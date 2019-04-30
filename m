Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0C21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kf9a1Q1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfD3A5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:57:30 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:6214
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728997AbfD3A53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUNyhrII1OT+eH8jknP9HHyxvJ9BILSAybBP29zZMTk=;
 b=Kf9a1Q1JnaYWh7w5lDYAbOr5kiBF7eavYd4jW5gIl5py01e/SgGlTyw+iKuGM1czYD0uykEKRWklgdrZPm5xocKLK6RZVcrjmObmv1nuRxDHVxRpgSHy93gvErcs+JOy6H5JEhDzEEt5WYNw1albgzIiIBBAbYoFzF9pypIbpbo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 00:57:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 00:57:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Topic: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Thread-Index: AQHU/u+rfzNhsf6HmUqZui5Dk6oOlQ==
Date:   Tue, 30 Apr 2019 00:57:22 +0000
Message-ID: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8978e38-a7ee-456c-e734-08d6cd06cd9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB3866C7584E18AED56D46FA66F53A0@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(2201001)(386003)(53936002)(316002)(6436002)(6486002)(68736007)(86362001)(6116002)(5660300002)(3846002)(102836004)(26005)(6506007)(186003)(110136005)(2501003)(36756003)(8936002)(6512007)(66066001)(66556008)(256004)(66446008)(99286004)(4326008)(2906002)(476003)(486006)(2616005)(305945005)(7736002)(8676002)(25786009)(73956011)(71200400001)(71190400001)(66946007)(50226002)(478600001)(97736004)(81156014)(66476007)(81166006)(52116002)(14454004)(64756008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MwMOdXuvCIsE6EUFLVg2mLoGEMfc2GCLIuiim/SzvoK2JAzH1sfMkkmddB0EgwFjjiGPKI4o23aKMm9et9S3C7yhQxjqC3GV0RrkbdzWOTAKHKNyyWtwv9ADqjhig2GmY0AiHi4s13SFzsE0hqi0gSlt1+1DljLa8awcUSYTTRScMPwgd8UrZTmciXZRtA0H8x8aLd7w4Ve52bbgOlpFFxD99HsAHNEMtk+hx+zpmXGp22/JOJldtTrvWSIFFQndR1BL/bY1g0uP036EpDgkpSnUHIHnkkHmhcD0sLxY6ltwq+o91LXpI7K0kRHe1hibPe2NhnclBRqvEWTD/oXsIw1IvJLoHrX3O84haIe1Xo3+75o0qk0hQCG9DRmYx4p5fQRcA2SlAp2LfMQydTd75JoeYzcniRBrwPu5TP9ZXAA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8978e38-a7ee-456c-e734-08d6cd06cd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 00:57:22.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHBsbHY0IHN1cHBvcnRzIGZyYWN0aW9uYWwtTiBmdW5jdGlvbiwgdGhlIGZvcm11bGEgaXM6
DQoNClBMTCBvdXRwdXQgZnJlcSA9IGlucHV0ICogKG11bHQgKyBudW0vZGVub20pLA0KDQpUaGlz
IHBhdGNoIGFkZHMgZnJhY3Rpb25hbC1OIGZ1bmN0aW9uIHN1cHBvcnQsIGluY2x1ZGluZw0KY2xv
Y2sgcm91bmQgcmF0ZSwgY2FsY3VsYXRlIHJhdGUgYW5kIHNldCByYXRlLCB3aXRoIHRoaXMNCnBh
dGNoLCB0aGUgY2xvY2sgcmF0ZSBvZiBBUExMIGluIGNsb2NrIHRyZWUgaXMgbW9yZSBhY2N1cmF0
ZQ0KdGhhbiBiZWZvcmU6DQoNCldpdGhvdXQgZnJhY3Rpb246DQphcGxsX3ByZV9zZWwgICAgICAg
ICAgICAgICAgICAgICAgMSAgICAgICAgMSAgICAgICAgMSAgICAyNDAwMDAwMCAgICAgICAgICAw
ICAgICAwICA1MDAwMA0KICAgYXBsbF9wcmVfZGl2ICAgICAgICAgICAgICAgICAgIDEgICAgICAg
IDEgICAgICAgIDIgICAgMjQwMDAwMDAgICAgICAgICAgMCAgICAgMCAgNTAwMDANCiAgICAgIGFw
bGwgICAgICAgICAgICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAyICAgNTI4MDAwMDAw
ICAgICAgICAgIDAgICAgIDAgIDUwMDAwDQogICAgICAgICBhcGxsX3BmZDMgICAgICAgICAgICAg
ICAgMCAgICAgICAgMCAgICAgICAgMCAgIDc5MjAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAw
MA0KICAgICAgICAgYXBsbF9wZmQyICAgICAgICAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAg
ICAzMzk0Mjg1NzEgICAgICAgICAgMCAgICAgMCAgNTAwMDANCiAgICAgICAgIGFwbGxfcGZkMSAg
ICAgICAgICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgMzUyMDAwMDAwICAgICAgICAgIDAg
ICAgIDAgIDUwMDAwDQogICAgICAgICAgICB1c2RoYzAgICAgICAgICAgICAgICAgMCAgICAgICAg
MCAgICAgICAgMCAgIDM1MjAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KICAgICAgICAg
YXBsbF9wZmQwICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDEgICAzNTIwMDAwMDAg
ICAgICAgICAgMCAgICAgMCAgNTAwMDANCg0KV2l0aCBmcmFjdGlvbjoNCmFwbGxfcHJlX3NlbCAg
ICAgICAgICAgICAgICAgICAgICAxICAgICAgICAxICAgICAgICAxICAgIDI0MDAwMDAwICAgICAg
ICAgIDAgICAgIDAgIDUwMDAwDQogICBhcGxsX3ByZV9kaXYgICAgICAgICAgICAgICAgICAgMSAg
ICAgICAgMSAgICAgICAgMiAgICAyNDAwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KICAg
ICAgYXBsbCAgICAgICAgICAgICAgICAgICAgICAgIDEgICAgICAgIDEgICAgICAgIDIgICA1Mjky
MDAwMDAgICAgICAgICAgMCAgICAgMCAgNTAwMDANCiAgICAgICAgIGFwbGxfcGZkMyAgICAgICAg
ICAgICAgICAwICAgICAgICAwICAgICAgICAwICAgNzkzODAwMDAwICAgICAgICAgIDAgICAgIDAg
IDUwMDAwDQogICAgICAgICBhcGxsX3BmZDIgICAgICAgICAgICAgICAgMCAgICAgICAgMCAgICAg
ICAgMCAgIDM0MDIwMDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KICAgICAgICAgYXBsbF9w
ZmQxICAgICAgICAgICAgICAgIDAgICAgICAgIDAgICAgICAgIDAgICAzNTI4MDAwMDAgICAgICAg
ICAgMCAgICAgMCAgNTAwMDANCiAgICAgICAgICAgIHVzZGhjMCAgICAgICAgICAgICAgICAwICAg
ICAgICAwICAgICAgICAwICAgMzUyODAwMDAwICAgICAgICAgIDAgICAgIDAgIDUwMDAwDQogICAg
ICAgICBhcGxsX3BmZDAgICAgICAgICAgICAgICAgMSAgICAgICAgMSAgICAgICAgMSAgIDM1Mjgw
MDAwMCAgICAgICAgICAwICAgICAwICA1MDAwMA0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2NC5jIHwgNzIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9pbXgvY2xrLXBsbHY0LmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHY0LmMN
CmluZGV4IGQzOGJjOWYuLmQ3ZTYyYzMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LXBsbHY0LmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGxsdjQuYw0KQEAgLTMwLDYgKzMw
LDkgQEANCiAvKiBQTEwgRGVub21pbmF0b3IgUmVnaXN0ZXIgKHhQTExERU5PTSkgKi8NCiAjZGVm
aW5lIFBMTF9ERU5PTV9PRkZTRVQJMHgxNA0KIA0KKyNkZWZpbmUgTUFYX01GRAkJCTB4M2ZmZmZm
ZmYNCisjZGVmaW5lIERFRkFVTFRfTUZECQkxMDAwMDAwDQorDQogc3RydWN0IGNsa19wbGx2NCB7
DQogCXN0cnVjdCBjbGtfaHcJaHc7DQogCXZvaWQgX19pb21lbQkqYmFzZTsNCkBAIC02NCwxMyAr
NjcsMjAgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3BsbHY0X3JlY2FsY19yYXRlKHN0cnVj
dCBjbGtfaHcgKmh3LA0KIAkJCQkJICAgdW5zaWduZWQgbG9uZyBwYXJlbnRfcmF0ZSkNCiB7DQog
CXN0cnVjdCBjbGtfcGxsdjQgKnBsbCA9IHRvX2Nsa19wbGx2NChodyk7DQotCXUzMiBkaXY7DQor
CXUzMiBtdWx0LCBtZm4sIG1mZDsNCisJdTY0IHRlbXA2NDsNCisNCisJbXVsdCA9IHJlYWRsX3Jl
bGF4ZWQocGxsLT5iYXNlICsgUExMX0NGR19PRkZTRVQpOw0KKwltdWx0ICY9IEJNX1BMTF9NVUxU
Ow0KKwltdWx0ID4+PSBCUF9QTExfTVVMVDsNCiANCi0JZGl2ID0gcmVhZGxfcmVsYXhlZChwbGwt
PmJhc2UgKyBQTExfQ0ZHX09GRlNFVCk7DQotCWRpdiAmPSBCTV9QTExfTVVMVDsNCi0JZGl2ID4+
PSBCUF9QTExfTVVMVDsNCisJbWZuID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBQTExfTlVN
X09GRlNFVCk7DQorCW1mZCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlICsgUExMX0RFTk9NX09G
RlNFVCk7DQorCXRlbXA2NCA9IHBhcmVudF9yYXRlOw0KKwl0ZW1wNjQgKj0gbWZuOw0KKwlkb19k
aXYodGVtcDY0LCBtZmQpOw0KIA0KLQlyZXR1cm4gcGFyZW50X3JhdGUgKiBkaXY7DQorCXJldHVy
biAocGFyZW50X3JhdGUgKiBtdWx0KSArICh1MzIpdGVtcDY0Ow0KIH0NCiANCiBzdGF0aWMgbG9u
ZyBjbGtfcGxsdjRfcm91bmRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyBy
YXRlLA0KQEAgLTc4LDE0ICs4OCw0NiBAQCBzdGF0aWMgbG9uZyBjbGtfcGxsdjRfcm91bmRfcmF0
ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLA0KIHsNCiAJdW5zaWduZWQg
bG9uZyBwYXJlbnRfcmF0ZSA9ICpwcmF0ZTsNCiAJdW5zaWduZWQgbG9uZyByb3VuZF9yYXRlLCBp
Ow0KKwl1MzIgbWZuLCBtZmQgPSBERUZBVUxUX01GRDsNCisJYm9vbCBmb3VuZCA9IGZhbHNlOw0K
Kwl1NjQgdGVtcDY0Ow0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShwbGx2NF9tdWx0
X3RhYmxlKTsgaSsrKSB7DQogCQlyb3VuZF9yYXRlID0gcGFyZW50X3JhdGUgKiBwbGx2NF9tdWx0
X3RhYmxlW2ldOw0KLQkJaWYgKHJhdGUgPj0gcm91bmRfcmF0ZSkNCi0JCQlyZXR1cm4gcm91bmRf
cmF0ZTsNCisJCWlmIChyYXRlID49IHJvdW5kX3JhdGUpIHsNCisJCQlmb3VuZCA9IHRydWU7DQor
CQkJYnJlYWs7DQorCQl9DQorCX0NCisNCisJaWYgKCFmb3VuZCkgew0KKwkJcHJfd2FybigiJXM6
IHVuYWJsZSB0byByb3VuZCByYXRlICVsdSwgcGFyZW50IHJhdGUgJWx1XG4iLA0KKwkJCWNsa19o
d19nZXRfbmFtZShodyksIHJhdGUsIHBhcmVudF9yYXRlKTsNCisJCXJldHVybiAwOw0KIAl9DQog
DQotCXJldHVybiByb3VuZF9yYXRlOw0KKwlpZiAocGFyZW50X3JhdGUgPD0gTUFYX01GRCkNCisJ
CW1mZCA9IHBhcmVudF9yYXRlOw0KKw0KKwl0ZW1wNjQgPSAodTY0KShyYXRlIC0gcm91bmRfcmF0
ZSk7DQorCXRlbXA2NCAqPSBtZmQ7DQorCWRvX2Rpdih0ZW1wNjQsIHBhcmVudF9yYXRlKTsNCisJ
bWZuID0gdGVtcDY0Ow0KKw0KKwkvKg0KKwkgKiBOT1RFOiBUaGUgdmFsdWUgb2YgbnVtZXJhdG9y
IG11c3QgYWx3YXlzIGJlIGNvbmZpZ3VyZWQgdG8gYmUNCisJICogbGVzcyB0aGFuIHRoZSB2YWx1
ZSBvZiB0aGUgZGVub21pbmF0b3IuIElmIHdlIGNhbid0IGdldCBhIHByb3Blcg0KKwkgKiBwYWly
IG9mIG1mbi9tZmQsIHdlIHNpbXBseSByZXR1cm4gdGhlIHJvdW5kX3JhdGUgd2l0aG91dCB1c2lu
Zw0KKwkgKiB0aGUgZnJhYyBwYXJ0Lg0KKwkgKi8NCisJaWYgKG1mbiA+PSBtZmQpDQorCQlyZXR1
cm4gcm91bmRfcmF0ZTsNCisNCisJdGVtcDY0ID0gKHU2NClwYXJlbnRfcmF0ZTsNCisJdGVtcDY0
ICo9IG1mbjsNCisJZG9fZGl2KHRlbXA2NCwgbWZkKTsNCisNCisJcmV0dXJuIHJvdW5kX3JhdGUg
KyAodTMyKXRlbXA2NDsNCiB9DQogDQogc3RhdGljIGJvb2wgY2xrX3BsbHY0X2lzX3ZhbGlkX211
bHQodW5zaWduZWQgaW50IG11bHQpDQpAQCAtMTA1LDE4ICsxNDcsMzAgQEAgc3RhdGljIGludCBj
bGtfcGxsdjRfc2V0X3JhdGUoc3RydWN0IGNsa19odyAqaHcsIHVuc2lnbmVkIGxvbmcgcmF0ZSwN
CiAJCQkgICAgICB1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlKQ0KIHsNCiAJc3RydWN0IGNsa19w
bGx2NCAqcGxsID0gdG9fY2xrX3BsbHY0KGh3KTsNCi0JdTMyIHZhbCwgbXVsdDsNCisJdTMyIHZh
bCwgbXVsdCwgbWZuLCBtZmQgPSBERUZBVUxUX01GRDsNCisJdTY0IHRlbXA2NDsNCiANCiAJbXVs
dCA9IHJhdGUgLyBwYXJlbnRfcmF0ZTsNCiANCiAJaWYgKCFjbGtfcGxsdjRfaXNfdmFsaWRfbXVs
dChtdWx0KSkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KKwlpZiAocGFyZW50X3JhdGUgPD0gTUFY
X01GRCkNCisJCW1mZCA9IHBhcmVudF9yYXRlOw0KKw0KKwl0ZW1wNjQgPSAodTY0KShyYXRlIC0g
bXVsdCAqIHBhcmVudF9yYXRlKTsNCisJdGVtcDY0ICo9IG1mZDsNCisJZG9fZGl2KHRlbXA2NCwg
cGFyZW50X3JhdGUpOw0KKwltZm4gPSB0ZW1wNjQ7DQorDQogCXZhbCA9IHJlYWRsX3JlbGF4ZWQo
cGxsLT5iYXNlICsgUExMX0NGR19PRkZTRVQpOw0KIAl2YWwgJj0gfkJNX1BMTF9NVUxUOw0KIAl2
YWwgfD0gbXVsdCA8PCBCUF9QTExfTVVMVDsNCiAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwbGwtPmJh
c2UgKyBQTExfQ0ZHX09GRlNFVCk7DQogDQorCXdyaXRlbF9yZWxheGVkKG1mbiwgcGxsLT5iYXNl
ICsgUExMX05VTV9PRkZTRVQpOw0KKwl3cml0ZWxfcmVsYXhlZChtZmQsIHBsbC0+YmFzZSArIFBM
TF9ERU5PTV9PRkZTRVQpOw0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQotLSANCjIuNy40DQoNCg==
