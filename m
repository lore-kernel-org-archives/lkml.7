Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D00EC28D1A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648520872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfFFJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:09:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36778 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfFFJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:09:44 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYoOw-0003Fk-8D; Thu, 06 Jun 2019 11:09:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, papadakospan@gmail.com,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] clk: rockchip: convert pclk_wdt boilerplat to new SGRF_GATE macro
Date:   Thu,  6 Jun 2019 11:09:34 +0200
Message-Id: <20190606090934.4443-2-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606090934.4443-1-heiko@sntech.de>
References: <20190606090934.4443-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the boilerplate code for manual addition of the watchdog clock
to the new SGRF_GATE macro for all affected socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-px30.c   | 11 +++--------
 drivers/clk/rockchip/clk-rk3288.c | 11 +++--------
 drivers/clk/rockchip/clk-rk3368.c | 11 +++--------
 drivers/clk/rockchip/clk-rk3399.c | 11 +++--------
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 68d23be18cbc..2e10b9f211eb 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -803,6 +803,9 @@ static struct rockchip_clk_branch px30_clk_branches[] __initdata = {
 	GATE(ACLK_GIC, "aclk_gic", "aclk_bus_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(13), 12, GFLAGS),
 	GATE(ACLK_DCF, "aclk_dcf", "aclk_bus_pre", 0, PX30_CLKGATE_CON(13), 15, GFLAGS),
 
+	/* aclk_dmac is controlled by sgrf_soc_con1[11]. */
+	SGRF_GATE(ACLK_DMAC, "aclk_dmac", "aclk_bus_pre"),
+
 	GATE(0, "hclk_bus_niu", "hclk_bus_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(13), 9, GFLAGS),
 	GATE(0, "hclk_rom", "hclk_bus_pre", CLK_IGNORE_UNUSED, PX30_CLKGATE_CON(13), 14, GFLAGS),
 	GATE(HCLK_PDM, "hclk_pdm", "hclk_bus_pre", 0, PX30_CLKGATE_CON(14), 1, GFLAGS),
@@ -981,14 +984,6 @@ static void __init px30_clk_init(struct device_node *np)
 		return;
 	}
 
-	/* aclk_dmac is controlled by sgrf_soc_con1[11]. */
-	clk = clk_register_fixed_factor(NULL, "aclk_dmac", "aclk_bus_pre", 0, 1, 1);
-	if (IS_ERR(clk))
-		pr_warn("%s: could not register clock aclk_dmac: %ld\n",
-			__func__, PTR_ERR(clk));
-	else
-		rockchip_clk_add_lookup(ctx, clk, ACLK_DMAC);
-
 	rockchip_clk_register_plls(ctx, px30_pll_clks,
 				   ARRAY_SIZE(px30_pll_clks),
 				   PX30_GRF_SOC_STATUS0);
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 85907f31c63f..9e3dbc4a7632 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -776,6 +776,9 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(PCLK_GRF, "pclk_grf", "pclk_pd_alive", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(14), 11, GFLAGS),
 	GATE(0, "pclk_alive_niu", "pclk_pd_alive", 0, RK3288_CLKGATE_CON(14), 12, GFLAGS),
 
+	/* Watchdog pclk is controlled by RK3288_SGRF_SOC_CON0[1]. */
+	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_pd_alive"),
+
 	/* pclk_pd_pmu gates */
 	GATE(PCLK_PMU, "pclk_pmu", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 0, GFLAGS),
 	GATE(0, "pclk_intmem1", "pclk_pd_pmu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(17), 1, GFLAGS),
@@ -939,14 +942,6 @@ static void __init rk3288_clk_init(struct device_node *np)
 		return;
 	}
 
-	/* Watchdog pclk is controlled by RK3288_SGRF_SOC_CON0[1]. */
-	clk = clk_register_fixed_factor(NULL, "pclk_wdt", "pclk_pd_alive", 0, 1, 1);
-	if (IS_ERR(clk))
-		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
-			__func__, PTR_ERR(clk));
-	else
-		rockchip_clk_add_lookup(ctx, clk, PCLK_WDT);
-
 	rockchip_clk_register_plls(ctx, rk3288_pll_clks,
 				   ARRAY_SIZE(rk3288_pll_clks),
 				   RK3288_GRF_SOC_STATUS1);
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index d239bbc2fc77..b70de6cacac4 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -820,6 +820,9 @@ static struct rockchip_clk_branch rk3368_clk_branches[] __initdata = {
 	GATE(PCLK_GPIO2, "pclk_gpio2", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 2, GFLAGS),
 	GATE(PCLK_GPIO1, "pclk_gpio1", "pclk_pd_alive", 0, RK3368_CLKGATE_CON(22), 1, GFLAGS),
 
+	/* Watchdog pclk is controlled by sgrf_soc_con3[7]. */
+	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_pd_alive"),
+
 	/*
 	 * pclk_vio gates
 	 * pclk_vio comes from the exactly same source as hclk_vio
@@ -886,14 +889,6 @@ static void __init rk3368_clk_init(struct device_node *np)
 		return;
 	}
 
-	/* Watchdog pclk is controlled by sgrf_soc_con3[7]. */
-	clk = clk_register_fixed_factor(NULL, "pclk_wdt", "pclk_pd_alive", 0, 1, 1);
-	if (IS_ERR(clk))
-		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
-			__func__, PTR_ERR(clk));
-	else
-		rockchip_clk_add_lookup(ctx, clk, PCLK_WDT);
-
 	rockchip_clk_register_plls(ctx, rk3368_pll_clks,
 				   ARRAY_SIZE(rk3368_pll_clks),
 				   RK3368_GRF_SOC_STATUS0);
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 2322d712ba88..7aeda9814012 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1304,6 +1304,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	GATE(PCLK_PMU_INTR_ARB, "pclk_pmu_intr_arb", "pclk_alive", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(31), 9, GFLAGS),
 	GATE(PCLK_SGRF, "pclk_sgrf", "pclk_alive", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(31), 10, GFLAGS),
 
+	/* Watchdog pclk is controlled by RK3399 SECURE_GRF_SOC_CON3[8]. */
+	SGRF_GATE(PCLK_WDT, "pclk_wdt", "pclk_alive"),
+
 	GATE(SCLK_MIPIDPHY_REF, "clk_mipidphy_ref", "xin24m", 0, RK3399_CLKGATE_CON(11), 14, GFLAGS),
 	GATE(SCLK_DPHY_PLL, "clk_dphy_pll", "clk_mipidphy_ref", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(21), 0, GFLAGS),
 
@@ -1546,14 +1549,6 @@ static void __init rk3399_clk_init(struct device_node *np)
 		return;
 	}
 
-	/* Watchdog pclk is controlled by RK3399 SECURE_GRF_SOC_CON3[8]. */
-	clk = clk_register_fixed_factor(NULL, "pclk_wdt", "pclk_alive", 0, 1, 1);
-	if (IS_ERR(clk))
-		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
-			__func__, PTR_ERR(clk));
-	else
-		rockchip_clk_add_lookup(ctx, clk, PCLK_WDT);
-
 	rockchip_clk_register_plls(ctx, rk3399_pll_clks,
 				   ARRAY_SIZE(rk3399_pll_clks), -1);
 
-- 
2.20.1

