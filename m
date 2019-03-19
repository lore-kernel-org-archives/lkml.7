Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83AD2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCSOaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:30:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:10784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfCSOaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:30:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 07:30:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="328649295"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2019 07:30:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C50117F; Tue, 19 Mar 2019 16:30:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] extcon: mrfld: Introduce extcon driver for Basin Cove PMIC
Date:   Tue, 19 Mar 2019 16:30:42 +0200
Message-Id: <20190319143042.66606-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319143042.66606-1-andriy.shevchenko@linux.intel.com>
References: <20190319143042.66606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Merrifield the Basin Cove PMIC provides a feature to detect
the USB connection type. This driver utilizes the feature in order
to support the USB dual role detection.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/Kconfig              |   7 +
 drivers/extcon/Makefile             |   1 +
 drivers/extcon/extcon-intel-mrfld.c | 284 ++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 drivers/extcon/extcon-intel-mrfld.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 8e17149655f0..46ad2bbeb44c 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -60,6 +60,13 @@ config EXTCON_INTEL_CHT_WC
 	  Say Y here to enable extcon support for charger detection / control
 	  on the Intel Cherrytrail Whiskey Cove PMIC.
 
+config EXTCON_INTEL_MRFLD
+	tristate "Intel Merrifield Basin Cove PMIC extcon driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	help
+	  Say Y here to enable extcon support for charger detection / control
+	  on the Intel Merrifield Basin Cove PMIC.
+
 config EXTCON_MAX14577
 	tristate "Maxim MAX14577/77836 EXTCON Support"
 	depends on MFD_MAX14577
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 261ce4cfe209..d3941a735df3 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
 obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
+obj-$(CONFIG_EXTCON_INTEL_MRFLD) += extcon-intel-mrfld.o
 obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
 obj-$(CONFIG_EXTCON_MAX3355)	+= extcon-max3355.o
 obj-$(CONFIG_EXTCON_MAX77693)	+= extcon-max77693.o
diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
new file mode 100644
index 000000000000..f47016fb28a8
--- /dev/null
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * extcon driver for Basin Cove PMIC
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/extcon-provider.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/mfd/intel_soc_pmic_mrfld.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "extcon-intel.h"
+
+#define BCOVE_USBIDCTRL			0x19
+#define BCOVE_USBIDCTRL_ID		BIT(0)
+#define BCOVE_USBIDCTRL_ACA		BIT(1)
+#define BCOVE_USBIDCTRL_ALL	(BCOVE_USBIDCTRL_ID | BCOVE_USBIDCTRL_ACA)
+
+#define BCOVE_USBIDSTS			0x1a
+#define BCOVE_USBIDSTS_GND		BIT(0)
+#define BCOVE_USBIDSTS_RARBRC_MASK	GENMASK(2, 1)
+#define BCOVE_USBIDSTS_RARBRC_SHIFT	1
+#define BCOVE_USBIDSTS_NO_ACA		0
+#define BCOVE_USBIDSTS_R_ID_A		1
+#define BCOVE_USBIDSTS_R_ID_B		2
+#define BCOVE_USBIDSTS_R_ID_C		3
+#define BCOVE_USBIDSTS_FLOAT		BIT(3)
+#define BCOVE_USBIDSTS_SHORT		BIT(4)
+
+#define BCOVE_CHGRIRQ_ALL	(BCOVE_CHGRIRQ_VBUSDET | BCOVE_CHGRIRQ_DCDET | \
+				 BCOVE_CHGRIRQ_BATTDET | BCOVE_CHGRIRQ_USBIDDET)
+
+#define BCOVE_CHGRCTRL0			0x4b
+#define BCOVE_CHGRCTRL0_CHGRRESET	BIT(0)
+#define BCOVE_CHGRCTRL0_EMRGCHREN	BIT(1)
+#define BCOVE_CHGRCTRL0_EXTCHRDIS	BIT(2)
+#define BCOVE_CHGRCTRL0_SWCONTROL	BIT(3)
+#define BCOVE_CHGRCTRL0_TTLCK		BIT(4)
+#define BCOVE_CHGRCTRL0_BIT_5		BIT(5)
+#define BCOVE_CHGRCTRL0_BIT_6		BIT(6)
+#define BCOVE_CHGRCTRL0_CHR_WDT_NOKICK	BIT(7)
+
+struct mrfld_extcon_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct extcon_dev *edev;
+	unsigned int status;
+	unsigned int id;
+};
+
+static const unsigned int mrfld_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_CDP,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_CHG_USB_ACA,
+	EXTCON_NONE,
+};
+
+static int mrfld_extcon_clear(struct mrfld_extcon_data *data, unsigned int reg,
+			      unsigned int mask)
+{
+	return regmap_update_bits(data->regmap, reg, mask, 0x00);
+}
+
+static int mrfld_extcon_set(struct mrfld_extcon_data *data, unsigned int reg,
+			    unsigned int mask)
+{
+	return regmap_update_bits(data->regmap, reg, mask, 0xff);
+}
+
+static int mrfld_extcon_sw_control(struct mrfld_extcon_data *data, bool enable)
+{
+	unsigned int mask = BCOVE_CHGRCTRL0_SWCONTROL;
+	struct device *dev = data->dev;
+	int ret;
+
+	if (enable)
+		ret = mrfld_extcon_set(data, BCOVE_CHGRCTRL0, mask);
+	else
+		ret = mrfld_extcon_clear(data, BCOVE_CHGRCTRL0, mask);
+	if (ret)
+		dev_err(dev, "can't set SW control: %d\n", ret);
+	return ret;
+}
+
+static int mrfld_extcon_get_id(struct mrfld_extcon_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	unsigned int id;
+	bool ground;
+	int ret;
+
+	ret = regmap_read(regmap, BCOVE_USBIDSTS, &id);
+	if (ret)
+		return ret;
+
+	if (id & BCOVE_USBIDSTS_FLOAT)
+		return INTEL_USB_ID_FLOAT;
+
+	switch ((id & BCOVE_USBIDSTS_RARBRC_MASK) >> BCOVE_USBIDSTS_RARBRC_SHIFT) {
+	case BCOVE_USBIDSTS_R_ID_A:
+		return INTEL_USB_RID_A;
+	case BCOVE_USBIDSTS_R_ID_B:
+		return INTEL_USB_RID_B;
+	case BCOVE_USBIDSTS_R_ID_C:
+		return INTEL_USB_RID_C;
+	}
+
+	/*
+	 * PMIC A0 reports USBIDSTS_GND = 1 for ID_GND,
+	 * but PMIC B0 reports USBIDSTS_GND = 0 for ID_GND.
+	 * Thus we must check this bit at last.
+	 */
+	ground = id & BCOVE_USBIDSTS_GND;
+	switch ('A' + BCOVE_MAJOR(data->id)) {
+	case 'A':
+		return ground ? INTEL_USB_ID_GND : INTEL_USB_ID_FLOAT;
+	case 'B':
+		return ground ? INTEL_USB_ID_FLOAT : INTEL_USB_ID_GND;
+	}
+
+	/* Unknown or unsupported type */
+	return INTEL_USB_ID_FLOAT;
+}
+
+static int mrfld_extcon_role_detect(struct mrfld_extcon_data *data)
+{
+	unsigned int id;
+	bool usb_host;
+	int ret;
+
+	ret = mrfld_extcon_get_id(data);
+	if (ret < 0)
+		return ret;
+
+	id = ret;
+
+	usb_host = (id == INTEL_USB_ID_GND) || (id == INTEL_USB_RID_A);
+	extcon_set_state_sync(data->edev, EXTCON_USB_HOST, usb_host);
+
+	return 0;
+}
+
+static int mrfld_extcon_cable_detect(struct mrfld_extcon_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	unsigned int status, change;
+	int ret;
+
+	/*
+	 * It seems SCU firmware clears the content of BCOVE_CHGRIRQ1
+	 * and makes it useless for OS. Instead we compare a previously
+	 * stored status to the current one, provided by BCOVE_SCHGRIRQ1.
+	 */
+	ret = regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
+	if (ret)
+		return ret;
+
+	change = status ^ data->status;
+	if (!change)
+		return -ENODATA;
+
+	if (change & BCOVE_CHGRIRQ_USBIDDET) {
+		ret = mrfld_extcon_role_detect(data);
+		if (ret)
+			return ret;
+	}
+
+	data->status = status;
+
+	return 0;
+}
+
+static irqreturn_t mrfld_extcon_interrupt(int irq, void *dev_id)
+{
+	struct mrfld_extcon_data *data = dev_id;
+	int ret;
+
+	ret = mrfld_extcon_cable_detect(data);
+
+	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
+
+	return ret ? IRQ_NONE: IRQ_HANDLED;
+}
+
+static int mrfld_extcon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
+	struct regmap *regmap = pmic->regmap;
+	struct mrfld_extcon_data *data;
+	unsigned int id;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	data->regmap = regmap;
+
+	data->edev = devm_extcon_dev_allocate(dev, mrfld_extcon_cable);
+	if (IS_ERR(data->edev))
+		return -ENOMEM;
+
+	ret = devm_extcon_dev_register(dev, data->edev);
+	if (ret < 0) {
+		dev_err(dev, "can't register extcon device: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_extcon_interrupt,
+					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
+					data);
+	if (ret) {
+		dev_err(dev, "can't register IRQ handler: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(regmap, BCOVE_ID, &id);
+	if (ret) {
+		dev_err(dev, "can't read PMIC ID: %d\n", ret);
+		return ret;
+	}
+
+	data->id = id;
+
+	ret = mrfld_extcon_sw_control(data, true);
+	if (ret)
+		return ret;
+
+	/* Get initial state */
+	mrfld_extcon_role_detect(data);
+
+	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
+	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
+
+	mrfld_extcon_set(data, BCOVE_USBIDCTRL, BCOVE_USBIDCTRL_ALL);
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int mrfld_extcon_remove(struct platform_device *pdev)
+{
+	struct mrfld_extcon_data *data = platform_get_drvdata(pdev);
+
+	mrfld_extcon_sw_control(data, false);
+
+	return 0;
+}
+
+static const struct platform_device_id mrfld_extcon_id_table[] = {
+	{ .name = "mrfld_bcove_pwrsrc" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, mrfld_extcon_id_table);
+
+static struct platform_driver mrfld_extcon_driver = {
+	.driver = {
+		.name	= "mrfld_bcove_pwrsrc",
+	},
+	.probe		= mrfld_extcon_probe,
+	.remove		= mrfld_extcon_remove,
+	.id_table	= mrfld_extcon_id_table,
+};
+module_platform_driver(mrfld_extcon_driver);
+
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("extcon driver for Intel Merrifield Basin Cove PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

