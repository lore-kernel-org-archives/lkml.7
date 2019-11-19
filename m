Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74BC222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKSIIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:08:18 -0500
Received: from inva020.nxp.com ([92.121.34.13]:52548 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfKSIIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:08:17 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1EEC1A0407;
        Tue, 19 Nov 2019 09:08:13 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60C3E1A0421;
        Tue, 19 Nov 2019 09:08:09 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 52A6B402B3;
        Tue, 19 Nov 2019 16:08:03 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wen He <wen.he_1@nxp.com>
Subject: [v9 2/2] clk: ls1028a: Add clock driver for Display output interface
Date:   Tue, 19 Nov 2019 16:07:47 +0800
Message-Id: <20191119080747.35250-2-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119080747.35250-1-wen.he_1@nxp.com>
References: <20191119080747.35250-1-wen.he_1@nxp.com>
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
change in v9:
	- Use the fixed mfd in plldig_set_rate 

 drivers/clk/Kconfig      |  10 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-plldig.c | 297 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)
 create mode 100644 drivers/clk/clk-plldig.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0530bebfc25a..9f6b0196c604 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,6 +218,16 @@ config CLK_QORIQ
 	  This adds the clock driver support for Freescale QorIQ platforms
 	  using common clock framework.
 
+config CLK_LS1028A_PLLDIG
+        tristate "Clock driver for LS1028A Display output"
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
index 0138fb14e6f8..97d1e5bc6de5 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
+obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
new file mode 100644
index 000000000000..f940a9d3d011
--- /dev/null
+++ b/drivers/clk/clk-plldig.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 NXP
+ *
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
+#include <linux/bitfield.h>
+
+/* PLLDIG register offsets and bit masks */
+#define PLLDIG_REG_PLLSR            0x24
+#define PLLDIG_REG_PLLDV            0x28
+#define PLLDIG_REG_PLLFM            0x2c
+#define PLLDIG_REG_PLLFD            0x30
+#define PLLDIG_REG_PLLCAL1          0x38
+#define PLLDIG_REG_PLLCAL2          0x3c
+#define PLLDIG_LOCK_MASK            BIT(2)
+#define PLLDIG_REG_FIELD_SSCGBYP    BIT(30)
+#define PLLDIG_REG_FIELD_FDEN       BIT(30)
+#define PLLDIG_REG_FIELD_DTHDIS     GENMASK(17, 16)
+#define PLLDIG_REG_FIELD_MULT       GENMASK(7, 0)
+#define PLLDIG_REG_FIELD_RFDPHI1    GENMASK(30, 25)
+
+/* Minimum output clock frequency, in Hz */
+#define PHI1_MIN_FREQ 27000000
+
+/* Maximum output clock frequency, in Hz */
+#define PHI1_MAX_FREQ 600000000
+
+/* Maximum of the divider */
+#define MAX_RFDPHI1          63
+
+/*
+ * Clock configuration relationship between the PHI1 frequency(fpll_phi) and
+ * the output frequency of the PLL is determined by the PLLDV, according to
+ * the following equation:
+ * fpll_phi = (pll_ref * mfd) / div_rfdphi1
+ */
+struct plldig_phi1_param {
+	unsigned long rate;
+	unsigned int rfdphi1;
+	unsigned int mfd;
+};
+
+static const struct clk_parent_data parent_data[] = {
+	{.index = 0},
+};
+
+struct clk_plldig {
+	struct clk_hw hw;
+	void __iomem *regs;
+	unsigned int mfd;
+};
+
+#define to_clk_plldig(_hw)	container_of(_hw, struct clk_plldig, hw)
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
+	val |= PLLDIG_REG_FIELD_SSCGBYP;
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+
+	val = readl(data->regs + PLLDIG_REG_PLLFD);
+	/* Disable dither and Sigma delta modulation in bypass mode */
+	val |= FIELD_PREP(PLLDIG_REG_FIELD_FDEN, 0x1) |
+	       FIELD_PREP(PLLDIG_REG_FIELD_DTHDIS, 0x3);
+
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
+	val &= ~PLLDIG_REG_FIELD_SSCGBYP;
+	val |= FIELD_PREP(PLLDIG_REG_FIELD_SSCGBYP, 0x0);
+
+	writel(val, data->regs + PLLDIG_REG_PLLFM);
+}
+
+static int plldig_is_enabled(struct clk_hw *hw)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+
+	return (readl(data->regs + PLLDIG_REG_PLLFM) &
+			      PLLDIG_REG_FIELD_SSCGBYP);
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
+	if (val & PLLDIG_REG_FIELD_SSCGBYP)
+		return parent_rate;
+
+	/* Checkout multiplication factor divider value */
+	mult = FIELD_GET(PLLDIG_REG_FIELD_MULT, val);
+
+	/* Checkout divider value of the output frequency */
+	div = FIELD_GET(PLLDIG_REG_FIELD_RFDPHI1, val);
+
+	return (parent_rate * mult) / div;
+}
+
+static int plldig_calc_target_rate(unsigned long target_rate,
+				   unsigned long parent_rate,
+				   struct plldig_phi1_param *phi1)
+{
+	unsigned int div, ret;
+	unsigned long round_rate;
+
+	/* Range limitation of the request target rate */
+	if (target_rate > PHI1_MAX_FREQ)
+		target_rate = PHI1_MAX_FREQ;
+	else if (target_rate < PHI1_MIN_FREQ)
+		target_rate = PHI1_MIN_FREQ;
+
+	/*
+	 * Firstly, check the request target rate whether is divisible
+	 * by the best VCO frequency.
+	 */
+	round_rate = parent_rate * phi1->mfd;
+	div = round_rate / target_rate;
+	if (!div || div > MAX_RFDPHI1)
+		return -EINVAL;
+
+	ret = round_rate % target_rate;
+	if (ret) {
+		/*
+		 * Rounded down the request target rate, VESA specifies
+		 * 0.5% pixel clock tolerance, therefore this algorithm
+		 * can able to compatible a lot of request rates within
+		 * range of the tolerance.
+		 */
+		round_rate += (target_rate / 2);
+		div = round_rate / target_rate;
+		if (!div || div > MAX_RFDPHI1)
+			return -EINVAL;
+	}
+
+	phi1->rfdphi1 = div;
+	phi1->rate = target_rate;
+
+	return 0;
+}
+
+static int plldig_determine_rate(struct clk_hw *hw,
+				 struct clk_rate_request *req)
+{
+	int ret;
+	unsigned long parent_rate;
+	struct clk_hw *parent;
+	struct plldig_phi1_param phi1_param;
+	struct clk_plldig *data = to_clk_plldig(hw);
+
+	if (!req->rate)
+		return -ERANGE;
+
+	phi1_param.mfd = data->mfd;
+	parent = clk_hw_get_parent(hw);
+	parent_rate = clk_hw_get_rate(parent);
+
+	ret = plldig_calc_target_rate(req->rate, parent_rate, &phi1_param);
+	if (ret)
+		return ret;
+
+	req->rate = phi1_param.rate;
+
+	return 0;
+}
+
+static int plldig_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_plldig *data = to_clk_plldig(hw);
+	struct plldig_phi1_param phi1_param;
+	unsigned int val, cond;
+	int ret;
+
+	phi1_param.mfd = data->mfd;
+	ret = plldig_calc_target_rate(rate, parent_rate, &phi1_param);
+	if (ret)
+		return ret;
+
+	val = readl(data->regs + PLLDIG_REG_PLLDV);
+	val = FIELD_PREP(PLLDIG_REG_FIELD_MULT, phi1_param.mfd) |
+	      FIELD_PREP(PLLDIG_REG_FIELD_RFDPHI1, phi1_param.rfdphi1);
+
+	writel(val, data->regs + PLLDIG_REG_PLLDV);
+
+	/* delay 200us make sure that old lock state is cleared */
+	udelay(200);
+
+	/* Wait until PLL is locked or timeout (maximum 1000 usecs) */
+	return readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLLSR, cond,
+					 cond & PLLDIG_LOCK_MASK, 0,
+					 USEC_PER_MSEC);
+}
+
+static const struct clk_ops plldig_clk_ops = {
+	.enable = plldig_enable,
+	.disable = plldig_disable,
+	.is_enabled = plldig_is_enabled,
+	.recalc_rate = plldig_recalc_rate,
+	.determine_rate = plldig_determine_rate,
+	.set_rate = plldig_set_rate,
+};
+
+static int plldig_clk_probe(struct platform_device *pdev)
+{
+	struct clk_plldig *data;
+	struct resource *mem;
+	struct device *dev = &pdev->dev;
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
+	 /*
+	  * Support to get the best loop multiplication divider value
+	  * from DTS file, since this PLL can't changed this value on
+	  * the fly, write the fixed value.
+	  */
+	ret = of_property_read_u32(dev->of_node, "best-mfd", &data->mfd);
+	if (ret)
+		data->mfd = 0x2c;
+
+	writel(data->mfd, data->regs + PLLDIG_REG_PLLDV);
+
+	data->hw.init = CLK_HW_INIT_PARENTS_DATA("dpclk",
+						 parent_data,
+						 &plldig_clk_ops,
+						 0);
+
+	ret = devm_clk_hw_register(dev, &data->hw);
+	if (ret) {
+		dev_err(dev, "failed to register %s clock\n",
+						dev->of_node->name);
+		return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &data->hw);
+}
+
+static const struct of_device_id plldig_clk_id[] = {
+	{ .compatible = "fsl,ls1028a-plldig"},
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
+};
+module_platform_driver(plldig_clk_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wen He <wen.he_1@nxp.com>");
+MODULE_DESCRIPTION("LS1028A Display output interface pixel clock driver");
-- 
2.17.1

