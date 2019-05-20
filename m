Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A8F21721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="ksysDfKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392657AbfETQj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:39:28 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:28806
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392636AbfETQjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22+t++npVmU9XAwfW/7uEQx2GWAPj6K1rITvV+4o4iM=;
 b=ksysDfKnj4b+rmRoqlLW5rhOToy6PA0JcWYOKjKF72iGeQTMyz8/tS28BdfgrUDCUH4nQRh6APG6Z3GF/3o0BYQK4A4+wvt/LpYVT83xB5qNlqVDKH+K767OnnrzAIAVOEWipZWe5uhjJIUIJstjvk/hjffJsyl8Uo+rS+s+1pw=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Mon, 20 May 2019 16:39:04 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::1d25:dae7:53a6:b461%3]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 16:39:04 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] staging: vt6656: use meaningful error code during buffer
 allocation
Thread-Topic: [PATCH 5/7] staging: vt6656: use meaningful error code during
 buffer allocation
Thread-Index: AQHVDyqJYpIMwruyFkC+v/QIyP9FLA==
Date:   Mon, 20 May 2019 16:39:04 +0000
Message-ID: <20190520163844.1225-6-quentin.deslandes@itdev.co.uk>
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
x-ms-office365-filtering-correlation-id: c978152b-d0fb-4f18-8d57-08d6dd41ab71
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3662;
x-ms-traffictypediagnostic: VI1PR08MB3662:
x-microsoft-antispam-prvs: <VI1PR08MB36629485364A4E7EF09ADB96B3060@VI1PR08MB3662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(1730700003)(2501003)(14454004)(73956011)(486006)(8936002)(44832011)(71190400001)(71200400001)(50226002)(81156014)(81166006)(4326008)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(53936002)(446003)(316002)(11346002)(476003)(2616005)(305945005)(6436002)(66066001)(508600001)(6486002)(7736002)(5640700003)(68736007)(25786009)(186003)(6512007)(86362001)(256004)(6116002)(3846002)(1076003)(5660300002)(26005)(36756003)(76176011)(99286004)(6916009)(6506007)(386003)(52116002)(102836004)(2351001)(54906003)(74482002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3662;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /+0zlcN5xF7ODRNZDHuqZpuafZKq0k8M3M5sai8Fx8Lutm1HYcKknanaAe3WRcrDusNrBeK2piIP1tEZHeoBOlapgyaYslONmzCVhyR6WFAzxN7oAIWvbrqohs2krf2IFg7zlx6LUuJZVtVYGohrQePuZ4Rj/Uq6ADrF2NfXFBFXKXJyUhkli3RF5aMXI8Z06t9/vUOmdNwkVQIC/ls5SuomDWo5c6bZ9nWeW2VXpOJwEAKdalA59nHf3ckvujg33F4xtK1qcQXsZ5G/Potrulfe92g79jMBWjf6DlkV1xZCU3eM0qhwKExyp3mrzOFdTTMvtbEeIQiDuhhFCCAJJO05Mnn4iYNZJTjqq5MLROs86k09BvwmemaRI0NEiIokgUBGdqV9TDDWiL8B8gLF4Taogm3oXmQPu4JJ8jp2/ro=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: c978152b-d0fb-4f18-8d57-08d6dd41ab71
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 16:39:04.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hlY2sgb24gY2FsbGVkIGZ1bmN0aW9uJ3MgcmV0dXJuZWQgdmFsdWUgZm9yIGVycm9yIGFuZCBy
ZXR1cm4gMCBvbg0Kc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm5vIHZhbHVlIG9uIGVycm9yIGlu
c3RlYWQgb2YgYSBib29sZWFuIHZhbHVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBRdWVudGluIERlc2xh
bmRlcyA8cXVlbnRpbi5kZXNsYW5kZXNAaXRkZXYuY28udWs+DQotLS0NCiBkcml2ZXJzL3N0YWdp
bmcvdnQ2NjU2L21haW5fdXNiLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWluX3VzYi5jIGIvZHJpdmVycy9z
dGFnaW5nL3Z0NjY1Ni9tYWluX3VzYi5jDQppbmRleCBiZmU5NTJmZTI3YmYuLjVmZDg0NWNiZGQ1
MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3RhZ2luZy92dDY2NTYvbWFpbl91c2IuYw0KKysrIGIv
ZHJpdmVycy9zdGFnaW5nL3Z0NjY1Ni9tYWluX3VzYi5jDQpAQCAtNDA1LDE2ICs0MDUsMTkgQEAg
c3RhdGljIHZvaWQgdm50X2ZyZWVfaW50X2J1ZnMoc3RydWN0IHZudF9wcml2YXRlICpwcml2KQ0K
IAlrZnJlZShwcml2LT5pbnRfYnVmLmRhdGFfYnVmKTsNCiB9DQogDQotc3RhdGljIGJvb2wgdm50
X2FsbG9jX2J1ZnMoc3RydWN0IHZudF9wcml2YXRlICpwcml2KQ0KK3N0YXRpYyBpbnQgdm50X2Fs
bG9jX2J1ZnMoc3RydWN0IHZudF9wcml2YXRlICpwcml2KQ0KIHsNCisJaW50IHJldCA9IDA7DQog
CXN0cnVjdCB2bnRfdXNiX3NlbmRfY29udGV4dCAqdHhfY29udGV4dDsNCiAJc3RydWN0IHZudF9y
Y2IgKnJjYjsNCiAJaW50IGlpOw0KIA0KIAlmb3IgKGlpID0gMDsgaWkgPCBwcml2LT5udW1fdHhf
Y29udGV4dDsgaWkrKykgew0KIAkJdHhfY29udGV4dCA9IGttYWxsb2Moc2l6ZW9mKCp0eF9jb250
ZXh0KSwgR0ZQX0tFUk5FTCk7DQotCQlpZiAoIXR4X2NvbnRleHQpDQorCQlpZiAoIXR4X2NvbnRl
eHQpIHsNCisJCQlyZXQgPSAtRU5PTUVNOw0KIAkJCWdvdG8gZnJlZV90eDsNCisJCX0NCiANCiAJ
CXByaXYtPnR4X2NvbnRleHRbaWldID0gdHhfY29udGV4dDsNCiAJCXR4X2NvbnRleHQtPnByaXYg
PSBwcml2Ow0KQEAgLTQyMiwxNiArNDI1LDIwIEBAIHN0YXRpYyBib29sIHZudF9hbGxvY19idWZz
KHN0cnVjdCB2bnRfcHJpdmF0ZSAqcHJpdikNCiANCiAJCS8qIGFsbG9jYXRlIFVSQnMgKi8NCiAJ
CXR4X2NvbnRleHQtPnVyYiA9IHVzYl9hbGxvY191cmIoMCwgR0ZQX0tFUk5FTCk7DQotCQlpZiAo
IXR4X2NvbnRleHQtPnVyYikNCisJCWlmICghdHhfY29udGV4dC0+dXJiKSB7DQorCQkJcmV0ID0g
LUVOT01FTTsNCiAJCQlnb3RvIGZyZWVfdHg7DQorCQl9DQogDQogCQl0eF9jb250ZXh0LT5pbl91
c2UgPSBmYWxzZTsNCiAJfQ0KIA0KIAlmb3IgKGlpID0gMDsgaWkgPCBwcml2LT5udW1fcmNiOyBp
aSsrKSB7DQogCQlwcml2LT5yY2JbaWldID0ga3phbGxvYyhzaXplb2YoKnByaXYtPnJjYltpaV0p
LCBHRlBfS0VSTkVMKTsNCi0JCWlmICghcHJpdi0+cmNiW2lpXSkNCisJCWlmICghcHJpdi0+cmNi
W2lpXSkgew0KKwkJCXJldCA9IC1FTk9NRU07DQogCQkJZ290byBmcmVlX3J4X3R4Ow0KKwkJfQ0K
IA0KIAkJcmNiID0gcHJpdi0+cmNiW2lpXTsNCiANCkBAIC00MzksMzkgKzQ0Niw0NiBAQCBzdGF0
aWMgYm9vbCB2bnRfYWxsb2NfYnVmcyhzdHJ1Y3Qgdm50X3ByaXZhdGUgKnByaXYpDQogDQogCQkv
KiBhbGxvY2F0ZSBVUkJzICovDQogCQlyY2ItPnVyYiA9IHVzYl9hbGxvY191cmIoMCwgR0ZQX0tF
Uk5FTCk7DQotCQlpZiAoIXJjYi0+dXJiKQ0KKwkJaWYgKCFyY2ItPnVyYikgew0KKwkJCXJldCA9
IC1FTk9NRU07DQogCQkJZ290byBmcmVlX3J4X3R4Ow0KKwkJfQ0KIA0KIAkJcmNiLT5za2IgPSBk
ZXZfYWxsb2Nfc2tiKHByaXYtPnJ4X2J1Zl9zeik7DQotCQlpZiAoIXJjYi0+c2tiKQ0KKwkJaWYg
KCFyY2ItPnNrYikgew0KKwkJCXJldCA9IC1FTk9NRU07DQogCQkJZ290byBmcmVlX3J4X3R4Ow0K
KwkJfQ0KIA0KIAkJcmNiLT5pbl91c2UgPSBmYWxzZTsNCiANCiAJCS8qIHN1Ym1pdCByeCB1cmIg
Ki8NCi0JCWlmICh2bnRfc3VibWl0X3J4X3VyYihwcml2LCByY2IpKQ0KKwkJcmV0ID0gdm50X3N1
Ym1pdF9yeF91cmIocHJpdiwgcmNiKTsNCisJCWlmIChyZXQpDQogCQkJZ290byBmcmVlX3J4X3R4
Ow0KIAl9DQogDQogCXByaXYtPmludGVycnVwdF91cmIgPSB1c2JfYWxsb2NfdXJiKDAsIEdGUF9L
RVJORUwpOw0KLQlpZiAoIXByaXYtPmludGVycnVwdF91cmIpDQorCWlmICghcHJpdi0+aW50ZXJy
dXB0X3VyYikgew0KKwkJcmV0ID0gLUVOT01FTTsNCiAJCWdvdG8gZnJlZV9yeF90eDsNCisJfQ0K
IA0KIAlwcml2LT5pbnRfYnVmLmRhdGFfYnVmID0ga21hbGxvYyhNQVhfSU5URVJSVVBUX1NJWkUs
IEdGUF9LRVJORUwpOw0KIAlpZiAoIXByaXYtPmludF9idWYuZGF0YV9idWYpIHsNCi0JCXVzYl9m
cmVlX3VyYihwcml2LT5pbnRlcnJ1cHRfdXJiKTsNCi0JCWdvdG8gZnJlZV9yeF90eDsNCisJCXJl
dCA9IC1FTk9NRU07DQorCQlnb3RvIGZyZWVfcnhfdHhfdXJiOw0KIAl9DQogDQotCXJldHVybiB0
cnVlOw0KKwlyZXR1cm4gMDsNCiANCitmcmVlX3J4X3R4X3VyYjoNCisJdXNiX2ZyZWVfdXJiKHBy
aXYtPmludGVycnVwdF91cmIpOw0KIGZyZWVfcnhfdHg6DQogCXZudF9mcmVlX3J4X2J1ZnMocHJp
dik7DQotDQogZnJlZV90eDoNCiAJdm50X2ZyZWVfdHhfYnVmcyhwcml2KTsNCi0NCi0JcmV0dXJu
IGZhbHNlOw0KKwlyZXR1cm4gcmV0Ow0KIH0NCiANCiBzdGF0aWMgdm9pZCB2bnRfdHhfODAyMTEo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQotLSANCjIuMTcuMQ0KDQo=
