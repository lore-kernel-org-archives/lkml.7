Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D24EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D1A23401
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="smgT8UJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfHWAhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:37:41 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:3822
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731932AbfHWAhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:37:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM/+w6EZb7azJ2dPYo2qefegLdhYd9rhyN/u5Rmd5xij+31pFVqy+01dW6p1MMIiuaIiuqSeSJPgNMVL9bQumGGSngjUQCSDgwamCd6+Z8yo4pPKmPvUm/YWHhEihsQEh2KewpdgSQrfHdhNqE/EYxHYi+kn6sM2HVgKIDaWxsldoGUeU6SKTSgaqYx9PplougclVTgbRmiZNBSLvF34d3jOBvllwOZGF/SvXXE0ke2OXJ1VMF/bYiLoeYZCGitfx9ZWTh8dBf95OL8N6bdZDEUvhb6heHTzEQ4prIrdp57vVaxX5xjc4NOUOr7JeBKl+5up/6y9eqBDRiwKtvui1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFHoVRyshSnuwD7ZrWTFrVyea3LTERa6XZf17qufvV4=;
 b=lHF6t2pXI0s8rxDK6vbZZE9GhU9e8t//vnvJ0awjIAWFjPmvq60yMxV68ZHhXwWVHHxS/jHaIMWpuYNpHIeO/LnFG2dRQMj9mObDSIStEr38YZ+HfNhul7JLQl0JNCjHVbnaYzIoYYTJCG0QV1p2t1i4ZzVNdzb8J7Eu3+ZNWnq+Gzl7q0oTHT+Vhn5EQg8FRUsH6ct+c3+6A4AU7pJyYXJaG0Gdfxrr/qFq8rqKFhR7QsX45QAjCtPcVqLwz5SSNE0+REnij2OPMZp+9fomVhSF/c488gQ5h3FyX5M3aORLjLz26F263nSnrJFqnPdir+odSJx81uadV59wJrejmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFHoVRyshSnuwD7ZrWTFrVyea3LTERa6XZf17qufvV4=;
 b=smgT8UJXSm1Haidzm6iqOokZMiHICPhkD0gIGYg/F4RUNFD2ajvJeb24AsLL3v2Blf3bqUnD83Yi8HyZ2ap50v7V+/YL71xUQUsz09x8d0RlpWt7zbNSztycQxc3/iuWcCVxxt9k64Q2vcKan0nab2Ub00ZRMJ2DMlOVsW5nalI=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB4662.eurprd04.prod.outlook.com (20.177.38.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 00:37:35 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::559a:24e4:40bb:faed]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::559a:24e4:40bb:faed%7]) with mapi id 15.20.2178.018; Fri, 23 Aug 2019
 00:37:35 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     LnxRevLi <LnxRevLi@nxp.com>, Jana Build <jana.build@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
Thread-Topic: [PATCH 2/2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
Thread-Index: AQHVWUr1au1vBfNheEmiNgH4/hdPdQ==
Date:   Fri, 23 Aug 2019 00:37:35 +0000
Message-ID: <20190823003600.8317-2-chen.fang@nxp.com>
References: <20190823003600.8317-1-chen.fang@nxp.com>
In-Reply-To: <20190823003600.8317-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16944f96-2e01-4d7e-cb81-08d727621781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB4662;
x-ms-traffictypediagnostic: AM6PR04MB4662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4662463B1A55BF3C3B374C2CF3A40@AM6PR04MB4662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(2906002)(2616005)(256004)(476003)(71190400001)(71200400001)(446003)(53936002)(36756003)(11346002)(2501003)(186003)(6116002)(64756008)(6506007)(3846002)(486006)(5660300002)(66446008)(386003)(66556008)(25786009)(76176011)(66946007)(26005)(52116002)(102836004)(4326008)(1076003)(66066001)(8936002)(305945005)(8676002)(81156014)(81166006)(66476007)(99286004)(50226002)(7736002)(14454004)(2201001)(316002)(478600001)(54906003)(86362001)(110136005)(6486002)(6436002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4662;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sHSR6V5VsMU6DuH49pTCjAO7wmed1zQ3fcDreDo2QPfRFiEIDNoaDl4c53k8eAtPHOjvxO9zQJY09r6mtVgKEGMsPIohs4pRbuIGetloGIzBjXdBtGOc429Y8Eip9lI1I8V316kEsTXnSiQlXQJmeRQIG3y9oOv2LSeMkl5FhDAidv8ov1zOzITpYXNmDY7jT7c3cocpZ8EUIXHOg5EsnpE2l7PkOGDyzYgwLEkt7i9QMZcKI8vCs2TR1j5FnwxxXnzPcHNas5IbHjK9B4sM9+tfWT0Vj7+67eHySb4VmRxCfCkeHw9ly6cW2e6Pu+AMJqrfXnV/B1t1GgEJ4m2s1y8CEwu9iKGFI43FZrZaFBvJRbEI3gRlac6XldVt0COnOhZHCBnFf8d4cYIB+jq9Cp/+7LjBYZOIEPFiYH/Bq48=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16944f96-2e01-4d7e-cb81-08d727621781
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 00:37:35.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is0VbZygNncpMtBVroGxIK65lBIOHD4AovfIHhwGMbQXsN4//HUzJnV09dsLtTj+gjGV6/T0RtiOjZk76zTYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mipi pll clock comes from the MIPI PHY PLL output, so
it should not be a fixed clock.

MIPI PHY PLL is in the MIPI DSI space, and it is used as
the bit clock for transferring the pixel data out and its
output clock is configured according to the display mode.

So it should be used only for MIPI DSI and not be exported
out for other usages.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt   |  1 -
 drivers/clk/imx/clk-imx7ulp.c                     |  3 +--
 include/dt-bindings/clock/imx7ulp-clock.h         | 15 +++++++--------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Do=
cumentation/devicetree/bindings/clock/imx7ulp-clock.txt
index a4f8cd478f92..93d89adb7afe 100644
--- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -82,7 +82,6 @@ pcc2: pcc2@403f0000 {
 		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
 		 <&scg1 IMX7ULP_CLK_UPLL>,
 		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
 		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
 		 <&scg1 IMX7ULP_CLK_ROSC>,
 		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 2022d9bead91..459b120b71d5 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -28,7 +28,7 @@ static const char * const scs_sels[]		=3D { "dummy", "sos=
c", "sirc", "firc", "dumm
 static const char * const ddr_sels[]		=3D { "apll_pfd_sel", "upll", };
 static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
 static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_clk"=
, "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
-static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk"=
, };
+static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk=
", };
 static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy", "=
hsrun_divcore", };
=20
 /* used by sosc/sirc/firc/ddr/spll/apll dividers */
@@ -75,7 +75,6 @@ static void __init imx7ulp_clk_scg1_init(struct device_no=
de *np)
 	clks[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
 	clks[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
 	clks[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
-	clks[IMX7ULP_CLK_MIPI_PLL]	=3D imx_obtain_fixed_clk_hw(np, "mpll");
 	clks[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
=20
 	/* SCG1 */
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-binding=
s/clock/imx7ulp-clock.h
index 6f66f9005c81..f8d34fb4378f 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -49,15 +49,14 @@
 #define IMX7ULP_CLK_NIC1_DIV		36
 #define IMX7ULP_CLK_NIC1_BUS_DIV	37
 #define IMX7ULP_CLK_NIC1_EXT_DIV	38
-#define IMX7ULP_CLK_MIPI_PLL		39
-#define IMX7ULP_CLK_SIRC		40
-#define IMX7ULP_CLK_SOSC_BUS_CLK	41
-#define IMX7ULP_CLK_FIRC_BUS_CLK	42
-#define IMX7ULP_CLK_SPLL_BUS_CLK	43
-#define IMX7ULP_CLK_HSRUN_SYS_SEL	44
-#define IMX7ULP_CLK_HSRUN_CORE_DIV	45
+#define IMX7ULP_CLK_SIRC		39
+#define IMX7ULP_CLK_SOSC_BUS_CLK	40
+#define IMX7ULP_CLK_FIRC_BUS_CLK	41
+#define IMX7ULP_CLK_SPLL_BUS_CLK	42
+#define IMX7ULP_CLK_HSRUN_SYS_SEL	43
+#define IMX7ULP_CLK_HSRUN_CORE_DIV	44
=20
-#define IMX7ULP_CLK_SCG1_END		46
+#define IMX7ULP_CLK_SCG1_END		45
=20
 /* PCC2 */
 #define IMX7ULP_CLK_DMA1		0
--=20
2.17.1

