Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA082084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pN7OVEEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfDKWra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:47:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37856 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDKWra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:47:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so1619193lfl.4;
        Thu, 11 Apr 2019 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXGKnqPAfm/VOTqSJsOjfJwerwiHM2T4SpkoKyggtt0=;
        b=pN7OVEEIj9XfOR1xsIjXaOwo0arCTMdzxfTVW0MpcZASJAr+p1kFW+stYztvmjIJ6Y
         +46RkYzehuhr/Qiev6TBfhDAer8BMPsEilMs5wAsXCTs4Rwle9k9mH+dLmvr9NCVnIz6
         FLnECWD6MaM+/aXDG7YKEeVNkDX50iZZ90xXSJLHonLV8TvxZgL/SGYAMpv+17oaM9uQ
         wDMGh/xXje67AXww4dX+4B9cOSXOlTNT2v4wptQDiw0kDnWafE3uvmjm9QanhESxRH9D
         ca89kXk1I1R9IOhXwnlEGcYlo3Q2FSdU2Al5II9R3xbwf1bAa8Rtl5OO1CJIhnsCmzx0
         33Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uXGKnqPAfm/VOTqSJsOjfJwerwiHM2T4SpkoKyggtt0=;
        b=fRmF+lDdtLX6AT4Z6UqN+FdrImOQvkTWSP/xD0xleD77cVXGGxIog85n+pbMgvC4u+
         w3SOtZ6R/eComVcA84R8mTeLv43hOtLHE0yrec5/LVy94rmd4cYD6qKKGntPZwd1Lwuo
         iNN3fNmIVJeXMte+x5iiZQe8CBRfoZgo6daKiiU5pPuPNBsjxletZeZ/Jxxai88kJcoz
         7bHLwsqMgTlF/ojGeMKn5b3VxsSv12KMpE1E4dWKEN2QcywQ3EE2efgPow1DcEtY9zs6
         4OYE6sVXA9WxEV8B0QJVo5SO1oZ9brGuSy68Zuc3tHVNnMLWLMww9zXIHqNPT8fihJe/
         nstQ==
X-Gm-Message-State: APjAAAU56kkDdWcOdUfnyWXhbYERzSSBrXk1Aaby+zgAPa4Y5q8TGRcm
        lXrC3JbEKl9BUlthhgRLhgM=
X-Google-Smtp-Source: APXvYqy1d+AkSaiE5J801XCI+CPy+5Sxpjz0bOdpq1RtgnVNCnrJnQI/5mik9r0sOtV34mitY9thOA==
X-Received: by 2002:a19:4c41:: with SMTP id z62mr29272067lfa.9.1555022847064;
        Thu, 11 Apr 2019 15:47:27 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id 30sm7839182ljv.79.2019.04.11.15.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:47:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra20/30: Add custom EMC clock implementation
Date:   Fri, 12 Apr 2019 01:47:08 +0300
Message-Id: <20190411224708.29103-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
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
 drivers/clk/tegra/clk-tegra20-emc.c | 274 ++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c     |  51 ++----
 drivers/clk/tegra/clk-tegra30.c     |  35 ++--
 drivers/clk/tegra/clk.h             |   6 +
 include/linux/clk/tegra.h           |   3 +
 6 files changed, 321 insertions(+), 50 deletions(-)
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
index 000000000000..2cc8f16cd136
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk/tegra.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK	0xff
+#define CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT		30
+#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK		0xc0000000
+
+#define CLK_SOURCE_EMC	0x19c
+
+#define USE_PLLM_UD	BIT(29)
+
+#define EMC_SRC_PLL_M	0
+#define EMC_SRC_PLL_C	1
+#define EMC_SRC_PLL_P	2
+#define EMC_SRC_CLK_M	3
+
+static const char * const emc_parent_clk_names[] = {
+	"pll_m", "pll_c", "pll_p", "clk_m",
+};
+
+struct tegra_clk_emc {
+	struct clk_hw hw;
+	void __iomem *ioaddr;
+	bool want_low_jitter;
+
+	long (*round_cb)(unsigned long, unsigned long, unsigned long, void *);
+	void *arg_cb;
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
+	val = readl_relaxed(emc->ioaddr);
+	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+
+	return DIV_ROUND_UP(parent_rate * 2, div + 2);
+}
+
+static u8 emc_get_parent(struct clk_hw *hw)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+
+	return readl_relaxed(emc->ioaddr) >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+}
+
+static int emc_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	u32 val, div;
+
+	val = readl_relaxed(emc->ioaddr);
+	div = val & CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+	val &= ~CLK_SOURCE_EMC_2X_CLK_SRC_MASK;
+	val |= index << CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+
+	if (index == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
+		val |= USE_PLLM_UD;
+	else
+		val &= ~USE_PLLM_UD;
+
+	writel_relaxed(val, emc->ioaddr);
+
+	return 0;
+}
+
+static int emc_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct tegra_clk_emc *emc = to_tegra_clk_emc(hw);
+	unsigned int parent;
+	u32 val, div;
+
+	div = div_frac_get(rate, parent_rate, 8, 1, 0);
+
+	val = readl_relaxed(emc->ioaddr);
+	val &= ~CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK;
+	val |= div;
+
+	parent = val >> CLK_SOURCE_EMC_2X_CLK_SRC_SHIFT;
+
+	if (parent == EMC_SRC_PLL_M && div == 0 && emc->want_low_jitter)
+		val |= USE_PLLM_UD;
+	else
+		val &= ~USE_PLLM_UD;
+
+	writel_relaxed(val, emc->ioaddr);
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
+	val = readl_relaxed(emc->ioaddr);
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
+	writel_relaxed(val, emc->ioaddr);
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
+				 emc->arg_cb);
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
+		WARN_ONCE(1, "can't find parent for rate %lu emc_rate %lu\n",
+			  req->rate, emc_rate);
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
+void tegra20_clk_set_emc_round_callback(void *round_cb, void *arg_cb)
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
+		emc->arg_cb = arg_cb;
+	}
+}
+
+bool tegra20_clk_emc_scaling_available(void)
+{
+	struct clk *clk = __clk_lookup("emc");
+	struct tegra_clk_emc *emc;
+	struct clk_hw *hw;
+
+	if (clk) {
+		hw = __clk_get_hw(clk);
+		emc = to_tegra_clk_emc(hw);
+
+		return !!emc->round_cb;
+	}
+
+	return false;
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
+	emc->ioaddr = ioaddr;
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
+void tegra30_clk_set_emc_round_callback(void *round_cb, void *arg_cb)
+{
+	tegra20_clk_set_emc_round_callback(round_cb, arg_cb);
+}
+
+bool tegra30_clk_emc_scaling_available(void)
+{
+	return tegra20_clk_emc_scaling_available();
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
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index c71b61162a32..6f8b3795d33f 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -141,8 +141,6 @@ static struct cpu_clk_suspend_context {
 static void __iomem *clk_base;
 static void __iomem *pmc_base;
 
-static DEFINE_SPINLOCK(emc_lock);
-
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
 	TEGRA_INIT_DATA(_name, NULL, NULL, _parents, _offset,	\
@@ -771,7 +769,6 @@ static const char *pwm_parents[] = { "pll_p", "pll_c", "audio", "clk_m",
 static const char *mux_pllpcm_clkm[] = { "pll_p", "pll_c", "pll_m", "clk_m" };
 static const char *mux_pllpdc_clkm[] = { "pll_p", "pll_d_out0", "pll_c",
 					 "clk_m" };
-static const char *mux_pllmcp_clkm[] = { "pll_m", "pll_c", "pll_p", "clk_m" };
 
 static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_MUX("i2s1", i2s1_parents,     CLK_SOURCE_I2S1,   11, TEGRA_PERIPH_ON_APB, TEGRA20_CLK_I2S1),
@@ -798,41 +795,6 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
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
@@ -846,7 +808,13 @@ static void __init tegra20_periph_clk_init(void)
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
@@ -1142,6 +1110,11 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 			return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	if (clkspec->args[0] == TEGRA20_CLK_EMC) {
+		if (!tegra20_clk_emc_scaling_available())
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
 	return clk;
 }
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index fa8d573ac626..68aec6af4867 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -162,7 +162,6 @@ static unsigned long input_freq;
 
 static DEFINE_SPINLOCK(cml_lock);
 static DEFINE_SPINLOCK(pll_d_lock);
-static DEFINE_SPINLOCK(emc_lock);
 
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
@@ -819,7 +818,7 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_pll_a] = { .dt_id = TEGRA30_CLK_PLL_A, .present = true },
 	[tegra_clk_pll_a_out0] = { .dt_id = TEGRA30_CLK_PLL_A_OUT0, .present = true },
 	[tegra_clk_cec] = { .dt_id = TEGRA30_CLK_CEC, .present = true },
-	[tegra_clk_emc] = { .dt_id = TEGRA30_CLK_EMC, .present = true },
+	[tegra_clk_emc] = { .dt_id = TEGRA30_CLK_EMC, .present = false },
 };
 
 static const char *pll_e_parents[] = { "pll_ref", "pll_p" };
@@ -1006,7 +1005,6 @@ static void __init tegra30_super_clk_init(void)
 static const char *mux_pllacp_clkm[] = { "pll_a_out0", "unused", "pll_p",
 					 "clk_m" };
 static const char *mux_pllpcm_clkm[] = { "pll_p", "pll_c", "pll_m", "clk_m" };
-static const char *mux_pllmcp_clkm[] = { "pll_m", "pll_c", "pll_p", "clk_m" };
 static const char *spdif_out_parents[] = { "pll_a_out0", "spdif_2x", "pll_p",
 					   "clk_m" };
 static const char *mux_pllmcpa[] = { "pll_m", "pll_c", "pll_p", "pll_a_out0" };
@@ -1055,14 +1053,12 @@ static void __init tegra30_periph_clk_init(void)
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
@@ -1313,6 +1309,23 @@ static struct tegra_audio_clk_info tegra30_audio_plls[] = {
 	{ "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
 };
 
+static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
+					       void *data)
+{
+	struct clk *clk;
+
+	clk = of_clk_src_onecell_get(clkspec, data);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (clkspec->args[0] == TEGRA30_CLK_EMC) {
+		if (!tegra30_clk_emc_scaling_available())
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return clk;
+}
+
 static void __init tegra30_clock_init(struct device_node *np)
 {
 	struct device_node *node;
@@ -1356,7 +1369,7 @@ static void __init tegra30_clock_init(struct device_node *np)
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
 
-	tegra_add_of_provider(np, of_clk_src_onecell_get);
+	tegra_add_of_provider(np, tegra30_clk_src_onecell_get);
 	tegra_register_devclks(devclks, ARRAY_SIZE(devclks));
 
 	tegra_clk_apply_init_table = tegra30_clock_apply_init_table;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 09bccbb9640c..7d31914d0916 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -849,4 +849,10 @@ int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		udelay(delay);		\
 	} while (0)
 
+bool tegra20_clk_emc_scaling_available(void);
+struct clk *tegra20_clk_register_emc(void __iomem *ioaddr);
+
+bool tegra30_clk_emc_scaling_available(void);
+struct clk *tegra30_clk_register_emc(void __iomem *ioaddr);
+
 #endif /* TEGRA_CLK_H */
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index afb9edfa5d58..fc5ed7b1489d 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -130,4 +130,7 @@ extern void tegra210_put_utmipll_in_iddq(void);
 extern void tegra210_put_utmipll_out_iddq(void);
 extern int tegra210_clk_handle_mbist_war(unsigned int id);
 
+void tegra20_clk_set_emc_round_callback(void *round_cb, void *arg_cb);
+void tegra30_clk_set_emc_round_callback(void *round_cb, void *arg_cb);
+
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
2.21.0

