Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BAE217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYLPS16c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDICoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:44:09 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:4482
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfDICoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbX5qAr3UEAyWe3LWY10x/NHZJJD+Jky7wW96XDV5W4=;
 b=RYLPS16c8NeBQGn3trWaNAK7pDuddWYeWhWZwm5cr+eIjD9u/oFrqAEqG1eQwyJ083jjHKoUNKFK4ZODiKYjmqMZ/qtfYKRgbv7B0PHmABxF9BlKsifmJw5TLNLyWiTIs6K5Cp+gqrxNVsbkLSwRdN491/CVcDuZa35mlzHYxV4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Tue, 9 Apr 2019 02:43:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:43:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V6 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU7n4EdgguyHsDvUib9vTZjNBAXA==
Date:   Tue, 9 Apr 2019 02:43:31 +0000
Message-ID: <1554777487-31075-4-git-send-email-Anson.Huang@nxp.com>
References: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5db90f0-37f8-4ba3-d6e2-08d6bc9526d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB392972D6876761A2E71F4E22F52D0@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(6512007)(53936002)(102836004)(478600001)(14454004)(6116002)(3846002)(7416002)(99286004)(97736004)(386003)(6506007)(305945005)(186003)(110136005)(4326008)(7736002)(316002)(256004)(25786009)(26005)(14444005)(446003)(2616005)(11346002)(5660300002)(105586002)(2501003)(106356001)(486006)(6436002)(6486002)(2906002)(476003)(68736007)(71190400001)(8936002)(81166006)(81156014)(50226002)(2201001)(86362001)(76176011)(52116002)(71200400001)(36756003)(8676002)(66066001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJ3+BovoAGmYDXk/taipBX+COozKux+/+UAfw3yrYKdNt6IvqmHctqXoUOYWNW9ZBemfZygtEgoEu3qnNhIu4Rhsem5FM/KxH0Zy2pgBIJKHH71a4ZpK9mBITkWB5xetKXQdNq9S9+2vS2+d4gmYah96BwPORv8DgL99G/3OlWrMYSdHHU8NL/6WevsPjxGvoaYF2BscTzz0vxS4bsLK07yLA89B3EoX7i+b67s7xxYOLoHUdUhcMr1MvtJO3I1hcJK+quHFUFHF+Km6UnCWdyxzXJRQhOMrbFLO8/UOufYFxENh9AV41lUU49OSVAM9uRDs72esK35Vh7hzQBylvvct7d7CG07HG6eZnJRYG59VZFptJkvI81Gex2FB1j3abhMliqlA+zxISNbEDSoLfclJmTqBoH8uUgJro5FmSmg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db90f0-37f8-4ba3-d6e2-08d6bc9526d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:43:31.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgUlRDIGFsYXJtIHN1cHBvcnQsIHRoZSBSVEMgYWxh
cm0NCmlzIGltcGxlbWVudGVkIHZpYSBTSVAoc2lsaWNvbiBwcm92aWRlcikgcnVudGltZSBzZXJ2
aWNlIGNhbGwNCmFuZCBBUk0tVHJ1c3RlZC1GaXJtd2FyZSB3aWxsIGNvbW11bmljYXRlIHdpdGgg
c3lzdGVtIGNvbnRyb2xsZXINCnZpYSBNVShtZXNzYWdlIHVuaXQpIElQQyB0byBzZXQgUlRDIGFs
YXJtLiBXaGVuIFJUQyBhbGFybSBmaXJlcywNCnN5c3RlbSBjb250cm9sbGVyIHdpbGwgZ2VuZXJh
dGUgYSBjb21tb24gTVUgaXJxIGV2ZW50IGFuZCBub3RpZnkNCnN5c3RlbSBjb250cm9sbGVyIFJU
QyBkcml2ZXIgdG8gaGFuZGxlIHRoZSBpcnEgZXZlbnQuDQoNClNpZ25lZC1vZmYtYnk6IEFuc29u
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQpDaGFuZ2VzIHNpbmNlIFY1Og0KCS0g
bW92ZSB0aGUgaXJxIGFsYXJtIGVuYWJsZSBSUEMgdG8gaW14LXNjdS1pcnEgZHJpdmVyLCBhbmQg
cnRjIGRyaXZlciBqdXN0IGNhbGwgdGhlDQoJICBBUEkgdG8gZW5hYmxlL2Rpc2FibGUgYWxhcm0u
DQotLS0NCiBkcml2ZXJzL3J0Yy9ydGMtaW14LXNjLmMgfCA4NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgODQgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLWlteC1zYy5jIGIvZHJpdmVy
cy9ydGMvcnRjLWlteC1zYy5jDQppbmRleCAxOTY0MmJmLi4zZWI0ZGIwIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ydGMvcnRjLWlteC1zYy5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtaW14LXNjLmMN
CkBAIC0zLDYgKzMsNyBAQA0KICAqIENvcHlyaWdodCAyMDE4IE5YUC4NCiAgKi8NCiANCisjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4NCiAjaW5jbHVkZSA8bGludXgv
YXJtLXNtY2NjLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2lteC9zY2kuaD4NCiAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQpAQCAtMTEsMTEgKzEyLDE1IEBADQogI2luY2x1ZGUgPGxp
bnV4L3J0Yy5oPg0KIA0KICNkZWZpbmUgSU1YX1NDX1RJTUVSX0ZVTkNfR0VUX1JUQ19TRUMxOTcw
CTkNCisjZGVmaW5lIElNWF9TQ19USU1FUl9GVU5DX1NFVF9SVENfQUxBUk0JCTgNCiAjZGVmaW5l
IElNWF9TQ19USU1FUl9GVU5DX1NFVF9SVENfVElNRQkJNg0KIA0KICNkZWZpbmUgSU1YX1NJUF9T
UlRDCQkJMHhDMjAwMDAwMg0KICNkZWZpbmUgSU1YX1NJUF9TUlRDX1NFVF9USU1FCQkweDANCiAN
CisjZGVmaW5lIFNDX0lSUV9HUk9VUF9SVEMgICAgMg0KKyNkZWZpbmUgU0NfSVJRX1JUQyAgICAg
ICAgICAxDQorDQogc3RhdGljIHN0cnVjdCBpbXhfc2NfaXBjICpydGNfaXBjX2hhbmRsZTsNCiBz
dGF0aWMgc3RydWN0IHJ0Y19kZXZpY2UgKmlteF9zY19ydGM7DQogDQpAQCAtMjQsNiArMjksMTYg
QEAgc3RydWN0IGlteF9zY19tc2dfdGltZXJfZ2V0X3J0Y190aW1lIHsNCiAJdTMyIHRpbWU7DQog
fSBfX3BhY2tlZDsNCiANCitzdHJ1Y3QgaW14X3NjX21zZ190aW1lcl9ydGNfc2V0X2FsYXJtIHsN
CisJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCisJdTE2IHllYXI7DQorCXU4IG1vbjsNCisJ
dTggZGF5Ow0KKwl1OCBob3VyOw0KKwl1OCBtaW47DQorCXU4IHNlYzsNCit9IF9fcGFja2VkOw0K
Kw0KIHN0YXRpYyBpbnQgaW14X3NjX3J0Y19yZWFkX3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgcnRjX3RpbWUgKnRtKQ0KIHsNCiAJc3RydWN0IGlteF9zY19tc2dfdGltZXJfZ2V0X3J0
Y190aW1lIG1zZzsNCkBAIC02MCw5ICs3NSw3NCBAQCBzdGF0aWMgaW50IGlteF9zY19ydGNfc2V0
X3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUgKnRtKQ0KIAlyZXR1cm4g
cmVzLmEwOw0KIH0NCiANCitzdGF0aWMgaW50IGlteF9zY19ydGNfYWxhcm1faXJxX2VuYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBlbmFibGUpDQorew0KKwlpbXhfc2N1X2ly
cV9lbmFibGUoU0NfSVJRX0dST1VQX1JUQywgU0NfSVJRX1JUQywgZW5hYmxlKTsNCisNCisJcmV0
dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgaW14X3NjX3J0Y19yZWFkX2FsYXJtKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0IHJ0Y193a2Fscm0gKmFscm0pDQorew0KKwlyZXR1cm4gMDsNCit9
DQorDQorc3RhdGljIGludCBpbXhfc2NfcnRjX3NldF9hbGFybShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBydGNfd2thbHJtICphbHJtKQ0KK3sNCisJc3RydWN0IGlteF9zY19tc2dfdGltZXJf
cnRjX3NldF9hbGFybSBtc2c7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0gJm1zZy5o
ZHI7DQorCWludCByZXQ7DQorCXN0cnVjdCBydGNfdGltZSAqYWxybV90bSA9ICZhbHJtLT50aW1l
Ow0KKw0KKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCisJaGRyLT5zdmMgPSBJTVhf
U0NfUlBDX1NWQ19USU1FUjsNCisJaGRyLT5mdW5jID0gSU1YX1NDX1RJTUVSX0ZVTkNfU0VUX1JU
Q19BTEFSTTsNCisJaGRyLT5zaXplID0gMzsNCisNCisJbXNnLnllYXIgPSBhbHJtX3RtLT50bV95
ZWFyICsgMTkwMDsNCisJbXNnLm1vbiA9IGFscm1fdG0tPnRtX21vbiArIDE7DQorCW1zZy5kYXkg
PSBhbHJtX3RtLT50bV9tZGF5Ow0KKwltc2cuaG91ciA9IGFscm1fdG0tPnRtX2hvdXI7DQorCW1z
Zy5taW4gPSBhbHJtX3RtLT50bV9taW47DQorCW1zZy5zZWMgPSBhbHJtX3RtLT50bV9zZWM7DQor
DQorCXJldCA9IGlteF9zY3VfY2FsbF9ycGMocnRjX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0K
KwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgInNldCBydGMgYWxhcm0gZmFpbGVkLCByZXQg
JWRcbiIsIHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCXJldCA9IGlteF9zY19ydGNf
YWxhcm1faXJxX2VuYWJsZShkZXYsIGFscm0tPmVuYWJsZWQpOw0KKwlpZiAocmV0KSB7DQorCQlk
ZXZfZXJyKGRldiwgImVuYWJsZSBydGMgYWxhcm0gZmFpbGVkLCByZXQgJWRcbiIsIHJldCk7DQor
CQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHJ0Y19jbGFzc19vcHMgaW14X3NjX3J0Y19vcHMgPSB7DQogCS5yZWFkX3RpbWUgPSBp
bXhfc2NfcnRjX3JlYWRfdGltZSwNCiAJLnNldF90aW1lID0gaW14X3NjX3J0Y19zZXRfdGltZSwN
CisJLnJlYWRfYWxhcm0gPSBpbXhfc2NfcnRjX3JlYWRfYWxhcm0sDQorCS5zZXRfYWxhcm0gPSBp
bXhfc2NfcnRjX3NldF9hbGFybSwNCisJLmFsYXJtX2lycV9lbmFibGUgPSBpbXhfc2NfcnRjX2Fs
YXJtX2lycV9lbmFibGUsDQorfTsNCisNCitzdGF0aWMgaW50IGlteF9zY19ydGNfYWxhcm1fc2Nf
bm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQorCQkJCQl1bnNpZ25lZCBsb25nIGV2
ZW50LCB2b2lkICpncm91cCkNCit7DQorCS8qIGlnbm9yZSBub24tcnRjIGlycSAqLw0KKwlpZiAo
ISgoZXZlbnQgJiBTQ19JUlFfUlRDKSAmJiAoKih1OCAqKWdyb3VwID09IFNDX0lSUV9HUk9VUF9S
VEMpKSkNCisJCXJldHVybiAwOw0KKw0KKwlydGNfdXBkYXRlX2lycShpbXhfc2NfcnRjLCAxLCBS
VENfSVJRRiB8IFJUQ19BRik7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgc3RydWN0
IG5vdGlmaWVyX2Jsb2NrIGlteF9zY19ydGNfYWxhcm1fc2Nfbm90aWZpZXIgPSB7DQorCS5ub3Rp
Zmllcl9jYWxsID0gaW14X3NjX3J0Y19hbGFybV9zY19ub3RpZnksDQogfTsNCiANCiBzdGF0aWMg
aW50IGlteF9zY19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCkBAIC03
Myw2ICsxNTMsOCBAQCBzdGF0aWMgaW50IGlteF9zY19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCiAJaWYgKHJldCkNCiAJCXJldHVybiByZXQ7DQogDQorCWRldmljZV9p
bml0X3dha2V1cCgmcGRldi0+ZGV2LCB0cnVlKTsNCisNCiAJaW14X3NjX3J0YyA9IGRldm1fcnRj
X2FsbG9jYXRlX2RldmljZSgmcGRldi0+ZGV2KTsNCiAJaWYgKElTX0VSUihpbXhfc2NfcnRjKSkN
CiAJCXJldHVybiBQVFJfRVJSKGlteF9zY19ydGMpOw0KQEAgLTg3LDYgKzE2OSw4IEBAIHN0YXRp
YyBpbnQgaW14X3NjX3J0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJ
cmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcigmaW14
X3NjX3J0Y19hbGFybV9zY19ub3RpZmllcik7DQorDQogCXJldHVybiAwOw0KIH0NCiANCi0tIA0K
Mi43LjQNCg0K
