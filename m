Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA56DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D54218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+JpRc9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCVPhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:34 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:8337
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfCVPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EHa23J+KjWkkgUpaVcrFa52VNAseHU6s2Cx03ZXbsg=;
 b=a+JpRc9wBw6Yyvpa3CV3xIm5cQxgmWbq6eFoaryxwircP4ARR/i0q0SNRrK4Djs9QfE+FEZMd6HaaxlYj/GUFZk2ZgMbcZbmriZWELGDUSwcghvRVVpilr4iVIOrke/7LJTB/1brRNbyMVrXmDuozx8BRPRdaZNsS7WdHJ5PXmQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:20 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:20 +0000
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
Subject: [RFC 16/19] clk: imx6sx: Switch to clk_hw based API
Thread-Topic: [RFC 16/19] clk: imx6sx: Switch to clk_hw based API
Thread-Index: AQHU4MUihKvMu4dn6E6sAJQAGj9naA==
Date:   Fri, 22 Mar 2019 15:37:20 +0000
Message-ID: <1553269010-15591-17-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: b350f309-bbc0-46f2-525c-08d6aedc4514
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802BF8D9338DAB81750E388F6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(14444005)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(53946003)(26005)(186003)(105586002)(102836004)(6436002)(30864003)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002)(32563001)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bT5SxSKJXLMa2fL527RxfACr1gtFdq6zeOQ8mDpA38s+aJRsdDz44UGv5Z3ygVsNqD9Drx8nFQ6566YxH2wejORSZHkVVxZD90H/i9zAL6vgAxVrKMTXc4DuppQiCcFSDMDdddXyG5jGCWYlKmrp+E0dSsX5ynGUChBoXIJ3hfzsdvTTHcbqP3vRertGdIUtHFXrmMycqV8iE4wd9Ir5TkD7IIKKu184TFah2o0+0Fg+L5RoWELmjOkxIyPTOPMRvssGhVCT2poQM0sK4FPajH9dTOs0fL04y7WDbUhKcH/ioeYHLPpJjHIIwwwidm+0xghWn3rbFGvXjc3rQmG+ZF0y75lYywZuwOgRhsCVnMzXKSIPZFU+1V3Oaj7za2l3ukG4ZDRwLh/BZGbbHPGHn8fDXDz4uSKRhdXaxNamNi4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b350f309-bbc0-46f2-525c-08d6aedc4514
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:20.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx6sx driver to clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 654 ++++++++++++++++++++++-----------------=
----
 1 file changed, 334 insertions(+), 320 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 4ed180c..bd8ee9a 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -89,8 +89,8 @@ static const char *pll5_bypass_sels[] =3D { "pll5", "pll5=
_bypass_src", };
 static const char *pll6_bypass_sels[] =3D { "pll6", "pll6_bypass_src", };
 static const char *pll7_bypass_sels[] =3D { "pll7", "pll7_bypass_src", };
=20
-static struct clk *clks[IMX6SX_CLK_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
=20
 static const struct clk_div_table clk_enet_ref_table[] =3D {
 	{ .val =3D 0, .div =3D 20, },
@@ -124,76 +124,86 @@ static u32 share_count_ssi3;
 static u32 share_count_sai1;
 static u32 share_count_sai2;
=20
-static struct clk ** const uart_clks[] __initconst =3D {
-	&clks[IMX6SX_CLK_UART_IPG],
-	&clks[IMX6SX_CLK_UART_SERIAL],
-	NULL
+static const int uart_clk_ids[] __initconst =3D {
+	IMX6SX_CLK_UART_IPG,
+	IMX6SX_CLK_UART_SERIAL,
 };
=20
+static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
+
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
+	int i;
+
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX6SX_CLK_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
+
+	clk_hw_data->num =3D IMX6SX_CLK_CLK_END;
+	hws =3D clk_hw_data->hws;
=20
-	clks[IMX6SX_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
+	hws[IMX6SX_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
=20
-	clks[IMX6SX_CLK_CKIL] =3D of_clk_get_by_name(ccm_node, "ckil");
-	clks[IMX6SX_CLK_OSC] =3D of_clk_get_by_name(ccm_node, "osc");
+	hws[IMX6SX_CLK_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil"=
));
+	hws[IMX6SX_CLK_OSC] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc"))=
;
=20
 	/* ipp_di clock is external input */
-	clks[IMX6SX_CLK_IPP_DI0] =3D of_clk_get_by_name(ccm_node, "ipp_di0");
-	clks[IMX6SX_CLK_IPP_DI1] =3D of_clk_get_by_name(ccm_node, "ipp_di1");
+	hws[IMX6SX_CLK_IPP_DI0] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di0"));
+	hws[IMX6SX_CLK_IPP_DI1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di1"));
=20
 	/* Clock source from external clock via CLK1/2 PAD */
-	clks[IMX6SX_CLK_ANACLK1] =3D of_clk_get_by_name(ccm_node, "anaclk1");
-	clks[IMX6SX_CLK_ANACLK2] =3D of_clk_get_by_name(ccm_node, "anaclk2");
+	hws[IMX6SX_CLK_ANACLK1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "an=
aclk1"));
+	hws[IMX6SX_CLK_ANACLK2] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "an=
aclk2"));
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
 	of_node_put(np);
=20
-	clks[IMX6SX_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL2_BYPASS_SRC] =3D imx_clk_mux("pll2_bypass_src", base + 0x=
30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL3_BYPASS_SRC] =3D imx_clk_mux("pll3_bypass_src", base + 0x=
10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL4_BYPASS_SRC] =3D imx_clk_mux("pll4_bypass_src", base + 0x=
70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL5_BYPASS_SRC] =3D imx_clk_mux("pll5_bypass_src", base + 0x=
a0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL6_BYPASS_SRC] =3D imx_clk_mux("pll6_bypass_src", base + 0x=
e0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SX_PLL7_BYPASS_SRC] =3D imx_clk_mux("pll7_bypass_src", base + 0x=
20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL1_BYPASS_SRC] =3D imx_clk_hw_mux("pll1_bypass_src", base + =
0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL2_BYPASS_SRC] =3D imx_clk_hw_mux("pll2_bypass_src", base + =
0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL3_BYPASS_SRC] =3D imx_clk_hw_mux("pll3_bypass_src", base + =
0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL4_BYPASS_SRC] =3D imx_clk_hw_mux("pll4_bypass_src", base + =
0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL5_BYPASS_SRC] =3D imx_clk_hw_mux("pll5_bypass_src", base + =
0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL6_BYPASS_SRC] =3D imx_clk_hw_mux("pll6_bypass_src", base + =
0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SX_PLL7_BYPASS_SRC] =3D imx_clk_hw_mux("pll7_bypass_src", base + =
0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
=20
 	/*                                    type               name    parent_n=
ame        base         div_mask */
-	clks[IMX6SX_CLK_PLL1] =3D imx_clk_pllv3(IMX_PLLV3_SYS,     "pll1", "osc",=
 base + 0x00, 0x7f);
-	clks[IMX6SX_CLK_PLL2] =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc",=
 base + 0x30, 0x1);
-	clks[IMX6SX_CLK_PLL3] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll3", "osc",=
 base + 0x10, 0x3);
-	clks[IMX6SX_CLK_PLL4] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll4", "osc",=
 base + 0x70, 0x7f);
-	clks[IMX6SX_CLK_PLL5] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll5", "osc",=
 base + 0xa0, 0x7f);
-	clks[IMX6SX_CLK_PLL6] =3D imx_clk_pllv3(IMX_PLLV3_ENET,    "pll6", "osc",=
 base + 0xe0, 0x3);
-	clks[IMX6SX_CLK_PLL7] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll7", "osc",=
 base + 0x20, 0x3);
-
-	clks[IMX6SX_PLL1_BYPASS] =3D imx_clk_mux_flags("pll1_bypass", base + 0x00=
, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL2_BYPASS] =3D imx_clk_mux_flags("pll2_bypass", base + 0x30=
, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL3_BYPASS] =3D imx_clk_mux_flags("pll3_bypass", base + 0x10=
, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL4_BYPASS] =3D imx_clk_mux_flags("pll4_bypass", base + 0x70=
, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL5_BYPASS] =3D imx_clk_mux_flags("pll5_bypass", base + 0xa0=
, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL6_BYPASS] =3D imx_clk_mux_flags("pll6_bypass", base + 0xe0=
, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SX_PLL7_BYPASS] =3D imx_clk_mux_flags("pll7_bypass", base + 0x20=
, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAREN=
T);
+	hws[IMX6SX_CLK_PLL1] =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc=
", base + 0x00, 0x7f);
+	hws[IMX6SX_CLK_PLL2] =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc=
", base + 0x30, 0x1);
+	hws[IMX6SX_CLK_PLL3] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc=
", base + 0x10, 0x3);
+	hws[IMX6SX_CLK_PLL4] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc=
", base + 0x70, 0x7f);
+	hws[IMX6SX_CLK_PLL5] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc=
", base + 0xa0, 0x7f);
+	hws[IMX6SX_CLK_PLL6] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc=
", base + 0xe0, 0x3);
+	hws[IMX6SX_CLK_PLL7] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc=
", base + 0x20, 0x3);
+
+	hws[IMX6SX_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("pll1_bypass", base + 0x=
00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("pll2_bypass", base + 0x=
30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("pll3_bypass", base + 0x=
10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL4_BYPASS] =3D imx_clk_hw_mux_flags("pll4_bypass", base + 0x=
70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL5_BYPASS] =3D imx_clk_hw_mux_flags("pll5_bypass", base + 0x=
a0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL6_BYPASS] =3D imx_clk_hw_mux_flags("pll6_bypass", base + 0x=
e0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SX_PLL7_BYPASS] =3D imx_clk_hw_mux_flags("pll7_bypass", base + 0x=
20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAR=
ENT);
=20
 	/* Do not bypass PLLs initially */
-	clk_set_parent(clks[IMX6SX_PLL1_BYPASS], clks[IMX6SX_CLK_PLL1]);
-	clk_set_parent(clks[IMX6SX_PLL2_BYPASS], clks[IMX6SX_CLK_PLL2]);
-	clk_set_parent(clks[IMX6SX_PLL3_BYPASS], clks[IMX6SX_CLK_PLL3]);
-	clk_set_parent(clks[IMX6SX_PLL4_BYPASS], clks[IMX6SX_CLK_PLL4]);
-	clk_set_parent(clks[IMX6SX_PLL5_BYPASS], clks[IMX6SX_CLK_PLL5]);
-	clk_set_parent(clks[IMX6SX_PLL6_BYPASS], clks[IMX6SX_CLK_PLL6]);
-	clk_set_parent(clks[IMX6SX_PLL7_BYPASS], clks[IMX6SX_CLK_PLL7]);
-
-	clks[IMX6SX_CLK_PLL1_SYS]      =3D imx_clk_gate("pll1_sys",      "pll1_by=
pass", base + 0x00, 13);
-	clks[IMX6SX_CLK_PLL2_BUS]      =3D imx_clk_gate("pll2_bus",      "pll2_by=
pass", base + 0x30, 13);
-	clks[IMX6SX_CLK_PLL3_USB_OTG]  =3D imx_clk_gate("pll3_usb_otg",  "pll3_by=
pass", base + 0x10, 13);
-	clks[IMX6SX_CLK_PLL4_AUDIO]    =3D imx_clk_gate("pll4_audio",    "pll4_by=
pass", base + 0x70, 13);
-	clks[IMX6SX_CLK_PLL5_VIDEO]    =3D imx_clk_gate("pll5_video",    "pll5_by=
pass", base + 0xa0, 13);
-	clks[IMX6SX_CLK_PLL6_ENET]     =3D imx_clk_gate("pll6_enet",     "pll6_by=
pass", base + 0xe0, 13);
-	clks[IMX6SX_CLK_PLL7_USB_HOST] =3D imx_clk_gate("pll7_usb_host", "pll7_by=
pass", base + 0x20, 13);
+	clk_set_parent(hws[IMX6SX_PLL1_BYPASS]->clk, hws[IMX6SX_CLK_PLL1]->clk);
+	clk_set_parent(hws[IMX6SX_PLL2_BYPASS]->clk, hws[IMX6SX_CLK_PLL2]->clk);
+	clk_set_parent(hws[IMX6SX_PLL3_BYPASS]->clk, hws[IMX6SX_CLK_PLL3]->clk);
+	clk_set_parent(hws[IMX6SX_PLL4_BYPASS]->clk, hws[IMX6SX_CLK_PLL4]->clk);
+	clk_set_parent(hws[IMX6SX_PLL5_BYPASS]->clk, hws[IMX6SX_CLK_PLL5]->clk);
+	clk_set_parent(hws[IMX6SX_PLL6_BYPASS]->clk, hws[IMX6SX_CLK_PLL6]->clk);
+	clk_set_parent(hws[IMX6SX_PLL7_BYPASS]->clk, hws[IMX6SX_CLK_PLL7]->clk);
+
+	hws[IMX6SX_CLK_PLL1_SYS]      =3D imx_clk_hw_gate("pll1_sys",      "pll1_=
bypass", base + 0x00, 13);
+	hws[IMX6SX_CLK_PLL2_BUS]      =3D imx_clk_hw_gate("pll2_bus",      "pll2_=
bypass", base + 0x30, 13);
+	hws[IMX6SX_CLK_PLL3_USB_OTG]  =3D imx_clk_hw_gate("pll3_usb_otg",  "pll3_=
bypass", base + 0x10, 13);
+	hws[IMX6SX_CLK_PLL4_AUDIO]    =3D imx_clk_hw_gate("pll4_audio",    "pll4_=
bypass", base + 0x70, 13);
+	hws[IMX6SX_CLK_PLL5_VIDEO]    =3D imx_clk_hw_gate("pll5_video",    "pll5_=
bypass", base + 0xa0, 13);
+	hws[IMX6SX_CLK_PLL6_ENET]     =3D imx_clk_hw_gate("pll6_enet",     "pll6_=
bypass", base + 0xe0, 13);
+	hws[IMX6SX_CLK_PLL7_USB_HOST] =3D imx_clk_hw_gate("pll7_usb_host", "pll7_=
bypass", base + 0x20, 13);
=20
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
@@ -201,359 +211,363 @@ static void __init imx6sx_clocks_init(struct device=
_node *ccm_node)
 	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
 	 * the clk framework may need to enable/disable usbphy's parent
 	 */
-	clks[IMX6SX_CLK_USBPHY1] =3D imx_clk_gate("usbphy1", "pll3_usb_otg",  bas=
e + 0x10, 20);
-	clks[IMX6SX_CLK_USBPHY2] =3D imx_clk_gate("usbphy2", "pll7_usb_host", bas=
e + 0x20, 20);
+	hws[IMX6SX_CLK_USBPHY1] =3D imx_clk_hw_gate("usbphy1", "pll3_usb_otg",  b=
ase + 0x10, 20);
+	hws[IMX6SX_CLK_USBPHY2] =3D imx_clk_hw_gate("usbphy2", "pll7_usb_host", b=
ase + 0x20, 20);
=20
 	/*
 	 * usbphy*_gate needs to be on after system boots up, and software
 	 * never needs to control it anymore.
 	 */
-	clks[IMX6SX_CLK_USBPHY1_GATE] =3D imx_clk_gate("usbphy1_gate", "dummy", b=
ase + 0x10, 6);
-	clks[IMX6SX_CLK_USBPHY2_GATE] =3D imx_clk_gate("usbphy2_gate", "dummy", b=
ase + 0x20, 6);
+	hws[IMX6SX_CLK_USBPHY1_GATE] =3D imx_clk_hw_gate("usbphy1_gate", "dummy",=
 base + 0x10, 6);
+	hws[IMX6SX_CLK_USBPHY2_GATE] =3D imx_clk_hw_gate("usbphy2_gate", "dummy",=
 base + 0x20, 6);
=20
 	/* FIXME 100MHz is used for pcie ref for all imx6 pcie, excepted imx6q */
-	clks[IMX6SX_CLK_PCIE_REF] =3D imx_clk_fixed_factor("pcie_ref", "pll6_enet=
", 1, 5);
-	clks[IMX6SX_CLK_PCIE_REF_125M] =3D imx_clk_gate("pcie_ref_125m", "pcie_re=
f", base + 0xe0, 19);
+	hws[IMX6SX_CLK_PCIE_REF] =3D imx_clk_hw_fixed_factor("pcie_ref", "pll6_en=
et", 1, 5);
+	hws[IMX6SX_CLK_PCIE_REF_125M] =3D imx_clk_hw_gate("pcie_ref_125m", "pcie_=
ref", base + 0xe0, 19);
=20
-	clks[IMX6SX_CLK_LVDS1_OUT] =3D imx_clk_gate_exclusive("lvds1_out", "lvds1=
_sel", base + 0x160, 10, BIT(12));
-	clks[IMX6SX_CLK_LVDS2_OUT] =3D imx_clk_gate_exclusive("lvds2_out", "lvds2=
_sel", base + 0x160, 11, BIT(13));
-	clks[IMX6SX_CLK_LVDS1_IN]  =3D imx_clk_gate_exclusive("lvds1_in",  "anacl=
k1",   base + 0x160, 12, BIT(10));
-	clks[IMX6SX_CLK_LVDS2_IN]  =3D imx_clk_gate_exclusive("lvds2_in",  "anacl=
k2",   base + 0x160, 13, BIT(11));
+	hws[IMX6SX_CLK_LVDS1_OUT] =3D imx_clk_hw_gate_exclusive("lvds1_out", "lvd=
s1_sel", base + 0x160, 10, BIT(12));
+	hws[IMX6SX_CLK_LVDS2_OUT] =3D imx_clk_hw_gate_exclusive("lvds2_out", "lvd=
s2_sel", base + 0x160, 11, BIT(13));
+	hws[IMX6SX_CLK_LVDS1_IN]  =3D imx_clk_hw_gate_exclusive("lvds1_in",  "ana=
clk1",   base + 0x160, 12, BIT(10));
+	hws[IMX6SX_CLK_LVDS2_IN]  =3D imx_clk_hw_gate_exclusive("lvds2_in",  "ana=
clk2",   base + 0x160, 13, BIT(11));
=20
-	clks[IMX6SX_CLK_ENET_REF] =3D clk_register_divider_table(NULL, "enet_ref"=
, "pll6_enet", 0,
+	hws[IMX6SX_CLK_ENET_REF] =3D clk_hw_register_divider_table(NULL, "enet_re=
f", "pll6_enet", 0,
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
 			&imx_ccm_lock);
-	clks[IMX6SX_CLK_ENET2_REF] =3D clk_register_divider_table(NULL, "enet2_re=
f", "pll6_enet", 0,
+	hws[IMX6SX_CLK_ENET2_REF] =3D clk_hw_register_divider_table(NULL, "enet2_=
ref", "pll6_enet", 0,
 			base + 0xe0, 2, 2, 0, clk_enet_ref_table,
 			&imx_ccm_lock);
-	clks[IMX6SX_CLK_ENET2_REF_125M] =3D imx_clk_gate("enet2_ref_125m", "enet2=
_ref", base + 0xe0, 20);
+	hws[IMX6SX_CLK_ENET2_REF_125M] =3D imx_clk_hw_gate("enet2_ref_125m", "ene=
t2_ref", base + 0xe0, 20);
=20
-	clks[IMX6SX_CLK_ENET_PTP_REF] =3D imx_clk_fixed_factor("enet_ptp_ref", "p=
ll6_enet", 1, 20);
-	clks[IMX6SX_CLK_ENET_PTP] =3D imx_clk_gate("enet_ptp_25m", "enet_ptp_ref"=
, base + 0xe0, 21);
+	hws[IMX6SX_CLK_ENET_PTP_REF] =3D imx_clk_hw_fixed_factor("enet_ptp_ref", =
"pll6_enet", 1, 20);
+	hws[IMX6SX_CLK_ENET_PTP] =3D imx_clk_hw_gate("enet_ptp_25m", "enet_ptp_re=
f", base + 0xe0, 21);
=20
 	/*                                       name              parent_name   =
  reg           idx */
-	clks[IMX6SX_CLK_PLL2_PFD0] =3D imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", =
    base + 0x100, 0);
-	clks[IMX6SX_CLK_PLL2_PFD1] =3D imx_clk_pfd("pll2_pfd1_594m", "pll2_bus", =
    base + 0x100, 1);
-	clks[IMX6SX_CLK_PLL2_PFD2] =3D imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", =
    base + 0x100, 2);
-	clks[IMX6SX_CLK_PLL2_PFD3] =3D imx_clk_pfd("pll2_pfd3_594m", "pll2_bus", =
    base + 0x100, 3);
-	clks[IMX6SX_CLK_PLL3_PFD0] =3D imx_clk_pfd("pll3_pfd0_720m", "pll3_usb_ot=
g", base + 0xf0,  0);
-	clks[IMX6SX_CLK_PLL3_PFD1] =3D imx_clk_pfd("pll3_pfd1_540m", "pll3_usb_ot=
g", base + 0xf0,  1);
-	clks[IMX6SX_CLK_PLL3_PFD2] =3D imx_clk_pfd("pll3_pfd2_508m", "pll3_usb_ot=
g", base + 0xf0,  2);
-	clks[IMX6SX_CLK_PLL3_PFD3] =3D imx_clk_pfd("pll3_pfd3_454m", "pll3_usb_ot=
g", base + 0xf0,  3);
+	hws[IMX6SX_CLK_PLL2_PFD0] =3D imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_bus"=
,     base + 0x100, 0);
+	hws[IMX6SX_CLK_PLL2_PFD1] =3D imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_bus"=
,     base + 0x100, 1);
+	hws[IMX6SX_CLK_PLL2_PFD2] =3D imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_bus"=
,     base + 0x100, 2);
+	hws[IMX6SX_CLK_PLL2_PFD3] =3D imx_clk_hw_pfd("pll2_pfd3_594m", "pll2_bus"=
,     base + 0x100, 3);
+	hws[IMX6SX_CLK_PLL3_PFD0] =3D imx_clk_hw_pfd("pll3_pfd0_720m", "pll3_usb_=
otg", base + 0xf0,  0);
+	hws[IMX6SX_CLK_PLL3_PFD1] =3D imx_clk_hw_pfd("pll3_pfd1_540m", "pll3_usb_=
otg", base + 0xf0,  1);
+	hws[IMX6SX_CLK_PLL3_PFD2] =3D imx_clk_hw_pfd("pll3_pfd2_508m", "pll3_usb_=
otg", base + 0xf0,  2);
+	hws[IMX6SX_CLK_PLL3_PFD3] =3D imx_clk_hw_pfd("pll3_pfd3_454m", "pll3_usb_=
otg", base + 0xf0,  3);
=20
 	/*                                                name         parent_nam=
e       mult div */
-	clks[IMX6SX_CLK_PLL2_198M] =3D imx_clk_fixed_factor("pll2_198m", "pll2_pf=
d2_396m", 1,   2);
-	clks[IMX6SX_CLK_PLL3_120M] =3D imx_clk_fixed_factor("pll3_120m", "pll3_us=
b_otg",   1,   4);
-	clks[IMX6SX_CLK_PLL3_80M]  =3D imx_clk_fixed_factor("pll3_80m",  "pll3_us=
b_otg",   1,   6);
-	clks[IMX6SX_CLK_PLL3_60M]  =3D imx_clk_fixed_factor("pll3_60m",  "pll3_us=
b_otg",   1,   8);
-	clks[IMX6SX_CLK_TWD]       =3D imx_clk_fixed_factor("twd",       "arm",  =
          1,   2);
-	clks[IMX6SX_CLK_GPT_3M]    =3D imx_clk_fixed_factor("gpt_3m",    "osc",  =
          1,   8);
-
-	clks[IMX6SX_CLK_PLL4_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
4_post_div", "pll4_audio",
+	hws[IMX6SX_CLK_PLL2_198M] =3D imx_clk_hw_fixed_factor("pll2_198m", "pll2_=
pfd2_396m", 1,   2);
+	hws[IMX6SX_CLK_PLL3_120M] =3D imx_clk_hw_fixed_factor("pll3_120m", "pll3_=
usb_otg",   1,   4);
+	hws[IMX6SX_CLK_PLL3_80M]  =3D imx_clk_hw_fixed_factor("pll3_80m",  "pll3_=
usb_otg",   1,   6);
+	hws[IMX6SX_CLK_PLL3_60M]  =3D imx_clk_hw_fixed_factor("pll3_60m",  "pll3_=
usb_otg",   1,   8);
+	hws[IMX6SX_CLK_TWD]       =3D imx_clk_hw_fixed_factor("twd",       "arm",=
            1,   2);
+	hws[IMX6SX_CLK_GPT_3M]    =3D imx_clk_hw_fixed_factor("gpt_3m",    "osc",=
            1,   8);
+
+	hws[IMX6SX_CLK_PLL4_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll4_post_div", "pll4_audio",
 				CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_l=
ock);
-	clks[IMX6SX_CLK_PLL4_AUDIO_DIV] =3D clk_register_divider(NULL, "pll4_audi=
o_div", "pll4_post_div",
+	hws[IMX6SX_CLK_PLL4_AUDIO_DIV] =3D clk_hw_register_divider(NULL, "pll4_au=
dio_div", "pll4_post_div",
 				CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_ccm_lock);
-	clks[IMX6SX_CLK_PLL5_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
5_post_div", "pll5_video",
+	hws[IMX6SX_CLK_PLL5_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll5_post_div", "pll5_video",
 				CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_l=
ock);
-	clks[IMX6SX_CLK_PLL5_VIDEO_DIV] =3D clk_register_divider_table(NULL, "pll=
5_video_div", "pll5_post_div",
+	hws[IMX6SX_CLK_PLL5_VIDEO_DIV] =3D clk_hw_register_divider_table(NULL, "p=
ll5_video_div", "pll5_post_div",
 				CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm=
_lock);
=20
 	/*                                                name                reg=
           shift   width   parent_names       num_parents */
-	clks[IMX6SX_CLK_LVDS1_SEL]          =3D imx_clk_mux("lvds1_sel",        b=
ase + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
-	clks[IMX6SX_CLK_LVDS2_SEL]          =3D imx_clk_mux("lvds2_sel",        b=
ase + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
+	hws[IMX6SX_CLK_LVDS1_SEL]          =3D imx_clk_hw_mux("lvds1_sel",       =
 base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
+	hws[IMX6SX_CLK_LVDS2_SEL]          =3D imx_clk_hw_mux("lvds2_sel",       =
 base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
 	/*                                                name                reg=
           shift   width   parent_names       num_parents */
-	clks[IMX6SX_CLK_STEP]               =3D imx_clk_mux("step",             b=
ase + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SX_CLK_PLL1_SW]            =3D imx_clk_mux("pll1_sw",          b=
ase + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
-	clks[IMX6SX_CLK_OCRAM_SEL]          =3D imx_clk_mux("ocram_sel",        b=
ase + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
-	clks[IMX6SX_CLK_PERIPH_PRE]         =3D imx_clk_mux("periph_pre",       b=
ase + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sels)=
);
-	clks[IMX6SX_CLK_PERIPH2_PRE]        =3D imx_clk_mux("periph2_pre",      b=
ase + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_sel=
s));
-	clks[IMX6SX_CLK_PERIPH_CLK2_SEL]    =3D imx_clk_mux("periph_clk2_sel",  b=
ase + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels=
));
-	clks[IMX6SX_CLK_PERIPH2_CLK2_SEL]   =3D imx_clk_mux("periph2_clk2_sel", b=
ase + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sel=
s));
-	clks[IMX6SX_CLK_PCIE_AXI_SEL]       =3D imx_clk_mux("pcie_axi_sel",     b=
ase + 0x18,  10,     1,      pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
-	clks[IMX6SX_CLK_GPU_AXI_SEL]        =3D imx_clk_mux("gpu_axi_sel",      b=
ase + 0x18,  8,      2,      gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
-	clks[IMX6SX_CLK_GPU_CORE_SEL]       =3D imx_clk_mux("gpu_core_sel",     b=
ase + 0x18,  4,      2,      gpu_core_sels,     ARRAY_SIZE(gpu_core_sels));
-	clks[IMX6SX_CLK_EIM_SLOW_SEL]       =3D imx_clk_mux("eim_slow_sel",     b=
ase + 0x1c,  29,     2,      eim_slow_sels,     ARRAY_SIZE(eim_slow_sels));
-	clks[IMX6SX_CLK_USDHC1_SEL]         =3D imx_clk_mux("usdhc1_sel",       b=
ase + 0x1c,  16,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SX_CLK_USDHC2_SEL]         =3D imx_clk_mux("usdhc2_sel",       b=
ase + 0x1c,  17,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SX_CLK_USDHC3_SEL]         =3D imx_clk_mux("usdhc3_sel",       b=
ase + 0x1c,  18,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SX_CLK_USDHC4_SEL]         =3D imx_clk_mux("usdhc4_sel",       b=
ase + 0x1c,  19,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-	clks[IMX6SX_CLK_SSI3_SEL]           =3D imx_clk_mux("ssi3_sel",         b=
ase + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
-	clks[IMX6SX_CLK_SSI2_SEL]           =3D imx_clk_mux("ssi2_sel",         b=
ase + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
-	clks[IMX6SX_CLK_SSI1_SEL]           =3D imx_clk_mux("ssi1_sel",         b=
ase + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
-	clks[IMX6SX_CLK_QSPI1_SEL]          =3D imx_clk_mux_flags("qspi1_sel", ba=
se + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_PERCLK_SEL]         =3D imx_clk_mux("perclk_sel",       b=
ase + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
-	clks[IMX6SX_CLK_VID_SEL]            =3D imx_clk_mux("vid_sel",          b=
ase + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
-	clks[IMX6SX_CLK_ESAI_SEL]           =3D imx_clk_mux("esai_sel",         b=
ase + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SX_CLK_CAN_SEL]            =3D imx_clk_mux("can_sel",          b=
ase + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
-	clks[IMX6SX_CLK_UART_SEL]           =3D imx_clk_mux("uart_sel",         b=
ase + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
-	clks[IMX6SX_CLK_QSPI2_SEL]          =3D imx_clk_mux_flags("qspi2_sel", ba=
se + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_SPDIF_SEL]          =3D imx_clk_mux("spdif_sel",        b=
ase + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SX_CLK_AUDIO_SEL]          =3D imx_clk_mux("audio_sel",        b=
ase + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SX_CLK_ENET_PRE_SEL]       =3D imx_clk_mux("enet_pre_sel",     b=
ase + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
-	clks[IMX6SX_CLK_ENET_SEL]           =3D imx_clk_mux("enet_sel",         b=
ase + 0x34,  9,      3,      enet_sels,         ARRAY_SIZE(enet_sels));
-	clks[IMX6SX_CLK_M4_PRE_SEL]         =3D imx_clk_mux("m4_pre_sel",       b=
ase + 0x34,  6,      3,      m4_pre_sels,       ARRAY_SIZE(m4_pre_sels));
-	clks[IMX6SX_CLK_M4_SEL]             =3D imx_clk_mux("m4_sel",           b=
ase + 0x34,  0,      3,      m4_sels,           ARRAY_SIZE(m4_sels));
-	clks[IMX6SX_CLK_ECSPI_SEL]          =3D imx_clk_mux("ecspi_sel",        b=
ase + 0x38,  18,     1,      ecspi_sels,        ARRAY_SIZE(ecspi_sels));
-	clks[IMX6SX_CLK_LCDIF2_PRE_SEL]     =3D imx_clk_mux("lcdif2_pre_sel",   b=
ase + 0x38,  6,      3,      lcdif2_pre_sels,   ARRAY_SIZE(lcdif2_pre_sels)=
);
-	clks[IMX6SX_CLK_LCDIF2_SEL]         =3D imx_clk_mux("lcdif2_sel",       b=
ase + 0x38,  0,      3,      lcdif2_sels,       ARRAY_SIZE(lcdif2_sels));
-	clks[IMX6SX_CLK_DISPLAY_SEL]        =3D imx_clk_mux("display_sel",      b=
ase + 0x3c,  14,     2,      display_sels,      ARRAY_SIZE(display_sels));
-	clks[IMX6SX_CLK_CSI_SEL]            =3D imx_clk_mux("csi_sel",          b=
ase + 0x3c,  9,      2,      csi_sels,          ARRAY_SIZE(csi_sels));
-	clks[IMX6SX_CLK_CKO1_SEL]           =3D imx_clk_mux("cko1_sel",         b=
ase + 0x60,  0,      4,      cko1_sels,         ARRAY_SIZE(cko1_sels));
-	clks[IMX6SX_CLK_CKO2_SEL]           =3D imx_clk_mux("cko2_sel",         b=
ase + 0x60,  16,     5,      cko2_sels,         ARRAY_SIZE(cko2_sels));
-	clks[IMX6SX_CLK_CKO]                =3D imx_clk_mux("cko",              b=
ase + 0x60,  8,      1,      cko_sels,          ARRAY_SIZE(cko_sels));
-
-	clks[IMX6SX_CLK_LDB_DI1_DIV_SEL]    =3D imx_clk_mux_flags("ldb_di1_div_se=
l", base + 0x20, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_LDB_DI0_DIV_SEL]    =3D imx_clk_mux_flags("ldb_di0_div_se=
l", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_LDB_DI1_SEL]        =3D imx_clk_mux_flags("ldb_di1_sel", =
    base + 0x2c, 12, 3, ldb_di1_sels,      ARRAY_SIZE(ldb_di1_sels),    CLK=
_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_LDB_DI0_SEL]        =3D imx_clk_mux_flags("ldb_di0_sel", =
    base + 0x2c, 9,  3, ldb_di0_sels,      ARRAY_SIZE(ldb_di0_sels),    CLK=
_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_LCDIF1_PRE_SEL]     =3D imx_clk_mux_flags("lcdif1_pre_sel=
",  base + 0x38, 15, 3, lcdif1_pre_sels,   ARRAY_SIZE(lcdif1_pre_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX6SX_CLK_LCDIF1_SEL]         =3D imx_clk_mux_flags("lcdif1_sel",  =
    base + 0x38, 9,  3, lcdif1_sels,       ARRAY_SIZE(lcdif1_sels),     CLK=
_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_STEP]               =3D imx_clk_hw_mux("step",            =
 base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
+	hws[IMX6SX_CLK_PLL1_SW]            =3D imx_clk_hw_mux("pll1_sw",         =
 base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels))=
;
+	hws[IMX6SX_CLK_OCRAM_SEL]          =3D imx_clk_hw_mux("ocram_sel",       =
 base + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
+	hws[IMX6SX_CLK_PERIPH_PRE]         =3D imx_clk_hw_mux("periph_pre",      =
 base + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sel=
s));
+	hws[IMX6SX_CLK_PERIPH2_PRE]        =3D imx_clk_hw_mux("periph2_pre",     =
 base + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_s=
els));
+	hws[IMX6SX_CLK_PERIPH_CLK2_SEL]    =3D imx_clk_hw_mux("periph_clk2_sel", =
 base + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_se=
ls));
+	hws[IMX6SX_CLK_PERIPH2_CLK2_SEL]   =3D imx_clk_hw_mux("periph2_clk2_sel",=
 base + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_s=
els));
+	hws[IMX6SX_CLK_PCIE_AXI_SEL]       =3D imx_clk_hw_mux("pcie_axi_sel",    =
 base + 0x18,  10,     1,      pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels)=
);
+	hws[IMX6SX_CLK_GPU_AXI_SEL]        =3D imx_clk_hw_mux("gpu_axi_sel",     =
 base + 0x18,  8,      2,      gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels))=
;
+	hws[IMX6SX_CLK_GPU_CORE_SEL]       =3D imx_clk_hw_mux("gpu_core_sel",    =
 base + 0x18,  4,      2,      gpu_core_sels,     ARRAY_SIZE(gpu_core_sels)=
);
+	hws[IMX6SX_CLK_EIM_SLOW_SEL]       =3D imx_clk_hw_mux("eim_slow_sel",    =
 base + 0x1c,  29,     2,      eim_slow_sels,     ARRAY_SIZE(eim_slow_sels)=
);
+	hws[IMX6SX_CLK_USDHC1_SEL]         =3D imx_clk_hw_mux("usdhc1_sel",      =
 base + 0x1c,  16,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SX_CLK_USDHC2_SEL]         =3D imx_clk_hw_mux("usdhc2_sel",      =
 base + 0x1c,  17,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SX_CLK_USDHC3_SEL]         =3D imx_clk_hw_mux("usdhc3_sel",      =
 base + 0x1c,  18,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SX_CLK_USDHC4_SEL]         =3D imx_clk_hw_mux("usdhc4_sel",      =
 base + 0x1c,  19,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+	hws[IMX6SX_CLK_SSI3_SEL]           =3D imx_clk_hw_mux("ssi3_sel",        =
 base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
+	hws[IMX6SX_CLK_SSI2_SEL]           =3D imx_clk_hw_mux("ssi2_sel",        =
 base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
+	hws[IMX6SX_CLK_SSI1_SEL]           =3D imx_clk_hw_mux("ssi1_sel",        =
 base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
+	hws[IMX6SX_CLK_QSPI1_SEL]          =3D imx_clk_hw_mux_flags("qspi1_sel", =
base + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT=
);
+	hws[IMX6SX_CLK_PERCLK_SEL]         =3D imx_clk_hw_mux("perclk_sel",      =
 base + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
+	hws[IMX6SX_CLK_VID_SEL]            =3D imx_clk_hw_mux("vid_sel",         =
 base + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
+	hws[IMX6SX_CLK_ESAI_SEL]           =3D imx_clk_hw_mux("esai_sel",        =
 base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SX_CLK_CAN_SEL]            =3D imx_clk_hw_mux("can_sel",         =
 base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
+	hws[IMX6SX_CLK_UART_SEL]           =3D imx_clk_hw_mux("uart_sel",        =
 base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
+	hws[IMX6SX_CLK_QSPI2_SEL]          =3D imx_clk_hw_mux_flags("qspi2_sel", =
base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT=
);
+	hws[IMX6SX_CLK_SPDIF_SEL]          =3D imx_clk_hw_mux("spdif_sel",       =
 base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SX_CLK_AUDIO_SEL]          =3D imx_clk_hw_mux("audio_sel",       =
 base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SX_CLK_ENET_PRE_SEL]       =3D imx_clk_hw_mux("enet_pre_sel",    =
 base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels)=
);
+	hws[IMX6SX_CLK_ENET_SEL]           =3D imx_clk_hw_mux("enet_sel",        =
 base + 0x34,  9,      3,      enet_sels,         ARRAY_SIZE(enet_sels));
+	hws[IMX6SX_CLK_M4_PRE_SEL]         =3D imx_clk_hw_mux("m4_pre_sel",      =
 base + 0x34,  6,      3,      m4_pre_sels,       ARRAY_SIZE(m4_pre_sels));
+	hws[IMX6SX_CLK_M4_SEL]             =3D imx_clk_hw_mux("m4_sel",          =
 base + 0x34,  0,      3,      m4_sels,           ARRAY_SIZE(m4_sels));
+	hws[IMX6SX_CLK_ECSPI_SEL]          =3D imx_clk_hw_mux("ecspi_sel",       =
 base + 0x38,  18,     1,      ecspi_sels,        ARRAY_SIZE(ecspi_sels));
+	hws[IMX6SX_CLK_LCDIF2_PRE_SEL]     =3D imx_clk_hw_mux("lcdif2_pre_sel",  =
 base + 0x38,  6,      3,      lcdif2_pre_sels,   ARRAY_SIZE(lcdif2_pre_sel=
s));
+	hws[IMX6SX_CLK_LCDIF2_SEL]         =3D imx_clk_hw_mux("lcdif2_sel",      =
 base + 0x38,  0,      3,      lcdif2_sels,       ARRAY_SIZE(lcdif2_sels));
+	hws[IMX6SX_CLK_DISPLAY_SEL]        =3D imx_clk_hw_mux("display_sel",     =
 base + 0x3c,  14,     2,      display_sels,      ARRAY_SIZE(display_sels))=
;
+	hws[IMX6SX_CLK_CSI_SEL]            =3D imx_clk_hw_mux("csi_sel",         =
 base + 0x3c,  9,      2,      csi_sels,          ARRAY_SIZE(csi_sels));
+	hws[IMX6SX_CLK_CKO1_SEL]           =3D imx_clk_hw_mux("cko1_sel",        =
 base + 0x60,  0,      4,      cko1_sels,         ARRAY_SIZE(cko1_sels));
+	hws[IMX6SX_CLK_CKO2_SEL]           =3D imx_clk_hw_mux("cko2_sel",        =
 base + 0x60,  16,     5,      cko2_sels,         ARRAY_SIZE(cko2_sels));
+	hws[IMX6SX_CLK_CKO]                =3D imx_clk_hw_mux("cko",             =
 base + 0x60,  8,      1,      cko_sels,          ARRAY_SIZE(cko_sels));
+
+	hws[IMX6SX_CLK_LDB_DI1_DIV_SEL]    =3D imx_clk_hw_mux_flags("ldb_di1_div_=
sel", base + 0x20, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_LDB_DI0_DIV_SEL]    =3D imx_clk_hw_mux_flags("ldb_di0_div_=
sel", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_LDB_DI1_SEL]        =3D imx_clk_hw_mux_flags("ldb_di1_sel"=
,     base + 0x2c, 12, 3, ldb_di1_sels,      ARRAY_SIZE(ldb_di1_sels),    C=
LK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_LDB_DI0_SEL]        =3D imx_clk_hw_mux_flags("ldb_di0_sel"=
,     base + 0x2c, 9,  3, ldb_di0_sels,      ARRAY_SIZE(ldb_di0_sels),    C=
LK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_LCDIF1_PRE_SEL]     =3D imx_clk_hw_mux_flags("lcdif1_pre_s=
el",  base + 0x38, 15, 3, lcdif1_pre_sels,   ARRAY_SIZE(lcdif1_pre_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6SX_CLK_LCDIF1_SEL]         =3D imx_clk_hw_mux_flags("lcdif1_sel",=
      base + 0x38, 9,  3, lcdif1_sels,       ARRAY_SIZE(lcdif1_sels),     C=
LK_SET_RATE_PARENT);
=20
 	/*                                                    name              p=
arent_name          reg          shift width */
-	clks[IMX6SX_CLK_PERIPH_CLK2]        =3D imx_clk_divider("periph_clk2",   =
 "periph_clk2_sel",   base + 0x14, 27,   3);
-	clks[IMX6SX_CLK_PERIPH2_CLK2]       =3D imx_clk_divider("periph2_clk2",  =
 "periph2_clk2_sel",  base + 0x14, 0,    3);
-	clks[IMX6SX_CLK_IPG]                =3D imx_clk_divider("ipg",           =
 "ahb",               base + 0x14, 8,    2);
-	clks[IMX6SX_CLK_GPU_CORE_PODF]      =3D imx_clk_divider("gpu_core_podf", =
 "gpu_core_sel",      base + 0x18, 29,   3);
-	clks[IMX6SX_CLK_GPU_AXI_PODF]       =3D imx_clk_divider("gpu_axi_podf",  =
 "gpu_axi_sel",       base + 0x18, 26,   3);
-	clks[IMX6SX_CLK_LCDIF1_PODF]        =3D imx_clk_divider("lcdif1_podf",   =
 "lcdif1_pred",       base + 0x18, 23,   3);
-	clks[IMX6SX_CLK_QSPI1_PODF]         =3D imx_clk_divider("qspi1_podf",    =
 "qspi1_sel",         base + 0x1c, 26,   3);
-	clks[IMX6SX_CLK_EIM_SLOW_PODF]      =3D imx_clk_divider("eim_slow_podf", =
 "eim_slow_sel",      base + 0x1c, 23,   3);
-	clks[IMX6SX_CLK_LCDIF2_PODF]        =3D imx_clk_divider("lcdif2_podf",   =
 "lcdif2_pred",       base + 0x1c, 20,   3);
-	clks[IMX6SX_CLK_PERCLK]             =3D imx_clk_divider_flags("perclk", "=
perclk_sel", base + 0x1c, 0, 6, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_VID_PODF]           =3D imx_clk_divider("vid_podf",      =
 "vid_sel",           base + 0x20, 24,   2);
-	clks[IMX6SX_CLK_CAN_PODF]           =3D imx_clk_divider("can_podf",      =
 "can_sel",           base + 0x20, 2,    6);
-	clks[IMX6SX_CLK_USDHC4_PODF]        =3D imx_clk_divider("usdhc4_podf",   =
 "usdhc4_sel",        base + 0x24, 22,   3);
-	clks[IMX6SX_CLK_USDHC3_PODF]        =3D imx_clk_divider("usdhc3_podf",   =
 "usdhc3_sel",        base + 0x24, 19,   3);
-	clks[IMX6SX_CLK_USDHC2_PODF]        =3D imx_clk_divider("usdhc2_podf",   =
 "usdhc2_sel",        base + 0x24, 16,   3);
-	clks[IMX6SX_CLK_USDHC1_PODF]        =3D imx_clk_divider("usdhc1_podf",   =
 "usdhc1_sel",        base + 0x24, 11,   3);
-	clks[IMX6SX_CLK_UART_PODF]          =3D imx_clk_divider("uart_podf",     =
 "uart_sel",          base + 0x24, 0,    6);
-	clks[IMX6SX_CLK_ESAI_PRED]          =3D imx_clk_divider("esai_pred",     =
 "esai_sel",          base + 0x28, 9,    3);
-	clks[IMX6SX_CLK_ESAI_PODF]          =3D imx_clk_divider("esai_podf",     =
 "esai_pred",         base + 0x28, 25,   3);
-	clks[IMX6SX_CLK_SSI3_PRED]          =3D imx_clk_divider("ssi3_pred",     =
 "ssi3_sel",          base + 0x28, 22,   3);
-	clks[IMX6SX_CLK_SSI3_PODF]          =3D imx_clk_divider("ssi3_podf",     =
 "ssi3_pred",         base + 0x28, 16,   6);
-	clks[IMX6SX_CLK_SSI1_PRED]          =3D imx_clk_divider("ssi1_pred",     =
 "ssi1_sel",          base + 0x28, 6,    3);
-	clks[IMX6SX_CLK_SSI1_PODF]          =3D imx_clk_divider("ssi1_podf",     =
 "ssi1_pred",         base + 0x28, 0,    6);
-	clks[IMX6SX_CLK_QSPI2_PRED]         =3D imx_clk_divider("qspi2_pred",    =
 "qspi2_sel",         base + 0x2c, 18,   3);
-	clks[IMX6SX_CLK_QSPI2_PODF]         =3D imx_clk_divider("qspi2_podf",    =
 "qspi2_pred",        base + 0x2c, 21,   6);
-	clks[IMX6SX_CLK_SSI2_PRED]          =3D imx_clk_divider("ssi2_pred",     =
 "ssi2_sel",          base + 0x2c, 6,    3);
-	clks[IMX6SX_CLK_SSI2_PODF]          =3D imx_clk_divider("ssi2_podf",     =
 "ssi2_pred",         base + 0x2c, 0,    6);
-	clks[IMX6SX_CLK_SPDIF_PRED]         =3D imx_clk_divider("spdif_pred",    =
 "spdif_sel",         base + 0x30, 25,   3);
-	clks[IMX6SX_CLK_SPDIF_PODF]         =3D imx_clk_divider("spdif_podf",    =
 "spdif_pred",        base + 0x30, 22,   3);
-	clks[IMX6SX_CLK_AUDIO_PRED]         =3D imx_clk_divider("audio_pred",    =
 "audio_sel",         base + 0x30, 12,   3);
-	clks[IMX6SX_CLK_AUDIO_PODF]         =3D imx_clk_divider("audio_podf",    =
 "audio_pred",        base + 0x30, 9,    3);
-	clks[IMX6SX_CLK_ENET_PODF]          =3D imx_clk_divider("enet_podf",     =
 "enet_pre_sel",      base + 0x34, 12,   3);
-	clks[IMX6SX_CLK_M4_PODF]            =3D imx_clk_divider("m4_podf",       =
 "m4_sel",            base + 0x34, 3,    3);
-	clks[IMX6SX_CLK_ECSPI_PODF]         =3D imx_clk_divider("ecspi_podf",    =
 "ecspi_sel",         base + 0x38, 19,   6);
-	clks[IMX6SX_CLK_LCDIF1_PRED]        =3D imx_clk_divider("lcdif1_pred",   =
 "lcdif1_pre_sel",    base + 0x38, 12,   3);
-	clks[IMX6SX_CLK_LCDIF2_PRED]        =3D imx_clk_divider("lcdif2_pred",   =
 "lcdif2_pre_sel",    base + 0x38, 3,    3);
-	clks[IMX6SX_CLK_DISPLAY_PODF]       =3D imx_clk_divider("display_podf",  =
 "display_sel",       base + 0x3c, 16,   3);
-	clks[IMX6SX_CLK_CSI_PODF]           =3D imx_clk_divider("csi_podf",      =
 "csi_sel",           base + 0x3c, 11,   3);
-	clks[IMX6SX_CLK_CKO1_PODF]          =3D imx_clk_divider("cko1_podf",     =
 "cko1_sel",          base + 0x60, 4,    3);
-	clks[IMX6SX_CLK_CKO2_PODF]          =3D imx_clk_divider("cko2_podf",     =
 "cko2_sel",          base + 0x60, 21,   3);
-
-	clks[IMX6SX_CLK_LDB_DI0_DIV_3_5]    =3D imx_clk_fixed_factor("ldb_di0_div=
_3_5", "ldb_di0_sel", 2, 7);
-	clks[IMX6SX_CLK_LDB_DI0_DIV_7]      =3D imx_clk_fixed_factor("ldb_di0_div=
_7",   "ldb_di0_sel", 1, 7);
-	clks[IMX6SX_CLK_LDB_DI1_DIV_3_5]    =3D imx_clk_fixed_factor("ldb_di1_div=
_3_5", "ldb_di1_sel", 2, 7);
-	clks[IMX6SX_CLK_LDB_DI1_DIV_7]      =3D imx_clk_fixed_factor("ldb_di1_div=
_7",   "ldb_di1_sel", 1, 7);
+	hws[IMX6SX_CLK_PERIPH_CLK2]        =3D imx_clk_hw_divider("periph_clk2", =
   "periph_clk2_sel",   base + 0x14, 27,   3);
+	hws[IMX6SX_CLK_PERIPH2_CLK2]       =3D imx_clk_hw_divider("periph2_clk2",=
   "periph2_clk2_sel",  base + 0x14, 0,    3);
+	hws[IMX6SX_CLK_IPG]                =3D imx_clk_hw_divider("ipg",         =
   "ahb",               base + 0x14, 8,    2);
+	hws[IMX6SX_CLK_GPU_CORE_PODF]      =3D imx_clk_hw_divider("gpu_core_podf"=
,  "gpu_core_sel",      base + 0x18, 29,   3);
+	hws[IMX6SX_CLK_GPU_AXI_PODF]       =3D imx_clk_hw_divider("gpu_axi_podf",=
   "gpu_axi_sel",       base + 0x18, 26,   3);
+	hws[IMX6SX_CLK_LCDIF1_PODF]        =3D imx_clk_hw_divider("lcdif1_podf", =
   "lcdif1_pred",       base + 0x18, 23,   3);
+	hws[IMX6SX_CLK_QSPI1_PODF]         =3D imx_clk_hw_divider("qspi1_podf",  =
   "qspi1_sel",         base + 0x1c, 26,   3);
+	hws[IMX6SX_CLK_EIM_SLOW_PODF]      =3D imx_clk_hw_divider("eim_slow_podf"=
,  "eim_slow_sel",      base + 0x1c, 23,   3);
+	hws[IMX6SX_CLK_LCDIF2_PODF]        =3D imx_clk_hw_divider("lcdif2_podf", =
   "lcdif2_pred",       base + 0x1c, 20,   3);
+	hws[IMX6SX_CLK_PERCLK]             =3D imx_clk_hw_divider_flags("perclk",=
 "perclk_sel", base + 0x1c, 0, 6, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_VID_PODF]           =3D imx_clk_hw_divider("vid_podf",    =
   "vid_sel",           base + 0x20, 24,   2);
+	hws[IMX6SX_CLK_CAN_PODF]           =3D imx_clk_hw_divider("can_podf",    =
   "can_sel",           base + 0x20, 2,    6);
+	hws[IMX6SX_CLK_USDHC4_PODF]        =3D imx_clk_hw_divider("usdhc4_podf", =
   "usdhc4_sel",        base + 0x24, 22,   3);
+	hws[IMX6SX_CLK_USDHC3_PODF]        =3D imx_clk_hw_divider("usdhc3_podf", =
   "usdhc3_sel",        base + 0x24, 19,   3);
+	hws[IMX6SX_CLK_USDHC2_PODF]        =3D imx_clk_hw_divider("usdhc2_podf", =
   "usdhc2_sel",        base + 0x24, 16,   3);
+	hws[IMX6SX_CLK_USDHC1_PODF]        =3D imx_clk_hw_divider("usdhc1_podf", =
   "usdhc1_sel",        base + 0x24, 11,   3);
+	hws[IMX6SX_CLK_UART_PODF]          =3D imx_clk_hw_divider("uart_podf",   =
   "uart_sel",          base + 0x24, 0,    6);
+	hws[IMX6SX_CLK_ESAI_PRED]          =3D imx_clk_hw_divider("esai_pred",   =
   "esai_sel",          base + 0x28, 9,    3);
+	hws[IMX6SX_CLK_ESAI_PODF]          =3D imx_clk_hw_divider("esai_podf",   =
   "esai_pred",         base + 0x28, 25,   3);
+	hws[IMX6SX_CLK_SSI3_PRED]          =3D imx_clk_hw_divider("ssi3_pred",   =
   "ssi3_sel",          base + 0x28, 22,   3);
+	hws[IMX6SX_CLK_SSI3_PODF]          =3D imx_clk_hw_divider("ssi3_podf",   =
   "ssi3_pred",         base + 0x28, 16,   6);
+	hws[IMX6SX_CLK_SSI1_PRED]          =3D imx_clk_hw_divider("ssi1_pred",   =
   "ssi1_sel",          base + 0x28, 6,    3);
+	hws[IMX6SX_CLK_SSI1_PODF]          =3D imx_clk_hw_divider("ssi1_podf",   =
   "ssi1_pred",         base + 0x28, 0,    6);
+	hws[IMX6SX_CLK_QSPI2_PRED]         =3D imx_clk_hw_divider("qspi2_pred",  =
   "qspi2_sel",         base + 0x2c, 18,   3);
+	hws[IMX6SX_CLK_QSPI2_PODF]         =3D imx_clk_hw_divider("qspi2_podf",  =
   "qspi2_pred",        base + 0x2c, 21,   6);
+	hws[IMX6SX_CLK_SSI2_PRED]          =3D imx_clk_hw_divider("ssi2_pred",   =
   "ssi2_sel",          base + 0x2c, 6,    3);
+	hws[IMX6SX_CLK_SSI2_PODF]          =3D imx_clk_hw_divider("ssi2_podf",   =
   "ssi2_pred",         base + 0x2c, 0,    6);
+	hws[IMX6SX_CLK_SPDIF_PRED]         =3D imx_clk_hw_divider("spdif_pred",  =
   "spdif_sel",         base + 0x30, 25,   3);
+	hws[IMX6SX_CLK_SPDIF_PODF]         =3D imx_clk_hw_divider("spdif_podf",  =
   "spdif_pred",        base + 0x30, 22,   3);
+	hws[IMX6SX_CLK_AUDIO_PRED]         =3D imx_clk_hw_divider("audio_pred",  =
   "audio_sel",         base + 0x30, 12,   3);
+	hws[IMX6SX_CLK_AUDIO_PODF]         =3D imx_clk_hw_divider("audio_podf",  =
   "audio_pred",        base + 0x30, 9,    3);
+	hws[IMX6SX_CLK_ENET_PODF]          =3D imx_clk_hw_divider("enet_podf",   =
   "enet_pre_sel",      base + 0x34, 12,   3);
+	hws[IMX6SX_CLK_M4_PODF]            =3D imx_clk_hw_divider("m4_podf",     =
   "m4_sel",            base + 0x34, 3,    3);
+	hws[IMX6SX_CLK_ECSPI_PODF]         =3D imx_clk_hw_divider("ecspi_podf",  =
   "ecspi_sel",         base + 0x38, 19,   6);
+	hws[IMX6SX_CLK_LCDIF1_PRED]        =3D imx_clk_hw_divider("lcdif1_pred", =
   "lcdif1_pre_sel",    base + 0x38, 12,   3);
+	hws[IMX6SX_CLK_LCDIF2_PRED]        =3D imx_clk_hw_divider("lcdif2_pred", =
   "lcdif2_pre_sel",    base + 0x38, 3,    3);
+	hws[IMX6SX_CLK_DISPLAY_PODF]       =3D imx_clk_hw_divider("display_podf",=
   "display_sel",       base + 0x3c, 16,   3);
+	hws[IMX6SX_CLK_CSI_PODF]           =3D imx_clk_hw_divider("csi_podf",    =
   "csi_sel",           base + 0x3c, 11,   3);
+	hws[IMX6SX_CLK_CKO1_PODF]          =3D imx_clk_hw_divider("cko1_podf",   =
   "cko1_sel",          base + 0x60, 4,    3);
+	hws[IMX6SX_CLK_CKO2_PODF]          =3D imx_clk_hw_divider("cko2_podf",   =
   "cko2_sel",          base + 0x60, 21,   3);
+
+	hws[IMX6SX_CLK_LDB_DI0_DIV_3_5]    =3D imx_clk_hw_fixed_factor("ldb_di0_d=
iv_3_5", "ldb_di0_sel", 2, 7);
+	hws[IMX6SX_CLK_LDB_DI0_DIV_7]      =3D imx_clk_hw_fixed_factor("ldb_di0_d=
iv_7",   "ldb_di0_sel", 1, 7);
+	hws[IMX6SX_CLK_LDB_DI1_DIV_3_5]    =3D imx_clk_hw_fixed_factor("ldb_di1_d=
iv_3_5", "ldb_di1_sel", 2, 7);
+	hws[IMX6SX_CLK_LDB_DI1_DIV_7]      =3D imx_clk_hw_fixed_factor("ldb_di1_d=
iv_7",   "ldb_di1_sel", 1, 7);
=20
 	/*                                               name        reg         =
 shift width busy: reg,   shift parent_names       num_parents */
-	clks[IMX6SX_CLK_PERIPH]       =3D imx_clk_busy_mux("periph",   base + 0x1=
4, 25,   1,    base + 0x48, 5,    periph_sels,       ARRAY_SIZE(periph_sels=
));
-	clks[IMX6SX_CLK_PERIPH2]      =3D imx_clk_busy_mux("periph2",  base + 0x1=
4, 26,   1,    base + 0x48, 3,    periph2_sels,      ARRAY_SIZE(periph2_sel=
s));
+	hws[IMX6SX_CLK_PERIPH]       =3D imx_clk_hw_busy_mux("periph",   base + 0=
x14, 25,   1,    base + 0x48, 5,    periph_sels,       ARRAY_SIZE(periph_se=
ls));
+	hws[IMX6SX_CLK_PERIPH2]      =3D imx_clk_hw_busy_mux("periph2",  base + 0=
x14, 26,   1,    base + 0x48, 3,    periph2_sels,      ARRAY_SIZE(periph2_s=
els));
 	/*                                                   name             par=
ent_name    reg          shift width busy: reg,   shift */
-	clks[IMX6SX_CLK_OCRAM_PODF]   =3D imx_clk_busy_divider("ocram_podf",    "=
ocram_sel",   base + 0x14, 16,   3,    base + 0x48, 0);
-	clks[IMX6SX_CLK_AHB]          =3D imx_clk_busy_divider("ahb",           "=
periph",      base + 0x14, 10,   3,    base + 0x48, 1);
-	clks[IMX6SX_CLK_MMDC_PODF]    =3D imx_clk_busy_divider("mmdc_podf",     "=
periph2",     base + 0x14, 3,    3,    base + 0x48, 2);
-	clks[IMX6SX_CLK_ARM]          =3D imx_clk_busy_divider("arm",           "=
pll1_sw",     base + 0x10, 0,    3,    base + 0x48, 16);
+	hws[IMX6SX_CLK_OCRAM_PODF]   =3D imx_clk_hw_busy_divider("ocram_podf",   =
 "ocram_sel",   base + 0x14, 16,   3,    base + 0x48, 0);
+	hws[IMX6SX_CLK_AHB]          =3D imx_clk_hw_busy_divider("ahb",          =
 "periph",      base + 0x14, 10,   3,    base + 0x48, 1);
+	hws[IMX6SX_CLK_MMDC_PODF]    =3D imx_clk_hw_busy_divider("mmdc_podf",    =
 "periph2",     base + 0x14, 3,    3,    base + 0x48, 2);
+	hws[IMX6SX_CLK_ARM]          =3D imx_clk_hw_busy_divider("arm",          =
 "pll1_sw",     base + 0x10, 0,    3,    base + 0x48, 16);
=20
 	/*                                            name             parent_nam=
e          reg         shift */
 	/* CCGR0 */
-	clks[IMX6SX_CLK_AIPS_TZ1]     =3D imx_clk_gate2_flags("aips_tz1", "ahb", =
base + 0x68, 0, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_AIPS_TZ2]     =3D imx_clk_gate2_flags("aips_tz2", "ahb", =
base + 0x68, 2, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_APBH_DMA]     =3D imx_clk_gate2("apbh_dma",      "usdhc3"=
,            base + 0x68, 4);
-	clks[IMX6SX_CLK_ASRC_MEM]     =3D imx_clk_gate2_shared("asrc_mem", "ahb",=
             base + 0x68, 6, &share_count_asrc);
-	clks[IMX6SX_CLK_ASRC_IPG]     =3D imx_clk_gate2_shared("asrc_ipg", "ahb",=
             base + 0x68, 6, &share_count_asrc);
-	clks[IMX6SX_CLK_CAAM_MEM]     =3D imx_clk_gate2("caam_mem",      "ahb",  =
             base + 0x68, 8);
-	clks[IMX6SX_CLK_CAAM_ACLK]    =3D imx_clk_gate2("caam_aclk",     "ahb",  =
             base + 0x68, 10);
-	clks[IMX6SX_CLK_CAAM_IPG]     =3D imx_clk_gate2("caam_ipg",      "ipg",  =
             base + 0x68, 12);
-	clks[IMX6SX_CLK_CAN1_IPG]     =3D imx_clk_gate2("can1_ipg",      "ipg",  =
             base + 0x68, 14);
-	clks[IMX6SX_CLK_CAN1_SERIAL]  =3D imx_clk_gate2("can1_serial",   "can_pod=
f",          base + 0x68, 16);
-	clks[IMX6SX_CLK_CAN2_IPG]     =3D imx_clk_gate2("can2_ipg",      "ipg",  =
             base + 0x68, 18);
-	clks[IMX6SX_CLK_CAN2_SERIAL]  =3D imx_clk_gate2("can2_serial",   "can_pod=
f",          base + 0x68, 20);
-	clks[IMX6SX_CLK_DCIC1]        =3D imx_clk_gate2("dcic1",         "display=
_podf",      base + 0x68, 24);
-	clks[IMX6SX_CLK_DCIC2]        =3D imx_clk_gate2("dcic2",         "display=
_podf",      base + 0x68, 26);
-	clks[IMX6SX_CLK_AIPS_TZ3]     =3D imx_clk_gate2_flags("aips_tz3", "ahb", =
base + 0x68, 30, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_AIPS_TZ1]     =3D imx_clk_hw_gate2_flags("aips_tz1", "ahb"=
, base + 0x68, 0, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_AIPS_TZ2]     =3D imx_clk_hw_gate2_flags("aips_tz2", "ahb"=
, base + 0x68, 2, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_APBH_DMA]     =3D imx_clk_hw_gate2("apbh_dma",      "usdhc=
3",            base + 0x68, 4);
+	hws[IMX6SX_CLK_ASRC_MEM]     =3D imx_clk_hw_gate2_shared("asrc_mem", "ahb=
",             base + 0x68, 6, &share_count_asrc);
+	hws[IMX6SX_CLK_ASRC_IPG]     =3D imx_clk_hw_gate2_shared("asrc_ipg", "ahb=
",             base + 0x68, 6, &share_count_asrc);
+	hws[IMX6SX_CLK_CAAM_MEM]     =3D imx_clk_hw_gate2("caam_mem",      "ahb",=
               base + 0x68, 8);
+	hws[IMX6SX_CLK_CAAM_ACLK]    =3D imx_clk_hw_gate2("caam_aclk",     "ahb",=
               base + 0x68, 10);
+	hws[IMX6SX_CLK_CAAM_IPG]     =3D imx_clk_hw_gate2("caam_ipg",      "ipg",=
               base + 0x68, 12);
+	hws[IMX6SX_CLK_CAN1_IPG]     =3D imx_clk_hw_gate2("can1_ipg",      "ipg",=
               base + 0x68, 14);
+	hws[IMX6SX_CLK_CAN1_SERIAL]  =3D imx_clk_hw_gate2("can1_serial",   "can_p=
odf",          base + 0x68, 16);
+	hws[IMX6SX_CLK_CAN2_IPG]     =3D imx_clk_hw_gate2("can2_ipg",      "ipg",=
               base + 0x68, 18);
+	hws[IMX6SX_CLK_CAN2_SERIAL]  =3D imx_clk_hw_gate2("can2_serial",   "can_p=
odf",          base + 0x68, 20);
+	hws[IMX6SX_CLK_DCIC1]        =3D imx_clk_hw_gate2("dcic1",         "displ=
ay_podf",      base + 0x68, 24);
+	hws[IMX6SX_CLK_DCIC2]        =3D imx_clk_hw_gate2("dcic2",         "displ=
ay_podf",      base + 0x68, 26);
+	hws[IMX6SX_CLK_AIPS_TZ3]     =3D imx_clk_hw_gate2_flags("aips_tz3", "ahb"=
, base + 0x68, 30, CLK_IS_CRITICAL);
=20
 	/* CCGR1 */
-	clks[IMX6SX_CLK_ECSPI1]       =3D imx_clk_gate2("ecspi1",        "ecspi_p=
odf",        base + 0x6c, 0);
-	clks[IMX6SX_CLK_ECSPI2]       =3D imx_clk_gate2("ecspi2",        "ecspi_p=
odf",        base + 0x6c, 2);
-	clks[IMX6SX_CLK_ECSPI3]       =3D imx_clk_gate2("ecspi3",        "ecspi_p=
odf",        base + 0x6c, 4);
-	clks[IMX6SX_CLK_ECSPI4]       =3D imx_clk_gate2("ecspi4",        "ecspi_p=
odf",        base + 0x6c, 6);
-	clks[IMX6SX_CLK_ECSPI5]       =3D imx_clk_gate2("ecspi5",        "ecspi_p=
odf",        base + 0x6c, 8);
-	clks[IMX6SX_CLK_EPIT1]        =3D imx_clk_gate2("epit1",         "perclk"=
,            base + 0x6c, 12);
-	clks[IMX6SX_CLK_EPIT2]        =3D imx_clk_gate2("epit2",         "perclk"=
,            base + 0x6c, 14);
-	clks[IMX6SX_CLK_ESAI_EXTAL]   =3D imx_clk_gate2_shared("esai_extal", "esa=
i_podf",     base + 0x6c, 16, &share_count_esai);
-	clks[IMX6SX_CLK_ESAI_IPG]     =3D imx_clk_gate2_shared("esai_ipg",   "ahb=
",           base + 0x6c, 16, &share_count_esai);
-	clks[IMX6SX_CLK_ESAI_MEM]     =3D imx_clk_gate2_shared("esai_mem",   "ahb=
",           base + 0x6c, 16, &share_count_esai);
-	clks[IMX6SX_CLK_WAKEUP]       =3D imx_clk_gate2_flags("wakeup", "ipg", ba=
se + 0x6c, 18, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_GPT_BUS]      =3D imx_clk_gate2("gpt_bus",       "perclk"=
,            base + 0x6c, 20);
-	clks[IMX6SX_CLK_GPT_SERIAL]   =3D imx_clk_gate2("gpt_serial",    "perclk"=
,            base + 0x6c, 22);
-	clks[IMX6SX_CLK_GPU]          =3D imx_clk_gate2("gpu",           "gpu_cor=
e_podf",     base + 0x6c, 26);
-	clks[IMX6SX_CLK_OCRAM_S]      =3D imx_clk_gate2("ocram_s",       "ahb",  =
             base + 0x6c, 28);
-	clks[IMX6SX_CLK_CANFD]        =3D imx_clk_gate2("canfd",         "can_pod=
f",          base + 0x6c, 30);
+	hws[IMX6SX_CLK_ECSPI1]       =3D imx_clk_hw_gate2("ecspi1",        "ecspi=
_podf",        base + 0x6c, 0);
+	hws[IMX6SX_CLK_ECSPI2]       =3D imx_clk_hw_gate2("ecspi2",        "ecspi=
_podf",        base + 0x6c, 2);
+	hws[IMX6SX_CLK_ECSPI3]       =3D imx_clk_hw_gate2("ecspi3",        "ecspi=
_podf",        base + 0x6c, 4);
+	hws[IMX6SX_CLK_ECSPI4]       =3D imx_clk_hw_gate2("ecspi4",        "ecspi=
_podf",        base + 0x6c, 6);
+	hws[IMX6SX_CLK_ECSPI5]       =3D imx_clk_hw_gate2("ecspi5",        "ecspi=
_podf",        base + 0x6c, 8);
+	hws[IMX6SX_CLK_EPIT1]        =3D imx_clk_hw_gate2("epit1",         "percl=
k",            base + 0x6c, 12);
+	hws[IMX6SX_CLK_EPIT2]        =3D imx_clk_hw_gate2("epit2",         "percl=
k",            base + 0x6c, 14);
+	hws[IMX6SX_CLK_ESAI_EXTAL]   =3D imx_clk_hw_gate2_shared("esai_extal", "e=
sai_podf",     base + 0x6c, 16, &share_count_esai);
+	hws[IMX6SX_CLK_ESAI_IPG]     =3D imx_clk_hw_gate2_shared("esai_ipg",   "a=
hb",           base + 0x6c, 16, &share_count_esai);
+	hws[IMX6SX_CLK_ESAI_MEM]     =3D imx_clk_hw_gate2_shared("esai_mem",   "a=
hb",           base + 0x6c, 16, &share_count_esai);
+	hws[IMX6SX_CLK_WAKEUP]       =3D imx_clk_hw_gate2_flags("wakeup", "ipg", =
base + 0x6c, 18, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_GPT_BUS]      =3D imx_clk_hw_gate2("gpt_bus",       "percl=
k",            base + 0x6c, 20);
+	hws[IMX6SX_CLK_GPT_SERIAL]   =3D imx_clk_hw_gate2("gpt_serial",    "percl=
k",            base + 0x6c, 22);
+	hws[IMX6SX_CLK_GPU]          =3D imx_clk_hw_gate2("gpu",           "gpu_c=
ore_podf",     base + 0x6c, 26);
+	hws[IMX6SX_CLK_OCRAM_S]      =3D imx_clk_hw_gate2("ocram_s",       "ahb",=
               base + 0x6c, 28);
+	hws[IMX6SX_CLK_CANFD]        =3D imx_clk_hw_gate2("canfd",         "can_p=
odf",          base + 0x6c, 30);
=20
 	/* CCGR2 */
-	clks[IMX6SX_CLK_CSI]          =3D imx_clk_gate2("csi",           "csi_pod=
f",          base + 0x70, 2);
-	clks[IMX6SX_CLK_I2C1]         =3D imx_clk_gate2("i2c1",          "perclk"=
,            base + 0x70, 6);
-	clks[IMX6SX_CLK_I2C2]         =3D imx_clk_gate2("i2c2",          "perclk"=
,            base + 0x70, 8);
-	clks[IMX6SX_CLK_I2C3]         =3D imx_clk_gate2("i2c3",          "perclk"=
,            base + 0x70, 10);
-	clks[IMX6SX_CLK_OCOTP]        =3D imx_clk_gate2("ocotp",         "ipg",  =
             base + 0x70, 12);
-	clks[IMX6SX_CLK_IOMUXC]       =3D imx_clk_gate2("iomuxc",        "lcdif1_=
podf",       base + 0x70, 14);
-	clks[IMX6SX_CLK_IPMUX1]       =3D imx_clk_gate2_flags("ipmux1", "ahb", ba=
se + 0x70, 16, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_IPMUX2]       =3D imx_clk_gate2_flags("ipmux2", "ahb", ba=
se + 0x70, 18, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_IPMUX3]       =3D imx_clk_gate2_flags("ipmux3", "ahb", ba=
se + 0x70, 20, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_TZASC1]       =3D imx_clk_gate2_flags("tzasc1", "mmdc_pod=
f", base + 0x70, 22, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_LCDIF_APB]    =3D imx_clk_gate2("lcdif_apb",     "display=
_podf",      base + 0x70, 28);
-	clks[IMX6SX_CLK_PXP_AXI]      =3D imx_clk_gate2("pxp_axi",       "display=
_podf",      base + 0x70, 30);
+	hws[IMX6SX_CLK_CSI]          =3D imx_clk_hw_gate2("csi",           "csi_p=
odf",          base + 0x70, 2);
+	hws[IMX6SX_CLK_I2C1]         =3D imx_clk_hw_gate2("i2c1",          "percl=
k",            base + 0x70, 6);
+	hws[IMX6SX_CLK_I2C2]         =3D imx_clk_hw_gate2("i2c2",          "percl=
k",            base + 0x70, 8);
+	hws[IMX6SX_CLK_I2C3]         =3D imx_clk_hw_gate2("i2c3",          "percl=
k",            base + 0x70, 10);
+	hws[IMX6SX_CLK_OCOTP]        =3D imx_clk_hw_gate2("ocotp",         "ipg",=
               base + 0x70, 12);
+	hws[IMX6SX_CLK_IOMUXC]       =3D imx_clk_hw_gate2("iomuxc",        "lcdif=
1_podf",       base + 0x70, 14);
+	hws[IMX6SX_CLK_IPMUX1]       =3D imx_clk_hw_gate2_flags("ipmux1", "ahb", =
base + 0x70, 16, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_IPMUX2]       =3D imx_clk_hw_gate2_flags("ipmux2", "ahb", =
base + 0x70, 18, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_IPMUX3]       =3D imx_clk_hw_gate2_flags("ipmux3", "ahb", =
base + 0x70, 20, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_TZASC1]       =3D imx_clk_hw_gate2_flags("tzasc1", "mmdc_p=
odf", base + 0x70, 22, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_LCDIF_APB]    =3D imx_clk_hw_gate2("lcdif_apb",     "displ=
ay_podf",      base + 0x70, 28);
+	hws[IMX6SX_CLK_PXP_AXI]      =3D imx_clk_hw_gate2("pxp_axi",       "displ=
ay_podf",      base + 0x70, 30);
=20
 	/* CCGR3 */
-	clks[IMX6SX_CLK_M4]           =3D imx_clk_gate2("m4",            "m4_podf=
",           base + 0x74, 2);
-	clks[IMX6SX_CLK_ENET]         =3D imx_clk_gate2("enet",          "ipg",  =
             base + 0x74, 4);
-	clks[IMX6SX_CLK_ENET_AHB]     =3D imx_clk_gate2("enet_ahb",      "enet_se=
l",          base + 0x74, 4);
-	clks[IMX6SX_CLK_DISPLAY_AXI]  =3D imx_clk_gate2("display_axi",   "display=
_podf",      base + 0x74, 6);
-	clks[IMX6SX_CLK_LCDIF2_PIX]   =3D imx_clk_gate2("lcdif2_pix",    "lcdif2_=
sel",        base + 0x74, 8);
-	clks[IMX6SX_CLK_LCDIF1_PIX]   =3D imx_clk_gate2("lcdif1_pix",    "lcdif1_=
sel",        base + 0x74, 10);
-	clks[IMX6SX_CLK_LDB_DI0]      =3D imx_clk_gate2("ldb_di0",       "ldb_di0=
_div_sel",   base + 0x74, 12);
-	clks[IMX6SX_CLK_QSPI1]        =3D imx_clk_gate2("qspi1",         "qspi1_p=
odf",        base + 0x74, 14);
-	clks[IMX6SX_CLK_MLB]          =3D imx_clk_gate2("mlb",           "ahb",  =
             base + 0x74, 18);
-	clks[IMX6SX_CLK_MMDC_P0_FAST] =3D imx_clk_gate2_flags("mmdc_p0_fast", "mm=
dc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_MMDC_P0_IPG]  =3D imx_clk_gate2_flags("mmdc_p0_ipg", "ipg=
", base + 0x74, 24, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_MMDC_P1_IPG]  =3D imx_clk_gate2("mmdc_p1_ipg", "ipg", bas=
e + 0x74, 26);
-	clks[IMX6SX_CLK_OCRAM]        =3D imx_clk_gate2_flags("ocram", "ocram_pod=
f", base + 0x74, 28, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_M4]           =3D imx_clk_hw_gate2("m4",            "m4_po=
df",           base + 0x74, 2);
+	hws[IMX6SX_CLK_ENET]         =3D imx_clk_hw_gate2("enet",          "ipg",=
               base + 0x74, 4);
+	hws[IMX6SX_CLK_ENET_AHB]     =3D imx_clk_hw_gate2("enet_ahb",      "enet_=
sel",          base + 0x74, 4);
+	hws[IMX6SX_CLK_DISPLAY_AXI]  =3D imx_clk_hw_gate2("display_axi",   "displ=
ay_podf",      base + 0x74, 6);
+	hws[IMX6SX_CLK_LCDIF2_PIX]   =3D imx_clk_hw_gate2("lcdif2_pix",    "lcdif=
2_sel",        base + 0x74, 8);
+	hws[IMX6SX_CLK_LCDIF1_PIX]   =3D imx_clk_hw_gate2("lcdif1_pix",    "lcdif=
1_sel",        base + 0x74, 10);
+	hws[IMX6SX_CLK_LDB_DI0]      =3D imx_clk_hw_gate2("ldb_di0",       "ldb_d=
i0_div_sel",   base + 0x74, 12);
+	hws[IMX6SX_CLK_QSPI1]        =3D imx_clk_hw_gate2("qspi1",         "qspi1=
_podf",        base + 0x74, 14);
+	hws[IMX6SX_CLK_MLB]          =3D imx_clk_hw_gate2("mlb",           "ahb",=
               base + 0x74, 18);
+	hws[IMX6SX_CLK_MMDC_P0_FAST] =3D imx_clk_hw_gate2_flags("mmdc_p0_fast", "=
mmdc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_MMDC_P0_IPG]  =3D imx_clk_hw_gate2_flags("mmdc_p0_ipg", "i=
pg", base + 0x74, 24, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_MMDC_P1_IPG]  =3D imx_clk_hw_gate2("mmdc_p1_ipg", "ipg", b=
ase + 0x74, 26);
+	hws[IMX6SX_CLK_OCRAM]        =3D imx_clk_hw_gate2_flags("ocram", "ocram_p=
odf", base + 0x74, 28, CLK_IS_CRITICAL);
=20
 	/* CCGR4 */
-	clks[IMX6SX_CLK_PCIE_AXI]     =3D imx_clk_gate2("pcie_axi",      "display=
_podf",      base + 0x78, 0);
-	clks[IMX6SX_CLK_QSPI2]        =3D imx_clk_gate2("qspi2",         "qspi2_p=
odf",        base + 0x78, 10);
-	clks[IMX6SX_CLK_PER1_BCH]     =3D imx_clk_gate2("per1_bch",      "usdhc3"=
,            base + 0x78, 12);
-	clks[IMX6SX_CLK_PER2_MAIN]    =3D imx_clk_gate2_flags("per2_main", "ahb",=
 base + 0x78, 14, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_PWM1]         =3D imx_clk_gate2("pwm1",          "perclk"=
,            base + 0x78, 16);
-	clks[IMX6SX_CLK_PWM2]         =3D imx_clk_gate2("pwm2",          "perclk"=
,            base + 0x78, 18);
-	clks[IMX6SX_CLK_PWM3]         =3D imx_clk_gate2("pwm3",          "perclk"=
,            base + 0x78, 20);
-	clks[IMX6SX_CLK_PWM4]         =3D imx_clk_gate2("pwm4",          "perclk"=
,            base + 0x78, 22);
-	clks[IMX6SX_CLK_GPMI_BCH_APB] =3D imx_clk_gate2("gpmi_bch_apb",  "usdhc3"=
,            base + 0x78, 24);
-	clks[IMX6SX_CLK_GPMI_BCH]     =3D imx_clk_gate2("gpmi_bch",      "usdhc4"=
,            base + 0x78, 26);
-	clks[IMX6SX_CLK_GPMI_IO]      =3D imx_clk_gate2("gpmi_io",       "qspi2_p=
odf",        base + 0x78, 28);
-	clks[IMX6SX_CLK_GPMI_APB]     =3D imx_clk_gate2("gpmi_apb",      "usdhc3"=
,            base + 0x78, 30);
+	hws[IMX6SX_CLK_PCIE_AXI]     =3D imx_clk_hw_gate2("pcie_axi",      "displ=
ay_podf",      base + 0x78, 0);
+	hws[IMX6SX_CLK_QSPI2]        =3D imx_clk_hw_gate2("qspi2",         "qspi2=
_podf",        base + 0x78, 10);
+	hws[IMX6SX_CLK_PER1_BCH]     =3D imx_clk_hw_gate2("per1_bch",      "usdhc=
3",            base + 0x78, 12);
+	hws[IMX6SX_CLK_PER2_MAIN]    =3D imx_clk_hw_gate2_flags("per2_main", "ahb=
", base + 0x78, 14, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_PWM1]         =3D imx_clk_hw_gate2("pwm1",          "percl=
k",            base + 0x78, 16);
+	hws[IMX6SX_CLK_PWM2]         =3D imx_clk_hw_gate2("pwm2",          "percl=
k",            base + 0x78, 18);
+	hws[IMX6SX_CLK_PWM3]         =3D imx_clk_hw_gate2("pwm3",          "percl=
k",            base + 0x78, 20);
+	hws[IMX6SX_CLK_PWM4]         =3D imx_clk_hw_gate2("pwm4",          "percl=
k",            base + 0x78, 22);
+	hws[IMX6SX_CLK_GPMI_BCH_APB] =3D imx_clk_hw_gate2("gpmi_bch_apb",  "usdhc=
3",            base + 0x78, 24);
+	hws[IMX6SX_CLK_GPMI_BCH]     =3D imx_clk_hw_gate2("gpmi_bch",      "usdhc=
4",            base + 0x78, 26);
+	hws[IMX6SX_CLK_GPMI_IO]      =3D imx_clk_hw_gate2("gpmi_io",       "qspi2=
_podf",        base + 0x78, 28);
+	hws[IMX6SX_CLK_GPMI_APB]     =3D imx_clk_hw_gate2("gpmi_apb",      "usdhc=
3",            base + 0x78, 30);
=20
 	/* CCGR5 */
-	clks[IMX6SX_CLK_ROM]          =3D imx_clk_gate2_flags("rom", "ahb", base =
+ 0x7c, 0, CLK_IS_CRITICAL);
-	clks[IMX6SX_CLK_SDMA]         =3D imx_clk_gate2("sdma",          "ahb",  =
             base + 0x7c, 6);
-	clks[IMX6SX_CLK_SPBA]         =3D imx_clk_gate2("spba",          "ipg",  =
             base + 0x7c, 12);
-	clks[IMX6SX_CLK_AUDIO]        =3D imx_clk_gate2_shared("audio",  "audio_p=
odf",        base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SX_CLK_SPDIF]        =3D imx_clk_gate2_shared("spdif",  "spdif_p=
odf",        base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SX_CLK_SPDIF_GCLK]   =3D imx_clk_gate2_shared("spdif_gclk",    "=
ipg",        base + 0x7c, 14, &share_count_audio);
-	clks[IMX6SX_CLK_SSI1_IPG]     =3D imx_clk_gate2_shared("ssi1_ipg",      "=
ipg",        base + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SX_CLK_SSI2_IPG]     =3D imx_clk_gate2_shared("ssi2_ipg",      "=
ipg",        base + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SX_CLK_SSI3_IPG]     =3D imx_clk_gate2_shared("ssi3_ipg",      "=
ipg",        base + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SX_CLK_SSI1]         =3D imx_clk_gate2_shared("ssi1",          "=
ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SX_CLK_SSI2]         =3D imx_clk_gate2_shared("ssi2",          "=
ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SX_CLK_SSI3]         =3D imx_clk_gate2_shared("ssi3",          "=
ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SX_CLK_UART_IPG]     =3D imx_clk_gate2("uart_ipg",      "ipg",  =
             base + 0x7c, 24);
-	clks[IMX6SX_CLK_UART_SERIAL]  =3D imx_clk_gate2("uart_serial",   "uart_po=
df",         base + 0x7c, 26);
-	clks[IMX6SX_CLK_SAI1_IPG]     =3D imx_clk_gate2_shared("sai1_ipg", "ipg",=
             base + 0x7c, 28, &share_count_sai1);
-	clks[IMX6SX_CLK_SAI2_IPG]     =3D imx_clk_gate2_shared("sai2_ipg", "ipg",=
             base + 0x7c, 30, &share_count_sai2);
-	clks[IMX6SX_CLK_SAI1]         =3D imx_clk_gate2_shared("sai1",	"ssi1_podf=
",        base + 0x7c, 28, &share_count_sai1);
-	clks[IMX6SX_CLK_SAI2]         =3D imx_clk_gate2_shared("sai2",	"ssi2_podf=
",        base + 0x7c, 30, &share_count_sai2);
+	hws[IMX6SX_CLK_ROM]          =3D imx_clk_hw_gate2_flags("rom", "ahb", bas=
e + 0x7c, 0, CLK_IS_CRITICAL);
+	hws[IMX6SX_CLK_SDMA]         =3D imx_clk_hw_gate2("sdma",          "ahb",=
               base + 0x7c, 6);
+	hws[IMX6SX_CLK_SPBA]         =3D imx_clk_hw_gate2("spba",          "ipg",=
               base + 0x7c, 12);
+	hws[IMX6SX_CLK_AUDIO]        =3D imx_clk_hw_gate2_shared("audio",  "audio=
_podf",        base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SX_CLK_SPDIF]        =3D imx_clk_hw_gate2_shared("spdif",  "spdif=
_podf",        base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SX_CLK_SPDIF_GCLK]   =3D imx_clk_hw_gate2_shared("spdif_gclk",   =
 "ipg",        base + 0x7c, 14, &share_count_audio);
+	hws[IMX6SX_CLK_SSI1_IPG]     =3D imx_clk_hw_gate2_shared("ssi1_ipg",     =
 "ipg",        base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SX_CLK_SSI2_IPG]     =3D imx_clk_hw_gate2_shared("ssi2_ipg",     =
 "ipg",        base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SX_CLK_SSI3_IPG]     =3D imx_clk_hw_gate2_shared("ssi3_ipg",     =
 "ipg",        base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SX_CLK_SSI1]         =3D imx_clk_hw_gate2_shared("ssi1",         =
 "ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SX_CLK_SSI2]         =3D imx_clk_hw_gate2_shared("ssi2",         =
 "ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SX_CLK_SSI3]         =3D imx_clk_hw_gate2_shared("ssi3",         =
 "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SX_CLK_UART_IPG]     =3D imx_clk_hw_gate2("uart_ipg",      "ipg",=
               base + 0x7c, 24);
+	hws[IMX6SX_CLK_UART_SERIAL]  =3D imx_clk_hw_gate2("uart_serial",   "uart_=
podf",         base + 0x7c, 26);
+	hws[IMX6SX_CLK_SAI1_IPG]     =3D imx_clk_hw_gate2_shared("sai1_ipg", "ipg=
",             base + 0x7c, 28, &share_count_sai1);
+	hws[IMX6SX_CLK_SAI2_IPG]     =3D imx_clk_hw_gate2_shared("sai2_ipg", "ipg=
",             base + 0x7c, 30, &share_count_sai2);
+	hws[IMX6SX_CLK_SAI1]         =3D imx_clk_hw_gate2_shared("sai1",	"ssi1_po=
df",        base + 0x7c, 28, &share_count_sai1);
+	hws[IMX6SX_CLK_SAI2]         =3D imx_clk_hw_gate2_shared("sai2",	"ssi2_po=
df",        base + 0x7c, 30, &share_count_sai2);
=20
 	/* CCGR6 */
-	clks[IMX6SX_CLK_USBOH3]       =3D imx_clk_gate2("usboh3",        "ipg",  =
             base + 0x80, 0);
-	clks[IMX6SX_CLK_USDHC1]       =3D imx_clk_gate2("usdhc1",        "usdhc1_=
podf",       base + 0x80, 2);
-	clks[IMX6SX_CLK_USDHC2]       =3D imx_clk_gate2("usdhc2",        "usdhc2_=
podf",       base + 0x80, 4);
-	clks[IMX6SX_CLK_USDHC3]       =3D imx_clk_gate2("usdhc3",        "usdhc3_=
podf",       base + 0x80, 6);
-	clks[IMX6SX_CLK_USDHC4]       =3D imx_clk_gate2("usdhc4",        "usdhc4_=
podf",       base + 0x80, 8);
-	clks[IMX6SX_CLK_EIM_SLOW]     =3D imx_clk_gate2("eim_slow",      "eim_slo=
w_podf",     base + 0x80, 10);
-	clks[IMX6SX_CLK_PWM8]         =3D imx_clk_gate2("pwm8",          "perclk"=
,            base + 0x80, 16);
-	clks[IMX6SX_CLK_VADC]         =3D imx_clk_gate2("vadc",          "vid_pod=
f",          base + 0x80, 20);
-	clks[IMX6SX_CLK_GIS]          =3D imx_clk_gate2("gis",           "display=
_podf",      base + 0x80, 22);
-	clks[IMX6SX_CLK_I2C4]         =3D imx_clk_gate2("i2c4",          "perclk"=
,            base + 0x80, 24);
-	clks[IMX6SX_CLK_PWM5]         =3D imx_clk_gate2("pwm5",          "perclk"=
,            base + 0x80, 26);
-	clks[IMX6SX_CLK_PWM6]         =3D imx_clk_gate2("pwm6",          "perclk"=
,            base + 0x80, 28);
-	clks[IMX6SX_CLK_PWM7]         =3D imx_clk_gate2("pwm7",          "perclk"=
,            base + 0x80, 30);
-
-	clks[IMX6SX_CLK_CKO1]         =3D imx_clk_gate("cko1",           "cko1_po=
df",         base + 0x60, 7);
-	clks[IMX6SX_CLK_CKO2]         =3D imx_clk_gate("cko2",           "cko2_po=
df",         base + 0x60, 24);
+	hws[IMX6SX_CLK_USBOH3]       =3D imx_clk_hw_gate2("usboh3",        "ipg",=
               base + 0x80, 0);
+	hws[IMX6SX_CLK_USDHC1]       =3D imx_clk_hw_gate2("usdhc1",        "usdhc=
1_podf",       base + 0x80, 2);
+	hws[IMX6SX_CLK_USDHC2]       =3D imx_clk_hw_gate2("usdhc2",        "usdhc=
2_podf",       base + 0x80, 4);
+	hws[IMX6SX_CLK_USDHC3]       =3D imx_clk_hw_gate2("usdhc3",        "usdhc=
3_podf",       base + 0x80, 6);
+	hws[IMX6SX_CLK_USDHC4]       =3D imx_clk_hw_gate2("usdhc4",        "usdhc=
4_podf",       base + 0x80, 8);
+	hws[IMX6SX_CLK_EIM_SLOW]     =3D imx_clk_hw_gate2("eim_slow",      "eim_s=
low_podf",     base + 0x80, 10);
+	hws[IMX6SX_CLK_PWM8]         =3D imx_clk_hw_gate2("pwm8",          "percl=
k",            base + 0x80, 16);
+	hws[IMX6SX_CLK_VADC]         =3D imx_clk_hw_gate2("vadc",          "vid_p=
odf",          base + 0x80, 20);
+	hws[IMX6SX_CLK_GIS]          =3D imx_clk_hw_gate2("gis",           "displ=
ay_podf",      base + 0x80, 22);
+	hws[IMX6SX_CLK_I2C4]         =3D imx_clk_hw_gate2("i2c4",          "percl=
k",            base + 0x80, 24);
+	hws[IMX6SX_CLK_PWM5]         =3D imx_clk_hw_gate2("pwm5",          "percl=
k",            base + 0x80, 26);
+	hws[IMX6SX_CLK_PWM6]         =3D imx_clk_hw_gate2("pwm6",          "percl=
k",            base + 0x80, 28);
+	hws[IMX6SX_CLK_PWM7]         =3D imx_clk_hw_gate2("pwm7",          "percl=
k",            base + 0x80, 30);
+
+	hws[IMX6SX_CLK_CKO1]         =3D imx_clk_hw_gate("cko1",           "cko1_=
podf",         base + 0x60, 7);
+	hws[IMX6SX_CLK_CKO2]         =3D imx_clk_hw_gate("cko2",           "cko2_=
podf",         base + 0x60, 24);
=20
 	/* mask handshake of mmdc */
 	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
=20
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
+	imx_check_clk_hws(hws, IMX6SX_CLK_CLK_END);
=20
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
=20
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY2_GATE]);
+		clk_prepare_enable(hws[IMX6SX_CLK_USBPHY1_GATE]->clk);
+		clk_prepare_enable(hws[IMX6SX_CLK_USBPHY2_GATE]->clk);
 	}
=20
 	/* Set the default 132MHz for EIM module */
-	clk_set_parent(clks[IMX6SX_CLK_EIM_SLOW_SEL], clks[IMX6SX_CLK_PLL2_PFD2])=
;
-	clk_set_rate(clks[IMX6SX_CLK_EIM_SLOW], 132000000);
+	clk_set_parent(hws[IMX6SX_CLK_EIM_SLOW_SEL]->clk, hws[IMX6SX_CLK_PLL2_PFD=
2]->clk);
+	clk_set_rate(hws[IMX6SX_CLK_EIM_SLOW]->clk, 132000000);
=20
 	/* set parent clock for LCDIF1 pixel clock */
-	clk_set_parent(clks[IMX6SX_CLK_LCDIF1_PRE_SEL], clks[IMX6SX_CLK_PLL5_VIDE=
O_DIV]);
-	clk_set_parent(clks[IMX6SX_CLK_LCDIF1_SEL], clks[IMX6SX_CLK_LCDIF1_PODF])=
;
+	clk_set_parent(hws[IMX6SX_CLK_LCDIF1_PRE_SEL]->clk, hws[IMX6SX_CLK_PLL5_V=
IDEO_DIV]->clk);
+	clk_set_parent(hws[IMX6SX_CLK_LCDIF1_SEL]->clk, hws[IMX6SX_CLK_LCDIF1_POD=
F]->clk);
=20
 	/* Set the parent clks of PCIe lvds1 and pcie_axi to be pcie ref, axi */
-	if (clk_set_parent(clks[IMX6SX_CLK_LVDS1_SEL], clks[IMX6SX_CLK_PCIE_REF_1=
25M]))
+	if (clk_set_parent(hws[IMX6SX_CLK_LVDS1_SEL]->clk, hws[IMX6SX_CLK_PCIE_RE=
F_125M]->clk))
 		pr_err("Failed to set pcie bus parent clk.\n");
=20
 	/*
 	 * Init enet system AHB clock, set to 200MHz
 	 * pll2_pfd2_396m-> ENET_PODF-> ENET_AHB
 	 */
-	clk_set_parent(clks[IMX6SX_CLK_ENET_PRE_SEL], clks[IMX6SX_CLK_PLL2_PFD2])=
;
-	clk_set_parent(clks[IMX6SX_CLK_ENET_SEL], clks[IMX6SX_CLK_ENET_PODF]);
-	clk_set_rate(clks[IMX6SX_CLK_ENET_PODF], 200000000);
-	clk_set_rate(clks[IMX6SX_CLK_ENET_REF], 125000000);
-	clk_set_rate(clks[IMX6SX_CLK_ENET2_REF], 125000000);
+	clk_set_parent(hws[IMX6SX_CLK_ENET_PRE_SEL]->clk, hws[IMX6SX_CLK_PLL2_PFD=
2]->clk);
+	clk_set_parent(hws[IMX6SX_CLK_ENET_SEL]->clk, hws[IMX6SX_CLK_ENET_PODF]->=
clk);
+	clk_set_rate(hws[IMX6SX_CLK_ENET_PODF]->clk, 200000000);
+	clk_set_rate(hws[IMX6SX_CLK_ENET_REF]->clk, 125000000);
+	clk_set_rate(hws[IMX6SX_CLK_ENET2_REF]->clk, 125000000);
=20
 	/* Audio clocks */
-	clk_set_rate(clks[IMX6SX_CLK_PLL4_AUDIO_DIV], 393216000);
+	clk_set_rate(hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk, 393216000);
=20
-	clk_set_parent(clks[IMX6SX_CLK_SPDIF_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV=
]);
-	clk_set_rate(clks[IMX6SX_CLK_SPDIF_PODF], 98304000);
+	clk_set_parent(hws[IMX6SX_CLK_SPDIF_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_=
DIV]->clk);
+	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 98304000);
=20
-	clk_set_parent(clks[IMX6SX_CLK_AUDIO_SEL], clks[IMX6SX_CLK_PLL3_USB_OTG])=
;
-	clk_set_rate(clks[IMX6SX_CLK_AUDIO_PODF], 24000000);
+	clk_set_parent(hws[IMX6SX_CLK_AUDIO_SEL]->clk, hws[IMX6SX_CLK_PLL3_USB_OT=
G]->clk);
+	clk_set_rate(hws[IMX6SX_CLK_AUDIO_PODF]->clk, 24000000);
=20
-	clk_set_parent(clks[IMX6SX_CLK_SSI1_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]=
);
-	clk_set_parent(clks[IMX6SX_CLK_SSI2_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]=
);
-	clk_set_parent(clks[IMX6SX_CLK_SSI3_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]=
);
-	clk_set_rate(clks[IMX6SX_CLK_SSI1_PODF], 24576000);
-	clk_set_rate(clks[IMX6SX_CLK_SSI2_PODF], 24576000);
-	clk_set_rate(clks[IMX6SX_CLK_SSI3_PODF], 24576000);
+	clk_set_parent(hws[IMX6SX_CLK_SSI1_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_D=
IV]->clk);
+	clk_set_parent(hws[IMX6SX_CLK_SSI2_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_D=
IV]->clk);
+	clk_set_parent(hws[IMX6SX_CLK_SSI3_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_D=
IV]->clk);
+	clk_set_rate(hws[IMX6SX_CLK_SSI1_PODF]->clk, 24576000);
+	clk_set_rate(hws[IMX6SX_CLK_SSI2_PODF]->clk, 24576000);
+	clk_set_rate(hws[IMX6SX_CLK_SSI3_PODF]->clk, 24576000);
=20
-	clk_set_parent(clks[IMX6SX_CLK_ESAI_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]=
);
-	clk_set_rate(clks[IMX6SX_CLK_ESAI_PODF], 24576000);
+	clk_set_parent(hws[IMX6SX_CLK_ESAI_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_D=
IV]->clk);
+	clk_set_rate(hws[IMX6SX_CLK_ESAI_PODF]->clk, 24576000);
=20
 	/* Set parent clock for vadc */
-	clk_set_parent(clks[IMX6SX_CLK_VID_SEL], clks[IMX6SX_CLK_PLL3_USB_OTG]);
+	clk_set_parent(hws[IMX6SX_CLK_VID_SEL]->clk, hws[IMX6SX_CLK_PLL3_USB_OTG]=
->clk);
=20
 	/* default parent of can_sel clock is invalid, manually set it here */
-	clk_set_parent(clks[IMX6SX_CLK_CAN_SEL], clks[IMX6SX_CLK_PLL3_60M]);
+	clk_set_parent(hws[IMX6SX_CLK_CAN_SEL]->clk, hws[IMX6SX_CLK_PLL3_60M]->cl=
k);
=20
 	/* Update gpu clock from default 528M to 720M */
-	clk_set_parent(clks[IMX6SX_CLK_GPU_CORE_SEL], clks[IMX6SX_CLK_PLL3_PFD0])=
;
-	clk_set_parent(clks[IMX6SX_CLK_GPU_AXI_SEL], clks[IMX6SX_CLK_PLL3_PFD0]);
+	clk_set_parent(hws[IMX6SX_CLK_GPU_CORE_SEL]->clk, hws[IMX6SX_CLK_PLL3_PFD=
0]->clk);
+	clk_set_parent(hws[IMX6SX_CLK_GPU_AXI_SEL]->clk, hws[IMX6SX_CLK_PLL3_PFD0=
]->clk);
=20
-	clk_set_parent(clks[IMX6SX_CLK_QSPI1_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
-	clk_set_parent(clks[IMX6SX_CLK_QSPI2_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
+	clk_set_parent(hws[IMX6SX_CLK_QSPI1_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->=
clk);
+	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->=
clk);
+
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_clks[i] =3D &hws[index]->clk;
+	}
=20
 	imx_register_uart_clocks(uart_clks);
 }
--=20
2.7.4

