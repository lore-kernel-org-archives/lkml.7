Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE3C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF45B208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="KEmzQsl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437283AbfFLIxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:53:04 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com ([40.107.4.118]:14254
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437194AbfFLIxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVCHVuSuR0rO1GkDmFLA8qjJiamLMTFUTWrGy20or20=;
 b=KEmzQsl8XYlzRADTDyXwezbUTScdpFYn7wGMHI2mEnXfFq5aEWerNXpaSB0VFAHj4dSYuq3jStd7hnT5Kh1ceAV/oiIx0ymMgEPnmZXlu+xuEJybm7bBSyUdAXym7UJaETJSl6gQBYXtvXpVac7AwZakF4sJ5KB2c3zMEPGo/24=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3275.eurprd02.prod.outlook.com (52.134.66.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Wed, 12 Jun 2019 08:53:00 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::49ac:3a71:a3ec:d6bf%5]) with mapi id 15.20.1987.010; Wed, 12 Jun 2019
 08:53:00 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [RESEND PATCH 2/2] mux: mmio: add generic regmap bitfield-based
 multiplexer
Thread-Topic: [RESEND PATCH 2/2] mux: mmio: add generic regmap bitfield-based
 multiplexer
Thread-Index: AQHVIPw8gnjhBeeWzEqTJaCId5UDSQ==
Date:   Wed, 12 Jun 2019 08:53:00 +0000
Message-ID: <20190612085238.1763-3-peda@axentia.se>
References: <20190612085238.1763-1-peda@axentia.se>
In-Reply-To: <20190612085238.1763-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::30) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d55deb67-6cfa-4bef-e85f-08d6ef135f3f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB3PR0202MB3275;
x-ms-traffictypediagnostic: DB3PR0202MB3275:
x-microsoft-antispam-prvs: <DB3PR0202MB3275714FCA71B82F99B5BF11BCEC0@DB3PR0202MB3275.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39830400003)(396003)(346002)(136003)(189003)(199004)(25786009)(508600001)(8936002)(4326008)(66476007)(74482002)(256004)(64756008)(66446008)(66556008)(66946007)(50226002)(73956011)(486006)(2906002)(11346002)(446003)(14454004)(476003)(81166006)(86362001)(110136005)(186003)(71200400001)(2501003)(3846002)(66066001)(8676002)(76176011)(53936002)(6486002)(81156014)(2616005)(26005)(6512007)(6436002)(316002)(5660300002)(6116002)(99286004)(7736002)(36756003)(52116002)(68736007)(305945005)(1076003)(6506007)(54906003)(102836004)(71190400001)(386003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3275;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GlUP1jyixgLCN8roXL8HYArCXOh4fsv2BSOC3vK/5pAe1o9lzPXQqdq+bbGy9hqBQRfAURGZf0WQNIvPj04jiY/ZHOZHC1kR3rVixv/XGLel/BDA4dahgmAu5m6/0Wqy9YoQZaNs+36xNb0hn9dDv0YzwT/dGLXhvPb7RzMxtcnRxoMOx+Q60R537gbxh4jWHjIHIlRyzKf6C9I6e37+HSHGwn0+tReZduzClAONKAU07hUP0B6FxLrCodDYZL+QyFTmgQwFZ0KSXMM/VPcu/KyulktRh1XwU1zNUOjgsL9M7NvzBl+LH3TTEeLQQWqVuqNNTlj97irjVdXczX6OhpAzKbc8mCsK12Yq2Vz5lGc6j60JedrZvs3Lh3vk5MIwVfcTyMDRVgQaW3ZTADkCIdR0V2T4M/l+aeyhY7Utm98=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d55deb67-6cfa-4bef-e85f-08d6ef135f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 08:53:00.3203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3275
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
