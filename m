Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89516C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE82089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pvs4DWpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEBIGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:06:44 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:42560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbfEBIGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+G2fFdlFEFiJ4IZnh1ZB+CjmaTHkWA3pQf3+2OBMxY=;
 b=pvs4DWpkaDt2w2VcgRni2Y1hNIyTnNZx+9xHjywoQvlmWa4GDBazGtoCT8/lQwv6EZX2frlQ/qorJYe8MMxSJShkDNDyEJ2xWDICJCjAAjxp2JoBWOJRpCcIjqENb7WrNXzIPDIl4NIZ+Wpb8+N6tpZ2bc8Kehzi3i+cRKfY2rM=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4563.eurprd04.prod.outlook.com (52.135.144.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Thu, 2 May 2019 08:06:39 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 08:06:39 +0000
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
Subject: [PATCH v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw based
 API
Thread-Topic: [PATCH v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw
 based API
Thread-Index: AQHVAL3494CVXW2TMka+Gnk5oj+AAw==
Date:   Thu, 2 May 2019 08:06:39 +0000
Message-ID: <1556784376-7191-1-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: e4776059-c9b9-4aaa-3236-08d6ced51aca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4563;
x-ms-traffictypediagnostic: AM0PR04MB4563:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB4563576F0F9215BA31DB1BA2F6340@AM0PR04MB4563.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(53936002)(66476007)(66556008)(64756008)(66946007)(73956011)(66446008)(66066001)(6116002)(36756003)(3846002)(305945005)(86362001)(6486002)(81156014)(6512007)(81166006)(25786009)(8676002)(4326008)(6306002)(71200400001)(71190400001)(99286004)(8936002)(14454004)(966005)(50226002)(2616005)(68736007)(478600001)(386003)(2906002)(6506007)(52116002)(316002)(44832011)(54906003)(110136005)(26005)(7736002)(5660300002)(256004)(102836004)(186003)(486006)(476003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4563;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +TPL3UHN7gJsI7USvMkPT4x17/WxXnsmInWgKz6r3y5GbdEd1qz+3BdL+wV8vLOscLcYlbPeDe6Mbrpa9jFeuqMbRKQ9BkV0NoM/6RN3nhIpe8YYuViitClo1OsynRko2/DLBjna9p44Yd6cvd3O6Yc82X9zZ0ykfuTou4tSBPMvW4Q+0moLvxoYpTiy6UXnCIP5D1sFRq7d++WG8SiJ79Llb8vOxtlExGy4g1PthgJ0EvffZs56Q78h8IU/tVRU3aFm8VVID69KVD3yhpiWNYY5Ft2Dhn1mf26WxOo9YMEpdRElh4OzZLRn1LNy0UTSwEMLKwuE/6+8T8GMVRmLpU8b8hqDPGdf1Nyl77qLjXMrA2X5b7L6OHoOwn/5xL1CU4rOuLlJ1SeRuFzRnAOGq77Q6vVJ/s2wSq3DBtP++ag=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4776059-c9b9-4aaa-3236-08d6ced51aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:06:39.5786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBiYXNpY2FsbHkgYSAybmQgdmVyc2lvbiBmb3IgdGhpcyBSRkM6DQoNCmh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE5LzMvMjIvMTc3Mg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KICogQWRk
ZWQgdGhlIHJlYXNvbiBmb3IgdGhpcyB3b3JrIGluIGVhY2ggY29tbWl0IG1lc3NhZ2UNCiAqIEFk
ZGVkIGNsa19odyBiYXNlZCBpbml0aWFsaXphdGlvbiBmb3IgdWFydF9jbGtzIGluIGlteDZzbGwg
ZHJpdmVyDQoNCkFiZWwgVmVzYSAoMTgpOg0KICBjbGs6IGlteDogQWRkIGlteF9vYnRhaW5fZml4
ZWRfY2xvY2sgY2xrX2h3IGJhc2VkIHZhcmlhbnQNCiAgY2xrOiBpbXg2c3g6IERvIG5vdCByZXBh
cmVudCB0byB1bnJlZ2lzdGVyZWQgSU1YNlNYX0NMS19BWEkNCiAgY2xrOiBpbXg2cTogRG8gbm90
IHJlcGFyZW50IHVuaW5pdGlhbGl6ZWQgSU1YNlFETF9DTEtfUEVSSVBIMiBjbG9jaw0KICBjbGs6
IGlteDogY2xrLWJ1c3k6IFN3aXRjaCB0byBjbGtfaHcgYmFzZWQgQVBJDQogIGNsazogaW14OiBj
bGstY3B1OiBTd2l0Y2ggdG8gY2xrX2h3IGJhc2VkIEFQSQ0KICBjbGs6IGlteDogY2xrLWdhdGUy
OiBTd2l0Y2ggdG8gY2xrX2h3IGJhc2VkIEFQSQ0KICBjbGs6IGlteDogY2xrLXBsbHYzOiBTd2l0
Y2ggdG8gY2xrX2h3IGJhc2VkIEFQSQ0KICBjbGs6IGlteDogY2xrLXBmZDogU3dpdGNoIHRvIGNs
a19odyBiYXNlZCBBUEkNCiAgY2xrOiBpbXg6IGNsay1nYXRlLWV4Y2x1c2l2ZTogU3dpdGNoIHRv
IGNsa19odyBiYXNlZCBBUEkNCiAgY2xrOiBpbXg6IGNsay1maXh1cC1kaXY6IFN3aXRjaCB0byBj
bGtfaHcgYmFzZWQgQVBJDQogIGNsazogaW14OiBjbGstZml4dXAtbXV4OiBTd2l0Y2ggdG8gY2xr
X2h3IGJhc2VkIEFQSQ0KICBjbGs6IGlteDogU3dpdGNoIHdyYXBwZXJzIHRvIGNsa19odyBiYXNl
ZCBBUEkNCiAgY2xrOiBpbXg2cTogU3dpdGNoIHRvIGNsa19odyBiYXNlZCBBUEkNCiAgY2xrOiBp
bXg2c2w6IFN3aXRjaCB0byBjbGtfaHcgYmFzZWQgQVBJDQogIGNsazogaW14NnN4OiBTd2l0Y2gg
dG8gY2xrX2h3IGJhc2VkIEFQSQ0KICBjbGs6IGlteDZ1bDogU3dpdGNoIHRvIGNsa19odyBiYXNl
ZCBBUEkNCiAgY2xrOiBpbXg3ZDogU3dpdGNoIHRvIGNsa19odyBiYXNlZCBBUEkNCiAgY2xrOiBp
bXg2c2xsOiBTd2l0Y2ggdG8gY2xrX2h3IGJhc2VkIEFQSQ0KDQogZHJpdmVycy9jbGsvaW14L2Ns
ay1idXN5LmMgICAgICAgICAgIHwgIDMwICstDQogZHJpdmVycy9jbGsvaW14L2Nsay1jcHUuYyAg
ICAgICAgICAgIHwgIDE0ICstDQogZHJpdmVycy9jbGsvaW14L2Nsay1maXh1cC1kaXYuYyAgICAg
IHwgIDE1ICstDQogZHJpdmVycy9jbGsvaW14L2Nsay1maXh1cC1tdXguYyAgICAgIHwgIDE1ICst
DQogZHJpdmVycy9jbGsvaW14L2Nsay1nYXRlLWV4Y2x1c2l2ZS5jIHwgIDE3ICstDQogZHJpdmVy
cy9jbGsvaW14L2Nsay1nYXRlMi5jICAgICAgICAgIHwgIDE0ICstDQogZHJpdmVycy9jbGsvaW14
L2Nsay1pbXg2cS5jICAgICAgICAgIHwgNzY3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0K
IGRyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsLmMgICAgICAgICB8IDQwNCArKysrKysrLS0tLS0t
LQ0KIGRyaXZlcnMvY2xrL2lteC9jbGstaW14NnNsbC5jICAgICAgICB8IDQzMCArKysrKysrLS0t
LS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZzeC5jICAgICAgICAgfCA2NTYgKysrKysr
KysrKystLS0tLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDZ1bC5jICAgICAgICAg
fCA1NzQgKysrKysrKysrKy0tLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDdkLmMg
ICAgICAgICAgfCA5ODMgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiBkcml2
ZXJzL2Nsay9pbXgvY2xrLXBmZC5jICAgICAgICAgICAgfCAgMTQgKy0NCiBkcml2ZXJzL2Nsay9p
bXgvY2xrLXBsbHYzLmMgICAgICAgICAgfCAgMTQgKy0NCiBkcml2ZXJzL2Nsay9pbXgvY2xrLmMg
ICAgICAgICAgICAgICAgfCAgMTEgKw0KIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAgICAgICAgICAg
ICAgICB8IDE0MiArKystLQ0KIDE2IGZpbGVzIGNoYW5nZWQsIDIxNTEgaW5zZXJ0aW9ucygrKSwg
MTk0OSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjcuNA0KDQo=
