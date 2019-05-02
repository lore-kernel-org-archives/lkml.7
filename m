Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514F920675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbWlX1nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEBIIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:08:13 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:51954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfEBIGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA6Qf6MZzfh97HRu3YxvB4VKPIsK+XB/X9pf8yDRXSE=;
 b=dbWlX1nqrrv0/8jIZ6COHBV4/Wyw532ihfRi4d5WK06kBGwevMfSqWdg3Dk97Z1gYrrt+AVacRkBWiBQJNinfsBoYSgQ09GWUSYcEHYgB6Az7wX70n5qj2BdcctSc6cA9nCQhKQR5UY+w3FXPxpWdDIpB7RTkl9hg37b2sUysUY=
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
Subject: [PATCH v2 09/18] clk: imx: clk-gate-exclusive: Switch to clk_hw based
 API
Thread-Topic: [PATCH v2 09/18] clk: imx: clk-gate-exclusive: Switch to clk_hw
 based API
Thread-Index: AQHVAL39kem+eMSdpUuD+JPRZq4xDg==
Date:   Thu, 2 May 2019 08:06:48 +0000
Message-ID: <1556784376-7191-10-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 3e03c19f-3194-414e-1bfb-08d6ced51fe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49483D6129680FC27F86516BF6340@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(86362001)(3846002)(8676002)(478600001)(25786009)(186003)(6436002)(81156014)(26005)(71190400001)(71200400001)(102836004)(14454004)(6116002)(4326008)(53936002)(305945005)(7736002)(66066001)(36756003)(81166006)(50226002)(8936002)(6512007)(66556008)(64756008)(44832011)(316002)(54906003)(110136005)(99286004)(476003)(2616005)(66946007)(73956011)(486006)(68736007)(66476007)(66446008)(256004)(2906002)(6486002)(11346002)(446003)(5660300002)(52116002)(76176011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5EZ+dSshm9LmkNeSs+/Se1g8ZVlayCv0w55nRunFdiAwunDJOT+p1MZHil9/QWeynJwKJHpU4zvqW/rWLedH3qHoSrKwlIhQGiGu3jomEkRQ6/YlOML8Z3qSCdg0G/94/LlXREBluQfm81VNfmv2/ShYT5EWSBjDknfjfMSK/VP6xC+QbI0YNai2VXfVk9zozAK5oLO+L1TTNlK2z5gggCsLSaQGu0/SzLQcFsEKdxF3T55k5Q5us3SKt1MPuoxtq1Ea8GNZikcRRuaQrMMirUgiXM0h179bd7ZENixAWPxFHU6Xwb13wxHOfcpdrVqgPNdDjflaq/kjKVLwInxPtAnaDmGTL5ryf0mDt5FM+wYGW6WpXeraje0BsoIRSTT+c8EoNnecBHmjl+LBxbfszdavJpO34qTJ8HvKZQFwLhU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e03c19f-3194-414e-1bfb-08d6ced51fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:48.0187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBpbXhfY2xrX2dhdGVfZXhjbHVzaXZlIGZ1bmN0aW9uIHRvIGNsa19odyBiYXNl
ZCBBUEksIHJlbmFtZQ0KYWNjb3JkaW5nbHkgYW5kIGFkZCBhIG1hY3JvIGZvciBjbGsgYmFzZWQg
bGVnYWN5LiBUaGlzIGFsbG93cyB1cyB0byBtb3ZlDQpjbG9zZXIgdG8gYSBjbGVhciBzcGxpdCBi
ZXR3ZWVuIGNvbnN1bWVyIGFuZCBwcm92aWRlciBjbGsgQVBJcy4NCg0KU2lnbmVkLW9mZi1ieTog
QWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGst
Z2F0ZS1leGNsdXNpdmUuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tDQogZHJpdmVycy9jbGsvaW14
L2Nsay5oICAgICAgICAgICAgICAgIHwgIDUgKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9p
bXgvY2xrLWdhdGUtZXhjbHVzaXZlLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWdhdGUtZXhjbHVz
aXZlLmMNCmluZGV4IDNiZDlkZWUuLjdiZDlmMTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9p
bXgvY2xrLWdhdGUtZXhjbHVzaXZlLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstZ2F0ZS1l
eGNsdXNpdmUuYw0KQEAgLTU4LDEzICs1OCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19v
cHMgY2xrX2dhdGVfZXhjbHVzaXZlX29wcyA9IHsNCiAJLmlzX2VuYWJsZWQgPSBjbGtfZ2F0ZV9l
eGNsdXNpdmVfaXNfZW5hYmxlZCwNCiB9Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtfZ2F0ZV9l
eGNsdXNpdmUoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50LA0KK3N0cnVjdCBj
bGtfaHcgKmlteF9jbGtfaHdfZ2F0ZV9leGNsdXNpdmUoY29uc3QgY2hhciAqbmFtZSwgY29uc3Qg
Y2hhciAqcGFyZW50LA0KIAkgdm9pZCBfX2lvbWVtICpyZWcsIHU4IHNoaWZ0LCB1MzIgZXhjbHVz
aXZlX21hc2spDQogew0KIAlzdHJ1Y3QgY2xrX2dhdGVfZXhjbHVzaXZlICpleGdhdGU7DQogCXN0
cnVjdCBjbGtfZ2F0ZSAqZ2F0ZTsNCi0Jc3RydWN0IGNsayAqY2xrOw0KKwlzdHJ1Y3QgY2xrX2h3
ICpodzsNCiAJc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdDsNCisJaW50IHJldDsNCiANCiAJaWYg
KGV4Y2x1c2l2ZV9tYXNrID09IDApDQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCkBAIC04
Niw5ICs4NywxMyBAQCBzdHJ1Y3QgY2xrICppbXhfY2xrX2dhdGVfZXhjbHVzaXZlKGNvbnN0IGNo
YXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudCwNCiAJZ2F0ZS0+aHcuaW5pdCA9ICZpbml0Ow0K
IAlleGdhdGUtPmV4Y2x1c2l2ZV9tYXNrID0gZXhjbHVzaXZlX21hc2s7DQogDQotCWNsayA9IGNs
a19yZWdpc3RlcihOVUxMLCAmZ2F0ZS0+aHcpOw0KLQlpZiAoSVNfRVJSKGNsaykpDQotCQlrZnJl
ZShleGdhdGUpOw0KKwlodyA9ICZnYXRlLT5odzsNCiANCi0JcmV0dXJuIGNsazsNCisJcmV0ID0g
Y2xrX2h3X3JlZ2lzdGVyKE5VTEwsIGh3KTsNCisJaWYgKHJldCkgew0KKwkJa2ZyZWUoZ2F0ZSk7
DQorCQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KKwl9DQorDQorCXJldHVybiBodzsNCiB9DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5oIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQpp
bmRleCA4NmM5OWI0Li4xMzA0MzE1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay5o
DQorKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCkBAIC02OSw2ICs2OSw5IEBAIHN0cnVjdCBp
bXhfcGxsMTR4eF9jbGsgew0KICNkZWZpbmUgaW14X2Nsa19wZmQobmFtZSwgcGFyZW50X25hbWUs
IHJlZywgaWR4KSBcDQogCWlteF9jbGtfaHdfcGZkKG5hbWUsIHBhcmVudF9uYW1lLCByZWcsIGlk
eCktPmNsaw0KIA0KKyNkZWZpbmUgaW14X2Nsa19nYXRlX2V4Y2x1c2l2ZShuYW1lLCBwYXJlbnQs
IHJlZywgc2hpZnQsIGV4Y2x1c2l2ZV9tYXNrKSBcDQorCWlteF9jbGtfaHdfZ2F0ZV9leGNsdXNp
dmUobmFtZSwgcGFyZW50LCByZWcsIHNoaWZ0LCBleGNsdXNpdmVfbWFzayktPmNsaw0KKw0KIHN0
cnVjdCBjbGsgKmlteF9jbGtfcGxsMTR4eChjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICpw
YXJlbnRfbmFtZSwNCiAJCSB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IHN0cnVjdCBpbXhfcGxs
MTR4eF9jbGsgKnBsbF9jbGspOw0KIA0KQEAgLTEyMiw3ICsxMjUsNyBAQCBzdHJ1Y3QgY2xrX2h3
ICppbXhfb2J0YWluX2ZpeGVkX2Nsb2NrX2h3KA0KIHN0cnVjdCBjbGtfaHcgKmlteF9vYnRhaW5f
Zml4ZWRfY2xrX2h3KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQogCQkJCSAgICAgICBjb25zdCBj
aGFyICpuYW1lKTsNCiANCi1zdHJ1Y3QgY2xrICppbXhfY2xrX2dhdGVfZXhjbHVzaXZlKGNvbnN0
IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudCwNCitzdHJ1Y3QgY2xrX2h3ICppbXhfY2xr
X2h3X2dhdGVfZXhjbHVzaXZlKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudCwN
CiAJIHZvaWQgX19pb21lbSAqcmVnLCB1OCBzaGlmdCwgdTMyIGV4Y2x1c2l2ZV9tYXNrKTsNCiAN
CiBzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2h3X3BmZChjb25zdCBjaGFyICpuYW1lLCBjb25zdCBj
aGFyICpwYXJlbnRfbmFtZSwNCi0tIA0KMi43LjQNCg0K
