//
//  ViewController.swift
//  iOSJSON3.0
//
//  Created by Chotipat on 9/23/2559 BE.
//  Copyright © 2559 Chotipat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UITableViewController {
    var name = [String]()
    var callURL = "https://api.spotify.com/v1/search?q=Shawn+Mendes&type=track"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callJSON(URL: callURL)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callJSON(URL:String){
        Alamofire.request(URL).validate().responseJSON {
            respond in
            switch respond.result{
            case .success:
            if let value = respond.result.value{
               let json = JSON(value)
               let music = json["tracks"]["items"]
               // print(name)
                for item in music.arrayValue{
                    let items = item["name"].stringValue
                    self.name.append(items)
                    self.tableView.reloadData()
                }
               
            }
                
            case .failure(let error):
                    print(error)
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = name[indexPath.row]
        return cell!
    }

}

