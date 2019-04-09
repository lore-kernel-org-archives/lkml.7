Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14450C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAB8213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MvNrHSKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDICnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:43:55 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:4482
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfDICnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwf0P9zGGgg65QyPQ93jaYsckIqWKZIKVU3WSWqMyIQ=;
 b=MvNrHSKXkMtkgvW9VFaZkgBqpw9U+82csDn2MJ+PSHUiaTBrXBWLp1SH2u7m6EPDP39gAOwsIgi7kQ+ifgLoOsuIiBCZPkRT0qKGjCzIekWwlmmWZHFbIA+r/zcNGVFABK392/2NJAQThiC1xRWBpcNii2QbjwcOP7+Q2QdNJLE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Tue, 9 Apr 2019 02:43:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 02:43:09 +0000
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
Subject: [PATCH V6 1/4] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHU7n33RGF29wp+KEqbA4Q8GOcUJA==
Date:   Tue, 9 Apr 2019 02:43:08 +0000
Message-ID: <1554777487-31075-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 9dbdb4c3-3fcb-4f03-2f88-08d6bc9519ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB3929B8DB9DB6D4B72DC484A2F52D0@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(6512007)(53936002)(102836004)(478600001)(14454004)(6116002)(3846002)(7416002)(99286004)(97736004)(386003)(6506007)(305945005)(186003)(110136005)(4326008)(7736002)(316002)(256004)(25786009)(26005)(2616005)(5660300002)(105586002)(2501003)(106356001)(486006)(6436002)(6486002)(2906002)(476003)(68736007)(71190400001)(8936002)(81166006)(81156014)(50226002)(2201001)(86362001)(52116002)(71200400001)(36756003)(8676002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pmr1qLgysYtF1hRIOgfDrNNp4Fbc3LM93eGqIB/aPxm4WOMnvs1WO5pRZgXbUHnYBmiLmpisec1AT0ocJsWgONZUQGOTUFavx8tr1ie0R7HKBQZKlCTkf7w6LoD6W7JIjwn0wlByhkV0J01A6RSWy0/QvXwTvNPN8C5TzECnELZxs4T17TSovS9/KsPbZEepOaUzlYpZsDvHJdgs3E3qXOKiu80V/NjCsd56AVsqrmAVv0HWbsDIX5GkEpYbiZm9820KErDpDc9yXZEQgaDyxe6ZniGNWerlnVOCzGGz0CTbEqgloySLL3qmNhYnZAgldPjQ8JijUZy4u/vjaWOgjOW74UAkw0WZe2Ywp0L1S0jgszrBnI5O+cAGFN2/WkNVuvi7+huzDlQYaBpxWY0vP4bnhP/T6Az/sYXo4+OKgPw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbdb4c3-3fcb-4f03-2f88-08d6bc9519ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 02:43:09.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNjdSBnZW5lcmFsIGludGVycnVwdCBmdW5jdGlvbiBzdXBwb3J0Lg0KDQpTaWduZWQtb2Zm
LWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBSb2Ig
SGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KUmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+DQotLS0NCk5vIGNoYW5nZXMuDQotLS0NCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICB8IDI5ICsrKysrKysrKysrKysr
KysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxzY3UudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCmluZGV4IDcyZDQ4MWMuLjVkN2RiYWIgMTAwNjQ0
DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9m
c2wsc2N1LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLHNjdS50eHQNCkBAIC0yMiw5ICsyMiwxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KIC0tLS0tLS0tLS0tLS0tLS0tLS0NCiAtIGNvbXBhdGlibGU6CXNob3VsZCBiZSAiZnNs
LGlteC1zY3UiLg0KIC0gbWJveC1uYW1lczoJc2hvdWxkIGluY2x1ZGUgInR4MCIsICJ0eDEiLCAi
dHgyIiwgInR4MyIsDQotCQkJICAgICAgICJyeDAiLCAicngxIiwgInJ4MiIsICJyeDMiLg0KLS0g
bWJveGVzOglMaXN0IG9mIHBoYW5kbGUgb2YgNCBNVSBjaGFubmVscyBmb3IgdHggYW5kIDQgTVUg
Y2hhbm5lbHMNCi0JCWZvciByeC4gQWxsIDggTVUgY2hhbm5lbHMgbXVzdCBiZSBpbiB0aGUgc2Ft
ZSBNVSBpbnN0YW5jZS4NCisJCQkgICAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyI7DQor
CQlpbmNsdWRlICJnaXAzIiBpZiB3YW50IHRvIHN1cHBvcnQgZ2VuZXJhbCBNVSBpbnRlcnJ1cHQu
DQorLSBtYm94ZXM6CUxpc3Qgb2YgcGhhbmRsZSBvZiA0IE1VIGNoYW5uZWxzIGZvciB0eCwgNCBN
VSBjaGFubmVscyBmb3INCisJCXJ4LCBhbmQgMSBvcHRpb25hbCBNVSBjaGFubmVsIGZvciBnZW5l
cmFsIGludGVycnVwdC4NCisJCUFsbCBNVSBjaGFubmVscyBtdXN0IGJlIGluIHRoZSBzYW1lIE1V
IGluc3RhbmNlLg0KIAkJQ3Jvc3MgaW5zdGFuY2VzIGFyZSBub3QgYWxsb3dlZC4gVGhlIE1VIGlu
c3RhbmNlIGNhbiBvbmx5DQogCQliZSBvbmUgb2YgTFNJTyBNVTB+TTQgZm9yIGlteDhxeHAgYW5k
IGlteDhxbS4gVXNlcnMgbmVlZA0KIAkJdG8gbWFrZSBzdXJlIHVzZSB0aGUgb25lIHdoaWNoIGlz
IG5vdCBjb25mbGljdCB3aXRoIG90aGVyDQpAQCAtMzQsNiArMzYsNyBAQCBSZXF1aXJlZCBwcm9w
ZXJ0aWVzOg0KIAkJQ2hhbm5lbCAxIG11c3QgYmUgInR4MSIgb3IgInJ4MSIuDQogCQlDaGFubmVs
IDIgbXVzdCBiZSAidHgyIiBvciAicngyIi4NCiAJCUNoYW5uZWwgMyBtdXN0IGJlICJ0eDMiIG9y
ICJyeDMiLg0KKwkJR2VuZXJhbCBpbnRlcnJ1cHQgcnggY2hhbm5lbCBtdXN0IGJlICJnaXAzIi4N
CiAJCWUuZy4NCiAJCW1ib3hlcyA9IDwmbHNpb19tdTEgMCAwDQogCQkJICAmbHNpb19tdTEgMCAx
DQpAQCAtNDIsMTAgKzQ1LDE4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogCQkJICAmbHNpb19t
dTEgMSAwDQogCQkJICAmbHNpb19tdTEgMSAxDQogCQkJICAmbHNpb19tdTEgMSAyDQotCQkJICAm
bHNpb19tdTEgMSAzPjsNCisJCQkgICZsc2lvX211MSAxIDMNCisJCQkgICZsc2lvX211MSAzIDM+
Ow0KIAkJU2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L2ZzbCxt
dS50eHQNCiAJCWZvciBkZXRhaWxlZCBtYWlsYm94IGJpbmRpbmcuDQogDQorTm90ZTogRWFjaCBt
dSB3aGljaCBzdXBwb3J0cyBnZW5lcmFsIGludGVycnVwdCBzaG91bGQgaGF2ZSBhbiBhbGlhcyBj
b3JyZWN0bHkNCitudW1iZXJlZCBpbiAiYWxpYXNlcyIgbm9kZS4NCitlLmcuDQorYWxpYXNlcyB7
DQorCW11MSA9ICZsc2lvX211MTsNCit9Ow0KKw0KIGkuTVggU0NVIENsaWVudCBEZXZpY2UgTm9k
ZToNCiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCiANCkBAIC0xMjQsNiArMTM1LDEwIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQog
DQogRXhhbXBsZSAoaW14OHF4cCk6DQogLS0tLS0tLS0tLS0tLQ0KK2FsaWFzZXMgew0KKwltdTEg
PSAmbHNpb19tdTE7DQorfTsNCisNCiBsc2lvX211MTogbWFpbGJveEA1ZDFjMDAwMCB7DQogCS4u
Lg0KIAkjbWJveC1jZWxscyA9IDwyPjsNCkBAIC0xMzMsNyArMTQ4LDggQEAgZmlybXdhcmUgew0K
IAlzY3Ugew0KIAkJY29tcGF0aWJsZSA9ICJmc2wsaW14LXNjdSI7DQogCQltYm94LW5hbWVzID0g
InR4MCIsICJ0eDEiLCAidHgyIiwgInR4MyIsDQotCQkJICAgICAicngwIiwgInJ4MSIsICJyeDIi
LCAicngzIjsNCisJCQkgICAgICJyeDAiLCAicngxIiwgInJ4MiIsICJyeDMiLA0KKwkJCSAgICAg
ImdpcDMiOw0KIAkJbWJveGVzID0gPCZsc2lvX211MSAwIDANCiAJCQkgICZsc2lvX211MSAwIDEN
CiAJCQkgICZsc2lvX211MSAwIDINCkBAIC0xNDEsNyArMTU3LDggQEAgZmlybXdhcmUgew0KIAkJ
CSAgJmxzaW9fbXUxIDEgMA0KIAkJCSAgJmxzaW9fbXUxIDEgMQ0KIAkJCSAgJmxzaW9fbXUxIDEg
Mg0KLQkJCSAgJmxzaW9fbXUxIDEgMz47DQorCQkJICAmbHNpb19tdTEgMSAzDQorCQkJICAmbHNp
b19tdTEgMyAzPjsNCiANCiAJCWNsazogY2xrIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4
cXhwLWNsayIsICJmc2wsc2N1LWNsayI7DQotLSANCjIuNy40DQoNCg==
