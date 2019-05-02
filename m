Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A6AC04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647FE2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="koDk9LAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEBIGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:52 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:51954
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfEBIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCDjQmedB9SYM0/pZVMYtm6la6ohlKYezfSybV55Flw=;
 b=koDk9LAbkEd9n5w+hM72BOWpAE9DApG74zwdNvNat6rTBZ3WlQ4VyuOUp+fRHLi1YFc+6qplObPC3zsq0yxjdmRUFIa0N+0ovK+pPisSfddniAwdS8UwS0d7PcBFibEKxd2q1Dj93Qt6hdbST6LhE+cN4oa570Kf3+ph8jSnGCE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.177.40.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Thu, 2 May 2019 08:06:46 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:46 +0000
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
Subject: [PATCH v2 07/18] clk: imx: clk-pllv3: Switch to clk_hw based API
Thread-Topic: [PATCH v2 07/18] clk: imx: clk-pllv3: Switch to clk_hw based API
Thread-Index: AQHVAL38ZgBpbRDYiE+oHrJi/4JGcw==
Date:   Thu, 2 May 2019 08:06:46 +0000
Message-ID: <1556784376-7191-8-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 65c470aa-df7a-4641-4110-08d6ced51ed8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49487846F79E94D869A8427BF6340@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(136003)(189003)(199004)(86362001)(3846002)(8676002)(478600001)(25786009)(186003)(6436002)(81156014)(26005)(71190400001)(71200400001)(102836004)(14454004)(6116002)(4326008)(53936002)(305945005)(7736002)(66066001)(36756003)(81166006)(50226002)(8936002)(6512007)(66556008)(64756008)(44832011)(316002)(54906003)(110136005)(99286004)(14444005)(476003)(2616005)(66946007)(73956011)(486006)(68736007)(66476007)(66446008)(256004)(2906002)(6486002)(11346002)(446003)(5660300002)(52116002)(76176011)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z3UWTx24xnWkFdt8o4dJzLCSRMyzhS3xeP2jFsu7UTF7rLRlcUPgHi82bgvHNQDA/vBi8rEwJr8Ucv8Fs3C1qsXBWHbR/sPdQKWLw2xMAYi11r8+5nOvskNkFu6C08BgGD2zkIIzbl7sBuMR1cmDqUhP6lnAWrGrxY9hF0O9Nv0jTcKZDeZgJ7j1maN0JEob6yB5+S9oiaofii9oSVE1uh1787cktV1yqHLGu8xJO+Nzin5QGvsurBDdv+3vig0vHQrZJEJd2bbrdYR73aHBxhgUsamTHcfgMESgNtheWSZjuc0Szhwc5/HgOHBdTxlXqsVsTvkGTqnKdMc/uL2oJuePuMX9RlAdiQRGoGOCu3lipkS6YdFbnJPPmUj2d5mOnjAg5v8KyRu4V37jZTvnnT/iJAh7GSMn5h3YzBmZf24=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c470aa-df7a-4641-4110-08d6ced51ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:46.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3dpdGNoIHRoZSBpbXhfY2xrX2h3X3BsbHYzIGZ1bmN0aW9uIHRvIGNsa19odyBiYXNlZCBBUEks
IHJlbmFtZQ0KYWNjb3JkaW5nbHkgYW5kIGFkZCBhIG1hY3JvIGZvciBjbGsgYmFzZWQgbGVnYWN5
LiBUaGlzIGFsbG93cyB1cw0KdG8gbW92ZSBjbG9zZXIgdG8gYSBjbGVhciBzcGxpdCBiZXR3ZWVu
IGNvbnN1bWVyIGFuZCBwcm92aWRlciBjbGsNCkFQSXMuDQoNClNpZ25lZC1vZmYtYnk6IEFiZWwg
VmVzYSA8YWJlbC52ZXNhQG54cC5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLXBsbHYz
LmMgfCAxNCArKysrKysrKystLS0tLQ0KIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAgICAgICB8ICA1
ICsrKystDQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jIGIvZHJpdmVycy9j
bGsvaW14L2Nsay1wbGx2My5jDQppbmRleCBlODkyYjlhLi4wMjkyMDViIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jbGsvaW14L2Nsay1wbGx2My5jDQorKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLXBs
bHYzLmMNCkBAIC00MTYsMTQgKzQxNiwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNsa19vcHMg
Y2xrX3BsbHYzX2VuZXRfb3BzID0gew0KIAkucmVjYWxjX3JhdGUJPSBjbGtfcGxsdjNfZW5ldF9y
ZWNhbGNfcmF0ZSwNCiB9Ow0KIA0KLXN0cnVjdCBjbGsgKmlteF9jbGtfcGxsdjMoZW51bSBpbXhf
cGxsdjNfdHlwZSB0eXBlLCBjb25zdCBjaGFyICpuYW1lLA0KK3N0cnVjdCBjbGtfaHcgKmlteF9j
bGtfaHdfcGxsdjMoZW51bSBpbXhfcGxsdjNfdHlwZSB0eXBlLCBjb25zdCBjaGFyICpuYW1lLA0K
IAkJCSAgY29uc3QgY2hhciAqcGFyZW50X25hbWUsIHZvaWQgX19pb21lbSAqYmFzZSwNCiAJCQkg
IHUzMiBkaXZfbWFzaykNCiB7DQogCXN0cnVjdCBjbGtfcGxsdjMgKnBsbDsNCiAJY29uc3Qgc3Ry
dWN0IGNsa19vcHMgKm9wczsNCi0Jc3RydWN0IGNsayAqY2xrOw0KKwlzdHJ1Y3QgY2xrX2h3ICpo
dzsNCiAJc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdDsNCisJaW50IHJldDsNCiANCiAJcGxsID0g
a3phbGxvYyhzaXplb2YoKnBsbCksIEdGUF9LRVJORUwpOw0KIAlpZiAoIXBsbCkNCkBAIC00ODIs
MTAgKzQ4MywxMyBAQCBzdHJ1Y3QgY2xrICppbXhfY2xrX3BsbHYzKGVudW0gaW14X3BsbHYzX3R5
cGUgdHlwZSwgY29uc3QgY2hhciAqbmFtZSwNCiAJaW5pdC5udW1fcGFyZW50cyA9IDE7DQogDQog
CXBsbC0+aHcuaW5pdCA9ICZpbml0Ow0KKwlodyA9ICZwbGwtPmh3Ow0KIA0KLQljbGsgPSBjbGtf
cmVnaXN0ZXIoTlVMTCwgJnBsbC0+aHcpOw0KLQlpZiAoSVNfRVJSKGNsaykpDQorCXJldCA9IGNs
a19od19yZWdpc3RlcihOVUxMLCBodyk7DQorCWlmIChyZXQpIHsNCiAJCWtmcmVlKHBsbCk7DQor
CQlyZXR1cm4gRVJSX1BUUihyZXQpOw0KKwl9DQogDQotCXJldHVybiBjbGs7DQorCXJldHVybiBo
dzsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5oIGIvZHJpdmVycy9jbGsv
aW14L2Nsay5oDQppbmRleCBjODE5Y2UxNS4uYTA3OWM3OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y2xrL2lteC9jbGsuaA0KKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQpAQCAtNjMsNiArNjMs
OSBAQCBzdHJ1Y3QgaW14X3BsbDE0eHhfY2xrIHsNCiAJY2xrX2h3X3JlZ2lzdGVyX2dhdGUyKGRl
diwgbmFtZSwgcGFyZW50X25hbWUsIGZsYWdzLCByZWcsIGJpdF9pZHgsIFwNCiAJCQkJY2dyX3Zh
bCwgY2xrX2dhdGVfZmxhZ3MsIGxvY2ssIHNoYXJlX2NvdW50KS0+Y2xrDQogDQorI2RlZmluZSBp
bXhfY2xrX3BsbHYzKHR5cGUsIG5hbWUsIHBhcmVudF9uYW1lLCBiYXNlLCBkaXZfbWFzaykgXA0K
KwlpbXhfY2xrX2h3X3BsbHYzKHR5cGUsIG5hbWUsIHBhcmVudF9uYW1lLCBiYXNlLCBkaXZfbWFz
ayktPmNsaw0KKw0KIHN0cnVjdCBjbGsgKmlteF9jbGtfcGxsMTR4eChjb25zdCBjaGFyICpuYW1l
LCBjb25zdCBjaGFyICpwYXJlbnRfbmFtZSwNCiAJCSB2b2lkIF9faW9tZW0gKmJhc2UsIGNvbnN0
IHN0cnVjdCBpbXhfcGxsMTR4eF9jbGsgKnBsbF9jbGspOw0KIA0KQEAgLTk1LDcgKzk4LDcgQEAg
ZW51bSBpbXhfcGxsdjNfdHlwZSB7DQogCUlNWF9QTExWM19BVl9JTVg3LA0KIH07DQogDQotc3Ry
dWN0IGNsayAqaW14X2Nsa19wbGx2MyhlbnVtIGlteF9wbGx2M190eXBlIHR5cGUsIGNvbnN0IGNo
YXIgKm5hbWUsDQorc3RydWN0IGNsa19odyAqaW14X2Nsa19od19wbGx2MyhlbnVtIGlteF9wbGx2
M190eXBlIHR5cGUsIGNvbnN0IGNoYXIgKm5hbWUsDQogCQljb25zdCBjaGFyICpwYXJlbnRfbmFt
ZSwgdm9pZCBfX2lvbWVtICpiYXNlLCB1MzIgZGl2X21hc2spOw0KIA0KIHN0cnVjdCBjbGtfaHcg
KmlteF9jbGtfcGxsdjQoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqcGFyZW50X25hbWUs
DQotLSANCjIuNy40DQoNCg==
