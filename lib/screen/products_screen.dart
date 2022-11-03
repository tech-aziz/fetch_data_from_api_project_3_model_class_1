import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/PostsModel.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<PostsModel> postList = [];
  String productApiLink = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostsModel>> getPostApi() async {
    final response = await http.get(Uri.parse(productApiLink));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (var i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading'));
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 10,
                          child: Center(
                            child: ListTile(
                              tileColor: Colors.white10,
                              leading: Text(postList[index].id.toString()),
                              title: Text(
                                postList[index].title.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(postList[index].body.toString()),
                              trailing: Text(postList[index].userId.toString()),
                            ),
                          ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
