Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C96C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC63233FD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 00:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cX0cjjJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfHWAhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:37:36 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:15841
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731932AbfHWAhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:37:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9v6AO9T6codJWXFLrLCx/w22zjsYHHA2o/iR7JRybJiGHiUksnluXtK3x6JABSQaIdBZQnzy79rkCjDguqxekymGhLiPizeub3Ypym4Wn/ZFKytZR5wsd8M/vhHjcr3NDyif+CuyYrZ1BeKrIQ4fw/Vs5o6a4Cv4t5KtTJb9VK7TIxMBmiBN35+SKrOUn72K9MawjoFncGhr7X4AhpLXC1Wo+gKax5ty3yXhCYpyazA9XdYeZbHglVoXeb4rH3OvIl51+m/PlKRkZNJVvvpB4Zlnm/1PSaCWA8G2tAlFFC+ItB/MDoXaIL+FN2xR42DJ7Pr59b/M3mVe28IY/I7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYVZrKQAGhh8etw/MzE10Scz2iXH0tfLC8zHP3R/PPk=;
 b=a39Ca4gpAH62fYAQ+B9U6Hxeii///8fiSwkjrQTdQRa5o+m4ovDRexX+0ZDgze3qwKGecYSFJogUFVyeNLzAJtwqKnCfll/Y/C4m6YsW8Hz5U+TeK15zByldg55gWfpmLtJ4ajzCCk8danMT2Vz0ntQTB1IELCC83OdopG6W4PqSczJdKtH1n1BZd+JLStGHLLvmKwSGicmgrGDQagHkNqtfVgd61N8m1tkP4KuKuSrsP0pXvHmuQLDF9/aTATKvWYMB1dsc4gVJj1bYi3Kr1ZpJs4Yx28z0mIGh9C4W9wkiD4TauY0bmwC07FZrRRsTbGOMoKhJ+dv0JzYnQZTDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYVZrKQAGhh8etw/MzE10Scz2iXH0tfLC8zHP3R/PPk=;
 b=cX0cjjJVsQ8ZEQVBObw/cTetx+zh+TPY4iM0akfcrLiyvMnUubgeIJv/bWQudugdm0CGP+T1qUazfMcBCz43cq20jwnr8Q1nvTmY2ENRgP8TZ5pXRKeedeUgtSwbVMMha6WrxgD5I9YAjQW2aKw6Q5H1H09G3UAFSf82CsrqYxI=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB4662.eurprd04.prod.outlook.com (20.177.38.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 00:37:30 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::559a:24e4:40bb:faed]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::559a:24e4:40bb:faed%7]) with mapi id 15.20.2178.018; Fri, 23 Aug 2019
 00:37:30 +0000
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
Subject: [PATCH 1/2] ARM: dts: imx7ulp: remove mipi pll clock node
Thread-Topic: [PATCH 1/2] ARM: dts: imx7ulp: remove mipi pll clock node
Thread-Index: AQHVWUryVFTPKJmy3EOKbGcFK1cgTg==
Date:   Fri, 23 Aug 2019 00:37:30 +0000
Message-ID: <20190823003600.8317-1-chen.fang@nxp.com>
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
x-ms-office365-filtering-correlation-id: e8e10589-77ef-4d83-c1de-08d7276214b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB4662;
x-ms-traffictypediagnostic: AM6PR04MB4662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4662825A18C8E97BD5A10275F3A40@AM6PR04MB4662.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(2906002)(2616005)(256004)(476003)(71190400001)(71200400001)(53936002)(36756003)(2501003)(186003)(6116002)(64756008)(6506007)(3846002)(486006)(5660300002)(66446008)(386003)(66556008)(25786009)(66946007)(26005)(52116002)(102836004)(4326008)(1076003)(66066001)(8936002)(305945005)(8676002)(81156014)(81166006)(66476007)(99286004)(50226002)(7736002)(14454004)(2201001)(316002)(478600001)(54906003)(86362001)(110136005)(6486002)(6436002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4662;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XFgg5UvXbtZz1aVxGLtFYKY3tyEYMWSEKAhf39V+ozuNHU2TF+skaXhEyRrtA8apZyB0XzpJwnfIZZ5N61suC+rUg/+B89l9m3N72OJ2XaUdC+A5Xs7mqI2rONA6C93QCREN2gW8Xmn0iYUXMx1Fi3pGlabwQTCY6vdLgNZjH32ohEyXKwJCqiCE0HirIOB/Q69r24z8gR7NgbrlQoVXuRhSxbDMA1Ajd5rUN2XRLJStR0fiKhQDGAEbnlnpuV6M0CZzTf4apshZ/T45cJQqx2qtkbt6g8jHnxQyy+DqeBjhBFBqv+43AEun3d8TePMX7p5beW539veQxK+bf2OFNP5XD9mJepmuJObYoSocsGhMiOcquT9Bi3J/FeToBt9HPlo4GnRIzKjRPVVYzYDdLqFr03KDeNX1xfsK9FRaCpk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e10589-77ef-4d83-c1de-08d7276214b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 00:37:30.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qivMkwhUJNyIAoxjc/G1R0tiyJdiLoB0aJC1GkeeMMWOzj0lJZB7IVz/DR5A71AKdoASJn54eAY9m3OeehvPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the IMX7ULP reference manual, the mipi pll
clock comes from the MIPI PHY PLL output. So it should
not be defined as a fixed clock. So remove this clock
node and all the references to it.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index 6859a3a83750..a7e4004bf428 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -87,13 +87,6 @@
 		#clock-cells =3D <0>;
 	};
=20
-	mpll: clock-mpll {
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <480000000>;
-		clock-output-names =3D "mpll";
-		#clock-cells =3D <0>;
-	};
-
 	ahbbridge0: bus@40000000 {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -258,9 +251,9 @@
 			compatible =3D "fsl,imx7ulp-scg1";
 			reg =3D <0x403e0000 0x10000>;
 			clocks =3D <&rosc>, <&sosc>, <&sirc>,
-				 <&firc>, <&upll>, <&mpll>;
+				 <&firc>, <&upll>;
 			clock-names =3D "rosc", "sosc", "sirc",
-				      "firc", "upll", "mpll";
+				      "firc", "upll";
 			#clock-cells =3D <1>;
 		};
=20
@@ -276,13 +269,12 @@
 				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
 				 <&scg1 IMX7ULP_CLK_UPLL>,
 				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
 				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
 				 <&scg1 IMX7ULP_CLK_ROSC>,
 				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
 			clock-names =3D "nic1_bus_clk", "nic1_clk", "ddr_clk",
 				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk", "mpll",
+				      "upll", "sosc_bus_clk",
 				      "firc_bus_clk", "rosc", "spll_bus_clk";
 			assigned-clocks =3D <&pcc2 IMX7ULP_CLK_LPTPM5>;
 			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
@@ -309,13 +301,12 @@
 				 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
 				 <&scg1 IMX7ULP_CLK_UPLL>,
 				 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
-				 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
 				 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
 				 <&scg1 IMX7ULP_CLK_ROSC>,
 				 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
 			clock-names =3D "nic1_bus_clk", "nic1_clk", "ddr_clk",
 				      "apll_pfd2", "apll_pfd1", "apll_pfd0",
-				      "upll", "sosc_bus_clk", "mpll",
+				      "upll", "sosc_bus_clk",
 				      "firc_bus_clk", "rosc", "spll_bus_clk";
 		};
 	};
--=20
2.17.1

