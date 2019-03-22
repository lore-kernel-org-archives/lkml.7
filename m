Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82876218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EMXYBonK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfCVPhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:47 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:8337
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbfCVPho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cYSowEGNNnl80ZUV8WxCKRf6c39KPEElkiVRSmbrYk=;
 b=EMXYBonKowHPupjc+1yEAmElpJGypU6dBWIxUzjVOEMFBrYGdiEvGCE7jAaXPuoRF9tHVeEBoX93OeT/yTWVs+OSfCSpEG1ERyAtE3xtJXY/I4Sywzomu3Etms4p0r/ojPy14qrsWtYAaC7KhRap7ps2HcANbqGUxogF4iYNmJU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:21 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:21 +0000
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
Subject: [RFC 17/19] clk: imx6ul: Switch to clk_hw based API
Thread-Topic: [RFC 17/19] clk: imx6ul: Switch to clk_hw based API
Thread-Index: AQHU4MUjjhL9wfZyUECJHG1BBDE2pQ==
Date:   Fri, 22 Mar 2019 15:37:21 +0000
Message-ID: <1553269010-15591-18-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: d14aec7f-d299-4c2e-e4ad-08d6aedc45db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB48022DB1A8D04BBB90717D6FF6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(14444005)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(53946003)(26005)(186003)(105586002)(102836004)(6436002)(30864003)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002)(32563001)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GeFnJSjv61i2n9X7GoF1TNqMiZR3tV27SiHglyr/JqjKCxzytIeBISFB5NnH+VZMNmYrW9uS5RpXjbK1XtdpQg5ZDh6hrmCLPbgBCYAbPC8d56bMJsy1k+cC45hoipI1veoImtwu54teexXTF0yUtlH/pYYw7z/HyPdVbeRdBkETSkC28tpNe/zhSt/NsIN/pY7FGApG140gj3hEPUHaMBhmfb22afpdnHfTEWVSfEpoQ/sHp+MRPULmRkUHTnYTExyqja2UVRLLVJSeqYULhgoG30Ixsox4q4vsmFYoZCku7GF9Wwfz/Z6N1UhQn0+tkLPx0cPdAmR2IqHM/KUe09KJiMIlcdnOI7jtH1sA/ryp7ntFqFas4ptmMddfdDxOFog+kbkPIteNCn4UVkLcUVXdVvt4MYpEugIysfSkXOI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14aec7f-d299-4c2e-e4ad-08d6aedc45db
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:21.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx6ul driver to clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c | 574 ++++++++++++++++++++++-----------------=
----
 1 file changed, 290 insertions(+), 284 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index fd60d15..2dab212 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -76,8 +76,8 @@ static const char *cko2_sels[] =3D { "dummy", "dummy", "d=
ummy", "usdhc1", "dummy",
 				   "dummy", "dummy", "dummy", "dummy", "uart_serial", "spdif", "dummy"=
, "dummy", };
 static const char *cko_sels[] =3D { "cko1", "cko2", };
=20
-static struct clk *clks[IMX6UL_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
=20
 static const struct clk_div_table clk_enet_ref_table[] =3D {
 	{ .val =3D 0, .div =3D 20, },
@@ -124,61 +124,69 @@ static void __init imx6ul_clocks_init(struct device_n=
ode *ccm_node)
 	struct device_node *np;
 	void __iomem *base;
=20
-	clks[IMX6UL_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX6UL_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
=20
-	clks[IMX6UL_CLK_CKIL] =3D of_clk_get_by_name(ccm_node, "ckil");
-	clks[IMX6UL_CLK_OSC] =3D of_clk_get_by_name(ccm_node, "osc");
+	clk_hw_data->num =3D IMX6UL_CLK_END;
+	hws =3D clk_hw_data->hws;
+
+	hws[IMX6UL_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+
+	hws[IMX6UL_CLK_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil"=
));
+	hws[IMX6UL_CLK_OSC] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc"))=
;
=20
 	/* ipp_di clock is external input */
-	clks[IMX6UL_CLK_IPP_DI0] =3D of_clk_get_by_name(ccm_node, "ipp_di0");
-	clks[IMX6UL_CLK_IPP_DI1] =3D of_clk_get_by_name(ccm_node, "ipp_di1");
+	hws[IMX6UL_CLK_IPP_DI0] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di0"));
+	hws[IMX6UL_CLK_IPP_DI1] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ip=
p_di1"));
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6ul-anatop");
 	base =3D of_iomap(np, 0);
 	of_node_put(np);
 	WARN_ON(!base);
=20
-	clks[IMX6UL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL2_BYPASS_SRC] =3D imx_clk_mux("pll2_bypass_src", base + 0x=
30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL3_BYPASS_SRC] =3D imx_clk_mux("pll3_bypass_src", base + 0x=
10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL4_BYPASS_SRC] =3D imx_clk_mux("pll4_bypass_src", base + 0x=
70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL5_BYPASS_SRC] =3D imx_clk_mux("pll5_bypass_src", base + 0x=
a0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL6_BYPASS_SRC] =3D imx_clk_mux("pll6_bypass_src", base + 0x=
e0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6UL_PLL7_BYPASS_SRC] =3D imx_clk_mux("pll7_bypass_src", base + 0x=
20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-
-	clks[IMX6UL_CLK_PLL1] =3D imx_clk_pllv3(IMX_PLLV3_SYS,	 "pll1", "osc", ba=
se + 0x00, 0x7f);
-	clks[IMX6UL_CLK_PLL2] =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc",=
 base + 0x30, 0x1);
-	clks[IMX6UL_CLK_PLL3] =3D imx_clk_pllv3(IMX_PLLV3_USB,	 "pll3", "osc", ba=
se + 0x10, 0x3);
-	clks[IMX6UL_CLK_PLL4] =3D imx_clk_pllv3(IMX_PLLV3_AV,	 "pll4", "osc", bas=
e + 0x70, 0x7f);
-	clks[IMX6UL_CLK_PLL5] =3D imx_clk_pllv3(IMX_PLLV3_AV,	 "pll5", "osc", bas=
e + 0xa0, 0x7f);
-	clks[IMX6UL_CLK_PLL6] =3D imx_clk_pllv3(IMX_PLLV3_ENET,	 "pll6", "osc", b=
ase + 0xe0, 0x3);
-	clks[IMX6UL_CLK_PLL7] =3D imx_clk_pllv3(IMX_PLLV3_USB,	 "pll7", "osc", ba=
se + 0x20, 0x3);
-
-	clks[IMX6UL_PLL1_BYPASS] =3D imx_clk_mux_flags("pll1_bypass", base + 0x00=
, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL2_BYPASS] =3D imx_clk_mux_flags("pll2_bypass", base + 0x30=
, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL3_BYPASS] =3D imx_clk_mux_flags("pll3_bypass", base + 0x10=
, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL4_BYPASS] =3D imx_clk_mux_flags("pll4_bypass", base + 0x70=
, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL5_BYPASS] =3D imx_clk_mux_flags("pll5_bypass", base + 0xa0=
, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL6_BYPASS] =3D imx_clk_mux_flags("pll6_bypass", base + 0xe0=
, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_PLL7_BYPASS] =3D imx_clk_mux_flags("pll7_bypass", base + 0x20=
, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6UL_CLK_CSI_SEL] =3D imx_clk_mux_flags("csi_sel", base + 0x3c, 9,=
 2, csi_sels, ARRAY_SIZE(csi_sels), CLK_SET_RATE_PARENT);
+	hws[IMX6UL_PLL1_BYPASS_SRC] =3D imx_clk_hw_mux("pll1_bypass_src", base + =
0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL2_BYPASS_SRC] =3D imx_clk_hw_mux("pll2_bypass_src", base + =
0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL3_BYPASS_SRC] =3D imx_clk_hw_mux("pll3_bypass_src", base + =
0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL4_BYPASS_SRC] =3D imx_clk_hw_mux("pll4_bypass_src", base + =
0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL5_BYPASS_SRC] =3D imx_clk_hw_mux("pll5_bypass_src", base + =
0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL6_BYPASS_SRC] =3D imx_clk_hw_mux("pll6_bypass_src", base + =
0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6UL_PLL7_BYPASS_SRC] =3D imx_clk_hw_mux("pll7_bypass_src", base + =
0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+
+	hws[IMX6UL_CLK_PLL1] =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS,	 "pll1", "osc", =
base + 0x00, 0x7f);
+	hws[IMX6UL_CLK_PLL2] =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc=
", base + 0x30, 0x1);
+	hws[IMX6UL_CLK_PLL3] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,	 "pll3", "osc", =
base + 0x10, 0x3);
+	hws[IMX6UL_CLK_PLL4] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,	 "pll4", "osc", b=
ase + 0x70, 0x7f);
+	hws[IMX6UL_CLK_PLL5] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,	 "pll5", "osc", b=
ase + 0xa0, 0x7f);
+	hws[IMX6UL_CLK_PLL6] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET,	 "pll6", "osc",=
 base + 0xe0, 0x3);
+	hws[IMX6UL_CLK_PLL7] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,	 "pll7", "osc", =
base + 0x20, 0x3);
+
+	hws[IMX6UL_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("pll1_bypass", base + 0x=
00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("pll2_bypass", base + 0x=
30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("pll3_bypass", base + 0x=
10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL4_BYPASS] =3D imx_clk_hw_mux_flags("pll4_bypass", base + 0x=
70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL5_BYPASS] =3D imx_clk_hw_mux_flags("pll5_bypass", base + 0x=
a0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL6_BYPASS] =3D imx_clk_hw_mux_flags("pll6_bypass", base + 0x=
e0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_PLL7_BYPASS] =3D imx_clk_hw_mux_flags("pll7_bypass", base + 0x=
20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6UL_CLK_CSI_SEL] =3D imx_clk_hw_mux_flags("csi_sel", base + 0x3c, =
9, 2, csi_sels, ARRAY_SIZE(csi_sels), CLK_SET_RATE_PARENT);
=20
 	/* Do not bypass PLLs initially */
-	clk_set_parent(clks[IMX6UL_PLL1_BYPASS], clks[IMX6UL_CLK_PLL1]);
-	clk_set_parent(clks[IMX6UL_PLL2_BYPASS], clks[IMX6UL_CLK_PLL2]);
-	clk_set_parent(clks[IMX6UL_PLL3_BYPASS], clks[IMX6UL_CLK_PLL3]);
-	clk_set_parent(clks[IMX6UL_PLL4_BYPASS], clks[IMX6UL_CLK_PLL4]);
-	clk_set_parent(clks[IMX6UL_PLL5_BYPASS], clks[IMX6UL_CLK_PLL5]);
-	clk_set_parent(clks[IMX6UL_PLL6_BYPASS], clks[IMX6UL_CLK_PLL6]);
-	clk_set_parent(clks[IMX6UL_PLL7_BYPASS], clks[IMX6UL_CLK_PLL7]);
-
-	clks[IMX6UL_CLK_PLL1_SYS]	=3D imx_clk_fixed_factor("pll1_sys",	"pll1_bypa=
ss", 1, 1);
-	clks[IMX6UL_CLK_PLL2_BUS]	=3D imx_clk_gate("pll2_bus",	"pll2_bypass", bas=
e + 0x30, 13);
-	clks[IMX6UL_CLK_PLL3_USB_OTG]	=3D imx_clk_gate("pll3_usb_otg",	"pll3_bypa=
ss", base + 0x10, 13);
-	clks[IMX6UL_CLK_PLL4_AUDIO]	=3D imx_clk_gate("pll4_audio",	"pll4_bypass",=
 base + 0x70, 13);
-	clks[IMX6UL_CLK_PLL5_VIDEO]	=3D imx_clk_gate("pll5_video",	"pll5_bypass",=
 base + 0xa0, 13);
-	clks[IMX6UL_CLK_PLL6_ENET]	=3D imx_clk_gate("pll6_enet",	"pll6_bypass", b=
ase + 0xe0, 13);
-	clks[IMX6UL_CLK_PLL7_USB_HOST]	=3D imx_clk_gate("pll7_usb_host",	"pll7_by=
pass", base + 0x20, 13);
+	clk_set_parent(hws[IMX6UL_PLL1_BYPASS]->clk, hws[IMX6UL_CLK_PLL1]->clk);
+	clk_set_parent(hws[IMX6UL_PLL2_BYPASS]->clk, hws[IMX6UL_CLK_PLL2]->clk);
+	clk_set_parent(hws[IMX6UL_PLL3_BYPASS]->clk, hws[IMX6UL_CLK_PLL3]->clk);
+	clk_set_parent(hws[IMX6UL_PLL4_BYPASS]->clk, hws[IMX6UL_CLK_PLL4]->clk);
+	clk_set_parent(hws[IMX6UL_PLL5_BYPASS]->clk, hws[IMX6UL_CLK_PLL5]->clk);
+	clk_set_parent(hws[IMX6UL_PLL6_BYPASS]->clk, hws[IMX6UL_CLK_PLL6]->clk);
+	clk_set_parent(hws[IMX6UL_PLL7_BYPASS]->clk, hws[IMX6UL_CLK_PLL7]->clk);
+
+	hws[IMX6UL_CLK_PLL1_SYS]	=3D imx_clk_hw_fixed_factor("pll1_sys",	"pll1_by=
pass", 1, 1);
+	hws[IMX6UL_CLK_PLL2_BUS]	=3D imx_clk_hw_gate("pll2_bus",	"pll2_bypass", b=
ase + 0x30, 13);
+	hws[IMX6UL_CLK_PLL3_USB_OTG]	=3D imx_clk_hw_gate("pll3_usb_otg",	"pll3_by=
pass", base + 0x10, 13);
+	hws[IMX6UL_CLK_PLL4_AUDIO]	=3D imx_clk_hw_gate("pll4_audio",	"pll4_bypass=
", base + 0x70, 13);
+	hws[IMX6UL_CLK_PLL5_VIDEO]	=3D imx_clk_hw_gate("pll5_video",	"pll5_bypass=
", base + 0xa0, 13);
+	hws[IMX6UL_CLK_PLL6_ENET]	=3D imx_clk_hw_gate("pll6_enet",	"pll6_bypass",=
 base + 0xe0, 13);
+	hws[IMX6UL_CLK_PLL7_USB_HOST]	=3D imx_clk_hw_gate("pll7_usb_host",	"pll7_=
bypass", base + 0x20, 13);
=20
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
@@ -186,291 +194,289 @@ static void __init imx6ul_clocks_init(struct device=
_node *ccm_node)
 	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
 	 * the clk framework many need to enable/disable usbphy's parent
 	 */
-	clks[IMX6UL_CLK_USBPHY1] =3D imx_clk_gate("usbphy1", "pll3_usb_otg",  bas=
e + 0x10, 20);
-	clks[IMX6UL_CLK_USBPHY2] =3D imx_clk_gate("usbphy2", "pll7_usb_host", bas=
e + 0x20, 20);
+	hws[IMX6UL_CLK_USBPHY1] =3D imx_clk_hw_gate("usbphy1", "pll3_usb_otg",  b=
ase + 0x10, 20);
+	hws[IMX6UL_CLK_USBPHY2] =3D imx_clk_hw_gate("usbphy2", "pll7_usb_host", b=
ase + 0x20, 20);
=20
 	/*
 	 * usbphy*_gate needs to be on after system boots up, and software
 	 * never needs to control it anymore.
 	 */
-	clks[IMX6UL_CLK_USBPHY1_GATE] =3D imx_clk_gate("usbphy1_gate", "dummy", b=
ase + 0x10, 6);
-	clks[IMX6UL_CLK_USBPHY2_GATE] =3D imx_clk_gate("usbphy2_gate", "dummy", b=
ase + 0x20, 6);
+	hws[IMX6UL_CLK_USBPHY1_GATE] =3D imx_clk_hw_gate("usbphy1_gate", "dummy",=
 base + 0x10, 6);
+	hws[IMX6UL_CLK_USBPHY2_GATE] =3D imx_clk_hw_gate("usbphy2_gate", "dummy",=
 base + 0x20, 6);
=20
 	/*					name		   parent_name	   reg		idx */
-	clks[IMX6UL_CLK_PLL2_PFD0] =3D imx_clk_pfd("pll2_pfd0_352m", "pll2_bus",	=
   base + 0x100, 0);
-	clks[IMX6UL_CLK_PLL2_PFD1] =3D imx_clk_pfd("pll2_pfd1_594m", "pll2_bus",	=
   base + 0x100, 1);
-	clks[IMX6UL_CLK_PLL2_PFD2] =3D imx_clk_pfd("pll2_pfd2_396m", "pll2_bus",	=
   base + 0x100, 2);
-	clks[IMX6UL_CLK_PLL2_PFD3] =3D imx_clk_pfd("pll2_pfd3_594m", "pll2_bus",	=
   base + 0x100, 3);
-	clks[IMX6UL_CLK_PLL3_PFD0] =3D imx_clk_pfd("pll3_pfd0_720m", "pll3_usb_ot=
g", base + 0xf0,  0);
-	clks[IMX6UL_CLK_PLL3_PFD1] =3D imx_clk_pfd("pll3_pfd1_540m", "pll3_usb_ot=
g", base + 0xf0,  1);
-	clks[IMX6UL_CLK_PLL3_PFD2] =3D imx_clk_pfd("pll3_pfd2_508m", "pll3_usb_ot=
g", base + 0xf0,	 2);
-	clks[IMX6UL_CLK_PLL3_PFD3] =3D imx_clk_pfd("pll3_pfd3_454m", "pll3_usb_ot=
g", base + 0xf0,	 3);
-
-	clks[IMX6UL_CLK_ENET_REF] =3D clk_register_divider_table(NULL, "enet_ref"=
, "pll6_enet", 0,
+	hws[IMX6UL_CLK_PLL2_PFD0] =3D imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_bus"=
,	   base + 0x100, 0);
+	hws[IMX6UL_CLK_PLL2_PFD1] =3D imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_bus"=
,	   base + 0x100, 1);
+	hws[IMX6UL_CLK_PLL2_PFD2] =3D imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_bus"=
,	   base + 0x100, 2);
+	hws[IMX6UL_CLK_PLL2_PFD3] =3D imx_clk_hw_pfd("pll2_pfd3_594m", "pll2_bus"=
,	   base + 0x100, 3);
+	hws[IMX6UL_CLK_PLL3_PFD0] =3D imx_clk_hw_pfd("pll3_pfd0_720m", "pll3_usb_=
otg", base + 0xf0,  0);
+	hws[IMX6UL_CLK_PLL3_PFD1] =3D imx_clk_hw_pfd("pll3_pfd1_540m", "pll3_usb_=
otg", base + 0xf0,  1);
+	hws[IMX6UL_CLK_PLL3_PFD2] =3D imx_clk_hw_pfd("pll3_pfd2_508m", "pll3_usb_=
otg", base + 0xf0,	 2);
+	hws[IMX6UL_CLK_PLL3_PFD3] =3D imx_clk_hw_pfd("pll3_pfd3_454m", "pll3_usb_=
otg", base + 0xf0,	 3);
+
+	hws[IMX6UL_CLK_ENET_REF] =3D clk_hw_register_divider_table(NULL, "enet_re=
f", "pll6_enet", 0,
 			base + 0xe0, 0, 2, 0, clk_enet_ref_table, &imx_ccm_lock);
-	clks[IMX6UL_CLK_ENET2_REF] =3D clk_register_divider_table(NULL, "enet2_re=
f", "pll6_enet", 0,
+	hws[IMX6UL_CLK_ENET2_REF] =3D clk_hw_register_divider_table(NULL, "enet2_=
ref", "pll6_enet", 0,
 			base + 0xe0, 2, 2, 0, clk_enet_ref_table, &imx_ccm_lock);
=20
-	clks[IMX6UL_CLK_ENET2_REF_125M] =3D imx_clk_gate("enet_ref_125m", "enet2_=
ref", base + 0xe0, 20);
-	clks[IMX6UL_CLK_ENET_PTP_REF]	=3D imx_clk_fixed_factor("enet_ptp_ref", "p=
ll6_enet", 1, 20);
-	clks[IMX6UL_CLK_ENET_PTP]	=3D imx_clk_gate("enet_ptp", "enet_ptp_ref", ba=
se + 0xe0, 21);
+	hws[IMX6UL_CLK_ENET2_REF_125M] =3D imx_clk_hw_gate("enet_ref_125m", "enet=
2_ref", base + 0xe0, 20);
+	hws[IMX6UL_CLK_ENET_PTP_REF]	=3D imx_clk_hw_fixed_factor("enet_ptp_ref", =
"pll6_enet", 1, 20);
+	hws[IMX6UL_CLK_ENET_PTP]	=3D imx_clk_hw_gate("enet_ptp", "enet_ptp_ref", =
base + 0xe0, 21);
=20
-	clks[IMX6UL_CLK_PLL4_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
4_post_div", "pll4_audio",
+	hws[IMX6UL_CLK_PLL4_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll4_post_div", "pll4_audio",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 19, 2, 0, post_di=
v_table, &imx_ccm_lock);
-	clks[IMX6UL_CLK_PLL4_AUDIO_DIV] =3D clk_register_divider(NULL, "pll4_audi=
o_div", "pll4_post_div",
+	hws[IMX6UL_CLK_PLL4_AUDIO_DIV] =3D clk_hw_register_divider(NULL, "pll4_au=
dio_div", "pll4_post_div",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x170, 15, 1, 0, &imx_c=
cm_lock);
-	clks[IMX6UL_CLK_PLL5_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
5_post_div", "pll5_video",
+	hws[IMX6UL_CLK_PLL5_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll5_post_div", "pll5_video",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xa0, 19, 2, 0, post_di=
v_table, &imx_ccm_lock);
-	clks[IMX6UL_CLK_PLL5_VIDEO_DIV] =3D clk_register_divider_table(NULL, "pll=
5_video_div", "pll5_post_div",
+	hws[IMX6UL_CLK_PLL5_VIDEO_DIV] =3D clk_hw_register_divider_table(NULL, "p=
ll5_video_div", "pll5_post_div",
 		 CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x170, 30, 2, 0, video_=
div_table, &imx_ccm_lock);
=20
 	/*						   name		parent_name	 mult  div */
-	clks[IMX6UL_CLK_PLL2_198M] =3D imx_clk_fixed_factor("pll2_198m", "pll2_pf=
d2_396m", 1,	2);
-	clks[IMX6UL_CLK_PLL3_80M]  =3D imx_clk_fixed_factor("pll3_80m",  "pll3_us=
b_otg",   1,	6);
-	clks[IMX6UL_CLK_PLL3_60M]  =3D imx_clk_fixed_factor("pll3_60m",  "pll3_us=
b_otg",   1,	8);
-	clks[IMX6UL_CLK_GPT_3M]	   =3D imx_clk_fixed_factor("gpt_3m",	"osc",		 1,=
	8);
+	hws[IMX6UL_CLK_PLL2_198M] =3D imx_clk_hw_fixed_factor("pll2_198m", "pll2_=
pfd2_396m", 1,	2);
+	hws[IMX6UL_CLK_PLL3_80M]  =3D imx_clk_hw_fixed_factor("pll3_80m",  "pll3_=
usb_otg",   1,	6);
+	hws[IMX6UL_CLK_PLL3_60M]  =3D imx_clk_hw_fixed_factor("pll3_60m",  "pll3_=
usb_otg",   1,	8);
+	hws[IMX6UL_CLK_GPT_3M]	   =3D imx_clk_hw_fixed_factor("gpt_3m",	"osc",		 =
1,	8);
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX6UL_CA7_SECONDARY_SEL]	  =3D imx_clk_mux("ca7_secondary_sel", bas=
e + 0xc, 3, 1, ca7_secondary_sels, ARRAY_SIZE(ca7_secondary_sels));
-	clks[IMX6UL_CLK_STEP]		  =3D imx_clk_mux("step", base + 0x0c, 8, 1, step_=
sels, ARRAY_SIZE(step_sels));
-	clks[IMX6UL_CLK_PLL1_SW]	  =3D imx_clk_mux_flags("pll1_sw",   base + 0x0c=
, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
-	clks[IMX6UL_CLK_AXI_ALT_SEL]	  =3D imx_clk_mux("axi_alt_sel",		base + 0x1=
4, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
-	clks[IMX6UL_CLK_AXI_SEL]	  =3D imx_clk_mux_flags("axi_sel",	base + 0x14, =
6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
-	clks[IMX6UL_CLK_PERIPH_PRE]	  =3D imx_clk_mux("periph_pre",       base + =
0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
-	clks[IMX6UL_CLK_PERIPH2_PRE]	  =3D imx_clk_mux("periph2_pre",      base +=
 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
-	clks[IMX6UL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_mux("periph_clk2_sel",  bas=
e + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
-	clks[IMX6UL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_mux("periph2_clk2_sel", bas=
e + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clks[IMX6UL_CLK_EIM_SLOW_SEL]	  =3D imx_clk_mux("eim_slow_sel", base + 0x=
1c, 29, 2, eim_slow_sels, ARRAY_SIZE(eim_slow_sels));
-	clks[IMX6UL_CLK_GPMI_SEL]	  =3D imx_clk_mux("gpmi_sel",     base + 0x1c, =
19, 1, gpmi_sels, ARRAY_SIZE(gpmi_sels));
-	clks[IMX6UL_CLK_BCH_SEL]	  =3D imx_clk_mux("bch_sel",	base + 0x1c, 18, 1,=
 bch_sels, ARRAY_SIZE(bch_sels));
-	clks[IMX6UL_CLK_USDHC2_SEL]	  =3D imx_clk_mux("usdhc2_sel",   base + 0x1c=
, 17, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6UL_CLK_USDHC1_SEL]	  =3D imx_clk_mux("usdhc1_sel",   base + 0x1c=
, 16, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
-	clks[IMX6UL_CLK_SAI3_SEL]	  =3D imx_clk_mux("sai3_sel",     base + 0x1c, =
14, 2, sai_sels, ARRAY_SIZE(sai_sels));
-	clks[IMX6UL_CLK_SAI2_SEL]         =3D imx_clk_mux("sai2_sel",     base + =
0x1c, 12, 2, sai_sels, ARRAY_SIZE(sai_sels));
-	clks[IMX6UL_CLK_SAI1_SEL]	  =3D imx_clk_mux("sai1_sel",     base + 0x1c, =
10, 2, sai_sels, ARRAY_SIZE(sai_sels));
-	clks[IMX6UL_CLK_QSPI1_SEL]	  =3D imx_clk_mux("qspi1_sel",    base + 0x1c,=
 7,  3, qspi1_sels, ARRAY_SIZE(qspi1_sels));
-	clks[IMX6UL_CLK_PERCLK_SEL]	  =3D imx_clk_mux("perclk_sel",	base + 0x1c, =
6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
-	clks[IMX6UL_CLK_CAN_SEL]	  =3D imx_clk_mux("can_sel",	base + 0x20, 8,  2,=
 can_sels, ARRAY_SIZE(can_sels));
+	hws[IMX6UL_CA7_SECONDARY_SEL]	  =3D imx_clk_hw_mux("ca7_secondary_sel", b=
ase + 0xc, 3, 1, ca7_secondary_sels, ARRAY_SIZE(ca7_secondary_sels));
+	hws[IMX6UL_CLK_STEP]		  =3D imx_clk_hw_mux("step", base + 0x0c, 8, 1, ste=
p_sels, ARRAY_SIZE(step_sels));
+	hws[IMX6UL_CLK_PLL1_SW]	  =3D imx_clk_hw_mux_flags("pll1_sw",   base + 0x=
0c, 2,  1, pll1_sw_sels, ARRAY_SIZE(pll1_sw_sels), 0);
+	hws[IMX6UL_CLK_AXI_ALT_SEL]	  =3D imx_clk_hw_mux("axi_alt_sel",		base + 0=
x14, 7,  1, axi_alt_sels, ARRAY_SIZE(axi_alt_sels));
+	hws[IMX6UL_CLK_AXI_SEL]	  =3D imx_clk_hw_mux_flags("axi_sel",	base + 0x14=
, 6,  1, axi_sels, ARRAY_SIZE(axi_sels), 0);
+	hws[IMX6UL_CLK_PERIPH_PRE]	  =3D imx_clk_hw_mux("periph_pre",       base =
+ 0x18, 18, 2, periph_pre_sels, ARRAY_SIZE(periph_pre_sels));
+	hws[IMX6UL_CLK_PERIPH2_PRE]	  =3D imx_clk_hw_mux("periph2_pre",      base=
 + 0x18, 21, 2, periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels));
+	hws[IMX6UL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_hw_mux("periph_clk2_sel",  b=
ase + 0x18, 12, 2, periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels));
+	hws[IMX6UL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_hw_mux("periph2_clk2_sel", b=
ase + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
+	hws[IMX6UL_CLK_EIM_SLOW_SEL]	  =3D imx_clk_hw_mux("eim_slow_sel", base + =
0x1c, 29, 2, eim_slow_sels, ARRAY_SIZE(eim_slow_sels));
+	hws[IMX6UL_CLK_GPMI_SEL]	  =3D imx_clk_hw_mux("gpmi_sel",     base + 0x1c=
, 19, 1, gpmi_sels, ARRAY_SIZE(gpmi_sels));
+	hws[IMX6UL_CLK_BCH_SEL]	  =3D imx_clk_hw_mux("bch_sel",	base + 0x1c, 18, =
1, bch_sels, ARRAY_SIZE(bch_sels));
+	hws[IMX6UL_CLK_USDHC2_SEL]	  =3D imx_clk_hw_mux("usdhc2_sel",   base + 0x=
1c, 17, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
+	hws[IMX6UL_CLK_USDHC1_SEL]	  =3D imx_clk_hw_mux("usdhc1_sel",   base + 0x=
1c, 16, 1, usdhc_sels, ARRAY_SIZE(usdhc_sels));
+	hws[IMX6UL_CLK_SAI3_SEL]	  =3D imx_clk_hw_mux("sai3_sel",     base + 0x1c=
, 14, 2, sai_sels, ARRAY_SIZE(sai_sels));
+	hws[IMX6UL_CLK_SAI2_SEL]         =3D imx_clk_hw_mux("sai2_sel",     base =
+ 0x1c, 12, 2, sai_sels, ARRAY_SIZE(sai_sels));
+	hws[IMX6UL_CLK_SAI1_SEL]	  =3D imx_clk_hw_mux("sai1_sel",     base + 0x1c=
, 10, 2, sai_sels, ARRAY_SIZE(sai_sels));
+	hws[IMX6UL_CLK_QSPI1_SEL]	  =3D imx_clk_hw_mux("qspi1_sel",    base + 0x1=
c, 7,  3, qspi1_sels, ARRAY_SIZE(qspi1_sels));
+	hws[IMX6UL_CLK_PERCLK_SEL]	  =3D imx_clk_hw_mux("perclk_sel",	base + 0x1c=
, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
+	hws[IMX6UL_CLK_CAN_SEL]	  =3D imx_clk_hw_mux("can_sel",	base + 0x20, 8,  =
2, can_sels, ARRAY_SIZE(can_sels));
 	if (clk_on_imx6ull())
-		clks[IMX6ULL_CLK_ESAI_SEL]	  =3D imx_clk_mux("esai_sel",	base + 0x20, 19=
, 2, esai_sels, ARRAY_SIZE(esai_sels));
-	clks[IMX6UL_CLK_UART_SEL]	  =3D imx_clk_mux("uart_sel",	base + 0x24, 6,  =
1, uart_sels, ARRAY_SIZE(uart_sels));
-	clks[IMX6UL_CLK_ENFC_SEL]	  =3D imx_clk_mux("enfc_sel",	base + 0x2c, 15, =
3, enfc_sels, ARRAY_SIZE(enfc_sels));
-	clks[IMX6UL_CLK_LDB_DI0_SEL]	  =3D imx_clk_mux("ldb_di0_sel",	base + 0x2c=
, 9,  3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
-	clks[IMX6UL_CLK_SPDIF_SEL]	  =3D imx_clk_mux("spdif_sel",	base + 0x30, 20=
, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
+		hws[IMX6ULL_CLK_ESAI_SEL]	  =3D imx_clk_hw_mux("esai_sel",	base + 0x20, =
19, 2, esai_sels, ARRAY_SIZE(esai_sels));
+	hws[IMX6UL_CLK_UART_SEL]	  =3D imx_clk_hw_mux("uart_sel",	base + 0x24, 6,=
  1, uart_sels, ARRAY_SIZE(uart_sels));
+	hws[IMX6UL_CLK_ENFC_SEL]	  =3D imx_clk_hw_mux("enfc_sel",	base + 0x2c, 15=
, 3, enfc_sels, ARRAY_SIZE(enfc_sels));
+	hws[IMX6UL_CLK_LDB_DI0_SEL]	  =3D imx_clk_hw_mux("ldb_di0_sel",	base + 0x=
2c, 9,  3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
+	hws[IMX6UL_CLK_SPDIF_SEL]	  =3D imx_clk_hw_mux("spdif_sel",	base + 0x30, =
20, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
 	if (clk_on_imx6ul()) {
-		clks[IMX6UL_CLK_SIM_PRE_SEL] 	  =3D imx_clk_mux("sim_pre_sel",	base + 0x=
34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
-		clks[IMX6UL_CLK_SIM_SEL]	  =3D imx_clk_mux("sim_sel", 	base + 0x34, 9, 3=
, sim_sels, ARRAY_SIZE(sim_sels));
+		hws[IMX6UL_CLK_SIM_PRE_SEL] 	  =3D imx_clk_hw_mux("sim_pre_sel",	base + =
0x34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
+		hws[IMX6UL_CLK_SIM_SEL]	  =3D imx_clk_hw_mux("sim_sel", 	base + 0x34, 9,=
 3, sim_sels, ARRAY_SIZE(sim_sels));
 	} else if (clk_on_imx6ull()) {
-		clks[IMX6ULL_CLK_EPDC_PRE_SEL]	  =3D imx_clk_mux("epdc_pre_sel",	base + =
0x34, 15, 3, epdc_pre_sels, ARRAY_SIZE(epdc_pre_sels));
-		clks[IMX6ULL_CLK_EPDC_SEL]	  =3D imx_clk_mux("epdc_sel",	base + 0x34, 9,=
 3, epdc_sels, ARRAY_SIZE(epdc_sels));
+		hws[IMX6ULL_CLK_EPDC_PRE_SEL]	  =3D imx_clk_hw_mux("epdc_pre_sel",	base =
+ 0x34, 15, 3, epdc_pre_sels, ARRAY_SIZE(epdc_pre_sels));
+		hws[IMX6ULL_CLK_EPDC_SEL]	  =3D imx_clk_hw_mux("epdc_sel",	base + 0x34, =
9, 3, epdc_sels, ARRAY_SIZE(epdc_sels));
 	}
-	clks[IMX6UL_CLK_ECSPI_SEL]	  =3D imx_clk_mux("ecspi_sel",	base + 0x38, 18=
, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
-	clks[IMX6UL_CLK_LCDIF_PRE_SEL]	  =3D imx_clk_mux_flags("lcdif_pre_sel", b=
ase + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels), CLK_SET_RATE=
_PARENT);
-	clks[IMX6UL_CLK_LCDIF_SEL]	  =3D imx_clk_mux("lcdif_sel",	base + 0x38, 9,=
 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
-
-	clks[IMX6UL_CLK_LDB_DI0_DIV_SEL]  =3D imx_clk_mux("ldb_di0", base + 0x20,=
 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
-	clks[IMX6UL_CLK_LDB_DI1_DIV_SEL]  =3D imx_clk_mux("ldb_di1", base + 0x20,=
 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
-
-	clks[IMX6UL_CLK_CKO1_SEL]	  =3D imx_clk_mux("cko1_sel", base + 0x60, 0,  =
4, cko1_sels, ARRAY_SIZE(cko1_sels));
-	clks[IMX6UL_CLK_CKO2_SEL]	  =3D imx_clk_mux("cko2_sel", base + 0x60, 16, =
5, cko2_sels, ARRAY_SIZE(cko2_sels));
-	clks[IMX6UL_CLK_CKO]		  =3D imx_clk_mux("cko", base + 0x60, 8, 1, cko_sel=
s, ARRAY_SIZE(cko_sels));
-
-	clks[IMX6UL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di0_div_3_=
5", "ldb_di0_sel", 2, 7);
-	clks[IMX6UL_CLK_LDB_DI0_DIV_7]	 =3D imx_clk_fixed_factor("ldb_di0_div_7",=
   "ldb_di0_sel", 1, 7);
-	clks[IMX6UL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di1_div_3_=
5", "qspi1_sel", 2, 7);
-	clks[IMX6UL_CLK_LDB_DI1_DIV_7]	 =3D imx_clk_fixed_factor("ldb_di1_div_7",=
   "qspi1_sel", 1, 7);
-
-	clks[IMX6UL_CLK_PERIPH]  =3D imx_clk_busy_mux("periph",  base + 0x14, 25,=
 1, base + 0x48, 5, periph_sels, ARRAY_SIZE(periph_sels));
-	clks[IMX6UL_CLK_PERIPH2] =3D imx_clk_busy_mux("periph2", base + 0x14, 26,=
 1, base + 0x48, 3, periph2_sels, ARRAY_SIZE(periph2_sels));
-
-	clks[IMX6UL_CLK_PERIPH_CLK2]	=3D imx_clk_divider("periph_clk2",   "periph=
_clk2_sel",	base + 0x14, 27, 3);
-	clks[IMX6UL_CLK_PERIPH2_CLK2]	=3D imx_clk_divider("periph2_clk2",  "perip=
h2_clk2_sel",	base + 0x14, 0,  3);
-	clks[IMX6UL_CLK_IPG]		=3D imx_clk_divider("ipg",	   "ahb",		base + 0x14, =
8,	 2);
-	clks[IMX6UL_CLK_LCDIF_PODF]	=3D imx_clk_divider("lcdif_podf",	   "lcdif_p=
red",	base + 0x18, 23, 3);
-	clks[IMX6UL_CLK_QSPI1_PDOF]	=3D imx_clk_divider("qspi1_podf",	   "qspi1_s=
el",		base + 0x1c, 26, 3);
-	clks[IMX6UL_CLK_EIM_SLOW_PODF]	=3D imx_clk_divider("eim_slow_podf", "eim_=
slow_sel",	base + 0x1c, 23, 3);
-	clks[IMX6UL_CLK_PERCLK]		=3D imx_clk_divider("perclk",	   "perclk_sel",	b=
ase + 0x1c, 0,  6);
-	clks[IMX6UL_CLK_CAN_PODF]	=3D imx_clk_divider("can_podf",	   "can_sel",		=
base + 0x20, 2,  6);
-	clks[IMX6UL_CLK_GPMI_PODF]	=3D imx_clk_divider("gpmi_podf",	   "gpmi_sel"=
,		base + 0x24, 22, 3);
-	clks[IMX6UL_CLK_BCH_PODF]	=3D imx_clk_divider("bch_podf",	   "bch_sel",		=
base + 0x24, 19, 3);
-	clks[IMX6UL_CLK_USDHC2_PODF]	=3D imx_clk_divider("usdhc2_podf",   "usdhc2=
_sel",	base + 0x24, 16, 3);
-	clks[IMX6UL_CLK_USDHC1_PODF]	=3D imx_clk_divider("usdhc1_podf",   "usdhc1=
_sel",	base + 0x24, 11, 3);
-	clks[IMX6UL_CLK_UART_PODF]	=3D imx_clk_divider("uart_podf",	   "uart_sel"=
,		base + 0x24, 0,  6);
-	clks[IMX6UL_CLK_SAI3_PRED]	=3D imx_clk_divider("sai3_pred",	   "sai3_sel"=
,		base + 0x28, 22, 3);
-	clks[IMX6UL_CLK_SAI3_PODF]	=3D imx_clk_divider("sai3_podf",	   "sai3_pred=
",		base + 0x28, 16, 6);
-	clks[IMX6UL_CLK_SAI1_PRED]	=3D imx_clk_divider("sai1_pred",	   "sai1_sel"=
,		base + 0x28, 6,	 3);
-	clks[IMX6UL_CLK_SAI1_PODF]	=3D imx_clk_divider("sai1_podf",	   "sai1_pred=
",		base + 0x28, 0,	 6);
+	hws[IMX6UL_CLK_ECSPI_SEL]	  =3D imx_clk_hw_mux("ecspi_sel",	base + 0x38, =
18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
+	hws[IMX6UL_CLK_LCDIF_PRE_SEL]	  =3D imx_clk_hw_mux_flags("lcdif_pre_sel",=
 base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels), CLK_SET_RA=
TE_PARENT);
+	hws[IMX6UL_CLK_LCDIF_SEL]	  =3D imx_clk_hw_mux("lcdif_sel",	base + 0x38, =
9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
+
+	hws[IMX6UL_CLK_LDB_DI0_DIV_SEL]  =3D imx_clk_hw_mux("ldb_di0", base + 0x2=
0, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
+	hws[IMX6UL_CLK_LDB_DI1_DIV_SEL]  =3D imx_clk_hw_mux("ldb_di1", base + 0x2=
0, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
+
+	hws[IMX6UL_CLK_CKO1_SEL]	  =3D imx_clk_hw_mux("cko1_sel", base + 0x60, 0,=
  4, cko1_sels, ARRAY_SIZE(cko1_sels));
+	hws[IMX6UL_CLK_CKO2_SEL]	  =3D imx_clk_hw_mux("cko2_sel", base + 0x60, 16=
, 5, cko2_sels, ARRAY_SIZE(cko2_sels));
+	hws[IMX6UL_CLK_CKO]		  =3D imx_clk_hw_mux("cko", base + 0x60, 8, 1, cko_s=
els, ARRAY_SIZE(cko_sels));
+
+	hws[IMX6UL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di0_div_=
3_5", "ldb_di0_sel", 2, 7);
+	hws[IMX6UL_CLK_LDB_DI0_DIV_7]	 =3D imx_clk_hw_fixed_factor("ldb_di0_div_7=
",   "ldb_di0_sel", 1, 7);
+	hws[IMX6UL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di1_div_=
3_5", "qspi1_sel", 2, 7);
+	hws[IMX6UL_CLK_LDB_DI1_DIV_7]	 =3D imx_clk_hw_fixed_factor("ldb_di1_div_7=
",   "qspi1_sel", 1, 7);
+
+	hws[IMX6UL_CLK_PERIPH]  =3D imx_clk_hw_busy_mux("periph",  base + 0x14, 2=
5, 1, base + 0x48, 5, periph_sels, ARRAY_SIZE(periph_sels));
+	hws[IMX6UL_CLK_PERIPH2] =3D imx_clk_hw_busy_mux("periph2", base + 0x14, 2=
6, 1, base + 0x48, 3, periph2_sels, ARRAY_SIZE(periph2_sels));
+
+	hws[IMX6UL_CLK_PERIPH_CLK2]	=3D imx_clk_hw_divider("periph_clk2",   "peri=
ph_clk2_sel",	base + 0x14, 27, 3);
+	hws[IMX6UL_CLK_PERIPH2_CLK2]	=3D imx_clk_hw_divider("periph2_clk2",  "per=
iph2_clk2_sel",	base + 0x14, 0,  3);
+	hws[IMX6UL_CLK_IPG]		=3D imx_clk_hw_divider("ipg",	   "ahb",		base + 0x14=
, 8,	 2);
+	hws[IMX6UL_CLK_LCDIF_PODF]	=3D imx_clk_hw_divider("lcdif_podf",	   "lcdif=
_pred",	base + 0x18, 23, 3);
+	hws[IMX6UL_CLK_QSPI1_PDOF]	=3D imx_clk_hw_divider("qspi1_podf",	   "qspi1=
_sel",		base + 0x1c, 26, 3);
+	hws[IMX6UL_CLK_EIM_SLOW_PODF]	=3D imx_clk_hw_divider("eim_slow_podf", "ei=
m_slow_sel",	base + 0x1c, 23, 3);
+	hws[IMX6UL_CLK_PERCLK]		=3D imx_clk_hw_divider("perclk",	   "perclk_sel",=
	base + 0x1c, 0,  6);
+	hws[IMX6UL_CLK_CAN_PODF]	=3D imx_clk_hw_divider("can_podf",	   "can_sel",=
		base + 0x20, 2,  6);
+	hws[IMX6UL_CLK_GPMI_PODF]	=3D imx_clk_hw_divider("gpmi_podf",	   "gpmi_se=
l",		base + 0x24, 22, 3);
+	hws[IMX6UL_CLK_BCH_PODF]	=3D imx_clk_hw_divider("bch_podf",	   "bch_sel",=
		base + 0x24, 19, 3);
+	hws[IMX6UL_CLK_USDHC2_PODF]	=3D imx_clk_hw_divider("usdhc2_podf",   "usdh=
c2_sel",	base + 0x24, 16, 3);
+	hws[IMX6UL_CLK_USDHC1_PODF]	=3D imx_clk_hw_divider("usdhc1_podf",   "usdh=
c1_sel",	base + 0x24, 11, 3);
+	hws[IMX6UL_CLK_UART_PODF]	=3D imx_clk_hw_divider("uart_podf",	   "uart_se=
l",		base + 0x24, 0,  6);
+	hws[IMX6UL_CLK_SAI3_PRED]	=3D imx_clk_hw_divider("sai3_pred",	   "sai3_se=
l",		base + 0x28, 22, 3);
+	hws[IMX6UL_CLK_SAI3_PODF]	=3D imx_clk_hw_divider("sai3_podf",	   "sai3_pr=
ed",		base + 0x28, 16, 6);
+	hws[IMX6UL_CLK_SAI1_PRED]	=3D imx_clk_hw_divider("sai1_pred",	   "sai1_se=
l",		base + 0x28, 6,	 3);
+	hws[IMX6UL_CLK_SAI1_PODF]	=3D imx_clk_hw_divider("sai1_podf",	   "sai1_pr=
ed",		base + 0x28, 0,	 6);
 	if (clk_on_imx6ull()) {
-		clks[IMX6ULL_CLK_ESAI_PRED]	=3D imx_clk_divider("esai_pred",     "esai_s=
el",		base + 0x28, 9,  3);
-		clks[IMX6ULL_CLK_ESAI_PODF]	=3D imx_clk_divider("esai_podf",     "esai_p=
red",		base + 0x28, 25, 3);
+		hws[IMX6ULL_CLK_ESAI_PRED]	=3D imx_clk_hw_divider("esai_pred",     "esai=
_sel",		base + 0x28, 9,  3);
+		hws[IMX6ULL_CLK_ESAI_PODF]	=3D imx_clk_hw_divider("esai_podf",     "esai=
_pred",		base + 0x28, 25, 3);
 	}
-	clks[IMX6UL_CLK_ENFC_PRED]	=3D imx_clk_divider("enfc_pred",	   "enfc_sel"=
,		base + 0x2c, 18, 3);
-	clks[IMX6UL_CLK_ENFC_PODF]	=3D imx_clk_divider("enfc_podf",	   "enfc_pred=
",		base + 0x2c, 21, 6);
-	clks[IMX6UL_CLK_SAI2_PRED]	=3D imx_clk_divider("sai2_pred",	   "sai2_sel"=
,		base + 0x2c, 6,	 3);
-	clks[IMX6UL_CLK_SAI2_PODF]	=3D imx_clk_divider("sai2_podf",	   "sai2_pred=
",		base + 0x2c, 0,  6);
-	clks[IMX6UL_CLK_SPDIF_PRED]	=3D imx_clk_divider("spdif_pred",	   "spdif_s=
el",		base + 0x30, 25, 3);
-	clks[IMX6UL_CLK_SPDIF_PODF]	=3D imx_clk_divider("spdif_podf",	   "spdif_p=
red",	base + 0x30, 22, 3);
+	hws[IMX6UL_CLK_ENFC_PRED]	=3D imx_clk_hw_divider("enfc_pred",	   "enfc_se=
l",		base + 0x2c, 18, 3);
+	hws[IMX6UL_CLK_ENFC_PODF]	=3D imx_clk_hw_divider("enfc_podf",	   "enfc_pr=
ed",		base + 0x2c, 21, 6);
+	hws[IMX6UL_CLK_SAI2_PRED]	=3D imx_clk_hw_divider("sai2_pred",	   "sai2_se=
l",		base + 0x2c, 6,	 3);
+	hws[IMX6UL_CLK_SAI2_PODF]	=3D imx_clk_hw_divider("sai2_podf",	   "sai2_pr=
ed",		base + 0x2c, 0,  6);
+	hws[IMX6UL_CLK_SPDIF_PRED]	=3D imx_clk_hw_divider("spdif_pred",	   "spdif=
_sel",		base + 0x30, 25, 3);
+	hws[IMX6UL_CLK_SPDIF_PODF]	=3D imx_clk_hw_divider("spdif_podf",	   "spdif=
_pred",	base + 0x30, 22, 3);
 	if (clk_on_imx6ul())
-		clks[IMX6UL_CLK_SIM_PODF]	=3D imx_clk_divider("sim_podf",	   "sim_pre_se=
l",	base + 0x34, 12, 3);
+		hws[IMX6UL_CLK_SIM_PODF]	=3D imx_clk_hw_divider("sim_podf",	   "sim_pre_=
sel",	base + 0x34, 12, 3);
 	else if (clk_on_imx6ull())
-		clks[IMX6ULL_CLK_EPDC_PODF]	=3D imx_clk_divider("epdc_podf",	   "epdc_pr=
e_sel",	base + 0x34, 12, 3);
-	clks[IMX6UL_CLK_ECSPI_PODF]	=3D imx_clk_divider("ecspi_podf",	   "ecspi_s=
el",		base + 0x38, 19, 6);
-	clks[IMX6UL_CLK_LCDIF_PRED]	=3D imx_clk_divider("lcdif_pred",	   "lcdif_p=
re_sel",	base + 0x38, 12, 3);
-	clks[IMX6UL_CLK_CSI_PODF]       =3D imx_clk_divider("csi_podf",      "csi=
_sel",           base + 0x3c, 11, 3);
+		hws[IMX6ULL_CLK_EPDC_PODF]	=3D imx_clk_hw_divider("epdc_podf",	   "epdc_=
pre_sel",	base + 0x34, 12, 3);
+	hws[IMX6UL_CLK_ECSPI_PODF]	=3D imx_clk_hw_divider("ecspi_podf",	   "ecspi=
_sel",		base + 0x38, 19, 6);
+	hws[IMX6UL_CLK_LCDIF_PRED]	=3D imx_clk_hw_divider("lcdif_pred",	   "lcdif=
_pre_sel",	base + 0x38, 12, 3);
+	hws[IMX6UL_CLK_CSI_PODF]       =3D imx_clk_hw_divider("csi_podf",      "c=
si_sel",           base + 0x3c, 11, 3);
=20
-	clks[IMX6UL_CLK_CKO1_PODF]	=3D imx_clk_divider("cko1_podf",     "cko1_sel=
",          base + 0x60, 4,  3);
-	clks[IMX6UL_CLK_CKO2_PODF]	=3D imx_clk_divider("cko2_podf",     "cko2_sel=
",          base + 0x60, 21, 3);
+	hws[IMX6UL_CLK_CKO1_PODF]	=3D imx_clk_hw_divider("cko1_podf",     "cko1_s=
el",          base + 0x60, 4,  3);
+	hws[IMX6UL_CLK_CKO2_PODF]	=3D imx_clk_hw_divider("cko2_podf",     "cko2_s=
el",          base + 0x60, 21, 3);
=20
-	clks[IMX6UL_CLK_ARM]		=3D imx_clk_busy_divider("arm",	    "pll1_sw",	base=
 +	0x10, 0,  3,  base + 0x48, 16);
-	clks[IMX6UL_CLK_MMDC_PODF]	=3D imx_clk_busy_divider("mmdc_podf", "periph2=
",	base +  0x14, 3,  3,  base + 0x48, 2);
-	clks[IMX6UL_CLK_AXI_PODF]	=3D imx_clk_busy_divider("axi_podf",  "axi_sel"=
,	base +  0x14, 16, 3,  base + 0x48, 0);
-	clks[IMX6UL_CLK_AHB]		=3D imx_clk_busy_divider("ahb",	    "periph",	base =
+  0x14, 10, 3,  base + 0x48, 1);
+	hws[IMX6UL_CLK_ARM]		=3D imx_clk_hw_busy_divider("arm",	    "pll1_sw",	ba=
se +	0x10, 0,  3,  base + 0x48, 16);
+	hws[IMX6UL_CLK_MMDC_PODF]	=3D imx_clk_hw_busy_divider("mmdc_podf", "perip=
h2",	base +  0x14, 3,  3,  base + 0x48, 2);
+	hws[IMX6UL_CLK_AXI_PODF]	=3D imx_clk_hw_busy_divider("axi_podf",  "axi_se=
l",	base +  0x14, 16, 3,  base + 0x48, 0);
+	hws[IMX6UL_CLK_AHB]		=3D imx_clk_hw_busy_divider("ahb",	    "periph",	bas=
e +  0x14, 10, 3,  base + 0x48, 1);
=20
 	/* CCGR0 */
-	clks[IMX6UL_CLK_AIPSTZ1]	=3D imx_clk_gate2_flags("aips_tz1", "ahb", base =
+ 0x68, 0, CLK_IS_CRITICAL);
-	clks[IMX6UL_CLK_AIPSTZ2]	=3D imx_clk_gate2_flags("aips_tz2", "ahb", base =
+ 0x68, 2, CLK_IS_CRITICAL);
-	clks[IMX6UL_CLK_APBHDMA]	=3D imx_clk_gate2("apbh_dma",	"bch_podf",	base +=
 0x68,	4);
-	clks[IMX6UL_CLK_ASRC_IPG]	=3D imx_clk_gate2_shared("asrc_ipg",	"ahb",	bas=
e + 0x68,	6, &share_count_asrc);
-	clks[IMX6UL_CLK_ASRC_MEM]	=3D imx_clk_gate2_shared("asrc_mem",	"ahb",	bas=
e + 0x68,	6, &share_count_asrc);
+	hws[IMX6UL_CLK_AIPSTZ1]	=3D imx_clk_hw_gate2_flags("aips_tz1", "ahb", bas=
e + 0x68, 0, CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_AIPSTZ2]	=3D imx_clk_hw_gate2_flags("aips_tz2", "ahb", bas=
e + 0x68, 2, CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_APBHDMA]	=3D imx_clk_hw_gate2("apbh_dma",	"bch_podf",	base=
 + 0x68,	4);
+	hws[IMX6UL_CLK_ASRC_IPG]	=3D imx_clk_hw_gate2_shared("asrc_ipg",	"ahb",	b=
ase + 0x68,	6, &share_count_asrc);
+	hws[IMX6UL_CLK_ASRC_MEM]	=3D imx_clk_hw_gate2_shared("asrc_mem",	"ahb",	b=
ase + 0x68,	6, &share_count_asrc);
 	if (clk_on_imx6ul()) {
-		clks[IMX6UL_CLK_CAAM_MEM]	=3D imx_clk_gate2("caam_mem",	"ahb",		base + 0=
x68,	8);
-		clks[IMX6UL_CLK_CAAM_ACLK]	=3D imx_clk_gate2("caam_aclk",	"ahb",		base +=
 0x68,	10);
-		clks[IMX6UL_CLK_CAAM_IPG]	=3D imx_clk_gate2("caam_ipg",	"ipg",		base + 0=
x68,	12);
+		hws[IMX6UL_CLK_CAAM_MEM]	=3D imx_clk_hw_gate2("caam_mem",	"ahb",		base +=
 0x68,	8);
+		hws[IMX6UL_CLK_CAAM_ACLK]	=3D imx_clk_hw_gate2("caam_aclk",	"ahb",		base=
 + 0x68,	10);
+		hws[IMX6UL_CLK_CAAM_IPG]	=3D imx_clk_hw_gate2("caam_ipg",	"ipg",		base +=
 0x68,	12);
 	} else if (clk_on_imx6ull()) {
-		clks[IMX6ULL_CLK_DCP_CLK]	=3D imx_clk_gate2("dcp",		"ahb",		base + 0x68,=
	10);
-		clks[IMX6UL_CLK_ENET]		=3D imx_clk_gate2("enet",		"ipg",		base + 0x68,	1=
2);
-		clks[IMX6UL_CLK_ENET_AHB]	=3D imx_clk_gate2("enet_ahb",	"ahb",		base + 0=
x68,	12);
+		hws[IMX6ULL_CLK_DCP_CLK]	=3D imx_clk_hw_gate2("dcp",		"ahb",		base + 0x6=
8,	10);
+		hws[IMX6UL_CLK_ENET]		=3D imx_clk_hw_gate2("enet",		"ipg",		base + 0x68,=
	12);
+		hws[IMX6UL_CLK_ENET_AHB]	=3D imx_clk_hw_gate2("enet_ahb",	"ahb",		base +=
 0x68,	12);
 	}
-	clks[IMX6UL_CLK_CAN1_IPG]	=3D imx_clk_gate2("can1_ipg",	"ipg",		base + 0x=
68,	14);
-	clks[IMX6UL_CLK_CAN1_SERIAL]	=3D imx_clk_gate2("can1_serial",	"can_podf",=
	base + 0x68,	16);
-	clks[IMX6UL_CLK_CAN2_IPG]	=3D imx_clk_gate2("can2_ipg",	"ipg",		base + 0x=
68,	18);
-	clks[IMX6UL_CLK_CAN2_SERIAL]	=3D imx_clk_gate2("can2_serial",	"can_podf",=
	base + 0x68,	20);
-	clks[IMX6UL_CLK_GPT2_BUS]	=3D imx_clk_gate2("gpt2_bus",	"perclk",	base + =
0x68,	24);
-	clks[IMX6UL_CLK_GPT2_SERIAL]	=3D imx_clk_gate2("gpt2_serial",	"perclk",	b=
ase + 0x68,	26);
-	clks[IMX6UL_CLK_UART2_IPG]	=3D imx_clk_gate2("uart2_ipg",	"ipg",		base + =
0x68,	28);
-	clks[IMX6UL_CLK_UART2_SERIAL]	=3D imx_clk_gate2("uart2_serial",	"uart_pod=
f",	base + 0x68,	28);
+	hws[IMX6UL_CLK_CAN1_IPG]	=3D imx_clk_hw_gate2("can1_ipg",	"ipg",		base + =
0x68,	14);
+	hws[IMX6UL_CLK_CAN1_SERIAL]	=3D imx_clk_hw_gate2("can1_serial",	"can_podf=
",	base + 0x68,	16);
+	hws[IMX6UL_CLK_CAN2_IPG]	=3D imx_clk_hw_gate2("can2_ipg",	"ipg",		base + =
0x68,	18);
+	hws[IMX6UL_CLK_CAN2_SERIAL]	=3D imx_clk_hw_gate2("can2_serial",	"can_podf=
",	base + 0x68,	20);
+	hws[IMX6UL_CLK_GPT2_BUS]	=3D imx_clk_hw_gate2("gpt2_bus",	"perclk",	base =
+ 0x68,	24);
+	hws[IMX6UL_CLK_GPT2_SERIAL]	=3D imx_clk_hw_gate2("gpt2_serial",	"perclk",=
	base + 0x68,	26);
+	hws[IMX6UL_CLK_UART2_IPG]	=3D imx_clk_hw_gate2("uart2_ipg",	"ipg",		base =
+ 0x68,	28);
+	hws[IMX6UL_CLK_UART2_SERIAL]	=3D imx_clk_hw_gate2("uart2_serial",	"uart_p=
odf",	base + 0x68,	28);
 	if (clk_on_imx6ull())
-		clks[IMX6UL_CLK_AIPSTZ3]	=3D imx_clk_gate2("aips_tz3",	"ahb",		 base + 0=
x80,	18);
-	clks[IMX6UL_CLK_GPIO2]		=3D imx_clk_gate2("gpio2",	"ipg",		base + 0x68,	3=
0);
+		hws[IMX6UL_CLK_AIPSTZ3]	=3D imx_clk_hw_gate2("aips_tz3",	"ahb",		 base +=
 0x80,	18);
+	hws[IMX6UL_CLK_GPIO2]		=3D imx_clk_hw_gate2("gpio2",	"ipg",		base + 0x68,=
	30);
=20
 	/* CCGR1 */
-	clks[IMX6UL_CLK_ECSPI1]		=3D imx_clk_gate2("ecspi1",	"ecspi_podf",	base +=
 0x6c,	0);
-	clks[IMX6UL_CLK_ECSPI2]		=3D imx_clk_gate2("ecspi2",	"ecspi_podf",	base +=
 0x6c,	2);
-	clks[IMX6UL_CLK_ECSPI3]		=3D imx_clk_gate2("ecspi3",	"ecspi_podf",	base +=
 0x6c,	4);
-	clks[IMX6UL_CLK_ECSPI4]		=3D imx_clk_gate2("ecspi4",	"ecspi_podf",	base +=
 0x6c,	6);
-	clks[IMX6UL_CLK_ADC2]		=3D imx_clk_gate2("adc2",		"ipg",		base + 0x6c,	8)=
;
-	clks[IMX6UL_CLK_UART3_IPG]	=3D imx_clk_gate2("uart3_ipg",	"ipg",		base + =
0x6c,	10);
-	clks[IMX6UL_CLK_UART3_SERIAL]	=3D imx_clk_gate2("uart3_serial",	"uart_pod=
f",	base + 0x6c,	10);
-	clks[IMX6UL_CLK_EPIT1]		=3D imx_clk_gate2("epit1",	"perclk",	base + 0x6c,=
	12);
-	clks[IMX6UL_CLK_EPIT2]		=3D imx_clk_gate2("epit2",	"perclk",	base + 0x6c,=
	14);
-	clks[IMX6UL_CLK_ADC1]		=3D imx_clk_gate2("adc1",		"ipg",		base + 0x6c,	16=
);
-	clks[IMX6UL_CLK_GPT1_BUS]	=3D imx_clk_gate2("gpt1_bus",	"perclk",	base + =
0x6c,	20);
-	clks[IMX6UL_CLK_GPT1_SERIAL]	=3D imx_clk_gate2("gpt1_serial",	"perclk",	b=
ase + 0x6c,	22);
-	clks[IMX6UL_CLK_UART4_IPG]	=3D imx_clk_gate2("uart4_ipg",	"ipg",		base + =
0x6c,	24);
-	clks[IMX6UL_CLK_UART4_SERIAL]	=3D imx_clk_gate2("uart4_serial",	"uart_pod=
f",	base + 0x6c,	24);
-	clks[IMX6UL_CLK_GPIO1]		=3D imx_clk_gate2("gpio1",	"ipg",		base + 0x6c,	2=
6);
-	clks[IMX6UL_CLK_GPIO5]		=3D imx_clk_gate2("gpio5",	"ipg",		base + 0x6c,	3=
0);
+	hws[IMX6UL_CLK_ECSPI1]		=3D imx_clk_hw_gate2("ecspi1",	"ecspi_podf",	base=
 + 0x6c,	0);
+	hws[IMX6UL_CLK_ECSPI2]		=3D imx_clk_hw_gate2("ecspi2",	"ecspi_podf",	base=
 + 0x6c,	2);
+	hws[IMX6UL_CLK_ECSPI3]		=3D imx_clk_hw_gate2("ecspi3",	"ecspi_podf",	base=
 + 0x6c,	4);
+	hws[IMX6UL_CLK_ECSPI4]		=3D imx_clk_hw_gate2("ecspi4",	"ecspi_podf",	base=
 + 0x6c,	6);
+	hws[IMX6UL_CLK_ADC2]		=3D imx_clk_hw_gate2("adc2",		"ipg",		base + 0x6c,	=
8);
+	hws[IMX6UL_CLK_UART3_IPG]	=3D imx_clk_hw_gate2("uart3_ipg",	"ipg",		base =
+ 0x6c,	10);
+	hws[IMX6UL_CLK_UART3_SERIAL]	=3D imx_clk_hw_gate2("uart3_serial",	"uart_p=
odf",	base + 0x6c,	10);
+	hws[IMX6UL_CLK_EPIT1]		=3D imx_clk_hw_gate2("epit1",	"perclk",	base + 0x6=
c,	12);
+	hws[IMX6UL_CLK_EPIT2]		=3D imx_clk_hw_gate2("epit2",	"perclk",	base + 0x6=
c,	14);
+	hws[IMX6UL_CLK_ADC1]		=3D imx_clk_hw_gate2("adc1",		"ipg",		base + 0x6c,	=
16);
+	hws[IMX6UL_CLK_GPT1_BUS]	=3D imx_clk_hw_gate2("gpt1_bus",	"perclk",	base =
+ 0x6c,	20);
+	hws[IMX6UL_CLK_GPT1_SERIAL]	=3D imx_clk_hw_gate2("gpt1_serial",	"perclk",=
	base + 0x6c,	22);
+	hws[IMX6UL_CLK_UART4_IPG]	=3D imx_clk_hw_gate2("uart4_ipg",	"ipg",		base =
+ 0x6c,	24);
+	hws[IMX6UL_CLK_UART4_SERIAL]	=3D imx_clk_hw_gate2("uart4_serial",	"uart_p=
odf",	base + 0x6c,	24);
+	hws[IMX6UL_CLK_GPIO1]		=3D imx_clk_hw_gate2("gpio1",	"ipg",		base + 0x6c,=
	26);
+	hws[IMX6UL_CLK_GPIO5]		=3D imx_clk_hw_gate2("gpio5",	"ipg",		base + 0x6c,=
	30);
=20
 	/* CCGR2 */
 	if (clk_on_imx6ull()) {
-		clks[IMX6ULL_CLK_ESAI_EXTAL]	=3D imx_clk_gate2_shared("esai_extal",	"esa=
i_podf",	base + 0x70,	0, &share_count_esai);
-		clks[IMX6ULL_CLK_ESAI_IPG]	=3D imx_clk_gate2_shared("esai_ipg",	"ahb",		=
base + 0x70,	0, &share_count_esai);
-		clks[IMX6ULL_CLK_ESAI_MEM]	=3D imx_clk_gate2_shared("esai_mem",	"ahb",		=
base + 0x70,	0, &share_count_esai);
+		hws[IMX6ULL_CLK_ESAI_EXTAL]	=3D imx_clk_hw_gate2_shared("esai_extal",	"e=
sai_podf",	base + 0x70,	0, &share_count_esai);
+		hws[IMX6ULL_CLK_ESAI_IPG]	=3D imx_clk_hw_gate2_shared("esai_ipg",	"ahb",=
		base + 0x70,	0, &share_count_esai);
+		hws[IMX6ULL_CLK_ESAI_MEM]	=3D imx_clk_hw_gate2_shared("esai_mem",	"ahb",=
		base + 0x70,	0, &share_count_esai);
 	}
-	clks[IMX6UL_CLK_CSI]		=3D imx_clk_gate2("csi",		"csi_podf",		base + 0x70,=
	2);
-	clks[IMX6UL_CLK_I2C1]		=3D imx_clk_gate2("i2c1",		"perclk",	base + 0x70,	=
6);
-	clks[IMX6UL_CLK_I2C2]		=3D imx_clk_gate2("i2c2",		"perclk",	base + 0x70,	=
8);
-	clks[IMX6UL_CLK_I2C3]		=3D imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	=
10);
-	clks[IMX6UL_CLK_OCOTP]		=3D imx_clk_gate2("ocotp",	"ipg",		base + 0x70,	1=
2);
-	clks[IMX6UL_CLK_IOMUXC]		=3D imx_clk_gate2("iomuxc",	"lcdif_podf",	base +=
 0x70,	14);
-	clks[IMX6UL_CLK_GPIO3]		=3D imx_clk_gate2("gpio3",	"ipg",		base + 0x70,	2=
6);
-	clks[IMX6UL_CLK_LCDIF_APB]	=3D imx_clk_gate2("lcdif_apb",	"axi",		base + =
0x70,	28);
-	clks[IMX6UL_CLK_PXP]		=3D imx_clk_gate2("pxp",		"axi",		base + 0x70,	30);
+	hws[IMX6UL_CLK_CSI]		=3D imx_clk_hw_gate2("csi",		"csi_podf",		base + 0x7=
0,	2);
+	hws[IMX6UL_CLK_I2C1]		=3D imx_clk_hw_gate2("i2c1",		"perclk",	base + 0x70=
,	6);
+	hws[IMX6UL_CLK_I2C2]		=3D imx_clk_hw_gate2("i2c2",		"perclk",	base + 0x70=
,	8);
+	hws[IMX6UL_CLK_I2C3]		=3D imx_clk_hw_gate2("i2c3",		"perclk",	base + 0x70=
,	10);
+	hws[IMX6UL_CLK_OCOTP]		=3D imx_clk_hw_gate2("ocotp",	"ipg",		base + 0x70,=
	12);
+	hws[IMX6UL_CLK_IOMUXC]		=3D imx_clk_hw_gate2("iomuxc",	"lcdif_podf",	base=
 + 0x70,	14);
+	hws[IMX6UL_CLK_GPIO3]		=3D imx_clk_hw_gate2("gpio3",	"ipg",		base + 0x70,=
	26);
+	hws[IMX6UL_CLK_LCDIF_APB]	=3D imx_clk_hw_gate2("lcdif_apb",	"axi",		base =
+ 0x70,	28);
+	hws[IMX6UL_CLK_PXP]		=3D imx_clk_hw_gate2("pxp",		"axi",		base + 0x70,	30=
);
=20
 	/* CCGR3 */
-	clks[IMX6UL_CLK_UART5_IPG]	=3D imx_clk_gate2("uart5_ipg",	"ipg",		base + =
0x74,	2);
-	clks[IMX6UL_CLK_UART5_SERIAL]	=3D imx_clk_gate2("uart5_serial",	"uart_pod=
f",	base + 0x74,	2);
+	hws[IMX6UL_CLK_UART5_IPG]	=3D imx_clk_hw_gate2("uart5_ipg",	"ipg",		base =
+ 0x74,	2);
+	hws[IMX6UL_CLK_UART5_SERIAL]	=3D imx_clk_hw_gate2("uart5_serial",	"uart_p=
odf",	base + 0x74,	2);
 	if (clk_on_imx6ul()) {
-		clks[IMX6UL_CLK_ENET]		=3D imx_clk_gate2("enet",		"ipg",		base + 0x74,	4=
);
-		clks[IMX6UL_CLK_ENET_AHB]	=3D imx_clk_gate2("enet_ahb",	"ahb",		base + 0=
x74,	4);
+		hws[IMX6UL_CLK_ENET]		=3D imx_clk_hw_gate2("enet",		"ipg",		base + 0x74,=
	4);
+		hws[IMX6UL_CLK_ENET_AHB]	=3D imx_clk_hw_gate2("enet_ahb",	"ahb",		base +=
 0x74,	4);
 	} else if (clk_on_imx6ull()) {
-		clks[IMX6ULL_CLK_EPDC_ACLK]	=3D imx_clk_gate2("epdc_aclk",	"axi",		base =
+ 0x74,	4);
-		clks[IMX6ULL_CLK_EPDC_PIX]	=3D imx_clk_gate2("epdc_pix",	"epdc_podf",	ba=
se + 0x74,	4);
+		hws[IMX6ULL_CLK_EPDC_ACLK]	=3D imx_clk_hw_gate2("epdc_aclk",	"axi",		bas=
e + 0x74,	4);
+		hws[IMX6ULL_CLK_EPDC_PIX]	=3D imx_clk_hw_gate2("epdc_pix",	"epdc_podf",	=
base + 0x74,	4);
 	}
-	clks[IMX6UL_CLK_UART6_IPG]	=3D imx_clk_gate2("uart6_ipg",	"ipg",		base + =
0x74,	6);
-	clks[IMX6UL_CLK_UART6_SERIAL]	=3D imx_clk_gate2("uart6_serial",	"uart_pod=
f",	base + 0x74,	6);
-	clks[IMX6UL_CLK_LCDIF_PIX]	=3D imx_clk_gate2("lcdif_pix",	"lcdif_podf",	b=
ase + 0x74,	10);
-	clks[IMX6UL_CLK_GPIO4]		=3D imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	1=
2);
-	clks[IMX6UL_CLK_QSPI]		=3D imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x=
74,	14);
-	clks[IMX6UL_CLK_WDOG1]		=3D imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	1=
6);
-	clks[IMX6UL_CLK_MMDC_P0_FAST]	=3D imx_clk_gate_flags("mmdc_p0_fast", "mmd=
c_podf", base + 0x74,	20, CLK_IS_CRITICAL);
-	clks[IMX6UL_CLK_MMDC_P0_IPG]	=3D imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg"=
,		base + 0x74,	24, CLK_IS_CRITICAL);
-	clks[IMX6UL_CLK_MMDC_P1_IPG]	=3D imx_clk_gate2("mmdc_p1_ipg",	"ipg",		bas=
e + 0x74,	26);
-	clks[IMX6UL_CLK_AXI]		=3D imx_clk_gate_flags("axi",	"axi_podf",	base + 0x=
74,	28, CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_UART6_IPG]	=3D imx_clk_hw_gate2("uart6_ipg",	"ipg",		base =
+ 0x74,	6);
+	hws[IMX6UL_CLK_UART6_SERIAL]	=3D imx_clk_hw_gate2("uart6_serial",	"uart_p=
odf",	base + 0x74,	6);
+	hws[IMX6UL_CLK_LCDIF_PIX]	=3D imx_clk_hw_gate2("lcdif_pix",	"lcdif_podf",=
	base + 0x74,	10);
+	hws[IMX6UL_CLK_GPIO4]		=3D imx_clk_hw_gate2("gpio4",	"ipg",		base + 0x74,=
	12);
+	hws[IMX6UL_CLK_QSPI]		=3D imx_clk_hw_gate2("qspi1",	"qspi1_podf",	base + =
0x74,	14);
+	hws[IMX6UL_CLK_WDOG1]		=3D imx_clk_hw_gate2("wdog1",	"ipg",		base + 0x74,=
	16);
+	hws[IMX6UL_CLK_MMDC_P0_FAST]	=3D imx_clk_hw_gate_flags("mmdc_p0_fast", "m=
mdc_podf", base + 0x74,	20, CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_MMDC_P0_IPG]	=3D imx_clk_hw_gate2_flags("mmdc_p0_ipg",	"ip=
g",		base + 0x74,	24, CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_MMDC_P1_IPG]	=3D imx_clk_hw_gate2("mmdc_p1_ipg",	"ipg",		b=
ase + 0x74,	26);
+	hws[IMX6UL_CLK_AXI]		=3D imx_clk_hw_gate_flags("axi",	"axi_podf",	base + =
0x74,	28, CLK_IS_CRITICAL);
=20
 	/* CCGR4 */
-	clks[IMX6UL_CLK_PER_BCH]	=3D imx_clk_gate2("per_bch",	"bch_podf",	base + =
0x78,	12);
-	clks[IMX6UL_CLK_PWM1]		=3D imx_clk_gate2("pwm1",		"perclk",	base + 0x78,	=
16);
-	clks[IMX6UL_CLK_PWM2]		=3D imx_clk_gate2("pwm2",		"perclk",	base + 0x78,	=
18);
-	clks[IMX6UL_CLK_PWM3]		=3D imx_clk_gate2("pwm3",		"perclk",	base + 0x78,	=
20);
-	clks[IMX6UL_CLK_PWM4]		=3D imx_clk_gate2("pwm4",		"perclk",	base + 0x78,	=
22);
-	clks[IMX6UL_CLK_GPMI_BCH_APB]	=3D imx_clk_gate2("gpmi_bch_apb",	"bch_podf=
",	base + 0x78,	24);
-	clks[IMX6UL_CLK_GPMI_BCH]	=3D imx_clk_gate2("gpmi_bch",	"gpmi_podf",	base=
 + 0x78,	26);
-	clks[IMX6UL_CLK_GPMI_IO]	=3D imx_clk_gate2("gpmi_io",	"enfc_podf",	base +=
 0x78,	28);
-	clks[IMX6UL_CLK_GPMI_APB]	=3D imx_clk_gate2("gpmi_apb",	"bch_podf",	base =
+ 0x78,	30);
+	hws[IMX6UL_CLK_PER_BCH]	=3D imx_clk_hw_gate2("per_bch",	"bch_podf",	base =
+ 0x78,	12);
+	hws[IMX6UL_CLK_PWM1]		=3D imx_clk_hw_gate2("pwm1",		"perclk",	base + 0x78=
,	16);
+	hws[IMX6UL_CLK_PWM2]		=3D imx_clk_hw_gate2("pwm2",		"perclk",	base + 0x78=
,	18);
+	hws[IMX6UL_CLK_PWM3]		=3D imx_clk_hw_gate2("pwm3",		"perclk",	base + 0x78=
,	20);
+	hws[IMX6UL_CLK_PWM4]		=3D imx_clk_hw_gate2("pwm4",		"perclk",	base + 0x78=
,	22);
+	hws[IMX6UL_CLK_GPMI_BCH_APB]	=3D imx_clk_hw_gate2("gpmi_bch_apb",	"bch_po=
df",	base + 0x78,	24);
+	hws[IMX6UL_CLK_GPMI_BCH]	=3D imx_clk_hw_gate2("gpmi_bch",	"gpmi_podf",	ba=
se + 0x78,	26);
+	hws[IMX6UL_CLK_GPMI_IO]	=3D imx_clk_hw_gate2("gpmi_io",	"enfc_podf",	base=
 + 0x78,	28);
+	hws[IMX6UL_CLK_GPMI_APB]	=3D imx_clk_hw_gate2("gpmi_apb",	"bch_podf",	bas=
e + 0x78,	30);
=20
 	/* CCGR5 */
-	clks[IMX6UL_CLK_ROM]		=3D imx_clk_gate2_flags("rom",	"ahb",		base + 0x7c,=
	0,	CLK_IS_CRITICAL);
-	clks[IMX6UL_CLK_SDMA]		=3D imx_clk_gate2("sdma",		"ahb",		base + 0x7c,	6)=
;
-	clks[IMX6UL_CLK_KPP]		=3D imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	8);
-	clks[IMX6UL_CLK_WDOG2]		=3D imx_clk_gate2("wdog2",	"ipg",		base + 0x7c,	1=
0);
-	clks[IMX6UL_CLK_SPBA]		=3D imx_clk_gate2("spba",		"ipg",		base + 0x7c,	12=
);
-	clks[IMX6UL_CLK_SPDIF]		=3D imx_clk_gate2_shared("spdif",		"spdif_podf",	=
base + 0x7c,	14, &share_count_audio);
-	clks[IMX6UL_CLK_SPDIF_GCLK]	=3D imx_clk_gate2_shared("spdif_gclk",	"ipg",=
		base + 0x7c,	14, &share_count_audio);
-	clks[IMX6UL_CLK_SAI3]		=3D imx_clk_gate2_shared("sai3",		"sai3_podf",	bas=
e + 0x7c,	22, &share_count_sai3);
-	clks[IMX6UL_CLK_SAI3_IPG]	=3D imx_clk_gate2_shared("sai3_ipg",	"ipg",		ba=
se + 0x7c,	22, &share_count_sai3);
-	clks[IMX6UL_CLK_UART1_IPG]	=3D imx_clk_gate2("uart1_ipg",	"ipg",		base + =
0x7c,	24);
-	clks[IMX6UL_CLK_UART1_SERIAL]	=3D imx_clk_gate2("uart1_serial",	"uart_pod=
f",	base + 0x7c,	24);
-	clks[IMX6UL_CLK_UART7_IPG]	=3D imx_clk_gate2("uart7_ipg",	"ipg",		base + =
0x7c,	26);
-	clks[IMX6UL_CLK_UART7_SERIAL]	=3D imx_clk_gate2("uart7_serial",	"uart_pod=
f",	base + 0x7c,	26);
-	clks[IMX6UL_CLK_SAI1]		=3D imx_clk_gate2_shared("sai1",		"sai1_podf",	bas=
e + 0x7c,	28, &share_count_sai1);
-	clks[IMX6UL_CLK_SAI1_IPG]	=3D imx_clk_gate2_shared("sai1_ipg",	"ipg",		ba=
se + 0x7c,	28, &share_count_sai1);
-	clks[IMX6UL_CLK_SAI2]		=3D imx_clk_gate2_shared("sai2",		"sai2_podf",	bas=
e + 0x7c,	30, &share_count_sai2);
-	clks[IMX6UL_CLK_SAI2_IPG]	=3D imx_clk_gate2_shared("sai2_ipg",	"ipg",		ba=
se + 0x7c,	30, &share_count_sai2);
+	hws[IMX6UL_CLK_ROM]		=3D imx_clk_hw_gate2_flags("rom",	"ahb",		base + 0x7=
c,	0,	CLK_IS_CRITICAL);
+	hws[IMX6UL_CLK_SDMA]		=3D imx_clk_hw_gate2("sdma",		"ahb",		base + 0x7c,	=
6);
+	hws[IMX6UL_CLK_KPP]		=3D imx_clk_hw_gate2("kpp",		"ipg",		base + 0x7c,	8)=
;
+	hws[IMX6UL_CLK_WDOG2]		=3D imx_clk_hw_gate2("wdog2",	"ipg",		base + 0x7c,=
	10);
+	hws[IMX6UL_CLK_SPBA]		=3D imx_clk_hw_gate2("spba",		"ipg",		base + 0x7c,	=
12);
+	hws[IMX6UL_CLK_SPDIF]		=3D imx_clk_hw_gate2_shared("spdif",		"spdif_podf"=
,	base + 0x7c,	14, &share_count_audio);
+	hws[IMX6UL_CLK_SPDIF_GCLK]	=3D imx_clk_hw_gate2_shared("spdif_gclk",	"ipg=
",		base + 0x7c,	14, &share_count_audio);
+	hws[IMX6UL_CLK_SAI3]		=3D imx_clk_hw_gate2_shared("sai3",		"sai3_podf",	b=
ase + 0x7c,	22, &share_count_sai3);
+	hws[IMX6UL_CLK_SAI3_IPG]	=3D imx_clk_hw_gate2_shared("sai3_ipg",	"ipg",		=
base + 0x7c,	22, &share_count_sai3);
+	hws[IMX6UL_CLK_UART1_IPG]	=3D imx_clk_hw_gate2("uart1_ipg",	"ipg",		base =
+ 0x7c,	24);
+	hws[IMX6UL_CLK_UART1_SERIAL]	=3D imx_clk_hw_gate2("uart1_serial",	"uart_p=
odf",	base + 0x7c,	24);
+	hws[IMX6UL_CLK_UART7_IPG]	=3D imx_clk_hw_gate2("uart7_ipg",	"ipg",		base =
+ 0x7c,	26);
+	hws[IMX6UL_CLK_UART7_SERIAL]	=3D imx_clk_hw_gate2("uart7_serial",	"uart_p=
odf",	base + 0x7c,	26);
+	hws[IMX6UL_CLK_SAI1]		=3D imx_clk_hw_gate2_shared("sai1",		"sai1_podf",	b=
ase + 0x7c,	28, &share_count_sai1);
+	hws[IMX6UL_CLK_SAI1_IPG]	=3D imx_clk_hw_gate2_shared("sai1_ipg",	"ipg",		=
base + 0x7c,	28, &share_count_sai1);
+	hws[IMX6UL_CLK_SAI2]		=3D imx_clk_hw_gate2_shared("sai2",		"sai2_podf",	b=
ase + 0x7c,	30, &share_count_sai2);
+	hws[IMX6UL_CLK_SAI2_IPG]	=3D imx_clk_hw_gate2_shared("sai2_ipg",	"ipg",		=
base + 0x7c,	30, &share_count_sai2);
=20
 	/* CCGR6 */
-	clks[IMX6UL_CLK_USBOH3]		=3D imx_clk_gate2("usboh3",	"ipg",		 base + 0x80=
,	0);
-	clks[IMX6UL_CLK_USDHC1]		=3D imx_clk_gate2("usdhc1",	"usdhc1_podf",	 base=
 + 0x80,	2);
-	clks[IMX6UL_CLK_USDHC2]		=3D imx_clk_gate2("usdhc2",	"usdhc2_podf",	 base=
 + 0x80,	4);
+	hws[IMX6UL_CLK_USBOH3]		=3D imx_clk_hw_gate2("usboh3",	"ipg",		 base + 0x=
80,	0);
+	hws[IMX6UL_CLK_USDHC1]		=3D imx_clk_hw_gate2("usdhc1",	"usdhc1_podf",	 ba=
se + 0x80,	2);
+	hws[IMX6UL_CLK_USDHC2]		=3D imx_clk_hw_gate2("usdhc2",	"usdhc2_podf",	 ba=
se + 0x80,	4);
 	if (clk_on_imx6ul()) {
-		clks[IMX6UL_CLK_SIM1]		=3D imx_clk_gate2("sim1",		"sim_sel",	 base + 0x8=
0,	6);
-		clks[IMX6UL_CLK_SIM2]		=3D imx_clk_gate2("sim2",		"sim_sel",	 base + 0x8=
0,	8);
+		hws[IMX6UL_CLK_SIM1]		=3D imx_clk_hw_gate2("sim1",		"sim_sel",	 base + 0=
x80,	6);
+		hws[IMX6UL_CLK_SIM2]		=3D imx_clk_hw_gate2("sim2",		"sim_sel",	 base + 0=
x80,	8);
 	}
-	clks[IMX6UL_CLK_EIM]		=3D imx_clk_gate2("eim",		"eim_slow_podf", base + 0=
x80,	10);
-	clks[IMX6UL_CLK_PWM8]		=3D imx_clk_gate2("pwm8",		"perclk",	 base + 0x80,=
	16);
-	clks[IMX6UL_CLK_UART8_IPG]	=3D imx_clk_gate2("uart8_ipg",	"ipg",		 base +=
 0x80,	14);
-	clks[IMX6UL_CLK_UART8_SERIAL]	=3D imx_clk_gate2("uart8_serial", "uart_pod=
f",	 base + 0x80,	14);
-	clks[IMX6UL_CLK_WDOG3]		=3D imx_clk_gate2("wdog3",	"ipg",		 base + 0x80,	=
20);
-	clks[IMX6UL_CLK_I2C4]		=3D imx_clk_gate2("i2c4",		"perclk",	 base + 0x80,=
	24);
-	clks[IMX6UL_CLK_PWM5]		=3D imx_clk_gate2("pwm5",		"perclk",	 base + 0x80,=
	26);
-	clks[IMX6UL_CLK_PWM6]		=3D imx_clk_gate2("pwm6",		"perclk",	 base +	0x80,=
	28);
-	clks[IMX6UL_CLK_PWM7]		=3D imx_clk_gate2("pwm7",		"perclk",	 base + 0x80,=
	30);
+	hws[IMX6UL_CLK_EIM]		=3D imx_clk_hw_gate2("eim",		"eim_slow_podf", base +=
 0x80,	10);
+	hws[IMX6UL_CLK_PWM8]		=3D imx_clk_hw_gate2("pwm8",		"perclk",	 base + 0x8=
0,	16);
+	hws[IMX6UL_CLK_UART8_IPG]	=3D imx_clk_hw_gate2("uart8_ipg",	"ipg",		 base=
 + 0x80,	14);
+	hws[IMX6UL_CLK_UART8_SERIAL]	=3D imx_clk_hw_gate2("uart8_serial", "uart_p=
odf",	 base + 0x80,	14);
+	hws[IMX6UL_CLK_WDOG3]		=3D imx_clk_hw_gate2("wdog3",	"ipg",		 base + 0x80=
,	20);
+	hws[IMX6UL_CLK_I2C4]		=3D imx_clk_hw_gate2("i2c4",		"perclk",	 base + 0x8=
0,	24);
+	hws[IMX6UL_CLK_PWM5]		=3D imx_clk_hw_gate2("pwm5",		"perclk",	 base + 0x8=
0,	26);
+	hws[IMX6UL_CLK_PWM6]		=3D imx_clk_hw_gate2("pwm6",		"perclk",	 base +	0x8=
0,	28);
+	hws[IMX6UL_CLK_PWM7]		=3D imx_clk_hw_gate2("pwm7",		"perclk",	 base + 0x8=
0,	30);
=20
 	/* CCOSR */
-	clks[IMX6UL_CLK_CKO1]		=3D imx_clk_gate("cko1",		"cko1_podf",	 base + 0x6=
0,	7);
-	clks[IMX6UL_CLK_CKO2]		=3D imx_clk_gate("cko2",		"cko2_podf",	 base + 0x6=
0,	24);
+	hws[IMX6UL_CLK_CKO1]		=3D imx_clk_hw_gate("cko1",		"cko1_podf",	 base + 0=
x60,	7);
+	hws[IMX6UL_CLK_CKO2]		=3D imx_clk_hw_gate("cko2",		"cko2_podf",	 base + 0=
x60,	24);
=20
 	/* mask handshake of mmdc */
 	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
=20
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
+	imx_check_clk_hws(hws, IMX6UL_CLK_END);
=20
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
=20
 	/*
 	 * Lower the AHB clock rate before changing the parent clock source,
@@ -479,39 +485,39 @@ static void __init imx6ul_clocks_init(struct device_n=
ode *ccm_node)
 	 * AXI clock rate, so we need to lower AHB rate first to make sure at
 	 * any time, AHB rate is <=3D 133MHz.
 	 */
-	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
+	clk_set_rate(hws[IMX6UL_CLK_AHB]->clk, 99000000);
=20
 	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
-	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL], clks[IMX6UL_CLK_OSC]);
-	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_CLK2]);
-	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE], clks[IMX6UL_CLK_PLL2_BUS]);
-	clk_set_parent(clks[IMX6UL_CLK_PERIPH], clks[IMX6UL_CLK_PERIPH_PRE]);
+	clk_set_parent(hws[IMX6UL_CLK_PERIPH_CLK2_SEL]->clk, hws[IMX6UL_CLK_OSC]-=
>clk);
+	clk_set_parent(hws[IMX6UL_CLK_PERIPH]->clk, hws[IMX6UL_CLK_PERIPH_CLK2]->=
clk);
+	clk_set_parent(hws[IMX6UL_CLK_PERIPH_PRE]->clk, hws[IMX6UL_CLK_PLL2_BUS]-=
>clk);
+	clk_set_parent(hws[IMX6UL_CLK_PERIPH]->clk, hws[IMX6UL_CLK_PERIPH_PRE]->c=
lk);
=20
 	/* Make sure AHB rate is 132MHz  */
-	clk_set_rate(clks[IMX6UL_CLK_AHB], 132000000);
+	clk_set_rate(hws[IMX6UL_CLK_AHB]->clk, 132000000);
=20
 	/* set perclk to from OSC */
-	clk_set_parent(clks[IMX6UL_CLK_PERCLK_SEL], clks[IMX6UL_CLK_OSC]);
+	clk_set_parent(hws[IMX6UL_CLK_PERCLK_SEL]->clk, hws[IMX6UL_CLK_OSC]->clk)=
;
=20
-	clk_set_rate(clks[IMX6UL_CLK_ENET_REF], 50000000);
-	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
-	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
+	clk_set_rate(hws[IMX6UL_CLK_ENET_REF]->clk, 50000000);
+	clk_set_rate(hws[IMX6UL_CLK_ENET2_REF]->clk, 50000000);
+	clk_set_rate(hws[IMX6UL_CLK_CSI]->clk, 24000000);
=20
 	if (clk_on_imx6ull())
-		clk_prepare_enable(clks[IMX6UL_CLK_AIPSTZ3]);
+		clk_prepare_enable(hws[IMX6UL_CLK_AIPSTZ3]->clk);
=20
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clks[IMX6UL_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clks[IMX6UL_CLK_USBPHY2_GATE]);
+		clk_prepare_enable(hws[IMX6UL_CLK_USBPHY1_GATE]->clk);
+		clk_prepare_enable(hws[IMX6UL_CLK_USBPHY2_GATE]->clk);
 	}
=20
-	clk_set_parent(clks[IMX6UL_CLK_CAN_SEL], clks[IMX6UL_CLK_PLL3_60M]);
+	clk_set_parent(hws[IMX6UL_CLK_CAN_SEL]->clk, hws[IMX6UL_CLK_PLL3_60M]->cl=
k);
 	if (clk_on_imx6ul())
-		clk_set_parent(clks[IMX6UL_CLK_SIM_PRE_SEL], clks[IMX6UL_CLK_PLL3_USB_OT=
G]);
+		clk_set_parent(hws[IMX6UL_CLK_SIM_PRE_SEL]->clk, hws[IMX6UL_CLK_PLL3_USB=
_OTG]->clk);
 	else if (clk_on_imx6ull())
-		clk_set_parent(clks[IMX6ULL_CLK_EPDC_PRE_SEL], clks[IMX6UL_CLK_PLL3_PFD2=
]);
+		clk_set_parent(hws[IMX6ULL_CLK_EPDC_PRE_SEL]->clk, hws[IMX6UL_CLK_PLL3_P=
FD2]->clk);
=20
-	clk_set_parent(clks[IMX6UL_CLK_ENFC_SEL], clks[IMX6UL_CLK_PLL2_PFD2]);
+	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->=
clk);
 }
=20
 CLK_OF_DECLARE(imx6ul, "fsl,imx6ul-ccm", imx6ul_clocks_init);
--=20
2.7.4

