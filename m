Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C620748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sB34AhDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfL3JNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:13:07 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:20292
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbfL3JNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:13:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlZcT32CZOhIio6Udf/nhPyL6JNDDW2F3N2bX7gyXxyqq8vOIlC+umLV0l839N+jo/PlZOpgvLMZ0WoeIRoBy1OC6a/DPGJbUQloyOFFAZ1e2Wdqk49PrSobkRhYuu0o/Wip3NRBdqItfT5u5thRiEirAhYEjwTD3IQ4pSxq3P5CfcSWWx4NI//M/N+rbrrViXOC1ENunO1XcDzDGXjSHWMb22/Jqk6Lbn1kv2d+9yCkblXhQN7qHwx13MNM1Lank5VvLZvVOufhMeQ1sZzNX8lq8WYdMNqrA8uPhs6jGP/V94TAxXhlr1l7Yok/KyGzE42n463hc75kedOvCr4W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6timvOCqNBW7pWKbxH0IVkGh8pAkux6PZz/sd0Is/Kc=;
 b=dmONxn669rxF+V++bcztwbWfN62ahxF6dDHOS9an2h+qrs1x0MPhfYXgl5WxFMFtNtz1IBgiSrv0ze1HK0OiF/foQweoKEOHrA2loW4A4f4eGIlPu7OgYa0JtWx2VPGTVMQxvE5lz8g+KOasznhFIrCZWOUcjP4mA1aKLHOoLH+EqMruoTp1p/IRYVsGW83o0BUqFNc7EN3i56tvO2Lb/hTzFB1sgJfZl7h9HQ71RWggi8OgzobhITqRvVLmtUSVokfBDtcauTucnmdQ3GdTzRth+ypZwPXNogvVQb99Y5/CO8JYrCJ5FV21MKJ1+mH/29fOeIL4n6euNTMTXIoipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6timvOCqNBW7pWKbxH0IVkGh8pAkux6PZz/sd0Is/Kc=;
 b=sB34AhDUJODVICqRphmvZKAnC2hqHiRhvlLoniuhEd2hH+qcl5+PL8RTmpFuVRc6gEfI/k+a1IeDHNWC292MC5u+gNra46QbFLAhW2BdGaY1r5yKtk6nHvLfPOPacxXGXwoc1wYtVCIItnZMio/v+JovWRA/Wpd3qpImoeoakYo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 09:13:01 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 09:13:01 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.8 via Frontend Transport; Mon, 30 Dec 2019 09:12:56 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] clk: imx: pll14xx: avoid modify dram pll
Thread-Topic: [PATCH 1/3] clk: imx: pll14xx: avoid modify dram pll
Thread-Index: AQHVvvFVclUlXNz3QUm1xFZVDau/cw==
Date:   Mon, 30 Dec 2019 09:13:00 +0000
Message-ID: <1577696903-27870-2-git-send-email-peng.fan@nxp.com>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 733d5376-6d1f-41eb-8f1b-08d78d0877ef
x-ms-traffictypediagnostic: AM0PR04MB6401:|AM0PR04MB6401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6401C75B2D4EC3CE6EF06B6188270@AM0PR04MB6401.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:239;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(81156014)(6506007)(66946007)(69590400006)(71200400001)(66476007)(66556008)(8676002)(52116002)(4326008)(66446008)(64756008)(26005)(8936002)(2616005)(110136005)(6486002)(54906003)(6666004)(956004)(86362001)(6636002)(316002)(16526019)(186003)(478600001)(36756003)(5660300002)(2906002)(6512007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7SAEPIPVN/NdyO+upqHImZReacu7ShWOGuvzIRQ4m2CyGQ85IeiSqYnzX/9ymSliio1lXWR7e87C0qHo7lpSx9vJ6J6QVtWG8hHaIV1s+QeskcrN7G8WcjK1leJmJ7mpAboxeBqiWJ43rOv2oYiGV2wNdmHuz37DUejH5yazICRyNRgDVMQdTM5tN0L7hYjutiKZoJE7SbUhdmEVX9K8Ieu93snvDaiYF87gHXFZw2gBw8c1qv0ubmymGOecGyu9ZV7r16tmfuM542qlq6kmutS8jy2iQ40iLkSYukvCyAD4+yPMy6CNVV1K3Ku//GbG/LUhkGtEq+6RDSkarJn8bfUHaPze9+oSrS62CmrRaHWjtg4UFAXG3e/VoFV3F+yObTA8WeVII6PoVfODQhhsTMP4WOoBru4o2Q6nQTjFlAJ5DPVxUrIqfNVykyP2NtPmEY8h/HVigEgkSgAeRzGFCX+vn+MHE9v0EUwtFGrIXZ46FoxyU9nfosfE3dD7R7tT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d5376-6d1f-41eb-8f1b-08d78d0877ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 09:13:01.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McIAWQEtJgy6BZzlTK5mi2r/ZjHtTrv3br80yplq20Rf8yTBUEtK+ciqXHqszD8sC5joqlcTlTnd0V+aCVf3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dram pll is only expected to be modified in firmware,
so we should only support read clk frequency in Linux Kernel.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 5b0519a81a7a..9288b21d4d59 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -69,8 +69,6 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
=20
 struct imx_pll14xx_clk imx_1443x_dram_pll =3D {
 	.type =3D PLL_1443X,
-	.rate_table =3D imx_pll1443x_tbl,
-	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
 	.flags =3D CLK_GET_RATE_NOCACHE,
 };
=20
@@ -376,6 +374,10 @@ static const struct clk_ops clk_pll1443x_ops =3D {
 	.set_rate	=3D clk_pll1443x_set_rate,
 };
=20
+static const struct clk_ops clk_pll1443x_min_ops =3D {
+	.recalc_rate	=3D clk_pll1443x_recalc_rate,
+};
+
 struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_nam=
e,
 				  void __iomem *base,
 				  const struct imx_pll14xx_clk *pll_clk)
@@ -403,7 +405,10 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, co=
nst char *parent_name,
 			init.ops =3D &clk_pll1416x_ops;
 		break;
 	case PLL_1443X:
-		init.ops =3D &clk_pll1443x_ops;
+		if (!pll_clk->rate_table)
+			init.ops =3D &clk_pll1443x_min_ops;
+		else
+			init.ops =3D &clk_pll1443x_ops;
 		break;
 	default:
 		pr_err("%s: Unknown pll type for pll clk %s\n",
--=20
2.16.4

