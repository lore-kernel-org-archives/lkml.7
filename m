Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942CF20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qVHkUpXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbfDARpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:45:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34220 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbfDAReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:34:18 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31HY5rQ129037;
        Mon, 1 Apr 2019 12:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554140045;
        bh=Cac50qITR0uXz3jNZcqSpB7OHZctr32fPLVIx57tlGg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qVHkUpXkSQ8xLlWvZujrXvK8n54eqjEpORgHK8KSSISVRGATcQm6heo1Ly4N2EBDF
         8HpVWiXJnmcQjSPXxE5ms2GLYdWndE8DgVHrnNvyFwkb9b9paFVKOjvRE3N/Onl/VC
         KDDIsoVj4FUmab6GCSmt8fpxAyOD7GApzhhEow1w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31HY5tB071871
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 12:34:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 12:34:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 12:34:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31HY59e015240;
        Mon, 1 Apr 2019 12:34:05 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <marek.behun@nic.cz>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 5/5] leds: multicolor: Introduce a multicolor class definition
Date:   Mon, 1 Apr 2019 12:34:00 -0500
Message-ID: <20190401173400.14238-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190401173400.14238-1-dmurphy@ti.com>
References: <20190401173400.14238-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a multicolor class that groups colored LEDs
within a LED node.

The framework allows for dynamically setting individual LEDs
or setting brightness levels of LEDs and updating them virtually
simultaneously.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig                 |  10 +
 drivers/leds/Makefile                |   1 +
 drivers/leds/led-class-multicolor.c  | 411 +++++++++++++++++++++++++++
 include/linux/led-class-multicolor.h |  69 +++++
 4 files changed, 491 insertions(+)
 create mode 100644 drivers/leds/led-class-multicolor.c
 create mode 100644 include/linux/led-class-multicolor.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..477e108fd2a7 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -29,6 +29,16 @@ config LEDS_CLASS_FLASH
 	  for the flash related features of a LED device. It can be built
 	  as a module.
 
+config LEDS_CLASS_MULTI_COLOR
+	tristate "LED Mulit Color LED Class Support"
+	depends on LEDS_CLASS
+	help
+	  This option enables the flash led sysfs class in /sys/class/leds.
+	  It wrapps LED Class and adds flash LEDs specific sysfs attributes
+	  and kernel internal API to it. You'll need this to provide support
+	  for the flash related features of a LED device. It can be built
+	  as a module.
+
 config LEDS_BRIGHTNESS_HW_CHANGED
 	bool "LED Class brightness_hw_changed attribute support"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4c1b0054f379..c57c2aec9510 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_NEW_LEDS)			+= led-core.o
 obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
 obj-$(CONFIG_LEDS_CLASS_FLASH)		+= led-class-flash.o
+obj-$(CONFIG_LEDS_CLASS_MULTI_COLOR)	+= led-class-multicolor.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o
 
 # LED Platform Drivers
diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
new file mode 100644
index 000000000000..d54a884eaf09
--- /dev/null
+++ b/drivers/leds/led-class-multicolor.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+// LED Multi Color class interface
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "leds.h"
+
+const char *led_colors[LED_COLOR_ID_MAX + 1] = {
+	[LED_COLOR_ID_WHITE] = LED_COLOR_NAME_WHITE,
+	[LED_COLOR_ID_RED] = LED_COLOR_NAME_RED,
+	[LED_COLOR_ID_GREEN] = LED_COLOR_NAME_GREEN,
+	[LED_COLOR_ID_BLUE] = LED_COLOR_NAME_BLUE,
+	[LED_COLOR_ID_AMBER] = LED_COLOR_NAME_AMBER,
+	[LED_COLOR_ID_VIOLET] = LED_COLOR_NAME_VIOLET,
+	[LED_COLOR_ID_YELLOW] = LED_COLOR_NAME_YELLOW,
+};
+
+struct led_classdev_mc_data {
+	struct led_classdev_mc *mcled_cdev;
+	struct kobject *color_kobj;
+	struct kobject *led_kobj;
+
+	struct device_attribute sync_attr;
+	struct device_attribute sync_enable_attr;
+
+	struct list_head color_list;
+};
+
+struct led_classdev_mc_priv {
+	struct led_classdev_mc *mcled_cdev;
+
+	struct device_attribute max_brightness_attr;
+	struct device_attribute brightness_attr;
+
+	enum led_brightness max_brightness;
+	enum led_brightness brightness;
+	struct list_head list;
+
+	int color_id;
+};
+
+static ssize_t sync_store(struct device *dev,
+			  struct device_attribute *sync_attr,
+			  const char *buf, size_t size)
+{
+	struct led_classdev_mc_data *data = container_of(sync_attr,
+						      struct led_classdev_mc_data,
+						      sync_attr);
+	struct led_classdev_mc *mcled_cdev = data->mcled_cdev;
+	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
+	const struct led_multicolor_ops *ops = mcled_cdev->ops;
+	struct led_classdev_mc_priv *priv;
+	unsigned long sync_value;
+	ssize_t ret = -EINVAL;
+
+	mutex_lock(&led_cdev->led_access);
+
+	if (!mcled_cdev->sync_enabled)
+		goto unlock;
+
+	ret = kstrtoul(buf, 0, &sync_value);
+	if (ret)
+		goto unlock;
+
+	if (!sync_value) {
+		ret = size;
+		goto unlock;
+	}
+
+	list_for_each_entry(priv, &data->color_list, list) {
+		ret = ops->set_color_brightness(priv->mcled_cdev,
+						priv->color_id,
+						priv->brightness);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	ret = size;
+unlock:
+	mutex_unlock(&led_cdev->led_access);
+	return ret;
+}
+
+static ssize_t sync_enable_store(struct device *dev,
+				 struct device_attribute *sync_enable_attr,
+				 const char *buf, size_t size)
+{
+	struct led_classdev_mc_data *data = container_of(sync_enable_attr,
+						      struct led_classdev_mc_data,
+						      sync_enable_attr);
+	struct led_classdev_mc *mcled_cdev = data->mcled_cdev;
+	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
+	unsigned long sync_value;
+	ssize_t ret = -EINVAL;
+
+	mutex_lock(&led_cdev->led_access);
+
+	ret = kstrtoul(buf, 0, &sync_value);
+	if (ret)
+		goto unlock;
+
+	mcled_cdev->sync_enabled = sync_value;
+
+	ret = size;
+unlock:
+	mutex_unlock(&led_cdev->led_access);
+	return ret;
+}
+
+static ssize_t sync_enable_show(struct device *dev,
+				struct device_attribute *sync_enable_attr,
+				char *buf)
+{
+	struct led_classdev_mc_data *data = container_of(sync_enable_attr,
+						      struct led_classdev_mc_data,
+						      sync_enable_attr);
+	struct led_classdev_mc *mcled_cdev = data->mcled_cdev;
+
+	return sprintf(buf, "%d\n", mcled_cdev->sync_enabled);
+}
+
+static ssize_t brightness_store(struct device *dev,
+				struct device_attribute *brightness_attr,
+				const char *buf, size_t size)
+{
+	struct led_classdev_mc_priv *priv = container_of(brightness_attr,
+						      struct led_classdev_mc_priv,
+						      brightness_attr);
+	struct led_multicolor_ops *ops = priv->mcled_cdev->ops;
+	struct led_classdev *led_cdev = &priv->mcled_cdev->led_cdev;
+
+	int old_brightness;
+	unsigned long value;
+	ssize_t ret = -EINVAL;
+
+	mutex_lock(&led_cdev->led_access);
+
+	ret = kstrtoul(buf, 10, &value);
+	if (ret)
+		goto unlock;
+
+	if (value > priv->max_brightness) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Retain the current brightness in case writing the LED fails */
+	old_brightness = priv->brightness;
+	priv->brightness = value;
+
+	if (priv->mcled_cdev->sync_enabled) {
+		ret = size;
+		goto unlock;
+	}
+
+	ret = ops->set_color_brightness(priv->mcled_cdev,
+					priv->color_id, value);
+	if (ret < 0) {
+		priv->brightness = old_brightness;
+		goto unlock;
+	}
+
+	ret = size;
+unlock:
+	mutex_unlock(&led_cdev->led_access);
+	return ret;
+}
+
+static ssize_t brightness_show(struct device *dev,
+			       struct device_attribute *brightness_attr, char *buf)
+{
+	struct led_classdev_mc_priv *priv = container_of(brightness_attr,
+						      struct led_classdev_mc_priv,
+						      brightness_attr);
+	const struct led_multicolor_ops *ops = priv->mcled_cdev->ops;
+	int value = 0;
+
+	if (priv->mcled_cdev->sync_enabled) {
+		value = priv->brightness;
+		goto sync_enabled;
+	}
+
+	if (ops->get_color_brightness) {
+		value = ops->get_color_brightness(priv->mcled_cdev,
+						  priv->color_id);
+		priv->brightness = value;
+	} else {
+		value = priv->brightness;
+	}
+
+sync_enabled:
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t max_brightness_show(struct device *dev,
+				   struct device_attribute *max_brightness_attr,
+				   char *buf)
+{
+	struct led_classdev_mc_priv *priv = container_of(max_brightness_attr,
+						      struct led_classdev_mc_priv,
+						      max_brightness_attr);
+
+	return sprintf(buf, "%d\n", priv->max_brightness);
+}
+
+static int led_multicolor_init_color(struct led_classdev_mc_data *data,
+				     struct led_classdev_mc *mcled_cdev,
+				     int color_id)
+{
+	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
+	struct led_classdev_mc_priv *mc_priv;
+	int ret;
+
+	mc_priv = devm_kzalloc(led_cdev->dev, sizeof(*mc_priv), GFP_KERNEL);
+	if (!mc_priv)
+		return -ENOMEM;
+
+	mc_priv->color_id = color_id;
+	mc_priv->mcled_cdev = mcled_cdev;
+
+	data->led_kobj = kobject_create_and_add(led_colors[color_id],
+						data->color_kobj);
+	if (!data->led_kobj)
+		return -EINVAL;
+
+	sysfs_attr_init(&mc_priv->brightness_attr.attr);
+	mc_priv->brightness_attr.attr.name = "brightness";
+	mc_priv->brightness_attr.attr.mode = S_IRUSR | S_IWUSR;
+	mc_priv->brightness_attr.show = brightness_show;
+	mc_priv->brightness_attr.store = brightness_store;
+	ret = sysfs_create_file(data->led_kobj,
+				&mc_priv->brightness_attr.attr);
+	if (ret)
+		goto err_out;
+
+	sysfs_attr_init(&mc_priv->max_brightness_attr.attr);
+	mc_priv->max_brightness_attr.attr.name = "max_brightness";
+	mc_priv->max_brightness_attr.attr.mode = S_IRUSR;
+	mc_priv->max_brightness_attr.show = max_brightness_show;
+	ret = sysfs_create_file(data->led_kobj,
+				&mc_priv->max_brightness_attr.attr);
+	if (ret)
+		goto err_out;
+
+	mc_priv->max_brightness = LED_FULL;
+	list_add_tail(&mc_priv->list, &data->color_list);
+
+err_out:
+	return ret;
+}
+
+static int led_multicolor_init_color_dir(struct led_classdev_mc_data *data,
+					 struct led_classdev_mc *mcled_cdev)
+{
+	struct led_classdev *led_cdev = &mcled_cdev->led_cdev;
+	int ret;
+
+	data->color_kobj = kobject_create_and_add("colors",
+						  &led_cdev->dev->kobj);
+	if (!data->color_kobj)
+		return -EINVAL;
+
+	sysfs_attr_init(&data->sync_enable_attr.attr);
+	data->sync_enable_attr.attr.name = "sync_enable";
+	data->sync_enable_attr.attr.mode = S_IRUSR | S_IWUSR;
+	data->sync_enable_attr.show = sync_enable_show;
+	data->sync_enable_attr.store = sync_enable_store;
+	ret = sysfs_create_file(data->color_kobj,
+				&data->sync_enable_attr.attr);
+	if (ret)
+		goto err_out;
+
+	sysfs_attr_init(&data->sync_attr.attr);
+	data->sync_attr.attr.name = "sync";
+	data->sync_attr.attr.mode = S_IWUSR;
+	data->sync_attr.store = sync_store;
+	ret = sysfs_create_file(data->color_kobj,
+				&data->sync_attr.attr);
+	if (ret)
+		goto err_out;
+
+	data->mcled_cdev = mcled_cdev;
+
+err_out:
+	return ret;
+}
+
+int led_classdev_multicolor_register(struct device *parent,
+				     struct led_classdev_mc *mcled_cdev)
+{
+	struct led_classdev *led_cdev;
+	struct led_multicolor_ops *ops;
+	struct led_classdev_mc_data *data;
+	int ret;
+	int i;
+
+	if (!mcled_cdev)
+		return -EINVAL;
+
+	ops = mcled_cdev->ops;
+	if (!ops || !ops->set_color_brightness)
+		return -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	led_cdev = &mcled_cdev->led_cdev;
+
+	INIT_LIST_HEAD(&data->color_list);
+
+	/* Register led class device */
+	ret = led_classdev_register(parent, led_cdev);
+	if (ret)
+		return ret;
+
+	ret = led_multicolor_init_color_dir(data, mcled_cdev);
+	if (ret)
+		return ret;
+
+
+	/* Select the sysfs attributes to be created for the device */
+	for (i = 0; i < mcled_cdev->num_of_leds; i++) {
+		ret = led_multicolor_init_color(data, mcled_cdev,
+						mcled_cdev->available_colors[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(led_classdev_multicolor_register);
+
+void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev)
+{
+	if (!mcled_cdev)
+		return;
+
+	led_classdev_unregister(&mcled_cdev->led_cdev);
+}
+EXPORT_SYMBOL_GPL(led_classdev_multicolor_unregister);
+
+static void devm_led_classdev_multicolor_release(struct device *dev, void *res)
+{
+	led_classdev_multicolor_unregister(*(struct led_classdev_mc **)res);
+}
+
+/**
+ * devm_of_led_classdev_register - resource managed led_classdev_register()
+ *
+ * @parent: parent of LED device
+ * @led_cdev: the led_classdev structure for this device.
+ */
+int devm_led_classdev_multicolor_register(struct device *parent,
+					  struct led_classdev_mc *mcled_cdev)
+{
+	struct led_classdev_mc **dr;
+	int ret;
+
+	dr = devres_alloc(devm_led_classdev_multicolor_release,
+			  sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = led_classdev_multicolor_register(parent, mcled_cdev);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	*dr = mcled_cdev;
+	devres_add(parent, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_led_classdev_multicolor_register);
+
+static int devm_led_classdev_multicolor_match(struct device *dev,
+					      void *res, void *data)
+{
+	struct mcled_cdev **p = res;
+
+	if (WARN_ON(!p || !*p))
+		return 0;
+
+	return *p == data;
+}
+
+/**
+ * devm_led_classdev_multicolor_unregister() - resource managed
+ *					led_classdev_multicolor_unregister()
+ * @parent: The device to unregister.
+ * @mcled_cdev: the led_classdev_mc structure for this device.
+ */
+void devm_led_classdev_multicolor_unregister(struct device *dev,
+				  struct led_classdev_mc *mcled_cdev)
+{
+	WARN_ON(devres_release(dev,
+			       devm_led_classdev_multicolor_release,
+			       devm_led_classdev_multicolor_match, mcled_cdev));
+}
+EXPORT_SYMBOL_GPL(devm_led_classdev_multicolor_unregister);
+
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_DESCRIPTION("Multi Color LED class interface");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/led-class-multicolor.h b/include/linux/led-class-multicolor.h
new file mode 100644
index 000000000000..8ca33ffe4493
--- /dev/null
+++ b/include/linux/led-class-multicolor.h
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* LED Multicolor class interface
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __LINUX_MULTICOLOR_LEDS_H_INCLUDED
+#define __LINUX_MULTICOLOR_LEDS_H_INCLUDED
+
+#include <linux/leds.h>
+#include <dt-bindings/leds/common.h>
+
+struct led_classdev_mc;
+
+struct led_multicolor_ops {
+	/* Set brightness for a specific color id */
+	int (*set_color_brightness)(struct led_classdev_mc *mcled_cdev,
+				    int color_id, int value);
+	/* Read current color setting */
+	int (*get_color_brightness)(struct led_classdev_mc *mcled_cdev,
+				    int color_id);
+};
+
+struct led_classdev_mc {
+	/* led class device */
+	struct led_classdev led_cdev;
+
+	/* multicolor led specific ops */
+	struct led_multicolor_ops *ops;
+
+	u32 available_colors[LED_COLOR_ID_MAX];
+	int num_of_leds;
+
+	bool sync_enabled;
+};
+
+static inline struct led_classdev_mc *lcdev_to_mccdev(
+						struct led_classdev *lcdev)
+{
+	return container_of(lcdev, struct led_classdev_mc, led_cdev);
+}
+
+/**
+ * led_classdev_multicolor_register - register a new object of led_classdev
+ *				      class with support for multicolor LEDs
+ * @parent: the multicolor LED to register
+ * @mcled_cdev: the led_classdev_mc structure for this device
+ *
+ * Returns: 0 on success or negative error value on failure
+ */
+extern int led_classdev_multicolor_register(struct device *parent,
+					    struct led_classdev_mc *mcled_cdev);
+
+/**
+ * led_classdev_multicolor_unregister - unregisters an object of led_classdev
+ *					class with support for multicolor LEDs
+ * @mcled_cdev: the multicolor LED to unregister
+ *
+ * Unregister a previously registered via led_classdev_multicolor_register
+ * object
+ */
+extern void led_classdev_multicolor_unregister(struct led_classdev_mc *mcled_cdev);
+
+extern int devm_led_classdev_multicolor_register(struct device *parent,
+						 struct led_classdev_mc *mcled_cdev);
+
+extern void devm_led_classdev_multicolor_unregister(struct device *parent,
+						    struct led_classdev_mc *mcled_cdev);
+
+#endif	/* __LINUX_MULTICOLOR_LEDS_H_INCLUDED */
-- 
2.19.0

