//
//  MyTableViewController.swift
//  tableViewTask
//
//  Created by swamnx on 23.06.21.
//

import Foundation
import UIKit

class MyTableViewController: UITableViewController {
    
    var familyNames = ["Vlad", "Kirill", "Anton", "Sasha"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
}

//
// MARK: Table View Default Moving Actions
//
extension MyTableViewController {
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let place = familyNames[sourceIndexPath.row]
        familyNames.remove(at: sourceIndexPath.row)
        familyNames.insert(place, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
//
// MARK: Table View Cell Default Swipe Actions
//
extension MyTableViewController {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            familyNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
//
// MARK: Bar Actions
//
extension MyTableViewController {
    
    @IBAction func plusTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Family Name", message: nil, preferredStyle: .alert)

        alertController.addTextField { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Family Name"
        }

        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { [unowned self] _ -> Void in
            let textField = alertController.textFields![0] as UITextField
            guard let writtenText = textField.text else { return }
            self.familyNames.append(writtenText)
            self.tableView.reloadData()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        if sender.title! == "Start Edit" {
            sender.title = "Stop Edit"
        } else {
            sender.title = "Start Edit"
        }
        self.tableView.isEditing = !self.tableView.isEditing
    }

}

//
// MARK: Table view data source
//
extension MyTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyNameID", for: indexPath)
        cell.textLabel?.text = familyNames[indexPath.row]
        return cell
    }

}
