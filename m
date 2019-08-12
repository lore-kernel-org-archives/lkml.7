Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6658C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0ED20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfHLKKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:10:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60682 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfHLKKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:10:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B00E200130;
        Mon, 12 Aug 2019 12:10:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7D862002DF;
        Mon, 12 Aug 2019 12:10:45 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B4CA40305;
        Mon, 12 Aug 2019 18:10:40 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, leoyang.li@nxp.com,
        liviu.dudau@arm.com
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v1 1/3] clk: ls1028a: Add clock driver for Display output interface
Date:   Mon, 12 Aug 2019 18:01:03 +0800
Message-Id: <20190812100103.34393-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for QorIQ LS1028A Display output interfaces(LCD, DPHY),
as implemented in TSMC CLN28HPM PLL, this PLL supports the programmable
integer division and range of the display output pixel clock's 27-594MHz.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
 drivers/clk/Kconfig      |   9 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-plldig.c | 277 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/clk/clk-plldig.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd0321..0e6c7027d637 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -223,6 +223,15 @@ config CLK_QORIQ
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
 
+config CLK_PLLDIG
+        bool "Clock driver for LS1028A Display output"
+        depends on ARCH_LAYERSCAPE && OF
+        help
+          This driver support the Display output interfaces(LCD, DPHY) pixel clocks
+          of the QorIQ Layerscape LS1028A, as implemented TSMC CLN28HPM PLL. Not all
+          features of the PLL are currently supported by the driver. By default,
+          configured bypass mode with this PLL.
+
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
 	default ARCH_XGENE
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0cad76021297..35277759ec03 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
+obj-$(CONFIG_CLK_PLLDIG)		+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
new file mode 100644
index 000000000000..15c9bb623a70
--- /dev/null
+++ b/drivers/clk/clk-plldig.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2019 NXP
+
+/*
+ * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
+ *
+ * Author: Wen He <wen.he_1@nxp.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* PLLDIG register offsets and bit masks */
+#define PLLDIG_REG_PLLSR            0x24
+#define PLLDIG_REG_PLLDV            0x28
+#define PLLDIG_REG_PLLFM            0x2c
+#define PLLDIG_REG_PLLFD            0x30
+#define PLLDIG_REG_PLLCAL1          0x38
+#define PLLDIG_REG_PLLCAL2          0x3c
+#define PLLDIG_DEFAULE_MULT         0x2c
+#define PLLDIG_LOCK_STATUS          BIT(3)
+#define PLLDIG_SSCGBYP_ENABLE       BIT(30)
+#define PLLDIG_FDEN                 BIT(30)
+#define PLLDIG_DTHRCTL              (0x3 << 16)
+
+/* macro to get/set values into register */
+#define PLLDIG_GET_MULT(x)          (((x) & ~(0xffffff00)) << 0)
+#define PLLDIG_GET_RFDPHI1(x)       ((u32)(x) >> 25)
+#define PLLDIG_SET_RFDPHI1(x)       ((u32)(x) << 25)
+
+struct clk_plldig {
+	struct clk_hw hw;
+	void __iomem *regs;
+};
+#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static inline int plldig_wait_lock(struct clk_plldig *plldig)
+{
+	u32 csr;
+       /*
+	* Indicates whether PLL has acquired lock, if operating in bypass
+	* mode, the LOCK bit will still assert when the PLL acquires lock
+	* or negate when it loses lock.
+	*/
+	return readl_poll_timeout(plldig->regs + PLLDIG_REG_PLLSR, csr,
+				csr & PLLDIG_LOCK_STATUS, 0, LOCK_TIMEOUT_US);
+}
+
+static int plldig_enable(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLFM);
+	/*
+	 * Use Bypass mode with PLL off by default,the frequency overshoot
+	 * detector output was disable. SSCG Bypass mode should be enable.
+	 */
+	val |= PLLDIG_SSCGBYP_ENABLE;
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+
+	val = readl(data->regs + PLLDIG_REG_PLLFD);
+	/* Disable dither and Sigma delta modulation in bypass mode */
+	val |= (PLLDIG_FDEN | PLLDIG_DTHRCTL);
+	writel(val, data->regs + PLLDIG_REG_PLLFD);
+
+	return plldig_wait_lock(data);
+}
+
+static void plldig_disable(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLFM);
+
+	val &= ~PLLDIG_SSCGBYP_ENABLE;
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+}
+
+static int plldig_is_enabled(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+
+	return (readl(data->regs + PLLDIG_REG_PLLFM) & PLLDIG_SSCGBYP_ENABLE);
+}
+
+/*
+ * Clock configuration relationship between the PHI1 frequency(fpll_phi) and
+ * the output frequency of the PLL is determined by the PLLDV, according to
+ * the following equation:
+ * pxclk = fpll_phi / RFDPHI1 = (pll_ref x PLLDV[MFD]) / PLLDV[RFDPHI1].
+ */
+static bool plldig_is_valid_range(unsigned long rate, unsigned long parent_rate,
+		unsigned int *mult, unsigned int *rfdphi1,
+		unsigned long *round_rate_base)
+{
+	u32 div, div_temp, mfd = PLLDIG_DEFAULE_MULT;
+	unsigned long round_rate;
+
+	round_rate = parent_rate * mfd;
+
+	/* Range of the diliver for driving the PHI1 output clock */
+	for (div = 1; div <= 63; div++) {
+		/* Checking match with default mult number at first */
+		if (round_rate / div == rate) {
+			*rfdphi1 = div;
+			*round_rate_base = round_rate;
+			*mult = mfd;
+			return true;
+		}
+	}
+
+	for (div = 1; div <= 63; div++) {
+		mfd = (div * rate) / parent_rate;
+		/* Range of the muliplicationthe factor applied to the
+		 * output reference frequency
+		 */
+		if ((mfd >= 10) && (mfd <= 150)) {
+			div_temp = (parent_rate * mfd) / rate;
+			if ((div_temp * rate) == (mfd * parent_rate)) {
+				*rfdphi1 = div_temp;
+				*mult = mfd;
+				*round_rate_base = mfd * parent_rate;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static unsigned long plldig_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_plldig *plldig = to_clk_plldig(hw);
+	u32 mult, div, val;
+
+	val = readl(plldig->regs + PLLDIG_REG_PLLDV);
+	pr_info("%s: current configuration: 0x%x\n", clk_hw_get_name(hw), val);
+
+	/* Check if PLL is bypassed */
+	if (val & PLLDIG_SSCGBYP_ENABLE)
+		return parent_rate;
+
+	/* Checkout multiplication factor divider value */
+	mult = val;
+	mult = PLLDIG_GET_MULT(mult);
+
+	/* Checkout divider value of the output frequency */
+	div = val;
+	div = PLLDIG_GET_RFDPHI1(div);
+
+	return (parent_rate * mult) / div;
+}
+
+static long plldig_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent)
+{
+	unsigned long parent_rate = *parent;
+	unsigned long round_rate;
+	u32 mult = 0, rfdphi1 = 0;
+	bool found = false;
+
+	found = plldig_is_valid_range(rate, parent_rate, &mult,
+					&rfdphi1, &round_rate);
+	if (!found) {
+		pr_warn("%s: unable to round rate %lu, parent rate :%lu\n",
+				clk_hw_get_name(hw), rate, parent_rate);
+		return 0;
+	}
+
+	return round_rate / rfdphi1;
+}
+
+static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	bool valid = false;
+	unsigned long round_rate = 0;
+	u32 rfdphi1 = 0, val, mult = 0;
+
+	valid = plldig_is_valid_range(rate, parent_rate, &mult,
+					&rfdphi1, &round_rate);
+	if (!valid) {
+		pr_warn("%s: unable to support rate %lu, parent_rate: %lu\n",
+				clk_hw_get_name(hw), rate, parent_rate);
+		return -EINVAL;
+	}
+
+	val = readl(data->regs + PLLDIG_REG_PLLDV);
+	val = mult;
+	rfdphi1 = PLLDIG_SET_RFDPHI1(rfdphi1);
+	val |= rfdphi1;
+
+	writel(val, data->regs + PLLDIG_REG_PLLDV);
+
+	return plldig_wait_lock(data);
+}
+
+static const struct clk_ops plldig_clk_ops = {
+	.enable = plldig_enable,
+	.disable = plldig_disable,
+	.is_enabled = plldig_is_enabled,
+	.recalc_rate = plldig_recalc_rate,
+	.round_rate = plldig_round_rate,
+	.set_rate = plldig_set_rate,
+};
+
+struct clk_hw *_plldig_clk_init(const char *name, const char *parent_name,
+				void __iomem *regs)
+{
+	struct clk_plldig *plldig;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	plldig = kzalloc(sizeof(*plldig), GFP_KERNEL);
+	if (!plldig)
+		return ERR_PTR(-ENOMEM);
+
+	plldig->regs = regs;
+
+	init.name = name;
+	init.ops = &plldig_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	plldig->hw.init = &init;
+
+	hw = &plldig->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(plldig);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static void __init plldig_clk_init(struct device_node *node)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data = kzalloc(struct_size(clk_data, hws, 1),
+			GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num = 1;
+	clks = clk_data->hws;
+
+	base = of_iomap(node, 0);
+	WARN_ON(!base);
+
+	clks[0] = _plldig_clk_init("pixel-clk",
+			of_clk_get_parent_name(node, 0), base);
+
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+}
+
+CLK_OF_DECLARE(plldig_clockgen, "fsl,ls1028a-plldig", plldig_clk_init);
-- 
2.17.1

