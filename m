Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33370C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AC420675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="blPGb/hA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfEBIGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:55 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:51954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfEBIGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ksu7ZH3fEYnTzgN4djwRseQACF6Ke1PM3tSgyHLRNsc=;
 b=blPGb/hAVvLZRGwTnw7creeudzPFWVyuHjDj47NBmyiV9/Mzhah4Av56HhfPJuDdIlqtps8R06ZfMeqdjmh56R5i3lH5jIz83RZddfiOb162xZFnLsY4iGos76Vv4Fb+mZHXv1xkJc0KGeToXMJDUKnjZhv9ftLiNPkJnTjHoQo=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.177.40.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Thu, 2 May 2019 08:06:47 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:47 +0000
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
Subject: [PATCH v2 08/18] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Topic: [PATCH v2 08/18] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Index: AQHVAL396xAjzLIjjE+l3n1d4NxiBg==
Date:   Thu, 2 May 2019 08:06:47 +0000
Message-ID: <1556784376-7191-9-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: dba862f9-2c36-4bb0-0352-08d6ced51f5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB4948BF40C9D4A53545E23AC3F6340@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(86362001)(3846002)(8676002)(478600001)(25786009)(186003)(6436002)(81156014)(26005)(71190400001)(71200400001)(102836004)(14454004)(6116002)(4326008)(53936002)(305945005)(7736002)(66066001)(36756003)(81166006)(50226002)(8936002)(6512007)(66556008)(64756008)(44832011)(316002)(54906003)(110136005)(99286004)(476003)(2616005)(66946007)(73956011)(486006)(68736007)(66476007)(66446008)(256004)(2906002)(6486002)(11346002)(446003)(5660300002)(52116002)(76176011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9l77cz/lXuE5WMyPQceROoxuIE5POh5bRIhy9yRzIW12vOrYznglLn7452xc+vdCCyAKw/8AveYEIBOZbsoc54wofZMT5e90JnX3ITBA9hvGqNLmUAA/+vFtsFvjcbv/695/BTamotLip7KbI90YvmHZvcNkfZ6VgONTbqxdy5sdcYgFoURsNJppUyKJ03g6omwf6SQoeXpN+Iw72Z3B6k8sPb8hi9NfRVvhz0iZqrBpCQhoAt0rPMdKTS4VHF/lRdbXTqP4/qsvVjLdIr0x2jnDlotied01EMSwXA5Edm02YGXsFgzyT6WPRubMS22jQtL2drtNJbxH3Xddv0UbXKNW6UKRDB+qHEgS4V6ngPU77KEbeHPMZcuJSDhIlEeR07F5i/Vk7lNY/zwm64urJ86B9yvgfZavM5aCWh4N7vs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba862f9-2c36-4bb0-0352-08d6ced51f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:47.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBpbXhfY2xrX3BmZCBmdW5jdGlvbiB0byBjbGtfaHcgYmFzZWQgQVBJLCByZW5h
bWUgYWNjb3JkaW5nbHkNCmFuZCBhZGQgYSBtYWNybyBmb3IgY2xrIGJhc2VkIGxlZ2FjeS4gVGhp
cyBhbGxvd3MgdXMgdG8gbW92ZSBjbG9zZXIgdG8NCmEgY2xlYXIgc3BsaXQgYmV0d2VlbiBjb25z
dW1lciBhbmQgcHJvdmlkZXIgY2xrIEFQSXMuDQoNClNpZ25lZC1vZmYtYnk6IEFiZWwgVmVzYSA8
YWJlbC52ZXNhQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLXBmZC5jIHwgMTQg
KysrKysrKysrLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLmggICAgIHwgIDUgKysrKy0NCiAy
IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLXBmZC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1w
ZmQuYw0KaW5kZXggMDRhM2U3OC4uM2I0M2QyOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2lt
eC9jbGstcGZkLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstcGZkLmMNCkBAIC0xMjcsMTIg
KzEyNywxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xrX3BmZF9vcHMgPSB7DQog
CS5pc19lbmFibGVkICAgICA9IGNsa19wZmRfaXNfZW5hYmxlZCwNCiB9Ow0KIA0KLXN0cnVjdCBj
bGsgKmlteF9jbGtfcGZkKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudF9uYW1l
LA0KK3N0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfcGZkKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0
IGNoYXIgKnBhcmVudF9uYW1lLA0KIAkJCXZvaWQgX19pb21lbSAqcmVnLCB1OCBpZHgpDQogew0K
IAlzdHJ1Y3QgY2xrX3BmZCAqcGZkOw0KLQlzdHJ1Y3QgY2xrICpjbGs7DQorCXN0cnVjdCBjbGtf
aHcgKmh3Ow0KIAlzdHJ1Y3QgY2xrX2luaXRfZGF0YSBpbml0Ow0KKwlpbnQgcmV0Ow0KIA0KIAlw
ZmQgPSBremFsbG9jKHNpemVvZigqcGZkKSwgR0ZQX0tFUk5FTCk7DQogCWlmICghcGZkKQ0KQEAg
LTE0OCwxMCArMTQ5LDEzIEBAIHN0cnVjdCBjbGsgKmlteF9jbGtfcGZkKGNvbnN0IGNoYXIgKm5h
bWUsIGNvbnN0IGNoYXIgKnBhcmVudF9uYW1lLA0KIAlpbml0Lm51bV9wYXJlbnRzID0gMTsNCiAN
CiAJcGZkLT5ody5pbml0ID0gJmluaXQ7DQorCWh3ID0gJnBmZC0+aHc7DQogDQotCWNsayA9IGNs
a19yZWdpc3RlcihOVUxMLCAmcGZkLT5odyk7DQotCWlmIChJU19FUlIoY2xrKSkNCisJcmV0ID0g
Y2xrX2h3X3JlZ2lzdGVyKE5VTEwsIGh3KTsNCisJaWYgKHJldCkgew0KIAkJa2ZyZWUocGZkKTsN
CisJCXJldHVybiBFUlJfUFRSKHJldCk7DQorCX0NCiANCi0JcmV0dXJuIGNsazsNCisJcmV0dXJu
IGh3Ow0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmggYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLmgNCmluZGV4IGEwNzljNzguLjg2Yzk5YjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2Nsay9pbXgvY2xrLmgNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuaA0KQEAgLTY2LDYgKzY2
LDkgQEAgc3RydWN0IGlteF9wbGwxNHh4X2NsayB7DQogI2RlZmluZSBpbXhfY2xrX3BsbHYzKHR5
cGUsIG5hbWUsIHBhcmVudF9uYW1lLCBiYXNlLCBkaXZfbWFzaykgXA0KIAlpbXhfY2xrX2h3X3Bs
bHYzKHR5cGUsIG5hbWUsIHBhcmVudF9uYW1lLCBiYXNlLCBkaXZfbWFzayktPmNsaw0KIA0KKyNk
ZWZpbmUgaW14X2Nsa19wZmQobmFtZSwgcGFyZW50X25hbWUsIHJlZywgaWR4KSBcDQorCWlteF9j
bGtfaHdfcGZkKG5hbWUsIHBhcmVudF9uYW1lLCByZWcsIGlkeCktPmNsaw0KKw0KIHN0cnVjdCBj
bGsgKmlteF9jbGtfcGxsMTR4eChjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICpwYXJlbnRf
bmFtZSwNCiAJCSB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0IHN0cnVjdCBpbXhfcGxsMTR4eF9j
bGsgKnBsbF9jbGspOw0KIA0KQEAgLTEyMiw3ICsxMjUsNyBAQCBzdHJ1Y3QgY2xrX2h3ICppbXhf
b2J0YWluX2ZpeGVkX2Nsa19odyhzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLA0KIHN0cnVjdCBjbGsg
KmlteF9jbGtfZ2F0ZV9leGNsdXNpdmUoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFy
ZW50LA0KIAkgdm9pZCBfX2lvbWVtICpyZWcsIHU4IHNoaWZ0LCB1MzIgZXhjbHVzaXZlX21hc2sp
Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtfcGZkKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNo
YXIgKnBhcmVudF9uYW1lLA0KK3N0cnVjdCBjbGtfaHcgKmlteF9jbGtfaHdfcGZkKGNvbnN0IGNo
YXIgKm5hbWUsIGNvbnN0IGNoYXIgKnBhcmVudF9uYW1lLA0KIAkJdm9pZCBfX2lvbWVtICpyZWcs
IHU4IGlkeCk7DQogDQogc3RydWN0IGNsa19odyAqaW14X2Nsa19wZmR2Mihjb25zdCBjaGFyICpu
YW1lLCBjb25zdCBjaGFyICpwYXJlbnRfbmFtZSwNCi0tIA0KMi43LjQNCg0K
