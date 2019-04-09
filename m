Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB3C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD872084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LPBTYxT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfDIFAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:00:14 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:20441
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfDIFAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtLXM1gwQzVo4EVtqWS4L6QYlpO9IiXgQ1lo9hTe1tY=;
 b=LPBTYxT0+zC+GpaKQl+iyD4LCapz5sfgOhDWM3znnSWlhhBHLveCAe18vb2cGOzAiGvedy3IToQgb2aujIvydjeAO7Ovk6GxcJ2lp11SyBWl4ydEd5uzt5PvCgMnBAHWu1gY78EP/pc6h9mfGSS67Y0MIqxi2G/V7eZVw2wTrO8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3865.eurprd04.prod.outlook.com (52.134.73.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 05:00:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 05:00:07 +0000
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
Subject: [PATCH V7 4/4] rtc: imx-sc: add rtc alarm support
Thread-Topic: [PATCH V7 4/4] rtc: imx-sc: add rtc alarm support
Thread-Index: AQHU7pEZ9C2z6clnd0y9G0M2Z7iy3Q==
Date:   Tue, 9 Apr 2019 05:00:07 +0000
Message-ID: <1554785675-8090-4-git-send-email-Anson.Huang@nxp.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::20) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36208c98-b07f-4de3-f701-08d6bca83c33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3865;
x-ms-traffictypediagnostic: DB3PR0402MB3865:
x-microsoft-antispam-prvs: <DB3PR0402MB38654F1EEE99F672132DD790F52D0@DB3PR0402MB3865.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(136003)(346002)(396003)(199004)(189003)(2906002)(52116002)(36756003)(68736007)(186003)(6436002)(26005)(110136005)(86362001)(6506007)(386003)(2201001)(8936002)(478600001)(25786009)(76176011)(102836004)(7736002)(316002)(4326008)(305945005)(66066001)(2501003)(97736004)(105586002)(7416002)(99286004)(50226002)(6486002)(8676002)(81156014)(81166006)(6116002)(106356001)(3846002)(71190400001)(71200400001)(5660300002)(14454004)(446003)(11346002)(486006)(6512007)(14444005)(2616005)(256004)(53936002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3865;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evZ++ZPVQqodDOOdXn7tB5twf2Q4ZyeNJkWAmd32X4A0St75Sg+dTC38c+F7EFxg2x/vA9Ktu6K1I35YJILTyjvSknKXYgTY9lzX2QSvj8Xooqz8zYDKNWkpuYYln2cpbrQyTNFlRpGZ9dJXNFWjIJ8rbkc21issE6xXCHyDl3QfuEGRdnn8GzlR0JcUDsc5lAySKVkDZxPxSaCKERW4D/kxTRZtk145idLPYGcxW/MwD+7v+QvdSJUbKvThdkWVdTlLVdFXsAbLS86w8cvjxROsEVTparTqIbaTpiuBANsQj8t5rK1errpokBaT2zd8YuuiOVNzgg2NtqXXXaGlz4syur2iNvztUSF9Ix+1+iZMRsC7h9ZmhgoRe281xuP+avq1dFC45YadG5iUm0uB5dt+FIHwNQiUSwe6ecEEYmk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36208c98-b07f-4de3-f701-08d6bca83c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 05:00:07.2902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3865
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
IEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8
YWlzaGVuZy5kb25nQG54cC5jb20+DQotLS0NCkNoYW5nZXMgc2luY2UgVjY6DQoJLSBhZGQgY29t
bWVudHMgdG8gLnJlYWRfYWxhcm0gY2FsbGJhY2sgZnVuY3Rpb24gdG8gZXhwbGFpbiB3aHkgaXQg
aXMgYW4gZW1wdHkgZnVuY3Rpb247DQoJLSBpbXByb3ZlIGlycSBub3RpZnkgY2FsbGJhY2sgZnVu
Y3Rpb24gbmFtZS4NCi0tDQogZHJpdmVycy9ydGMvcnRjLWlteC1zYy5jIHwgODcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDg3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1pbXgtc2Mu
YyBiL2RyaXZlcnMvcnRjL3J0Yy1pbXgtc2MuYw0KaW5kZXggMTk2NDJiZi4uYzkzMzA0NSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcnRjL3J0Yy1pbXgtc2MuYw0KKysrIGIvZHJpdmVycy9ydGMvcnRj
LWlteC1zYy5jDQpAQCAtMyw2ICszLDcgQEANCiAgKiBDb3B5cmlnaHQgMjAxOCBOWFAuDQogICov
DQogDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Zpcm13YXJlL2lteC9yc3JjLmg+DQogI2luY2x1
ZGUgPGxpbnV4L2FybS1zbWNjYy5oPg0KICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc2Np
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KQEAgLTExLDExICsxMiwxNSBAQA0KICNp
bmNsdWRlIDxsaW51eC9ydGMuaD4NCiANCiAjZGVmaW5lIElNWF9TQ19USU1FUl9GVU5DX0dFVF9S
VENfU0VDMTk3MAk5DQorI2RlZmluZSBJTVhfU0NfVElNRVJfRlVOQ19TRVRfUlRDX0FMQVJNCQk4
DQogI2RlZmluZSBJTVhfU0NfVElNRVJfRlVOQ19TRVRfUlRDX1RJTUUJCTYNCiANCiAjZGVmaW5l
IElNWF9TSVBfU1JUQwkJCTB4QzIwMDAwMDINCiAjZGVmaW5lIElNWF9TSVBfU1JUQ19TRVRfVElN
RQkJMHgwDQogDQorI2RlZmluZSBTQ19JUlFfR1JPVVBfUlRDICAgIDINCisjZGVmaW5lIFNDX0lS
UV9SVEMgICAgICAgICAgMQ0KKw0KIHN0YXRpYyBzdHJ1Y3QgaW14X3NjX2lwYyAqcnRjX2lwY19o
YW5kbGU7DQogc3RhdGljIHN0cnVjdCBydGNfZGV2aWNlICppbXhfc2NfcnRjOw0KIA0KQEAgLTI0
LDYgKzI5LDE2IEBAIHN0cnVjdCBpbXhfc2NfbXNnX3RpbWVyX2dldF9ydGNfdGltZSB7DQogCXUz
MiB0aW1lOw0KIH0gX19wYWNrZWQ7DQogDQorc3RydWN0IGlteF9zY19tc2dfdGltZXJfcnRjX3Nl
dF9hbGFybSB7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQorCXUxNiB5ZWFyOw0KKwl1
OCBtb247DQorCXU4IGRheTsNCisJdTggaG91cjsNCisJdTggbWluOw0KKwl1OCBzZWM7DQorfSBf
X3BhY2tlZDsNCisNCiBzdGF0aWMgaW50IGlteF9zY19ydGNfcmVhZF90aW1lKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkNCiB7DQogCXN0cnVjdCBpbXhfc2NfbXNnX3Rp
bWVyX2dldF9ydGNfdGltZSBtc2c7DQpAQCAtNjAsOSArNzUsNzcgQEAgc3RhdGljIGludCBpbXhf
c2NfcnRjX3NldF90aW1lKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y190aW1lICp0bSkN
CiAJcmV0dXJuIHJlcy5hMDsNCiB9DQogDQorc3RhdGljIGludCBpbXhfc2NfcnRjX2FsYXJtX2ly
cV9lbmFibGUoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgZW5hYmxlKQ0KK3sNCisJ
cmV0dXJuIGlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZShTQ19JUlFfR1JPVVBfUlRDLCBTQ19JUlFf
UlRDLCBlbmFibGUpOw0KK30NCisNCitzdGF0aWMgaW50IGlteF9zY19ydGNfcmVhZF9hbGFybShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBydGNfd2thbHJtICphbHJtKQ0KK3sNCisJLyoNCisJ
ICogU0NVIGZpcm13YXJlIGRvZXMgTk9UIHByb3ZpZGUgcmVhZCBhbGFybSBBUEksIGJ1dCAucmVh
ZF9hbGFybQ0KKwkgKiBjYWxsYmFjayBpcyByZXF1aXJlZCBieSBSVEMgZnJhbWV3b3JrIHRvIHN1
cHBvcnQgYWxhcm0gZnVuY3Rpb24sDQorCSAqIHNvIGp1c3QgcmV0dXJuIGhlcmUuDQorCSAqLw0K
KwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBpbXhfc2NfcnRjX3NldF9hbGFybShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBydGNfd2thbHJtICphbHJtKQ0KK3sNCisJc3RydWN0IGlt
eF9zY19tc2dfdGltZXJfcnRjX3NldF9hbGFybSBtc2c7DQorCXN0cnVjdCBpbXhfc2NfcnBjX21z
ZyAqaGRyID0gJm1zZy5oZHI7DQorCWludCByZXQ7DQorCXN0cnVjdCBydGNfdGltZSAqYWxybV90
bSA9ICZhbHJtLT50aW1lOw0KKw0KKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCisJ
aGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19USU1FUjsNCisJaGRyLT5mdW5jID0gSU1YX1NDX1RJ
TUVSX0ZVTkNfU0VUX1JUQ19BTEFSTTsNCisJaGRyLT5zaXplID0gMzsNCisNCisJbXNnLnllYXIg
PSBhbHJtX3RtLT50bV95ZWFyICsgMTkwMDsNCisJbXNnLm1vbiA9IGFscm1fdG0tPnRtX21vbiAr
IDE7DQorCW1zZy5kYXkgPSBhbHJtX3RtLT50bV9tZGF5Ow0KKwltc2cuaG91ciA9IGFscm1fdG0t
PnRtX2hvdXI7DQorCW1zZy5taW4gPSBhbHJtX3RtLT50bV9taW47DQorCW1zZy5zZWMgPSBhbHJt
X3RtLT50bV9zZWM7DQorDQorCXJldCA9IGlteF9zY3VfY2FsbF9ycGMocnRjX2lwY19oYW5kbGUs
ICZtc2csIHRydWUpOw0KKwlpZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgInNldCBydGMgYWxh
cm0gZmFpbGVkLCByZXQgJWRcbiIsIHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCXJl
dCA9IGlteF9zY19ydGNfYWxhcm1faXJxX2VuYWJsZShkZXYsIGFscm0tPmVuYWJsZWQpOw0KKwlp
ZiAocmV0KSB7DQorCQlkZXZfZXJyKGRldiwgImVuYWJsZSBydGMgYWxhcm0gZmFpbGVkLCByZXQg
JWRcbiIsIHJldCk7DQorCQlyZXR1cm4gcmV0Ow0KKwl9DQorDQorCXJldHVybiAwOw0KK30NCisN
CiBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0Y19jbGFzc19vcHMgaW14X3NjX3J0Y19vcHMgPSB7DQog
CS5yZWFkX3RpbWUgPSBpbXhfc2NfcnRjX3JlYWRfdGltZSwNCiAJLnNldF90aW1lID0gaW14X3Nj
X3J0Y19zZXRfdGltZSwNCisJLnJlYWRfYWxhcm0gPSBpbXhfc2NfcnRjX3JlYWRfYWxhcm0sDQor
CS5zZXRfYWxhcm0gPSBpbXhfc2NfcnRjX3NldF9hbGFybSwNCisJLmFsYXJtX2lycV9lbmFibGUg
PSBpbXhfc2NfcnRjX2FsYXJtX2lycV9lbmFibGUsDQorfTsNCisNCitzdGF0aWMgaW50IGlteF9z
Y19ydGNfYWxhcm1fbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQorCQkJCQl1bnNp
Z25lZCBsb25nIGV2ZW50LCB2b2lkICpncm91cCkNCit7DQorCS8qIGlnbm9yZSBub24tcnRjIGly
cSAqLw0KKwlpZiAoISgoZXZlbnQgJiBTQ19JUlFfUlRDKSAmJiAoKih1OCAqKWdyb3VwID09IFND
X0lSUV9HUk9VUF9SVEMpKSkNCisJCXJldHVybiAwOw0KKw0KKwlydGNfdXBkYXRlX2lycShpbXhf
c2NfcnRjLCAxLCBSVENfSVJRRiB8IFJUQ19BRik7DQorDQorCXJldHVybiAwOw0KK30NCisNCitz
dGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIGlteF9zY19ydGNfYWxhcm1fc2Nfbm90aWZpZXIg
PSB7DQorCS5ub3RpZmllcl9jYWxsID0gaW14X3NjX3J0Y19hbGFybV9ub3RpZnksDQogfTsNCiAN
CiBzdGF0aWMgaW50IGlteF9zY19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCkBAIC03Myw2ICsxNTYsOCBAQCBzdGF0aWMgaW50IGlteF9zY19ydGNfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKHJldCkNCiAJCXJldHVybiByZXQ7DQogDQor
CWRldmljZV9pbml0X3dha2V1cCgmcGRldi0+ZGV2LCB0cnVlKTsNCisNCiAJaW14X3NjX3J0YyA9
IGRldm1fcnRjX2FsbG9jYXRlX2RldmljZSgmcGRldi0+ZGV2KTsNCiAJaWYgKElTX0VSUihpbXhf
c2NfcnRjKSkNCiAJCXJldHVybiBQVFJfRVJSKGlteF9zY19ydGMpOw0KQEAgLTg3LDYgKzE3Miw4
IEBAIHN0YXRpYyBpbnQgaW14X3NjX3J0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAkJcmV0dXJuIHJldDsNCiAJfQ0KIA0KKwlpbXhfc2N1X2lycV9yZWdpc3Rlcl9ub3Rp
ZmllcigmaW14X3NjX3J0Y19hbGFybV9zY19ub3RpZmllcik7DQorDQogCXJldHVybiAwOw0KIH0N
CiANCi0tIA0KMi43LjQNCg0K
