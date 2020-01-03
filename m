Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79DC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6F20672
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgACKAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:00:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:13286 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgACKAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:00:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 02:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="302205297"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 03 Jan 2020 02:00:26 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, robh@kernel.org,
        martin.blumenstingl@googlemail.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v6 2/2] reset: intel: Add system reset controller driver
Date:   Fri,  3 Jan 2020 18:00:18 +0800
Message-Id: <578307a64c72a72d87c77bd9b5e97143b914cbde.1578021776.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <ab84cc2ada92e4512ff18b11d6f1f752e5821b67.1578021776.git.eswara.kota@linux.intel.com>
References: <ab84cc2ada92e4512ff18b11d6f1f752e5821b67.1578021776.git.eswara.kota@linux.intel.com>
In-Reply-To: <ab84cc2ada92e4512ff18b11d6f1f752e5821b67.1578021776.git.eswara.kota@linux.intel.com>
References: <ab84cc2ada92e4512ff18b11d6f1f752e5821b67.1578021776.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the reset controller present on Intel
Gateway SoCs for performing reset management of the
devices present on the SoC. Driver also registers a
reset handler to peform the entire device reset.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
---
Changes on v6:
	Address review comments
	 Define structures xrx200_data and lgm_data as static const
	 Remove timer as parameter for intel_set_clr_bits()
	Correct the alignments during restart_nb structure field assignments

Changes on v5:
	Rebase patches on v5.5-rc1 kernel

Changes on v4:
	No Change

Changes on v3:
	Address review comments:
		Remove intel_reset_device() as not supported
	reset-intel-syscon.c renamed to reset-intel-gw.c
	Remove syscon and add regmap logic
	Add support to legacy xrx200 SoC
	Use bitfield helper functions for bit operations.
	Change config RESET_INTEL_SYSCON-> RESET_INTEL_GW
 drivers/reset/Kconfig          |   9 ++
 drivers/reset/Makefile         |   1 +
 drivers/reset/reset-intel-gw.c | 262 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/reset/reset-intel-gw.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 3ad7817ce1f0..218571cda38d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -64,6 +64,15 @@ config RESET_IMX7
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
 
+config RESET_INTEL_GW
+	bool "Intel Reset Controller Driver"
+	depends on OF
+	select REGMAP_MMIO
+	help
+	  This enables the reset controller driver for Intel Gateway SoCs.
+	  Say Y to control the reset signals provided by reset controller.
+	  Otherwise, say N.
+
 config RESET_LANTIQ
 	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
 	default SOC_TYPE_XWAY
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cf60ce526064..a196d545b4b8 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
+obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
new file mode 100644
index 000000000000..854238444616
--- /dev/null
+++ b/drivers/reset/reset-intel-gw.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Intel Corporation.
+ * Lei Chuanhua <Chuanhua.lei@intel.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#define RCU_RST_STAT	0x0024
+#define RCU_RST_REQ	0x0048
+
+#define REG_OFFSET	GENMASK(31, 16)
+#define BIT_OFFSET	GENMASK(15, 8)
+#define STAT_BIT_OFFSET	GENMASK(7, 0)
+
+#define to_reset_data(x)	container_of(x, struct intel_reset_data, rcdev)
+
+struct intel_reset_soc {
+	bool legacy;
+	u32 reset_cell_count;
+};
+
+struct intel_reset_data {
+	struct reset_controller_dev rcdev;
+	struct notifier_block restart_nb;
+	const struct intel_reset_soc *soc_data;
+	struct regmap *regmap;
+	struct device *dev;
+	u32 reboot_id;
+};
+
+static const struct regmap_config intel_rcu_regmap_config = {
+	.name =		"intel-reset",
+	.reg_bits =	32,
+	.reg_stride =	4,
+	.val_bits =	32,
+	.fast_io =	true,
+};
+
+/*
+ * Reset status register offset relative to
+ * the reset control register(X) is X + 4
+ */
+static u32 id_to_reg_and_bit_offsets(struct intel_reset_data *data,
+				     unsigned long id, u32 *rst_req,
+				     u32 *req_bit, u32 *stat_bit)
+{
+	*rst_req = FIELD_GET(REG_OFFSET, id);
+	*req_bit = FIELD_GET(BIT_OFFSET, id);
+
+	if (data->soc_data->legacy)
+		*stat_bit = FIELD_GET(STAT_BIT_OFFSET, id);
+	else
+		*stat_bit = *req_bit;
+
+	if (data->soc_data->legacy && *rst_req == RCU_RST_REQ)
+		return RCU_RST_STAT;
+	else
+		return *rst_req + 0x4;
+}
+
+static int intel_set_clr_bits(struct intel_reset_data *data, unsigned long id,
+			      bool set)
+{
+	u32 rst_req, req_bit, rst_stat, stat_bit, val;
+	int ret;
+
+	rst_stat = id_to_reg_and_bit_offsets(data, id, &rst_req,
+					     &req_bit, &stat_bit);
+
+	val = set ? BIT(req_bit) : 0;
+	ret = regmap_update_bits(data->regmap, rst_req,  BIT(req_bit), val);
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(data->regmap, rst_stat, val,
+					set == !!(val & BIT(stat_bit)), 20,
+					200);
+}
+
+static int intel_assert_device(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct intel_reset_data *data = to_reset_data(rcdev);
+	int ret;
+
+	ret = intel_set_clr_bits(data, id, true);
+	if (ret)
+		dev_err(data->dev, "Reset assert failed %d\n", ret);
+
+	return ret;
+}
+
+static int intel_deassert_device(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct intel_reset_data *data = to_reset_data(rcdev);
+	int ret;
+
+	ret = intel_set_clr_bits(data, id, false);
+	if (ret)
+		dev_err(data->dev, "Reset deassert failed %d\n", ret);
+
+	return ret;
+}
+
+static int intel_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct intel_reset_data *data = to_reset_data(rcdev);
+	u32 rst_req, req_bit, rst_stat, stat_bit, val;
+	int ret;
+
+	rst_stat = id_to_reg_and_bit_offsets(data, id, &rst_req,
+					     &req_bit, &stat_bit);
+	ret = regmap_read(data->regmap, rst_stat, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(stat_bit));
+}
+
+static const struct reset_control_ops intel_reset_ops = {
+	.assert =	intel_assert_device,
+	.deassert =	intel_deassert_device,
+	.status	=	intel_reset_status,
+};
+
+static int intel_reset_xlate(struct reset_controller_dev *rcdev,
+			     const struct of_phandle_args *spec)
+{
+	struct intel_reset_data *data = to_reset_data(rcdev);
+	u32 id;
+
+	if (spec->args[1] > 31)
+		return -EINVAL;
+
+	id = FIELD_PREP(REG_OFFSET, spec->args[0]);
+	id |= FIELD_PREP(BIT_OFFSET, spec->args[1]);
+
+	if (data->soc_data->legacy) {
+		if (spec->args[2] > 31)
+			return -EINVAL;
+
+		id |= FIELD_PREP(STAT_BIT_OFFSET, spec->args[2]);
+	}
+
+	return id;
+}
+
+static int intel_reset_restart_handler(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct intel_reset_data *reset_data;
+
+	reset_data = container_of(nb, struct intel_reset_data, restart_nb);
+	intel_assert_device(&reset_data->rcdev, reset_data->reboot_id);
+
+	return NOTIFY_DONE;
+}
+
+static int intel_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct intel_reset_data *data;
+	void __iomem *base;
+	u32 rb_id[3];
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->soc_data = of_device_get_match_data(dev);
+	if (!data->soc_data)
+		return -ENODEV;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	data->regmap = devm_regmap_init_mmio(dev, base,
+					     &intel_rcu_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "regmap initialization failed\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	ret = device_property_read_u32_array(dev, "intel,global-reset", rb_id,
+					     data->soc_data->reset_cell_count);
+	if (ret) {
+		dev_err(dev, "Failed to get global reset offset!\n");
+		return ret;
+	}
+
+	data->dev =			dev;
+	data->rcdev.of_node =		np;
+	data->rcdev.owner =		dev->driver->owner;
+	data->rcdev.ops	=		&intel_reset_ops;
+	data->rcdev.of_xlate =		intel_reset_xlate;
+	data->rcdev.of_reset_n_cells =	data->soc_data->reset_cell_count;
+	ret = devm_reset_controller_register(&pdev->dev, &data->rcdev);
+	if (ret)
+		return ret;
+
+	data->reboot_id = FIELD_PREP(REG_OFFSET, rb_id[0]);
+	data->reboot_id |= FIELD_PREP(BIT_OFFSET, rb_id[1]);
+
+	if (data->soc_data->legacy)
+		data->reboot_id |= FIELD_PREP(STAT_BIT_OFFSET, rb_id[2]);
+
+	data->restart_nb.notifier_call =	intel_reset_restart_handler;
+	data->restart_nb.priority =		128;
+	register_restart_handler(&data->restart_nb);
+
+	return 0;
+}
+
+static const struct intel_reset_soc xrx200_data = {
+	.legacy =		true,
+	.reset_cell_count =	3,
+};
+
+static const struct intel_reset_soc lgm_data = {
+	.legacy =		false,
+	.reset_cell_count =	2,
+};
+
+static const struct of_device_id intel_reset_match[] = {
+	{ .compatible = "intel,rcu-lgm", .data = &lgm_data },
+	{ .compatible = "intel,rcu-xrx200", .data = &xrx200_data },
+	{}
+};
+
+static struct platform_driver intel_reset_driver = {
+	.probe = intel_reset_probe,
+	.driver = {
+		.name = "intel-reset",
+		.of_match_table = intel_reset_match,
+	},
+};
+
+static int __init intel_reset_init(void)
+{
+	return platform_driver_register(&intel_reset_driver);
+}
+
+/*
+ * RCU is system core entity which is in Always On Domain whose clocks
+ * or resource initialization happens in system core initialization.
+ * Also, it is required for most of the platform or architecture
+ * specific devices to perform reset operation as part of initialization.
+ * So perform RCU as post core initialization.
+ */
+postcore_initcall(intel_reset_init);
-- 
2.11.0

