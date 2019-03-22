Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6616BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A8D213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xcwbIST2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCVPi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:28 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:8337
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbfCVPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+Ex1+SwK8EL1rglvtQI4kz6mpociJR2EoK5q0neMXY=;
 b=xcwbIST2LQ9ybzgVsAu/1q+njEpe/O8lY43X3FMi8M8UDNc4PM3YTa7gzKX2PPiAdAOuE/aa+jdgYz4bjo/8E3j4kdmXn9hzyGDLpWX8/nFfFVbGuBhhQZkMG4KUAv+xJyeZgm5ckBHuvD5b4lI8cZhn8nlq2ueVatzccFdm0g8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:23 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:23 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 19/19] clk: imx6sll: Switch to clk_hw based API
Thread-Topic: [RFC 19/19] clk: imx6sll: Switch to clk_hw based API
Thread-Index: AQHU4MUkGZz4/XPtDUOA65DGY5hVpw==
Date:   Fri, 22 Mar 2019 15:37:23 +0000
Message-ID: <1553269010-15591-20-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 881664a2-d1d7-41e2-c5ea-08d6aedc471d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802796262EA1771712D1D3EF6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(14444005)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(53946003)(26005)(186003)(105586002)(102836004)(6436002)(30864003)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002)(32563001)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0PBLF2I9pTaQrLAhhaCn0QoI40ToI91xIc8svPKu+duyEEGwWdceVsGnxHNZwa/bqU8ZP/5gx0qRWmuBfl6cvaojIxV2OPhA4eKI8IrUEzeKxZJLwMOQTSIyIJrCMZi+ZGnwkit16OQpIzM2w7/hz8p1j5Y5Vn2SvE86xcs+5b/7NBe9LKBmcGrBNPbCzqHb55RyiaAHKdcOEsZWKAkyUNFb6P2KytAIBVJjbY1ZXbDtVJREUtZQk0POqVdGVIiPdiU/nZ1ytAR/PZe5YZ2BhWJw5MHc+2CHkoCoUzlp8MfpE8CeR5I3cWVet8JH2ats7FvXqi07QFrp1i9k5K+cIgb+n1ohEaI616/lq84QfaQJjDW7mgheHns/i2jyp3R7jryS3549jL8bHlK/05f4VbKOML1uoCS4GfZm3k2Y0P4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881664a2-d1d7-41e2-c5ea-08d6aedc471d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:23.1047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx6sll driver to clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c | 398 +++++++++++++++++++++-----------------=
----
 1 file changed, 202 insertions(+), 196 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 3bd2044..728a57f 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -53,8 +53,8 @@ static const char *lcdif_sels[] =3D { "lcdif_podf", "ipp_=
di0", "ipp_di1", "ldb_di0
 static const char *epdc_pre_sels[] =3D { "pll2_bus", "pll3_usb_otg", "pll5=
_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd2_508m", };
 static const char *epdc_sels[] =3D { "epdc_podf", "ipp_di0", "ipp_di1", "l=
db_di0", "ldb_di1", };
=20
-static struct clk *clks[IMX6SLL_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
=20
 static const struct clk_div_table post_div_table[] =3D {
 	{ .val =3D 2, .div =3D 1, },
@@ -81,14 +81,22 @@ static void __init imx6sll_clocks_init(struct device_no=
de *ccm_node)
 	struct device_node *np;
 	void __iomem *base;
=20
-	clks[IMX6SLL_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX6SLL_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
=20
-	clks[IMX6SLL_CLK_CKIL] =3D of_clk_get_by_name(ccm_node, "ckil");
-	clks[IMX6SLL_CLK_OSC] =3D of_clk_get_by_name(ccm_node, "osc");
+	clk_hw_data->num =3D IMX6SLL_CLK_END;
+	hws =3D clk_hw_data->hws;
+
+	hws[IMX6SLL_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+
+	hws[IMX6SLL_CLK_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil=
"));
+	hws[IMX6SLL_CLK_OSC] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc")=
);
=20
 	/* ipp_di clock is external input */
-	clks[IMX6SLL_CLK_IPP_DI0] =3D of_clk_get_by_name(ccm_node, "ipp_di0");
-	clks[IMX6SLL_CLK_IPP_DI1] =3D of_clk_get_by_name(ccm_node, "ipp_di1");
+	hws[IMX6SLL_CLK_IPP_DI0] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "i=
pp_di0"));
+	hws[IMX6SLL_CLK_IPP_DI1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "i=
pp_di1"));
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sll-anatop");
 	base =3D of_iomap(np, 0);
@@ -104,37 +112,37 @@ static void __init imx6sll_clocks_init(struct device_=
node *ccm_node)
 	writel_relaxed(CCM_ANALOG_PLL_BYPASS, base + xPLL_CLR(0xa0));
 	writel_relaxed(CCM_ANALOG_PLL_BYPASS, base + xPLL_CLR(0xe0));
=20
-	clks[IMX6SLL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0=
x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL2_BYPASS_SRC] =3D imx_clk_mux("pll2_bypass_src", base + 0=
x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL3_BYPASS_SRC] =3D imx_clk_mux("pll3_bypass_src", base + 0=
x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL4_BYPASS_SRC] =3D imx_clk_mux("pll4_bypass_src", base + 0=
x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL5_BYPASS_SRC] =3D imx_clk_mux("pll5_bypass_src", base + 0=
xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL6_BYPASS_SRC] =3D imx_clk_mux("pll6_bypass_src", base + 0=
xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SLL_PLL7_BYPASS_SRC] =3D imx_clk_mux("pll7_bypass_src", base + 0=
x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-
-	clks[IMX6SLL_CLK_PLL1] =3D imx_clk_pllv3(IMX_PLLV3_SYS,	 "pll1", "pll1_by=
pass_src", base + 0x00, 0x7f);
-	clks[IMX6SLL_CLK_PLL2] =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "pll2=
_bypass_src", base + 0x30, 0x1);
-	clks[IMX6SLL_CLK_PLL3] =3D imx_clk_pllv3(IMX_PLLV3_USB,	 "pll3", "pll3_by=
pass_src", base + 0x10, 0x3);
-	clks[IMX6SLL_CLK_PLL4] =3D imx_clk_pllv3(IMX_PLLV3_AV,	 "pll4", "pll4_byp=
ass_src", base + 0x70, 0x7f);
-	clks[IMX6SLL_CLK_PLL5] =3D imx_clk_pllv3(IMX_PLLV3_AV,	 "pll5", "pll5_byp=
ass_src", base + 0xa0, 0x7f);
-	clks[IMX6SLL_CLK_PLL6] =3D imx_clk_pllv3(IMX_PLLV3_ENET,	 "pll6", "pll6_b=
ypass_src", base + 0xe0, 0x3);
-	clks[IMX6SLL_CLK_PLL7] =3D imx_clk_pllv3(IMX_PLLV3_USB,	 "pll7", "pll7_by=
pass_src", base + 0x20, 0x3);
-
-	clks[IMX6SLL_PLL1_BYPASS] =3D imx_clk_mux_flags("pll1_bypass", base + 0x0=
0, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL2_BYPASS] =3D imx_clk_mux_flags("pll2_bypass", base + 0x3=
0, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL3_BYPASS] =3D imx_clk_mux_flags("pll3_bypass", base + 0x1=
0, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL4_BYPASS] =3D imx_clk_mux_flags("pll4_bypass", base + 0x7=
0, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL5_BYPASS] =3D imx_clk_mux_flags("pll5_bypass", base + 0xa=
0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL6_BYPASS] =3D imx_clk_mux_flags("pll6_bypass", base + 0xe=
0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PARE=
NT);
-	clks[IMX6SLL_PLL7_BYPASS] =3D imx_clk_mux_flags("pll7_bypass", base + 0x2=
0, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PARE=
NT);
-
-	clks[IMX6SLL_CLK_PLL1_SYS]	=3D imx_clk_fixed_factor("pll1_sys", "pll1_byp=
ass", 1, 1);
-	clks[IMX6SLL_CLK_PLL2_BUS]	=3D imx_clk_gate("pll2_bus",	   "pll2_bypass",=
 base + 0x30, 13);
-	clks[IMX6SLL_CLK_PLL3_USB_OTG]	=3D imx_clk_gate("pll3_usb_otg",	   "pll3_=
bypass", base + 0x10, 13);
-	clks[IMX6SLL_CLK_PLL4_AUDIO]	=3D imx_clk_gate("pll4_audio",	   "pll4_bypa=
ss", base + 0x70, 13);
-	clks[IMX6SLL_CLK_PLL5_VIDEO]	=3D imx_clk_gate("pll5_video",	   "pll5_bypa=
ss", base + 0xa0, 13);
-	clks[IMX6SLL_CLK_PLL6_ENET]	=3D imx_clk_gate("pll6_enet",	   "pll6_bypass=
", base + 0xe0, 13);
-	clks[IMX6SLL_CLK_PLL7_USB_HOST]	=3D imx_clk_gate("pll7_usb_host",	   "pll=
7_bypass", base + 0x20, 13);
+	hws[IMX6SLL_PLL1_BYPASS_SRC] =3D imx_clk_hw_mux("pll1_bypass_src", base +=
 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL2_BYPASS_SRC] =3D imx_clk_hw_mux("pll2_bypass_src", base +=
 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL3_BYPASS_SRC] =3D imx_clk_hw_mux("pll3_bypass_src", base +=
 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL4_BYPASS_SRC] =3D imx_clk_hw_mux("pll4_bypass_src", base +=
 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL5_BYPASS_SRC] =3D imx_clk_hw_mux("pll5_bypass_src", base +=
 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL6_BYPASS_SRC] =3D imx_clk_hw_mux("pll6_bypass_src", base +=
 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SLL_PLL7_BYPASS_SRC] =3D imx_clk_hw_mux("pll7_bypass_src", base +=
 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+
+	hws[IMX6SLL_CLK_PLL1] =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS,	 "pll1", "pll1_=
bypass_src", base + 0x00, 0x7f);
+	hws[IMX6SLL_CLK_PLL2] =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "pl=
l2_bypass_src", base + 0x30, 0x1);
+	hws[IMX6SLL_CLK_PLL3] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,	 "pll3", "pll3_=
bypass_src", base + 0x10, 0x3);
+	hws[IMX6SLL_CLK_PLL4] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,	 "pll4", "pll4_b=
ypass_src", base + 0x70, 0x7f);
+	hws[IMX6SLL_CLK_PLL5] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,	 "pll5", "pll5_b=
ypass_src", base + 0xa0, 0x7f);
+	hws[IMX6SLL_CLK_PLL6] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET,	 "pll6", "pll6=
_bypass_src", base + 0xe0, 0x3);
+	hws[IMX6SLL_CLK_PLL7] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,	 "pll7", "pll7_=
bypass_src", base + 0x20, 0x3);
+
+	hws[IMX6SLL_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("pll1_bypass", base + 0=
x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("pll2_bypass", base + 0=
x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("pll3_bypass", base + 0=
x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL4_BYPASS] =3D imx_clk_hw_mux_flags("pll4_bypass", base + 0=
x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL5_BYPASS] =3D imx_clk_hw_mux_flags("pll5_bypass", base + 0=
xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL6_BYPASS] =3D imx_clk_hw_mux_flags("pll6_bypass", base + 0=
xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6SLL_PLL7_BYPASS] =3D imx_clk_hw_mux_flags("pll7_bypass", base + 0=
x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PA=
RENT);
+
+	hws[IMX6SLL_CLK_PLL1_SYS]	=3D imx_clk_hw_fixed_factor("pll1_sys", "pll1_b=
ypass", 1, 1);
+	hws[IMX6SLL_CLK_PLL2_BUS]	=3D imx_clk_hw_gate("pll2_bus",	   "pll2_bypass=
", base + 0x30, 13);
+	hws[IMX6SLL_CLK_PLL3_USB_OTG]	=3D imx_clk_hw_gate("pll3_usb_otg",	   "pll=
3_bypass", base + 0x10, 13);
+	hws[IMX6SLL_CLK_PLL4_AUDIO]	=3D imx_clk_hw_gate("pll4_audio",	   "pll4_by=
pass", base + 0x70, 13);
+	hws[IMX6SLL_CLK_PLL5_VIDEO]	=3D imx_clk_hw_gate("pll5_video",	   "pll5_by=
pass", base + 0xa0, 13);
+	hws[IMX6SLL_CLK_PLL6_ENET]	=3D imx_clk_hw_gate("pll6_enet",	   "pll6_bypa=
ss", base + 0xe0, 13);
+	hws[IMX6SLL_CLK_PLL7_USB_HOST]	=3D imx_clk_hw_gate("pll7_usb_host",	   "p=
ll7_bypass", base + 0x20, 13);
=20
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
@@ -142,207 +150,205 @@ static void __init imx6sll_clocks_init(struct devic=
e_node *ccm_node)
 	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
 	 * the clk framework many need to enable/disable usbphy's parent
 	 */
-	clks[IMX6SLL_CLK_USBPHY1] =3D imx_clk_gate("usbphy1", "pll3_usb_otg",  ba=
se + 0x10, 20);
-	clks[IMX6SLL_CLK_USBPHY2] =3D imx_clk_gate("usbphy2", "pll7_usb_host", ba=
se + 0x20, 20);
+	hws[IMX6SLL_CLK_USBPHY1] =3D imx_clk_hw_gate("usbphy1", "pll3_usb_otg",  =
base + 0x10, 20);
+	hws[IMX6SLL_CLK_USBPHY2] =3D imx_clk_hw_gate("usbphy2", "pll7_usb_host", =
base + 0x20, 20);
=20
 	/*
 	 * usbphy*_gate needs to be on after system boots up, and software
 	 * never needs to control it anymore.
 	 */
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clks[IMX6SLL_CLK_USBPHY1_GATE] =3D imx_clk_gate_flags("usbphy1_gate", "d=
ummy", base + 0x10, 6, CLK_IS_CRITICAL);
-		clks[IMX6SLL_CLK_USBPHY2_GATE] =3D imx_clk_gate_flags("usbphy2_gate", "d=
ummy", base + 0x20, 6, CLK_IS_CRITICAL);
+		hws[IMX6SLL_CLK_USBPHY1_GATE] =3D imx_clk_hw_gate_flags("usbphy1_gate", =
"dummy", base + 0x10, 6, CLK_IS_CRITICAL);
+		hws[IMX6SLL_CLK_USBPHY2_GATE] =3D imx_clk_hw_gate_flags("usbphy2_gate", =
"dummy", base + 0x20, 6, CLK_IS_CRITICAL);
 	}
=20
 	/*					name		   parent_name	   reg		idx */
-	clks[IMX6SLL_CLK_PLL2_PFD0] =3D imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",=
 base + 0x100, 0);
-	clks[IMX6SLL_CLK_PLL2_PFD1] =3D imx_clk_pfd("pll2_pfd1_594m", "pll2_bus",=
 base + 0x100, 1);
-	clks[IMX6SLL_CLK_PLL2_PFD2] =3D imx_clk_pfd("pll2_pfd2_396m", "pll2_bus",=
 base + 0x100, 2);
-	clks[IMX6SLL_CLK_PLL2_PFD3] =3D imx_clk_pfd("pll2_pfd3_594m", "pll2_bus",=
	base + 0x100, 3);
-	clks[IMX6SLL_CLK_PLL3_PFD0] =3D imx_clk_pfd("pll3_pfd0_720m", "pll3_usb_o=
tg", base + 0xf0, 0);
-	clks[IMX6SLL_CLK_PLL3_PFD1] =3D imx_clk_pfd("pll3_pfd1_540m", "pll3_usb_o=
tg", base + 0xf0, 1);
-	clks[IMX6SLL_CLK_PLL3_PFD2] =3D imx_clk_pfd("pll3_pfd2_508m", "pll3_usb_o=
tg", base + 0xf0, 2);
-	clks[IMX6SLL_CLK_PLL3_PFD3] =3D imx_clk_pfd("pll3_pfd3_454m", "pll3_usb_o=
tg", base + 0xf0, 3);
-
-	clks[IMX6SLL_CLK_PLL4_POST_DIV]  =3D clk_register_divider_table(NULL, "pl=
l4_post_div", "pll4_audio",
+	hws[IMX6SLL_CLK_PLL2_PFD0] =3D imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_bus=
", base + 0x100, 0);
+	hws[IMX6SLL_CLK_PLL2_PFD1] =3D imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_bus=
", base + 0x100, 1);
+	hws[IMX6SLL_CLK_PLL2_PFD2] =3D imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_bus=
", base + 0x100, 2);
+	hws[IMX6SLL_CLK_PLL2_PFD3] =3D imx_clk_hw_pfd("pll2_pfd3_594m", "pll2_bus=
",	base + 0x100, 3);
+	hws[IMX6SLL_CLK_PLL3_PFD0] =3D imx_clk_hw_pfd("pll3_pfd0_720m", "pll3_usb=
_otg", base + 0xf0, 0);
+	hws[IMX6SLL_CLK_PLL3_PFD1] =3D imx_clk_hw_pfd("pll3_pfd1_540m", "pll3_usb=
_otg", base + 0xf0, 1);
+	hws[IMX6SLL_CLK_PLL3_PFD2] =3D imx_clk_hw_pfd("pll3_pfd2_508m", "pll3_usb=
_otg", base + 0xf0, 2);
+	hws[IMX6SLL_CLK_PLL3_PFD3] =3D imx_clk_hw_pfd("pll3_pfd3_454m", "pll3_usb=
_otg", base + 0xf0, 3);
+
+	hws[IMX6SLL_CLK_PLL4_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "=
pll4_post_div", "pll4_audio",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 19, 2, 0, post_di=
v_table, &imx_ccm_lock);
-	clks[IMX6SLL_CLK_PLL4_AUDIO_DIV] =3D clk_register_divider(NULL, "pll4_aud=
io_div", "pll4_post_div",
+	hws[IMX6SLL_CLK_PLL4_AUDIO_DIV] =3D clk_hw_register_divider(NULL, "pll4_a=
udio_div", "pll4_post_div",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x170, 15, 1, 0, &imx_c=
cm_lock);
-	clks[IMX6SLL_CLK_PLL5_POST_DIV]  =3D clk_register_divider_table(NULL, "pl=
l5_post_div", "pll5_video",
+	hws[IMX6SLL_CLK_PLL5_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "=
pll5_post_div", "pll5_video",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xa0, 19, 2, 0, post_di=
v_table, &imx_ccm_lock);
-	clks[IMX6SLL_CLK_PLL5_VIDEO_DIV] =3D clk_register_divider_table(NULL, "pl=
l5_video_div", "pll5_post_div",
+	hws[IMX6SLL_CLK_PLL5_VIDEO_DIV] =3D clk_hw_register_divider_table(NULL, "=
pll5_video_div", "pll5_post_div",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x170, 30, 2, 0, video_=
div_table, &imx_ccm_lock);
=20
 	/*						   name		parent_name	 mult  div */
-	clks[IMX6SLL_CLK_PLL2_198M] =3D imx_clk_fixed_factor("pll2_198m", "pll2_p=
fd2_396m", 1, 2);
-	clks[IMX6SLL_CLK_PLL3_120M] =3D imx_clk_fixed_factor("pll3_120m", "pll3_u=
sb_otg",   1, 4);
-	clks[IMX6SLL_CLK_PLL3_80M]  =3D imx_clk_fixed_factor("pll3_80m",  "pll3_u=
sb_otg",   1, 6);
-	clks[IMX6SLL_CLK_PLL3_60M]  =3D imx_clk_fixed_factor("pll3_60m",  "pll3_u=
sb_otg",   1, 8);
+	hws[IMX6SLL_CLK_PLL2_198M] =3D imx_clk_hw_fixed_factor("pll2_198m", "pll2=
_pfd2_396m", 1, 2);
+	hws[IMX6SLL_CLK_PLL3_120M] =3D imx_clk_hw_fixed_factor("pll3_120m", "pll3=
_usb_otg",   1, 4);
+	hws[IMX6SLL_CLK_PLL3_80M]  =3D imx_clk_hw_fixed_factor("pll3_80m",  "pll3=
_usb_otg",   1, 6);
+	hws[IMX6SLL_CLK_PLL3_60M]  =3D imx_clk_hw_fixed_factor("pll3_60m",  "pll3=
_usb_otg",   1, 8);
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX6SLL_CLK_STEP] 	 	  =3D imx_clk_mux("step", base + 0x0c, 8, 1, st=
ep_sels, ARRAY_SIZE(step_sels));
-	clks[IMX6SLL_CLK_PLL1_SW] 	  =3D imx_clk_mux_flags("pll1_sw",   base + 0x=
0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
-	clks[IMX6SLL_CLK_AXI_ALT_SEL]	  =3D imx_clk_mux("axi_alt_sel",	   base + =
0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
-	clks[IMX6SLL_CLK_AXI_SEL] 	  =3D imx_clk_mux_flags("axi_sel",   base + 0x=
14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
-	clks[IMX6SLL_CLK_PERIPH_PRE]	  =3D imx_clk_mux("periph_pre",      base + =
0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
-	clks[IMX6SLL_CLK_PERIPH2_PRE]	  =3D imx_clk_mux("periph2_pre",     base +=
 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
-	clks[IMX6SLL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_mux("periph_clk2_sel",  ba=
se + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
-	clks[IMX6SLL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_mux("periph2_clk2_sel", ba=
se + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clks[IMX6SLL_CLK_USDHC1_SEL]	  =3D imx_clk_mux("usdhc1_sel",   base + 0x1=
c, 16, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SLL_CLK_USDHC2_SEL]	  =3D imx_clk_mux("usdhc2_sel",   base + 0x1=
c, 17, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SLL_CLK_USDHC3_SEL]	  =3D imx_clk_mux("usdhc3_sel",   base + 0x1=
c, 18, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SLL_CLK_SSI1_SEL]	  =3D imx_clk_mux("ssi1_sel",     base + 0x1c,=
 10, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
-	clks[IMX6SLL_CLK_SSI2_SEL]	  =3D imx_clk_mux("ssi2_sel",     base + 0x1c,=
 12, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
-	clks[IMX6SLL_CLK_SSI3_SEL]	  =3D imx_clk_mux("ssi3_sel",     base + 0x1c,=
 14, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
-	clks[IMX6SLL_CLK_PERCLK_SEL] 	  =3D imx_clk_mux("perclk_sel",	base + 0x1c=
, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
-	clks[IMX6SLL_CLK_UART_SEL]	  =3D imx_clk_mux("uart_sel",	base + 0x24, 6, =
 1, uart_sels, ARRAY_SIZE(uart_sels));
-	clks[IMX6SLL_CLK_SPDIF_SEL]	  =3D imx_clk_mux("spdif_sel",	base + 0x30, 2=
0, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
-	clks[IMX6SLL_CLK_EXTERN_AUDIO_SEL] =3D imx_clk_mux("extern_audio_sel", ba=
se + 0x30, 7,  2, spdif_sels, ARRAY_SIZE(spdif_sels));
-	clks[IMX6SLL_CLK_EPDC_PRE_SEL]	  =3D imx_clk_mux("epdc_pre_sel",	base + 0=
x34, 15, 3, epdc_pre_sels, ARRAY_SIZE(epdc_pre_sels));
-	clks[IMX6SLL_CLK_EPDC_SEL]	  =3D imx_clk_mux("epdc_sel",	base + 0x34, 9, =
3, epdc_sels, ARRAY_SIZE(epdc_sels));
-	clks[IMX6SLL_CLK_ECSPI_SEL]	  =3D imx_clk_mux("ecspi_sel",	base + 0x38, 1=
8, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
-	clks[IMX6SLL_CLK_LCDIF_PRE_SEL]	  =3D imx_clk_mux("lcdif_pre_sel", base +=
 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels));
-	clks[IMX6SLL_CLK_LCDIF_SEL]	  =3D imx_clk_mux("lcdif_sel", 	 base + 0x38,=
 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
-
-	clks[IMX6SLL_CLK_PERIPH]  =3D imx_clk_busy_mux("periph",  base + 0x14, 25=
, 1, base + 0x48, 5, periph_sels, ARRAY_SIZE(periph_sels));
-	clks[IMX6SLL_CLK_PERIPH2] =3D imx_clk_busy_mux("periph2", base + 0x14, 26=
, 1, base + 0x48, 3, periph2_sels, ARRAY_SIZE(periph2_sels));
-
-	clks[IMX6SLL_CLK_PERIPH_CLK2]	=3D imx_clk_divider("periph_clk2",   "perip=
h_clk2_sel",  	base + 0x14, 27, 3);
-	clks[IMX6SLL_CLK_PERIPH2_CLK2]	=3D imx_clk_divider("periph2_clk2",  "peri=
ph2_clk2_sel", 	base + 0x14, 0,  3);
-	clks[IMX6SLL_CLK_IPG]		=3D imx_clk_divider("ipg",	   "ahb",		base + 0x14,=
 8,	 2);
-	clks[IMX6SLL_CLK_LCDIF_PODF]	=3D imx_clk_divider("lcdif_podf",	   "lcdif_=
pred",	base + 0x18, 23, 3);
-	clks[IMX6SLL_CLK_PERCLK]	=3D imx_clk_divider("perclk",	   "perclk_sel",	b=
ase + 0x1c, 0,  6);
-	clks[IMX6SLL_CLK_USDHC3_PODF]   =3D imx_clk_divider("usdhc3_podf",   "usd=
hc3_sel",	base + 0x24, 19, 3);
-	clks[IMX6SLL_CLK_USDHC2_PODF]	=3D imx_clk_divider("usdhc2_podf",   "usdhc=
2_sel",	base + 0x24, 16, 3);
-	clks[IMX6SLL_CLK_USDHC1_PODF]	=3D imx_clk_divider("usdhc1_podf",   "usdhc=
1_sel",	base + 0x24, 11, 3);
-	clks[IMX6SLL_CLK_UART_PODF]	=3D imx_clk_divider("uart_podf",	   "uart_sel=
",		base + 0x24, 0,  6);
-	clks[IMX6SLL_CLK_SSI3_PRED]	=3D imx_clk_divider("ssi3_pred",	   "ssi3_sel=
",		base + 0x28, 22, 3);
-	clks[IMX6SLL_CLK_SSI3_PODF]	=3D imx_clk_divider("ssi3_podf",	   "ssi3_pre=
d",		base + 0x28, 16, 6);
-	clks[IMX6SLL_CLK_SSI1_PRED]	=3D imx_clk_divider("ssi1_pred",	   "ssi1_sel=
",		base + 0x28, 6,	 3);
-	clks[IMX6SLL_CLK_SSI1_PODF]	=3D imx_clk_divider("ssi1_podf",	   "ssi1_pre=
d",		base + 0x28, 0,	 6);
-	clks[IMX6SLL_CLK_SSI2_PRED]	=3D imx_clk_divider("ssi2_pred",	   "ssi2_sel=
",		base + 0x2c, 6,	 3);
-	clks[IMX6SLL_CLK_SSI2_PODF]	=3D imx_clk_divider("ssi2_podf",	   "ssi2_pre=
d",		base + 0x2c, 0,  6);
-	clks[IMX6SLL_CLK_SPDIF_PRED]	=3D imx_clk_divider("spdif_pred",	   "spdif_=
sel",		base + 0x30, 25, 3);
-	clks[IMX6SLL_CLK_SPDIF_PODF]	=3D imx_clk_divider("spdif_podf",	   "spdif_=
pred",	base + 0x30, 22, 3);
-	clks[IMX6SLL_CLK_EXTERN_AUDIO_PRED] =3D imx_clk_divider("extern_audio_pre=
d", "extern_audio_sel",  base + 0x30, 12, 3);
-	clks[IMX6SLL_CLK_EXTERN_AUDIO_PODF] =3D imx_clk_divider("extern_audio_pod=
f", "extern_audio_pred", base + 0x30, 9,  3);
-	clks[IMX6SLL_CLK_EPDC_PODF]  =3D imx_clk_divider("epdc_podf",  "epdc_pre_=
sel",  base + 0x34, 12, 3);
-	clks[IMX6SLL_CLK_ECSPI_PODF] =3D imx_clk_divider("ecspi_podf", "ecspi_sel=
",     base + 0x38, 19, 6);
-	clks[IMX6SLL_CLK_LCDIF_PRED] =3D imx_clk_divider("lcdif_pred", "lcdif_pre=
_sel", base + 0x38, 12, 3);
-
-	clks[IMX6SLL_CLK_ARM]		=3D imx_clk_busy_divider("arm", 	    "pll1_sw",	ba=
se +	0x10, 0,  3,  base + 0x48, 16);
-	clks[IMX6SLL_CLK_MMDC_PODF]	=3D imx_clk_busy_divider("mmdc_podf", "periph=
2",	base +  0x14, 3,  3,  base + 0x48, 2);
-	clks[IMX6SLL_CLK_AXI_PODF]	=3D imx_clk_busy_divider("axi",       "axi_sel=
",	base +  0x14, 16, 3,  base + 0x48, 0);
-	clks[IMX6SLL_CLK_AHB]		=3D imx_clk_busy_divider("ahb",	    "periph",	base=
 +  0x14, 10, 3,  base + 0x48, 1);
-
-	clks[IMX6SLL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di0_div_3=
_5", "ldb_di0_sel", 2, 7);
-	clks[IMX6SLL_CLK_LDB_DI0_DIV_7]	  =3D imx_clk_fixed_factor("ldb_di0_div_7=
",   "ldb_di0_sel", 1, 7);
-	clks[IMX6SLL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di1_div_3=
_5", "ldb_di1_sel", 2, 7);
-	clks[IMX6SLL_CLK_LDB_DI1_DIV_7]	  =3D imx_clk_fixed_factor("ldb_di1_div_7=
",   "ldb_di1_sel", 1, 7);
-
-	clks[IMX6SLL_CLK_LDB_DI0_SEL]	=3D imx_clk_mux("ldb_di0_sel", base + 0x2c,=
 9, 3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
-	clks[IMX6SLL_CLK_LDB_DI1_SEL]   =3D imx_clk_mux("ldb_di1_sel", base + 0x1=
c, 7, 3, ldb_di1_sels, ARRAY_SIZE(ldb_di1_sels));
-	clks[IMX6SLL_CLK_LDB_DI0_DIV_SEL] =3D imx_clk_mux("ldb_di0_div_sel", base=
 + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
-	clks[IMX6SLL_CLK_LDB_DI1_DIV_SEL] =3D imx_clk_mux("ldb_di1_div_sel", base=
 + 0x20, 10, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
+	hws[IMX6SLL_CLK_STEP] 	 	  =3D imx_clk_hw_mux("step", base + 0x0c, 8, 1, =
step_sels, ARRAY_SIZE(step_sels));
+	hws[IMX6SLL_CLK_PLL1_SW] 	  =3D imx_clk_hw_mux_flags("pll1_sw",   base + =
0x0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	hws[IMX6SLL_CLK_AXI_ALT_SEL]	  =3D imx_clk_hw_mux("axi_alt_sel",	   base =
+ 0x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
+	hws[IMX6SLL_CLK_AXI_SEL] 	  =3D imx_clk_hw_mux_flags("axi_sel",   base + =
0x14, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
+	hws[IMX6SLL_CLK_PERIPH_PRE]	  =3D imx_clk_hw_mux("periph_pre",      base =
+ 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
+	hws[IMX6SLL_CLK_PERIPH2_PRE]	  =3D imx_clk_hw_mux("periph2_pre",     base=
 + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
+	hws[IMX6SLL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_hw_mux("periph_clk2_sel",  =
base + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
+	hws[IMX6SLL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_hw_mux("periph2_clk2_sel", =
base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
+	hws[IMX6SLL_CLK_USDHC1_SEL]	  =3D imx_clk_hw_mux("usdhc1_sel",   base + 0=
x1c, 16, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SLL_CLK_USDHC2_SEL]	  =3D imx_clk_hw_mux("usdhc2_sel",   base + 0=
x1c, 17, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SLL_CLK_USDHC3_SEL]	  =3D imx_clk_hw_mux("usdhc3_sel",   base + 0=
x1c, 18, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SLL_CLK_SSI1_SEL]	  =3D imx_clk_hw_mux("ssi1_sel",     base + 0x1=
c, 10, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
+	hws[IMX6SLL_CLK_SSI2_SEL]	  =3D imx_clk_hw_mux("ssi2_sel",     base + 0x1=
c, 12, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
+	hws[IMX6SLL_CLK_SSI3_SEL]	  =3D imx_clk_hw_mux("ssi3_sel",     base + 0x1=
c, 14, 2, ssi_sels, ARRAY_SIZE(ssi_sels));
+	hws[IMX6SLL_CLK_PERCLK_SEL] 	  =3D imx_clk_hw_mux("perclk_sel",	base + 0x=
1c, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
+	hws[IMX6SLL_CLK_UART_SEL]	  =3D imx_clk_hw_mux("uart_sel",	base + 0x24, 6=
,  1, uart_sels, ARRAY_SIZE(uart_sels));
+	hws[IMX6SLL_CLK_SPDIF_SEL]	  =3D imx_clk_hw_mux("spdif_sel",	base + 0x30,=
 20, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
+	hws[IMX6SLL_CLK_EXTERN_AUDIO_SEL] =3D imx_clk_hw_mux("extern_audio_sel", =
base + 0x30, 7,  2, spdif_sels, ARRAY_SIZE(spdif_sels));
+	hws[IMX6SLL_CLK_EPDC_PRE_SEL]	  =3D imx_clk_hw_mux("epdc_pre_sel",	base +=
 0x34, 15, 3, epdc_pre_sels, ARRAY_SIZE(epdc_pre_sels));
+	hws[IMX6SLL_CLK_EPDC_SEL]	  =3D imx_clk_hw_mux("epdc_sel",	base + 0x34, 9=
, 3, epdc_sels, ARRAY_SIZE(epdc_sels));
+	hws[IMX6SLL_CLK_ECSPI_SEL]	  =3D imx_clk_hw_mux("ecspi_sel",	base + 0x38,=
 18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
+	hws[IMX6SLL_CLK_LCDIF_PRE_SEL]	  =3D imx_clk_hw_mux("lcdif_pre_sel", base=
 + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels));
+	hws[IMX6SLL_CLK_LCDIF_SEL]	  =3D imx_clk_hw_mux("lcdif_sel", 	 base + 0x3=
8, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
+
+	hws[IMX6SLL_CLK_PERIPH]  =3D imx_clk_hw_busy_mux("periph",  base + 0x14, =
25, 1, base + 0x48, 5, periph_sels, ARRAY_SIZE(periph_sels));
+	hws[IMX6SLL_CLK_PERIPH2] =3D imx_clk_hw_busy_mux("periph2", base + 0x14, =
26, 1, base + 0x48, 3, periph2_sels, ARRAY_SIZE(periph2_sels));
+
+	hws[IMX6SLL_CLK_PERIPH_CLK2]	=3D imx_clk_hw_divider("periph_clk2",   "per=
iph_clk2_sel",  	base + 0x14, 27, 3);
+	hws[IMX6SLL_CLK_PERIPH2_CLK2]	=3D imx_clk_hw_divider("periph2_clk2",  "pe=
riph2_clk2_sel", 	base + 0x14, 0,  3);
+	hws[IMX6SLL_CLK_IPG]		=3D imx_clk_hw_divider("ipg",	   "ahb",		base + 0x1=
4, 8,	 2);
+	hws[IMX6SLL_CLK_LCDIF_PODF]	=3D imx_clk_hw_divider("lcdif_podf",	   "lcdi=
f_pred",	base + 0x18, 23, 3);
+	hws[IMX6SLL_CLK_PERCLK]	=3D imx_clk_hw_divider("perclk",	   "perclk_sel",=
	base + 0x1c, 0,  6);
+	hws[IMX6SLL_CLK_USDHC3_PODF]   =3D imx_clk_hw_divider("usdhc3_podf",   "u=
sdhc3_sel",	base + 0x24, 19, 3);
+	hws[IMX6SLL_CLK_USDHC2_PODF]	=3D imx_clk_hw_divider("usdhc2_podf",   "usd=
hc2_sel",	base + 0x24, 16, 3);
+	hws[IMX6SLL_CLK_USDHC1_PODF]	=3D imx_clk_hw_divider("usdhc1_podf",   "usd=
hc1_sel",	base + 0x24, 11, 3);
+	hws[IMX6SLL_CLK_UART_PODF]	=3D imx_clk_hw_divider("uart_podf",	   "uart_s=
el",		base + 0x24, 0,  6);
+	hws[IMX6SLL_CLK_SSI3_PRED]	=3D imx_clk_hw_divider("ssi3_pred",	   "ssi3_s=
el",		base + 0x28, 22, 3);
+	hws[IMX6SLL_CLK_SSI3_PODF]	=3D imx_clk_hw_divider("ssi3_podf",	   "ssi3_p=
red",		base + 0x28, 16, 6);
+	hws[IMX6SLL_CLK_SSI1_PRED]	=3D imx_clk_hw_divider("ssi1_pred",	   "ssi1_s=
el",		base + 0x28, 6,	 3);
+	hws[IMX6SLL_CLK_SSI1_PODF]	=3D imx_clk_hw_divider("ssi1_podf",	   "ssi1_p=
red",		base + 0x28, 0,	 6);
+	hws[IMX6SLL_CLK_SSI2_PRED]	=3D imx_clk_hw_divider("ssi2_pred",	   "ssi2_s=
el",		base + 0x2c, 6,	 3);
+	hws[IMX6SLL_CLK_SSI2_PODF]	=3D imx_clk_hw_divider("ssi2_podf",	   "ssi2_p=
red",		base + 0x2c, 0,  6);
+	hws[IMX6SLL_CLK_SPDIF_PRED]	=3D imx_clk_hw_divider("spdif_pred",	   "spdi=
f_sel",		base + 0x30, 25, 3);
+	hws[IMX6SLL_CLK_SPDIF_PODF]	=3D imx_clk_hw_divider("spdif_podf",	   "spdi=
f_pred",	base + 0x30, 22, 3);
+	hws[IMX6SLL_CLK_EXTERN_AUDIO_PRED] =3D imx_clk_hw_divider("extern_audio_p=
red", "extern_audio_sel",  base + 0x30, 12, 3);
+	hws[IMX6SLL_CLK_EXTERN_AUDIO_PODF] =3D imx_clk_hw_divider("extern_audio_p=
odf", "extern_audio_pred", base + 0x30, 9,  3);
+	hws[IMX6SLL_CLK_EPDC_PODF]  =3D imx_clk_hw_divider("epdc_podf",  "epdc_pr=
e_sel",  base + 0x34, 12, 3);
+	hws[IMX6SLL_CLK_ECSPI_PODF] =3D imx_clk_hw_divider("ecspi_podf", "ecspi_s=
el",     base + 0x38, 19, 6);
+	hws[IMX6SLL_CLK_LCDIF_PRED] =3D imx_clk_hw_divider("lcdif_pred", "lcdif_p=
re_sel", base + 0x38, 12, 3);
+
+	hws[IMX6SLL_CLK_ARM]		=3D imx_clk_hw_busy_divider("arm", 	    "pll1_sw",	=
base +	0x10, 0,  3,  base + 0x48, 16);
+	hws[IMX6SLL_CLK_MMDC_PODF]	=3D imx_clk_hw_busy_divider("mmdc_podf", "peri=
ph2",	base +  0x14, 3,  3,  base + 0x48, 2);
+	hws[IMX6SLL_CLK_AXI_PODF]	=3D imx_clk_hw_busy_divider("axi",       "axi_s=
el",	base +  0x14, 16, 3,  base + 0x48, 0);
+	hws[IMX6SLL_CLK_AHB]		=3D imx_clk_hw_busy_divider("ahb",	    "periph",	ba=
se +  0x14, 10, 3,  base + 0x48, 1);
+
+	hws[IMX6SLL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di0_div=
_3_5", "ldb_di0_sel", 2, 7);
+	hws[IMX6SLL_CLK_LDB_DI0_DIV_7]	  =3D imx_clk_hw_fixed_factor("ldb_di0_div=
_7",   "ldb_di0_sel", 1, 7);
+	hws[IMX6SLL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di1_div=
_3_5", "ldb_di1_sel", 2, 7);
+	hws[IMX6SLL_CLK_LDB_DI1_DIV_7]	  =3D imx_clk_hw_fixed_factor("ldb_di1_div=
_7",   "ldb_di1_sel", 1, 7);
+
+	hws[IMX6SLL_CLK_LDB_DI0_SEL]	=3D imx_clk_hw_mux("ldb_di0_sel", base + 0x2=
c, 9, 3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
+	hws[IMX6SLL_CLK_LDB_DI1_SEL]   =3D imx_clk_hw_mux("ldb_di1_sel", base + 0=
x1c, 7, 3, ldb_di1_sels, ARRAY_SIZE(ldb_di1_sels));
+	hws[IMX6SLL_CLK_LDB_DI0_DIV_SEL] =3D imx_clk_hw_mux("ldb_di0_div_sel", ba=
se + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
+	hws[IMX6SLL_CLK_LDB_DI1_DIV_SEL] =3D imx_clk_hw_mux("ldb_di1_div_sel", ba=
se + 0x20, 10, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
=20
 	/* CCGR0 */
-	clks[IMX6SLL_CLK_AIPSTZ1]	=3D imx_clk_gate2_flags("aips_tz1", "ahb", base=
 + 0x68, 0, CLK_IS_CRITICAL);
-	clks[IMX6SLL_CLK_AIPSTZ2]	=3D imx_clk_gate2_flags("aips_tz2", "ahb", base=
 + 0x68, 2, CLK_IS_CRITICAL);
-	clks[IMX6SLL_CLK_DCP]		=3D imx_clk_gate2("dcp", "ahb", base + 0x68, 10);
-	clks[IMX6SLL_CLK_UART2_IPG]	=3D imx_clk_gate2("uart2_ipg", "ipg", base + =
0x68, 28);
-	clks[IMX6SLL_CLK_UART2_SERIAL]	=3D imx_clk_gate2("uart2_serial",	"uart_po=
df", base + 0x68, 28);
-	clks[IMX6SLL_CLK_GPIO2]		=3D imx_clk_gate2("gpio2", "ipg", base + 0x68, 3=
0);
+	hws[IMX6SLL_CLK_AIPSTZ1]	=3D imx_clk_hw_gate2_flags("aips_tz1", "ahb", ba=
se + 0x68, 0, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_AIPSTZ2]	=3D imx_clk_hw_gate2_flags("aips_tz2", "ahb", ba=
se + 0x68, 2, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_DCP]		=3D imx_clk_hw_gate2("dcp", "ahb", base + 0x68, 10)=
;
+	hws[IMX6SLL_CLK_UART2_IPG]	=3D imx_clk_hw_gate2("uart2_ipg", "ipg", base =
+ 0x68, 28);
+	hws[IMX6SLL_CLK_UART2_SERIAL]	=3D imx_clk_hw_gate2("uart2_serial",	"uart_=
podf", base + 0x68, 28);
+	hws[IMX6SLL_CLK_GPIO2]		=3D imx_clk_hw_gate2("gpio2", "ipg", base + 0x68,=
 30);
=20
 	/* CCGR1 */
-	clks[IMX6SLL_CLK_ECSPI1]	=3D imx_clk_gate2("ecspi1",	"ecspi_podf", base +=
 0x6c, 0);
-	clks[IMX6SLL_CLK_ECSPI2]	=3D imx_clk_gate2("ecspi2",	"ecspi_podf", base +=
 0x6c, 2);
-	clks[IMX6SLL_CLK_ECSPI3]	=3D imx_clk_gate2("ecspi3",	"ecspi_podf", base +=
 0x6c, 4);
-	clks[IMX6SLL_CLK_ECSPI4]	=3D imx_clk_gate2("ecspi4",	"ecspi_podf", base +=
 0x6c, 6);
-	clks[IMX6SLL_CLK_UART3_IPG]	=3D imx_clk_gate2("uart3_ipg",	"ipg", base + =
0x6c, 10);
-	clks[IMX6SLL_CLK_UART3_SERIAL]	=3D imx_clk_gate2("uart3_serial",	"uart_po=
df", base + 0x6c, 10);
-	clks[IMX6SLL_CLK_EPIT1]		=3D imx_clk_gate2("epit1",	"perclk", base + 0x6c=
, 12);
-	clks[IMX6SLL_CLK_EPIT2]		=3D imx_clk_gate2("epit2",	"perclk", base + 0x6c=
, 14);
-	clks[IMX6SLL_CLK_GPT_BUS]	=3D imx_clk_gate2("gpt1_bus",	"perclk", base + =
0x6c, 20);
-	clks[IMX6SLL_CLK_GPT_SERIAL]	=3D imx_clk_gate2("gpt1_serial",	"perclk", b=
ase + 0x6c, 22);
-	clks[IMX6SLL_CLK_UART4_IPG]	=3D imx_clk_gate2("uart4_ipg",	"ipg", base + =
0x6c, 24);
-	clks[IMX6SLL_CLK_UART4_SERIAL]	=3D imx_clk_gate2("uart4_serail",	"uart_po=
df", base + 0x6c, 24);
-	clks[IMX6SLL_CLK_GPIO1]		=3D imx_clk_gate2("gpio1",	"ipg", base + 0x6c, 2=
6);
-	clks[IMX6SLL_CLK_GPIO5]		=3D imx_clk_gate2("gpio5",	"ipg", base + 0x6c, 3=
0);
+	hws[IMX6SLL_CLK_ECSPI1]	=3D imx_clk_hw_gate2("ecspi1",	"ecspi_podf", base=
 + 0x6c, 0);
+	hws[IMX6SLL_CLK_ECSPI2]	=3D imx_clk_hw_gate2("ecspi2",	"ecspi_podf", base=
 + 0x6c, 2);
+	hws[IMX6SLL_CLK_ECSPI3]	=3D imx_clk_hw_gate2("ecspi3",	"ecspi_podf", base=
 + 0x6c, 4);
+	hws[IMX6SLL_CLK_ECSPI4]	=3D imx_clk_hw_gate2("ecspi4",	"ecspi_podf", base=
 + 0x6c, 6);
+	hws[IMX6SLL_CLK_UART3_IPG]	=3D imx_clk_hw_gate2("uart3_ipg",	"ipg", base =
+ 0x6c, 10);
+	hws[IMX6SLL_CLK_UART3_SERIAL]	=3D imx_clk_hw_gate2("uart3_serial",	"uart_=
podf", base + 0x6c, 10);
+	hws[IMX6SLL_CLK_EPIT1]		=3D imx_clk_hw_gate2("epit1",	"perclk", base + 0x=
6c, 12);
+	hws[IMX6SLL_CLK_EPIT2]		=3D imx_clk_hw_gate2("epit2",	"perclk", base + 0x=
6c, 14);
+	hws[IMX6SLL_CLK_GPT_BUS]	=3D imx_clk_hw_gate2("gpt1_bus",	"perclk", base =
+ 0x6c, 20);
+	hws[IMX6SLL_CLK_GPT_SERIAL]	=3D imx_clk_hw_gate2("gpt1_serial",	"perclk",=
 base + 0x6c, 22);
+	hws[IMX6SLL_CLK_UART4_IPG]	=3D imx_clk_hw_gate2("uart4_ipg",	"ipg", base =
+ 0x6c, 24);
+	hws[IMX6SLL_CLK_UART4_SERIAL]	=3D imx_clk_hw_gate2("uart4_serail",	"uart_=
podf", base + 0x6c, 24);
+	hws[IMX6SLL_CLK_GPIO1]		=3D imx_clk_hw_gate2("gpio1",	"ipg", base + 0x6c,=
 26);
+	hws[IMX6SLL_CLK_GPIO5]		=3D imx_clk_hw_gate2("gpio5",	"ipg", base + 0x6c,=
 30);
=20
 	/* CCGR2 */
-	clks[IMX6SLL_CLK_GPIO6]		=3D imx_clk_gate2("gpio6",	"ipg",    base + 0x70=
, 0);
-	clks[IMX6SLL_CLK_CSI]		=3D imx_clk_gate2("csi",		"axi",    base + 0x70,	2=
);
-	clks[IMX6SLL_CLK_I2C1]		=3D imx_clk_gate2("i2c1",		"perclk", base + 0x70,=
	6);
-	clks[IMX6SLL_CLK_I2C2]		=3D imx_clk_gate2("i2c2",		"perclk", base + 0x70,=
	8);
-	clks[IMX6SLL_CLK_I2C3]		=3D imx_clk_gate2("i2c3",		"perclk", base + 0x70,=
	10);
-	clks[IMX6SLL_CLK_OCOTP]		=3D imx_clk_gate2("ocotp",	"ipg",    base + 0x70=
,	12);
-	clks[IMX6SLL_CLK_GPIO3]		=3D imx_clk_gate2("gpio3",	"ipg",    base + 0x70=
,	26);
-	clks[IMX6SLL_CLK_LCDIF_APB]	=3D imx_clk_gate2("lcdif_apb",	"axi",    base=
 + 0x70,	28);
-	clks[IMX6SLL_CLK_PXP]		=3D imx_clk_gate2("pxp",		"axi",    base + 0x70,	3=
0);
+	hws[IMX6SLL_CLK_GPIO6]		=3D imx_clk_hw_gate2("gpio6",	"ipg",    base + 0x=
70, 0);
+	hws[IMX6SLL_CLK_CSI]		=3D imx_clk_hw_gate2("csi",		"axi",    base + 0x70,=
	2);
+	hws[IMX6SLL_CLK_I2C1]		=3D imx_clk_hw_gate2("i2c1",		"perclk", base + 0x7=
0,	6);
+	hws[IMX6SLL_CLK_I2C2]		=3D imx_clk_hw_gate2("i2c2",		"perclk", base + 0x7=
0,	8);
+	hws[IMX6SLL_CLK_I2C3]		=3D imx_clk_hw_gate2("i2c3",		"perclk", base + 0x7=
0,	10);
+	hws[IMX6SLL_CLK_OCOTP]		=3D imx_clk_hw_gate2("ocotp",	"ipg",    base + 0x=
70,	12);
+	hws[IMX6SLL_CLK_GPIO3]		=3D imx_clk_hw_gate2("gpio3",	"ipg",    base + 0x=
70,	26);
+	hws[IMX6SLL_CLK_LCDIF_APB]	=3D imx_clk_hw_gate2("lcdif_apb",	"axi",    ba=
se + 0x70,	28);
+	hws[IMX6SLL_CLK_PXP]		=3D imx_clk_hw_gate2("pxp",		"axi",    base + 0x70,=
	30);
=20
 	/* CCGR3 */
-	clks[IMX6SLL_CLK_UART5_IPG]	=3D imx_clk_gate2("uart5_ipg",	"ipg",		base +=
 0x74, 2);
-	clks[IMX6SLL_CLK_UART5_SERIAL]	=3D imx_clk_gate2("uart5_serial",	"uart_po=
df",	base + 0x74, 2);
-	clks[IMX6SLL_CLK_EPDC_AXI]	=3D imx_clk_gate2("epdc_aclk",	"axi",		base + =
0x74, 4);
-	clks[IMX6SLL_CLK_EPDC_PIX]	=3D imx_clk_gate2("epdc_pix",	"epdc_podf",	bas=
e + 0x74, 4);
-	clks[IMX6SLL_CLK_LCDIF_PIX]	=3D imx_clk_gate2("lcdif_pix",	"lcdif_podf",	=
base + 0x74, 10);
-	clks[IMX6SLL_CLK_GPIO4]		=3D imx_clk_gate2("gpio4",	"ipg",		base + 0x74, =
12);
-	clks[IMX6SLL_CLK_WDOG1]		=3D imx_clk_gate2("wdog1",	"ipg",		base + 0x74, =
16);
-	clks[IMX6SLL_CLK_MMDC_P0_FAST]	=3D imx_clk_gate_flags("mmdc_p0_fast", "mm=
dc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
-	clks[IMX6SLL_CLK_MMDC_P0_IPG]	=3D imx_clk_gate2_flags("mmdc_p0_ipg", "ipg=
",	   base + 0x74,	24, CLK_IS_CRITICAL);
-	clks[IMX6SLL_CLK_MMDC_P1_IPG]	=3D imx_clk_gate2("mmdc_p1_ipg", "ipg",	   =
base + 0x74,	26);
-	clks[IMX6SLL_CLK_OCRAM]		=3D imx_clk_gate_flags("ocram","ahb",		   base +=
 0x74,	28, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_UART5_IPG]	=3D imx_clk_hw_gate2("uart5_ipg",	"ipg",		base=
 + 0x74, 2);
+	hws[IMX6SLL_CLK_UART5_SERIAL]	=3D imx_clk_hw_gate2("uart5_serial",	"uart_=
podf",	base + 0x74, 2);
+	hws[IMX6SLL_CLK_EPDC_AXI]	=3D imx_clk_hw_gate2("epdc_aclk",	"axi",		base =
+ 0x74, 4);
+	hws[IMX6SLL_CLK_EPDC_PIX]	=3D imx_clk_hw_gate2("epdc_pix",	"epdc_podf",	b=
ase + 0x74, 4);
+	hws[IMX6SLL_CLK_LCDIF_PIX]	=3D imx_clk_hw_gate2("lcdif_pix",	"lcdif_podf"=
,	base + 0x74, 10);
+	hws[IMX6SLL_CLK_GPIO4]		=3D imx_clk_hw_gate2("gpio4",	"ipg",		base + 0x74=
, 12);
+	hws[IMX6SLL_CLK_WDOG1]		=3D imx_clk_hw_gate2("wdog1",	"ipg",		base + 0x74=
, 16);
+	hws[IMX6SLL_CLK_MMDC_P0_FAST]	=3D imx_clk_hw_gate_flags("mmdc_p0_fast", "=
mmdc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_MMDC_P0_IPG]	=3D imx_clk_hw_gate2_flags("mmdc_p0_ipg", "i=
pg",	   base + 0x74,	24, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_MMDC_P1_IPG]	=3D imx_clk_hw_gate2("mmdc_p1_ipg", "ipg",	 =
  base + 0x74,	26);
+	hws[IMX6SLL_CLK_OCRAM]		=3D imx_clk_hw_gate_flags("ocram","ahb",		   base=
 + 0x74,	28, CLK_IS_CRITICAL);
=20
 	/* CCGR4 */
-	clks[IMX6SLL_CLK_PWM1]		=3D imx_clk_gate2("pwm1", "perclk", base + 0x78, =
16);
-	clks[IMX6SLL_CLK_PWM2]		=3D imx_clk_gate2("pwm2", "perclk", base + 0x78, =
18);
-	clks[IMX6SLL_CLK_PWM3]		=3D imx_clk_gate2("pwm3", "perclk", base + 0x78, =
20);
-	clks[IMX6SLL_CLK_PWM4]		=3D imx_clk_gate2("pwm4", "perclk", base + 0x78, =
22);
+	hws[IMX6SLL_CLK_PWM1]		=3D imx_clk_hw_gate2("pwm1", "perclk", base + 0x78=
, 16);
+	hws[IMX6SLL_CLK_PWM2]		=3D imx_clk_hw_gate2("pwm2", "perclk", base + 0x78=
, 18);
+	hws[IMX6SLL_CLK_PWM3]		=3D imx_clk_hw_gate2("pwm3", "perclk", base + 0x78=
, 20);
+	hws[IMX6SLL_CLK_PWM4]		=3D imx_clk_hw_gate2("pwm4", "perclk", base + 0x78=
, 22);
=20
 	/* CCGR5 */
-	clks[IMX6SLL_CLK_ROM]		=3D imx_clk_gate2_flags("rom", "ahb", base + 0x7c,=
 0, CLK_IS_CRITICAL);
-	clks[IMX6SLL_CLK_SDMA]		=3D imx_clk_gate2("sdma",	 "ahb",	base + 0x7c, 6)=
;
-	clks[IMX6SLL_CLK_WDOG2]		=3D imx_clk_gate2("wdog2", "ipg",	base + 0x7c, 1=
0);
-	clks[IMX6SLL_CLK_SPBA]		=3D imx_clk_gate2("spba",	 "ipg",	base + 0x7c, 12=
);
-	clks[IMX6SLL_CLK_EXTERN_AUDIO]	=3D imx_clk_gate2_shared("extern_audio",  =
"extern_audio_podf", base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SLL_CLK_SPDIF]		=3D imx_clk_gate2_shared("spdif",		"spdif_podf",=
	base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SLL_CLK_SPDIF_GCLK]	=3D imx_clk_gate2_shared("spdif_gclk",	"ipg"=
,		base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SLL_CLK_SSI1]		=3D imx_clk_gate2_shared("ssi1",		"ssi1_podf",	ba=
se + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SLL_CLK_SSI1_IPG]	=3D imx_clk_gate2_shared("ssi1_ipg",	"ipg",		b=
ase + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SLL_CLK_SSI2]		=3D imx_clk_gate2_shared("ssi2",		"ssi2_podf",	ba=
se + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SLL_CLK_SSI2_IPG]	=3D imx_clk_gate2_shared("ssi2_ipg",	"ipg",		b=
ase + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SLL_CLK_SSI3]		=3D imx_clk_gate2_shared("ssi3",		"ssi3_podf",	ba=
se + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SLL_CLK_SSI3_IPG]	=3D imx_clk_gate2_shared("ssi3_ipg",	"ipg",		b=
ase + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SLL_CLK_UART1_IPG]	=3D imx_clk_gate2("uart1_ipg",	"ipg",		base +=
 0x7c, 24);
-	clks[IMX6SLL_CLK_UART1_SERIAL]	=3D imx_clk_gate2("uart1_serial",	"uart_po=
df",	base + 0x7c, 24);
+	hws[IMX6SLL_CLK_ROM]		=3D imx_clk_hw_gate2_flags("rom", "ahb", base + 0x7=
c, 0, CLK_IS_CRITICAL);
+	hws[IMX6SLL_CLK_SDMA]		=3D imx_clk_hw_gate2("sdma",	 "ahb",	base + 0x7c, =
6);
+	hws[IMX6SLL_CLK_WDOG2]		=3D imx_clk_hw_gate2("wdog2", "ipg",	base + 0x7c,=
 10);
+	hws[IMX6SLL_CLK_SPBA]		=3D imx_clk_hw_gate2("spba",	 "ipg",	base + 0x7c, =
12);
+	hws[IMX6SLL_CLK_EXTERN_AUDIO]	=3D imx_clk_hw_gate2_shared("extern_audio",=
  "extern_audio_podf", base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SLL_CLK_SPDIF]		=3D imx_clk_hw_gate2_shared("spdif",		"spdif_podf=
",	base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SLL_CLK_SPDIF_GCLK]	=3D imx_clk_hw_gate2_shared("spdif_gclk",	"ip=
g",		base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SLL_CLK_SSI1]		=3D imx_clk_hw_gate2_shared("ssi1",		"ssi1_podf",	=
base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SLL_CLK_SSI1_IPG]	=3D imx_clk_hw_gate2_shared("ssi1_ipg",	"ipg",	=
	base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SLL_CLK_SSI2]		=3D imx_clk_hw_gate2_shared("ssi2",		"ssi2_podf",	=
base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SLL_CLK_SSI2_IPG]	=3D imx_clk_hw_gate2_shared("ssi2_ipg",	"ipg",	=
	base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SLL_CLK_SSI3]		=3D imx_clk_hw_gate2_shared("ssi3",		"ssi3_podf",	=
base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SLL_CLK_SSI3_IPG]	=3D imx_clk_hw_gate2_shared("ssi3_ipg",	"ipg",	=
	base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SLL_CLK_UART1_IPG]	=3D imx_clk_hw_gate2("uart1_ipg",	"ipg",		base=
 + 0x7c, 24);
+	hws[IMX6SLL_CLK_UART1_SERIAL]	=3D imx_clk_hw_gate2("uart1_serial",	"uart_=
podf",	base + 0x7c, 24);
=20
 	/* CCGR6 */
-	clks[IMX6SLL_CLK_USBOH3]	=3D imx_clk_gate2("usboh3", "ipg",	  base + 0x80=
,	0);
-	clks[IMX6SLL_CLK_USDHC1]	=3D imx_clk_gate2("usdhc1", "usdhc1_podf",  base=
 + 0x80,	2);
-	clks[IMX6SLL_CLK_USDHC2]	=3D imx_clk_gate2("usdhc2", "usdhc2_podf",  base=
 + 0x80,	4);
-	clks[IMX6SLL_CLK_USDHC3]	=3D imx_clk_gate2("usdhc3", "usdhc3_podf",  base=
 + 0x80,	6);
+	hws[IMX6SLL_CLK_USBOH3]	=3D imx_clk_hw_gate2("usboh3", "ipg",	  base + 0x=
80,	0);
+	hws[IMX6SLL_CLK_USDHC1]	=3D imx_clk_hw_gate2("usdhc1", "usdhc1_podf",  ba=
se + 0x80,	2);
+	hws[IMX6SLL_CLK_USDHC2]	=3D imx_clk_hw_gate2("usdhc2", "usdhc2_podf",  ba=
se + 0x80,	4);
+	hws[IMX6SLL_CLK_USDHC3]	=3D imx_clk_hw_gate2("usdhc3", "usdhc3_podf",  ba=
se + 0x80,	6);
=20
 	/* mask handshake of mmdc */
 	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + 0x4);
=20
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
+	imx_check_clk_hws(hws, IMX6SLL_CLK_END);
=20
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
=20
 	/* Lower the AHB clock rate before changing the clock source. */
-	clk_set_rate(clks[IMX6SLL_CLK_AHB], 99000000);
+	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 99000000);
=20
 	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
-	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_CLK2_SEL], clks[IMX6SLL_CLK_PLL3_U=
SB_OTG]);
-	clk_set_parent(clks[IMX6SLL_CLK_PERIPH], clks[IMX6SLL_CLK_PERIPH_CLK2]);
-	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_PRE], clks[IMX6SLL_CLK_PLL2_BUS]);
-	clk_set_parent(clks[IMX6SLL_CLK_PERIPH], clks[IMX6SLL_CLK_PERIPH_PRE]);
+	clk_set_parent(hws[IMX6SLL_CLK_PERIPH_CLK2_SEL]->clk, hws[IMX6SLL_CLK_PLL=
3_USB_OTG]->clk);
+	clk_set_parent(hws[IMX6SLL_CLK_PERIPH]->clk, hws[IMX6SLL_CLK_PERIPH_CLK2]=
->clk);
+	clk_set_parent(hws[IMX6SLL_CLK_PERIPH_PRE]->clk, hws[IMX6SLL_CLK_PLL2_BUS=
]->clk);
+	clk_set_parent(hws[IMX6SLL_CLK_PERIPH]->clk, hws[IMX6SLL_CLK_PERIPH_PRE]-=
>clk);
=20
-	clk_set_rate(clks[IMX6SLL_CLK_AHB], 132000000);
+	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 132000000);
 }
 CLK_OF_DECLARE_DRIVER(imx6sll, "fsl,imx6sll-ccm", imx6sll_clocks_init);
--=20
2.7.4

