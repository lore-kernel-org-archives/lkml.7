Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD338C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CF218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DXbjND3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfISDKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:10:48 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:1347
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbfISDKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhz/EcSPUknWs0Jc5ynriyrJpoW+Cgy0vyNNFwxkVlrhyiGhsJod3LLjXeUalULlVAmt4UfJ4sEEUiRVDJGSL/TgBMv+l2S8yr8Wx2SSNCN5AynVFSN2ZO+C51DTnM+8eCWoTKP0tSmLIq5x3VWcRe+5e4uA+8RzdogYnPyVmgDLUyC2ROB9g5XS82QQ9BYMKLXrxkIkaB3cyPqmRvTzNIlej5FNQBGkD+DkOHceWp7NQp8zeNy5qo0xXB5hpPi/AmDfJQf0ljOK5KJxh5MKHQrhM6hnmMGx90HhPUVHWYf8sxY058w8v467aG9UWc9JvzJQXHubYw4c7y9R0yVVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOGt3H3vBAfiZrsFDseE/JdGtm+1S4KWNhXyHFTMbuk=;
 b=Ei1hJe8ixQr3nmhorfado/SwB3iIHf+4XJqmao5H/+KJJZnpOY4N0hs1v7n1JSQWr7ONO98Gl5zNXup6renWTGY9QPc4zPROd2rlY0SNpwwH8oCVNbgVJHFxt7aSUi/PzA1Ts/3KFEx+yb5ln06litbLijADN/NaJBaJlUv8rhu8YwexCVdFr3QuKF5gXB3piQoV8G9QrsHl65WXalI2bwIMRuCTWWYCXw5edUHu27/LcB8uMTSkv5S7tQHq/7BhIyrICH++4OSbmo5lyijNmWWBEl5f2Is4f7Bz/ualnaoxQ79ld8gIt9yctJUchsENFYh48muyQsxscgysOxUryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOGt3H3vBAfiZrsFDseE/JdGtm+1S4KWNhXyHFTMbuk=;
 b=DXbjND3VPfKDM9/WVUp3rBRPrdzXbHs5mXvgg+XLplPXnA8MnRyNqGc387+FPBeaHYp3g9yjM2frQrMP3bbnFvQMPeUc6H4fp3Bc/Mk4bzxfOgdY99g+2dit97lrpWLbIA3LbfUMf0lukgvz2DM+Q7hMI2X1QQutzvrcj+ErY6s=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB3992.eurprd04.prod.outlook.com (52.135.169.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 03:10:44 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::3069:86de:e199:8abe]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::3069:86de:e199:8abe%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 03:10:44 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
Thread-Topic: [PATCH v2] clk: imx7ulp: remove IMX7ULP_CLK_MIPI_PLL clock
Thread-Index: AQHVbpfTBWkVGhuNzkmN4Sgwz3kphA==
Date:   Thu, 19 Sep 2019 03:10:44 +0000
Message-ID: <20190919030912.16957-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d2c498-d3e9-4d83-cab7-08d73caef60f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB3992;
x-ms-traffictypediagnostic: AM6PR04MB3992:|AM6PR04MB3992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB399227AF633B36F5D56C9A3DF3890@AM6PR04MB3992.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54534003)(8936002)(186003)(50226002)(1730700003)(8676002)(81156014)(81166006)(14454004)(66556008)(66446008)(64756008)(66476007)(66946007)(1076003)(4326008)(102836004)(52116002)(25786009)(386003)(3846002)(2351001)(2906002)(6506007)(6116002)(6916009)(26005)(316002)(478600001)(5640700003)(2501003)(6486002)(476003)(6436002)(86362001)(54906003)(486006)(7736002)(5660300002)(36756003)(2616005)(305945005)(99286004)(256004)(6512007)(71190400001)(71200400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3992;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Si118vHcMuzFWwfS3xY/gLGeqUGe0WzoKxCUmhTTUAgdY426kK2TAsD2OSm0B89PdN2rSFUXKjOH1JS2zjj1aDD/nbYqeycwfuMDegyBbfPRWDK1YpdnFM5F3IGF4qrONAMsDiWDxCRD1EwRuFN2buLCDW3Uc6IpHnJbBq2pzdihTm2HNLCuAERoIZ1XZSuHAR1xG23jOAxfPlqgBoi7rlwmuqakAYNU4Pf9lAJ14wpMypKBkFS2T4GokvIkCa4Kfa/vXgX8FFuDbml6tg1GfziFUd+LSMEJuJZuXQAiWRa9FlubAIQMu1w6Tzf5GeQ/Yw892UcBUWSRI8LcaiAm7mAkxus1ctQPuwFjnUtItAf8RLTUvF1GCfWWDigoHZuKGbaf5JogeYgZ2dA2mwo0dKuyinV+XkZ57P4nbDs9+i0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d2c498-d3e9-4d83-cab7-08d73caef60f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 03:10:44.7909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAcDs2qcKUpykHxXkkCBqdMjwgi46D9zETJn3oyP1dL+EE441lPhl2hFyuYG+wa0CR8mVCWQnh4JbJmeoDhrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3992
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
ChangeLog v1->v2:
 * Keep other clock indexes unchanged as Shawn suggested.

 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
 drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
 include/dt-bindings/clock/imx7ulp-clock.h                 | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

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
index 995a4ad10904..936c39f767df 100644
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
index 6f66f9005c81..a39b0c40cb41 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -49,7 +49,6 @@
 #define IMX7ULP_CLK_NIC1_DIV		36
 #define IMX7ULP_CLK_NIC1_BUS_DIV	37
 #define IMX7ULP_CLK_NIC1_EXT_DIV	38
-#define IMX7ULP_CLK_MIPI_PLL		39
 #define IMX7ULP_CLK_SIRC		40
 #define IMX7ULP_CLK_SOSC_BUS_CLK	41
 #define IMX7ULP_CLK_FIRC_BUS_CLK	42
--=20
2.17.1

