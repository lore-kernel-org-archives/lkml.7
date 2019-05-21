Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB2EC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38262183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="o0q3C1Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfEUXbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8289 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEUXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a460000>; Tue, 21 May 2019 16:31:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a450006>; Tue, 21 May 2019 16:31:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 03/12] clk: tegra: save and restore PLLs state for system
Date:   Tue, 21 May 2019 16:31:14 -0700
Message-ID: <1558481483-22254-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481478; bh=BjFmNuiOdCzn6XauneHg2P5gSX+8bpnzX50Kauv0FfQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=o0q3C1LdpjQXy6el1Y+OEJXp++NY50Gn5wf+VYwAQAfu9PMKfnRXiYIdZoYpaICxE
         yKISoFY4Q7augf/cheVSpLKWnTD9m0AiUkV9ceTzC0GYQuQEIwWNHqg+HD8nbXir0Z
         GcPJunxMHmb2pZX0JPYDlKnys6OpNfYUhDRnIG4ImIBgeNVpkDSvdx6LY82Zc1+kBQ
         ueERTjOIk/kM0C19vJ4mk6nrp2FxpMXOQZIMOd7FNL0ZreouQBk4TAhqxcn01x55Ra
         oRIp7D5Gt0yUmE0RjFbNPG7pcMnggf/FLZaYf7Q4kRa7NSU/bz+6DsbFIVuZ7rSzJa
         4a0rd6IBIK6ew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has implementation of saving and restoring PLL's state to
support system suspend and resume operations.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-divider.c |  19 ++++
 drivers/clk/tegra/clk-pll-out.c |  25 +++++
 drivers/clk/tegra/clk-pll.c     | 220 ++++++++++++++++++++++++++++++++++++----
 drivers/clk/tegra/clk.h         |  14 +++
 4 files changed, 258 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 2a1822a22740..718694727042 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -14,6 +14,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -179,3 +180,21 @@ struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
 					  reg, 16, 1, CLK_DIVIDER_READ_ONLY,
 					  mc_div_table, lock);
 }
+
+#if defined(CONFIG_PM_SLEEP)
+void tegra_clk_divider_resume(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned long parent_rate;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_hw_get_rate(parent);
+
+	if (clk_frac_div_set_rate(hw, rate, parent_rate) < 0)
+		WARN_ON(1);
+}
+#endif
diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
index 257cae0c1488..8b8c3b77d243 100644
--- a/drivers/clk/tegra/clk-pll-out.c
+++ b/drivers/clk/tegra/clk-pll-out.c
@@ -14,6 +14,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/err.h>
@@ -120,3 +121,27 @@ struct clk *tegra_clk_register_pll_out(const char *name,
 
 	return clk;
 }
+
+#if defined(CONFIG_PM_SLEEP)
+void tegra_clk_pll_out_resume(struct clk *clk, unsigned long rate)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	tegra_clk_divider_resume(parent, rate);
+	clk_pll_out_enable(hw);
+}
+
+void tegra_clk_sync_state_pll_out(struct clk *clk)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+
+	if (!__clk_get_enable_count(clk))
+		clk_pll_out_disable(hw);
+}
+#endif
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 6b976b2514f7..a47950256598 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/tegra.h>
 
 #include "clk.h"
 
@@ -1813,6 +1814,28 @@ static int clk_pllu_tegra114_enable(struct clk_hw *hw)
 
 	return ret;
 }
+
+static void _clk_plle_tegra_init_parent(struct tegra_clk_pll *pll)
+{
+	u32 val, val_aux;
+
+	/* ensure parent is set to pll_ref */
+
+	val = pll_readl_base(pll);
+	val_aux = pll_readl(pll->params->aux_reg, pll);
+
+	if (val & PLL_BASE_ENABLE) {
+		if ((val_aux & PLLE_AUX_PLLRE_SEL) ||
+		    (val_aux & PLLE_AUX_PLLP_SEL))
+			WARN(1, "pll_e enabled with unsupported parent %s\n",
+			     (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
+			     "pll_re_vco");
+	} else {
+		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
+		pll_writel(val_aux, pll->params->aux_reg, pll);
+		fence_udelay(1, pll->clk_base);
+	}
+}
 #endif
 
 static struct tegra_clk_pll *_tegra_init_pll(void __iomem *clk_base,
@@ -2289,6 +2312,21 @@ static const struct clk_ops tegra_clk_pllss_ops = {
 	.set_rate = clk_pllxc_set_rate,
 };
 
+static void _pllss_set_defaults(struct tegra_clk_pll *pll)
+{
+	u32 val;
+
+	pll_writel_misc(PLLSS_MISC_DEFAULT, pll);
+	pll_writel(PLLSS_CFG_DEFAULT, pll->params->ext_misc_reg[0], pll);
+	pll_writel(PLLSS_CTRL1_DEFAULT, pll->params->ext_misc_reg[1], pll);
+	pll_writel(PLLSS_CTRL2_DEFAULT, pll->params->ext_misc_reg[2], pll);
+
+	val = pll_readl_base(pll);
+	val &= ~PLLSS_LOCK_OVERRIDE;
+	pll_writel_base(val, pll);
+
+}
+
 struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
 				void __iomem *clk_base, unsigned long flags,
 				struct tegra_clk_pll_params *pll_params,
@@ -2339,10 +2377,7 @@ struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
 
 	_update_pll_mnp(pll, &cfg);
 
-	pll_writel_misc(PLLSS_MISC_DEFAULT, pll);
-	pll_writel(PLLSS_CFG_DEFAULT, pll_params->ext_misc_reg[0], pll);
-	pll_writel(PLLSS_CTRL1_DEFAULT, pll_params->ext_misc_reg[1], pll);
-	pll_writel(PLLSS_CTRL1_DEFAULT, pll_params->ext_misc_reg[2], pll);
+	_pllss_set_defaults(pll);
 
 	val = pll_readl_base(pll);
 	val_iddq = readl_relaxed(clk_base + pll_params->iddq_reg);
@@ -2546,27 +2581,12 @@ struct clk *tegra_clk_register_plle_tegra210(const char *name,
 {
 	struct tegra_clk_pll *pll;
 	struct clk *clk;
-	u32 val, val_aux;
 
 	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
 	if (IS_ERR(pll))
 		return ERR_CAST(pll);
 
-	/* ensure parent is set to pll_re_vco */
-
-	val = pll_readl_base(pll);
-	val_aux = pll_readl(pll_params->aux_reg, pll);
-
-	if (val & PLLE_BASE_ENABLE) {
-		if ((val_aux & PLLE_AUX_PLLRE_SEL) ||
-			(val_aux & PLLE_AUX_PLLP_SEL))
-			WARN(1, "pll_e enabled with unsupported parent %s\n",
-			  (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
-					"pll_re_vco");
-	} else {
-		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
-		pll_writel(val_aux, pll_params->aux_reg, pll);
-	}
+	_clk_plle_tegra_init_parent(pll);
 
 	clk = _tegra_clk_register_pll(pll, name, parent_name, flags,
 				      &tegra_clk_plle_tegra210_ops);
@@ -2710,3 +2730,163 @@ struct clk *tegra_clk_register_pllmb(const char *name, const char *parent_name,
 }
 
 #endif
+
+#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARCH_TEGRA_210_SOC)
+void tegra_clk_pll_resume(struct clk *c, unsigned long rate)
+{
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+
+	if (clk_pll_is_enabled(hw))
+		return;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	if (pll->params->set_defaults)
+		pll->params->set_defaults(pll);
+
+	clk_set_rate(c, rate);
+	clk_enable(c);
+}
+
+void tegra_clk_sync_state_pll(struct clk *c)
+{
+	struct clk_hw *hw = __clk_get_hw(c);
+
+	if (!__clk_get_enable_count(c))
+		clk_pll_disable(hw);
+}
+
+void tegra_clk_pllcx_resume(struct clk *c, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(c);
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	struct tegra_clk_pll_freq_table cfg;
+	unsigned long parent_rate;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_get_rate(parent);
+
+	cfg.n = 0;
+	cfg.p = 0;
+	cfg.m = _pll_fixed_mdiv(pll->params, parent_rate);
+
+	pll_writel_base(0, pll);
+	_update_pll_mnp(pll, &cfg);
+
+	pll_writel_misc(PLLCX_MISC_DEFAULT, pll);
+	pll_writel(PLLCX_MISC1_DEFAULT, pll->params->ext_misc_reg[0], pll);
+	pll_writel(PLLCX_MISC2_DEFAULT, pll->params->ext_misc_reg[1], pll);
+	pll_writel(PLLCX_MISC3_DEFAULT, pll->params->ext_misc_reg[2], pll);
+
+	_pllcx_update_dynamic_coef(pll, parent_rate, cfg.n);
+
+	clk_pllc_set_rate(hw, rate, parent_rate);
+	clk_pllc_enable(hw);
+}
+
+void tegra_clk_pllxc_resume(struct clk *c, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(c);
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	unsigned long parent_rate;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_get_rate(parent);
+
+	if (_setup_dynamic_ramp(pll->params, pll->clk_base, parent_rate))
+		return;
+
+	clk_pllxc_set_rate(hw, rate, parent_rate);
+	clk_pll_enable(hw);
+}
+
+void tegra_clk_pllre_vco_resume(struct clk *c, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(c);
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	unsigned long parent_rate;
+	u32 val;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_get_rate(parent);
+
+	/* disable lock override */
+	val = pll_readl_misc(pll);
+	val &= ~BIT(29);
+	pll_writel_misc(val, pll);
+
+	clk_pllre_set_rate(hw, rate, parent_rate);
+	clk_pll_enable(hw);
+}
+
+void tegra_clk_pllu_resume(struct clk *c, unsigned long rate)
+{
+	struct clk *parent = clk_get_parent(c);
+	struct clk_hw *hw = __clk_get_hw(c);
+	unsigned long parent_rate;
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_get_rate(parent);
+	clk_pllre_set_rate(hw, rate, parent_rate);
+	clk_enable(c);
+}
+
+void tegra_clk_plle_tegra210_resume(struct clk *c)
+{
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+
+	_clk_plle_tegra_init_parent(pll);
+}
+
+void tegra_clk_pllss_resume(struct clk *c, unsigned long rate)
+{
+	struct clk_hw *hw = __clk_get_hw(c);
+	struct clk *parent = clk_get_parent(c);
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	struct tegra_clk_pll_freq_table cfg;
+	unsigned long parent_rate;
+
+	if (clk_pll_is_enabled(hw))
+		return; /* already resumed */
+
+	if (IS_ERR(parent)) {
+		WARN_ON(1);
+		return;
+	}
+
+	parent_rate = clk_get_rate(parent);
+
+	_get_pll_mnp(pll, &cfg);
+	cfg.m = _pll_fixed_mdiv(pll->params, parent_rate);
+	_update_pll_mnp(pll, &cfg);
+
+	_pllss_set_defaults(pll);
+	clk_pllxc_set_rate(hw, rate, parent_rate);
+	clk_pll_enable(hw);
+}
+#endif
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 09bccbb9640c..c82633686820 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -841,6 +841,20 @@ int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
 int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		 u8 frac_width, u8 flags);
 
+#ifdef CONFIG_PM_SLEEP
+void tegra_clk_pll_resume(struct clk *c, unsigned long rate);
+void tegra_clk_pllcx_resume(struct clk *c, unsigned long rate);
+void tegra_clk_pllxc_resume(struct clk *c, unsigned long rate);
+void tegra_clk_pllre_vco_resume(struct clk *c, unsigned long rate);
+void tegra_clk_pllu_resume(struct clk *c, unsigned long rate);
+void tegra_clk_pllss_resume(struct clk *c, unsigned long rate);
+void tegra_clk_divider_resume(struct clk_hw *hw, unsigned long rate);
+void tegra_clk_pll_out_resume(struct clk *clk, unsigned long rate);
+void tegra_clk_plle_tegra210_resume(struct clk *c);
+void tegra_clk_sync_state_pll(struct clk *c);
+void tegra_clk_sync_state_pll_out(struct clk *clk);
+#endif
+
 
 /* Combined read fence with delay */
 #define fence_udelay(delay, reg)	\
-- 
2.7.4

