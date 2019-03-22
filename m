Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33626C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83E620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nm+HBOpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCVPhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:50 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:56385
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfCVPhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaclOJmfO4S1FYEs6NDMZvn6IDdVdHG6pngfVM+jtqk=;
 b=Nm+HBOpC/CVkozEXl1An4yRmgfnfrGcWrFLJYKD/aHao8KxlAkJbpRlgiLd7AG66O8RSq/Ujcw/NjgDzCfgihII56vI5DdrnGiPNqTfznUq6kRL0blW4mdXzuXwBpPC538uoWuojJfqf9yBls9swzqNoL0PU/H5m5Mk57FTjPcM=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:14 +0000
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
Subject: [RFC 14/19] clk: imx6q: Switch to clk_hw based API
Thread-Topic: [RFC 14/19] clk: imx6q: Switch to clk_hw based API
Thread-Index: AQHU4MUfoY9vd/5K4Ey/Pu+63BNqBg==
Date:   Fri, 22 Mar 2019 15:37:14 +0000
Message-ID: <1553269010-15591-15-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: c48e6d84-55fc-41e2-8529-08d6aedc41ab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB563693770C7CAD6FFA6F5EF5F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(53946003)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(30864003)(6486002)(50226002)(14444005)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005)(32563001)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qu0fVPRZWvtrOhmj6x8FQPE8JGFXwor15vj+yZlQ3Ti/Riiw4tLSiOOd/H3kwjGTOrnN+WVKVQ5AvC1dX2psC2MWdgQbW6f8BFIarE7u2q4w/afTRYQejTR143bBaiZE7Gbn3OdHos2CI4+8S6CEs4U6w53ceMGF7jHSXjXcRYJKE7HD3gsqk7QgCPDG2GgQquwrOOShBc1eHblxDqqe1Bsb82q7AafMLi2nzNIqKXE+EHuhKwDKnAP4/IQ74GYn+MF1n7MLRRz4zvFS/yP46typRVaeG8jXU0WXW5DN/NyC9SvDVyMWqSMKMX+Jumosyut6axOH1pPUwb5FeznoTBKszcM53IgdJ/YLCXeI5HW3ja364xCyOxVidG5vu1hzIZf3HdYROhwSrLbMtRaDHp/HLWTMowAmGvSqBTDehSM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e6d84-55fc-41e2-8529-08d6aedc41ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:14.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx6q driver to clk_hw based API.
Add imx6q_obtain_fixed_clk_hw helper to clean up the registration
of the clocks that are either found in device tree or are assigned
a fixed zero rate.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 759 +++++++++++++++++++++++-----------------=
----
 1 file changed, 392 insertions(+), 367 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index c7b671e..71767b2 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -93,8 +93,8 @@ static const char *pll5_bypass_sels[] =3D { "pll5", "pll5=
_bypass_src", };
 static const char *pll6_bypass_sels[] =3D { "pll6", "pll6_bypass_src", };
 static const char *pll7_bypass_sels[] =3D { "pll7", "pll7_bypass_src", };
=20
-static struct clk *clk[IMX6QDL_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
=20
 static struct clk_div_table clk_enet_ref_table[] =3D {
 	{ .val =3D 0, .div =3D 20, },
@@ -144,12 +144,13 @@ static inline int clk_on_imx6dl(void)
 	return of_machine_is_compatible("fsl,imx6dl");
 }
=20
-static struct clk ** const uart_clks[] __initconst =3D {
-	&clk[IMX6QDL_CLK_UART_IPG],
-	&clk[IMX6QDL_CLK_UART_SERIAL],
-	NULL
+static const int uart_clk_ids[] __initconst =3D {
+	IMX6QDL_CLK_UART_IPG,
+	IMX6QDL_CLK_UART_SERIAL,
 };
=20
+static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
+
 static int ldb_di_sel_by_clock_id(int clock_id)
 {
 	switch (clock_id) {
@@ -288,8 +289,8 @@ static void mmdc_ch1_disable(void __iomem *ccm_base)
 {
 	unsigned int reg;
=20
-	clk_set_parent(clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL],
-		       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
+	clk_set_parent(hws[IMX6QDL_CLK_PERIPH2_CLK2_SEL]->clk,
+		       hws[IMX6QDL_CLK_PLL3_USB_OTG]->clk);
=20
 	/* Disable pll3_sw_clk by selecting the bypass clock source */
 	reg =3D readl_relaxed(ccm_base + CCM_CCSR);
@@ -363,8 +364,8 @@ static void init_ldb_clks(struct device_node *np, void =
__iomem *ccm_base)
=20
 		/* Only switch to or from pll2_pfd2_396m if it is disabled */
 		if ((sel[i][0] =3D=3D 2 || sel[i][3] =3D=3D 2) &&
-		    (clk_get_parent(clk[IMX6QDL_CLK_PERIPH_PRE]) =3D=3D
-		     clk[IMX6QDL_CLK_PLL2_PFD2_396M])) {
+		    (clk_get_parent(hws[IMX6QDL_CLK_PERIPH_PRE]->clk) =3D=3D
+		     hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk)) {
 			pr_err("ccm: ldb_di%d_sel: couldn't disable pll2_pfd2_396m\n",
 			       i);
 			sel[i][3] =3D sel[i][2] =3D sel[i][1] =3D sel[i][0];
@@ -416,8 +417,8 @@ static void disable_anatop_clocks(void __iomem *anatop_=
base)
 	/* Make sure PLL2 PFDs 0-2 are gated */
 	reg =3D readl_relaxed(anatop_base + CCM_ANALOG_PFD_528);
 	/* Cannot gate PFD2 if pll2_pfd2_396m is the parent of MMDC clock */
-	if (clk_get_parent(clk[IMX6QDL_CLK_PERIPH_PRE]) =3D=3D
-	    clk[IMX6QDL_CLK_PLL2_PFD2_396M])
+	if (clk_get_parent(hws[IMX6QDL_CLK_PERIPH_PRE]->clk) =3D=3D
+	    hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk)
 		reg |=3D PFD0_CLKGATE | PFD1_CLKGATE;
 	else
 		reg |=3D PFD0_CLKGATE | PFD1_CLKGATE | PFD2_CLKGATE;
@@ -434,31 +435,44 @@ static void disable_anatop_clocks(void __iomem *anato=
p_base)
 	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
 }
=20
+static struct clk_hw *imx6q_obtain_fixed_clk_hw(struct device_node *np,
+						const char *name, unsigned long rate)
+{
+	struct clk *clk =3D of_clk_get_by_name(np, name);
+	struct clk_hw *hw;
+
+	if (IS_ERR(clk))
+		hw =3D imx_obtain_fixed_clock_hw(name, rate);
+	else
+		hw =3D __clk_get_hw(clk);
+
+	return hw;
+}
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *anatop_base, *base;
 	int ret;
+	int i;
+
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX6QDL_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
=20
-	clk[IMX6QDL_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
-	clk[IMX6QDL_CLK_CKIL] =3D of_clk_get_by_name(ccm_node, "ckil");
-	if (IS_ERR(clk[IMX6QDL_CLK_CKIL]))
-		clk[IMX6QDL_CLK_CKIL] =3D imx_obtain_fixed_clock("ckil", 0);
-	clk[IMX6QDL_CLK_CKIH] =3D of_clk_get_by_name(ccm_node, "ckih1");
-	if (IS_ERR(clk[IMX6QDL_CLK_CKIH]))
-		clk[IMX6QDL_CLK_CKIH] =3D imx_obtain_fixed_clock("ckih1", 0);
-	clk[IMX6QDL_CLK_OSC] =3D of_clk_get_by_name(ccm_node, "osc");
-	if (IS_ERR(clk[IMX6QDL_CLK_OSC]))
-		clk[IMX6QDL_CLK_OSC] =3D imx_obtain_fixed_clock("osc", 0);
+	clk_hw_data->num =3D IMX6QDL_CLK_END;
+	hws =3D clk_hw_data->hws;
=20
-	/* Clock source from external clock via CLK1/2 PADs */
-	clk[IMX6QDL_CLK_ANACLK1] =3D of_clk_get_by_name(ccm_node, "anaclk1");
-	if (IS_ERR(clk[IMX6QDL_CLK_ANACLK1]))
-		clk[IMX6QDL_CLK_ANACLK1] =3D imx_obtain_fixed_clock("anaclk1", 0);
+	hws[IMX6QDL_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
=20
-	clk[IMX6QDL_CLK_ANACLK2] =3D of_clk_get_by_name(ccm_node, "anaclk2");
-	if (IS_ERR(clk[IMX6QDL_CLK_ANACLK2]))
-		clk[IMX6QDL_CLK_ANACLK2] =3D imx_obtain_fixed_clock("anaclk2", 0);
+	hws[IMX6QDL_CLK_CKIL] =3D imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
+	hws[IMX6QDL_CLK_CKIH] =3D imx6q_obtain_fixed_clk_hw(ccm_node, "ckih1", 0)=
;
+	hws[IMX6QDL_CLK_OSC] =3D imx6q_obtain_fixed_clk_hw(ccm_node, "osc", 0);
+
+	/* Clock source from external clock via CLK1/2 PADs */
+	hws[IMX6QDL_CLK_ANACLK1] =3D imx6q_obtain_fixed_clk_hw(ccm_node, "anaclk1=
", 0);
+	hws[IMX6QDL_CLK_ANACLK2] =3D imx6q_obtain_fixed_clk_hw(ccm_node, "anaclk2=
", 0);
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	anatop_base =3D base =3D of_iomap(np, 0);
@@ -473,47 +487,47 @@ static void __init imx6q_clocks_init(struct device_no=
de *ccm_node)
 		video_div_table[3].div =3D 1;
 	}
=20
-	clk[IMX6QDL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL2_BYPASS_SRC] =3D imx_clk_mux("pll2_bypass_src", base + 0x=
30, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL3_BYPASS_SRC] =3D imx_clk_mux("pll3_bypass_src", base + 0x=
10, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL4_BYPASS_SRC] =3D imx_clk_mux("pll4_bypass_src", base + 0x=
70, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL5_BYPASS_SRC] =3D imx_clk_mux("pll5_bypass_src", base + 0x=
a0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL6_BYPASS_SRC] =3D imx_clk_mux("pll6_bypass_src", base + 0x=
e0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clk[IMX6QDL_PLL7_BYPASS_SRC] =3D imx_clk_mux("pll7_bypass_src", base + 0x=
20, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL1_BYPASS_SRC] =3D imx_clk_hw_mux("pll1_bypass_src", base +=
 0x00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL2_BYPASS_SRC] =3D imx_clk_hw_mux("pll2_bypass_src", base +=
 0x30, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL3_BYPASS_SRC] =3D imx_clk_hw_mux("pll3_bypass_src", base +=
 0x10, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL4_BYPASS_SRC] =3D imx_clk_hw_mux("pll4_bypass_src", base +=
 0x70, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL5_BYPASS_SRC] =3D imx_clk_hw_mux("pll5_bypass_src", base +=
 0xa0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL6_BYPASS_SRC] =3D imx_clk_hw_mux("pll6_bypass_src", base +=
 0xe0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6QDL_PLL7_BYPASS_SRC] =3D imx_clk_hw_mux("pll7_bypass_src", base +=
 0x20, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
=20
 	/*                                    type               name    parent_n=
ame        base         div_mask */
-	clk[IMX6QDL_CLK_PLL1] =3D imx_clk_pllv3(IMX_PLLV3_SYS,     "pll1", "osc",=
 base + 0x00, 0x7f);
-	clk[IMX6QDL_CLK_PLL2] =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc",=
 base + 0x30, 0x1);
-	clk[IMX6QDL_CLK_PLL3] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll3", "osc",=
 base + 0x10, 0x3);
-	clk[IMX6QDL_CLK_PLL4] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll4", "osc",=
 base + 0x70, 0x7f);
-	clk[IMX6QDL_CLK_PLL5] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll5", "osc",=
 base + 0xa0, 0x7f);
-	clk[IMX6QDL_CLK_PLL6] =3D imx_clk_pllv3(IMX_PLLV3_ENET,    "pll6", "osc",=
 base + 0xe0, 0x3);
-	clk[IMX6QDL_CLK_PLL7] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll7", "osc",=
 base + 0x20, 0x3);
-
-	clk[IMX6QDL_PLL1_BYPASS] =3D imx_clk_mux_flags("pll1_bypass", base + 0x00=
, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL2_BYPASS] =3D imx_clk_mux_flags("pll2_bypass", base + 0x30=
, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL3_BYPASS] =3D imx_clk_mux_flags("pll3_bypass", base + 0x10=
, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL4_BYPASS] =3D imx_clk_mux_flags("pll4_bypass", base + 0x70=
, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL5_BYPASS] =3D imx_clk_mux_flags("pll5_bypass", base + 0xa0=
, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL6_BYPASS] =3D imx_clk_mux_flags("pll6_bypass", base + 0xe0=
, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clk[IMX6QDL_PLL7_BYPASS] =3D imx_clk_mux_flags("pll7_bypass", base + 0x20=
, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAREN=
T);
+	hws[IMX6QDL_CLK_PLL1] =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "os=
c", base + 0x00, 0x7f);
+	hws[IMX6QDL_CLK_PLL2] =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "os=
c", base + 0x30, 0x1);
+	hws[IMX6QDL_CLK_PLL3] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "os=
c", base + 0x10, 0x3);
+	hws[IMX6QDL_CLK_PLL4] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "os=
c", base + 0x70, 0x7f);
+	hws[IMX6QDL_CLK_PLL5] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "os=
c", base + 0xa0, 0x7f);
+	hws[IMX6QDL_CLK_PLL6] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "os=
c", base + 0xe0, 0x3);
+	hws[IMX6QDL_CLK_PLL7] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "os=
c", base + 0x20, 0x3);
+
+	hws[IMX6QDL_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("pll1_bypass", base + 0=
x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("pll2_bypass", base + 0=
x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("pll3_bypass", base + 0=
x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL4_BYPASS] =3D imx_clk_hw_mux_flags("pll4_bypass", base + 0=
x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL5_BYPASS] =3D imx_clk_hw_mux_flags("pll5_bypass", base + 0=
xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL6_BYPASS] =3D imx_clk_hw_mux_flags("pll6_bypass", base + 0=
xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PA=
RENT);
+	hws[IMX6QDL_PLL7_BYPASS] =3D imx_clk_hw_mux_flags("pll7_bypass", base + 0=
x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PA=
RENT);
=20
 	/* Do not bypass PLLs initially */
-	clk_set_parent(clk[IMX6QDL_PLL1_BYPASS], clk[IMX6QDL_CLK_PLL1]);
-	clk_set_parent(clk[IMX6QDL_PLL2_BYPASS], clk[IMX6QDL_CLK_PLL2]);
-	clk_set_parent(clk[IMX6QDL_PLL3_BYPASS], clk[IMX6QDL_CLK_PLL3]);
-	clk_set_parent(clk[IMX6QDL_PLL4_BYPASS], clk[IMX6QDL_CLK_PLL4]);
-	clk_set_parent(clk[IMX6QDL_PLL5_BYPASS], clk[IMX6QDL_CLK_PLL5]);
-	clk_set_parent(clk[IMX6QDL_PLL6_BYPASS], clk[IMX6QDL_CLK_PLL6]);
-	clk_set_parent(clk[IMX6QDL_PLL7_BYPASS], clk[IMX6QDL_CLK_PLL7]);
-
-	clk[IMX6QDL_CLK_PLL1_SYS]      =3D imx_clk_gate("pll1_sys",      "pll1_by=
pass", base + 0x00, 13);
-	clk[IMX6QDL_CLK_PLL2_BUS]      =3D imx_clk_gate("pll2_bus",      "pll2_by=
pass", base + 0x30, 13);
-	clk[IMX6QDL_CLK_PLL3_USB_OTG]  =3D imx_clk_gate("pll3_usb_otg",  "pll3_by=
pass", base + 0x10, 13);
-	clk[IMX6QDL_CLK_PLL4_AUDIO]    =3D imx_clk_gate("pll4_audio",    "pll4_by=
pass", base + 0x70, 13);
-	clk[IMX6QDL_CLK_PLL5_VIDEO]    =3D imx_clk_gate("pll5_video",    "pll5_by=
pass", base + 0xa0, 13);
-	clk[IMX6QDL_CLK_PLL6_ENET]     =3D imx_clk_gate("pll6_enet",     "pll6_by=
pass", base + 0xe0, 13);
-	clk[IMX6QDL_CLK_PLL7_USB_HOST] =3D imx_clk_gate("pll7_usb_host", "pll7_by=
pass", base + 0x20, 13);
+	clk_set_parent(hws[IMX6QDL_PLL1_BYPASS]->clk, hws[IMX6QDL_CLK_PLL1]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL2_BYPASS]->clk, hws[IMX6QDL_CLK_PLL2]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL3_BYPASS]->clk, hws[IMX6QDL_CLK_PLL3]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL4_BYPASS]->clk, hws[IMX6QDL_CLK_PLL4]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL5_BYPASS]->clk, hws[IMX6QDL_CLK_PLL5]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL6_BYPASS]->clk, hws[IMX6QDL_CLK_PLL6]->clk)=
;
+	clk_set_parent(hws[IMX6QDL_PLL7_BYPASS]->clk, hws[IMX6QDL_CLK_PLL7]->clk)=
;
+
+	hws[IMX6QDL_CLK_PLL1_SYS]      =3D imx_clk_hw_gate("pll1_sys",      "pll1=
_bypass", base + 0x00, 13);
+	hws[IMX6QDL_CLK_PLL2_BUS]      =3D imx_clk_hw_gate("pll2_bus",      "pll2=
_bypass", base + 0x30, 13);
+	hws[IMX6QDL_CLK_PLL3_USB_OTG]  =3D imx_clk_hw_gate("pll3_usb_otg",  "pll3=
_bypass", base + 0x10, 13);
+	hws[IMX6QDL_CLK_PLL4_AUDIO]    =3D imx_clk_hw_gate("pll4_audio",    "pll4=
_bypass", base + 0x70, 13);
+	hws[IMX6QDL_CLK_PLL5_VIDEO]    =3D imx_clk_hw_gate("pll5_video",    "pll5=
_bypass", base + 0xa0, 13);
+	hws[IMX6QDL_CLK_PLL6_ENET]     =3D imx_clk_hw_gate("pll6_enet",     "pll6=
_bypass", base + 0xe0, 13);
+	hws[IMX6QDL_CLK_PLL7_USB_HOST] =3D imx_clk_hw_gate("pll7_usb_host", "pll7=
_bypass", base + 0x20, 13);
=20
 	/*
 	 * Bit 20 is the reserved and read-only bit, we do this only for:
@@ -521,15 +535,15 @@ static void __init imx6q_clocks_init(struct device_no=
de *ccm_node)
 	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
 	 * the clk framework may need to enable/disable usbphy's parent
 	 */
-	clk[IMX6QDL_CLK_USBPHY1] =3D imx_clk_gate("usbphy1", "pll3_usb_otg", base=
 + 0x10, 20);
-	clk[IMX6QDL_CLK_USBPHY2] =3D imx_clk_gate("usbphy2", "pll7_usb_host", bas=
e + 0x20, 20);
+	hws[IMX6QDL_CLK_USBPHY1] =3D imx_clk_hw_gate("usbphy1", "pll3_usb_otg", b=
ase + 0x10, 20);
+	hws[IMX6QDL_CLK_USBPHY2] =3D imx_clk_hw_gate("usbphy2", "pll7_usb_host", =
base + 0x20, 20);
=20
 	/*
 	 * usbphy*_gate needs to be on after system boots up, and software
 	 * never needs to control it anymore.
 	 */
-	clk[IMX6QDL_CLK_USBPHY1_GATE] =3D imx_clk_gate("usbphy1_gate", "dummy", b=
ase + 0x10, 6);
-	clk[IMX6QDL_CLK_USBPHY2_GATE] =3D imx_clk_gate("usbphy2_gate", "dummy", b=
ase + 0x20, 6);
+	hws[IMX6QDL_CLK_USBPHY1_GATE] =3D imx_clk_hw_gate("usbphy1_gate", "dummy"=
, base + 0x10, 6);
+	hws[IMX6QDL_CLK_USBPHY2_GATE] =3D imx_clk_hw_gate("usbphy2_gate", "dummy"=
, base + 0x20, 6);
=20
 	/*
 	 * The ENET PLL is special in that is has multiple outputs with
@@ -543,22 +557,22 @@ static void __init imx6q_clocks_init(struct device_no=
de *ccm_node)
 	 *
 	 */
 	if (!pll6_bypassed(ccm_node)) {
-		clk[IMX6QDL_CLK_SATA_REF] =3D imx_clk_fixed_factor("sata_ref", "pll6_ene=
t", 1, 5);
-		clk[IMX6QDL_CLK_PCIE_REF] =3D imx_clk_fixed_factor("pcie_ref", "pll6_ene=
t", 1, 4);
-		clk[IMX6QDL_CLK_ENET_REF] =3D clk_register_divider_table(NULL, "enet_ref=
", "pll6_enet", 0,
+		hws[IMX6QDL_CLK_SATA_REF] =3D imx_clk_hw_fixed_factor("sata_ref", "pll6_=
enet", 1, 5);
+		hws[IMX6QDL_CLK_PCIE_REF] =3D imx_clk_hw_fixed_factor("pcie_ref", "pll6_=
enet", 1, 4);
+		hws[IMX6QDL_CLK_ENET_REF] =3D clk_hw_register_divider_table(NULL, "enet_=
ref", "pll6_enet", 0,
 						base + 0xe0, 0, 2, 0, clk_enet_ref_table,
 						&imx_ccm_lock);
 	} else {
-		clk[IMX6QDL_CLK_SATA_REF] =3D imx_clk_fixed_factor("sata_ref", "pll6_ene=
t", 1, 1);
-		clk[IMX6QDL_CLK_PCIE_REF] =3D imx_clk_fixed_factor("pcie_ref", "pll6_ene=
t", 1, 1);
-		clk[IMX6QDL_CLK_ENET_REF] =3D imx_clk_fixed_factor("enet_ref", "pll6_ene=
t", 1, 1);
+		hws[IMX6QDL_CLK_SATA_REF] =3D imx_clk_hw_fixed_factor("sata_ref", "pll6_=
enet", 1, 1);
+		hws[IMX6QDL_CLK_PCIE_REF] =3D imx_clk_hw_fixed_factor("pcie_ref", "pll6_=
enet", 1, 1);
+		hws[IMX6QDL_CLK_ENET_REF] =3D imx_clk_hw_fixed_factor("enet_ref", "pll6_=
enet", 1, 1);
 	}
=20
-	clk[IMX6QDL_CLK_SATA_REF_100M] =3D imx_clk_gate("sata_ref_100m", "sata_re=
f", base + 0xe0, 20);
-	clk[IMX6QDL_CLK_PCIE_REF_125M] =3D imx_clk_gate("pcie_ref_125m", "pcie_re=
f", base + 0xe0, 19);
+	hws[IMX6QDL_CLK_SATA_REF_100M] =3D imx_clk_hw_gate("sata_ref_100m", "sata=
_ref", base + 0xe0, 20);
+	hws[IMX6QDL_CLK_PCIE_REF_125M] =3D imx_clk_hw_gate("pcie_ref_125m", "pcie=
_ref", base + 0xe0, 19);
=20
-	clk[IMX6QDL_CLK_LVDS1_SEL] =3D imx_clk_mux("lvds1_sel", base + 0x160, 0, =
5, lvds_sels, ARRAY_SIZE(lvds_sels));
-	clk[IMX6QDL_CLK_LVDS2_SEL] =3D imx_clk_mux("lvds2_sel", base + 0x160, 5, =
5, lvds_sels, ARRAY_SIZE(lvds_sels));
+	hws[IMX6QDL_CLK_LVDS1_SEL] =3D imx_clk_hw_mux("lvds1_sel", base + 0x160, =
0, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
+	hws[IMX6QDL_CLK_LVDS2_SEL] =3D imx_clk_hw_mux("lvds2_sel", base + 0x160, =
5, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
=20
 	/*
 	 * lvds1_gate and lvds2_gate are pseudo-gates.  Both can be
@@ -570,84 +584,84 @@ static void __init imx6q_clocks_init(struct device_no=
de *ccm_node)
 	 * it.
 	 */
 	writel(readl(base + 0x160) & ~0x3c00, base + 0x160);
-	clk[IMX6QDL_CLK_LVDS1_GATE] =3D imx_clk_gate_exclusive("lvds1_gate", "lvd=
s1_sel", base + 0x160, 10, BIT(12));
-	clk[IMX6QDL_CLK_LVDS2_GATE] =3D imx_clk_gate_exclusive("lvds2_gate", "lvd=
s2_sel", base + 0x160, 11, BIT(13));
+	hws[IMX6QDL_CLK_LVDS1_GATE] =3D imx_clk_hw_gate_exclusive("lvds1_gate", "=
lvds1_sel", base + 0x160, 10, BIT(12));
+	hws[IMX6QDL_CLK_LVDS2_GATE] =3D imx_clk_hw_gate_exclusive("lvds2_gate", "=
lvds2_sel", base + 0x160, 11, BIT(13));
=20
-	clk[IMX6QDL_CLK_LVDS1_IN] =3D imx_clk_gate_exclusive("lvds1_in", "anaclk1=
", base + 0x160, 12, BIT(10));
-	clk[IMX6QDL_CLK_LVDS2_IN] =3D imx_clk_gate_exclusive("lvds2_in", "anaclk2=
", base + 0x160, 13, BIT(11));
+	hws[IMX6QDL_CLK_LVDS1_IN] =3D imx_clk_hw_gate_exclusive("lvds1_in", "anac=
lk1", base + 0x160, 12, BIT(10));
+	hws[IMX6QDL_CLK_LVDS2_IN] =3D imx_clk_hw_gate_exclusive("lvds2_in", "anac=
lk2", base + 0x160, 13, BIT(11));
=20
 	/*                                            name              parent_na=
me        reg       idx */
-	clk[IMX6QDL_CLK_PLL2_PFD0_352M] =3D imx_clk_pfd("pll2_pfd0_352m", "pll2_b=
us",     base + 0x100, 0);
-	clk[IMX6QDL_CLK_PLL2_PFD1_594M] =3D imx_clk_pfd("pll2_pfd1_594m", "pll2_b=
us",     base + 0x100, 1);
-	clk[IMX6QDL_CLK_PLL2_PFD2_396M] =3D imx_clk_pfd("pll2_pfd2_396m", "pll2_b=
us",     base + 0x100, 2);
-	clk[IMX6QDL_CLK_PLL3_PFD0_720M] =3D imx_clk_pfd("pll3_pfd0_720m", "pll3_u=
sb_otg", base + 0xf0,  0);
-	clk[IMX6QDL_CLK_PLL3_PFD1_540M] =3D imx_clk_pfd("pll3_pfd1_540m", "pll3_u=
sb_otg", base + 0xf0,  1);
-	clk[IMX6QDL_CLK_PLL3_PFD2_508M] =3D imx_clk_pfd("pll3_pfd2_508m", "pll3_u=
sb_otg", base + 0xf0,  2);
-	clk[IMX6QDL_CLK_PLL3_PFD3_454M] =3D imx_clk_pfd("pll3_pfd3_454m", "pll3_u=
sb_otg", base + 0xf0,  3);
+	hws[IMX6QDL_CLK_PLL2_PFD0_352M] =3D imx_clk_hw_pfd("pll2_pfd0_352m", "pll=
2_bus",     base + 0x100, 0);
+	hws[IMX6QDL_CLK_PLL2_PFD1_594M] =3D imx_clk_hw_pfd("pll2_pfd1_594m", "pll=
2_bus",     base + 0x100, 1);
+	hws[IMX6QDL_CLK_PLL2_PFD2_396M] =3D imx_clk_hw_pfd("pll2_pfd2_396m", "pll=
2_bus",     base + 0x100, 2);
+	hws[IMX6QDL_CLK_PLL3_PFD0_720M] =3D imx_clk_hw_pfd("pll3_pfd0_720m", "pll=
3_usb_otg", base + 0xf0,  0);
+	hws[IMX6QDL_CLK_PLL3_PFD1_540M] =3D imx_clk_hw_pfd("pll3_pfd1_540m", "pll=
3_usb_otg", base + 0xf0,  1);
+	hws[IMX6QDL_CLK_PLL3_PFD2_508M] =3D imx_clk_hw_pfd("pll3_pfd2_508m", "pll=
3_usb_otg", base + 0xf0,  2);
+	hws[IMX6QDL_CLK_PLL3_PFD3_454M] =3D imx_clk_hw_pfd("pll3_pfd3_454m", "pll=
3_usb_otg", base + 0xf0,  3);
=20
 	/*                                                name         parent_nam=
e     mult div */
-	clk[IMX6QDL_CLK_PLL2_198M] =3D imx_clk_fixed_factor("pll2_198m", "pll2_pf=
d2_396m", 1, 2);
-	clk[IMX6QDL_CLK_PLL3_120M] =3D imx_clk_fixed_factor("pll3_120m", "pll3_us=
b_otg",   1, 4);
-	clk[IMX6QDL_CLK_PLL3_80M]  =3D imx_clk_fixed_factor("pll3_80m",  "pll3_us=
b_otg",   1, 6);
-	clk[IMX6QDL_CLK_PLL3_60M]  =3D imx_clk_fixed_factor("pll3_60m",  "pll3_us=
b_otg",   1, 8);
-	clk[IMX6QDL_CLK_TWD]       =3D imx_clk_fixed_factor("twd",       "arm",  =
          1, 2);
-	clk[IMX6QDL_CLK_GPT_3M]    =3D imx_clk_fixed_factor("gpt_3m",    "osc",  =
          1, 8);
-	clk[IMX6QDL_CLK_VIDEO_27M] =3D imx_clk_fixed_factor("video_27m", "pll3_pf=
d1_540m", 1, 20);
+	hws[IMX6QDL_CLK_PLL2_198M] =3D imx_clk_hw_fixed_factor("pll2_198m", "pll2=
_pfd2_396m", 1, 2);
+	hws[IMX6QDL_CLK_PLL3_120M] =3D imx_clk_hw_fixed_factor("pll3_120m", "pll3=
_usb_otg",   1, 4);
+	hws[IMX6QDL_CLK_PLL3_80M]  =3D imx_clk_hw_fixed_factor("pll3_80m",  "pll3=
_usb_otg",   1, 6);
+	hws[IMX6QDL_CLK_PLL3_60M]  =3D imx_clk_hw_fixed_factor("pll3_60m",  "pll3=
_usb_otg",   1, 8);
+	hws[IMX6QDL_CLK_TWD]       =3D imx_clk_hw_fixed_factor("twd",       "arm"=
,            1, 2);
+	hws[IMX6QDL_CLK_GPT_3M]    =3D imx_clk_hw_fixed_factor("gpt_3m",    "osc"=
,            1, 8);
+	hws[IMX6QDL_CLK_VIDEO_27M] =3D imx_clk_hw_fixed_factor("video_27m", "pll3=
_pfd1_540m", 1, 20);
 	if (clk_on_imx6dl() || clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_GPU2D_AXI] =3D imx_clk_fixed_factor("gpu2d_axi", "mmdc_c=
h0_axi_podf", 1, 1);
-		clk[IMX6QDL_CLK_GPU3D_AXI] =3D imx_clk_fixed_factor("gpu3d_axi", "mmdc_c=
h0_axi_podf", 1, 1);
+		hws[IMX6QDL_CLK_GPU2D_AXI] =3D imx_clk_hw_fixed_factor("gpu2d_axi", "mmd=
c_ch0_axi_podf", 1, 1);
+		hws[IMX6QDL_CLK_GPU3D_AXI] =3D imx_clk_hw_fixed_factor("gpu3d_axi", "mmd=
c_ch0_axi_podf", 1, 1);
 	}
=20
-	clk[IMX6QDL_CLK_PLL4_POST_DIV] =3D clk_register_divider_table(NULL, "pll4=
_post_div", "pll4_audio", CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_=
div_table, &imx_ccm_lock);
-	clk[IMX6QDL_CLK_PLL4_AUDIO_DIV] =3D clk_register_divider(NULL, "pll4_audi=
o_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_=
ccm_lock);
-	clk[IMX6QDL_CLK_PLL5_POST_DIV] =3D clk_register_divider_table(NULL, "pll5=
_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_=
div_table, &imx_ccm_lock);
-	clk[IMX6QDL_CLK_PLL5_VIDEO_DIV] =3D clk_register_divider_table(NULL, "pll=
5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0,=
 video_div_table, &imx_ccm_lock);
+	hws[IMX6QDL_CLK_PLL4_POST_DIV] =3D clk_hw_register_divider_table(NULL, "p=
ll4_post_div", "pll4_audio", CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, po=
st_div_table, &imx_ccm_lock);
+	hws[IMX6QDL_CLK_PLL4_AUDIO_DIV] =3D clk_hw_register_divider(NULL, "pll4_a=
udio_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &i=
mx_ccm_lock);
+	hws[IMX6QDL_CLK_PLL5_POST_DIV] =3D clk_hw_register_divider_table(NULL, "p=
ll5_post_div", "pll5_video", CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, po=
st_div_table, &imx_ccm_lock);
+	hws[IMX6QDL_CLK_PLL5_VIDEO_DIV] =3D clk_hw_register_divider_table(NULL, "=
pll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2,=
 0, video_div_table, &imx_ccm_lock);
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
 	/*                                              name                reg  =
     shift width parent_names     num_parents */
-	clk[IMX6QDL_CLK_STEP]             =3D imx_clk_mux("step",	            bas=
e + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
-	clk[IMX6QDL_CLK_PLL1_SW]          =3D imx_clk_mux("pll1_sw",	    base + 0=
xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
-	clk[IMX6QDL_CLK_PERIPH_PRE]       =3D imx_clk_mux("periph_pre",       bas=
e + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
-	clk[IMX6QDL_CLK_PERIPH2_PRE]      =3D imx_clk_mux("periph2_pre",      bas=
e + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
-	clk[IMX6QDL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_mux("periph_clk2_sel",  bas=
e + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
-	clk[IMX6QDL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_mux("periph2_clk2_sel", bas=
e + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clk[IMX6QDL_CLK_AXI_SEL]          =3D imx_clk_mux("axi_sel",          bas=
e + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
-	clk[IMX6QDL_CLK_ESAI_SEL]         =3D imx_clk_mux("esai_sel",         bas=
e + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
-	clk[IMX6QDL_CLK_ASRC_SEL]         =3D imx_clk_mux("asrc_sel",         bas=
e + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
-	clk[IMX6QDL_CLK_SPDIF_SEL]        =3D imx_clk_mux("spdif_sel",        bas=
e + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6QDL_CLK_STEP]             =3D imx_clk_hw_mux("step",	            =
base + 0xc,  8,  1, step_sels,	   ARRAY_SIZE(step_sels));
+	hws[IMX6QDL_CLK_PLL1_SW]          =3D imx_clk_hw_mux("pll1_sw",	    base =
+ 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	hws[IMX6QDL_CLK_PERIPH_PRE]       =3D imx_clk_hw_mux("periph_pre",       =
base + 0x18, 18, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
+	hws[IMX6QDL_CLK_PERIPH2_PRE]      =3D imx_clk_hw_mux("periph2_pre",      =
base + 0x18, 21, 2, periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
+	hws[IMX6QDL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_hw_mux("periph_clk2_sel",  =
base + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
+	hws[IMX6QDL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_hw_mux("periph2_clk2_sel", =
base + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
+	hws[IMX6QDL_CLK_AXI_SEL]          =3D imx_clk_hw_mux("axi_sel",          =
base + 0x14, 6,  2, axi_sels,          ARRAY_SIZE(axi_sels));
+	hws[IMX6QDL_CLK_ESAI_SEL]         =3D imx_clk_hw_mux("esai_sel",         =
base + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6QDL_CLK_ASRC_SEL]         =3D imx_clk_hw_mux("asrc_sel",         =
base + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6QDL_CLK_SPDIF_SEL]        =3D imx_clk_hw_mux("spdif_sel",        =
base + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
 	if (clk_on_imx6q()) {
-		clk[IMX6QDL_CLK_GPU2D_AXI]        =3D imx_clk_mux("gpu2d_axi",        ba=
se + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
-		clk[IMX6QDL_CLK_GPU3D_AXI]        =3D imx_clk_mux("gpu3d_axi",        ba=
se + 0x18, 1,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
+		hws[IMX6QDL_CLK_GPU2D_AXI]        =3D imx_clk_hw_mux("gpu2d_axi",       =
 base + 0x18, 0,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
+		hws[IMX6QDL_CLK_GPU3D_AXI]        =3D imx_clk_hw_mux("gpu3d_axi",       =
 base + 0x18, 1,  1, gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
 	}
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_CAN_SEL]   =3D imx_clk_mux("can_sel",	base + 0x20, 8,  2=
, can_sels, ARRAY_SIZE(can_sels));
-		clk[IMX6QDL_CLK_ECSPI_SEL] =3D imx_clk_mux("ecspi_sel",	base + 0x38, 18,=
 1, ecspi_sels,  ARRAY_SIZE(ecspi_sels));
-		clk[IMX6QDL_CLK_IPG_PER_SEL] =3D imx_clk_mux("ipg_per_sel", base + 0x1c,=
 6, 1, ipg_per_sels, ARRAY_SIZE(ipg_per_sels));
-		clk[IMX6QDL_CLK_UART_SEL] =3D imx_clk_mux("uart_sel", base + 0x24, 6, 1,=
 uart_sels, ARRAY_SIZE(uart_sels));
-		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_mux("gpu2d_core_sel", base +=
 0x18, 16, 2, gpu2d_core_sels_2, ARRAY_SIZE(gpu2d_core_sels_2));
+		hws[IMX6QDL_CLK_CAN_SEL]   =3D imx_clk_hw_mux("can_sel",	base + 0x20, 8,=
  2, can_sels, ARRAY_SIZE(can_sels));
+		hws[IMX6QDL_CLK_ECSPI_SEL] =3D imx_clk_hw_mux("ecspi_sel",	base + 0x38, =
18, 1, ecspi_sels,  ARRAY_SIZE(ecspi_sels));
+		hws[IMX6QDL_CLK_IPG_PER_SEL] =3D imx_clk_hw_mux("ipg_per_sel", base + 0x=
1c, 6, 1, ipg_per_sels, ARRAY_SIZE(ipg_per_sels));
+		hws[IMX6QDL_CLK_UART_SEL] =3D imx_clk_hw_mux("uart_sel", base + 0x24, 6,=
 1, uart_sels, ARRAY_SIZE(uart_sels));
+		hws[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_hw_mux("gpu2d_core_sel", bas=
e + 0x18, 16, 2, gpu2d_core_sels_2, ARRAY_SIZE(gpu2d_core_sels_2));
 	} else if (clk_on_imx6dl()) {
-		clk[IMX6QDL_CLK_MLB_SEL] =3D imx_clk_mux("mlb_sel",   base + 0x18, 16, 2=
, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
+		hws[IMX6QDL_CLK_MLB_SEL] =3D imx_clk_hw_mux("mlb_sel",   base + 0x18, 16=
, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
 	} else {
-		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_mux("gpu2d_core_sel",   base=
 + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
+		hws[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_hw_mux("gpu2d_core_sel",   b=
ase + 0x18, 16, 2, gpu2d_core_sels,   ARRAY_SIZE(gpu2d_core_sels));
 	}
-	clk[IMX6QDL_CLK_GPU3D_CORE_SEL]   =3D imx_clk_mux("gpu3d_core_sel",   bas=
e + 0x18, 4,  2, gpu3d_core_sels,   ARRAY_SIZE(gpu3d_core_sels));
+	hws[IMX6QDL_CLK_GPU3D_CORE_SEL]   =3D imx_clk_hw_mux("gpu3d_core_sel",   =
base + 0x18, 4,  2, gpu3d_core_sels,   ARRAY_SIZE(gpu3d_core_sels));
 	if (clk_on_imx6dl())
-		clk[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_mux("gpu2d_core_sel", base +=
 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
+		hws[IMX6QDL_CLK_GPU2D_CORE_SEL] =3D imx_clk_hw_mux("gpu2d_core_sel", bas=
e + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
 	else
-		clk[IMX6QDL_CLK_GPU3D_SHADER_SEL] =3D imx_clk_mux("gpu3d_shader_sel", ba=
se + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
-	clk[IMX6QDL_CLK_IPU1_SEL]         =3D imx_clk_mux("ipu1_sel",         bas=
e + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
-	clk[IMX6QDL_CLK_IPU2_SEL]         =3D imx_clk_mux("ipu2_sel",         bas=
e + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
+		hws[IMX6QDL_CLK_GPU3D_SHADER_SEL] =3D imx_clk_hw_mux("gpu3d_shader_sel",=
 base + 0x18, 8,  2, gpu3d_shader_sels, ARRAY_SIZE(gpu3d_shader_sels));
+	hws[IMX6QDL_CLK_IPU1_SEL]         =3D imx_clk_hw_mux("ipu1_sel",         =
base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
+	hws[IMX6QDL_CLK_IPU2_SEL]         =3D imx_clk_hw_mux("ipu2_sel",         =
base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
=20
 	disable_anatop_clocks(anatop_base);
=20
 	imx6q_mmdc_ch1_mask_handshake(base);
=20
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_LDB_DI0_SEL]      =3D imx_clk_mux_flags("ldb_di0_sel", b=
ase + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_=
PARENT);
-		clk[IMX6QDL_CLK_LDB_DI1_SEL]      =3D imx_clk_mux_flags("ldb_di1_sel", b=
ase + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_=
PARENT);
+		hws[IMX6QDL_CLK_LDB_DI0_SEL]      =3D imx_clk_hw_mux_flags("ldb_di0_sel"=
, base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RA=
TE_PARENT);
+		hws[IMX6QDL_CLK_LDB_DI1_SEL]      =3D imx_clk_hw_mux_flags("ldb_di1_sel"=
, base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RA=
TE_PARENT);
 	} else {
 		/*
 		 * The LDB_DI0/1_SEL muxes are registered read-only due to a hardware
@@ -656,322 +670,333 @@ static void __init imx6q_clocks_init(struct device_=
node *ccm_node)
 		 */
 		init_ldb_clks(np, base);
=20
-		clk[IMX6QDL_CLK_LDB_DI0_SEL]      =3D imx_clk_mux_ldb("ldb_di0_sel", bas=
e + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
-		clk[IMX6QDL_CLK_LDB_DI1_SEL]      =3D imx_clk_mux_ldb("ldb_di1_sel", bas=
e + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
+		hws[IMX6QDL_CLK_LDB_DI0_SEL]      =3D imx_clk_hw_mux_ldb("ldb_di0_sel", =
base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
+		hws[IMX6QDL_CLK_LDB_DI1_SEL]      =3D imx_clk_hw_mux_ldb("ldb_di1_sel", =
base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
 	}
-	clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL] =3D imx_clk_mux_flags("ipu1_di0_pre_sel=
", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_=
SET_RATE_PARENT);
-	clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL] =3D imx_clk_mux_flags("ipu1_di1_pre_sel=
", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_=
SET_RATE_PARENT);
-	clk[IMX6QDL_CLK_IPU2_DI0_PRE_SEL] =3D imx_clk_mux_flags("ipu2_di0_pre_sel=
", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_=
SET_RATE_PARENT);
-	clk[IMX6QDL_CLK_IPU2_DI1_PRE_SEL] =3D imx_clk_mux_flags("ipu2_di1_pre_sel=
", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), CLK_=
SET_RATE_PARENT);
-	clk[IMX6QDL_CLK_HSI_TX_SEL]       =3D imx_clk_mux("hsi_tx_sel",       bas=
e + 0x30, 28, 1, hsi_tx_sels,       ARRAY_SIZE(hsi_tx_sels));
-	clk[IMX6QDL_CLK_PCIE_AXI_SEL]     =3D imx_clk_mux("pcie_axi_sel",     bas=
e + 0x18, 10, 1, pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
+
+	hws[IMX6QDL_CLK_IPU1_DI0_PRE_SEL] =3D imx_clk_hw_mux_flags("ipu1_di0_pre_=
sel", base + 0x34, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6QDL_CLK_IPU1_DI1_PRE_SEL] =3D imx_clk_hw_mux_flags("ipu1_di1_pre_=
sel", base + 0x34, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6QDL_CLK_IPU2_DI0_PRE_SEL] =3D imx_clk_hw_mux_flags("ipu2_di0_pre_=
sel", base + 0x38, 6,  3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6QDL_CLK_IPU2_DI1_PRE_SEL] =3D imx_clk_hw_mux_flags("ipu2_di1_pre_=
sel", base + 0x38, 15, 3, ipu_di_pre_sels,   ARRAY_SIZE(ipu_di_pre_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX6QDL_CLK_HSI_TX_SEL]       =3D imx_clk_hw_mux("hsi_tx_sel",       =
base + 0x30, 28, 1, hsi_tx_sels,       ARRAY_SIZE(hsi_tx_sels));
+	hws[IMX6QDL_CLK_PCIE_AXI_SEL]     =3D imx_clk_hw_mux("pcie_axi_sel",     =
base + 0x18, 10, 1, pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
+
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_IPU1_DI0_SEL]     =3D imx_clk_mux_flags("ipu1_di0_sel", =
    base + 0x34, 0,  3, ipu1_di0_sels_2,     ARRAY_SIZE(ipu1_di0_sels_2), C=
LK_SET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU1_DI1_SEL]     =3D imx_clk_mux_flags("ipu1_di1_sel", =
    base + 0x34, 9,  3, ipu1_di1_sels_2,     ARRAY_SIZE(ipu1_di1_sels_2), C=
LK_SET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU2_DI0_SEL]     =3D imx_clk_mux_flags("ipu2_di0_sel", =
    base + 0x38, 0,  3, ipu2_di0_sels_2,     ARRAY_SIZE(ipu2_di0_sels_2), C=
LK_SET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU2_DI1_SEL]     =3D imx_clk_mux_flags("ipu2_di1_sel", =
    base + 0x38, 9,  3, ipu2_di1_sels_2,     ARRAY_SIZE(ipu2_di1_sels_2), C=
LK_SET_RATE_PARENT);
-		clk[IMX6QDL_CLK_SSI1_SEL]         =3D imx_clk_mux("ssi1_sel",   base + 0=
x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
-		clk[IMX6QDL_CLK_SSI2_SEL]         =3D imx_clk_mux("ssi2_sel",   base + 0=
x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
-		clk[IMX6QDL_CLK_SSI3_SEL]         =3D imx_clk_mux("ssi3_sel",   base + 0=
x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
-		clk[IMX6QDL_CLK_USDHC1_SEL]       =3D imx_clk_mux("usdhc1_sel", base + 0=
x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-		clk[IMX6QDL_CLK_USDHC2_SEL]       =3D imx_clk_mux("usdhc2_sel", base + 0=
x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-		clk[IMX6QDL_CLK_USDHC3_SEL]       =3D imx_clk_mux("usdhc3_sel", base + 0=
x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-		clk[IMX6QDL_CLK_USDHC4_SEL]       =3D imx_clk_mux("usdhc4_sel", base + 0=
x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
-		clk[IMX6QDL_CLK_ENFC_SEL]         =3D imx_clk_mux("enfc_sel",         ba=
se + 0x2c, 15, 3, enfc_sels_2,         ARRAY_SIZE(enfc_sels_2));
-		clk[IMX6QDL_CLK_EIM_SEL]          =3D imx_clk_mux("eim_sel",      base +=
 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels));
-		clk[IMX6QDL_CLK_EIM_SLOW_SEL]     =3D imx_clk_mux("eim_slow_sel", base +=
 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels));
-		clk[IMX6QDL_CLK_PRE_AXI]	  =3D imx_clk_mux("pre_axi",	base + 0x18, 1,  1=
, pre_axi_sels,    ARRAY_SIZE(pre_axi_sels));
+		hws[IMX6QDL_CLK_IPU1_DI0_SEL]     =3D imx_clk_hw_mux_flags("ipu1_di0_sel=
",     base + 0x34, 0,  3, ipu1_di0_sels_2,     ARRAY_SIZE(ipu1_di0_sels_2)=
, CLK_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU1_DI1_SEL]     =3D imx_clk_hw_mux_flags("ipu1_di1_sel=
",     base + 0x34, 9,  3, ipu1_di1_sels_2,     ARRAY_SIZE(ipu1_di1_sels_2)=
, CLK_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU2_DI0_SEL]     =3D imx_clk_hw_mux_flags("ipu2_di0_sel=
",     base + 0x38, 0,  3, ipu2_di0_sels_2,     ARRAY_SIZE(ipu2_di0_sels_2)=
, CLK_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU2_DI1_SEL]     =3D imx_clk_hw_mux_flags("ipu2_di1_sel=
",     base + 0x38, 9,  3, ipu2_di1_sels_2,     ARRAY_SIZE(ipu2_di1_sels_2)=
, CLK_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_SSI1_SEL]         =3D imx_clk_hw_mux("ssi1_sel",   base =
+ 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
+		hws[IMX6QDL_CLK_SSI2_SEL]         =3D imx_clk_hw_mux("ssi2_sel",   base =
+ 0x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
+		hws[IMX6QDL_CLK_SSI3_SEL]         =3D imx_clk_hw_mux("ssi3_sel",   base =
+ 0x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels));
+		hws[IMX6QDL_CLK_USDHC1_SEL]       =3D imx_clk_hw_mux("usdhc1_sel", base =
+ 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+		hws[IMX6QDL_CLK_USDHC2_SEL]       =3D imx_clk_hw_mux("usdhc2_sel", base =
+ 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+		hws[IMX6QDL_CLK_USDHC3_SEL]       =3D imx_clk_hw_mux("usdhc3_sel", base =
+ 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+		hws[IMX6QDL_CLK_USDHC4_SEL]       =3D imx_clk_hw_mux("usdhc4_sel", base =
+ 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels));
+		hws[IMX6QDL_CLK_ENFC_SEL]         =3D imx_clk_hw_mux("enfc_sel",        =
 base + 0x2c, 15, 3, enfc_sels_2,         ARRAY_SIZE(enfc_sels_2));
+		hws[IMX6QDL_CLK_EIM_SEL]          =3D imx_clk_hw_mux("eim_sel",      bas=
e + 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels));
+		hws[IMX6QDL_CLK_EIM_SLOW_SEL]     =3D imx_clk_hw_mux("eim_slow_sel", bas=
e + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels));
+		hws[IMX6QDL_CLK_PRE_AXI]	  =3D imx_clk_hw_mux("pre_axi",	base + 0x18, 1,=
  1, pre_axi_sels,    ARRAY_SIZE(pre_axi_sels));
 	} else {
-		clk[IMX6QDL_CLK_IPU1_DI0_SEL]     =3D imx_clk_mux_flags("ipu1_di0_sel", =
    base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels), CLK_S=
ET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU1_DI1_SEL]     =3D imx_clk_mux_flags("ipu1_di1_sel", =
    base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels), CLK_S=
ET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU2_DI0_SEL]     =3D imx_clk_mux_flags("ipu2_di0_sel", =
    base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels), CLK_S=
ET_RATE_PARENT);
-		clk[IMX6QDL_CLK_IPU2_DI1_SEL]     =3D imx_clk_mux_flags("ipu2_di1_sel", =
    base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels), CLK_S=
ET_RATE_PARENT);
-		clk[IMX6QDL_CLK_SSI1_SEL]         =3D imx_clk_fixup_mux("ssi1_sel",   ba=
se + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fixup=
);
-		clk[IMX6QDL_CLK_SSI2_SEL]         =3D imx_clk_fixup_mux("ssi2_sel",   ba=
se + 0x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fixup=
);
-		clk[IMX6QDL_CLK_SSI3_SEL]         =3D imx_clk_fixup_mux("ssi3_sel",   ba=
se + 0x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fixup=
);
-		clk[IMX6QDL_CLK_USDHC1_SEL]       =3D imx_clk_fixup_mux("usdhc1_sel", ba=
se + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fix=
up);
-		clk[IMX6QDL_CLK_USDHC2_SEL]       =3D imx_clk_fixup_mux("usdhc2_sel", ba=
se + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fix=
up);
-		clk[IMX6QDL_CLK_USDHC3_SEL]       =3D imx_clk_fixup_mux("usdhc3_sel", ba=
se + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fix=
up);
-		clk[IMX6QDL_CLK_USDHC4_SEL]       =3D imx_clk_fixup_mux("usdhc4_sel", ba=
se + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_fix=
up);
-		clk[IMX6QDL_CLK_ENFC_SEL]         =3D imx_clk_mux("enfc_sel",         ba=
se + 0x2c, 16, 2, enfc_sels,         ARRAY_SIZE(enfc_sels));
-		clk[IMX6QDL_CLK_EIM_SEL]          =3D imx_clk_fixup_mux("eim_sel",      =
base + 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels), imx_cscmr1_fixup=
);
-		clk[IMX6QDL_CLK_EIM_SLOW_SEL]     =3D imx_clk_fixup_mux("eim_slow_sel", =
base + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels), imx_cscmr1_=
fixup);
+		hws[IMX6QDL_CLK_IPU1_DI0_SEL]     =3D imx_clk_hw_mux_flags("ipu1_di0_sel=
",     base + 0x34, 0,  3, ipu1_di0_sels,     ARRAY_SIZE(ipu1_di0_sels), CL=
K_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU1_DI1_SEL]     =3D imx_clk_hw_mux_flags("ipu1_di1_sel=
",     base + 0x34, 9,  3, ipu1_di1_sels,     ARRAY_SIZE(ipu1_di1_sels), CL=
K_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU2_DI0_SEL]     =3D imx_clk_hw_mux_flags("ipu2_di0_sel=
",     base + 0x38, 0,  3, ipu2_di0_sels,     ARRAY_SIZE(ipu2_di0_sels), CL=
K_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_IPU2_DI1_SEL]     =3D imx_clk_hw_mux_flags("ipu2_di1_sel=
",     base + 0x38, 9,  3, ipu2_di1_sels,     ARRAY_SIZE(ipu2_di1_sels), CL=
K_SET_RATE_PARENT);
+		hws[IMX6QDL_CLK_SSI1_SEL]         =3D imx_clk_hw_fixup_mux("ssi1_sel",  =
 base + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fi=
xup);
+		hws[IMX6QDL_CLK_SSI2_SEL]         =3D imx_clk_hw_fixup_mux("ssi2_sel",  =
 base + 0x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fi=
xup);
+		hws[IMX6QDL_CLK_SSI3_SEL]         =3D imx_clk_hw_fixup_mux("ssi3_sel",  =
 base + 0x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels), imx_cscmr1_fi=
xup);
+		hws[IMX6QDL_CLK_USDHC1_SEL]       =3D imx_clk_hw_fixup_mux("usdhc1_sel",=
 base + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_=
fixup);
+		hws[IMX6QDL_CLK_USDHC2_SEL]       =3D imx_clk_hw_fixup_mux("usdhc2_sel",=
 base + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_=
fixup);
+		hws[IMX6QDL_CLK_USDHC3_SEL]       =3D imx_clk_hw_fixup_mux("usdhc3_sel",=
 base + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_=
fixup);
+		hws[IMX6QDL_CLK_USDHC4_SEL]       =3D imx_clk_hw_fixup_mux("usdhc4_sel",=
 base + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels), imx_cscmr1_=
fixup);
+		hws[IMX6QDL_CLK_ENFC_SEL]         =3D imx_clk_hw_mux("enfc_sel",        =
 base + 0x2c, 16, 2, enfc_sels,         ARRAY_SIZE(enfc_sels));
+		hws[IMX6QDL_CLK_EIM_SEL]          =3D imx_clk_hw_fixup_mux("eim_sel",   =
   base + 0x1c, 27, 2, eim_sels,        ARRAY_SIZE(eim_sels), imx_cscmr1_fi=
xup);
+		hws[IMX6QDL_CLK_EIM_SLOW_SEL]     =3D imx_clk_hw_fixup_mux("eim_slow_sel=
", base + 0x1c, 29, 2, eim_slow_sels,   ARRAY_SIZE(eim_slow_sels), imx_cscm=
r1_fixup);
 	}
-	clk[IMX6QDL_CLK_VDO_AXI_SEL]      =3D imx_clk_mux("vdo_axi_sel",      bas=
e + 0x18, 11, 1, vdo_axi_sels,      ARRAY_SIZE(vdo_axi_sels));
-	clk[IMX6QDL_CLK_VPU_AXI_SEL]      =3D imx_clk_mux("vpu_axi_sel",      bas=
e + 0x18, 14, 2, vpu_axi_sels,      ARRAY_SIZE(vpu_axi_sels));
-	clk[IMX6QDL_CLK_CKO1_SEL]         =3D imx_clk_mux("cko1_sel",         bas=
e + 0x60, 0,  4, cko1_sels,         ARRAY_SIZE(cko1_sels));
-	clk[IMX6QDL_CLK_CKO2_SEL]         =3D imx_clk_mux("cko2_sel",         bas=
e + 0x60, 16, 5, cko2_sels,         ARRAY_SIZE(cko2_sels));
-	clk[IMX6QDL_CLK_CKO]              =3D imx_clk_mux("cko",              bas=
e + 0x60, 8, 1,  cko_sels,          ARRAY_SIZE(cko_sels));
+
+	hws[IMX6QDL_CLK_VDO_AXI_SEL]      =3D imx_clk_hw_mux("vdo_axi_sel",      =
base + 0x18, 11, 1, vdo_axi_sels,      ARRAY_SIZE(vdo_axi_sels));
+	hws[IMX6QDL_CLK_VPU_AXI_SEL]      =3D imx_clk_hw_mux("vpu_axi_sel",      =
base + 0x18, 14, 2, vpu_axi_sels,      ARRAY_SIZE(vpu_axi_sels));
+	hws[IMX6QDL_CLK_CKO1_SEL]         =3D imx_clk_hw_mux("cko1_sel",         =
base + 0x60, 0,  4, cko1_sels,         ARRAY_SIZE(cko1_sels));
+	hws[IMX6QDL_CLK_CKO2_SEL]         =3D imx_clk_hw_mux("cko2_sel",         =
base + 0x60, 16, 5, cko2_sels,         ARRAY_SIZE(cko2_sels));
+	hws[IMX6QDL_CLK_CKO]              =3D imx_clk_hw_mux("cko",              =
base + 0x60, 8, 1,  cko_sels,          ARRAY_SIZE(cko_sels));
=20
 	/*                                          name         reg      shift w=
idth busy: reg, shift parent_names  num_parents */
-	clk[IMX6QDL_CLK_PERIPH]  =3D imx_clk_busy_mux("periph",  base + 0x14, 25,=
  1,   base + 0x48, 5,  periph_sels,  ARRAY_SIZE(periph_sels));
-	clk[IMX6QDL_CLK_PERIPH2] =3D imx_clk_busy_mux("periph2", base + 0x14, 26,=
  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
+	hws[IMX6QDL_CLK_PERIPH]  =3D imx_clk_hw_busy_mux("periph",  base + 0x14, =
25,  1,   base + 0x48, 5,  periph_sels,  ARRAY_SIZE(periph_sels));
+	hws[IMX6QDL_CLK_PERIPH2] =3D imx_clk_hw_busy_mux("periph2", base + 0x14, =
26,  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
=20
 	/*                                                  name                p=
arent_name          reg       shift width */
-	clk[IMX6QDL_CLK_PERIPH_CLK2]      =3D imx_clk_divider("periph_clk2",     =
 "periph_clk2_sel",   base + 0x14, 27, 3);
-	clk[IMX6QDL_CLK_PERIPH2_CLK2]     =3D imx_clk_divider("periph2_clk2",    =
 "periph2_clk2_sel",  base + 0x14, 0,  3);
-	clk[IMX6QDL_CLK_IPG]              =3D imx_clk_divider("ipg",             =
 "ahb",               base + 0x14, 8,  2);
-	clk[IMX6QDL_CLK_ESAI_PRED]        =3D imx_clk_divider("esai_pred",       =
 "esai_sel",          base + 0x28, 9,  3);
-	clk[IMX6QDL_CLK_ESAI_PODF]        =3D imx_clk_divider("esai_podf",       =
 "esai_pred",         base + 0x28, 25, 3);
-	clk[IMX6QDL_CLK_ASRC_PRED]        =3D imx_clk_divider("asrc_pred",       =
 "asrc_sel",          base + 0x30, 12, 3);
-	clk[IMX6QDL_CLK_ASRC_PODF]        =3D imx_clk_divider("asrc_podf",       =
 "asrc_pred",         base + 0x30, 9,  3);
-	clk[IMX6QDL_CLK_SPDIF_PRED]       =3D imx_clk_divider("spdif_pred",      =
 "spdif_sel",         base + 0x30, 25, 3);
-	clk[IMX6QDL_CLK_SPDIF_PODF]       =3D imx_clk_divider("spdif_podf",      =
 "spdif_pred",        base + 0x30, 22, 3);
+	hws[IMX6QDL_CLK_PERIPH_CLK2]      =3D imx_clk_hw_divider("periph_clk2",  =
    "periph_clk2_sel",   base + 0x14, 27, 3);
+	hws[IMX6QDL_CLK_PERIPH2_CLK2]     =3D imx_clk_hw_divider("periph2_clk2", =
    "periph2_clk2_sel",  base + 0x14, 0,  3);
+	hws[IMX6QDL_CLK_IPG]              =3D imx_clk_hw_divider("ipg",          =
    "ahb",               base + 0x14, 8,  2);
+	hws[IMX6QDL_CLK_ESAI_PRED]        =3D imx_clk_hw_divider("esai_pred",    =
    "esai_sel",          base + 0x28, 9,  3);
+	hws[IMX6QDL_CLK_ESAI_PODF]        =3D imx_clk_hw_divider("esai_podf",    =
    "esai_pred",         base + 0x28, 25, 3);
+	hws[IMX6QDL_CLK_ASRC_PRED]        =3D imx_clk_hw_divider("asrc_pred",    =
    "asrc_sel",          base + 0x30, 12, 3);
+	hws[IMX6QDL_CLK_ASRC_PODF]        =3D imx_clk_hw_divider("asrc_podf",    =
    "asrc_pred",         base + 0x30, 9,  3);
+	hws[IMX6QDL_CLK_SPDIF_PRED]       =3D imx_clk_hw_divider("spdif_pred",   =
    "spdif_sel",         base + 0x30, 25, 3);
+	hws[IMX6QDL_CLK_SPDIF_PODF]       =3D imx_clk_hw_divider("spdif_podf",   =
    "spdif_pred",        base + 0x30, 22, 3);
+
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_IPG_PER] =3D imx_clk_divider("ipg_per", "ipg_per_sel", b=
ase + 0x1c, 0, 6);
-		clk[IMX6QDL_CLK_ECSPI_ROOT] =3D imx_clk_divider("ecspi_root", "ecspi_sel=
", base + 0x38, 19, 6);
-		clk[IMX6QDL_CLK_CAN_ROOT] =3D imx_clk_divider("can_root", "can_sel", bas=
e + 0x20, 2, 6);
-		clk[IMX6QDL_CLK_UART_SERIAL_PODF] =3D imx_clk_divider("uart_serial_podf"=
, "uart_sel", base + 0x24, 0, 6);
-		clk[IMX6QDL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di0_div_3=
_5", "ldb_di0", 2, 7);
-		clk[IMX6QDL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di1_div_3=
_5", "ldb_di1", 2, 7);
+		hws[IMX6QDL_CLK_IPG_PER] =3D imx_clk_hw_divider("ipg_per", "ipg_per_sel"=
, base + 0x1c, 0, 6);
+		hws[IMX6QDL_CLK_ECSPI_ROOT] =3D imx_clk_hw_divider("ecspi_root", "ecspi_=
sel", base + 0x38, 19, 6);
+		hws[IMX6QDL_CLK_CAN_ROOT] =3D imx_clk_hw_divider("can_root", "can_sel", =
base + 0x20, 2, 6);
+		hws[IMX6QDL_CLK_UART_SERIAL_PODF] =3D imx_clk_hw_divider("uart_serial_po=
df", "uart_sel", base + 0x24, 0, 6);
+		hws[IMX6QDL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di0_di=
v_3_5", "ldb_di0", 2, 7);
+		hws[IMX6QDL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di1_di=
v_3_5", "ldb_di1", 2, 7);
 	} else {
-		clk[IMX6QDL_CLK_ECSPI_ROOT] =3D imx_clk_divider("ecspi_root", "pll3_60m"=
, base + 0x38, 19, 6);
-		clk[IMX6QDL_CLK_CAN_ROOT] =3D imx_clk_divider("can_root", "pll3_60m", ba=
se + 0x20, 2, 6);
-		clk[IMX6QDL_CLK_IPG_PER] =3D imx_clk_fixup_divider("ipg_per", "ipg", bas=
e + 0x1c, 0, 6, imx_cscmr1_fixup);
-		clk[IMX6QDL_CLK_UART_SERIAL_PODF] =3D imx_clk_divider("uart_serial_podf"=
, "pll3_80m",          base + 0x24, 0,  6);
-		clk[IMX6QDL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di0_div_3=
_5", "ldb_di0_sel", 2, 7);
-		clk[IMX6QDL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_fixed_factor("ldb_di1_div_3=
_5", "ldb_di1_sel", 2, 7);
+		hws[IMX6QDL_CLK_ECSPI_ROOT] =3D imx_clk_hw_divider("ecspi_root", "pll3_6=
0m", base + 0x38, 19, 6);
+		hws[IMX6QDL_CLK_CAN_ROOT] =3D imx_clk_hw_divider("can_root", "pll3_60m",=
 base + 0x20, 2, 6);
+		hws[IMX6QDL_CLK_IPG_PER] =3D imx_clk_hw_fixup_divider("ipg_per", "ipg", =
base + 0x1c, 0, 6, imx_cscmr1_fixup);
+		hws[IMX6QDL_CLK_UART_SERIAL_PODF] =3D imx_clk_hw_divider("uart_serial_po=
df", "pll3_80m",          base + 0x24, 0,  6);
+		hws[IMX6QDL_CLK_LDB_DI0_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di0_di=
v_3_5", "ldb_di0_sel", 2, 7);
+		hws[IMX6QDL_CLK_LDB_DI1_DIV_3_5] =3D imx_clk_hw_fixed_factor("ldb_di1_di=
v_3_5", "ldb_di1_sel", 2, 7);
 	}
+
 	if (clk_on_imx6dl())
-		clk[IMX6QDL_CLK_MLB_PODF]  =3D imx_clk_divider("mlb_podf",  "mlb_sel",  =
  base + 0x18, 23, 3);
+		hws[IMX6QDL_CLK_MLB_PODF]  =3D imx_clk_hw_divider("mlb_podf",  "mlb_sel"=
,    base + 0x18, 23, 3);
 	else
-		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  =3D imx_clk_divider("gpu2d_core_podf",=
  "gpu2d_core_sel",    base + 0x18, 23, 3);
-	clk[IMX6QDL_CLK_GPU3D_CORE_PODF]  =3D imx_clk_divider("gpu3d_core_podf", =
 "gpu3d_core_sel",    base + 0x18, 26, 3);
+		hws[IMX6QDL_CLK_GPU2D_CORE_PODF]  =3D imx_clk_hw_divider("gpu2d_core_pod=
f",  "gpu2d_core_sel",    base + 0x18, 23, 3);
+	hws[IMX6QDL_CLK_GPU3D_CORE_PODF]  =3D imx_clk_hw_divider("gpu3d_core_podf=
",  "gpu3d_core_sel",    base + 0x18, 26, 3);
 	if (clk_on_imx6dl())
-		clk[IMX6QDL_CLK_GPU2D_CORE_PODF]  =3D imx_clk_divider("gpu2d_core_podf",=
     "gpu2d_core_sel",  base + 0x18, 29, 3);
+		hws[IMX6QDL_CLK_GPU2D_CORE_PODF]  =3D imx_clk_hw_divider("gpu2d_core_pod=
f",     "gpu2d_core_sel",  base + 0x18, 29, 3);
 	else
-		clk[IMX6QDL_CLK_GPU3D_SHADER]     =3D imx_clk_divider("gpu3d_shader",   =
  "gpu3d_shader_sel",  base + 0x18, 29, 3);
-	clk[IMX6QDL_CLK_IPU1_PODF]        =3D imx_clk_divider("ipu1_podf",       =
 "ipu1_sel",          base + 0x3c, 11, 3);
-	clk[IMX6QDL_CLK_IPU2_PODF]        =3D imx_clk_divider("ipu2_podf",       =
 "ipu2_sel",          base + 0x3c, 16, 3);
-	clk[IMX6QDL_CLK_LDB_DI0_PODF]     =3D imx_clk_divider_flags("ldb_di0_podf=
", "ldb_di0_div_3_5", base + 0x20, 10, 1, 0);
-	clk[IMX6QDL_CLK_LDB_DI1_PODF]     =3D imx_clk_divider_flags("ldb_di1_podf=
", "ldb_di1_div_3_5", base + 0x20, 11, 1, 0);
-	clk[IMX6QDL_CLK_IPU1_DI0_PRE]     =3D imx_clk_divider("ipu1_di0_pre",    =
 "ipu1_di0_pre_sel",  base + 0x34, 3,  3);
-	clk[IMX6QDL_CLK_IPU1_DI1_PRE]     =3D imx_clk_divider("ipu1_di1_pre",    =
 "ipu1_di1_pre_sel",  base + 0x34, 12, 3);
-	clk[IMX6QDL_CLK_IPU2_DI0_PRE]     =3D imx_clk_divider("ipu2_di0_pre",    =
 "ipu2_di0_pre_sel",  base + 0x38, 3,  3);
-	clk[IMX6QDL_CLK_IPU2_DI1_PRE]     =3D imx_clk_divider("ipu2_di1_pre",    =
 "ipu2_di1_pre_sel",  base + 0x38, 12, 3);
-	clk[IMX6QDL_CLK_HSI_TX_PODF]      =3D imx_clk_divider("hsi_tx_podf",     =
 "hsi_tx_sel",        base + 0x30, 29, 3);
-	clk[IMX6QDL_CLK_SSI1_PRED]        =3D imx_clk_divider("ssi1_pred",       =
 "ssi1_sel",          base + 0x28, 6,  3);
-	clk[IMX6QDL_CLK_SSI1_PODF]        =3D imx_clk_divider("ssi1_podf",       =
 "ssi1_pred",         base + 0x28, 0,  6);
-	clk[IMX6QDL_CLK_SSI2_PRED]        =3D imx_clk_divider("ssi2_pred",       =
 "ssi2_sel",          base + 0x2c, 6,  3);
-	clk[IMX6QDL_CLK_SSI2_PODF]        =3D imx_clk_divider("ssi2_podf",       =
 "ssi2_pred",         base + 0x2c, 0,  6);
-	clk[IMX6QDL_CLK_SSI3_PRED]        =3D imx_clk_divider("ssi3_pred",       =
 "ssi3_sel",          base + 0x28, 22, 3);
-	clk[IMX6QDL_CLK_SSI3_PODF]        =3D imx_clk_divider("ssi3_podf",       =
 "ssi3_pred",         base + 0x28, 16, 6);
-	clk[IMX6QDL_CLK_USDHC1_PODF]      =3D imx_clk_divider("usdhc1_podf",     =
 "usdhc1_sel",        base + 0x24, 11, 3);
-	clk[IMX6QDL_CLK_USDHC2_PODF]      =3D imx_clk_divider("usdhc2_podf",     =
 "usdhc2_sel",        base + 0x24, 16, 3);
-	clk[IMX6QDL_CLK_USDHC3_PODF]      =3D imx_clk_divider("usdhc3_podf",     =
 "usdhc3_sel",        base + 0x24, 19, 3);
-	clk[IMX6QDL_CLK_USDHC4_PODF]      =3D imx_clk_divider("usdhc4_podf",     =
 "usdhc4_sel",        base + 0x24, 22, 3);
-	clk[IMX6QDL_CLK_ENFC_PRED]        =3D imx_clk_divider("enfc_pred",       =
 "enfc_sel",          base + 0x2c, 18, 3);
-	clk[IMX6QDL_CLK_ENFC_PODF]        =3D imx_clk_divider("enfc_podf",       =
 "enfc_pred",         base + 0x2c, 21, 6);
+		hws[IMX6QDL_CLK_GPU3D_SHADER]     =3D imx_clk_hw_divider("gpu3d_shader",=
     "gpu3d_shader_sel",  base + 0x18, 29, 3);
+	hws[IMX6QDL_CLK_IPU1_PODF]        =3D imx_clk_hw_divider("ipu1_podf",    =
    "ipu1_sel",          base + 0x3c, 11, 3);
+	hws[IMX6QDL_CLK_IPU2_PODF]        =3D imx_clk_hw_divider("ipu2_podf",    =
    "ipu2_sel",          base + 0x3c, 16, 3);
+	hws[IMX6QDL_CLK_LDB_DI0_PODF]     =3D imx_clk_hw_divider_flags("ldb_di0_p=
odf", "ldb_di0_div_3_5", base + 0x20, 10, 1, 0);
+	hws[IMX6QDL_CLK_LDB_DI1_PODF]     =3D imx_clk_hw_divider_flags("ldb_di1_p=
odf", "ldb_di1_div_3_5", base + 0x20, 11, 1, 0);
+	hws[IMX6QDL_CLK_IPU1_DI0_PRE]     =3D imx_clk_hw_divider("ipu1_di0_pre", =
    "ipu1_di0_pre_sel",  base + 0x34, 3,  3);
+	hws[IMX6QDL_CLK_IPU1_DI1_PRE]     =3D imx_clk_hw_divider("ipu1_di1_pre", =
    "ipu1_di1_pre_sel",  base + 0x34, 12, 3);
+	hws[IMX6QDL_CLK_IPU2_DI0_PRE]     =3D imx_clk_hw_divider("ipu2_di0_pre", =
    "ipu2_di0_pre_sel",  base + 0x38, 3,  3);
+	hws[IMX6QDL_CLK_IPU2_DI1_PRE]     =3D imx_clk_hw_divider("ipu2_di1_pre", =
    "ipu2_di1_pre_sel",  base + 0x38, 12, 3);
+	hws[IMX6QDL_CLK_HSI_TX_PODF]      =3D imx_clk_hw_divider("hsi_tx_podf",  =
    "hsi_tx_sel",        base + 0x30, 29, 3);
+	hws[IMX6QDL_CLK_SSI1_PRED]        =3D imx_clk_hw_divider("ssi1_pred",    =
    "ssi1_sel",          base + 0x28, 6,  3);
+	hws[IMX6QDL_CLK_SSI1_PODF]        =3D imx_clk_hw_divider("ssi1_podf",    =
    "ssi1_pred",         base + 0x28, 0,  6);
+	hws[IMX6QDL_CLK_SSI2_PRED]        =3D imx_clk_hw_divider("ssi2_pred",    =
    "ssi2_sel",          base + 0x2c, 6,  3);
+	hws[IMX6QDL_CLK_SSI2_PODF]        =3D imx_clk_hw_divider("ssi2_podf",    =
    "ssi2_pred",         base + 0x2c, 0,  6);
+	hws[IMX6QDL_CLK_SSI3_PRED]        =3D imx_clk_hw_divider("ssi3_pred",    =
    "ssi3_sel",          base + 0x28, 22, 3);
+	hws[IMX6QDL_CLK_SSI3_PODF]        =3D imx_clk_hw_divider("ssi3_podf",    =
    "ssi3_pred",         base + 0x28, 16, 6);
+	hws[IMX6QDL_CLK_USDHC1_PODF]      =3D imx_clk_hw_divider("usdhc1_podf",  =
    "usdhc1_sel",        base + 0x24, 11, 3);
+	hws[IMX6QDL_CLK_USDHC2_PODF]      =3D imx_clk_hw_divider("usdhc2_podf",  =
    "usdhc2_sel",        base + 0x24, 16, 3);
+	hws[IMX6QDL_CLK_USDHC3_PODF]      =3D imx_clk_hw_divider("usdhc3_podf",  =
    "usdhc3_sel",        base + 0x24, 19, 3);
+	hws[IMX6QDL_CLK_USDHC4_PODF]      =3D imx_clk_hw_divider("usdhc4_podf",  =
    "usdhc4_sel",        base + 0x24, 22, 3);
+	hws[IMX6QDL_CLK_ENFC_PRED]        =3D imx_clk_hw_divider("enfc_pred",    =
    "enfc_sel",          base + 0x2c, 18, 3);
+	hws[IMX6QDL_CLK_ENFC_PODF]        =3D imx_clk_hw_divider("enfc_podf",    =
    "enfc_pred",         base + 0x2c, 21, 6);
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_EIM_PODF]         =3D imx_clk_divider("eim_podf",   "eim=
_sel",           base + 0x1c, 20, 3);
-		clk[IMX6QDL_CLK_EIM_SLOW_PODF]    =3D imx_clk_divider("eim_slow_podf", "=
eim_slow_sel",   base + 0x1c, 23, 3);
+		hws[IMX6QDL_CLK_EIM_PODF]         =3D imx_clk_hw_divider("eim_podf",   "=
eim_sel",           base + 0x1c, 20, 3);
+		hws[IMX6QDL_CLK_EIM_SLOW_PODF]    =3D imx_clk_hw_divider("eim_slow_podf"=
, "eim_slow_sel",   base + 0x1c, 23, 3);
 	} else {
-		clk[IMX6QDL_CLK_EIM_PODF]         =3D imx_clk_fixup_divider("eim_podf", =
  "eim_sel",           base + 0x1c, 20, 3, imx_cscmr1_fixup);
-		clk[IMX6QDL_CLK_EIM_SLOW_PODF]    =3D imx_clk_fixup_divider("eim_slow_po=
df", "eim_slow_sel",   base + 0x1c, 23, 3, imx_cscmr1_fixup);
+		hws[IMX6QDL_CLK_EIM_PODF]         =3D imx_clk_hw_fixup_divider("eim_podf=
",   "eim_sel",           base + 0x1c, 20, 3, imx_cscmr1_fixup);
+		hws[IMX6QDL_CLK_EIM_SLOW_PODF]    =3D imx_clk_hw_fixup_divider("eim_slow=
_podf", "eim_slow_sel",   base + 0x1c, 23, 3, imx_cscmr1_fixup);
 	}
-	clk[IMX6QDL_CLK_VPU_AXI_PODF]     =3D imx_clk_divider("vpu_axi_podf",    =
 "vpu_axi_sel",       base + 0x24, 25, 3);
-	clk[IMX6QDL_CLK_CKO1_PODF]        =3D imx_clk_divider("cko1_podf",       =
 "cko1_sel",          base + 0x60, 4,  3);
-	clk[IMX6QDL_CLK_CKO2_PODF]        =3D imx_clk_divider("cko2_podf",       =
 "cko2_sel",          base + 0x60, 21, 3);
+
+	hws[IMX6QDL_CLK_VPU_AXI_PODF]     =3D imx_clk_hw_divider("vpu_axi_podf", =
    "vpu_axi_sel",       base + 0x24, 25, 3);
+	hws[IMX6QDL_CLK_CKO1_PODF]        =3D imx_clk_hw_divider("cko1_podf",    =
    "cko1_sel",          base + 0x60, 4,  3);
+	hws[IMX6QDL_CLK_CKO2_PODF]        =3D imx_clk_hw_divider("cko2_podf",    =
    "cko2_sel",          base + 0x60, 21, 3);
=20
 	/*                                                        name           =
      parent_name    reg        shift width busy: reg, shift */
-	clk[IMX6QDL_CLK_AXI]               =3D imx_clk_busy_divider("axi",       =
        "axi_sel",     base + 0x14, 16,  3,   base + 0x48, 0);
-	clk[IMX6QDL_CLK_MMDC_CH0_AXI_PODF] =3D imx_clk_busy_divider("mmdc_ch0_axi=
_podf", "periph",      base + 0x14, 19,  3,   base + 0x48, 4);
+	hws[IMX6QDL_CLK_AXI]               =3D imx_clk_hw_busy_divider("axi",    =
           "axi_sel",     base + 0x14, 16,  3,   base + 0x48, 0);
+	hws[IMX6QDL_CLK_MMDC_CH0_AXI_PODF] =3D imx_clk_hw_busy_divider("mmdc_ch0_=
axi_podf", "periph",      base + 0x14, 19,  3,   base + 0x48, 4);
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_MMDC_CH1_AXI_CG] =3D imx_clk_gate("mmdc_ch1_axi_cg", "pe=
riph2", base + 0x4, 18);
-		clk[IMX6QDL_CLK_MMDC_CH1_AXI_PODF] =3D imx_clk_busy_divider("mmdc_ch1_ax=
i_podf", "mmdc_ch1_axi_cg", base + 0x14, 3, 3, base + 0x48, 2);
+		hws[IMX6QDL_CLK_MMDC_CH1_AXI_CG] =3D imx_clk_hw_gate("mmdc_ch1_axi_cg", =
"periph2", base + 0x4, 18);
+		hws[IMX6QDL_CLK_MMDC_CH1_AXI_PODF] =3D imx_clk_hw_busy_divider("mmdc_ch1=
_axi_podf", "mmdc_ch1_axi_cg", base + 0x14, 3, 3, base + 0x48, 2);
 	} else {
-		clk[IMX6QDL_CLK_MMDC_CH1_AXI_PODF] =3D imx_clk_busy_divider("mmdc_ch1_ax=
i_podf", "periph2",     base + 0x14, 3,   3,   base + 0x48, 2);
+		hws[IMX6QDL_CLK_MMDC_CH1_AXI_PODF] =3D imx_clk_hw_busy_divider("mmdc_ch1=
_axi_podf", "periph2",     base + 0x14, 3,   3,   base + 0x48, 2);
 	}
-	clk[IMX6QDL_CLK_ARM]               =3D imx_clk_busy_divider("arm",       =
        "pll1_sw",     base + 0x10, 0,   3,   base + 0x48, 16);
-	clk[IMX6QDL_CLK_AHB]               =3D imx_clk_busy_divider("ahb",       =
        "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
+	hws[IMX6QDL_CLK_ARM]               =3D imx_clk_hw_busy_divider("arm",    =
           "pll1_sw",     base + 0x10, 0,   3,   base + 0x48, 16);
+	hws[IMX6QDL_CLK_AHB]               =3D imx_clk_hw_busy_divider("ahb",    =
           "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
=20
 	/*                                            name             parent_nam=
e          reg         shift */
-	clk[IMX6QDL_CLK_APBH_DMA]     =3D imx_clk_gate2("apbh_dma",      "usdhc3"=
,            base + 0x68, 4);
-	clk[IMX6QDL_CLK_ASRC]         =3D imx_clk_gate2_shared("asrc",         "a=
src_podf",   base + 0x68, 6, &share_count_asrc);
-	clk[IMX6QDL_CLK_ASRC_IPG]     =3D imx_clk_gate2_shared("asrc_ipg",     "a=
hb",         base + 0x68, 6, &share_count_asrc);
-	clk[IMX6QDL_CLK_ASRC_MEM]     =3D imx_clk_gate2_shared("asrc_mem",     "a=
hb",         base + 0x68, 6, &share_count_asrc);
-	clk[IMX6QDL_CLK_CAAM_MEM]     =3D imx_clk_gate2("caam_mem",      "ahb",  =
             base + 0x68, 8);
-	clk[IMX6QDL_CLK_CAAM_ACLK]    =3D imx_clk_gate2("caam_aclk",     "ahb",  =
             base + 0x68, 10);
-	clk[IMX6QDL_CLK_CAAM_IPG]     =3D imx_clk_gate2("caam_ipg",      "ipg",  =
             base + 0x68, 12);
-	clk[IMX6QDL_CLK_CAN1_IPG]     =3D imx_clk_gate2("can1_ipg",      "ipg",  =
             base + 0x68, 14);
-	clk[IMX6QDL_CLK_CAN1_SERIAL]  =3D imx_clk_gate2("can1_serial",   "can_roo=
t",          base + 0x68, 16);
-	clk[IMX6QDL_CLK_CAN2_IPG]     =3D imx_clk_gate2("can2_ipg",      "ipg",  =
             base + 0x68, 18);
-	clk[IMX6QDL_CLK_CAN2_SERIAL]  =3D imx_clk_gate2("can2_serial",   "can_roo=
t",          base + 0x68, 20);
-	clk[IMX6QDL_CLK_DCIC1]        =3D imx_clk_gate2("dcic1",         "ipu1_po=
df",         base + 0x68, 24);
-	clk[IMX6QDL_CLK_DCIC2]        =3D imx_clk_gate2("dcic2",         "ipu2_po=
df",         base + 0x68, 26);
-	clk[IMX6QDL_CLK_ECSPI1]       =3D imx_clk_gate2("ecspi1",        "ecspi_r=
oot",        base + 0x6c, 0);
-	clk[IMX6QDL_CLK_ECSPI2]       =3D imx_clk_gate2("ecspi2",        "ecspi_r=
oot",        base + 0x6c, 2);
-	clk[IMX6QDL_CLK_ECSPI3]       =3D imx_clk_gate2("ecspi3",        "ecspi_r=
oot",        base + 0x6c, 4);
-	clk[IMX6QDL_CLK_ECSPI4]       =3D imx_clk_gate2("ecspi4",        "ecspi_r=
oot",        base + 0x6c, 6);
+	hws[IMX6QDL_CLK_APBH_DMA]     =3D imx_clk_hw_gate2("apbh_dma",      "usdh=
c3",            base + 0x68, 4);
+	hws[IMX6QDL_CLK_ASRC]         =3D imx_clk_hw_gate2_shared("asrc",        =
 "asrc_podf",   base + 0x68, 6, &share_count_asrc);
+	hws[IMX6QDL_CLK_ASRC_IPG]     =3D imx_clk_hw_gate2_shared("asrc_ipg",    =
 "ahb",         base + 0x68, 6, &share_count_asrc);
+	hws[IMX6QDL_CLK_ASRC_MEM]     =3D imx_clk_hw_gate2_shared("asrc_mem",    =
 "ahb",         base + 0x68, 6, &share_count_asrc);
+	hws[IMX6QDL_CLK_CAAM_MEM]     =3D imx_clk_hw_gate2("caam_mem",      "ahb"=
,               base + 0x68, 8);
+	hws[IMX6QDL_CLK_CAAM_ACLK]    =3D imx_clk_hw_gate2("caam_aclk",     "ahb"=
,               base + 0x68, 10);
+	hws[IMX6QDL_CLK_CAAM_IPG]     =3D imx_clk_hw_gate2("caam_ipg",      "ipg"=
,               base + 0x68, 12);
+	hws[IMX6QDL_CLK_CAN1_IPG]     =3D imx_clk_hw_gate2("can1_ipg",      "ipg"=
,               base + 0x68, 14);
+	hws[IMX6QDL_CLK_CAN1_SERIAL]  =3D imx_clk_hw_gate2("can1_serial",   "can_=
root",          base + 0x68, 16);
+	hws[IMX6QDL_CLK_CAN2_IPG]     =3D imx_clk_hw_gate2("can2_ipg",      "ipg"=
,               base + 0x68, 18);
+	hws[IMX6QDL_CLK_CAN2_SERIAL]  =3D imx_clk_hw_gate2("can2_serial",   "can_=
root",          base + 0x68, 20);
+	hws[IMX6QDL_CLK_DCIC1]        =3D imx_clk_hw_gate2("dcic1",         "ipu1=
_podf",         base + 0x68, 24);
+	hws[IMX6QDL_CLK_DCIC2]        =3D imx_clk_hw_gate2("dcic2",         "ipu2=
_podf",         base + 0x68, 26);
+	hws[IMX6QDL_CLK_ECSPI1]       =3D imx_clk_hw_gate2("ecspi1",        "ecsp=
i_root",        base + 0x6c, 0);
+	hws[IMX6QDL_CLK_ECSPI2]       =3D imx_clk_hw_gate2("ecspi2",        "ecsp=
i_root",        base + 0x6c, 2);
+	hws[IMX6QDL_CLK_ECSPI3]       =3D imx_clk_hw_gate2("ecspi3",        "ecsp=
i_root",        base + 0x6c, 4);
+	hws[IMX6QDL_CLK_ECSPI4]       =3D imx_clk_hw_gate2("ecspi4",        "ecsp=
i_root",        base + 0x6c, 6);
 	if (clk_on_imx6dl())
-		clk[IMX6DL_CLK_I2C4]  =3D imx_clk_gate2("i2c4",          "ipg_per",     =
      base + 0x6c, 8);
+		hws[IMX6DL_CLK_I2C4]  =3D imx_clk_hw_gate2("i2c4",          "ipg_per",  =
         base + 0x6c, 8);
 	else
-		clk[IMX6Q_CLK_ECSPI5] =3D imx_clk_gate2("ecspi5",        "ecspi_root",  =
      base + 0x6c, 8);
-	clk[IMX6QDL_CLK_ENET]         =3D imx_clk_gate2("enet",          "ipg",  =
             base + 0x6c, 10);
-	clk[IMX6QDL_CLK_EPIT1]        =3D imx_clk_gate2("epit1",         "ipg",  =
             base + 0x6c, 12);
-	clk[IMX6QDL_CLK_EPIT2]        =3D imx_clk_gate2("epit2",         "ipg",  =
             base + 0x6c, 14);
-	clk[IMX6QDL_CLK_ESAI_EXTAL]   =3D imx_clk_gate2_shared("esai_extal",   "e=
sai_podf",   base + 0x6c, 16, &share_count_esai);
-	clk[IMX6QDL_CLK_ESAI_IPG]     =3D imx_clk_gate2_shared("esai_ipg",   "ahb=
",           base + 0x6c, 16, &share_count_esai);
-	clk[IMX6QDL_CLK_ESAI_MEM]     =3D imx_clk_gate2_shared("esai_mem", "ahb",=
             base + 0x6c, 16, &share_count_esai);
-	clk[IMX6QDL_CLK_GPT_IPG]      =3D imx_clk_gate2("gpt_ipg",       "ipg",  =
             base + 0x6c, 20);
-	clk[IMX6QDL_CLK_GPT_IPG_PER]  =3D imx_clk_gate2("gpt_ipg_per",   "ipg_per=
",           base + 0x6c, 22);
-	clk[IMX6QDL_CLK_GPU2D_CORE] =3D imx_clk_gate2("gpu2d_core", "gpu2d_core_p=
odf", base + 0x6c, 24);
-	clk[IMX6QDL_CLK_GPU3D_CORE]   =3D imx_clk_gate2("gpu3d_core",    "gpu3d_c=
ore_podf",   base + 0x6c, 26);
-	clk[IMX6QDL_CLK_HDMI_IAHB]    =3D imx_clk_gate2("hdmi_iahb",     "ahb",  =
             base + 0x70, 0);
-	clk[IMX6QDL_CLK_HDMI_ISFR]    =3D imx_clk_gate2("hdmi_isfr",     "mipi_co=
re_cfg",     base + 0x70, 4);
-	clk[IMX6QDL_CLK_I2C1]         =3D imx_clk_gate2("i2c1",          "ipg_per=
",           base + 0x70, 6);
-	clk[IMX6QDL_CLK_I2C2]         =3D imx_clk_gate2("i2c2",          "ipg_per=
",           base + 0x70, 8);
-	clk[IMX6QDL_CLK_I2C3]         =3D imx_clk_gate2("i2c3",          "ipg_per=
",           base + 0x70, 10);
-	clk[IMX6QDL_CLK_IIM]          =3D imx_clk_gate2("iim",           "ipg",  =
             base + 0x70, 12);
-	clk[IMX6QDL_CLK_ENFC]         =3D imx_clk_gate2("enfc",          "enfc_po=
df",         base + 0x70, 14);
-	clk[IMX6QDL_CLK_VDOA]         =3D imx_clk_gate2("vdoa",          "vdo_axi=
",           base + 0x70, 26);
-	clk[IMX6QDL_CLK_IPU1]         =3D imx_clk_gate2("ipu1",          "ipu1_po=
df",         base + 0x74, 0);
-	clk[IMX6QDL_CLK_IPU1_DI0]     =3D imx_clk_gate2("ipu1_di0",      "ipu1_di=
0_sel",      base + 0x74, 2);
-	clk[IMX6QDL_CLK_IPU1_DI1]     =3D imx_clk_gate2("ipu1_di1",      "ipu1_di=
1_sel",      base + 0x74, 4);
-	clk[IMX6QDL_CLK_IPU2]         =3D imx_clk_gate2("ipu2",          "ipu2_po=
df",         base + 0x74, 6);
-	clk[IMX6QDL_CLK_IPU2_DI0]     =3D imx_clk_gate2("ipu2_di0",      "ipu2_di=
0_sel",      base + 0x74, 8);
+		hws[IMX6Q_CLK_ECSPI5] =3D imx_clk_hw_gate2("ecspi5",        "ecspi_root"=
,        base + 0x6c, 8);
+	hws[IMX6QDL_CLK_ENET]         =3D imx_clk_hw_gate2("enet",          "ipg"=
,               base + 0x6c, 10);
+	hws[IMX6QDL_CLK_EPIT1]        =3D imx_clk_hw_gate2("epit1",         "ipg"=
,               base + 0x6c, 12);
+	hws[IMX6QDL_CLK_EPIT2]        =3D imx_clk_hw_gate2("epit2",         "ipg"=
,               base + 0x6c, 14);
+	hws[IMX6QDL_CLK_ESAI_EXTAL]   =3D imx_clk_hw_gate2_shared("esai_extal",  =
 "esai_podf",   base + 0x6c, 16, &share_count_esai);
+	hws[IMX6QDL_CLK_ESAI_IPG]     =3D imx_clk_hw_gate2_shared("esai_ipg",   "=
ahb",           base + 0x6c, 16, &share_count_esai);
+	hws[IMX6QDL_CLK_ESAI_MEM]     =3D imx_clk_hw_gate2_shared("esai_mem", "ah=
b",             base + 0x6c, 16, &share_count_esai);
+	hws[IMX6QDL_CLK_GPT_IPG]      =3D imx_clk_hw_gate2("gpt_ipg",       "ipg"=
,               base + 0x6c, 20);
+	hws[IMX6QDL_CLK_GPT_IPG_PER]  =3D imx_clk_hw_gate2("gpt_ipg_per",   "ipg_=
per",           base + 0x6c, 22);
+	hws[IMX6QDL_CLK_GPU2D_CORE] =3D imx_clk_hw_gate2("gpu2d_core", "gpu2d_cor=
e_podf", base + 0x6c, 24);
+	hws[IMX6QDL_CLK_GPU3D_CORE]   =3D imx_clk_hw_gate2("gpu3d_core",    "gpu3=
d_core_podf",   base + 0x6c, 26);
+	hws[IMX6QDL_CLK_HDMI_IAHB]    =3D imx_clk_hw_gate2("hdmi_iahb",     "ahb"=
,               base + 0x70, 0);
+	hws[IMX6QDL_CLK_HDMI_ISFR]    =3D imx_clk_hw_gate2("hdmi_isfr",     "mipi=
_core_cfg",     base + 0x70, 4);
+	hws[IMX6QDL_CLK_I2C1]         =3D imx_clk_hw_gate2("i2c1",          "ipg_=
per",           base + 0x70, 6);
+	hws[IMX6QDL_CLK_I2C2]         =3D imx_clk_hw_gate2("i2c2",          "ipg_=
per",           base + 0x70, 8);
+	hws[IMX6QDL_CLK_I2C3]         =3D imx_clk_hw_gate2("i2c3",          "ipg_=
per",           base + 0x70, 10);
+	hws[IMX6QDL_CLK_IIM]          =3D imx_clk_hw_gate2("iim",           "ipg"=
,               base + 0x70, 12);
+	hws[IMX6QDL_CLK_ENFC]         =3D imx_clk_hw_gate2("enfc",          "enfc=
_podf",         base + 0x70, 14);
+	hws[IMX6QDL_CLK_VDOA]         =3D imx_clk_hw_gate2("vdoa",          "vdo_=
axi",           base + 0x70, 26);
+	hws[IMX6QDL_CLK_IPU1]         =3D imx_clk_hw_gate2("ipu1",          "ipu1=
_podf",         base + 0x74, 0);
+	hws[IMX6QDL_CLK_IPU1_DI0]     =3D imx_clk_hw_gate2("ipu1_di0",      "ipu1=
_di0_sel",      base + 0x74, 2);
+	hws[IMX6QDL_CLK_IPU1_DI1]     =3D imx_clk_hw_gate2("ipu1_di1",      "ipu1=
_di1_sel",      base + 0x74, 4);
+	hws[IMX6QDL_CLK_IPU2]         =3D imx_clk_hw_gate2("ipu2",          "ipu2=
_podf",         base + 0x74, 6);
+	hws[IMX6QDL_CLK_IPU2_DI0]     =3D imx_clk_hw_gate2("ipu2_di0",      "ipu2=
_di0_sel",      base + 0x74, 8);
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_LDB_DI0]      =3D imx_clk_gate2("ldb_di0",       "ldb_di=
0_sel",      base + 0x74, 12);
-		clk[IMX6QDL_CLK_LDB_DI1]      =3D imx_clk_gate2("ldb_di1",       "ldb_di=
1_sel",      base + 0x74, 14);
+		hws[IMX6QDL_CLK_LDB_DI0]      =3D imx_clk_hw_gate2("ldb_di0",       "ldb=
_di0_sel",      base + 0x74, 12);
+		hws[IMX6QDL_CLK_LDB_DI1]      =3D imx_clk_hw_gate2("ldb_di1",       "ldb=
_di1_sel",      base + 0x74, 14);
 	} else {
-		clk[IMX6QDL_CLK_LDB_DI0]      =3D imx_clk_gate2("ldb_di0",       "ldb_di=
0_podf",      base + 0x74, 12);
-		clk[IMX6QDL_CLK_LDB_DI1]      =3D imx_clk_gate2("ldb_di1",       "ldb_di=
1_podf",      base + 0x74, 14);
+		hws[IMX6QDL_CLK_LDB_DI0]      =3D imx_clk_hw_gate2("ldb_di0",       "ldb=
_di0_podf",      base + 0x74, 12);
+		hws[IMX6QDL_CLK_LDB_DI1]      =3D imx_clk_hw_gate2("ldb_di1",       "ldb=
_di1_podf",      base + 0x74, 14);
 	}
-	clk[IMX6QDL_CLK_IPU2_DI1]     =3D imx_clk_gate2("ipu2_di1",      "ipu2_di=
1_sel",      base + 0x74, 10);
-	clk[IMX6QDL_CLK_HSI_TX]       =3D imx_clk_gate2_shared("hsi_tx", "hsi_tx_=
podf",       base + 0x74, 16, &share_count_mipi_core_cfg);
-	clk[IMX6QDL_CLK_MIPI_CORE_CFG] =3D imx_clk_gate2_shared("mipi_core_cfg", =
"video_27m", base + 0x74, 16, &share_count_mipi_core_cfg);
-	clk[IMX6QDL_CLK_MIPI_IPG]     =3D imx_clk_gate2_shared("mipi_ipg", "ipg",=
             base + 0x74, 16, &share_count_mipi_core_cfg);
+	hws[IMX6QDL_CLK_IPU2_DI1]     =3D imx_clk_hw_gate2("ipu2_di1",      "ipu2=
_di1_sel",      base + 0x74, 10);
+	hws[IMX6QDL_CLK_HSI_TX]       =3D imx_clk_hw_gate2_shared("hsi_tx", "hsi_=
tx_podf",       base + 0x74, 16, &share_count_mipi_core_cfg);
+	hws[IMX6QDL_CLK_MIPI_CORE_CFG] =3D imx_clk_hw_gate2_shared("mipi_core_cfg=
", "video_27m", base + 0x74, 16, &share_count_mipi_core_cfg);
+	hws[IMX6QDL_CLK_MIPI_IPG]     =3D imx_clk_hw_gate2_shared("mipi_ipg", "ip=
g",             base + 0x74, 16, &share_count_mipi_core_cfg);
+
 	if (clk_on_imx6dl())
 		/*
 		 * The multiplexer and divider of the imx6q clock gpu2d get
 		 * redefined/reused as mlb_sys_sel and mlb_sys_clk_podf on imx6dl.
 		 */
-		clk[IMX6QDL_CLK_MLB] =3D imx_clk_gate2("mlb",            "mlb_podf",   b=
ase + 0x74, 18);
+		hws[IMX6QDL_CLK_MLB] =3D imx_clk_hw_gate2("mlb",            "mlb_podf", =
  base + 0x74, 18);
 	else
-		clk[IMX6QDL_CLK_MLB] =3D imx_clk_gate2("mlb",            "axi",         =
      base + 0x74, 18);
-	clk[IMX6QDL_CLK_MMDC_CH0_AXI] =3D imx_clk_gate2_flags("mmdc_ch0_axi",  "m=
mdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
-	clk[IMX6QDL_CLK_MMDC_CH1_AXI] =3D imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch=
1_axi_podf", base + 0x74, 22);
-	clk[IMX6QDL_CLK_MMDC_P0_IPG]  =3D imx_clk_gate2_flags("mmdc_p0_ipg",   "i=
pg",         base + 0x74, 24, CLK_IS_CRITICAL);
-	clk[IMX6QDL_CLK_OCRAM]        =3D imx_clk_gate2("ocram",         "ahb",  =
             base + 0x74, 28);
-	clk[IMX6QDL_CLK_OPENVG_AXI]   =3D imx_clk_gate2("openvg_axi",    "axi",  =
             base + 0x74, 30);
-	clk[IMX6QDL_CLK_PCIE_AXI]     =3D imx_clk_gate2("pcie_axi",      "pcie_ax=
i_sel",      base + 0x78, 0);
-	clk[IMX6QDL_CLK_PER1_BCH]     =3D imx_clk_gate2("per1_bch",      "usdhc3"=
,            base + 0x78, 12);
-	clk[IMX6QDL_CLK_PWM1]         =3D imx_clk_gate2("pwm1",          "ipg_per=
",           base + 0x78, 16);
-	clk[IMX6QDL_CLK_PWM2]         =3D imx_clk_gate2("pwm2",          "ipg_per=
",           base + 0x78, 18);
-	clk[IMX6QDL_CLK_PWM3]         =3D imx_clk_gate2("pwm3",          "ipg_per=
",           base + 0x78, 20);
-	clk[IMX6QDL_CLK_PWM4]         =3D imx_clk_gate2("pwm4",          "ipg_per=
",           base + 0x78, 22);
-	clk[IMX6QDL_CLK_GPMI_BCH_APB] =3D imx_clk_gate2("gpmi_bch_apb",  "usdhc3"=
,            base + 0x78, 24);
-	clk[IMX6QDL_CLK_GPMI_BCH]     =3D imx_clk_gate2("gpmi_bch",      "usdhc4"=
,            base + 0x78, 26);
-	clk[IMX6QDL_CLK_GPMI_IO]      =3D imx_clk_gate2("gpmi_io",       "enfc", =
             base + 0x78, 28);
-	clk[IMX6QDL_CLK_GPMI_APB]     =3D imx_clk_gate2("gpmi_apb",      "usdhc3"=
,            base + 0x78, 30);
-	clk[IMX6QDL_CLK_ROM]          =3D imx_clk_gate2_flags("rom",     "ahb",  =
             base + 0x7c, 0, CLK_IS_CRITICAL);
-	clk[IMX6QDL_CLK_SATA]         =3D imx_clk_gate2("sata",          "ahb",  =
             base + 0x7c, 4);
-	clk[IMX6QDL_CLK_SDMA]         =3D imx_clk_gate2("sdma",          "ahb",  =
             base + 0x7c, 6);
-	clk[IMX6QDL_CLK_SPBA]         =3D imx_clk_gate2("spba",          "ipg",  =
             base + 0x7c, 12);
-	clk[IMX6QDL_CLK_SPDIF]        =3D imx_clk_gate2_shared("spdif",     "spdi=
f_podf",     base + 0x7c, 14, &share_count_spdif);
-	clk[IMX6QDL_CLK_SPDIF_GCLK]   =3D imx_clk_gate2_shared("spdif_gclk", "ipg=
",           base + 0x7c, 14, &share_count_spdif);
-	clk[IMX6QDL_CLK_SSI1_IPG]     =3D imx_clk_gate2_shared("ssi1_ipg",      "=
ipg",        base + 0x7c, 18, &share_count_ssi1);
-	clk[IMX6QDL_CLK_SSI2_IPG]     =3D imx_clk_gate2_shared("ssi2_ipg",      "=
ipg",        base + 0x7c, 20, &share_count_ssi2);
-	clk[IMX6QDL_CLK_SSI3_IPG]     =3D imx_clk_gate2_shared("ssi3_ipg",      "=
ipg",        base + 0x7c, 22, &share_count_ssi3);
-	clk[IMX6QDL_CLK_SSI1]         =3D imx_clk_gate2_shared("ssi1",          "=
ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
-	clk[IMX6QDL_CLK_SSI2]         =3D imx_clk_gate2_shared("ssi2",          "=
ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
-	clk[IMX6QDL_CLK_SSI3]         =3D imx_clk_gate2_shared("ssi3",          "=
ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
-	clk[IMX6QDL_CLK_UART_IPG]     =3D imx_clk_gate2("uart_ipg",      "ipg",  =
             base + 0x7c, 24);
-	clk[IMX6QDL_CLK_UART_SERIAL]  =3D imx_clk_gate2("uart_serial",   "uart_se=
rial_podf",  base + 0x7c, 26);
-	clk[IMX6QDL_CLK_USBOH3]       =3D imx_clk_gate2("usboh3",        "ipg",  =
             base + 0x80, 0);
-	clk[IMX6QDL_CLK_USDHC1]       =3D imx_clk_gate2("usdhc1",        "usdhc1_=
podf",       base + 0x80, 2);
-	clk[IMX6QDL_CLK_USDHC2]       =3D imx_clk_gate2("usdhc2",        "usdhc2_=
podf",       base + 0x80, 4);
-	clk[IMX6QDL_CLK_USDHC3]       =3D imx_clk_gate2("usdhc3",        "usdhc3_=
podf",       base + 0x80, 6);
-	clk[IMX6QDL_CLK_USDHC4]       =3D imx_clk_gate2("usdhc4",        "usdhc4_=
podf",       base + 0x80, 8);
-	clk[IMX6QDL_CLK_EIM_SLOW]     =3D imx_clk_gate2("eim_slow",      "eim_slo=
w_podf",     base + 0x80, 10);
-	clk[IMX6QDL_CLK_VDO_AXI]      =3D imx_clk_gate2("vdo_axi",       "vdo_axi=
_sel",       base + 0x80, 12);
-	clk[IMX6QDL_CLK_VPU_AXI]      =3D imx_clk_gate2("vpu_axi",       "vpu_axi=
_podf",      base + 0x80, 14);
+		hws[IMX6QDL_CLK_MLB] =3D imx_clk_hw_gate2("mlb",            "axi",      =
         base + 0x74, 18);
+	hws[IMX6QDL_CLK_MMDC_CH0_AXI] =3D imx_clk_hw_gate2_flags("mmdc_ch0_axi", =
 "mmdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
+	hws[IMX6QDL_CLK_MMDC_CH1_AXI] =3D imx_clk_hw_gate2("mmdc_ch1_axi",  "mmdc=
_ch1_axi_podf", base + 0x74, 22);
+	hws[IMX6QDL_CLK_MMDC_P0_IPG]  =3D imx_clk_hw_gate2_flags("mmdc_p0_ipg",  =
 "ipg",         base + 0x74, 24, CLK_IS_CRITICAL);
+	hws[IMX6QDL_CLK_OCRAM]        =3D imx_clk_hw_gate2("ocram",         "ahb"=
,               base + 0x74, 28);
+	hws[IMX6QDL_CLK_OPENVG_AXI]   =3D imx_clk_hw_gate2("openvg_axi",    "axi"=
,               base + 0x74, 30);
+	hws[IMX6QDL_CLK_PCIE_AXI]     =3D imx_clk_hw_gate2("pcie_axi",      "pcie=
_axi_sel",      base + 0x78, 0);
+	hws[IMX6QDL_CLK_PER1_BCH]     =3D imx_clk_hw_gate2("per1_bch",      "usdh=
c3",            base + 0x78, 12);
+	hws[IMX6QDL_CLK_PWM1]         =3D imx_clk_hw_gate2("pwm1",          "ipg_=
per",           base + 0x78, 16);
+	hws[IMX6QDL_CLK_PWM2]         =3D imx_clk_hw_gate2("pwm2",          "ipg_=
per",           base + 0x78, 18);
+	hws[IMX6QDL_CLK_PWM3]         =3D imx_clk_hw_gate2("pwm3",          "ipg_=
per",           base + 0x78, 20);
+	hws[IMX6QDL_CLK_PWM4]         =3D imx_clk_hw_gate2("pwm4",          "ipg_=
per",           base + 0x78, 22);
+	hws[IMX6QDL_CLK_GPMI_BCH_APB] =3D imx_clk_hw_gate2("gpmi_bch_apb",  "usdh=
c3",            base + 0x78, 24);
+	hws[IMX6QDL_CLK_GPMI_BCH]     =3D imx_clk_hw_gate2("gpmi_bch",      "usdh=
c4",            base + 0x78, 26);
+	hws[IMX6QDL_CLK_GPMI_IO]      =3D imx_clk_hw_gate2("gpmi_io",       "enfc=
",              base + 0x78, 28);
+	hws[IMX6QDL_CLK_GPMI_APB]     =3D imx_clk_hw_gate2("gpmi_apb",      "usdh=
c3",            base + 0x78, 30);
+	hws[IMX6QDL_CLK_ROM]          =3D imx_clk_hw_gate2_flags("rom",     "ahb"=
,               base + 0x7c, 0, CLK_IS_CRITICAL);
+	hws[IMX6QDL_CLK_SATA]         =3D imx_clk_hw_gate2("sata",          "ahb"=
,               base + 0x7c, 4);
+	hws[IMX6QDL_CLK_SDMA]         =3D imx_clk_hw_gate2("sdma",          "ahb"=
,               base + 0x7c, 6);
+	hws[IMX6QDL_CLK_SPBA]         =3D imx_clk_hw_gate2("spba",          "ipg"=
,               base + 0x7c, 12);
+	hws[IMX6QDL_CLK_SPDIF]        =3D imx_clk_hw_gate2_shared("spdif",     "s=
pdif_podf",     base + 0x7c, 14, &share_count_spdif);
+	hws[IMX6QDL_CLK_SPDIF_GCLK]   =3D imx_clk_hw_gate2_shared("spdif_gclk", "=
ipg",           base + 0x7c, 14, &share_count_spdif);
+	hws[IMX6QDL_CLK_SSI1_IPG]     =3D imx_clk_hw_gate2_shared("ssi1_ipg",    =
  "ipg",        base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6QDL_CLK_SSI2_IPG]     =3D imx_clk_hw_gate2_shared("ssi2_ipg",    =
  "ipg",        base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6QDL_CLK_SSI3_IPG]     =3D imx_clk_hw_gate2_shared("ssi3_ipg",    =
  "ipg",        base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6QDL_CLK_SSI1]         =3D imx_clk_hw_gate2_shared("ssi1",        =
  "ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6QDL_CLK_SSI2]         =3D imx_clk_hw_gate2_shared("ssi2",        =
  "ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6QDL_CLK_SSI3]         =3D imx_clk_hw_gate2_shared("ssi3",        =
  "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6QDL_CLK_UART_IPG]     =3D imx_clk_hw_gate2("uart_ipg",      "ipg"=
,               base + 0x7c, 24);
+	hws[IMX6QDL_CLK_UART_SERIAL]  =3D imx_clk_hw_gate2("uart_serial",   "uart=
_serial_podf",  base + 0x7c, 26);
+	hws[IMX6QDL_CLK_USBOH3]       =3D imx_clk_hw_gate2("usboh3",        "ipg"=
,               base + 0x80, 0);
+	hws[IMX6QDL_CLK_USDHC1]       =3D imx_clk_hw_gate2("usdhc1",        "usdh=
c1_podf",       base + 0x80, 2);
+	hws[IMX6QDL_CLK_USDHC2]       =3D imx_clk_hw_gate2("usdhc2",        "usdh=
c2_podf",       base + 0x80, 4);
+	hws[IMX6QDL_CLK_USDHC3]       =3D imx_clk_hw_gate2("usdhc3",        "usdh=
c3_podf",       base + 0x80, 6);
+	hws[IMX6QDL_CLK_USDHC4]       =3D imx_clk_hw_gate2("usdhc4",        "usdh=
c4_podf",       base + 0x80, 8);
+	hws[IMX6QDL_CLK_EIM_SLOW]     =3D imx_clk_hw_gate2("eim_slow",      "eim_=
slow_podf",     base + 0x80, 10);
+	hws[IMX6QDL_CLK_VDO_AXI]      =3D imx_clk_hw_gate2("vdo_axi",       "vdo_=
axi_sel",       base + 0x80, 12);
+	hws[IMX6QDL_CLK_VPU_AXI]      =3D imx_clk_hw_gate2("vpu_axi",       "vpu_=
axi_podf",      base + 0x80, 14);
 	if (clk_on_imx6qp()) {
-		clk[IMX6QDL_CLK_PRE0] =3D imx_clk_gate2("pre0",	       "pre_axi",	    ba=
se + 0x80, 16);
-		clk[IMX6QDL_CLK_PRE1] =3D imx_clk_gate2("pre1",	       "pre_axi",	    ba=
se + 0x80, 18);
-		clk[IMX6QDL_CLK_PRE2] =3D imx_clk_gate2("pre2",	       "pre_axi",       =
  base + 0x80, 20);
-		clk[IMX6QDL_CLK_PRE3] =3D imx_clk_gate2("pre3",	       "pre_axi",	    ba=
se + 0x80, 22);
-		clk[IMX6QDL_CLK_PRG0_AXI] =3D imx_clk_gate2_shared("prg0_axi",  "ipu1_po=
df",  base + 0x80, 24, &share_count_prg0);
-		clk[IMX6QDL_CLK_PRG1_AXI] =3D imx_clk_gate2_shared("prg1_axi",  "ipu2_po=
df",  base + 0x80, 26, &share_count_prg1);
-		clk[IMX6QDL_CLK_PRG0_APB] =3D imx_clk_gate2_shared("prg0_apb",  "ipg",	 =
   base + 0x80, 24, &share_count_prg0);
-		clk[IMX6QDL_CLK_PRG1_APB] =3D imx_clk_gate2_shared("prg1_apb",  "ipg",	 =
   base + 0x80, 26, &share_count_prg1);
+		hws[IMX6QDL_CLK_PRE0] =3D imx_clk_hw_gate2("pre0",	       "pre_axi",	   =
 base + 0x80, 16);
+		hws[IMX6QDL_CLK_PRE1] =3D imx_clk_hw_gate2("pre1",	       "pre_axi",	   =
 base + 0x80, 18);
+		hws[IMX6QDL_CLK_PRE2] =3D imx_clk_hw_gate2("pre2",	       "pre_axi",    =
     base + 0x80, 20);
+		hws[IMX6QDL_CLK_PRE3] =3D imx_clk_hw_gate2("pre3",	       "pre_axi",	   =
 base + 0x80, 22);
+		hws[IMX6QDL_CLK_PRG0_AXI] =3D imx_clk_hw_gate2_shared("prg0_axi",  "ipu1=
_podf",  base + 0x80, 24, &share_count_prg0);
+		hws[IMX6QDL_CLK_PRG1_AXI] =3D imx_clk_hw_gate2_shared("prg1_axi",  "ipu2=
_podf",  base + 0x80, 26, &share_count_prg1);
+		hws[IMX6QDL_CLK_PRG0_APB] =3D imx_clk_hw_gate2_shared("prg0_apb",  "ipg"=
,	    base + 0x80, 24, &share_count_prg0);
+		hws[IMX6QDL_CLK_PRG1_APB] =3D imx_clk_hw_gate2_shared("prg1_apb",  "ipg"=
,	    base + 0x80, 26, &share_count_prg1);
 	}
-	clk[IMX6QDL_CLK_CKO1]         =3D imx_clk_gate("cko1",           "cko1_po=
df",         base + 0x60, 7);
-	clk[IMX6QDL_CLK_CKO2]         =3D imx_clk_gate("cko2",           "cko2_po=
df",         base + 0x60, 24);
+	hws[IMX6QDL_CLK_CKO1]         =3D imx_clk_hw_gate("cko1",           "cko1=
_podf",         base + 0x60, 7);
+	hws[IMX6QDL_CLK_CKO2]         =3D imx_clk_hw_gate("cko2",           "cko2=
_podf",         base + 0x60, 24);
=20
 	/*
 	 * The gpt_3m clock is not available on i.MX6Q TO1.0.  Let's point it
 	 * to clock gpt_ipg_per to ease the gpt driver code.
 	 */
 	if (clk_on_imx6q() && imx_get_soc_revision() =3D=3D IMX_CHIP_REVISION_1_0=
)
-		clk[IMX6QDL_CLK_GPT_3M] =3D clk[IMX6QDL_CLK_GPT_IPG_PER];
+		hws[IMX6QDL_CLK_GPT_3M] =3D hws[IMX6QDL_CLK_GPT_IPG_PER];
=20
-	imx_check_clocks(clk, ARRAY_SIZE(clk));
+	imx_check_clk_hws(hws, IMX6QDL_CLK_END);
=20
-	clk_data.clks =3D clk;
-	clk_data.clk_num =3D ARRAY_SIZE(clk);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
=20
-	clk_register_clkdev(clk[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
+	clk_hw_register_clkdev(hws[IMX6QDL_CLK_ENET_REF], "enet_ref", NULL);
=20
-	clk_set_rate(clk[IMX6QDL_CLK_PLL3_PFD1_540M], 540000000);
+	clk_set_rate(hws[IMX6QDL_CLK_PLL3_PFD1_540M]->clk, 540000000);
 	if (clk_on_imx6dl())
-		clk_set_parent(clk[IMX6QDL_CLK_IPU1_SEL], clk[IMX6QDL_CLK_PLL3_PFD1_540M=
]);
+		clk_set_parent(hws[IMX6QDL_CLK_IPU1_SEL]->clk, hws[IMX6QDL_CLK_PLL3_PFD1=
_540M]->clk);
=20
-	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VI=
DEO_DIV]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI1_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VI=
DEO_DIV]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI0_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VI=
DEO_DIV]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI1_PRE_SEL], clk[IMX6QDL_CLK_PLL5_VI=
DEO_DIV]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI0_SEL], clk[IMX6QDL_CLK_IPU1_DI0_PR=
E]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU1_DI1_SEL], clk[IMX6QDL_CLK_IPU1_DI1_PR=
E]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI0_SEL], clk[IMX6QDL_CLK_IPU2_DI0_PR=
E]);
-	clk_set_parent(clk[IMX6QDL_CLK_IPU2_DI1_SEL], clk[IMX6QDL_CLK_IPU2_DI1_PR=
E]);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU1_DI0_PRE_SEL]->clk, hws[IMX6QDL_CLK_PL=
L5_VIDEO_DIV]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU1_DI1_PRE_SEL]->clk, hws[IMX6QDL_CLK_PL=
L5_VIDEO_DIV]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI0_PRE_SEL]->clk, hws[IMX6QDL_CLK_PL=
L5_VIDEO_DIV]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI1_PRE_SEL]->clk, hws[IMX6QDL_CLK_PL=
L5_VIDEO_DIV]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU1_DI0_SEL]->clk, hws[IMX6QDL_CLK_IPU1_D=
I0_PRE]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU1_DI1_SEL]->clk, hws[IMX6QDL_CLK_IPU1_D=
I1_PRE]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI0_SEL]->clk, hws[IMX6QDL_CLK_IPU2_D=
I0_PRE]->clk);
+	clk_set_parent(hws[IMX6QDL_CLK_IPU2_DI1_SEL]->clk, hws[IMX6QDL_CLK_IPU2_D=
I1_PRE]->clk);
=20
 	/*
 	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
 	 * We can not get the 100MHz from the pll2_pfd0_352m.
 	 * So choose pll2_pfd2_396m as enfc_sel's parent.
 	 */
-	clk_set_parent(clk[IMX6QDL_CLK_ENFC_SEL], clk[IMX6QDL_CLK_PLL2_PFD2_396M]=
);
+	clk_set_parent(hws[IMX6QDL_CLK_ENFC_SEL]->clk, hws[IMX6QDL_CLK_PLL2_PFD2_=
396M]->clk);
=20
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY2_GATE]);
+		clk_prepare_enable(hws[IMX6QDL_CLK_USBPHY1_GATE]->clk);
+		clk_prepare_enable(hws[IMX6QDL_CLK_USBPHY2_GATE]->clk);
 	}
=20
 	/*
 	 * Let's initially set up CLKO with OSC24M, since this configuration
 	 * is widely used by imx6q board designs to clock audio codec.
 	 */
-	ret =3D clk_set_parent(clk[IMX6QDL_CLK_CKO2_SEL], clk[IMX6QDL_CLK_OSC]);
+	ret =3D clk_set_parent(hws[IMX6QDL_CLK_CKO2_SEL]->clk, hws[IMX6QDL_CLK_OS=
C]->clk);
 	if (!ret)
-		ret =3D clk_set_parent(clk[IMX6QDL_CLK_CKO], clk[IMX6QDL_CLK_CKO2]);
+		ret =3D clk_set_parent(hws[IMX6QDL_CLK_CKO]->clk, hws[IMX6QDL_CLK_CKO2]-=
>clk);
 	if (ret)
 		pr_warn("failed to set up CLKO: %d\n", ret);
=20
 	/* Audio-related clocks configuration */
-	clk_set_parent(clk[IMX6QDL_CLK_SPDIF_SEL], clk[IMX6QDL_CLK_PLL3_PFD3_454M=
]);
+	clk_set_parent(hws[IMX6QDL_CLK_SPDIF_SEL]->clk, hws[IMX6QDL_CLK_PLL3_PFD3=
_454M]->clk);
=20
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
-		clk_set_parent(clk[IMX6QDL_CLK_LVDS1_SEL], clk[IMX6QDL_CLK_SATA_REF_100M=
]);
+		clk_set_parent(hws[IMX6QDL_CLK_LVDS1_SEL]->clk, hws[IMX6QDL_CLK_SATA_REF=
_100M]->clk);
=20
 	/*
 	 * Initialize the GPU clock muxes, so that the maximum specified clock
 	 * rates for the respective SoC are not exceeded.
 	 */
 	if (clk_on_imx6dl()) {
-		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_CORE_SEL],
-			       clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
-		clk_set_parent(clk[IMX6QDL_CLK_GPU2D_CORE_SEL],
-			       clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
+		clk_set_parent(hws[IMX6QDL_CLK_GPU3D_CORE_SEL]->clk,
+			       hws[IMX6QDL_CLK_PLL2_PFD1_594M]->clk);
+		clk_set_parent(hws[IMX6QDL_CLK_GPU2D_CORE_SEL]->clk,
+			       hws[IMX6QDL_CLK_PLL2_PFD1_594M]->clk);
 	} else if (clk_on_imx6q()) {
-		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_CORE_SEL],
-			       clk[IMX6QDL_CLK_MMDC_CH0_AXI]);
-		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_SHADER_SEL],
-			       clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
-		clk_set_parent(clk[IMX6QDL_CLK_GPU2D_CORE_SEL],
-			       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
+		clk_set_parent(hws[IMX6QDL_CLK_GPU3D_CORE_SEL]->clk,
+			       hws[IMX6QDL_CLK_MMDC_CH0_AXI]->clk);
+		clk_set_parent(hws[IMX6QDL_CLK_GPU3D_SHADER_SEL]->clk,
+			       hws[IMX6QDL_CLK_PLL2_PFD1_594M]->clk);
+		clk_set_parent(hws[IMX6QDL_CLK_GPU2D_CORE_SEL]->clk,
+			       hws[IMX6QDL_CLK_PLL3_USB_OTG]->clk);
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_clks[i] =3D &hws[index]->clk;
 	}
=20
 	imx_register_uart_clocks(uart_clks);
--=20
2.7.4

