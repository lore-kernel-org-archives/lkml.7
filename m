Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69A121743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 19:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="aduzLSkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfD3Twx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 15:52:53 -0400
Received: from mail-eopbgr60118.outbound.protection.outlook.com ([40.107.6.118]:47920
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfD3Twp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 15:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVCHVuSuR0rO1GkDmFLA8qjJiamLMTFUTWrGy20or20=;
 b=aduzLSkv3TMWm4RqkwiHIW8bETPd4cxR67uEvn09eFHEegUwL/Nn1/3zzF+aKjTESQMxGoBZFmJnSq7KhoDLpy1IkW+mZmWz4MtXrTTBK2CkyjH9dowD5Ql/77mFLMtqHyR0mGfeZd4DEbIATat2hgLG8kMFXrenn6H2hUSQ1/o=
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com (20.178.17.97) by
 AM0PR02MB4609.eurprd02.prod.outlook.com (20.178.17.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 19:52:41 +0000
Received: from AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::e80e:1cbb:5e37:b8c7]) by AM0PR02MB4563.eurprd02.prod.outlook.com
 ([fe80::e80e:1cbb:5e37:b8c7%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 19:52:41 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] mux: mmio: add generic regmap bitfield-based multiplexer
Thread-Topic: [PATCH 2/2] mux: mmio: add generic regmap bitfield-based
 multiplexer
Thread-Index: AQHU/45FnbJXIZlBdEqEUQLa8q8aWg==
Date:   Tue, 30 Apr 2019 19:52:41 +0000
Message-ID: <20190430195226.8965-3-peda@axentia.se>
References: <20190430195226.8965-1-peda@axentia.se>
In-Reply-To: <20190430195226.8965-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1P189CA0028.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::41)
 To AM0PR02MB4563.eurprd02.prod.outlook.com (2603:10a6:208:ec::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73688d8c-42a6-4e6e-040e-08d6cda567b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM0PR02MB4609;
x-ms-traffictypediagnostic: AM0PR02MB4609:
x-microsoft-antispam-prvs: <AM0PR02MB460994AABEFB71CFC0BF462ABC3A0@AM0PR02MB4609.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(25786009)(66946007)(73956011)(81166006)(81156014)(66446008)(64756008)(66556008)(66476007)(8676002)(4326008)(97736004)(2906002)(68736007)(53936002)(74482002)(6116002)(8936002)(6512007)(3846002)(36756003)(50226002)(6486002)(2501003)(6436002)(2351001)(5640700003)(26005)(316002)(186003)(7736002)(305945005)(52116002)(76176011)(99286004)(102836004)(5660300002)(386003)(6506007)(54906003)(508600001)(486006)(86362001)(11346002)(1076003)(256004)(6916009)(2616005)(476003)(66066001)(14454004)(71200400001)(71190400001)(446003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB4609;H:AM0PR02MB4563.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vFKmpoBHk8lCvBrKm+76pwShMe/59LKVt+j+MXwYMOxnVRg83xOhHmk6ikJTTKOB9ytRP9ersvlU+Rv+tQwUAkKk+96zUS57Lw6bXK1TW1iCuvrBCnIlANXCOTH4h0FIuNWmZ7NyTJ7qIQGDDTdQJvtnOgbePKhOkSXpQzwnTmXwyLD2C/DudQrN3iSzF/K9Nh/ZhtIz8Tr0A59ercKP5e8X7umuOD0goTWafK2nQnqHSuCz93pVasMAmNKy6Y35qQwY5AMOMAyM5DG1gpBZaAVXNsr92GWs9X1GA2eE0nyKCyb0v8Vg4mxC6/mZKy3YDIk9xb1PRqFUUnxVx2Nkb6O2Owj2rh+vzjvdQDhkH34F8cLFUdBMHgcHr539zPqvnGw/oNR8QVJL38/bMt66y//rhAE2qWdZNr3TAyCDJ18=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 73688d8c-42a6-4e6e-040e-08d6cda567b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 19:52:41.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPg0KDQpHZW5lcmljIHJl
Z2lzdGVyIGJpdGZpZWxkLWJhc2VkIG11bHRpcGxleGVyIHRoYXQgY29udHJvbHMgdGhlIG11bHRp
cGxleGVyDQpwcm9kdWNlciBkZWZpbmVkIHVuZGVyIGEgcGFyZW50IG5vZGUuDQpUaGUgZHJpdmVy
IGNvcnJlc3BvbmRpbmcgdG8gcGFyZW50IG5vZGUgcHJvdmlkZXMgcmVnaXN0ZXIgcmVhZC93cml0
ZQ0KY2FwYWJpbGl0aWVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWou
YmFuc2FsQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBQZXRlciBSb3NpbiA8cGVkYUBheGVudGlh
LnNlPg0KLS0tDQogZHJpdmVycy9tdXgvS2NvbmZpZyB8IDEyICsrKysrKy0tLS0tLQ0KIGRyaXZl
cnMvbXV4L21taW8uYyAgfCAgNiArKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL211eC9LY29uZmln
IGIvZHJpdmVycy9tdXgvS2NvbmZpZw0KaW5kZXggNzY1OWQ2YzVmNzE4Li5lNWM1NzFmZDIzMmMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL211eC9LY29uZmlnDQorKysgYi9kcml2ZXJzL211eC9LY29u
ZmlnDQpAQCAtNDYsMTQgKzQ2LDE0IEBAIGNvbmZpZyBNVVhfR1BJTw0KIAkgIGJlIGNhbGxlZCBt
dXgtZ3Bpby4NCiANCiBjb25maWcgTVVYX01NSU8NCi0JdHJpc3RhdGUgIk1NSU8gcmVnaXN0ZXIg
Yml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciINCi0JZGVwZW5kcyBvbiAoT0YgJiYgTUZE
X1NZU0NPTikgfHwgQ09NUElMRV9URVNUDQorCXRyaXN0YXRlICJNTUlPL1JlZ21hcCByZWdpc3Rl
ciBiaXRmaWVsZC1jb250cm9sbGVkIE11bHRpcGxleGVyIg0KKwlkZXBlbmRzIG9uIE9GIHx8IENP
TVBJTEVfVEVTVA0KIAloZWxwDQotCSAgTU1JTyByZWdpc3RlciBiaXRmaWVsZC1jb250cm9sbGVk
IE11bHRpcGxleGVyIGNvbnRyb2xsZXIuDQorCSAgTU1JTy9SZWdtYXAgcmVnaXN0ZXIgYml0Zmll
bGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciBjb250cm9sbGVyLg0KIA0KLQkgIFRoZSBkcml2ZXIg
YnVpbGRzIG11bHRpcGxleGVyIGNvbnRyb2xsZXJzIGZvciBiaXRmaWVsZHMgaW4gYSBzeXNjb24N
Ci0JICByZWdpc3Rlci4gRm9yIE4gYml0IHdpZGUgYml0ZmllbGRzLCB0aGVyZSB3aWxsIGJlIDJe
TiBwb3NzaWJsZQ0KLQkgIG11bHRpcGxleGVyIHN0YXRlcy4NCisJICBUaGUgZHJpdmVyIGJ1aWxk
cyBtdWx0aXBsZXhlciBjb250cm9sbGVycyBmb3IgYml0ZmllbGRzIGluIGVpdGhlcg0KKwkgIGEg
c3lzY29uIHJlZ2lzdGVyIG9yIGEgZHJpdmVyIHJlZ21hcCByZWdpc3Rlci4gRm9yIE4gYml0IHdp
ZGUNCisJICBiaXRmaWVsZHMsIHRoZXJlIHdpbGwgYmUgMl5OIHBvc3NpYmxlIG11bHRpcGxleGVy
IHN0YXRlcy4NCiANCiAJICBUbyBjb21waWxlIHRoZSBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29z
ZSBNIGhlcmU6IHRoZSBtb2R1bGUgd2lsbA0KIAkgIGJlIGNhbGxlZCBtdXgtbW1pby4NCmRpZmYg
LS1naXQgYS9kcml2ZXJzL211eC9tbWlvLmMgYi9kcml2ZXJzL211eC9tbWlvLmMNCmluZGV4IDkz
NWFjNDRhYTIwOS4uNDRhN2EwZTg4NWI4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdXgvbW1pby5j
DQorKysgYi9kcml2ZXJzL211eC9tbWlvLmMNCkBAIC0yOCw2ICsyOCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXV4X2NvbnRyb2xfb3BzIG11eF9tbWlvX29wcyA9IHsNCiANCiBzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdXhfbW1pb19kdF9pZHNbXSA9IHsNCiAJeyAuY29tcGF0
aWJsZSA9ICJtbWlvLW11eCIsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAicmVnLW11eCIsIH0sDQog
CXsgLyogc2VudGluZWwgKi8gfQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXV4X21t
aW9fZHRfaWRzKTsNCkBAIC00Myw3ICs0NCwxMCBAQCBzdGF0aWMgaW50IG11eF9tbWlvX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWludCByZXQ7DQogCWludCBpOw0KIA0K
LQlyZWdtYXAgPSBzeXNjb25fbm9kZV90b19yZWdtYXAobnAtPnBhcmVudCk7DQorCWlmIChvZl9k
ZXZpY2VfaXNfY29tcGF0aWJsZShucCwgIm1taW8tbXV4IikpDQorCQlyZWdtYXAgPSBzeXNjb25f
bm9kZV90b19yZWdtYXAobnAtPnBhcmVudCk7DQorCWVsc2UNCisJCXJlZ21hcCA9IGRldl9nZXRf
cmVnbWFwKGRldi0+cGFyZW50LCBOVUxMKSA/OiBFUlJfUFRSKC1FTk9ERVYpOw0KIAlpZiAoSVNf
RVJSKHJlZ21hcCkpIHsNCiAJCXJldCA9IFBUUl9FUlIocmVnbWFwKTsNCiAJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGdldCByZWdtYXA6ICVkXG4iLCByZXQpOw0KLS0gDQoyLjExLjANCg0K
