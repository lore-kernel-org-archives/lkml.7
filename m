Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB35C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F22064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCRXSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:18:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:48537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfCRXSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:18:23 -0400
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ2Tn-1h2Skh0SF1-005LZA; Tue, 19
 Mar 2019 00:18:04 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] clk: imx5: Fix i.MX50 clock registers
Date:   Tue, 19 Mar 2019 00:17:35 +0100
Message-Id: <20190318231737.8459-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RRb6Xf/VcMvOxhN4ikYAgBPue7L4Lp92ZxXActVlKqpG8N/olT6
 qmQwoa3HiH20jMn7/wr6u1r+r6PPMaPNZAsToQYfWkq+1EkMtbmATrfPKuNV76nUsh+PH18
 MCft4q7U6gKZZ+aNRFLax+QCzzZPZg9gWUK6hnEf0BqLT5Z9Qz1uJsLMuCPg3gMXxgIFgJp
 D+YCLWmU/ewPFQJlDMVyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RBFQzZ7TkFU=:qwrmcLoOKxhzpEVtaxxf+Q
 ma3Ee+SkKGOp0F1nXTJQop2HuAz9NzDuuSyZzpIgKMBQXifwzp0rXa/BwJ7btlq8uIzYlrR2B
 tWrGFn9C59O688pj7zaj+t42yQSx/PuBCGsBPDwj0rPIu+fNthcCN9ZJ5qThpICZq9bZc7GJD
 6KXOAywx1hD22kAAqStZnWoRPGVxDrWkuRc3P22vCw6xoWvttuNspBoJdVLvywteNf/o/27w4
 uURzu+qciipJl85wxV4gZvNaJQH2IexqxkiI0cr8BKX2SDnoMnvZi3eEC1Y2VZv9WbTLV2K4g
 NWRpJpgY6AuKZdCKOF/oyYpP6PELJhL5hTnF7zzQpl3IYC5iEeCKo0Ekpt+Odj1I6s729gEcG
 s0CGpHZGuuVNnIFe3dWFSzINrFsnIUqA16nGK/d8I/i3rwGdgsfP1DizG3KO+FQKQp4tbo3PP
 vyCKMxmOxAx3PMLxnbU8yjkktl5EyoIqwf5XkwlVm6P/HER1csQrWxsExfE6JFzFmzzK+u2Ob
 NEyweM8+/464YEOZdN6yatD/s+WcwUCbef30NeWKbM5tTNJA/pTs5cGbymC1NALw94aqAqVGj
 L5osWadXBJA3S30i15WuNw56f6Ad3uxpiINfrma9mx3BfzQYf4AaxsQrP4lciJq7flfitzZtd
 nGbi9sOYHY9Gddzv1QarJKl3a/nPjE6so9pz4NzpQC0qUjBZE/+o6eto9lGqTO/zfFMbAJZ7a
 nVM59JxiPTSUd0XycvBLsEGp18ZR1ZAKS3X4PaZXwRowoYVx4SnJ6v6z2FSUsaab5W1XGpHuM
 y8HWKvIFHZTmXdWuvYAaYgnspLNKACdKOvTfwriCBymG0PmpEO4GykNLMd0gNAimw1CZ3axhz
 5TWwei+/DmPGlmOvP5sQ3auWriVTJIYwHNL0X/ov3hABo08Hb0X1We3YDpB0tqLfYPHkatej/
 u8V3GMWRCLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few differences between the i.MX50 clock tree and those of
i.MX51 and i.MX53 that are not yet handled in clk-imx51-imx53.c.
This patch handles the following differences:

- i.MX50 does not have a periph_apm clock. Instead, the main bus clock
  (a.k.a. periph_clk) comes directly from a MUX between pll1_sw,
  pll2_sw, pll3_sw, and lp_apm.
- The MUX bits for esdhc_{a,c,d}_sel are shifted by one bit within
  CSCMR1.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---

I'd appreciate some testing from owners of i.MX51 or i.MX53 based boards
to ensure that I didn't break the driver for these SoCs.

Previous copy of v1:
https://lore.kernel.org/lkml/20190211164048.7841-1-j.neuschaefer@gmx.net/
---
 drivers/clk/imx/clk-imx51-imx53.c | 59 +++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index e91c826bce70..c85ebd74a8a5 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -164,10 +164,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_CKIH1]		= imx_obtain_fixed_clock("ckih1", 0);
 	clk[IMX5_CLK_CKIH2]		= imx_obtain_fixed_clock("ckih2", 0);
 
-	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
-						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
-	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
-						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_PER_LP_APM]	= imx_clk_mux("per_lp_apm", MXC_CCM_CBCMR, 1, 1,
 						per_lp_apm_sel, ARRAY_SIZE(per_lp_apm_sel));
 	clk[IMX5_CLK_PER_PRED1]		= imx_clk_divider("per_pred1", "per_lp_apm", MXC_CCM_CBCDR, 6, 2);
@@ -191,16 +187,10 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk[IMX5_CLK_UART_PRED]		= imx_clk_divider("uart_pred", "uart_sel", MXC_CCM_CSCDR1, 3, 3);
 	clk[IMX5_CLK_UART_ROOT]		= imx_clk_divider("uart_root", "uart_pred", MXC_CCM_CSCDR1, 0, 3);
 
-	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
-	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
-						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
 	clk[IMX5_CLK_ESDHC_A_PRED]	= imx_clk_divider("esdhc_a_pred", "esdhc_a_sel", MXC_CCM_CSCDR1, 16, 3);
 	clk[IMX5_CLK_ESDHC_A_PODF]	= imx_clk_divider("esdhc_a_podf", "esdhc_a_pred", MXC_CCM_CSCDR1, 11, 3);
 	clk[IMX5_CLK_ESDHC_B_PRED]	= imx_clk_divider("esdhc_b_pred", "esdhc_b_sel", MXC_CCM_CSCDR1, 22, 3);
 	clk[IMX5_CLK_ESDHC_B_PODF]	= imx_clk_divider("esdhc_b_podf", "esdhc_b_pred", MXC_CCM_CSCDR1, 19, 3);
-	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
-	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 
 	clk[IMX5_CLK_EMI_SEL]		= imx_clk_mux("emi_sel", MXC_CCM_CBCDR, 26, 1,
 						emi_slow_sel, ARRAY_SIZE(emi_slow_sel));
@@ -311,10 +301,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk_register_clkdev(clk[IMX5_CLK_CPU_PODF], NULL, "cpu0");
 	clk_register_clkdev(clk[IMX5_CLK_GPC_DVFS], "gpc_dvfs", NULL);
 
-	/* Set SDHC parents to be PLL2 */
-	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
-	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
-
 	/* move usb phy clk to 24MHz */
 	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
 }
@@ -342,8 +328,21 @@ static void __init mx50_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	/*
+	 * This clock is called periph_clk in the i.MX50 Reference Manual, but
+	 * it comes closest in scope to the main_bus_clk of i.MX51 and i.MX53
+	 */
+	clk[IMX5_CLK_MAIN_BUS]          = imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 21, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 20, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 10);
@@ -372,6 +371,10 @@ static void __init mx50_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
@@ -410,6 +413,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 9, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_IPU_DI0_SEL]	= imx_clk_mux_flags("ipu_di0_sel", MXC_CCM_CSCMR2, 26, 3,
@@ -422,6 +429,12 @@ static void __init mx51_clocks_init(struct device_node *np)
 						mx51_tve_sel, ARRAY_SIZE(mx51_tve_sel));
 	clk[IMX5_CLK_TVE_GATE]		= imx_clk_gate2("tve_gate", "tve_sel", MXC_CCM_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		= imx_clk_divider("tve_pred", "pll3_sw", MXC_CCM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 10);
@@ -452,6 +465,10 @@ static void __init mx51_clocks_init(struct device_node *np)
 	/* set the usboh3 parent to pll2_sw */
 	clk_set_parent(clk[IMX5_CLK_USBOH3_SEL], clk[IMX5_CLK_PLL2_SW]);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 166.25MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 166250000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
@@ -506,6 +523,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 
 	mx5_clocks_common_init(ccm_base);
 
+	clk[IMX5_CLK_PERIPH_APM]	= imx_clk_mux("periph_apm", MXC_CCM_CBCMR, 12, 2,
+						periph_apm_sel, ARRAY_SIZE(periph_apm_sel));
+	clk[IMX5_CLK_MAIN_BUS]		= imx_clk_mux("main_bus", MXC_CCM_CBCDR, 25, 1,
+						main_bus_sel, ARRAY_SIZE(main_bus_sel));
 	clk[IMX5_CLK_LP_APM]		= imx_clk_mux("lp_apm", MXC_CCM_CCSR, 10, 1,
 						lp_apm_sel, ARRAY_SIZE(lp_apm_sel));
 	clk[IMX5_CLK_LDB_DI1_DIV_3_5]	= imx_clk_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
@@ -527,6 +548,12 @@ static void __init mx53_clocks_init(struct device_node *np)
 						mx53_tve_ext_sel, ARRAY_SIZE(mx53_tve_ext_sel), CLK_SET_RATE_PARENT);
 	clk[IMX5_CLK_TVE_GATE]		= imx_clk_gate2("tve_gate", "tve_pred", MXC_CCM_CCGR2, 30);
 	clk[IMX5_CLK_TVE_PRED]		= imx_clk_divider("tve_pred", "tve_ext_sel", MXC_CCM_CDCDR, 28, 3);
+	clk[IMX5_CLK_ESDHC_A_SEL]	= imx_clk_mux("esdhc_a_sel", MXC_CCM_CSCMR1, 20, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_B_SEL]	= imx_clk_mux("esdhc_b_sel", MXC_CCM_CSCMR1, 16, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_ESDHC_C_SEL]	= imx_clk_mux("esdhc_c_sel", MXC_CCM_CSCMR1, 19, 1, esdhc_c_sel, ARRAY_SIZE(esdhc_c_sel));
+	clk[IMX5_CLK_ESDHC_D_SEL]	= imx_clk_mux("esdhc_d_sel", MXC_CCM_CSCMR1, 18, 1, esdhc_d_sel, ARRAY_SIZE(esdhc_d_sel));
 	clk[IMX5_CLK_ESDHC1_PER_GATE]	= imx_clk_gate2("esdhc1_per_gate", "esdhc_a_podf", MXC_CCM_CCGR3, 2);
 	clk[IMX5_CLK_ESDHC2_PER_GATE]	= imx_clk_gate2("esdhc2_per_gate", "esdhc_c_sel", MXC_CCM_CCGR3, 6);
 	clk[IMX5_CLK_ESDHC3_PER_GATE]	= imx_clk_gate2("esdhc3_per_gate", "esdhc_b_podf", MXC_CCM_CCGR3, 10);
@@ -589,6 +616,10 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_data.clk_num = ARRAY_SIZE(clk);
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
 	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
-- 
2.20.1

