Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155CC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8532087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjfCFtLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFPXgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFPXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so5112026lfm.12;
        Sun, 16 Jun 2019 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wedrmmB3duBDUMk4gL7cFPZmkqp4y2CptQlKceXLMM=;
        b=hjfCFtLccJNY3pMCByhgS/c5ZLlDvQi7RHMP7SlSXASdbDGlloDIn5smR07tBiUi+L
         UQx0qxH+ETyOl/RgZyCveOdutdFqNhvpbaffu+xyNpp3bpjdHQWVyNxP12N/8f2wJK6o
         lb/jTCfyfL67eNLIzym/z9SngDiGx9sVyP9g943a4xhB5EZRDWr52uI28h3mexWg3UKc
         Sw9ool6WEtlaRy4QEUuafs9n854FKKRSifOPsXfQ8Zy/wKdWuhSW/dVtPMVrv6dx8yV9
         tuH736qHvyd7Bq9cV7de4B2tBGFRJXb9RJAL72EP8KFNV1wqJakcxrdZkjc8VAGwDJXl
         f/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wedrmmB3duBDUMk4gL7cFPZmkqp4y2CptQlKceXLMM=;
        b=uDK9ektWwgJ2R/GD8GmWcAyBSLEA5wRaSbkk3jpLYmGY8aZAHyl087OZez4XOhI5xM
         +Co+WLCYPG/xEJ8WWUHHHc5NMRiycfy7sjNBB0c8VTEPu+8XsXuFi0/S+nJLCVwE2qBe
         1j0LvwznWhNTY9P51Jps8H9DrFM8XKTHZ9ngKkxTAfFnnMTOXRVT0gglF3ShG/t0V0XL
         ntIVNPUIb9PQwyvxoWtoBeF4Q4sIA3ekA7KgDLYxYNfmhUqO8IPRzrSA4h/6GoBVrUbM
         NP/mrusQkUmafjLinA6DEB3CUjeq9B4UriVfZgMuXf5p4j+iyagabMmeATK+7JT//g8A
         6SXg==
X-Gm-Message-State: APjAAAXF6/DsqN8ELle1WKsxNhefmgI20AdmvNKDQE4Vp1prfq7QzFWF
        10EfVJAtc114YyUDvS/q0DQ=
X-Google-Smtp-Source: APXvYqwyXKfjnJZNEDntqLj0zW5kpxG+CMaqP6tOePejpbGC+fqArrTI7aBcxe4XUimTiR1JgS+5xg==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr47465956lfi.130.1560728165960;
        Sun, 16 Jun 2019 16:36:05 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock implementation
Date:   Mon, 17 Jun 2019 02:35:42 +0300
Message-Id: <20190616233551.6838-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A proper External Memory Controller clock rounding and parent selection
functionality is required by the EMC drivers. It is not available using
the generic clock implementation, hence add a custom one. The clock rate
rounding shall be done by the EMC drivers because they have information
about available memory timings, so the drivers will have to register a
callback that will round the requested rate. EMC clock users won't be able
to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
and the callback is set up. The functionality is somewhat similar to the
clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
more parent clock sources and the HW configuration and integration with
the EMC drivers differs a tad from the older gens, hence it's not really
worth to try to squash everything into a single source file.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/Makefile          |   2 +
 drivers/clk/tegra/clk-tegra20-emc.c | 305 ++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c     |  55 ++---
 drivers/clk/tegra/clk-tegra30.c     |  38 +++-
 drivers/clk/tegra/clk.h             |   6 +
 include/linux/clk/tegra.h           |  14 ++
 6 files changed, 368 insertions(+), 52 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 4812e45c2214..df966ca06788 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
 obj-y					+= clk-tegra-super-gen4.o
 obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
 obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
new file mode 100644
index 000000000000..b7f64ad5c04c
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/tegra.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK	GENMASK(7, 0)
+#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK		GENMASK(31, 30)
+#define CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT		30
+
+#define MC_EMC_SAME_FREQ	BIT(16)
+#define USE_PLLM_UD		BIT(29)
+
+#define EMC_SRC_PLL_M		0
+#define EMC_SRC_PLL_C		1
+#define EMC_SRC_PLL_P		2
+#define EMC_SRC_CLK_M		3
+
+static const char * const emc_parent_clk_names[] = {
+	"pll_m", "pll_c", "pll_p", "clk_m",
+};
+
+struct tegra_clk_emc {
+	struct clk_hw hw;
+	void __iomem *reg;
+	bool mc_same_freq;
+	bool want_low_jitter;
+
+	tegra20_clk_emc_round_cb *round_cb;
+	void *cb_arg;
+};
+
+static inline struct tegra_clk_emc *to_tegra_clk_emc(struct clk_hw *hw)
+{
+	return container_of(hw, struct tegra_clk_emc, hw);
+}
+
+static unsigned long emc_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	u32 val, div;
+
+	val = readl_relaxed(emc->reg);
+	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+
+	return DIV_ROUND_UP(parent_rate * 2, div + 2);
+}
+
+static u8 emc_get_parent(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+
+	return readl_relaxed(emc->reg) >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+}
+
+static int emc_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	u32 val, div;
+
+	val = readl_relaxed(emc->reg);
+	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
+	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+
+	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+
+	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
+		val |= USE_PLLM_UD;
+	else
+		val &= ~USE_PLLM_UD;
+
+	if (emc->mc_same_freq)
+		val |= MC_EMC_SAME_FREQ;
+	else
+		val &= ~MC_EMC_SAME_FREQ;
+
+	writel_relaxed(val, emc->reg);
+
+	fence_udelay(1, emc->reg);
+
+	return 0;
+}
+
+static int emc_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	unsigned int index;
+	u32 val, div;
+
+	div = div_frac_get(rate, parent_rate, 8, 1, 0);
+
+	val = readl_relaxed(emc->reg);
+	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+	val |= div;
+
+	index = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+
+	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
+		val |= USE_PLLM_UD;
+	else
+		val &= ~USE_PLLM_UD;
+
+	if (emc->mc_same_freq)
+		val |= MC_EMC_SAME_FREQ;
+	else
+		val &= ~MC_EMC_SAME_FREQ;
+
+	writel_relaxed(val, emc->reg);
+
+	fence_udelay(1, emc->reg);
+
+	return 0;
+}
+
+static int emc_set_rate_and_parent(struct clk_hw *hw,
+				   unsigned long rate,
+				   unsigned long parent_rate,
+				   u8 index)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	u32 val, div;
+
+	div = div_frac_get(rate, parent_rate, 8, 1, 0);
+
+	val = readl_relaxed(emc->reg);
+
+	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
+	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+
+	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+	val |= div;
+
+	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
+		val |= USE_PLLM_UD;
+	else
+		val &= ~USE_PLLM_UD;
+
+	if (emc->mc_same_freq)
+		val |= MC_EMC_SAME_FREQ;
+	else
+		val &= ~MC_EMC_SAME_FREQ;
+
+	writel_relaxed(val, emc->reg);
+
+	fence_udelay(1, emc->reg);
+
+	return 0;
+}
+
+static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	struct clk_hw *parent_hw;
+	unsigned long divided_rate;
+	unsigned long parent_rate;
+	unsigned int i;
+	long emc_rate;
+	int div;
+
+	emc_rate = emc->round_cb(req->rate, req->min_rate, req->max_rate,
+				 emc->cb_arg);
+	if (emc_rate < 0)
+		return emc_rate;
+
+	for (i = 0; i < ARRAY_SIZE(emc_parent_clk_names); i++) {
+		parent_hw = clk_hw_get_parent_by_index(hw, i);
+
+		if (req->best_parent_hw == parent_hw)
+			parent_rate = req->best_parent_rate;
+		else
+			parent_rate = clk_hw_get_rate(parent_hw);
+
+		if (emc_rate > parent_rate)
+			continue;
+
+		div = div_frac_get(emc_rate, parent_rate, 8, 1, 0);
+		divided_rate = DIV_ROUND_UP(parent_rate * 2, div + 2);
+
+		if (divided_rate != emc_rate)
+			continue;
+
+		req->best_parent_rate = parent_rate;
+		req->best_parent_hw = parent_hw;
+		req->rate = emc_rate;
+		break;
+	}
+
+	if (i == ARRAY_SIZE(emc_parent_clk_names)) {
+		pr_err_once("%s: can't find parent for rate %lu emc_rate %lu\n",
+			    __func__, req->rate, emc_rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops tegra_clk_emc_ops = {
+	.recalc_rate = emc_recalc_rate,
+	.get_parent = emc_get_parent,
+	.set_parent = emc_set_parent,
+	.set_rate = emc_set_rate,
+	.set_rate_and_parent = emc_set_rate_and_parent,
+	.determine_rate = emc_determine_rate,
+};
+
+void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
+					void *cb_arg)
+{
+	struct clk *clk = __clk_lookup("emc");
+	struct tegra_clk_emc *emc;
+	struct clk_hw *hw;
+
+	if (clk) {
+		hw = __clk_get_hw(clk);
+		emc = to_tegra_clk_emc(hw);
+
+		emc->round_cb = round_cb;
+		emc->cb_arg = cb_arg;
+	}
+}
+
+bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw)
+{
+	return to_tegra_clk_emc(emc_hw)->round_cb != NULL;
+}
+
+struct clk *tegra20_clk_register_emc(void __iomem *ioaddr)
+{
+	struct tegra_clk_emc *emc;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	emc = kzalloc(sizeof(*emc), GFP_KERNEL);
+	if (!emc)
+		return NULL;
+
+	init.name = "emc";
+	init.ops = &tegra_clk_emc_ops;
+	init.flags = CLK_IS_CRITICAL;
+	init.parent_names = emc_parent_clk_names;
+	init.num_parents = ARRAY_SIZE(emc_parent_clk_names);
+
+	emc->reg = ioaddr;
+	emc->hw.init = &init;
+
+	clk = clk_register(NULL, &emc->hw);
+	if (IS_ERR(clk)) {
+		kfree(emc);
+		return NULL;
+	}
+
+	return clk;
+}
+
+void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_cb,
+					void *cb_arg)
+{
+	tegra20_clk_set_emc_round_callback(round_cb, cb_arg);
+}
+
+bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw)
+{
+	return tegra20_clk_emc_driver_available(emc_hw);
+}
+
+struct clk *tegra30_clk_register_emc(void __iomem *ioaddr)
+{
+	struct tegra_clk_emc *emc;
+	struct clk_hw *hw;
+	struct clk *clk;
+
+	clk = tegra20_clk_register_emc(ioaddr);
+	if (!clk)
+		return NULL;
+
+	hw = __clk_get_hw(clk);
+	emc = to_tegra_clk_emc(hw);
+	emc->want_low_jitter = true;
+
+	return clk;
+}
+
+int tegra30_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
+{
+	struct tegra_clk_emc *emc;
+	struct clk_hw *hw;
+
+	if (emc_clk) {
+		hw = __clk_get_hw(emc_clk);
+		emc = to_tegra_clk_emc(hw);
+		emc->mc_same_freq = same;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index bcd871134f45..f937a0f35afb 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -130,8 +130,6 @@ static struct cpu_clk_suspend_context {
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
-static DEFINE_SPINLOCK(emc_lock);
-
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, NULL, NULL, _parents, _offset,	\
@@ -760,7 +758,6 @@ static const char *pwm_parents[] = { "pll_p", "pll_c", "audio", "clk_m",
 static const char *mux_pllpcm_clkm[] = { "pll_p", "pll_c", "pll_m", "clk_m" };
 static const char *mux_pllpdc_clkm[] = { "pll_p", "pll_d_out0", "pll_c",
 					 "clk_m" };
-static const char *mux_pllmcp_clkm[] = { "pll_m", "pll_c", "pll_p", "clk_m" };
 
 static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_MUX("i2s1", i2s1_parents,     CLK_SOURCE_I2S1,   11, TEGRA_PERIPH_ON_APB, TEGRA20_CLK_I2S1),
@@ -787,41 +784,6 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 	TEGRA_INIT_DATA_NODIV("disp2",	mux_pllpdc_clkm, CLK_SOURCE_DISP2, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
 };
 
-static void __init tegra20_emc_clk_init(void)
-{
-	const u32 use_pllm_ud = BIT(29);
-	struct clk *clk;
-	u32 emc_reg;
-
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, &emc_lock);
-
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
-	clks[TEGRA20_CLK_MC] = clk;
-
-	/* un-divided pll_m_out0 is currently unsupported */
-	emc_reg = readl_relaxed(clk_base + CLK_SOURCE_EMC);
-	if (emc_reg & use_pllm_ud) {
-		pr_err("%s: un-divided PllM_out0 used as clock source\n",
-		       __func__);
-		return;
-	}
-
-	/*
-	 * Note that 'emc_mux' source and 'emc' rate shouldn't be changed at
-	 * the same time due to a HW bug, this won't happen because we're
-	 * defining 'emc_mux' and 'emc' as distinct clocks.
-	 */
-	clk = tegra_clk_register_divider("emc", "emc_mux",
-				clk_base + CLK_SOURCE_EMC, CLK_IS_CRITICAL,
-				TEGRA_DIVIDER_INT, 0, 8, 1, &emc_lock);
-	clks[TEGRA20_CLK_EMC] = clk;
-}
-
 static void __init tegra20_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
@@ -835,7 +797,13 @@ static void __init tegra20_periph_clk_init(void)
 	clks[TEGRA20_CLK_AC97] = clk;
 
 	/* emc */
-	tegra20_emc_clk_init();
+	clk = tegra20_clk_register_emc(clk_base + CLK_SOURCE_EMC);
+
+	clks[TEGRA20_CLK_EMC] = clk;
+
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
+				    NULL);
+	clks[TEGRA20_CLK_MC] = clk;
 
 	/* dsi */
 	clk = tegra_clk_register_periph_gate("dsi", "pll_d", 0, clk_base, 0,
@@ -1115,6 +1083,8 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 	if (IS_ERR(clk))
 		return clk;
 
+	hw = __clk_get_hw(clk);
+
 	/*
 	 * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
 	 * clock is created by the pinctrl driver. It is possible for clk user
@@ -1124,13 +1094,16 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 	 */
 	if (clkspec->args[0] == TEGRA20_CLK_CDEV1 ||
 	    clkspec->args[0] == TEGRA20_CLK_CDEV2) {
-		hw = __clk_get_hw(clk);
-
 		parent_hw = clk_hw_get_parent(hw);
 		if (!parent_hw)
 			return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	if (clkspec->args[0] == TEGRA20_CLK_EMC) {
+		if (!tegra20_clk_emc_driver_available(hw))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	return clk;
 }
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 7b4c6a488527..fab075808c20 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -151,7 +151,6 @@ static unsigned long input_freq;
 
 static DEFINE_SPINLOCK(cml_lock);
 static DEFINE_SPINLOCK(pll_d_lock);
-static DEFINE_SPINLOCK(emc_lock);
 
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
@@ -808,7 +807,7 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_pll_a] = { .dt_id = TEGRA30_CLK_PLL_A, .present = true },
 	[tegra_clk_pll_a_out0] = { .dt_id = TEGRA30_CLK_PLL_A_OUT0, .present = true },
 	[tegra_clk_cec] = { .dt_id = TEGRA30_CLK_CEC, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA30_CLK_EMC, .present = true },
+	[tegra_clk_emc] = { .dt_id = TEGRA30_CLK_EMC, .present = false },
 };
 
 static const char *pll_e_parents[] = { "pll_ref", "pll_p" };
@@ -995,7 +994,6 @@ static void __init tegra30_super_clk_init(void)
 static const char *mux_pllacp_clkm[] = { "pll_a_out0", "unused", "pll_p",
 					 "clk_m" };
 static const char *mux_pllpcm_clkm[] = { "pll_p", "pll_c", "pll_m", "clk_m" };
-static const char *mux_pllmcp_clkm[] = { "pll_m", "pll_c", "pll_p", "clk_m" };
 static const char *spdif_out_parents[] = { "pll_a_out0", "spdif_2x", "pll_p",
 					   "clk_m" };
 static const char *mux_pllmcpa[] = { "pll_m", "pll_c", "pll_p", "pll_a_out0" };
@@ -1044,14 +1042,12 @@ static void __init tegra30_periph_clk_init(void)
 	clks[TEGRA30_CLK_AFI] = clk;
 
 	/* emc */
-	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
-			       ARRAY_SIZE(mux_pllmcp_clkm),
-			       CLK_SET_RATE_NO_REPARENT,
-			       clk_base + CLK_SOURCE_EMC,
-			       30, 2, 0, &emc_lock);
+	clk = tegra30_clk_register_emc(clk_base + CLK_SOURCE_EMC);
+
+	clks[TEGRA30_CLK_EMC] = clk;
 
-	clk = tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOURCE_EMC,
-				    &emc_lock);
+	clk = tegra_clk_register_mc("mc", "emc", clk_base + CLK_SOURCE_EMC,
+				    NULL);
 	clks[TEGRA30_CLK_MC] = clk;
 
 	/* cml0 */
@@ -1302,6 +1298,26 @@ static struct tegra_audio_clk_info tegra30_audio_plls[] = {
 	{ "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
 };
 
+static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
+					       void *data)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+
+	clk = of_clk_src_onecell_get(clkspec, data);
+	if (IS_ERR(clk))
+		return clk;
+
+	hw = __clk_get_hw(clk);
+
+	if (clkspec->args[0] == TEGRA30_CLK_EMC) {
+		if (!tegra30_clk_emc_driver_available(hw))
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return clk;
+}
+
 static void __init tegra30_clock_init(struct device_node *np)
 {
 	struct device_node *node;
@@ -1345,7 +1361,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
 
-	tegra_add_of_provider(np, of_clk_src_onecell_get);
+	tegra_add_of_provider(np, tegra30_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra30_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 905bf1096558..1eb2ec20e343 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -838,4 +838,10 @@ int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		udelay(delay);		\
 	} while (0)
 
+bool tegra20_clk_emc_driver_available(struct clk_hw *emc_hw);
+struct clk *tegra20_clk_register_emc(void __iomem *ioaddr);
+
+bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw);
+struct clk *tegra30_clk_register_emc(void __iomem *ioaddr);
+
 #endif /* TEGRA_CLK_H */
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index b8aef62cc3f5..8546e28aa518 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -119,4 +119,18 @@ extern void tegra210_put_utmipll_in_iddq(void);
 extern void tegra210_put_utmipll_out_iddq(void);
 extern int tegra210_clk_handle_mbist_war(unsigned int id);
 
+struct clk;
+
+typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
+					void *arg);
+#define tegra30_clk_emc_round_cb	tegra20_clk_emc_round_cb
+
+void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
+					void *cb_arg);
+void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_cb,
+					void *cb_arg);
+int tegra30_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
+
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
2.22.0

