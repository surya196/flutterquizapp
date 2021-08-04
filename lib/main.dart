import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/quizs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Quiz(),
      )),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<Widget> score = [];
  Quizs quizs = Quizs();
  void checkans(bool userpicked) {
    bool correctans = quizs.getanswer();

    setState(() {
      if (quizs.isfinsed() == true) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('finished'),
            duration: Duration(seconds: 2),
          ),
        );
        quizs.reset();
        score = [];
      } else {
        if (correctans == userpicked) {
          score.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          score.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizs.nextquestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  quizs.getquestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'true',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkans(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'false',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkans(false);
              },
            ),
          ),
        ),
        Row(
          children: score,
        )
      ],
    );
  }
}
