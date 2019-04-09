Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B38C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB92084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMqrd/ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDIOnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39768 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfDIOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:01 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so5275640ita.4;
        Tue, 09 Apr 2019 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJyLNWCBZSzmhb6HzxsKhyTUSBZpvF5u+qVV/Z6KTpc=;
        b=cMqrd/zegq5701uwgncQeFOmc1FTXEGzXj7Vd+deKMhLHGsDM10oQ5gFboDzRDhNpR
         DlzSFuZASxuLud1QEXLY6b4lbbvxAbVqK+peY943gr2Icm70i3dLAP2mlSHM7TihkzOK
         /5OrJgpBPAx++YGaSdYRmk9SGGOj0emQs941qMNUYFmJM32W6qqkkMJ2U1Ab3J11bWPV
         TbV5vZoo61Zj05GzjGIukGEUSjA2rWR/Wx3nFRpUuqA4AqO5OGlz3abPW5tbRUBm3GVK
         JEMouGgYtrWZTAVyZlUGV7H43sgjDnBIZVLFhDaER869ZTZAhhzWvrfFrNaNm5peMAEx
         gu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJyLNWCBZSzmhb6HzxsKhyTUSBZpvF5u+qVV/Z6KTpc=;
        b=kRj7qDJm7LU6oFPqy2zVYYgzTJTn+m5XVGV/wu9oFpOrbcDiuFFSXJbTQe0/F8XLhz
         dKPww3aRxIEWA1ZIqjN7xui5+527SAV+egzto8Edp9f336cMi35pnBoEHhJDv3C+3QPi
         X/39IN3GQ84yBmCyFoAZk27CxZyQpVK8XlA2W/+ih8tz5uICaGoIjmCosnROnZD3z8Sp
         tvIWL3o4jATvaFrPz6N8VVeywZuu4it+r9lLC+9W1lh73AcXDItfPDG6lBymUSdBp3a5
         X9hHSUE4kN+8Vp0wROdjZqtInVs8KY0UfezzLETnt5k1bmh+NOrRZ8KraPYfbxTEPvOB
         o9iQ==
X-Gm-Message-State: APjAAAWCnzSzaER+c/dmE/9ziYS0OQ234JfQetKy0cLBJ8TV6QJKuywY
        hEo6s9yCDnoyQADs5GisEJQ=
X-Google-Smtp-Source: APXvYqzPL9P9kvd9VCpEDV7XuNQ6n8K8JogH2M53ZGfHqYF7qf5LZyHBJHC/JW66tPAPciUILv6WVQ==
X-Received: by 2002:a24:e208:: with SMTP id q8mr25546156ith.145.1554820980021;
        Tue, 09 Apr 2019 07:43:00 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j10sm6562000itj.32.2019.04.09.07.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:42:59 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v10 3/7] anybus-s: support the Arcx anybus controller
Date:   Tue,  9 Apr 2019 10:42:46 -0400
Message-Id: <20190409144250.7237-4-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Arcx anybus controller.

This device implements two Anybus-S hosts (buses),
and connects to the SoC via a parallel memory bus.
There is also a CAN power readout, unrelated to the Anybus,
modelled as a regulator.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/Makefile             |   1 -
 drivers/staging/fieldbus/anybuss/Kconfig      |  14 +
 drivers/staging/fieldbus/anybuss/Makefile     |   2 +
 .../staging/fieldbus/anybuss/arcx-anybus.c    | 398 ++++++++++++++++++
 4 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fieldbus/anybuss/arcx-anybus.c

diff --git a/drivers/staging/fieldbus/Makefile b/drivers/staging/fieldbus/Makefile
index c21056bdb3d2..bdf645d41344 100644
--- a/drivers/staging/fieldbus/Makefile
+++ b/drivers/staging/fieldbus/Makefile
@@ -5,4 +5,3 @@
 
 obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus_dev.o anybuss/
 fieldbus_dev-y			:= dev_core.o
-
diff --git a/drivers/staging/fieldbus/anybuss/Kconfig b/drivers/staging/fieldbus/anybuss/Kconfig
index 5b495f25c11e..e257f8a517bb 100644
--- a/drivers/staging/fieldbus/anybuss/Kconfig
+++ b/drivers/staging/fieldbus/anybuss/Kconfig
@@ -7,3 +7,17 @@ config HMS_ANYBUSS_BUS
 	  You can attach a single Anybus-S compatible card to it, which
 	  typically provides fieldbus and industrial ethernet
 	  functionality.
+
+if HMS_ANYBUSS_BUS
+
+config ARCX_ANYBUS_CONTROLLER
+	tristate "Arcx Anybus-S Controller"
+	depends on OF && GPIOLIB && HAS_IOMEM && REGULATOR
+	help
+	  Select this to get support for the Arcx Anybus controller.
+	  It connects to the SoC via a parallel memory bus, and
+	  embeds up to two Anybus-S buses (slots).
+	  There is also a CAN power readout, unrelated to the Anybus,
+	  modelled as a regulator.
+
+endif
diff --git a/drivers/staging/fieldbus/anybuss/Makefile b/drivers/staging/fieldbus/anybuss/Makefile
index 236579aa7270..7198b080926b 100644
--- a/drivers/staging/fieldbus/anybuss/Makefile
+++ b/drivers/staging/fieldbus/anybuss/Makefile
@@ -5,3 +5,5 @@
 
 obj-$(CONFIG_HMS_ANYBUSS_BUS)	+= anybuss_core.o
 anybuss_core-y			+= host.o
+
+obj-$(CONFIG_ARCX_ANYBUS_CONTROLLER) += arcx-anybus.o
diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
new file mode 100644
index 000000000000..b21b8cf9cc0f
--- /dev/null
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Arcx Anybus-S Controller driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/idr.h>
+#include <linux/mutex.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regmap.h>
+
+#include <linux/anybuss-controller.h>
+
+#define CPLD_STATUS1		0x80
+#define CPLD_CONTROL		0x80
+#define CPLD_CONTROL_CRST	0x40
+#define CPLD_CONTROL_RST1	0x04
+#define CPLD_CONTROL_RST2	0x80
+#define CPLD_STATUS1_AB		0x02
+#define CPLD_STATUS1_CAN_POWER	0x01
+#define CPLD_DESIGN_LO		0x81
+#define CPLD_DESIGN_HI		0x82
+#define CPLD_CAP		0x83
+#define CPLD_CAP_COMPAT		0x01
+#define CPLD_CAP_SEP_RESETS	0x02
+
+struct controller_priv {
+	struct device *class_dev;
+	bool common_reset;
+	struct gpio_desc *reset_gpiod;
+	void __iomem *cpld_base;
+	struct mutex ctrl_lock; /* protects CONTROL register */
+	u8 control_reg;
+	char version[3];
+	u16 design_no;
+};
+
+static void do_reset(struct controller_priv *cd, u8 rst_bit, bool reset)
+{
+	mutex_lock(&cd->ctrl_lock);
+	/*
+	 * CPLD_CONTROL is write-only, so cache its value in
+	 * cd->control_reg
+	 */
+	if (reset)
+		cd->control_reg &= ~rst_bit;
+	else
+		cd->control_reg |= rst_bit;
+	writeb(cd->control_reg, cd->cpld_base + CPLD_CONTROL);
+	/*
+	 * h/w work-around:
+	 * the hardware is 'too fast', so a reset followed by an immediate
+	 * not-reset will _not_ change the anybus reset line in any way,
+	 * losing the reset. to prevent this from happening, introduce
+	 * a minimum reset duration.
+	 * Verified minimum safe duration required using a scope
+	 * on 14-June-2018: 100 us.
+	 */
+	if (reset)
+		usleep_range(100, 200);
+	mutex_unlock(&cd->ctrl_lock);
+}
+
+static int anybuss_reset(struct controller_priv *cd,
+			 unsigned long id, bool reset)
+{
+	if (id >= 2)
+		return -EINVAL;
+	if (cd->common_reset)
+		do_reset(cd, CPLD_CONTROL_CRST, reset);
+	else
+		do_reset(cd, id ? CPLD_CONTROL_RST2 : CPLD_CONTROL_RST1, reset);
+	return 0;
+}
+
+static void export_reset_0(struct device *dev, bool assert)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	anybuss_reset(cd, 0, assert);
+}
+
+static void export_reset_1(struct device *dev, bool assert)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	anybuss_reset(cd, 1, assert);
+}
+
+/*
+ * parallel bus limitation:
+ *
+ * the anybus is 8-bit wide. we can't assume that the hardware will translate
+ * word accesses on the parallel bus to multiple byte-accesses on the anybus.
+ *
+ * the imx WEIM bus does not provide this type of translation.
+ *
+ * to be safe, we will limit parallel bus accesses to a single byte
+ * at a time for now.
+ */
+
+static int read_reg_bus(void *context, unsigned int reg,
+			unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readb(base + reg);
+	return 0;
+}
+
+static int write_reg_bus(void *context, unsigned int reg,
+			 unsigned int val)
+{
+	void __iomem *base = context;
+
+	writeb(val, base + reg);
+	return 0;
+}
+
+static struct regmap *create_parallel_regmap(struct platform_device *pdev,
+					     int idx)
+{
+	struct regmap_config regmap_cfg = {
+		.reg_bits = 11,
+		.val_bits = 8,
+		/*
+		 * single-byte parallel bus accesses are atomic, so don't
+		 * require any synchronization.
+		 */
+		.disable_locking = true,
+		.reg_read = read_reg_bus,
+		.reg_write = write_reg_bus,
+	};
+	struct resource *res;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, idx + 1);
+	if (resource_size(res) < (1 << regmap_cfg.reg_bits))
+		return ERR_PTR(-EINVAL);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+	return devm_regmap_init(dev, NULL, base, &regmap_cfg);
+}
+
+static struct anybuss_host *
+create_anybus_host(struct platform_device *pdev, int idx)
+{
+	struct anybuss_ops ops = {};
+
+	switch (idx) {
+	case 0:
+		ops.reset = export_reset_0;
+		break;
+	case 1:
+		ops.reset = export_reset_1;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+	ops.host_idx = idx;
+	ops.regmap = create_parallel_regmap(pdev, idx);
+	if (IS_ERR(ops.regmap))
+		return ERR_CAST(ops.regmap);
+	ops.irq = platform_get_irq(pdev, idx);
+	if (ops.irq <= 0)
+		return ERR_PTR(-EINVAL);
+	return devm_anybuss_host_common_probe(&pdev->dev, &ops);
+}
+
+static ssize_t version_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", cd->version);
+}
+static DEVICE_ATTR_RO(version);
+
+static ssize_t design_number_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct controller_priv *cd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cd->design_no);
+}
+static DEVICE_ATTR_RO(design_number);
+
+static struct attribute *controller_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_design_number.attr,
+	NULL,
+};
+
+static struct attribute_group controller_attribute_group = {
+	.attrs = controller_attributes,
+};
+
+static const struct attribute_group *controller_attribute_groups[] = {
+	&controller_attribute_group,
+	NULL,
+};
+
+static void controller_device_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static int can_power_is_enabled(struct regulator_dev *rdev)
+{
+	struct controller_priv *cd = rdev_get_drvdata(rdev);
+
+	return !(readb(cd->cpld_base + CPLD_STATUS1) & CPLD_STATUS1_CAN_POWER);
+}
+
+static struct regulator_ops can_power_ops = {
+	.is_enabled = can_power_is_enabled,
+};
+
+static const struct regulator_desc can_power_desc = {
+	.name = "regulator-can-power",
+	.id = -1,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &can_power_ops,
+};
+
+static struct class *controller_class;
+static DEFINE_IDA(controller_index_ida);
+
+static int controller_probe(struct platform_device *pdev)
+{
+	struct controller_priv *cd;
+	struct device *dev = &pdev->dev;
+	struct regulator_config config = { };
+	struct regulator_dev *regulator;
+	int err, id;
+	struct resource *res;
+	struct anybuss_host *host;
+	u8 status1, cap;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+	dev_set_drvdata(dev, cd);
+	mutex_init(&cd->ctrl_lock);
+	cd->reset_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(cd->reset_gpiod))
+		return PTR_ERR(cd->reset_gpiod);
+
+	/* CPLD control memory, sits at index 0 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cd->cpld_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cd->cpld_base)) {
+		dev_err(dev,
+			"failed to map cpld base address\n");
+		err = PTR_ERR(cd->cpld_base);
+		goto out_reset;
+	}
+
+	/* identify cpld */
+	status1 = readb(cd->cpld_base + CPLD_STATUS1);
+	cd->design_no = (readb(cd->cpld_base + CPLD_DESIGN_HI) << 8) |
+				readb(cd->cpld_base + CPLD_DESIGN_LO);
+	snprintf(cd->version, sizeof(cd->version), "%c%d",
+		 'A' + ((status1 >> 5) & 0x7),
+		 (status1 >> 2) & 0x7);
+	dev_info(dev, "design number %d, revision %s\n",
+		 cd->design_no,
+		cd->version);
+	cap = readb(cd->cpld_base + CPLD_CAP);
+	if (!(cap & CPLD_CAP_COMPAT)) {
+		dev_err(dev, "unsupported controller [cap=0x%02X]", cap);
+		err = -ENODEV;
+		goto out_reset;
+	}
+
+	if (status1 & CPLD_STATUS1_AB) {
+		dev_info(dev, "has anybus-S slot(s)");
+		cd->common_reset = !(cap & CPLD_CAP_SEP_RESETS);
+		dev_info(dev, "supports %s", cd->common_reset ?
+			"a common reset" : "separate resets");
+		for (id = 0; id < 2; id++) {
+			host = create_anybus_host(pdev, id);
+			if (!IS_ERR(host))
+				continue;
+			err = PTR_ERR(host);
+			/* -ENODEV is fine, it just means no card detected */
+			if (err != -ENODEV)
+				goto out_reset;
+		}
+	}
+
+	id = ida_simple_get(&controller_index_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		err = id;
+		goto out_reset;
+	}
+	/* export can power readout as a regulator */
+	config.dev = dev;
+	config.driver_data = cd;
+	regulator = devm_regulator_register(dev, &can_power_desc, &config);
+	if (IS_ERR(regulator)) {
+		err = PTR_ERR(regulator);
+		goto out_reset;
+	}
+	/* make controller info visible to userspace */
+	cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
+	if (!cd->class_dev) {
+		err = -ENOMEM;
+		goto out_ida;
+	}
+	cd->class_dev->class = controller_class;
+	cd->class_dev->groups = controller_attribute_groups;
+	cd->class_dev->parent = dev;
+	cd->class_dev->id = id;
+	cd->class_dev->release = controller_device_release;
+	dev_set_name(cd->class_dev, "%d", cd->class_dev->id);
+	dev_set_drvdata(cd->class_dev, cd);
+	err = device_register(cd->class_dev);
+	if (err)
+		goto out_dev;
+	return 0;
+out_dev:
+	put_device(cd->class_dev);
+out_ida:
+	ida_simple_remove(&controller_index_ida, id);
+out_reset:
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return err;
+}
+
+static int controller_remove(struct platform_device *pdev)
+{
+	struct controller_priv *cd = platform_get_drvdata(pdev);
+	int id = cd->class_dev->id;
+
+	device_unregister(cd->class_dev);
+	ida_simple_remove(&controller_index_ida, id);
+	gpiod_set_value_cansleep(cd->reset_gpiod, 1);
+	return 0;
+}
+
+static const struct of_device_id controller_of_match[] = {
+	{ .compatible = "arcx,anybus-controller" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, controller_of_match);
+
+static struct platform_driver controller_driver = {
+	.probe = controller_probe,
+	.remove = controller_remove,
+	.driver		= {
+		.name   = "arcx-anybus-controller",
+		.of_match_table	= of_match_ptr(controller_of_match),
+	},
+};
+
+static int __init controller_init(void)
+{
+	int err;
+
+	controller_class = class_create(THIS_MODULE, "arcx_anybus_controller");
+	if (IS_ERR(controller_class))
+		return PTR_ERR(controller_class);
+	err = platform_driver_register(&controller_driver);
+	if (err)
+		class_destroy(controller_class);
+
+	return err;
+}
+
+static void __exit controller_exit(void)
+{
+	platform_driver_unregister(&controller_driver);
+	class_destroy(controller_class);
+	ida_destroy(&controller_index_ida);
+}
+
+module_init(controller_init);
+module_exit(controller_exit);
+
+MODULE_DESCRIPTION("Arcx Anybus-S Controller driver");
+MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

