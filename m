Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0339C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998E5206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qpW1JBl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfD2DSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:18:51 -0400
Received: from mail-eopbgr150089.outbound.protection.outlook.com ([40.107.15.89]:64738
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfD2DSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iMLlDfwX5SjLqPHsRwarG/5BUrKn0CHzbRXGTwW7xw=;
 b=qpW1JBl2GFTdY7PvHQ2t+X7EaeCh5JeW/QmA6nul8y8isigYk7P1oYe9VZ0AEMgfdN64NImZvHHeLpenY5vMnldq4ipbflf/5Ir5oDyDot19/gUQjdFrOwMYW6NlGv33+iUr1j2SpWcgTqTpSTukXBM+fCE+fStqHZFjCTCxqH0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 03:18:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 03:18:43 +0000
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
Subject: [PATCH] clk: imx: add fractional-N pll support to pllv4
Thread-Topic: [PATCH] clk: imx: add fractional-N pll support to pllv4
Thread-Index: AQHU/jo/D2ZwDi5WREOeVbOKgmEXYQ==
Date:   Mon, 29 Apr 2019 03:18:43 +0000
Message-ID: <1556507637-22847-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1621dcd0-9aa4-4613-ac6c-08d6cc5161f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB3724A98114832849F315C314F5390@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(53936002)(25786009)(186003)(97736004)(8936002)(478600001)(110136005)(305945005)(7736002)(4326008)(26005)(73956011)(66946007)(3846002)(6116002)(66556008)(476003)(64756008)(66476007)(2616005)(2906002)(2201001)(486006)(66446008)(6506007)(102836004)(66066001)(386003)(6512007)(52116002)(6436002)(5660300002)(68736007)(86362001)(71200400001)(6486002)(71190400001)(36756003)(81156014)(8676002)(316002)(14454004)(2501003)(256004)(81166006)(99286004)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YDnUAWd0UZ2nqTuFYIMpg4zROUGw4Zo7/K/+YZI4ZNDnYAoob7OY6LYAurgSltu/69oSUCDD4BH4I4Xcz1QmsGsxJPVTjyZygDO7in5EBVvSt4bZyVS+Us0pSil3JZu7i8Zl86ow23/vqCwf9sq2leWix/WFvQaFHn8HteMR4DU3Lddl1VB/sYDc3e8eT6fXkC+lsTg3Fa8CiaNO+C6KSqGWiWibX5MmGS+mwYOchqmJuPvAku8uzqw06SgyPvSmnidwh5gDYhX03g2fUvY1IzxSkUuzbEKX2zefe9NcK3fvaECwBVYQ9XzR+3x9wHpM7X7aGPyztYY6uDzqLY+oM0JNIGHvO4p7YrhmV7IpD053wzOQ+SV7JoAh3UdL1TbNxQ70DuRCAbPdo8tp71BbiOBjh6fe1XkLcicL3/4qoMA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1621dcd0-9aa4-4613-ac6c-08d6cc5161f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 03:18:43.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
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
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGstcGxsdjQu
YyB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2NC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1w
bGx2NC5jDQppbmRleCBkMzhiYzlmLi40Y2VkNWNhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsv
aW14L2Nsay1wbGx2NC5jDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHY0LmMNCkBAIC02
NCwxMyArNjQsMTggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xrX3BsbHY0X3JlY2FsY19yYXRl
KHN0cnVjdCBjbGtfaHcgKmh3LA0KIAkJCQkJICAgdW5zaWduZWQgbG9uZyBwYXJlbnRfcmF0ZSkN
CiB7DQogCXN0cnVjdCBjbGtfcGxsdjQgKnBsbCA9IHRvX2Nsa19wbGx2NChodyk7DQotCXUzMiBk
aXY7DQorCXUzMiBtdWx0ID0gcmVhZGxfcmVsYXhlZChwbGwtPmJhc2UgKyBQTExfQ0ZHX09GRlNF
VCk7DQorCXUzMiBtZm4gPSByZWFkbF9yZWxheGVkKHBsbC0+YmFzZSArIFBMTF9OVU1fT0ZGU0VU
KTsNCisJdTMyIG1mZCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlICsgUExMX0RFTk9NX09GRlNF
VCk7DQorCXU2NCB0ZW1wNjQgPSBwYXJlbnRfcmF0ZTsNCiANCi0JZGl2ID0gcmVhZGxfcmVsYXhl
ZChwbGwtPmJhc2UgKyBQTExfQ0ZHX09GRlNFVCk7DQotCWRpdiAmPSBCTV9QTExfTVVMVDsNCi0J
ZGl2ID4+PSBCUF9QTExfTVVMVDsNCisJbXVsdCAmPSBCTV9QTExfTVVMVDsNCisJbXVsdCA+Pj0g
QlBfUExMX01VTFQ7DQogDQotCXJldHVybiBwYXJlbnRfcmF0ZSAqIGRpdjsNCisJdGVtcDY0ICo9
IG1mbjsNCisJZG9fZGl2KHRlbXA2NCwgbWZkKTsNCisNCisJcmV0dXJuIChwYXJlbnRfcmF0ZSAq
IG11bHQpICsgKHUzMil0ZW1wNjQ7DQogfQ0KIA0KIHN0YXRpYyBsb25nIGNsa19wbGx2NF9yb3Vu
ZF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQpAQCAtNzgsMTQg
KzgzLDQ3IEBAIHN0YXRpYyBsb25nIGNsa19wbGx2NF9yb3VuZF9yYXRlKHN0cnVjdCBjbGtfaHcg
Kmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQogew0KIAl1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRl
ID0gKnByYXRlOw0KIAl1bnNpZ25lZCBsb25nIHJvdW5kX3JhdGUsIGk7DQorCWJvb2wgZm91bmQg
PSBmYWxzZTsNCisJdTMyIG1mbiwgbWZkID0gMTAwMDAwMDsNCisJdTMyIG1heF9tZmQgPSAweDNG
RkZGRkZGOw0KKwl1NjQgdGVtcDY0Ow0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShw
bGx2NF9tdWx0X3RhYmxlKTsgaSsrKSB7DQogCQlyb3VuZF9yYXRlID0gcGFyZW50X3JhdGUgKiBw
bGx2NF9tdWx0X3RhYmxlW2ldOw0KLQkJaWYgKHJhdGUgPj0gcm91bmRfcmF0ZSkNCi0JCQlyZXR1
cm4gcm91bmRfcmF0ZTsNCisJCWlmIChyYXRlID49IHJvdW5kX3JhdGUpIHsNCisJCQlmb3VuZCA9
IHRydWU7DQorCQkJYnJlYWs7DQorCQl9DQorCX0NCisNCisJaWYgKCFmb3VuZCkgew0KKwkJcHJf
d2FybigiJXM6IHVuYWJsZSB0byByb3VuZCByYXRlICVsdSwgcGFyZW50IHJhdGUgJWx1XG4iLA0K
KwkJCWNsa19od19nZXRfbmFtZShodyksIHJhdGUsIHBhcmVudF9yYXRlKTsNCisJCXJldHVybiAw
Ow0KIAl9DQogDQotCXJldHVybiByb3VuZF9yYXRlOw0KKwlpZiAocGFyZW50X3JhdGUgPD0gbWF4
X21mZCkNCisJCW1mZCA9IHBhcmVudF9yYXRlOw0KKw0KKwl0ZW1wNjQgPSAodTY0KShyYXRlIC0g
cm91bmRfcmF0ZSk7DQorCXRlbXA2NCAqPSBtZmQ7DQorCWRvX2Rpdih0ZW1wNjQsIHBhcmVudF9y
YXRlKTsNCisJbWZuID0gdGVtcDY0Ow0KKw0KKwkvKg0KKwkgKiBOT1RFOiBUaGUgdmFsdWUgb2Yg
bnVtZXJhdG9yIG11c3QgYWx3YXlzIGJlIGNvbmZpZ3VyZWQgdG8gYmUNCisJICogbGVzcyB0aGFu
IHRoZSB2YWx1ZSBvZiB0aGUgZGVub21pbmF0b3IuIElmIHdlIGNhbid0IGdldCBhIHByb3Blcg0K
KwkgKiBwYWlyIG9mIG1mbi9tZmQsIHdlIHNpbXBseSByZXR1cm4gdGhlIHJvdW5kX3JhdGUgd2l0
aG91dCB1c2luZw0KKwkgKiB0aGUgZnJhYyBwYXJ0Lg0KKwkgKi8NCisJaWYgKG1mbiA+PSBtZmQp
DQorCQlyZXR1cm4gcm91bmRfcmF0ZTsNCisNCisJdGVtcDY0ID0gKHU2NClwYXJlbnRfcmF0ZTsN
CisJdGVtcDY0ICo9IG1mbjsNCisJZG9fZGl2KHRlbXA2NCwgbWZkKTsNCisNCisJcmV0dXJuIHJv
dW5kX3JhdGUgKyAodTMyKXRlbXA2NDsNCiB9DQogDQogc3RhdGljIGJvb2wgY2xrX3BsbHY0X2lz
X3ZhbGlkX211bHQodW5zaWduZWQgaW50IG11bHQpDQpAQCAtMTA2LDE3ICsxNDQsMzEgQEAgc3Rh
dGljIGludCBjbGtfcGxsdjRfc2V0X3JhdGUoc3RydWN0IGNsa19odyAqaHcsIHVuc2lnbmVkIGxv
bmcgcmF0ZSwNCiB7DQogCXN0cnVjdCBjbGtfcGxsdjQgKnBsbCA9IHRvX2Nsa19wbGx2NChodyk7
DQogCXUzMiB2YWwsIG11bHQ7DQorCXUzMiBtZm4sIG1mZCA9IDEwMDAwMDA7DQorCXUzMiBtYXhf
bWZkID0gMHgzRkZGRkZGRjsNCisJdTY0IHRlbXA2NDsNCiANCiAJbXVsdCA9IHJhdGUgLyBwYXJl
bnRfcmF0ZTsNCiANCiAJaWYgKCFjbGtfcGxsdjRfaXNfdmFsaWRfbXVsdChtdWx0KSkNCiAJCXJl
dHVybiAtRUlOVkFMOw0KIA0KKwlpZiAocGFyZW50X3JhdGUgPD0gbWF4X21mZCkNCisJCW1mZCA9
IHBhcmVudF9yYXRlOw0KKw0KKwl0ZW1wNjQgPSAodTY0KShyYXRlIC0gbXVsdCAqIHBhcmVudF9y
YXRlKTsNCisJdGVtcDY0ICo9IG1mZDsNCisJZG9fZGl2KHRlbXA2NCwgcGFyZW50X3JhdGUpOw0K
KwltZm4gPSB0ZW1wNjQ7DQorDQogCXZhbCA9IHJlYWRsX3JlbGF4ZWQocGxsLT5iYXNlICsgUExM
X0NGR19PRkZTRVQpOw0KIAl2YWwgJj0gfkJNX1BMTF9NVUxUOw0KIAl2YWwgfD0gbXVsdCA8PCBC
UF9QTExfTVVMVDsNCiAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwbGwtPmJhc2UgKyBQTExfQ0ZHX09G
RlNFVCk7DQogDQorCXdyaXRlbF9yZWxheGVkKG1mbiwgcGxsLT5iYXNlICsgUExMX05VTV9PRkZT
RVQpOw0KKwl3cml0ZWxfcmVsYXhlZChtZmQsIHBsbC0+YmFzZSArIFBMTF9ERU5PTV9PRkZTRVQp
Ow0KKw0KIAlyZXR1cm4gMDsNCiB9DQogDQotLSANCjIuNy40DQoNCg==
