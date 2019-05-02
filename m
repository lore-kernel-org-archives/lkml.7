Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F612133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bB3h+A6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEBIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:07:00 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:51954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbfEBIG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VreMw08K1QYvE445NH5Gr1g17TVjMFIsCtPHIxRlHHQ=;
 b=bB3h+A6IimXzlG6hxrkETHMOHxR1PFC8lbLLHmJMWmZAGYDL7iHDFY01A8q/nNZL2UQq45cVOfc8Y2lkMsuEMy+kiIJtx1tAn6nDJ4EUOfSj+ZaTrK/lYohgNs6QswcUeOkkM5ylzS9kvZXZR5HkXl/Gt3chhx5iReWCGb1pQTk=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.177.40.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Thu, 2 May 2019 08:06:48 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:48 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 10/18] clk: imx: clk-fixup-div: Switch to clk_hw based API
Thread-Topic: [PATCH v2 10/18] clk: imx: clk-fixup-div: Switch to clk_hw based
 API
Thread-Index: AQHVAL3+K+LqazBmQEWkh8KDmGpwvw==
Date:   Thu, 2 May 2019 08:06:48 +0000
Message-ID: <1556784376-7191-11-git-send-email-abel.vesa@nxp.com>
References: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0041.eurprd05.prod.outlook.com
 (2603:10a6:800:60::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c92efc5a-4fa4-48d1-fc4a-08d6ced5206c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB494813BD6D14C95D992E5F7FF6340@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(86362001)(3846002)(8676002)(478600001)(25786009)(186003)(6436002)(81156014)(26005)(71190400001)(71200400001)(102836004)(14454004)(6116002)(4326008)(53936002)(305945005)(7736002)(66066001)(36756003)(81166006)(50226002)(8936002)(6512007)(66556008)(64756008)(44832011)(316002)(54906003)(110136005)(99286004)(476003)(2616005)(66946007)(73956011)(486006)(68736007)(66476007)(66446008)(256004)(2906002)(6486002)(11346002)(446003)(5660300002)(52116002)(76176011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y1Q8tQataOoGdf6BThSXmV0qU8nnX8ZmcC47hOYdjVw6DXkFVN4eHQpsIb+83KY8u7JWqcSPuV5KMw4VAAKH8lCpMraZexw5IV9R30+GBE/OYLYpt1+xLAmBHn2h+FpXYGqXTKJwBfaJ1xl2VJXcvCDmJTqUUgPU8M1wxuTHgEGA2CSC72eNfP/9uJDj/FmoXnhNHaHDZ/4jm6TeAESiQn9qbPg1rhAY0//Aucb5iCD7k5mlBRY9KlolfF+msozGVAE90aXY6oEssM66ktVtRX4wTHYOMvVkmHLj8gtWmJqZAHfVQefWsjtAnMymXut1u1SedwYkmGewnAub+bvyiilsf3IqkV1xFHuIGWd80z6Y+DQxHJy3SGwAWslNnKzxe11q15LKLSStJC7n+Muqi69rz3JiRdH/Y99yaiic+eU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92efc5a-4fa4-48d1-fc4a-08d6ced5206c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:48.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBpbXhfY2xrX2ZpeHVwX2RpdmlkZXIgZnVuY3Rpb24gdG8gY2xrX2h3IGJhc2Vk
IEFQSSwgcmVuYW1lDQphY2NvcmRpbmdseSBhbmQgYWRkIGEgbWFjcm8gZm9yIGNsayBiYXNlZCBs
ZWdhY3kuIFRoaXMgYWxsb3dzIHVzIHRvDQptb3ZlIGNsb3NlciB0byBhIGNsZWFyIHNwbGl0IGJl
dHdlZW4gY29uc3VtZXIgYW5kIHByb3ZpZGVyIGNsayBBUElzLg0KDQpTaWduZWQtb2ZmLWJ5OiBB
YmVsIFZlc2EgPGFiZWwudmVzYUBueHAuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvaW14L2Nsay1m
aXh1cC1kaXYuYyB8IDE1ICsrKysrKysrKystLS0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAg
ICAgICAgICAgfCAgNyArKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1maXh1
cC1kaXYuYyBiL2RyaXZlcnMvY2xrL2lteC9jbGstZml4dXAtZGl2LmMNCmluZGV4IGNlNTcyMjcz
Li4yODc1MzliIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1maXh1cC1kaXYuYw0K
KysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1maXh1cC1kaXYuYw0KQEAgLTkxLDEzICs5MSwxNCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xrX2ZpeHVwX2Rpdl9vcHMgPSB7DQogCS5z
ZXRfcmF0ZSA9IGNsa19maXh1cF9kaXZfc2V0X3JhdGUsDQogfTsNCiANCi1zdHJ1Y3QgY2xrICpp
bXhfY2xrX2ZpeHVwX2RpdmlkZXIoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50
LA0KK3N0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfZml4dXBfZGl2aWRlcihjb25zdCBjaGFyICpu
YW1lLCBjb25zdCBjaGFyICpwYXJlbnQsDQogCQkJCSAgdm9pZCBfX2lvbWVtICpyZWcsIHU4IHNo
aWZ0LCB1OCB3aWR0aCwNCiAJCQkJICB2b2lkICgqZml4dXApKHUzMiAqdmFsKSkNCiB7DQogCXN0
cnVjdCBjbGtfZml4dXBfZGl2ICpmaXh1cF9kaXY7DQotCXN0cnVjdCBjbGsgKmNsazsNCisJc3Ry
dWN0IGNsa19odyAqaHc7DQogCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQ7DQorCWludCByZXQ7
DQogDQogCWlmICghZml4dXApDQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCkBAIC0xMjAs
OSArMTIxLDEzIEBAIHN0cnVjdCBjbGsgKmlteF9jbGtfZml4dXBfZGl2aWRlcihjb25zdCBjaGFy
ICpuYW1lLCBjb25zdCBjaGFyICpwYXJlbnQsDQogCWZpeHVwX2Rpdi0+b3BzID0gJmNsa19kaXZp
ZGVyX29wczsNCiAJZml4dXBfZGl2LT5maXh1cCA9IGZpeHVwOw0KIA0KLQljbGsgPSBjbGtfcmVn
aXN0ZXIoTlVMTCwgJmZpeHVwX2Rpdi0+ZGl2aWRlci5odyk7DQotCWlmIChJU19FUlIoY2xrKSkN
CisJaHcgPSAmZml4dXBfZGl2LT5kaXZpZGVyLmh3Ow0KKw0KKwlyZXQgPSBjbGtfaHdfcmVnaXN0
ZXIoTlVMTCwgaHcpOw0KKwlpZiAocmV0KSB7DQogCQlrZnJlZShmaXh1cF9kaXYpOw0KKwkJcmV0
dXJuIEVSUl9QVFIocmV0KTsNCisJfQ0KIA0KLQlyZXR1cm4gY2xrOw0KKwlyZXR1cm4gaHc7DQog
fQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuaCBiL2RyaXZlcnMvY2xrL2lteC9j
bGsuaA0KaW5kZXggMTMwNDMxNS4uZmMzMmJhYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lt
eC9jbGsuaA0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQpAQCAtNzIsNiArNzIsOSBAQCBz
dHJ1Y3QgaW14X3BsbDE0eHhfY2xrIHsNCiAjZGVmaW5lIGlteF9jbGtfZ2F0ZV9leGNsdXNpdmUo
bmFtZSwgcGFyZW50LCByZWcsIHNoaWZ0LCBleGNsdXNpdmVfbWFzaykgXA0KIAlpbXhfY2xrX2h3
X2dhdGVfZXhjbHVzaXZlKG5hbWUsIHBhcmVudCwgcmVnLCBzaGlmdCwgZXhjbHVzaXZlX21hc2sp
LT5jbGsNCiANCisjZGVmaW5lIGlteF9jbGtfZml4dXBfZGl2aWRlcihuYW1lLCBwYXJlbnQsIHJl
Zywgc2hpZnQsIHdpZHRoLCBmaXh1cCkgXA0KKwlpbXhfY2xrX2h3X2ZpeHVwX2RpdmlkZXIobmFt
ZSwgcGFyZW50LCByZWcsIHNoaWZ0LCB3aWR0aCwgZml4dXApLT5jbGsNCisNCiBzdHJ1Y3QgY2xr
ICppbXhfY2xrX3BsbDE0eHgoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25h
bWUsDQogCQkgdm9pZCBfX2lvbWVtICpiYXNlLCBjb25zdCBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xr
ICpwbGxfY2xrKTsNCiANCkBAIC0xNDgsMTEgKzE1MSwxMSBAQCBzdHJ1Y3QgY2xrX2h3ICppbXg3
dWxwX2Nsa19jb21wb3NpdGUoY29uc3QgY2hhciAqbmFtZSwNCiAJCQkJICAgICBib29sIHJhdGVf
cHJlc2VudCwgYm9vbCBnYXRlX3ByZXNlbnQsDQogCQkJCSAgICAgdm9pZCBfX2lvbWVtICpyZWcp
Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtfZml4dXBfZGl2aWRlcihjb25zdCBjaGFyICpuYW1l
LCBjb25zdCBjaGFyICpwYXJlbnQsDQorc3RydWN0IGNsa19odyAqaW14X2Nsa19od19maXh1cF9k
aXZpZGVyKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudCwNCiAJCQkJICB2b2lk
IF9faW9tZW0gKnJlZywgdTggc2hpZnQsIHU4IHdpZHRoLA0KIAkJCQkgIHZvaWQgKCpmaXh1cCko
dTMyICp2YWwpKTsNCiANCi1zdHJ1Y3QgY2xrICppbXhfY2xrX2ZpeHVwX211eChjb25zdCBjaGFy
ICpuYW1lLCB2b2lkIF9faW9tZW0gKnJlZywNCitzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2h3X2Zp
eHVwX211eChjb25zdCBjaGFyICpuYW1lLCB2b2lkIF9faW9tZW0gKnJlZywNCiAJCQkgICAgICB1
OCBzaGlmdCwgdTggd2lkdGgsIGNvbnN0IGNoYXIgKiBjb25zdCAqcGFyZW50cywNCiAJCQkgICAg
ICBpbnQgbnVtX3BhcmVudHMsIHZvaWQgKCpmaXh1cCkodTMyICp2YWwpKTsNCiANCi0tIA0KMi43
LjQNCg0K
