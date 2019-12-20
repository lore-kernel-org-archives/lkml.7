Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85897C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456E724679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTH2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:28:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:26593 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfLTH2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:28:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 23:28:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; 
   d="scan'208";a="390794595"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2019 23:28:35 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH 2/2] phy: intel: Add driver support for combo phy
Date:   Fri, 20 Dec 2019 15:28:28 +0800
Message-Id: <09556a80a967780072ae1240c7c8356f9142de50.1576824311.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
In-Reply-To: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
References: <9f3df8c403bba3633391551fc601cbcd2f950959.1576824311.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combo phy subsystem provides PHYs for various
controllers like PCIe, SATA and EMAC.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/intel/Kconfig           |  15 +
 drivers/phy/intel/Makefile          |   2 +
 drivers/phy/intel/phy-intel-combo.c | 732 ++++++++++++++++++++++++++++++++++++
 5 files changed, 751 insertions(+)
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 0263db2ac874..cde11d1e57f4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/freescale/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
+source "drivers/phy/intel/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
 source "drivers/phy/mediatek/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c96a1afc95bd..310c149a9df5 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -18,6 +18,7 @@ obj-y					+= broadcom/	\
 					   cadence/	\
 					   freescale/	\
 					   hisilicon/	\
+					   intel/	\
 					   lantiq/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
new file mode 100644
index 000000000000..cfe7fb89f08b
--- /dev/null
+++ b/drivers/phy/intel/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Phy drivers for Intel X86 LGM platform
+#
+config PHY_INTEL_COMBO
+	bool "Intel Combo PHY driver"
+	depends on OF && HAS_IOMEM
+	select MFD_SYSCON
+	select GENERIC_PHY
+	help
+	  Enable this to support Intel combo phy.
+
+	  This driver configures combo phy subsystem on Intel gateway
+	  chipsets which provides PHYs for various controllers, EMAC,
+	  SATA and PCIe.
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
new file mode 100644
index 000000000000..960218133d84
--- /dev/null
+++ b/drivers/phy/intel/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
new file mode 100644
index 000000000000..3fee02ab5e53
--- /dev/null
+++ b/drivers/phy/intel/phy-intel-combo.c
@@ -0,0 +1,732 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Combo-PHY driver
+ *
+ * Copyright (C) 2019 Intel Corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define PCIE_PHY_GEN_CTRL	0x00
+#define PCIE_PHY_CLK_PAD	BIT(17)
+#define PCIE_PHY_MPLLA_CTRL	0x10
+#define PCIE_PHY_MPLLB_CTRL	0x14
+
+#define REG_COMBO_MODE(x)	((x) * 0x200)
+#define REG_CLK_DISABLE(x)	((x) * 0x200 + 0x124)
+
+#define CLK_100MHZ		100000000
+#define CLK_156_25MHZ		156250000
+
+#define COMBO_PHY_ID(x)	((x)->parent->id)
+#define PHY_ID(x)	((x)->id)
+
+static const char *const intel_iphy_names[] = {"pcie", "xpcs", "sata"};
+static const unsigned long intel_iphy_clk_rate[] = {
+	CLK_100MHZ, CLK_156_25MHZ, CLK_100MHZ
+};
+
+enum {
+	PHY_0 = 0,
+	PHY_1,
+	PHY_MAX_NUM,
+};
+
+enum intel_phy_mode {
+	PHY_PCIE_MODE = 0,
+	PHY_XPCS_MODE,
+	PHY_SATA_MODE,
+	PHY_MAX_MODE,
+};
+
+enum intel_combo_mode {
+	PCIE0_PCIE1_MODE = 0,
+	PCIE_DL_MODE,
+	RXAUI_MODE,
+	XPCS0_XPCS1_MODE,
+	SATA0_SATA1_MODE,
+	COMBO_PHY_MODE_MAX,
+};
+
+enum aggregated_mode {
+	PHY_SL_MODE = 0,
+	PHY_DL_MODE,
+};
+
+enum intel_phy_role {
+	PHY_INDIVIDUAL = 0,	/* Not aggr phy mode */
+	PHY_MASTER,		/* DL mode, PHY 0 */
+	PHY_SLAVE,		/* DL mode, PHY 1 */
+};
+
+#define	PHY_PCIE_CAP	BIT(PHY_PCIE_MODE)
+#define	PHY_XPCS_CAP	BIT(PHY_XPCS_MODE)
+#define	PHY_SATA_CAP	BIT(PHY_SATA_MODE)
+
+struct intel_combo_phy;
+
+struct intel_cbphy_iphy {
+	u32 id; /* Internal PHY idx 0 - 1 */
+	bool enable;
+	struct intel_combo_phy *parent;
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct device	*dev;
+	struct phy *phy;
+	struct reset_control *app_rst;
+	void __iomem *app_base;
+	struct clk *freq_clk;
+	unsigned long clk_rate;
+	enum intel_phy_mode phy_mode;
+	enum intel_phy_role phy_role;
+	bool power_en;
+};
+
+struct intel_combo_phy {
+	u32 id; /* Physical COMBO PHY Index */
+	u32 phy_cap;
+	u32 bid; /* Bus ID */
+	struct device *dev;
+	struct regmap *syscfg;
+	struct regmap *hsiocfg;
+	struct reset_control *phy_rst;
+	struct reset_control *core_rst;
+	struct intel_cbphy_iphy iphy[PHY_MAX_NUM];
+	enum intel_combo_mode mode;
+	enum aggregated_mode aggr_mode;
+};
+
+static void intel_cbphy_iphy_enable(struct intel_cbphy_iphy *iphy, bool set)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	u32 val, bitn;
+
+	bitn = iphy->phy_mode * 2 + iphy->id;
+
+	/* Register: 0 is enable, 1 is disable */
+	val =  set ? 0 : BIT(bitn);
+
+	regmap_update_bits(cbphy->hsiocfg, REG_CLK_DISABLE(cbphy->bid),
+			   BIT(bitn), val);
+}
+
+static void intel_cbphy_pcie_refclk_cfg(struct intel_cbphy_iphy *iphy, bool set)
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	const u32 pad_dis_cfg_off = 0x174;
+	u32 val, bitn;
+
+	bitn = cbphy->id * 2 + iphy->id;
+
+	/* Register: 0 is enable, 1 is disable */
+	val = set ? 0 : BIT(bitn);
+
+	regmap_update_bits(cbphy->syscfg, pad_dis_cfg_off, BIT(bitn), val);
+}
+
+static ssize_t intel_cbphy_info_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct intel_combo_phy *cbphy;
+	int i, off;
+
+	cbphy = dev_get_drvdata(dev);
+
+	off = sprintf(buf, "mode: %u\n", cbphy->mode);
+
+	off += sprintf(buf + off, "aggr mode: %s\n",
+		      cbphy->aggr_mode == PHY_DL_MODE ? "Yes" : "No");
+
+	off += sprintf(buf + off, "capability: ");
+	for (i = PHY_PCIE_MODE; i < PHY_MAX_MODE; i++) {
+		if (BIT(i) & cbphy->phy_cap)
+			off += sprintf(buf + off, "%s ", intel_iphy_names[i]);
+	}
+
+	off += sprintf(buf + off, "\n");
+
+	for (i = 0; i < PHY_MAX_NUM; i++) {
+		off += sprintf(buf + off, "PHY%d mode: %s, enable: %s\n",
+			       i, intel_iphy_names[cbphy->iphy[i].phy_mode],
+			       cbphy->iphy[i].enable ? "Yes" : "No");
+	}
+
+	return off;
+}
+
+static DEVICE_ATTR_RO(intel_cbphy_info);
+
+static struct attribute *intel_cbphy_attrs[] = {
+	&dev_attr_intel_cbphy_info.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(intel_cbphy);
+
+static int intel_cbphy_sysfs_init(struct intel_combo_phy *cbphy)
+{
+	return devm_device_add_groups(cbphy->dev, intel_cbphy_groups);
+}
+
+static inline void combo_phy_w32_off_mask(void __iomem *base,
+					  u32 mask, u32 set, unsigned int reg)
+{
+	u32 val;
+
+	val = readl(base + reg);
+	val &= ~mask;
+	val |= FIELD_PREP(mask, set);
+	writel(val, base + reg);
+}
+
+static int intel_cbphy_iphy_cfg(struct intel_cbphy_iphy *iphy,
+				int (*phy_cfg)(struct intel_cbphy_iphy *))
+{
+	struct intel_combo_phy *cbphy = iphy->parent;
+	struct intel_cbphy_iphy *sphy;
+	int ret;
+
+	ret = phy_cfg(iphy);
+	if (ret)
+		return ret;
+
+	if (cbphy->aggr_mode == PHY_DL_MODE) {
+		sphy = &cbphy->iphy[PHY_1];
+		ret =  phy_cfg(sphy);
+	}
+
+	return ret;
+}
+
+static int intel_cbphy_pcie_en_pad_refclk(struct intel_cbphy_iphy *iphy)
+{
+	intel_cbphy_pcie_refclk_cfg(iphy, true);
+	combo_phy_w32_off_mask(iphy->app_base, PCIE_PHY_CLK_PAD,
+			       0, PCIE_PHY_GEN_CTRL);
+	/*
+	 * NB, no way to identify gen1/2/3/4 for mppla and mpplb, just delay
+	 * for stable plla(gen1/gen2) or pllb(gen3/gen4)
+	 */
+	usleep_range(50, 100);
+
+	return 0;
+}
+
+static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
+{
+	intel_cbphy_pcie_refclk_cfg(iphy, false);
+	combo_phy_w32_off_mask(iphy->app_base, PCIE_PHY_CLK_PAD,
+			       1, PCIE_PHY_GEN_CTRL);
+
+	return 0;
+}
+
+static int intel_cbphy_iphy_power_on(struct intel_cbphy_iphy *iphy)
+{
+	struct device *dev = iphy->dev;
+	int ret;
+
+	ret = reset_control_deassert(iphy->app_rst);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) phy deassert failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return ret;
+	}
+
+	ret = clk_prepare_enable(iphy->freq_clk);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) freq clock enable failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return ret;
+	}
+
+	ret = clk_set_rate(iphy->freq_clk, iphy->clk_rate);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) clock frequency set to %lu failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy),
+			iphy->clk_rate);
+		goto clk_err;
+	}
+
+	intel_cbphy_iphy_enable(iphy, true);
+	iphy->power_en = true;
+
+	return ret;
+
+clk_err:
+	clk_disable_unprepare(iphy->freq_clk);
+
+	return ret;
+}
+
+static int intel_cbphy_iphy_power_off(struct intel_cbphy_iphy *iphy)
+{
+	struct device *dev = iphy->dev;
+	int ret;
+
+	ret = reset_control_assert(iphy->app_rst);
+	if (ret) {
+		dev_err(dev, "PHY(%u:%u) core assert failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return ret;
+	}
+
+	intel_cbphy_iphy_enable(iphy, false);
+	clk_disable_unprepare(iphy->freq_clk);
+	iphy->power_en = false;
+
+	return 0;
+}
+
+static int intel_cbphy_init(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy;
+	int ret = 0;
+
+	iphy = phy_get_drvdata(phy);
+
+	if (iphy->phy_mode == PHY_PCIE_MODE) {
+		ret = intel_cbphy_iphy_cfg(iphy,
+					   intel_cbphy_pcie_en_pad_refclk);
+	}
+
+	if (!ret)
+		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_on);
+
+	return ret;
+}
+
+static int intel_cbphy_exit(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy;
+	int ret = 0;
+
+	iphy = phy_get_drvdata(phy);
+
+	if (iphy->power_en)
+		ret = intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_off);
+
+	if (!ret && iphy->phy_mode == PHY_PCIE_MODE)
+		ret = intel_cbphy_iphy_cfg(iphy,
+					   intel_cbphy_pcie_dis_pad_refclk);
+
+	return ret;
+}
+
+static int intel_cbphy_power_on(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy;
+
+	iphy = phy_get_drvdata(phy);
+
+	if (iphy->power_en)
+		return 0;
+
+	return intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_on);
+}
+
+static int intel_cbphy_power_off(struct phy *phy)
+{
+	struct intel_cbphy_iphy *iphy;
+
+	iphy = phy_get_drvdata(phy);
+
+	if (!iphy->power_en)
+		return 0;
+
+	return intel_cbphy_iphy_cfg(iphy, intel_cbphy_iphy_power_off);
+}
+
+static int intel_cbphy_iphy_mem_resource(struct intel_cbphy_iphy *iphy)
+{
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(iphy->pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	iphy->app_base = base;
+
+	return 0;
+}
+
+static int intel_cbphy_iphy_get_clks(struct intel_cbphy_iphy *iphy)
+{
+	enum intel_phy_mode mode = iphy->phy_mode;
+	struct device *dev = iphy->dev;
+	int ret = 0;
+
+	iphy->freq_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(iphy->freq_clk)) {
+		ret = PTR_ERR(iphy->freq_clk);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "PHY[%u:%u] No %s freq clock\n",
+				COMBO_PHY_ID(iphy), PHY_ID(iphy),
+				intel_iphy_names[mode]);
+		}
+
+		return ret;
+	}
+
+	iphy->clk_rate = intel_iphy_clk_rate[mode];
+
+	return ret;
+}
+
+static int intel_cbphy_iphy_get_reset(struct intel_cbphy_iphy *iphy)
+{
+	enum intel_phy_mode mode = iphy->phy_mode;
+	struct device *dev = iphy->dev;
+	int ret = 0;
+
+	iphy->app_rst = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(iphy->app_rst)) {
+		ret = PTR_ERR(iphy->app_rst);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "PHY[%u:%u] Get %s reset ctrl Err!\n",
+				COMBO_PHY_ID(iphy),
+				PHY_ID(iphy), intel_iphy_names[mode]);
+		}
+
+		return ret;
+	}
+
+	return ret;
+}
+
+static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
+				     struct fwnode_handle *fwn, int idx)
+{
+	struct intel_cbphy_iphy *iphy = &cbphy->iphy[idx];
+	struct platform_device *pdev;
+	struct device *dev;
+	int ret = 0;
+	u32 prop;
+
+	iphy->id = idx;
+	iphy->enable = false;
+	iphy->power_en = false;
+	iphy->parent = cbphy;
+	iphy->np = to_of_node(fwn);
+
+	pdev = of_find_device_by_node(iphy->np);
+	if (!pdev) {
+		dev_warn(cbphy->dev, "Combo-PHY%u: PHY device: %d disabled!\n",
+			 cbphy->id, idx);
+		return 0;
+	}
+
+	dev = &pdev->dev;
+	iphy->pdev = pdev;
+	iphy->dev = dev;
+	platform_set_drvdata(pdev, iphy);
+
+	if (!device_property_read_u32(dev, "intel,phy-mode", &prop)) {
+		iphy->phy_mode = prop;
+		if (iphy->phy_mode >= PHY_MAX_MODE) {
+			dev_err(dev, "PHY mode: %u is invalid\n",
+				iphy->phy_mode);
+			return -EINVAL;
+		}
+	}
+
+	if (!(BIT(iphy->phy_mode) & cbphy->phy_cap)) {
+		dev_err(dev,
+			"PHY mode %u is not supported by CbPhy(%u) cap: 0x%x\n",
+			iphy->phy_mode, PHY_ID(iphy), cbphy->phy_cap);
+		return -EINVAL;
+	}
+
+	cbphy->aggr_mode = PHY_SL_MODE;
+	if (device_property_read_bool(dev, "intel,aggregation"))
+		cbphy->aggr_mode = PHY_DL_MODE;
+
+	if (cbphy->aggr_mode == PHY_DL_MODE)
+		iphy->phy_role = iphy->id ? PHY_SLAVE : PHY_MASTER;
+	else
+		iphy->phy_role = PHY_INDIVIDUAL;
+
+	ret = intel_cbphy_iphy_mem_resource(iphy);
+	if (ret)
+		return ret;
+
+	ret = intel_cbphy_iphy_get_clks(iphy);
+	if (ret)
+		return ret;
+
+	ret = intel_cbphy_iphy_get_reset(iphy);
+	if (ret)
+		return ret;
+
+	iphy->enable = fwnode_device_is_available(fwn);
+
+	dev_dbg(dev, "PHY(%u:%u) mode: %u, role: %u, enable %u\n",
+		COMBO_PHY_ID(iphy), PHY_ID(iphy),
+		iphy->phy_mode, iphy->phy_role, iphy->enable);
+
+	return ret;
+}
+
+static int intel_cbphy_dt_sanity_check(struct intel_combo_phy *cbphy)
+{
+	struct intel_cbphy_iphy *iphy0, *iphy1;
+
+	iphy0 = &cbphy->iphy[PHY_0];
+	iphy1 = &cbphy->iphy[PHY_1];
+
+	if (!iphy0->enable && !iphy1->enable) {
+		dev_err(cbphy->dev, "CBPHY%u both PHY disabled!\n", cbphy->id);
+		return -EINVAL;
+	}
+
+	if (cbphy->aggr_mode == PHY_DL_MODE) {
+		if (!iphy0->enable || !iphy1->enable) {
+			dev_err(cbphy->dev,
+				"Dual lane mode but lane0: %s, lane1: %s\n",
+				iphy0->enable ? "on" : "off",
+				iphy1->enable ? "on" : "off");
+			return -EINVAL;
+		}
+
+		if (iphy0->phy_mode != iphy1->phy_mode) {
+			dev_err(cbphy->dev,
+				" Mode mismatch lane0 : %u, lane1 : %u\n",
+				iphy0->phy_mode, iphy1->phy_mode);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int intel_cbphy_dt_parse(struct intel_combo_phy *cbphy)
+{
+	struct device *dev = cbphy->dev;
+	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwn;
+	int i = 0, ret = 0;
+
+	cbphy->phy_rst = devm_reset_control_get_optional(dev, "phy");
+	if (IS_ERR(cbphy->phy_rst)) {
+		ret = PTR_ERR(cbphy->phy_rst);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "get phy reset err: %d!\n", ret);
+		return ret;
+	}
+
+	cbphy->core_rst = devm_reset_control_get_optional(dev, "core");
+	if (IS_ERR(cbphy->core_rst)) {
+		ret = PTR_ERR(cbphy->core_rst);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "get combo reset err: %d!\n", ret);
+		return ret;
+	}
+
+	cbphy->syscfg = syscon_regmap_lookup_by_phandle(np, "intel,syscfg");
+	if (IS_ERR(cbphy->syscfg)) {
+		dev_err(dev, "No syscon phandle for chip cfg registers\n");
+		return PTR_ERR(cbphy->syscfg);
+	}
+
+	cbphy->hsiocfg = syscon_regmap_lookup_by_phandle(np, "intel,hsio");
+	if (IS_ERR(cbphy->hsiocfg)) {
+		dev_err(dev, "No syscon phandle for hsio\n");
+		return PTR_ERR(cbphy->hsiocfg);
+	}
+
+	ret = device_property_read_u32(dev, "intel,bid", &cbphy->bid);
+	if (ret) {
+		dev_err(dev, "NO intel,bid provided!\n");
+		return ret;
+	}
+
+	device_for_each_child_node(dev, fwn) {
+		if (i >= PHY_MAX_NUM) {
+			fwnode_handle_put(fwn);
+			dev_err(dev, "Error: DT child number larger than %d\n",
+				PHY_MAX_NUM);
+			return -EINVAL;
+		}
+
+		ret = intel_cbphy_iphy_dt_parse(cbphy, fwn, i);
+		if (ret) {
+			fwnode_handle_put(fwn);
+			return ret;
+		}
+
+		i++;
+	}
+
+	return intel_cbphy_dt_sanity_check(cbphy);
+}
+
+static void intel_cbphy_deassert(struct intel_combo_phy *cbphy)
+{
+	reset_control_deassert(cbphy->core_rst);
+	reset_control_deassert(cbphy->phy_rst);
+	usleep_range(10, 20);
+}
+
+static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
+{
+	enum intel_combo_mode cb_mode = COMBO_PHY_MODE_MAX;
+	struct device *dev = cbphy->dev;
+	struct intel_cbphy_iphy *iphy0, *iphy1;
+	enum intel_phy_mode mode;
+	enum aggregated_mode aggr = cbphy->aggr_mode;
+
+	iphy0 = &cbphy->iphy[PHY_0];
+	iphy1 = &cbphy->iphy[PHY_1];
+
+	mode = iphy0->enable ? iphy0->phy_mode : iphy1->phy_mode;
+
+	switch (mode) {
+	case PHY_PCIE_MODE:
+		cb_mode = (aggr == PHY_DL_MODE) ?
+			  PCIE_DL_MODE : PCIE0_PCIE1_MODE;
+		break;
+
+	case PHY_XPCS_MODE:
+		cb_mode = (aggr == PHY_DL_MODE) ? RXAUI_MODE : XPCS0_XPCS1_MODE;
+		break;
+
+	case PHY_SATA_MODE:
+		if (aggr == PHY_DL_MODE) {
+			dev_err(dev, "CBPHY%u mode:%u not support dual lane!\n",
+				cbphy->id, mode);
+			return -EINVAL;
+		}
+
+		cb_mode = SATA0_SATA1_MODE;
+		break;
+
+	default:
+		dev_err(dev, "CBPHY%u mode:%u not supported!\n",
+			cbphy->id, mode);
+		return -EINVAL;
+	}
+
+	cbphy->mode = cb_mode;
+	regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
+
+	return 0;
+}
+
+static const struct phy_ops intel_cbphy_ops = {
+	.init =		intel_cbphy_init,
+	.exit =		intel_cbphy_exit,
+	.power_on =	intel_cbphy_power_on,
+	.power_off =	intel_cbphy_power_off,
+};
+
+static int intel_cbphy_iphy_create(struct intel_cbphy_iphy *iphy)
+{
+	struct device *dev = iphy->dev;
+	struct phy_provider *phy_provider;
+
+	/* No phy instance required for slave */
+	if (iphy->phy_role == PHY_SLAVE)
+		return 0;
+
+	iphy->phy = devm_phy_create(dev, iphy->np, &intel_cbphy_ops);
+	if (IS_ERR(iphy->phy)) {
+		dev_err(dev, "PHY[%u:%u]: create PHY instance failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return PTR_ERR(iphy->phy);
+	}
+
+	phy_set_drvdata(iphy->phy, iphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "PHY[%u:%u]: register phy provider failed!\n",
+			COMBO_PHY_ID(iphy), PHY_ID(iphy));
+		return PTR_ERR(phy_provider);
+	}
+
+	return 0;
+}
+
+static int intel_cbphy_create(struct intel_combo_phy *cbphy)
+{
+	struct intel_cbphy_iphy *iphy;
+	int i, ret = 0;
+
+	for (i = 0; i < PHY_MAX_NUM; i++) {
+		iphy = &cbphy->iphy[i];
+		if (iphy->enable) {
+			ret = intel_cbphy_iphy_create(iphy);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int intel_cbphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_combo_phy *cbphy;
+	int id, ret;
+
+	ret = of_property_read_u32(dev->of_node, "cell-index", &id);
+	if (ret) {
+		dev_err(dev, "cell index not specified:%d\n", ret);
+		return ret;
+	}
+
+	cbphy = devm_kzalloc(dev, sizeof(*cbphy), GFP_KERNEL);
+	if (!cbphy)
+		return -ENOMEM;
+
+	cbphy->phy_cap = PHY_PCIE_CAP;
+	if (!device_property_read_bool(dev, "intel,cap-pcie-only"))
+		cbphy->phy_cap |= PHY_XPCS_CAP | PHY_SATA_CAP;
+
+	cbphy->id = id;
+	cbphy->dev = dev;
+	platform_set_drvdata(pdev, cbphy);
+
+	ret = intel_cbphy_dt_parse(cbphy);
+	if (ret)
+		return ret;
+
+	intel_cbphy_deassert(cbphy);
+	ret = intel_cbphy_set_mode(cbphy);
+	if (ret)
+		return ret;
+
+	ret = intel_cbphy_create(cbphy);
+	if (ret)
+		return ret;
+
+	ret = intel_cbphy_sysfs_init(cbphy);
+
+	return ret;
+}
+
+static const struct of_device_id of_intel_cbphy_match[] = {
+	{ .compatible = "intel,combo-phy" },
+	{}
+};
+
+static struct platform_driver intel_cbphy_driver = {
+	.probe = intel_cbphy_probe,
+	.driver = {
+		.name = "intel-combo-phy",
+		.of_match_table = of_intel_cbphy_match,
+	}
+};
+
+builtin_platform_driver(intel_cbphy_driver);
-- 
2.11.0

