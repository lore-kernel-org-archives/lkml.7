Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB352C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F72080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfH1HAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:00:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:20886 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfH1HAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:00:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 00:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="197490889"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2019 00:00:25 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        robhkernel.org@vger.kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
Date:   Wed, 28 Aug 2019 15:00:17 +0800
Message-Id: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: rtanwar <rahul.tanwar@intel.com>

Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
Intel network processor SoC. It provides programming interfaces to control
& configure all CPU & peripheral clocks. Add common clock framework based
clock controller driver for CGU.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/clk/Kconfig             |   1 +
 drivers/clk/Makefile            |   1 +
 drivers/clk/intel/Kconfig       |  13 +
 drivers/clk/intel/Makefile      |   4 +
 drivers/clk/intel/clk-cgu-pll.c | 160 ++++++++++++
 drivers/clk/intel/clk-cgu-pll.h |  24 ++
 drivers/clk/intel/clk-cgu.c     | 544 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/intel/clk-cgu.h     | 278 ++++++++++++++++++++
 drivers/clk/intel/clk-lgm.c     | 352 ++++++++++++++++++++++++++
 9 files changed, 1377 insertions(+)
 create mode 100644 drivers/clk/intel/Kconfig
 create mode 100644 drivers/clk/intel/Makefile
 create mode 100644 drivers/clk/intel/clk-cgu-pll.c
 create mode 100644 drivers/clk/intel/clk-cgu-pll.h
 create mode 100644 drivers/clk/intel/clk-cgu.c
 create mode 100644 drivers/clk/intel/clk-cgu.h
 create mode 100644 drivers/clk/intel/clk-lgm.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd0321..3b2e0106b305 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -336,5 +336,6 @@ source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
+source "drivers/clk/intel/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0cad76021297..f7e2ef6931b7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -117,3 +117,4 @@ endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
 obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
+obj-$(CONFIG_INTEL_LGM_CGU_CLK)		+= intel/
diff --git a/drivers/clk/intel/Kconfig b/drivers/clk/intel/Kconfig
new file mode 100644
index 000000000000..6608ae88a9a7
--- /dev/null
+++ b/drivers/clk/intel/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+config INTEL_LGM_CGU_CLK
+	depends on COMMON_CLK
+	select MFD_SYSCON
+	select OF_EARLY_FLATTREE
+	bool "Intel Clock Genration Unit support"
+	help
+	  Support for clock generation unit driver for Intel Lightning
+	  Mountain(LGM) series SoCs. It is based on Common Clock Framework.
+	  CGU driver provides all means to access the clock generation unit
+	  hardware module of LGM in order to generate a series of clocks for
+	  the whole system and individual peripherals. Choose Y here if you
+	  are building for Lightning Mountain(LGM) platform.
diff --git a/drivers/clk/intel/Makefile b/drivers/clk/intel/Makefile
new file mode 100644
index 000000000000..82741528d2fb
--- /dev/null
+++ b/drivers/clk/intel/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for intel specific clk
+
+obj-$(CONFIG_INTEL_LGM_CGU_CLK) += clk-cgu.o clk-cgu-pll.o clk-lgm.o
diff --git a/drivers/clk/intel/clk-cgu-pll.c b/drivers/clk/intel/clk-cgu-pll.c
new file mode 100644
index 000000000000..e1e9036470df
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu-pll.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "clk-cgu-pll.h"
+#include "clk-cgu.h"
+
+#define to_intel_clk_pll(_hw)	container_of(_hw, struct intel_clk_pll, hw)
+
+/*
+ * Calculate formula:
+ * rate = (prate * mult + (prate * frac) / frac_div) / div
+ */
+static unsigned long
+intel_pll_calc_rate(unsigned long prate, unsigned int mult,
+		    unsigned int div, unsigned int frac, unsigned int frac_div)
+{
+	u64 crate, frate, rate64;
+
+	rate64 = prate;
+	crate = rate64 * mult;
+
+	if (frac) {
+		frate = rate64 * frac;
+		do_div(frate, frac_div);
+		crate += frate;
+	}
+	do_div(crate, div);
+
+	return (unsigned long)crate;
+}
+
+static int intel_pll_wait_for_lock(struct intel_clk_pll *pll)
+{
+	unsigned int v;
+
+	return regmap_read_poll_timeout(pll->map, pll->reg, v, v & 1, 1, 100);
+}
+
+static void
+lgm_pll_get_params(struct intel_clk_pll *pll, unsigned int *mult,
+		   unsigned int *div, unsigned int *frac)
+{
+	*mult = intel_get_clk_val(pll->map, pll->reg + 0x8, 0, 12);
+	*div = intel_get_clk_val(pll->map, pll->reg + 0x8, 18, 6);
+	*frac = intel_get_clk_val(pll->map, pll->reg, 2, 24);
+}
+
+static unsigned long lgm_pll_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct intel_clk_pll *pll = to_intel_clk_pll(hw);
+	unsigned int div, mult, frac;
+
+	lgm_pll_get_params(pll, &mult, &div, &frac);
+	if (pll->type == TYPE_LJPLL)
+		div *= 4;
+
+	return intel_pll_calc_rate(prate, mult, div, frac, BIT(24));
+}
+
+static int lgm_pll_is_enabled(struct clk_hw *hw)
+{
+	struct intel_clk_pll *pll = to_intel_clk_pll(hw);
+
+	return intel_get_clk_val(pll->map, pll->reg, 0, 1);
+}
+
+static int lgm_pll_enable(struct clk_hw *hw)
+{
+	struct intel_clk_pll *pll = to_intel_clk_pll(hw);
+
+	intel_set_clk_val(pll->map, pll->reg, 0, 1, 1);
+	return intel_pll_wait_for_lock(pll);
+}
+
+static void lgm_pll_disable(struct clk_hw *hw)
+{
+	struct intel_clk_pll *pll = to_intel_clk_pll(hw);
+
+	intel_set_clk_val(pll->map, pll->reg, 0, 1, 0);
+}
+
+static long
+lgm_pll_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
+{
+	return lgm_pll_recalc_rate(hw, *prate);
+}
+
+const static struct clk_ops intel_lgm_pll_ops = {
+	.recalc_rate = lgm_pll_recalc_rate,
+	.is_enabled = lgm_pll_is_enabled,
+	.enable = lgm_pll_enable,
+	.disable = lgm_pll_disable,
+	.round_rate = lgm_pll_round_rate,
+};
+
+static struct clk_hw
+*intel_clk_register_pll(struct intel_clk_provider *ctx,
+			const struct intel_pll_clk_data *list)
+{
+	struct clk_init_data init;
+	struct intel_clk_pll *pll;
+	struct device *dev = ctx->dev;
+	struct clk_hw *hw;
+	int ret;
+
+	init.ops = &intel_lgm_pll_ops;
+	init.name = list->name;
+	init.parent_names = list->parent_names;
+	init.num_parents = list->num_parents;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->map = ctx->map;
+	pll->dev = ctx->dev;
+	pll->reg = list->reg;
+	pll->flags = list->flags;
+	pll->type = list->type;
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hw;
+}
+
+void intel_clk_register_plls(struct intel_clk_provider *ctx,
+			     const struct intel_pll_clk_data *list,
+				unsigned int nr_clk)
+{
+	struct clk_hw *hw;
+	int i;
+
+	for (i = 0; i < nr_clk; i++, list++) {
+		hw = intel_clk_register_pll(ctx, list);
+		if (IS_ERR(hw)) {
+			dev_err(ctx->dev, "failed to register pll: %s\n",
+				list->name);
+			continue;
+		}
+
+		intel_clk_add_lookup(ctx, hw, list->id);
+	}
+}
diff --git a/drivers/clk/intel/clk-cgu-pll.h b/drivers/clk/intel/clk-cgu-pll.h
new file mode 100644
index 000000000000..35e25b242cff
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu-pll.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright(c) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+
+#ifndef __INTEL_CLK_PLL_H
+#define __INTEL_CLK_PLL_H
+
+enum pll_type {
+	TYPE_ROPLL,
+	TYPE_LJPLL,
+};
+
+struct intel_clk_pll {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	unsigned long flags;
+	enum pll_type type;
+};
+
+#endif				/* __INTEL_CLK_PLL_H */
diff --git a/drivers/clk/intel/clk-cgu.c b/drivers/clk/intel/clk-cgu.c
new file mode 100644
index 000000000000..bccaca9a81d4
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "clk-cgu-pll.h"
+#include "clk-cgu.h"
+
+#define GATE_HW_REG_STAT(reg)	((reg) + 0x0)
+#define GATE_HW_REG_EN(reg)	((reg) + 0x4)
+#define GATE_HW_REG_DIS(reg)	((reg) + 0x8)
+
+#define to_intel_clk_mux(_hw) container_of(_hw, struct intel_clk_mux, hw)
+#define to_intel_clk_divider(_hw) \
+			container_of(_hw, struct intel_clk_divider, hw)
+#define to_intel_clk_gate(_hw) container_of(_hw, struct intel_clk_gate, hw)
+#define to_intel_clk_ddiv(_hw) container_of(_hw, struct intel_clk_ddiv, hw)
+
+void intel_set_clk_val(struct regmap *map, u32 reg,
+		       u8 shift, u8 width, u32 set_val)
+{
+	u32 mask = (GENMASK(width - 1, 0) << shift);
+
+	regmap_update_bits(map, reg, mask, set_val << shift);
+}
+
+u32 intel_get_clk_val(struct regmap *map, u32 reg, u8 shift, u8 width)
+{
+	u32 val;
+
+	if (regmap_read(map, reg, &val)) {
+		WARN_ONCE(1, "Failed to read clk reg: 0x%x\n", reg);
+		return 0;
+	}
+
+	val >>= shift;
+	val &= BIT(width) - 1;
+
+	return val;
+}
+
+void intel_clk_add_lookup(struct intel_clk_provider *ctx,
+			  struct clk_hw *hw, unsigned int id)
+{
+	pr_debug("Add clk: %s, id: %u\n", clk_hw_get_name(hw), id);
+	if (ctx->clk_data.hws)
+		ctx->clk_data.hws[id] = hw;
+}
+
+static struct clk_hw
+*intel_clk_register_fixed(struct intel_clk_provider *ctx,
+			  const struct intel_clk_branch *list)
+{
+	if (list->div_flags & CLOCK_FLAG_VAL_INIT)
+		intel_set_clk_val(ctx->map, list->div_off, list->div_shift,
+				  list->div_width, list->div_val);
+
+	return clk_hw_register_fixed_rate(NULL, list->name,
+					list->parent_names[0],
+					list->flags, list->mux_flags);
+}
+
+static u8 intel_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct intel_clk_mux *mux = to_intel_clk_mux(hw);
+	u32 val;
+
+	val = intel_get_clk_val(mux->map, mux->reg, mux->shift, mux->width);
+	return clk_mux_val_to_index(hw, NULL, mux->flags, val);
+}
+
+static int intel_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct intel_clk_mux *mux = to_intel_clk_mux(hw);
+	u32 val;
+
+	val = clk_mux_index_to_val(NULL, mux->flags, index);
+	intel_set_clk_val(mux->map, mux->reg, mux->shift, mux->width, val);
+
+	return 0;
+}
+
+static int intel_clk_mux_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct intel_clk_mux *mux = to_intel_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
+const static struct clk_ops intel_clk_mux_ops = {
+	.get_parent = intel_clk_mux_get_parent,
+	.set_parent = intel_clk_mux_set_parent,
+	.determine_rate = intel_clk_mux_determine_rate,
+};
+
+static struct clk_hw
+*intel_clk_register_mux(struct intel_clk_provider *ctx,
+			const struct intel_clk_branch *list)
+{
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	struct intel_clk_mux *mux;
+	struct device *dev = ctx->dev;
+	u32 reg = list->mux_off;
+	u8 shift = list->mux_shift;
+	u8 width = list->mux_width;
+	unsigned long cflags = list->mux_flags;
+	int ret;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &intel_clk_mux_ops;
+	init.flags = list->flags;
+	init.parent_names = list->parent_names;
+	init.num_parents = list->num_parents;
+
+	mux->map = ctx->map;
+	mux->reg = reg;
+	mux->shift = shift;
+	mux->width = width;
+	mux->flags = cflags;
+	mux->dev = dev;
+	mux->hw.init = &init;
+
+	hw = &mux->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cflags & CLOCK_FLAG_VAL_INIT)
+		intel_set_clk_val(ctx->map, reg, shift, width, list->mux_val);
+
+	return hw;
+}
+
+static unsigned long
+intel_clk_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct intel_clk_divider *divider = to_intel_clk_divider(hw);
+	unsigned int val;
+
+	val = intel_get_clk_val(divider->map, divider->reg,
+				divider->shift, divider->width);
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				divider->flags, divider->width);
+}
+
+static long
+intel_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *prate)
+{
+	struct intel_clk_divider *divider = to_intel_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				divider->width, divider->flags);
+}
+
+static int
+intel_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long prate)
+{
+	struct intel_clk_divider *divider = to_intel_clk_divider(hw);
+	int value;
+
+	value = divider_get_val(rate, prate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	intel_set_clk_val(divider->map, divider->reg,
+			  divider->shift, divider->width, value);
+
+	return 0;
+}
+
+const static struct clk_ops intel_clk_divider_ops = {
+	.recalc_rate = intel_clk_divider_recalc_rate,
+	.round_rate = intel_clk_divider_round_rate,
+	.set_rate = intel_clk_divider_set_rate,
+};
+
+static struct clk_hw
+*intel_clk_register_divider(struct intel_clk_provider *ctx,
+				const struct intel_clk_branch *list)
+{
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	struct intel_clk_divider *div;
+	struct device *dev = ctx->dev;
+	unsigned long cflags = list->div_flags;
+	u32 reg = list->div_off;
+	u8 shift = list->div_shift;
+	u8 width = list->div_width;
+	int ret;
+
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &intel_clk_divider_ops;
+	init.flags = list->flags;
+	init.parent_names = &list->parent_names[0];
+	init.num_parents = 1;
+
+	div->map = ctx->map;
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->flags = cflags;
+	div->table = list->div_table;
+	div->dev = dev;
+	div->hw.init = &init;
+
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		dev_err(dev, "register clk: %s failed!\n", list->name);
+		return ERR_PTR(ret);
+	}
+
+	if (cflags & CLOCK_FLAG_VAL_INIT)
+		intel_set_clk_val(ctx->map, reg, shift, width, list->div_val);
+
+	return hw;
+}
+
+static struct clk_hw
+*intel_clk_register_fixed_factor(struct intel_clk_provider *ctx,
+				 const struct intel_clk_branch *list)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_factor(ctx->dev, list->name,
+					  list->parent_names[0], list->flags,
+					  list->mult, list->div);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+
+	if (list->div_flags & CLOCK_FLAG_VAL_INIT)
+		intel_set_clk_val(ctx->map, list->div_off, list->div_shift,
+				  list->div_width, list->div_val);
+
+	return hw;
+}
+
+static int intel_clk_gate_enable(struct clk_hw *hw)
+{
+	struct intel_clk_gate *gate = to_intel_clk_gate(hw);
+	unsigned int reg;
+
+	if (gate->flags & GATE_CLK_HW) {
+		reg = GATE_HW_REG_EN(gate->reg);
+	} else if (gate->flags & GATE_CLK_SW) {
+		reg = gate->reg;
+	} else {
+		dev_err(gate->dev, "%s has not supported flags 0x%lx!\n",
+			clk_hw_get_name(hw), gate->flags);
+		return 0;
+	}
+
+	intel_set_clk_val(gate->map, reg, gate->shift, 1, 1);
+
+	return 0;
+}
+
+static void intel_clk_gate_disable(struct clk_hw *hw)
+{
+	struct intel_clk_gate *gate = to_intel_clk_gate(hw);
+	unsigned int reg;
+	unsigned int set;
+
+	if (gate->flags & GATE_CLK_HW) {
+		reg = GATE_HW_REG_DIS(gate->reg);
+		set = 1;
+	} else if (gate->flags & GATE_CLK_SW) {
+		reg = gate->reg;
+		set = 0;
+	} else {
+		dev_err(gate->dev, "%s has not supported flags 0x%lx!\n",
+			clk_hw_get_name(hw), gate->flags);
+		return;
+	}
+
+	intel_set_clk_val(gate->map, reg, gate->shift, 1, set);
+}
+
+static int intel_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct intel_clk_gate *gate = to_intel_clk_gate(hw);
+	unsigned int reg;
+
+	if (gate->flags & GATE_CLK_HW) {
+		reg = GATE_HW_REG_STAT(gate->reg);
+	} else if (gate->flags & GATE_CLK_SW) {
+		reg = gate->reg;
+	} else {
+		dev_err(gate->dev, "%s has not supported flags 0x%lx!\n",
+			clk_hw_get_name(hw), gate->flags);
+		return 0;
+	}
+
+	return intel_get_clk_val(gate->map, reg, gate->shift, 1);
+}
+
+const static struct clk_ops intel_clk_gate_ops = {
+	.enable = intel_clk_gate_enable,
+	.disable = intel_clk_gate_disable,
+	.is_enabled = intel_clk_gate_is_enabled,
+};
+
+static struct clk_hw
+*intel_clk_register_gate(struct intel_clk_provider *ctx,
+			 const struct intel_clk_branch *list)
+{
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	struct intel_clk_gate *gate;
+	struct device *dev = ctx->dev;
+	u32 reg = list->gate_off;
+	u8 shift = list->gate_shift;
+	unsigned long cflags = list->gate_flags;
+	const char *pname = list->parent_names[0];
+	int ret;
+
+	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = list->name;
+	init.ops = &intel_clk_gate_ops;
+	init.flags = list->flags;
+	init.parent_names = pname ? &pname : NULL;
+	init.num_parents = pname ? 1 : 0;
+
+	gate->map = ctx->map;
+	gate->reg = reg;
+	gate->shift = shift;
+	gate->flags = cflags;
+	gate->dev = dev;
+	gate->hw.init = &init;
+
+	hw = &gate->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (cflags & CLOCK_FLAG_VAL_INIT)
+		intel_set_clk_val(ctx->map, reg, shift, 1, list->gate_val);
+
+	return hw;
+}
+
+void intel_clk_register_branches(struct intel_clk_provider *ctx,
+				 const struct intel_clk_branch *list,
+				 unsigned int nr_clk)
+{
+	struct clk_hw *hw;
+	unsigned int idx;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		switch (list->type) {
+		case intel_clk_fixed:
+			hw = intel_clk_register_fixed(ctx, list);
+			break;
+		case intel_clk_mux:
+			hw = intel_clk_register_mux(ctx, list);
+			break;
+		case intel_clk_divider:
+			hw = intel_clk_register_divider(ctx, list);
+			break;
+		case intel_clk_fixed_factor:
+			hw = intel_clk_register_fixed_factor(ctx, list);
+			break;
+		case intel_clk_gate:
+			hw = intel_clk_register_gate(ctx, list);
+			break;
+		default:
+			dev_err(ctx->dev, "type: %u not supported!\n",
+				list->type);
+			return;
+		}
+
+		if (IS_ERR(hw)) {
+			dev_err(ctx->dev,
+				"register clk: %s, type: %u failed!\n",
+				list->name, list->type);
+			return;
+		}
+		intel_clk_add_lookup(ctx, hw, list->id);
+	}
+}
+
+static unsigned long
+intel_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct intel_clk_ddiv *ddiv = to_intel_clk_ddiv(hw);
+	unsigned int div0, div1, exdiv;
+	u64 prate;
+
+	div0 = intel_get_clk_val(ddiv->map, ddiv->reg,
+				 ddiv->shift0, ddiv->width0) + 1;
+	div1 = intel_get_clk_val(ddiv->map, ddiv->reg,
+				 ddiv->shift1, ddiv->width1) + 1;
+	exdiv = intel_get_clk_val(ddiv->map, ddiv->reg,
+				  ddiv->shift2, ddiv->width2);
+
+	prate = (u64)parent_rate;
+	do_div(prate, div0);
+	do_div(prate, div1);
+
+	if (exdiv) {
+		do_div(prate, ddiv->div);
+		prate *= ddiv->mult;
+	}
+
+	return (unsigned long)prate;
+}
+
+const static struct clk_ops intel_clk_ddiv_ops = {
+	.recalc_rate = intel_clk_ddiv_recalc_rate,
+};
+
+int intel_clk_register_ddiv(struct intel_clk_provider *ctx,
+			    const struct intel_clk_ddiv_data *list,
+			    unsigned int nr_clk)
+{
+	unsigned int idx;
+	struct clk_init_data init;
+	struct intel_clk_ddiv *ddiv;
+	struct device *dev = ctx->dev;
+	struct clk_hw *hw;
+	int ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		ddiv = devm_kzalloc(dev, sizeof(*ddiv), GFP_KERNEL);
+		if (!ddiv)
+			return -ENOMEM;
+
+		memset(&init, 0, sizeof(init));
+		init.name = list->name;
+		init.ops = &intel_clk_ddiv_ops;
+		init.flags = list->flags;
+		init.parent_names = list->parent_name;
+		init.num_parents = 1;
+
+		ddiv->map = ctx->map;
+		ddiv->reg = list->reg;
+		ddiv->shift0 = list->shift0;
+		ddiv->width0 = list->width0;
+		ddiv->shift1 = list->shift1;
+		ddiv->width1 = list->width1;
+		ddiv->shift2 = list->ex_shift;
+		ddiv->width2 = list->ex_width;
+		ddiv->flags = list->div_flags;
+		ddiv->mult = 2;
+		ddiv->div = 5;
+		ddiv->dev = dev;
+		ddiv->hw.init = &init;
+
+		hw = &ddiv->hw;
+		ret = clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "register clk: %s failed!\n", list->name);
+			return ret;
+		}
+
+		intel_clk_add_lookup(ctx, hw, list->id);
+	}
+
+	return 0;
+}
+
+struct intel_clk_provider *__init
+intel_clk_init(struct device *dev, struct regmap *map, unsigned int nr_clks)
+{
+	struct intel_clk_provider *ctx;
+
+	ctx = devm_kzalloc(dev, struct_size(ctx, clk_data.hws, nr_clks),
+			   GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->map = map;
+	ctx->clk_data.num = nr_clks;
+
+	return ctx;
+}
+
+static void
+intel_clk_set_ssc(struct intel_clk_provider *ctx,
+		  u32 reg, u32 spread, u32 dir, u32 div, u32 en)
+{
+	intel_set_clk_val(ctx->map, reg, 2, 5, spread);
+	intel_set_clk_val(ctx->map, reg, 12, 1, dir);
+	intel_set_clk_val(ctx->map, reg, 8, 4, div);
+	intel_set_clk_val(ctx->map, reg, 0, 1, en);
+}
+
+void intel_clk_ssc_probe(struct intel_clk_provider *ctx)
+{
+	struct fwnode_handle *nc, *np_ssc;
+	u32 reg, en, spread, dir, div;
+
+	np_ssc = fwnode_get_named_child_node(dev_fwnode(ctx->dev), "cgussc");
+	if (!np_ssc)
+		return;
+
+	fwnode_for_each_available_child_node(np_ssc, nc) {
+		if (fwnode_property_read_u32(nc, "reg", &reg))
+			continue;
+		if (fwnode_property_read_u32(nc, "intel,ssc-enable", &en))
+			continue;
+		if (fwnode_property_read_u32(nc, "intel,ssc-divval", &div))
+			continue;
+		if (!div) {
+			dev_err(ctx->dev, "divval is Zero!\n");
+			continue;
+		}
+
+		if (fwnode_property_read_u32(nc, "intel,ssc-spread", &spread))
+			spread = 0;
+		if (fwnode_property_read_u32(nc, "intel,ssc-dir", &dir))
+			dir = 0;
+
+		intel_clk_set_ssc(ctx, reg, spread, dir, div, en);
+	}
+
+	fwnode_handle_put(np_ssc);
+}
diff --git a/drivers/clk/intel/clk-cgu.h b/drivers/clk/intel/clk-cgu.h
new file mode 100644
index 000000000000..e44396b4aad7
--- /dev/null
+++ b/drivers/clk/intel/clk-cgu.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright(c) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+
+#ifndef __INTEL_CLK_H
+#define __INTEL_CLK_H
+
+struct intel_clk_mux {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+};
+
+struct intel_clk_divider {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+	const struct clk_div_table *table;
+};
+
+struct intel_clk_ddiv {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift0;
+	u8 width0;
+	u8 shift1;
+	u8 width1;
+	u8 shift2;
+	u8 width2;
+	unsigned int mult;
+	unsigned int div;
+	unsigned long flags;
+};
+
+struct intel_clk_gate {
+	struct clk_hw hw;
+	struct device *dev;
+	struct regmap *map;
+	unsigned int reg;
+	u8 shift;
+	unsigned long flags;
+};
+
+enum intel_clk_type {
+	intel_clk_fixed,
+	intel_clk_mux,
+	intel_clk_divider,
+	intel_clk_fixed_factor,
+	intel_clk_gate,
+};
+
+/**
+ * struct intel_clk_provider
+ * @map: regmap type base address for register.
+ * @np: device node
+ * @dev: device
+ * @clk_data: array of hw clocks and clk number.
+ */
+struct intel_clk_provider {
+	struct regmap *map;
+	struct device_node *np;
+	struct device *dev;
+	struct clk_hw_onecell_data clk_data;
+};
+
+/**
+ * struct intel_pll_clk_data
+ * @id: platform specific id of the clock.
+ * @name: name of this pll clock.
+ * @parent_names: name of the parent clock.
+ * @num_parents: number of parents.
+ * @flags: optional flags for basic clock.
+ * @type: platform type of pll.
+ * @reg: offset of the register.
+ */
+struct intel_pll_clk_data {
+	unsigned int id;
+	const char *name;
+	const char *const *parent_names;
+	u8 num_parents;
+	unsigned long flags;
+	enum pll_type type;
+	int reg;
+};
+
+#define INTEL_PLL(_id, _name, _pnames, _flags,	\
+		  _reg, _type)			\
+	{						\
+		.id		= _id,			\
+		.name		= _name,		\
+		.parent_names	= _pnames,		\
+		.num_parents	= ARRAY_SIZE(_pnames),	\
+		.flags		= _flags,		\
+		.reg		= _reg,			\
+		.type		= _type,		\
+	}
+
+struct intel_clk_ddiv_data {
+	unsigned int id;
+	const char *name;
+	const char *const *parent_name;
+	u8 flags;
+	unsigned long div_flags;
+	unsigned int reg;
+	u8 shift0;
+	u8 width0;
+	u8 shift1;
+	u8 width1;
+	u8 ex_shift;
+	u8 ex_width;
+};
+
+#define INTEL_DDIV(_id, _name, _pname, _flags, _reg,		\
+		   _shft0, _wdth0, _shft1, _wdth1,		\
+		   _xshft, _df)					\
+	{							\
+		.id		= _id,				\
+		.name		= _name,			\
+		.parent_name	= (const char *[]) { _pname },	\
+		.flags		= _flags,			\
+		.reg		= _reg,				\
+		.shift0		= _shft0,			\
+		.width0		= _wdth0,			\
+		.shift1		= _shft1,			\
+		.width1		= _wdth1,			\
+		.ex_shift	= _xshft,			\
+		.ex_width	= 1,				\
+		.div_flags	= _df,				\
+	}
+
+struct intel_clk_branch {
+	unsigned int id;
+	enum intel_clk_type type;
+	const char *name;
+	const char *const *parent_names;
+	u8 num_parents;
+	unsigned long flags;
+	unsigned int mux_off;
+	u8 mux_shift;
+	u8 mux_width;
+	unsigned long mux_flags;
+	unsigned int mux_val;
+	unsigned int div_off;
+	u8 div_shift;
+	u8 div_width;
+	unsigned long div_flags;
+	unsigned int div_val;
+	const struct clk_div_table *div_table;
+	unsigned int gate_off;
+	u8 gate_shift;
+	unsigned long gate_flags;
+	unsigned int gate_val;
+	unsigned int mult;
+	unsigned int div;
+};
+
+/* clock flags definition */
+#define CLOCK_FLAG_VAL_INIT	BIT(16)
+#define GATE_CLK_HW		BIT(17)
+#define GATE_CLK_SW		BIT(18)
+
+#define INTEL_MUX(_id, _name, _pname, _f, _reg,			\
+		  _shift, _width, _cf, _v)			\
+	{							\
+		.id		= _id,				\
+		.type		= intel_clk_mux,		\
+		.name		= _name,			\
+		.parent_names	= _pname,			\
+		.num_parents	= ARRAY_SIZE(_pname),		\
+		.flags		= _f,				\
+		.mux_off	= _reg,				\
+		.mux_shift	= _shift,			\
+		.mux_width	= _width,			\
+		.mux_flags	= _cf,				\
+		.mux_val	= _v,				\
+	}
+
+#define INTEL_DIV(_id, _name, _pname, _f, _reg,			\
+		 _shift, _width, _cf, _v, _dtable)		\
+	{							\
+		.id		= _id,				\
+		.type		= intel_clk_divider,		\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _pname },	\
+		.num_parents	= 1,				\
+		.flags		= _f,				\
+		.div_off	= _reg,				\
+		.div_shift	= _shift,			\
+		.div_width	= _width,			\
+		.div_flags	= _cf,				\
+		.div_val	= _v,				\
+		.div_table	= _dtable,			\
+	}
+
+#define INTEL_GATE(_id, _name, _pname, _f, _reg,		\
+		   _shift, _cf, _v)				\
+	{							\
+		.id		= _id,				\
+		.type		= intel_clk_gate,		\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _pname },	\
+		.num_parents	= !_pname ? 0 : 1,		\
+		.flags		= _f,				\
+		.gate_off	= _reg,				\
+		.gate_shift	= _shift,			\
+		.gate_flags	= _cf,				\
+		.gate_val	= _v,				\
+	}
+
+#define INTEL_FIXED(_id, _name, _pname, _f, _reg,		\
+		    _shift, _width, _cf, _freq, _v)		\
+	{							\
+		.id		= _id,				\
+		.type		= intel_clk_fixed,		\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _pname },	\
+		.num_parents	= !_pname ? 0 : 1,		\
+		.flags		= _f,				\
+		.div_off	= _reg,				\
+		.div_shift	= _shift,			\
+		.div_width	= _width,			\
+		.div_flags	= _cf,				\
+		.div_val	= _v,				\
+		.mux_flags	= _freq,			\
+	}
+
+#define INTEL_FIXED_FACTOR(_id, _name, _pname, _f, _reg,	\
+			   _shift, _width, _cf, _v, _m, _d)	\
+	{							\
+		.id		= _id,				\
+		.type		= intel_clk_fixed_factor,	\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _pname },	\
+		.num_parents	= 1,				\
+		.flags		= _f,				\
+		.div_off	= _reg,				\
+		.div_shift	= _shift,			\
+		.div_width	= _width,			\
+		.div_flags	= _cf,				\
+		.div_val	= _v,				\
+		.mult		= _m,				\
+		.div		= _d,				\
+	}
+
+void intel_set_clk_val(struct regmap *map, u32 reg, u8 shift,
+		       u8 width, u32 set_val);
+u32 intel_get_clk_val(struct regmap *map, u32 reg, u8 shift, u8 width);
+void intel_clk_add_lookup(struct intel_clk_provider *ctx,
+			  struct clk_hw *hw, unsigned int id);
+void __init intel_clk_of_add_provider(struct device_node *np,
+				      struct intel_clk_provider *ctx);
+struct intel_clk_provider *intel_clk_init(struct device *dev,
+					  struct regmap *map,
+					  unsigned int nr_clks);
+void intel_clk_register_branches(struct intel_clk_provider *ctx,
+				 const struct intel_clk_branch *list,
+				 unsigned int nr_clk);
+void intel_clk_register_plls(struct intel_clk_provider *ctx,
+			     const struct intel_pll_clk_data *list,
+			     unsigned int nr_clk);
+int intel_clk_register_ddiv(struct intel_clk_provider *ctx,
+			    const struct intel_clk_ddiv_data *list,
+			    unsigned int nr_clk);
+void intel_clk_ssc_probe(struct intel_clk_provider *ctx);
+
+#endif				/* __INTEL_CLK_H */
diff --git a/drivers/clk/intel/clk-lgm.c b/drivers/clk/intel/clk-lgm.c
new file mode 100644
index 000000000000..a7a7da07149d
--- /dev/null
+++ b/drivers/clk/intel/clk-lgm.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2018 Intel Corporation.
+ *  Zhu YiXin <Yixin.zhu@intel.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/clock/intel,lgm-clk.h>
+#include "clk-cgu-pll.h"
+#include "clk-cgu.h"
+
+#define PLL_DIV_WIDTH		4
+#define PLL_DDIV_WIDTH		3
+
+/* Register definition */
+#define CGU_PLL0CZ_CFG0		0x000
+#define CGU_PLL0B_CFG0		0x060
+#define CGU_PLL1_CFG0		0x080
+#define CGU_PLL2_CFG0		0x0A0
+#define CGU_PLLPP_CFG0		0x0C0
+#define CGU_LJPLL3_CFG0		0x0E0
+#define CGU_LJPLL4_CFG0		0x100
+#define CGU_IF_CLK1		0x1A0
+#define CGU_IF_CLK2		0x1A4
+#define CGU_GATE0		0x300
+#define CGU_GATE1		0x310
+#define CGU_GATE2		0x320
+#define CGU_GATE3		0x310
+
+#define PLL_DIV(x)		((x) + 0x04)
+#define PLL_SSC(x)		((x) + 0x10)
+
+/*
+ * Below table defines the pair's of regval & effective dividers.
+ * It's more efficient to provide an explicit table due to non-linear
+ * relation between values.
+ */
+static const struct clk_div_table pll_div[] = {
+	{ .val = 1, .div = 2 },
+	{ .val = 2, .div = 3 },
+	{ .val = 3, .div = 4 },
+	{ .val = 4, .div = 5 },
+	{ .val = 5, .div = 6 },
+	{ .val = 6, .div = 8 },
+	{ .val = 7, .div = 10 },
+	{ .val = 8, .div = 12 },
+	{ .val = 9, .div = 16 },
+	{ .val = 10, .div = 20 },
+	{ .val = 11, .div = 24 },
+	{ .val = 12, .div = 32 },
+	{ .val = 13, .div = 40 },
+	{ .val = 14, .div = 48 },
+	{ .val = 15, .div = 64 },
+	{}
+};
+
+enum lgm_plls {
+	PLL0CZ, PLL0B, PLL1, PLL2, PLLPP, LJPLL3, LJPLL4
+};
+
+static const char *const pll_p[] __initconst = { "osc" };
+static const char *const emmc_p[] __initconst = { "emmc4", "noc4" };
+static const char *const sdio_p[] __initconst = { "sdio3", "sdio2" };
+
+static const struct intel_pll_clk_data lgm_pll_clks[] __initconst = {
+	[PLL0CZ] = INTEL_PLL(LGM_CLK_PLL0CZ, "pll0cz", pll_p, 0,
+			     CGU_PLL0CZ_CFG0, TYPE_ROPLL),
+	[PLL0B] = INTEL_PLL(LGM_CLK_PLL0B, "pll0b", pll_p, 0,
+			    CGU_PLL0B_CFG0, TYPE_ROPLL),
+	[PLL1] = INTEL_PLL(LGM_CLK_PLL1, "pll1", pll_p, 0,
+			   CGU_PLL1_CFG0, TYPE_ROPLL),
+	[PLL2] = INTEL_PLL(LGM_CLK_PLL2, "pll2", pll_p, 0,
+			   CGU_PLL2_CFG0, TYPE_ROPLL),
+	[PLLPP] = INTEL_PLL(LGM_CLK_PLLPP, "pllpp", pll_p, 0,
+			    CGU_PLLPP_CFG0, TYPE_ROPLL),
+	[LJPLL3] = INTEL_PLL(LGM_CLK_LJPLL3, "ljpll3", pll_p, 0,
+			     CGU_LJPLL3_CFG0, TYPE_LJPLL),
+	[LJPLL4] = INTEL_PLL(LGM_CLK_LJPLL4, "ljpll4", pll_p, 0,
+			     CGU_LJPLL4_CFG0, TYPE_LJPLL),
+};
+
+static const struct intel_clk_branch lgm_branch_clks[] __initconst = {
+	/* Divider clocks */
+	INTEL_DIV(LGM_CLK_PP_HW, "pp_hw", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		  0, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_PP_UC, "pp_uc", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		  4, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_PP_FXD, "pp_rt", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		  8, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_PP_TBM, "pp_tbm", "pllpp", 0, PLL_DIV(CGU_PLLPP_CFG0),
+		  12, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_DDR, "ddr", "pll2", 0, PLL_DIV(CGU_PLL2_CFG0),
+		  0, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_CM, "cpu_cm", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG0),
+		  0, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_IC, "cpu_ic", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG0),
+		  4, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_SDIO3, "sdio3", "pll0cz", 0, PLL_DIV(CGU_PLL0CZ_CFG0),
+		  8, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_NGI, "ngi", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		  0, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_NOC4, "noc4", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		  4, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_SW, "switch", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		  8, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_QSPI, "qspi", "pll0b", 0, PLL_DIV(CGU_PLL0B_CFG0),
+		  12, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_CT, "voice_ct", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		  0, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_DSP, "voice_dsp", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		  4, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_4X, "voice_4x", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		  8, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_DIV(LGM_CLK_DCL, "voice_dcl", "pll1", 0, PLL_DIV(CGU_PLL1_CFG0),
+		  12, PLL_DIV_WIDTH, 0, 0, pll_div),
+	INTEL_FIXED_FACTOR(LGM_CLK_EMMC4, "emmc4", "sdio3", 0, 0,
+			   0, 0, 0, 0, 1, 4),
+	INTEL_FIXED_FACTOR(LGM_CLK_SDIO2, "sdio2", "noc4", 0, 0,
+			   0, 0, 0, 0, 1, 4),
+	INTEL_MUX(LGM_CLK_EMMC, "emmc", emmc_p, 0, CGU_IF_CLK1,
+		  0, 1, 0, 0),
+	INTEL_MUX(LGM_CLK_SDIO, "sdio", sdio_p, 0, CGU_IF_CLK1,
+		  1, 1, 0, 0),
+
+	/* Gate0 clocks */
+	INTEL_GATE(LGM_GCLK_TOPNOC, "g_topnoc", NULL, 0, CGU_GATE0,
+		   0, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_C55, "g_c55", NULL, 0, CGU_GATE0,
+		   7, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_VCODEC, "g_vcodec", NULL, 0, CGU_GATE0,
+		   8, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_QSPI, "g_qspi", NULL, 0, CGU_GATE0,
+		   9, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_TEP, "g_tep", NULL, 0, CGU_GATE0,
+		   10, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_EIP197, "g_eip197", NULL, 0, CGU_GATE0,
+		   11, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_VAULT, "g_vault130", NULL, 0, CGU_GATE0,
+		   12, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_TOE, "g_toe", NULL, 0, CGU_GATE0,
+		   13, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SDXC, "g_sdxc", NULL, 0, CGU_GATE0,
+		   14, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_EMMC, "g_emmc", NULL, 0, CGU_GATE0,
+		   15, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_EIP154, "g_eip154", NULL, 0, CGU_GATE0,
+		   16, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SPI_DBG, "g_spidbg", NULL, 0, CGU_GATE0,
+		   17, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_DMA3, "g_dma3", NULL, 0, CGU_GATE0,
+		   28, GATE_CLK_HW, 0),
+
+	/* Gate1 clocks */
+	INTEL_GATE(LGM_GCLK_DMA0, "g_dma0", NULL, 0, CGU_GATE1,
+		   0, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_LEDC0, "g_ledc0", NULL, 0, CGU_GATE1,
+		   1, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_LEDC1, "g_ledc1", NULL, 0, CGU_GATE1,
+		   2, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2S0, "g_i2s0", NULL, 0, CGU_GATE1,
+		   3, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2S1, "g_i2s1", NULL, 0, CGU_GATE1,
+		   4, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_EBU, "g_ebu", NULL, 0, CGU_GATE1,
+		   5, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2C0, "g_i2c0", NULL, 0, CGU_GATE1,
+		   7, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2C1, "g_i2c1", NULL, 0, CGU_GATE1,
+		   8, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2C2, "g_i2c2", NULL, 0, CGU_GATE1,
+		   9, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_I2C3, "g_i2c3", NULL, 0, CGU_GATE1,
+		   10, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SSC0, "g_ssc0", NULL, 0, CGU_GATE1,
+		   12, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SSC1, "g_ssc1", NULL, 0, CGU_GATE1,
+		   13, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SSC2, "g_ssc2", NULL, 0, CGU_GATE1,
+		   14, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SSC3, "g_ssc3", NULL, 0, CGU_GATE1,
+		   15, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_GPTC0, "g_gptc0", NULL, 0, CGU_GATE1,
+		   17, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_GPTC1, "g_gptc1", NULL, 0, CGU_GATE1,
+		   18, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_GPTC2, "g_gptc2", NULL, 0, CGU_GATE1,
+		   19, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_GPTC3, "g_gptc3", NULL, 0, CGU_GATE1,
+		   20, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_ASC0, "g_asc0", NULL, 0, CGU_GATE1,
+		   22, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_ASC1, "g_asc1", NULL, 0, CGU_GATE1,
+		   23, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_ASC2, "g_asc2", NULL, 0, CGU_GATE1,
+		   24, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_ASC3, "g_asc3", NULL, 0, CGU_GATE1,
+		   25, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCM0, "g_pcm0", NULL, 0, CGU_GATE1,
+		   27, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCM1, "g_pcm1", NULL, 0, CGU_GATE1,
+		   28, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCM2, "g_pcm2", NULL, 0, CGU_GATE1,
+		   29, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PERINOC, "g_perinoc", NULL, 0, CGU_GATE1,
+		   31, GATE_CLK_HW, 0),
+
+	/* Gate2 clock */
+	INTEL_GATE(LGM_GCLK_PCIE10, "g_pcie10", NULL, 0, CGU_GATE2,
+		   1, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE11, "g_pcie11", NULL, 0, CGU_GATE2,
+		   2, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE30, "g_pcie30", NULL, 0, CGU_GATE2,
+		   3, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE31, "g_pcie31", NULL, 0, CGU_GATE2,
+		   4, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE20, "g_pcie20", NULL, 0, CGU_GATE2,
+		   5, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE21, "g_pcie21", NULL, 0, CGU_GATE2,
+		   6, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE40, "g_pcie40", NULL, 0, CGU_GATE2,
+		   7, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PCIE41, "g_pcie41", NULL, 0, CGU_GATE2,
+		   8, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_XPCS0, "g_xpcs0", NULL, 0, CGU_GATE2,
+		   10, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_XPCS1, "g_xpcs1", NULL, 0, CGU_GATE2,
+		   11, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_XPCS2, "g_xpcs2", NULL, 0, CGU_GATE2,
+		   12, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_XPCS3, "g_xpcs3", NULL, 0, CGU_GATE2,
+		   13, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SATA0, "g_sata0", NULL, 0, CGU_GATE2,
+		   14, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SATA1, "g_sata1", NULL, 0, CGU_GATE2,
+		   15, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SATA2, "g_sata2", NULL, 0, CGU_GATE2,
+		   16, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_SATA3, "g_sata3", NULL, 0, CGU_GATE2,
+		   17, GATE_CLK_HW, 0),
+
+	/* Gate3 clock */
+	INTEL_GATE(LGM_GCLK_ARCEM4, "g_arcem4", NULL, 0, CGU_GATE3,
+		   0, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_VPNHOST, "g_vpnhost", NULL, 0, CGU_GATE3,
+		   1, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_IDMAR1, "g_idmar1", NULL, 0, CGU_GATE3,
+		   2, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_IDMAT0, "g_idmat0", NULL, 0, CGU_GATE3,
+		   3, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_IDMAT1, "g_idmat1", NULL, 0, CGU_GATE3,
+		   4, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_IDMAT2, "g_idmat2", NULL, 0, CGU_GATE3,
+		   5, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PPV4, "g_ppv4", NULL, 0, CGU_GATE3,
+		   8, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_GSWIPO, "g_gswipo", NULL, 0, CGU_GATE3,
+		   9, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_CQEM, "g_cqem", NULL, 0, CGU_GATE3,
+		   10, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PON, "g_pon", NULL, 0, CGU_GATE3,
+		   11, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_BM, "g_bm", NULL, 0, CGU_GATE3,
+		   12, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_PB, "g_pb", NULL, 0, CGU_GATE3,
+		   13, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_XPCS5, "g_xpcs5", NULL, 0, CGU_GATE3,
+		   14, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_USB1, "g_usb1", NULL, 0, CGU_GATE3,
+		   25, GATE_CLK_HW, 0),
+	INTEL_GATE(LGM_GCLK_USB2, "g_usb2", NULL, 0, CGU_GATE3,
+		   26, GATE_CLK_HW, 0),
+};
+
+static const struct intel_clk_ddiv_data lgm_ddiv_clks[] __initconst = {
+	INTEL_DDIV(LGM_CLK_CML, "dd_cml", "ljpll3", 0,
+		   PLL_DIV(CGU_LJPLL3_CFG0), 0, PLL_DDIV_WIDTH,
+		   3, PLL_DDIV_WIDTH, 29, 0),
+	INTEL_DDIV(LGM_CLK_CBPHY, "dd_cbphy", "ljpll3", 0,
+		   PLL_DIV(CGU_LJPLL3_CFG0), 6, PLL_DDIV_WIDTH,
+		   9, PLL_DDIV_WIDTH, 28, 0),
+	INTEL_DDIV(LGM_CLK_POOL, "dd_pool", "ljpll3", 0,
+		   PLL_DIV(CGU_LJPLL3_CFG0), 12, PLL_DDIV_WIDTH,
+		   15, PLL_DDIV_WIDTH, 28, 0),
+	INTEL_DDIV(LGM_CLK_PTP, "dd_ptp", "ljpll3", 0,
+		   PLL_DIV(CGU_LJPLL3_CFG0), 18, PLL_DDIV_WIDTH,
+		   21, PLL_DDIV_WIDTH, 28, 0),
+	INTEL_DDIV(LGM_CLK_PCIE, "dd_pcie", "ljpll4", 0,
+		   PLL_DIV(CGU_LJPLL4_CFG0), 0, PLL_DDIV_WIDTH,
+		   3, PLL_DDIV_WIDTH, 29, 0),
+};
+
+static int __init intel_lgm_cgu_probe(struct platform_device *pdev)
+{
+	struct intel_clk_provider *ctx;
+	struct regmap *map;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	map = syscon_node_to_regmap(np);
+	if (IS_ERR(map))
+		return -ENODEV;
+
+	ctx = intel_clk_init(dev, map, CLK_NR_CLKS);
+	if (IS_ERR(ctx))
+		return -ENOMEM;
+
+	ctx->np = np;
+	ctx->dev = dev;
+	platform_set_drvdata(pdev, ctx);
+
+	intel_clk_register_plls(ctx, lgm_pll_clks, ARRAY_SIZE(lgm_pll_clks));
+	intel_clk_register_branches(ctx, lgm_branch_clks,
+				    ARRAY_SIZE(lgm_branch_clks));
+
+	ret = intel_clk_register_ddiv(ctx, lgm_ddiv_clks,
+				      ARRAY_SIZE(lgm_ddiv_clks));
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &ctx->clk_data);
+	if (ret)
+		return ret;
+
+	intel_clk_ssc_probe(ctx);
+	return 0;
+}
+
+static const struct of_device_id of_intel_lgm_cgu_match[] = {
+	{.compatible = "intel,cgu-lgm"},
+	{}
+};
+
+static struct platform_driver intel_lgm_cgu_driver __refdata = {
+	.probe = intel_lgm_cgu_probe,
+	.driver = {
+		   .name = "cgu-lgm",
+		   .of_match_table = of_intel_lgm_cgu_match,
+	},
+};
+
+module_platform_driver(intel_lgm_cgu_driver);
-- 
2.11.0

