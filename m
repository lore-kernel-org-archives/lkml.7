Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFC2C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E0323402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfIDG13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:27:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:60280 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDG12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:27:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 23:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="185012054"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 23:27:25 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v3 2/2] phy: intel-lgm-sdxc: Add support for SDXC PHY
Date:   Wed,  4 Sep 2019 14:27:19 +0800
Message-Id: <20190904062719.37462-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for SDXC PHY on Intel's Lightning Mountain SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/phy/intel/Kconfig          |   6 ++
 drivers/phy/intel/Makefile         |   1 +
 drivers/phy/intel/phy-intel-sdxc.c | 144 +++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/phy/intel/phy-intel-sdxc.c

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 4ea6a8897cd7..d6356c762a6b 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -7,3 +7,9 @@ config PHY_INTEL_EMMC
 	select GENERIC_PHY
 	help
 	  Enable this to support the Intel EMMC PHY
+
+config PHY_INTEL_SDXC
+       tristate "Intel SDXC PHY driver"
+       select GENERIC_PHY
+       help
+         Enable this to support the Intel SDXC PHY driver
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 6b876a75599d..3c6e7523200c 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
+obj-$(CONFIG_PHY_INTEL_SDXC)            += phy-intel-sdxc.o
diff --git a/drivers/phy/intel/phy-intel-sdxc.c b/drivers/phy/intel/phy-intel-sdxc.c
new file mode 100644
index 000000000000..7e13fd9ced5b
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-sdxc.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel SDXC PHY driver
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
+/* SDXC PHY register definitions */
+#define SDXC_PHYCTRL_REG	0x88
+#define OTAPDLYENA_MASK		BIT(14)
+#define OTAPDLYSEL(x)		((x) << 10)
+#define OTAPDLYSEL_ALL		OTAPDLYSEL(GENMASK(3, 0))
+
+struct intel_sdxc_phy {
+	struct regmap *syscfg;
+	struct clk *sdxcclk;
+};
+
+static int intel_sdxc_phy_init(struct phy *phy)
+{
+	struct intel_sdxc_phy *priv = phy_get_drvdata(phy);
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
+	 */
+	priv->sdxcclk = clk_get_optional(&phy->dev, "sdxcclk");
+	if (IS_ERR(priv->sdxcclk)) {
+		dev_err(&phy->dev, "Error getting sdxcclk\n");
+		return PTR_ERR(priv->sdxcclk);
+	}
+
+	return 0;
+}
+
+static int intel_sdxc_phy_exit(struct phy *phy)
+{
+	struct intel_sdxc_phy *priv = phy_get_drvdata(phy);
+
+	clk_put(priv->sdxcclk);
+
+	return 0;
+}
+
+static int intel_sdxc_phy_power_on(struct phy *phy)
+{
+	struct intel_sdxc_phy *priv = phy_get_drvdata(phy);
+
+	/* Output tap delay: disable */
+	regmap_update_bits(priv->syscfg, SDXC_PHYCTRL_REG, OTAPDLYENA_MASK, 0);
+
+	/* Output tap delay */
+	regmap_update_bits(priv->syscfg, SDXC_PHYCTRL_REG, OTAPDLYSEL_ALL,
+			   OTAPDLYSEL_ALL);
+
+	return 0;
+}
+
+static int intel_sdxc_phy_power_off(struct phy *phy)
+{
+	/* Do nothing */
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.init		= intel_sdxc_phy_init,
+	.exit		= intel_sdxc_phy_exit,
+	.power_on	= intel_sdxc_phy_power_on,
+	.power_off	= intel_sdxc_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int intel_sdxc_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_sdxc_phy *priv;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+
+	if (!dev->parent || !dev->parent->of_node)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Get SDXC phy (accessed via chiptop) regmap */
+	priv->syscfg = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "intel,syscon");
+	if (IS_ERR(priv->syscfg)) {
+		dev_err(dev, "No syscon phandle for chiptop\n");
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
+static const struct of_device_id intel_sdxc_phy_dt_ids[] = {
+	{ .compatible = "intel,lgm-sdxc-phy" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, intel_sdxc_phy_dt_ids);
+
+static struct platform_driver intel_sdxc_driver = {
+	.probe		= intel_sdxc_phy_probe,
+	.driver		= {
+		.name	= "intel-sdxc-phy",
+		.of_match_table = intel_sdxc_phy_dt_ids,
+	},
+};
+
+module_platform_driver(intel_sdxc_driver);
+
+MODULE_AUTHOR("Peter Harliman Liem <peter.harliman.liem@intel.com>");
+MODULE_DESCRIPTION("Intel SDXC PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

