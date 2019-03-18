Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B44E2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCRJx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:53:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:33424 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfCRJxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:53:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 02:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,493,1544515200"; 
   d="scan'208";a="123573618"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2019 02:53:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B8CC17F; Mon, 18 Mar 2019 11:53:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: Add support for Basin Cove power button
Date:   Mon, 18 Mar 2019 12:53:51 +0300
Message-Id: <20190318095351.69343-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a new input driver for supporting the power button on
Basin Cove PMIC, found on Intel Merrifield-based devices.

The driver follows the design used in intel_chtdc_ti_pwrbtn.c module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig              |  11 +++
 drivers/platform/x86/Makefile             |   1 +
 drivers/platform/x86/intel_mrfld_pwrbtn.c | 107 ++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/platform/x86/intel_mrfld_pwrbtn.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index a1ed13183559..85b92a95e4c8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1263,6 +1263,17 @@ config INTEL_CHTDC_TI_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_chtdc_ti_pwrbtn.
 
+config INTEL_MRFLD_PWRBTN
+	tristate "Intel Merrifield Basin Cove power button driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	depends on INPUT
+	---help---
+	  This option adds a power button driver for Basin Cove PMIC
+	  on Intel Merrifield devices.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_mrfld_pwrbtn.
+
 config I2C_MULTI_INSTANTIATE
 	tristate "I2C multi instantiate pseudo device driver"
 	depends on I2C && ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 86cb76677bc8..87b0069bd781 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
 obj-$(CONFIG_INTEL_ATOMISP2_PM)	+= intel_atomisp2_pm.o
 obj-$(CONFIG_PCENGINES_APU2)	+= pcengines-apuv2.o
diff --git a/drivers/platform/x86/intel_mrfld_pwrbtn.c b/drivers/platform/x86/intel_mrfld_pwrbtn.c
new file mode 100644
index 000000000000..b1b367d261cb
--- /dev/null
+++ b/drivers/platform/x86/intel_mrfld_pwrbtn.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power-button driver for Basin Cove PMIC
+ *
+ * Copyright (c) 2018, Intel Corporation.
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/mfd/intel_soc_pmic_mrfld.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/slab.h>
+
+#define BCOVE_PBSTATUS		0x27
+#define BCOVE_PBSTATUS_PBLVL	BIT(4)	/* 1 - release, 0 - press */
+
+static irqreturn_t mrfld_pwrbtn_interrupt(int irq, void *dev_id)
+{
+	struct input_dev *input = dev_id;
+	struct device *dev = input->dev.parent;
+	struct regmap *regmap = dev_get_drvdata(dev);
+	unsigned int state;
+	int ret;
+
+	ret = regmap_read(regmap, BCOVE_PBSTATUS, &state);
+	if (ret)
+		return IRQ_NONE;
+
+	dev_dbg(dev, "PBSTATUS=0x%x\n", state);
+	input_report_key(input, KEY_POWER, !(state & BCOVE_PBSTATUS_PBLVL));
+	input_sync(input);
+
+	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_PWRBTN, 0);
+	return IRQ_HANDLED;
+}
+
+static int mrfld_pwrbtn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
+	struct input_dev *input;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	input->name = pdev->name;
+	input->phys = "power-button/input0";
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = dev;
+	input_set_capability(input, EV_KEY, KEY_POWER);
+	ret = input_register_device(input);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, pmic->regmap);
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_pwrbtn_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
+					input);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pmic->regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_PWRBTN, 0);
+	regmap_update_bits(pmic->regmap, BCOVE_MPBIRQ, BCOVE_PBIRQ_PBTN, 0);
+
+	device_init_wakeup(dev, true);
+	dev_pm_set_wake_irq(dev, irq);
+	return 0;
+}
+
+static int mrfld_pwrbtn_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
+	return 0;
+}
+
+static const struct platform_device_id mrfld_pwrbtn_id_table[] = {
+	{ .name = "mrfld_bcove_pwrbtn" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, mrfld_pwrbtn_id_table);
+
+static struct platform_driver mrfld_pwrbtn_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+	},
+	.probe		= mrfld_pwrbtn_probe,
+	.remove		= mrfld_pwrbtn_remove,
+	.id_table	= mrfld_pwrbtn_id_table,
+};
+module_platform_driver(mrfld_pwrbtn_driver);
+
+MODULE_DESCRIPTION("Power-button driver for Basin Cove PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

