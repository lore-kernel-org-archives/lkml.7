Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9EAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79E2214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="h31p/6iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392689AbfETQjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:39:44 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:28806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392586AbfETQjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icpRyS73cIcQKDqGrCfshKA+Dl1mr/H8Tjfi0jTGOyY=;
 b=h31p/6iLLMb3cYHdR+rF6JmDmYr/dgkBivGgMs6LYqDgTmRMe61B/L4YOmjWR9KCHyiIzBJY/YhKt15QE6RE3N5wsw1aAdTdk5zav1ZVSEttnbfVmxHOvaJMOblyZEzyUcuyz3FG8HIv6VTWnIjFu5A+U1DFPlGYOWYJ21i40tE=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 16:39:03 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 16:39:03 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] staging: vt6656: clean error path for firmware management
Thread-Topic: [PATCH 4/7] staging: vt6656: clean error path for firmware
 management
Thread-Index: AQHVDyqIEKpGQa86PkmrlJfCOD3n5Q==
Date:   Mon, 20 May 2019 16:39:03 +0000
Message-ID: <20190520163844.1225-5-quentin.deslandes@itdev.co.uk>
References: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
In-Reply-To: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR08CA0002.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::14) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb1b574a-911f-4de9-eff4-08d6dd41ab08
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3662;
x-ms-traffictypediagnostic: VI1PR08MB3662:
x-microsoft-antispam-prvs: <VI1PR08MB366298ABA8F784A25F11DADAB3060@VI1PR08MB3662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(1730700003)(2501003)(14454004)(73956011)(486006)(8936002)(44832011)(71190400001)(71200400001)(50226002)(81156014)(81166006)(4326008)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(53936002)(446003)(316002)(11346002)(476003)(2616005)(305945005)(6436002)(66066001)(508600001)(6486002)(7736002)(5640700003)(68736007)(25786009)(186003)(6512007)(14444005)(86362001)(256004)(6116002)(3846002)(1076003)(5660300002)(26005)(36756003)(76176011)(99286004)(6916009)(6506007)(386003)(52116002)(102836004)(2351001)(54906003)(74482002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3662;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G64e19tEHUOzgv45dqcNSKfwMEiecbYl2VJLRTWTZadV3ztu4/VVJ1bF1G05jCINBdxRU0Ui9acD98MHDVU3WXPPoQz/7I2Q8IsKMmzzQ3m78xOVTS/HeiNsHFS1N1oFyq0hKbxkok2ZJCrXZ7q5cl40jeTeOKmNrZPO8LTBz4Fz8Dr8WiMckbTlKxTS3i4Dsenoe326s61E9axx4lsviTyDqGDuhCVpXvYSR3vAbCOOM+YKBP6cStPH0G9GhWGH7f82PrIUnD9sWJcBTsCgcqUbMHM4zL0XrM7lx/cGsH8L+DrkpUUUol1hx6pwGNU4383bfgJ1t/8ePIAWlD8HX3bLqc4xyk9cJsmubkccM2WL1LFNQF/CwteGwIDGM+8apy1JDpZUFsdotK/Pxg1DK9cL78UykkrJ0TTm15MTN+c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1b574a-911f-4de9-eff4-08d6dd41ab08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 16:39:03.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXZvaWQgZGlzY2FyZGluZyByZXR1cm4gdmFsdWUgb2YgZnVuY3Rpb25zIGNhbGxlZCBkdXJpbmcg
ZmlybXdhcmUNCm1hbmFnZW1lbnQgcHJvY2Vzcy4gSGFuZGxlIHN1Y2ggcmV0dXJuIHZhbHVlIGFu
ZCByZXR1cm4gMCBvbiBzdWNjZXNzIG9yDQphIG5lZ2F0aXZlIGVycm5vIHZhbHVlIG9uIGVycm9y
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBRdWVudGluIERlc2xhbmRlcyA8cXVlbnRpbi5kZXNsYW5kZXNA
aXRkZXYuY28udWs+DQotLS0NCiBkcml2ZXJzL3N0YWdpbmcvdnQ2NjU2L2Zpcm13YXJlLmMgfCA5
MSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQwIGlu
c2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFn
aW5nL3Z0NjY1Ni9maXJtd2FyZS5jIGIvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9maXJtd2FyZS5j
DQppbmRleCAzODUyMWMzMzg5MTcuLjYwYTAwYWYyNTBiZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
c3RhZ2luZy92dDY2NTYvZmlybXdhcmUuYw0KKysrIGIvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9m
aXJtd2FyZS5jDQpAQCAtMzAsOTggKzMwLDg3IEBAIGludCB2bnRfZG93bmxvYWRfZmlybXdhcmUo
c3RydWN0IHZudF9wcml2YXRlICpwcml2KQ0KIHsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBy
aXYtPnVzYi0+ZGV2Ow0KIAljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KLQlpbnQgc3RhdHVz
Ow0KIAl2b2lkICpidWZmZXIgPSBOVUxMOw0KLQlib29sIHJlc3VsdCA9IGZhbHNlOw0KIAl1MTYg
bGVuZ3RoOw0KLQlpbnQgaWksIHJjOw0KKwlpbnQgaWk7DQorCWludCByZXQgPSAwOw0KIA0KIAlk
ZXZfZGJnKGRldiwgIi0tLS0+RG93bmxvYWQgZmlybXdhcmVcbiIpOw0KIA0KLQlyYyA9IHJlcXVl
c3RfZmlybXdhcmUoJmZ3LCBGSVJNV0FSRV9OQU1FLCBkZXYpOw0KLQlpZiAocmMpIHsNCisJcmV0
ID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIEZJUk1XQVJFX05BTUUsIGRldik7DQorCWlmIChyZXQp
IHsNCiAJCWRldl9lcnIoZGV2LCAiZmlybXdhcmUgZmlsZSAlcyByZXF1ZXN0IGZhaWxlZCAoJWQp
XG4iLA0KLQkJCUZJUk1XQVJFX05BTUUsIHJjKTsNCi0JCQlnb3RvIG91dDsNCisJCQlGSVJNV0FS
RV9OQU1FLCByZXQpOw0KKwkJZ290byBlbmQ7DQogCX0NCiANCiAJYnVmZmVyID0ga21hbGxvYyhG
SVJNV0FSRV9DSFVOS19TSVpFLCBHRlBfS0VSTkVMKTsNCi0JaWYgKCFidWZmZXIpDQorCWlmICgh
YnVmZmVyKSB7DQorCQlyZXQgPSAtRU5PTUVNOw0KIAkJZ290byBmcmVlX2Z3Ow0KKwl9DQogDQog
CWZvciAoaWkgPSAwOyBpaSA8IGZ3LT5zaXplOyBpaSArPSBGSVJNV0FSRV9DSFVOS19TSVpFKSB7
DQogCQlsZW5ndGggPSBtaW5fdChpbnQsIGZ3LT5zaXplIC0gaWksIEZJUk1XQVJFX0NIVU5LX1NJ
WkUpOw0KIAkJbWVtY3B5KGJ1ZmZlciwgZnctPmRhdGEgKyBpaSwgbGVuZ3RoKTsNCiANCi0JCXN0
YXR1cyA9IHZudF9jb250cm9sX291dChwcml2LA0KLQkJCQkJIDAsDQotCQkJCQkgMHgxMjAwICsg
aWksDQotCQkJCQkgMHgwMDAwLA0KLQkJCQkJIGxlbmd0aCwNCi0JCQkJCSBidWZmZXIpOw0KKwkJ
cmV0ID0gdm50X2NvbnRyb2xfb3V0KHByaXYsIDAsIDB4MTIwMCArIGlpLCAweDAwMDAsIGxlbmd0
aCwNCisJCQkJICAgICAgYnVmZmVyKTsNCisJCWlmIChyZXQpDQorCQkJZ290byBmcmVlX2J1ZmZl
cjsNCiANCiAJCWRldl9kYmcoZGV2LCAiRG93bmxvYWQgZmlybXdhcmUuLi4lZCAlenVcbiIsIGlp
LCBmdy0+c2l6ZSk7DQotDQotCQlpZiAoc3RhdHVzICE9IFNUQVRVU19TVUNDRVNTKQ0KLQkJCWdv
dG8gZnJlZV9mdzsNCiAJfQ0KIA0KLQlyZXN1bHQgPSB0cnVlOw0KK2ZyZWVfYnVmZmVyOg0KKwlr
ZnJlZShidWZmZXIpOw0KIGZyZWVfZnc6DQogCXJlbGVhc2VfZmlybXdhcmUoZncpOw0KLQ0KLW91
dDoNCi0Ja2ZyZWUoYnVmZmVyKTsNCi0NCi0JcmV0dXJuIHJlc3VsdDsNCitlbmQ6DQorCXJldHVy
biByZXQ7DQogfQ0KIE1PRFVMRV9GSVJNV0FSRShGSVJNV0FSRV9OQU1FKTsNCiANCiBpbnQgdm50
X2Zpcm13YXJlX2JyYW5jaF90b19zcmFtKHN0cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdikNCiB7DQot
CWludCBzdGF0dXM7DQotDQogCWRldl9kYmcoJnByaXYtPnVzYi0+ZGV2LCAiLS0tLT5CcmFuY2gg
dG8gU3JhbVxuIik7DQogDQotCXN0YXR1cyA9IHZudF9jb250cm9sX291dChwcml2LA0KLQkJCQkg
MSwNCi0JCQkJIDB4MTIwMCwNCi0JCQkJIDB4MDAwMCwNCi0JCQkJIDAsDQotCQkJCSBOVUxMKTsN
Ci0JcmV0dXJuIHN0YXR1cyA9PSBTVEFUVVNfU1VDQ0VTUzsNCisJcmV0dXJuIHZudF9jb250cm9s
X291dChwcml2LCAxLCAweDEyMDAsIDB4MDAwMCwgMCwgTlVMTCk7DQogfQ0KIA0KIGludCB2bnRf
Y2hlY2tfZmlybXdhcmVfdmVyc2lvbihzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYpDQogew0KLQlp
bnQgc3RhdHVzOw0KLQ0KLQlzdGF0dXMgPSB2bnRfY29udHJvbF9pbihwcml2LA0KLQkJCQlNRVNT
QUdFX1RZUEVfUkVBRCwNCi0JCQkJMCwNCi0JCQkJTUVTU0FHRV9SRVFVRVNUX1ZFUlNJT04sDQot
CQkJCTIsDQotCQkJCSh1OCAqKSZwcml2LT5maXJtd2FyZV92ZXJzaW9uKTsNCisJaW50IHJldCA9
IDA7DQorDQorCXJldCA9IHZudF9jb250cm9sX2luKHByaXYsIE1FU1NBR0VfVFlQRV9SRUFELCAw
LA0KKwkJCSAgICAgTUVTU0FHRV9SRVFVRVNUX1ZFUlNJT04sIDIsDQorCQkJICAgICAodTggKikm
cHJpdi0+ZmlybXdhcmVfdmVyc2lvbik7DQorCWlmIChyZXQpIHsNCisJCWRldl9kYmcoJnByaXYt
PnVzYi0+ZGV2LA0KKwkJCSJDb3VsZCBub3QgZ2V0IGZpcm13YXJlIHZlcnNpb246ICVkLlxuIiwg
cmV0KTsNCisJCWdvdG8gZW5kOw0KKwl9DQogDQogCWRldl9kYmcoJnByaXYtPnVzYi0+ZGV2LCAi
RmlybXdhcmUgVmVyc2lvbiBbJTA0eF1cbiIsDQogCQlwcml2LT5maXJtd2FyZV92ZXJzaW9uKTsN
CiANCi0JaWYgKHN0YXR1cyAhPSBTVEFUVVNfU1VDQ0VTUykgew0KLQkJZGV2X2RiZygmcHJpdi0+
dXNiLT5kZXYsICJGaXJtd2FyZSBJbnZhbGlkLlxuIik7DQotCQlyZXR1cm4gZmFsc2U7DQotCX0N
CiAJaWYgKHByaXYtPmZpcm13YXJlX3ZlcnNpb24gPT0gMHhGRkZGKSB7DQogCQlkZXZfZGJnKCZw
cml2LT51c2ItPmRldiwgIkluIExvYWRlci5cbiIpOw0KLQkJcmV0dXJuIGZhbHNlOw0KKwkJcmV0
ID0gLUVJTlZBTDsNCisJCWdvdG8gZW5kOw0KIAl9DQogDQotCWRldl9kYmcoJnByaXYtPnVzYi0+
ZGV2LCAiRmlybXdhcmUgVmVyc2lvbiBbJTA0eF1cbiIsDQotCQlwcml2LT5maXJtd2FyZV92ZXJz
aW9uKTsNCi0NCiAJaWYgKHByaXYtPmZpcm13YXJlX3ZlcnNpb24gPCBGSVJNV0FSRV9WRVJTSU9O
KSB7DQogCQkvKiBicmFuY2ggdG8gbG9hZGVyIGZvciBkb3dubG9hZCBuZXcgZmlybXdhcmUgKi8N
Ci0JCXZudF9maXJtd2FyZV9icmFuY2hfdG9fc3JhbShwcml2KTsNCi0JCXJldHVybiBmYWxzZTsN
CisJCXJldCA9IHZudF9maXJtd2FyZV9icmFuY2hfdG9fc3JhbShwcml2KTsNCisJCWlmIChyZXQp
IHsNCisJCQlkZXZfZGJnKCZwcml2LT51c2ItPmRldiwNCisJCQkJIkNvdWxkIG5vdCBicmFuY2gg
dG8gU1JBTTogJWQuXG4iLCByZXQpOw0KKwkJfSBlbHNlIHsNCisJCQlyZXQgPSAtRUlOVkFMOw0K
KwkJfQ0KIAl9DQotCXJldHVybiB0cnVlOw0KKw0KK2VuZDoNCisJcmV0dXJuIHJldDsNCiB9DQot
LSANCjIuMTcuMQ0KDQo=
