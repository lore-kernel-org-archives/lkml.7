Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C3C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174B22DD3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfHVCS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37146 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfHVCSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB8A62005B4;
        Thu, 22 Aug 2019 04:18:52 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 280B02005AD;
        Thu, 22 Aug 2019 04:18:47 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1C95A402A2;
        Thu, 22 Aug 2019 10:18:40 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-devel@linux.nxdi.nxp.com, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
Subject: [v3 2/2] clk: ls1028a: Add clock driver for Display output interface
Date:   Thu, 22 Aug 2019 10:08:47 +0800
Message-Id: <20190822020847.10159-2-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190822020847.10159-1-wen.he_1@nxp.com>
References: <20190822020847.10159-1-wen.he_1@nxp.com>
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
change in v3:
        - remove the OF dependency
        - use clk_parent_data instead of parent_name

 drivers/clk/Kconfig      |  10 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-plldig.c | 283 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 drivers/clk/clk-plldig.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 801fa1cd0321..ab05f342af04 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -223,6 +223,16 @@ config CLK_QORIQ
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
 
+config CLK_LS1028A_PLLDIG
+        bool "Clock driver for LS1028A Display output"
+        depends on ARCH_LAYERSCAPE || COMPILE_TEST
+        default ARCH_LAYERSCAPE
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
index 0cad76021297..c8e22a764c4d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
+obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
new file mode 100644
index 000000000000..c5ce80a46fd4
--- /dev/null
+++ b/drivers/clk/clk-plldig.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2019 NXP
+
+/*
+ * Clock driver for LS1028A Display output interfaces(LCD, DPHY).
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
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
+#define PLLDIG_LOCK_MASK            BIT(2)
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
+	struct device *dev;
+};
+#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static int plldig_enable(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLFM);
+	/*
+	 * Use Bypass mode with PLL off by default, the frequency overshoot
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
+	return 0;
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
+ * pxlclk = fpll_phi / RFDPHI1 = (pll_ref x PLLDV[MFD]) / PLLDV[RFDPHI1].
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
+	/* Range of the divider for driving the PHI1 output clock */
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
+		/*
+		 * Range of the muliplicationthe factor applied to the
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
+	struct clk_plldig *data = to_clk_plldig(hw);
+	u32 mult, div, val;
+
+	val = readl(data->regs + PLLDIG_REG_PLLDV);
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
+	u32 rfdphi1 = 0, val, mult = 0, cond = 0;
+	int ret = -ETIMEDOUT;
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
+	/* delay 200us make sure that old lock state is cleared */
+	udelay(200);
+
+	/* Wait until PLL is locked or timeout (maximum 1000 usecs) */
+	ret = readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, cond,
+					cond & PLLDIG_LOCK_MASK, 0,
+					USEC_PER_MSEC);
+
+	return ret;
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
+static int plldig_clk_probe(struct platform_device *pdev)
+{
+	struct clk_plldig *data;
+	struct resource *mem;
+	struct clk_init_data init = {};
+	struct device *dev = &pdev->dev;
+	struct clk_parent_data parent_data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(data->regs))
+		return PTR_ERR(data->regs);
+
+	parent_data.name = of_clk_get_parent_name(dev->of_node, 0);
+	parent_data.index = 0;
+
+	init.name = dev->of_node->name;
+	init.ops = &plldig_clk_ops;
+	init.parent_data = &parent_data;
+	init.num_parents = 1;
+
+	data->hw.init = &init;
+	data->dev = dev;
+
+	ret = devm_clk_hw_register(dev, &data->hw);
+	if (ret) {
+		dev_err(dev, "failed to register %s clock\n", init.name);
+		return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &data->hw);
+	if (ret)
+		dev_err(dev, "failed adding the clock provider\n");
+
+	return ret;
+}
+
+static int plldig_clk_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+	return 0;
+}
+
+static const struct of_device_id plldig_clk_id[] = {
+	{ .compatible = "fsl,ls1028a-plldig", .data = NULL},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, plldig_clk_id);
+
+static struct platform_driver plldig_clk_driver = {
+	.driver = {
+		.name = "plldig-clock",
+		.of_match_table = plldig_clk_id,
+	},
+	.probe = plldig_clk_probe,
+	.remove = plldig_clk_remove,
+};
+module_platform_driver(plldig_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
+MODULE_DESCRIPTION("LS1028A Display output interface pixel clock driver");
-- 
2.17.1

