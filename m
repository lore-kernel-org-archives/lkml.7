Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35060C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4D22CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfHTKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:31:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:28272 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfHTKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:31:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 03:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="377736005"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 20 Aug 2019 03:31:39 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v2 2/2] phy: intel-lgm-emmc: Add support for eMMC PHY
Date:   Tue, 20 Aug 2019 18:31:33 +0800
Message-Id: <20190820103133.53776-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for eMMC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
changes in v2:
 - optimize IS_CALDONE() and IS_DLLRDY() macro
 - remove unneccessary comment
 - remove redundant assignment
 - add return the error ptr
---
 drivers/phy/Kconfig                |   1 +
 drivers/phy/Makefile               |   1 +
 drivers/phy/intel/Kconfig          |   8 ++
 drivers/phy/intel/Makefile         |   2 +
 drivers/phy/intel/phy-intel-emmc.c | 274 +++++++++++++++++++++++++++++++++++++
 5 files changed, 286 insertions(+)
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 0263db2ac874..b3ed94b98d9b 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -69,5 +69,6 @@ source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/tegra/Kconfig"
 source "drivers/phy/ti/Kconfig"
+source "drivers/phy/intel/Kconfig"
 
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0d9fddc498a6..3f1fc9efbbed 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -19,6 +19,7 @@ obj-y					+= broadcom/	\
 					   cadence/	\
 					   freescale/	\
 					   hisilicon/	\
+					   intel/	\
 					   marvell/	\
 					   motorola/	\
 					   mscc/	\
diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
new file mode 100644
index 000000000000..aa34e0fa9824
--- /dev/null
+++ b/drivers/phy/intel/Kconfig
@@ -0,0 +1,8 @@
+#
+# Phy drivers for Intel X86 LGM platform
+#
+config PHY_INTEL_EMMC
+	tristate "Intel EMMC PHY driver"
+	select GENERIC_PHY
+	help
+	  Enable this to support the Intel EMMC PHY
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
new file mode 100644
index 000000000000..6b876a75599d
--- /dev/null
+++ b/drivers/phy/intel/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
diff --git a/drivers/phy/intel/phy-intel-emmc.c b/drivers/phy/intel/phy-intel-emmc.c
new file mode 100644
index 000000000000..11f179ff81f0
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-emmc.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel eMMC PHY driver
+ * Copyright (C) 2019 Intel, Corp.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* eMMC phy register definitions */
+#define EMMC_PHYCTRL0_REG	0xa8
+#define DR_TY_MASK		GENMASK(30, 28)
+#define DR_TY_50OHM(x)		((~(x) << 28) & DR_TY_MASK)
+#define OTAPDLYENA		BIT(14)
+#define OTAPDLYSEL_MASK		GENMASK(13, 10)
+#define OTAPDLYSEL_SHIFT(x)	(((x) << 10) & OTAPDLYSEL_MASK)
+
+#define EMMC_PHYCTRL1_REG	0xac
+#define PDB_MASK		BIT(0)
+#define ENDLL_MASK		BIT(7)
+#define ENDLL_VAL		BIT(7)
+
+#define EMMC_PHYCTRL2_REG	0xb0
+#define FRQSEL_25M		0
+#define FRQSEL_150M		3
+#define FRQSEL_MASK		GENMASK(24, 22)
+#define FRQSEL_SHIFT(x)		((x) << 22)
+
+#define EMMC_PHYSTAT_REG	0xbc
+#define CALDONE_MASK		BIT(9)
+#define DLLRDY_MASK		BIT(8)
+#define IS_CALDONE(x)	((x) & CALDONE_MASK)
+#define IS_DLLRDY(x)	((x) & DLLRDY_MASK)
+
+struct intel_emmc_phy {
+	struct regmap *syscfg;
+	struct clk *emmcclk;
+};
+
+static int intel_emmc_phy_power(struct phy *phy, bool on_off)
+{
+	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
+	unsigned int caldone;
+	unsigned int dllrdy;
+	unsigned int freqsel = 0;
+	unsigned long rate;
+	int ret, quot;
+
+	/*
+	 * Keep phyctrl_pdb and phyctrl_endll low to allow
+	 * initialization of CALIO state M/C DFFs
+	 */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG,
+				 PDB_MASK | ENDLL_MASK, 0);
+	if (ret) {
+		dev_err(&phy->dev, "CALIO power down bar failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Already finish power_off above */
+	if (!on_off)
+		return 0;
+
+	rate = clk_get_rate(priv->emmcclk);
+	quot = DIV_ROUND_CLOSEST(rate, 50000000);
+	if (quot > FRQSEL_150M)
+		dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
+	freqsel = clamp_t(int, quot, FRQSEL_25M, FRQSEL_150M);
+
+	/*
+	 * According to the user manual, calpad calibration
+	 * cycle takes more than 2us without the minimal recommended
+	 * value, so we may need a little margin here
+	 */
+	usleep_range(3, 6);
+	regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, PDB_MASK, 1);
+
+	/*
+	 * According to the user manual, it asks driver to wait 5us for
+	 * calpad busy trimming. However it is documented that this value is
+	 * PVT(A.K.A process,voltage and temperature) relevant, so some
+	 * failure cases are found which indicates we should be more tolerant
+	 * to calpad busy trimming.
+	 */
+	ret = regmap_read_poll_timeout(priv->syscfg, EMMC_PHYSTAT_REG,
+				       caldone, IS_CALDONE(caldone),
+				       0, 50);
+	if (ret) {
+		dev_err(&phy->dev, "caldone failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	/* Set the frequency of the DLL operation */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL2_REG, FRQSEL_MASK,
+				 FRQSEL_SHIFT(freqsel));
+	if (ret) {
+		dev_err(&phy->dev, "set the frequency of dll failed:%d\n", ret);
+		return ret;
+	}
+
+	/* Turn on the DLL */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL1_REG, ENDLL_MASK,
+				 ENDLL_VAL);
+	if (ret) {
+		dev_err(&phy->dev, "turn on the dll failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * After enabling analog DLL circuits docs say that we need 10.2 us if
+	 * our source clock is at 50 MHz and that lock time scales linearly
+	 * with clock speed.  If we are powering on the PHY and the card clock
+	 * is super slow (like 100 kHZ) this could take as long as 5.1 ms as
+	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) => 5.1 ms
+	 * Hopefully we won't be running at 100 kHz, but we should still make
+	 * sure we wait long enough.
+	 *
+	 * NOTE: There appear to be corner cases where the DLL seems to take
+	 * extra long to lock for reasons that aren't understood.  In some
+	 * extreme cases we've seen it take up to over 10ms (!).  We'll be
+	 * generous and give it 50ms.
+	 */
+	ret = regmap_read_poll_timeout(priv->syscfg,
+				       EMMC_PHYSTAT_REG,
+				       dllrdy, IS_DLLRDY(dllrdy),
+				       0, 50 * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(&phy->dev, "dllrdy failed. ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int intel_emmc_phy_init(struct phy *phy)
+{
+	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
+
+	/*
+	 * We purposely get the clock here and not in probe to avoid the
+	 * circular dependency problem.  We expect:
+	 * - PHY driver to probe
+	 * - SDHCI driver to start probe
+	 * - SDHCI driver to register it's clock
+	 * - SDHCI driver to get the PHY
+	 * - SDHCI driver to init the PHY
+	 *
+	 * The clock is optional, so upon any error just return it like
+	 * any other error to user.
+	 *
+	 */
+	priv->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
+	if (IS_ERR(priv->emmcclk)) {
+		dev_err(&phy->dev, "ERROR: getting emmcclk\n");
+		return PTR_ERR(priv->emmcclk);
+	}
+
+	return 0;
+}
+
+static int intel_emmc_phy_exit(struct phy *phy)
+{
+	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
+
+	clk_put(priv->emmcclk);
+
+	return 0;
+}
+
+static int intel_emmc_phy_power_on(struct phy *phy)
+{
+	struct intel_emmc_phy *priv = phy_get_drvdata(phy);
+	int ret;
+
+	/* Drive impedance: 50 Ohm */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, DR_TY_MASK,
+				 DR_TY_50OHM(1));
+	if (ret) {
+		dev_err(&phy->dev, "ERROR set drive-impednce-50ohm: %d\n", ret);
+		return ret;
+	}
+
+	/* Output tap delay: disable */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG, OTAPDLYENA,
+				 0x0);
+	if (ret) {
+		dev_err(&phy->dev, "ERROR Set output tap delay : %d\n", ret);
+		return ret;
+	}
+
+	/* Output tap delay */
+	ret = regmap_update_bits(priv->syscfg, EMMC_PHYCTRL0_REG,
+				 OTAPDLYSEL_MASK, OTAPDLYSEL_SHIFT(4));
+	if (ret) {
+		dev_err(&phy->dev, "ERROR: output tap dly select: %d\n", ret);
+		return ret;
+	}
+
+	/* Power up eMMC phy analog blocks */
+	return intel_emmc_phy_power(phy, true);
+}
+
+static int intel_emmc_phy_power_off(struct phy *phy)
+{
+	/* Power down eMMC phy analog blocks */
+	return intel_emmc_phy_power(phy, false);
+}
+
+static const struct phy_ops ops = {
+	.init		= intel_emmc_phy_init,
+	.exit		= intel_emmc_phy_exit,
+	.power_on	= intel_emmc_phy_power_on,
+	.power_off	= intel_emmc_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int intel_emmc_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_emmc_phy *priv;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get eMMC phy (accessed via chiptop) regmap */
+	priv->syscfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "intel,syscon");
+	if (IS_ERR(priv->syscfg)) {
+		dev_err(dev, "failed to find syscon\n");
+		return PTR_ERR(priv->syscfg);
+	}
+
+	generic_phy = devm_phy_create(dev, dev->of_node, &ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(generic_phy);
+	}
+
+	phy_set_drvdata(generic_phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id intel_emmc_phy_dt_ids[] = {
+	{ .compatible = "intel,lgm-emmc-phy" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, intel_emmc_phy_dt_ids);
+
+static struct platform_driver intel_emmc_driver = {
+	.probe		= intel_emmc_phy_probe,
+	.driver		= {
+		.name	= "intel-emmc-phy",
+		.of_match_table = intel_emmc_phy_dt_ids,
+	},
+};
+
+module_platform_driver(intel_emmc_driver);
+
+MODULE_AUTHOR("Peter Harliman Liem <peter.harliman.liem@intel.com>");
+MODULE_DESCRIPTION("Intel eMMC PHY driver");
-- 
2.11.0

