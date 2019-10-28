Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD7CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA320862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bTvCIUIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfJ1IID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:08:03 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:18275
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731255AbfJ1IID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jO1xwITKwVHXDCSePT9h932lJB+LUQ2wGUSzXGKswaVN1qpUy4iIwEJAoTLuUujiGVF6yRZwxTEi3a7QMiWsV3HwBPOdjlne0B7gsKM62YkOiDbeGXX0OLlN/hwj2gxWXvbWqYcVOxzHhhLRHeo7iqZZ7SEHcjMNk9atrBmOkf2KJZNpFX5Yd+4hz+JnHL2mSeigsyxS0hhKiRxahfbjtOFSxBYseubNuuAtQXphGymhuOPlz6rV4fkEvMXOhsaLTdu8vztnZ+Q8isvfnk3dahEfkZ/cjapAygu/mdbC+fgHWNOecilj05NBos4PB6jryph6Wn/yhtK0+nuyrgTfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnnxiX0aappY7H3cw9R28vok40npa2IhbBR7c2x6Sg=;
 b=YhXhwCDGFc8lQe31ce1b1tu/0JaVWF6DPXoq8BMBRpoZm88GdTrgjSfH8jJEcKh4gl8dYByKvmx30FJBN58JkAyXmhcPAEwHnLKKX5r0u7sa42lHJ8GmsiKIqaVI+45ahMciHK/ojLklGgKgmD8ek9xKfcPJ8DX9NOy1pVFdn4kWovDti/kqML44TJ6jPR9E2O3LJT3iMfOmQyQzfavS9IjKcvLWvg/zN3C/fn+8ywIPjF2J+Ek9w/YAZhZ1gfjd+/Wyb3EWXbSSWAY3GTY5l1oBc5PiWLHXKkgZk8UKWjrg3q8td4ayTRGA4Bvp9UWVgxkWlJev1MWB648mGqtqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnnxiX0aappY7H3cw9R28vok40npa2IhbBR7c2x6Sg=;
 b=bTvCIUIqkFCqLfsOvbiSHe2sbNleSF6wjuArTV5wbwzVENHSpbqiJpvt7SKBWdhCuNqGzDEoOTUOzEFca4MkXG1oHb068icuBw0t5v3lld68dpe4OWzvpmkIm62JMwoaDTwyXq7kbIyIhyBQTozqtAinZBf3Um1QxtUUZtjMXi4=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB3989.eurprd04.prod.outlook.com (52.135.161.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Mon, 28 Oct 2019 08:07:59 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0%7]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 08:07:59 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL clock
Thread-Topic: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Index: AQHVjWbPxL+wRlx07k+0T7BaUjsAXA==
Date:   Mon, 28 Oct 2019 08:07:59 +0000
Message-ID: <20191028080545.28275-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK0PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::22) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 397b82d1-6384-40a4-2cac-08d75b7df230
x-ms-traffictypediagnostic: AM6PR04MB3989:|AM6PR04MB3989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB3989EB3C653DF59CE5EC5BBEF3660@AM6PR04MB3989.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(54534003)(25786009)(1076003)(5660300002)(6916009)(2906002)(316002)(478600001)(476003)(186003)(2616005)(36756003)(256004)(99286004)(52116002)(86362001)(81166006)(81156014)(1730700003)(8676002)(66066001)(54906003)(6436002)(2501003)(5640700003)(66556008)(4326008)(50226002)(66476007)(66946007)(64756008)(66446008)(7736002)(3846002)(6116002)(386003)(6506007)(102836004)(71200400001)(486006)(71190400001)(2351001)(26005)(6486002)(14454004)(8936002)(305945005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3989;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4Z3BJ2NyFwpdArCFOc64zvPVghJ0utAUwL8b/w6CYv1XimkGiMi/WdCef7JUh9pGjLKr92VwhKBLq8cHElPykkweN42/m9gczDx1VQto776pQiwEzPjz2fFGftbp8gsN7EnA4BJsI9YgLcV/KCA88nyymUMfxRIi+UG5E/OdOdaBv3jBd0l8W4YV8+eI9e0oVmqXRan2mwnlYeqkHv8yZDJc4XFcDZ1V6rXwHm8N3CaxIG1Kv5tbFaNGtcY1PM18enB64W9f4lIEcUXGR8KEkF0ixu3nwRuxRsba4HA6FkN8QwQUIEdc0tgvFHW1lKHf4ESoJ6a/0e9qRaEJgQc5blwsDZUAkUdOO1pvYLMpFXdN7Rmmvy3Df20Y3wc2R4om7009l5bFJ8+bT6gPGAsLbnxmuhKnEWII2+Bp0IMAiTQiRiyErCIOLIaYASiobFF
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397b82d1-6384-40a4-2cac-08d75b7df230
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:07:59.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLYn74IhApjx1nti9fHXNLoubingOceOkpYZvHXY+eFKxDleZviV8pEUnzJTrvLibGizYh5q91xbVpK3iFhd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3989
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
ChangeLog v3->v4:
 * Add some comments to 'IMX7ULP_CLK_MIPI_PLL'
   clock.

 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
 drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
 include/dt-bindings/clock/imx7ulp-clock.h                 | 6 ++++++
 3 files changed, 7 insertions(+), 3 deletions(-)

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
index 6f66f9005c81..e9ef62f211fe 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -49,7 +49,13 @@
 #define IMX7ULP_CLK_NIC1_DIV		36
 #define IMX7ULP_CLK_NIC1_BUS_DIV	37
 #define IMX7ULP_CLK_NIC1_EXT_DIV	38
+
+/* mpll clock is a special clock comes from
+ * mipi DPHY PLL and should be used only for
+ * mipi dsi instead of any other peripheral.
+ */
 #define IMX7ULP_CLK_MIPI_PLL		39
+
 #define IMX7ULP_CLK_SIRC		40
 #define IMX7ULP_CLK_SOSC_BUS_CLK	41
 #define IMX7ULP_CLK_FIRC_BUS_CLK	42
--=20
2.17.1

