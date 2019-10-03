Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C83C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A4F21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RG8hQxwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJCJ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:29:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55565 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfJCJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:29:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so1672315wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzUpm1jbLAGSvzG2CvK19o5RQyJfQpMupBUkWx+KPtM=;
        b=RG8hQxwSzz9y7zk5TifCAyzEbxYauV8wc2a18G3ltpXYqqFUchl8mZHI4OjpyINMm3
         Ccu2ZhTfiErBVe/vY8cTy49ULl/ZQ/FTJf1UEwWbVk89o4Qc2oAe5mnKMaTOGi/Xc362
         jxtSZ76JSIjDvKFMC+btWuiYNcDXbrlYV6EbszVJ4/GjKZmmPhff4QcRGxI/3UlTLP2a
         RJJDr3LLt7qwunapEDdfi4PzkOdNVbg3t2fOLCsbJKD8Tzyle7BDotR30TO70AkPwarz
         se3FabLnV1rRdHgs5oxyM+jLLD19JePl9bwHGlnii7KOiG97Zw8fVBw6Qc5XZ9k6bkoA
         GB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzUpm1jbLAGSvzG2CvK19o5RQyJfQpMupBUkWx+KPtM=;
        b=MjJVN0ZLwX78pUMfUAaYqy4Huv1P+/GxpgO7dft/ZqK1Yi3vpTryVdHIslV+06oHvM
         0UG9RdBIgEK1qkrnnZkmF4xyiWUJKC84hXZwwCQvgyE8+rb06hCt4255UCXODuWgxw4U
         Z8+8W0q/XCxrvv6xrKFmxqsKJURFQpCFqbhHESBLKH8nsjkkuSJAFoRywj9poFRrnWKF
         tB3QWHNvrF6dPd70M11CHvt9KsGFFoDEmfpxvEyK1tjn/fM+Tct5NbQaARJb+64+BaGl
         h2ouLF/GxVnNeZA2TVssti0FOXB7sePdeZ5m/vUz4Ct0RypnmxHQlxBDlm8oSUiHpYKv
         SCuw==
X-Gm-Message-State: APjAAAU+gzm8OWKGRJUAdTOtOSEtIfo3PYNzE73Yqt9zk1o2Sh7c1QKH
        BI1oSzwLVWJJoaX0Yn0IxWojJA==
X-Google-Smtp-Source: APXvYqwExJN5oefvYYhOBWuRtTBNDjG2/AtR/Kj6eYZnivXEI62L9Kc7Qtlgit/pFO1s2xbdqfumOw==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190mr6609801wmr.143.1570094963472;
        Thu, 03 Oct 2019 02:29:23 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id u83sm10554259wme.0.2019.10.03.02.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 02:29:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/2] drivers: move the early platform device support to arch/sh
Date:   Thu,  3 Oct 2019 11:29:12 +0200
Message-Id: <20191003092913.10731-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003092913.10731-1-brgl@bgdev.pl>
References: <20191003092913.10731-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

SuperH is the only user of the current implementation of early platform
device support. We want to introduce a more robust approach to early
probing. As the first step - move all the current early platform code
to arch/sh.

In order not to export internal drivers/base functions to arch code for
this temporary solution - copy the two needed routines for driver
matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.

Also: call early_platform_cleanup() from subsys_initcall() so that it's
called after all early devices are probed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 347 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   1 +
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   1 +
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   1 +
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   1 +
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   1 +
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   1 +
 arch/sh/kernel/setup.c                 |   1 +
 arch/sh/kernel/time.c                  |   1 +
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |   7 +
 drivers/clocksource/sh_mtu2.c          |   7 +
 drivers/clocksource/sh_tmu.c           |   8 +
 drivers/tty/serial/sh-sci.c            |   7 +-
 include/linux/platform_device.h        |  64 +----
 40 files changed, 480 insertions(+), 342 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index 3e93b434e604..56b0acace6e7 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux SuperH-specific device drivers.
 #
 
-obj-y		+= dma/
+obj-y		+= dma/ platform_early.o
 
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
new file mode 100644
index 000000000000..3dfe9f3541bb
--- /dev/null
+++ b/arch/sh/drivers/platform_early.c
@@ -0,0 +1,347 @@
+// SPDX--License-Identifier: GPL-2.0
+
+#include <asm/platform_early.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+
+static __initdata LIST_HEAD(early_platform_driver_list);
+static __initdata LIST_HEAD(early_platform_device_list);
+
+static const struct platform_device_id *
+platform_match_id(const struct platform_device_id *id,
+		  struct platform_device *pdev)
+{
+	while (id->name[0]) {
+		if (strcmp(pdev->name, id->name) == 0) {
+			pdev->id_entry = id;
+			return id;
+		}
+		id++;
+	}
+	return NULL;
+}
+
+static int platform_match(struct device *dev, struct device_driver *drv)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_driver *pdrv = to_platform_driver(drv);
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (pdev->driver_override)
+		return !strcmp(pdev->driver_override, drv->name);
+
+	/* Then try to match against the id table */
+	if (pdrv->id_table)
+		return platform_match_id(pdrv->id_table, pdev) != NULL;
+
+	/* fall-back to driver name match */
+	return (strcmp(pdev->name, drv->name) == 0);
+}
+
+#ifdef CONFIG_PM
+static void device_pm_init_common(struct device *dev)
+{
+	if (!dev->power.early_init) {
+		spin_lock_init(&dev->power.lock);
+		dev->power.qos = NULL;
+		dev->power.early_init = true;
+	}
+}
+
+static void pm_runtime_early_init(struct device *dev)
+{
+	dev->power.disable_depth = 1;
+	device_pm_init_common(dev);
+}
+#else
+static void pm_runtime_early_init(struct device *dev) {}
+#endif
+
+/**
+ * early_platform_driver_register - register early platform driver
+ * @epdrv: early_platform driver structure
+ * @buf: string passed from early_param()
+ *
+ * Helper function for early_platform_init() / early_platform_init_buffer()
+ */
+int __init early_platform_driver_register(struct early_platform_driver *epdrv,
+					  char *buf)
+{
+	char *tmp;
+	int n;
+
+	/* Simply add the driver to the end of the global list.
+	 * Drivers will by default be put on the list in compiled-in order.
+	 */
+	if (!epdrv->list.next) {
+		INIT_LIST_HEAD(&epdrv->list);
+		list_add_tail(&epdrv->list, &early_platform_driver_list);
+	}
+
+	/* If the user has specified device then make sure the driver
+	 * gets prioritized. The driver of the last device specified on
+	 * command line will be put first on the list.
+	 */
+	n = strlen(epdrv->pdrv->driver.name);
+	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
+		list_move(&epdrv->list, &early_platform_driver_list);
+
+		/* Allow passing parameters after device name */
+		if (buf[n] == '\0' || buf[n] == ',')
+			epdrv->requested_id = -1;
+		else {
+			epdrv->requested_id = simple_strtoul(&buf[n + 1],
+							     &tmp, 10);
+
+			if (buf[n] != '.' || (tmp == &buf[n + 1])) {
+				epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
+				n = 0;
+			} else
+				n += strcspn(&buf[n + 1], ",") + 1;
+		}
+
+		if (buf[n] == ',')
+			n++;
+
+		if (epdrv->bufsize) {
+			memcpy(epdrv->buffer, &buf[n],
+			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
+			epdrv->buffer[epdrv->bufsize - 1] = '\0';
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * early_platform_add_devices - adds a number of early platform devices
+ * @devs: array of early platform devices to add
+ * @num: number of early platform devices in array
+ *
+ * Used by early architecture code to register early platform devices and
+ * their platform data.
+ */
+void __init early_platform_add_devices(struct platform_device **devs, int num)
+{
+	struct device *dev;
+	int i;
+
+	/* simply add the devices to list */
+	for (i = 0; i < num; i++) {
+		dev = &devs[i]->dev;
+
+		if (!dev->devres_head.next) {
+			pm_runtime_early_init(dev);
+			INIT_LIST_HEAD(&dev->devres_head);
+			list_add_tail(&dev->devres_head,
+				      &early_platform_device_list);
+		}
+	}
+}
+
+/**
+ * early_platform_driver_register_all - register early platform drivers
+ * @class_str: string to identify early platform driver class
+ *
+ * Used by architecture code to register all early platform drivers
+ * for a certain class. If omitted then only early platform drivers
+ * with matching kernel command line class parameters will be registered.
+ */
+void __init early_platform_driver_register_all(char *class_str)
+{
+	/* The "class_str" parameter may or may not be present on the kernel
+	 * command line. If it is present then there may be more than one
+	 * matching parameter.
+	 *
+	 * Since we register our early platform drivers using early_param()
+	 * we need to make sure that they also get registered in the case
+	 * when the parameter is missing from the kernel command line.
+	 *
+	 * We use parse_early_options() to make sure the early_param() gets
+	 * called at least once. The early_param() may be called more than
+	 * once since the name of the preferred device may be specified on
+	 * the kernel command line. early_platform_driver_register() handles
+	 * this case for us.
+	 */
+	parse_early_options(class_str);
+}
+
+/**
+ * early_platform_match - find early platform device matching driver
+ * @epdrv: early platform driver structure
+ * @id: id to match against
+ */
+static struct platform_device * __init
+early_platform_match(struct early_platform_driver *epdrv, int id)
+{
+	struct platform_device *pd;
+
+	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
+			if (pd->id == id)
+				return pd;
+
+	return NULL;
+}
+
+/**
+ * early_platform_left - check if early platform driver has matching devices
+ * @epdrv: early platform driver structure
+ * @id: return true if id or above exists
+ */
+static int __init early_platform_left(struct early_platform_driver *epdrv,
+				       int id)
+{
+	struct platform_device *pd;
+
+	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
+		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
+			if (pd->id >= id)
+				return 1;
+
+	return 0;
+}
+
+/**
+ * early_platform_driver_probe_id - probe drivers matching class_str and id
+ * @class_str: string to identify early platform driver class
+ * @id: id to match against
+ * @nr_probe: number of platform devices to successfully probe before exiting
+ */
+static int __init early_platform_driver_probe_id(char *class_str,
+						 int id,
+						 int nr_probe)
+{
+	struct early_platform_driver *epdrv;
+	struct platform_device *match;
+	int match_id;
+	int n = 0;
+	int left = 0;
+
+	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
+		/* only use drivers matching our class_str */
+		if (strcmp(class_str, epdrv->class_str))
+			continue;
+
+		if (id == -2) {
+			match_id = epdrv->requested_id;
+			left = 1;
+
+		} else {
+			match_id = id;
+			left += early_platform_left(epdrv, id);
+
+			/* skip requested id */
+			switch (epdrv->requested_id) {
+			case EARLY_PLATFORM_ID_ERROR:
+			case EARLY_PLATFORM_ID_UNSET:
+				break;
+			default:
+				if (epdrv->requested_id == id)
+					match_id = EARLY_PLATFORM_ID_UNSET;
+			}
+		}
+
+		switch (match_id) {
+		case EARLY_PLATFORM_ID_ERROR:
+			pr_warn("%s: unable to parse %s parameter\n",
+				class_str, epdrv->pdrv->driver.name);
+			/* fall-through */
+		case EARLY_PLATFORM_ID_UNSET:
+			match = NULL;
+			break;
+		default:
+			match = early_platform_match(epdrv, match_id);
+		}
+
+		if (match) {
+			/*
+			 * Set up a sensible init_name to enable
+			 * dev_name() and others to be used before the
+			 * rest of the driver core is initialized.
+			 */
+			if (!match->dev.init_name && slab_is_available()) {
+				if (match->id != -1)
+					match->dev.init_name =
+						kasprintf(GFP_KERNEL, "%s.%d",
+							  match->name,
+							  match->id);
+				else
+					match->dev.init_name =
+						kasprintf(GFP_KERNEL, "%s",
+							  match->name);
+
+				if (!match->dev.init_name)
+					return -ENOMEM;
+			}
+
+			if (epdrv->pdrv->probe(match))
+				pr_warn("%s: unable to probe %s early.\n",
+					class_str, match->name);
+			else
+				n++;
+		}
+
+		if (n >= nr_probe)
+			break;
+	}
+
+	if (left)
+		return n;
+	else
+		return -ENODEV;
+}
+
+/**
+ * early_platform_driver_probe - probe a class of registered drivers
+ * @class_str: string to identify early platform driver class
+ * @nr_probe: number of platform devices to successfully probe before exiting
+ * @user_only: only probe user specified early platform devices
+ *
+ * Used by architecture code to probe registered early platform drivers
+ * within a certain class. For probe to happen a registered early platform
+ * device matching a registered early platform driver is needed.
+ */
+int __init early_platform_driver_probe(char *class_str,
+				       int nr_probe,
+				       int user_only)
+{
+	int k, n, i;
+
+	n = 0;
+	for (i = -2; n < nr_probe; i++) {
+		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
+
+		if (k < 0)
+			break;
+
+		n += k;
+
+		if (user_only)
+			break;
+	}
+
+	return n;
+}
+
+/**
+ * early_platform_cleanup - clean up early platform code
+ */
+static int __init early_platform_cleanup(void)
+{
+	struct platform_device *pd, *pd2;
+
+	/* clean up the devres list used to chain devices */
+	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
+				 dev.devres_head) {
+		list_del(&pd->dev.devres_head);
+		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
+	}
+
+	return 0;
+}
+/*
+ * This must happen once after all early devices are probed but before probing
+ * real platform devices.
+ */
+subsys_initcall(early_platform_cleanup);
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
new file mode 100644
index 000000000000..4590ab757d5f
--- /dev/null
+++ b/arch/sh/include/asm/platform_early.h
@@ -0,0 +1,61 @@
+/* SPDX--License-Identifier: GPL-2.0 */
+
+#ifndef __PLATFORM_EARLY__
+#define __PLATFORM_EARLY__
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+struct early_platform_driver {
+	const char *class_str;
+	struct platform_driver *pdrv;
+	struct list_head list;
+	int requested_id;
+	char *buffer;
+	int bufsize;
+};
+
+#define EARLY_PLATFORM_ID_UNSET -2
+#define EARLY_PLATFORM_ID_ERROR -3
+
+extern int early_platform_driver_register(struct early_platform_driver *epdrv,
+					  char *buf);
+extern void early_platform_add_devices(struct platform_device **devs, int num);
+
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return !pdev->dev.driver;
+}
+
+extern void early_platform_driver_register_all(char *class_str);
+extern int early_platform_driver_probe(char *class_str,
+				       int nr_probe, int user_only);
+
+#define early_platform_init(class_string, platdrv)		\
+	early_platform_init_buffer(class_string, platdrv, NULL, 0)
+
+#ifndef MODULE
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static __initdata struct early_platform_driver early_driver = {		\
+	.class_str = class_string,					\
+	.buffer = buf,							\
+	.bufsize = bufsiz,						\
+	.pdrv = platdrv,						\
+	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
+};									\
+static int __init early_platform_driver_setup_func(char *buffer)	\
+{									\
+	return early_platform_driver_register(&early_driver, buffer);	\
+}									\
+early_param(class_string, early_platform_driver_setup_func)
+#else /* MODULE */
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
+static inline char *early_platform_driver_setup_func(void)		\
+{									\
+	return bufsiz ? buf : NULL;					\
+}
+#endif /* MODULE */
+
+#endif /* __PLATFORM_EARLY__ */
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
index f5b6841ef7e1..27d459e8a598 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -12,6 +12,7 @@
 #include <linux/sh_eth.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
index 52350ad0b0a2..8a19c5754978 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -9,6 +9,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
index b51ed761ae08..d975e4d404bd 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -11,6 +11,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
index 89b3e49fc250..318b8cd8d5b7 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -10,6 +10,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
index 36ff3a3139da..8e6fae60074a 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -11,6 +11,7 @@
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
index d199618d877c..2d95c9b38330 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -11,6 +11,7 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
index 9095c960b455..ef4ff76cbe9e 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -12,6 +12,7 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh3.c b/arch/sh/kernel/cpu/sh3/setup-sh3.c
index 8058c01cf09d..cf2a3f09fee4 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh3.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 /* All SH3 devices are equipped with IRQ0->5 (except sh7708) */
 
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
index e19d1ce7b6ad..9b34d1f4e797 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -14,6 +14,7 @@
 #include <linux/sh_intc.h>
 #include <asm/rtc.h>
 #include <cpu/serial.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 5c5144bee6bc..39f09504bd96 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -18,6 +18,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <cpu/serial.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
index 4776e2495738..c006c8fcfa0f 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -13,6 +13,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
index 1d4c34e7b7db..cf2eec9f6abd 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -19,6 +19,7 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 #include <cpu/serial.h>
 
 static struct resource rtc_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
index a40ef35d101a..2480ce4a3b1e 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -12,6 +12,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index b37bda66a532..4592d660b942 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -13,6 +13,7 @@
 #include <linux/sh_intc.h>
 #include <linux/serial_sci.h>
 #include <generated/machtypes.h>
+#include <asm/platform_early.h>
 
 static struct resource rtc_resources[] = {
 	[0] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 86845da85997..e64eb96e3589 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -11,6 +11,7 @@
 #include <linux/sh_intc.h>
 #include <linux/serial_sci.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 enum {
 	UNUSED = 0,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index a15e25690b5f..0fa56128bdca 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -12,6 +12,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/clock.h>
+#include <asm/platform_early.h>
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 7bd2776441ba..9f2f75285ec3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -15,6 +15,7 @@
 #include <linux/sh_intc.h>
 #include <linux/usb/r8a66597.h>
 #include <asm/clock.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 1ce65f88f060..8e5eaac789a7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -18,6 +18,7 @@
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 #include <asm/siu.h>
+#include <asm/platform_early.h>
 
 #include <cpu/dma-register.h>
 #include <cpu/sh7722.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index edb649950662..b4b54aa0c267 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 #include <cpu/sh7723.h>
 
 /* Serial */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 3e9825031d3d..ec237ab112cf 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -24,6 +24,7 @@
 #include <asm/suspend.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 #include <cpu/dma-register.h>
 #include <cpu/sh7724.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 06a91569697a..7ea9a8b43955 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/irq.h>
+#include <asm/platform_early.h>
 #include <cpu/sh7734.h>
 
 /* SCIF */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 2501ce656511..922d9886be18 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -19,6 +19,7 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 419c5efe4a17..8725d4751baf 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 5fb4cf9b58c6..035a0d4f2a2e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -11,6 +11,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/io.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_TOIE,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index ab7d6b715865..983be87cb7be 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -13,6 +13,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <cpu/dma-register.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index a438da47285d..bb0cb710c16e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -14,6 +14,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 #include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index d894165a0ef6..b5d94366eed3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -23,6 +23,7 @@
 #include <linux/usb/ohci_pdriver.h>
 #include <cpu/dma-register.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_REIE | SCSCR_CKE1,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index 14aa4552bc45..e82398d80b74 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -14,6 +14,7 @@
 #include <linux/sh_intc.h>
 #include <cpu/shx3.h>
 #include <asm/mmzone.h>
+#include <asm/platform_early.h>
 
 /*
  * This intentionally only registers SCIF ports 0, 1, and 3. SCIF 2
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/setup-sh5.c
index 41c1673afc0b..584a6aeeca26 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
 #include <asm/addrspace.h>
+#include <asm/platform_early.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.flags		= UPF_IOREMAP,
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 2c0e0f37a318..e535507851e1 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -44,6 +44,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mmzone.h>
 #include <asm/sparsemem.h>
+#include <asm/platform_early.h>
 
 /*
  * Initialize loops_per_jiffy as 10000000 (1000MIPS).
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index e16b2cd269a3..8ad9fd5c4ff6 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -18,6 +18,7 @@
 #include <linux/rtc.h>
 #include <asm/clock.h>
 #include <asm/rtc.h>
+#include <asm/platform_early.h>
 
 static void __init sh_late_time_init(void)
 {
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..be1e67ee3af6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1264,8 +1264,6 @@ int __init platform_bus_init(void)
 {
 	int error;
 
-	early_platform_cleanup();
-
 	error = device_register(&platform_bus);
 	if (error) {
 		put_device(&platform_bus);
@@ -1277,289 +1275,3 @@ int __init platform_bus_init(void)
 	of_platform_register_reconfig_notifier();
 	return error;
 }
-
-static __initdata LIST_HEAD(early_platform_driver_list);
-static __initdata LIST_HEAD(early_platform_device_list);
-
-/**
- * early_platform_driver_register - register early platform driver
- * @epdrv: early_platform driver structure
- * @buf: string passed from early_param()
- *
- * Helper function for early_platform_init() / early_platform_init_buffer()
- */
-int __init early_platform_driver_register(struct early_platform_driver *epdrv,
-					  char *buf)
-{
-	char *tmp;
-	int n;
-
-	/* Simply add the driver to the end of the global list.
-	 * Drivers will by default be put on the list in compiled-in order.
-	 */
-	if (!epdrv->list.next) {
-		INIT_LIST_HEAD(&epdrv->list);
-		list_add_tail(&epdrv->list, &early_platform_driver_list);
-	}
-
-	/* If the user has specified device then make sure the driver
-	 * gets prioritized. The driver of the last device specified on
-	 * command line will be put first on the list.
-	 */
-	n = strlen(epdrv->pdrv->driver.name);
-	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
-		list_move(&epdrv->list, &early_platform_driver_list);
-
-		/* Allow passing parameters after device name */
-		if (buf[n] == '\0' || buf[n] == ',')
-			epdrv->requested_id = -1;
-		else {
-			epdrv->requested_id = simple_strtoul(&buf[n + 1],
-							     &tmp, 10);
-
-			if (buf[n] != '.' || (tmp == &buf[n + 1])) {
-				epdrv->requested_id = EARLY_PLATFORM_ID_ERROR;
-				n = 0;
-			} else
-				n += strcspn(&buf[n + 1], ",") + 1;
-		}
-
-		if (buf[n] == ',')
-			n++;
-
-		if (epdrv->bufsize) {
-			memcpy(epdrv->buffer, &buf[n],
-			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
-			epdrv->buffer[epdrv->bufsize - 1] = '\0';
-		}
-	}
-
-	return 0;
-}
-
-/**
- * early_platform_add_devices - adds a number of early platform devices
- * @devs: array of early platform devices to add
- * @num: number of early platform devices in array
- *
- * Used by early architecture code to register early platform devices and
- * their platform data.
- */
-void __init early_platform_add_devices(struct platform_device **devs, int num)
-{
-	struct device *dev;
-	int i;
-
-	/* simply add the devices to list */
-	for (i = 0; i < num; i++) {
-		dev = &devs[i]->dev;
-
-		if (!dev->devres_head.next) {
-			pm_runtime_early_init(dev);
-			INIT_LIST_HEAD(&dev->devres_head);
-			list_add_tail(&dev->devres_head,
-				      &early_platform_device_list);
-		}
-	}
-}
-
-/**
- * early_platform_driver_register_all - register early platform drivers
- * @class_str: string to identify early platform driver class
- *
- * Used by architecture code to register all early platform drivers
- * for a certain class. If omitted then only early platform drivers
- * with matching kernel command line class parameters will be registered.
- */
-void __init early_platform_driver_register_all(char *class_str)
-{
-	/* The "class_str" parameter may or may not be present on the kernel
-	 * command line. If it is present then there may be more than one
-	 * matching parameter.
-	 *
-	 * Since we register our early platform drivers using early_param()
-	 * we need to make sure that they also get registered in the case
-	 * when the parameter is missing from the kernel command line.
-	 *
-	 * We use parse_early_options() to make sure the early_param() gets
-	 * called at least once. The early_param() may be called more than
-	 * once since the name of the preferred device may be specified on
-	 * the kernel command line. early_platform_driver_register() handles
-	 * this case for us.
-	 */
-	parse_early_options(class_str);
-}
-
-/**
- * early_platform_match - find early platform device matching driver
- * @epdrv: early platform driver structure
- * @id: id to match against
- */
-static struct platform_device * __init
-early_platform_match(struct early_platform_driver *epdrv, int id)
-{
-	struct platform_device *pd;
-
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
-		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
-			if (pd->id == id)
-				return pd;
-
-	return NULL;
-}
-
-/**
- * early_platform_left - check if early platform driver has matching devices
- * @epdrv: early platform driver structure
- * @id: return true if id or above exists
- */
-static int __init early_platform_left(struct early_platform_driver *epdrv,
-				       int id)
-{
-	struct platform_device *pd;
-
-	list_for_each_entry(pd, &early_platform_device_list, dev.devres_head)
-		if (platform_match(&pd->dev, &epdrv->pdrv->driver))
-			if (pd->id >= id)
-				return 1;
-
-	return 0;
-}
-
-/**
- * early_platform_driver_probe_id - probe drivers matching class_str and id
- * @class_str: string to identify early platform driver class
- * @id: id to match against
- * @nr_probe: number of platform devices to successfully probe before exiting
- */
-static int __init early_platform_driver_probe_id(char *class_str,
-						 int id,
-						 int nr_probe)
-{
-	struct early_platform_driver *epdrv;
-	struct platform_device *match;
-	int match_id;
-	int n = 0;
-	int left = 0;
-
-	list_for_each_entry(epdrv, &early_platform_driver_list, list) {
-		/* only use drivers matching our class_str */
-		if (strcmp(class_str, epdrv->class_str))
-			continue;
-
-		if (id == -2) {
-			match_id = epdrv->requested_id;
-			left = 1;
-
-		} else {
-			match_id = id;
-			left += early_platform_left(epdrv, id);
-
-			/* skip requested id */
-			switch (epdrv->requested_id) {
-			case EARLY_PLATFORM_ID_ERROR:
-			case EARLY_PLATFORM_ID_UNSET:
-				break;
-			default:
-				if (epdrv->requested_id == id)
-					match_id = EARLY_PLATFORM_ID_UNSET;
-			}
-		}
-
-		switch (match_id) {
-		case EARLY_PLATFORM_ID_ERROR:
-			pr_warn("%s: unable to parse %s parameter\n",
-				class_str, epdrv->pdrv->driver.name);
-			/* fall-through */
-		case EARLY_PLATFORM_ID_UNSET:
-			match = NULL;
-			break;
-		default:
-			match = early_platform_match(epdrv, match_id);
-		}
-
-		if (match) {
-			/*
-			 * Set up a sensible init_name to enable
-			 * dev_name() and others to be used before the
-			 * rest of the driver core is initialized.
-			 */
-			if (!match->dev.init_name && slab_is_available()) {
-				if (match->id != -1)
-					match->dev.init_name =
-						kasprintf(GFP_KERNEL, "%s.%d",
-							  match->name,
-							  match->id);
-				else
-					match->dev.init_name =
-						kasprintf(GFP_KERNEL, "%s",
-							  match->name);
-
-				if (!match->dev.init_name)
-					return -ENOMEM;
-			}
-
-			if (epdrv->pdrv->probe(match))
-				pr_warn("%s: unable to probe %s early.\n",
-					class_str, match->name);
-			else
-				n++;
-		}
-
-		if (n >= nr_probe)
-			break;
-	}
-
-	if (left)
-		return n;
-	else
-		return -ENODEV;
-}
-
-/**
- * early_platform_driver_probe - probe a class of registered drivers
- * @class_str: string to identify early platform driver class
- * @nr_probe: number of platform devices to successfully probe before exiting
- * @user_only: only probe user specified early platform devices
- *
- * Used by architecture code to probe registered early platform drivers
- * within a certain class. For probe to happen a registered early platform
- * device matching a registered early platform driver is needed.
- */
-int __init early_platform_driver_probe(char *class_str,
-				       int nr_probe,
-				       int user_only)
-{
-	int k, n, i;
-
-	n = 0;
-	for (i = -2; n < nr_probe; i++) {
-		k = early_platform_driver_probe_id(class_str, i, nr_probe - n);
-
-		if (k < 0)
-			break;
-
-		n += k;
-
-		if (user_only)
-			break;
-	}
-
-	return n;
-}
-
-/**
- * early_platform_cleanup - clean up early platform code
- */
-void __init early_platform_cleanup(void)
-{
-	struct platform_device *pd, *pd2;
-
-	/* clean up the devres list used to chain devices */
-	list_for_each_entry_safe(pd, pd2, &early_platform_device_list,
-				 dev.devres_head) {
-		list_del(&pd->dev.devres_head);
-		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
-	}
-}
-
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index ef773db080e9..3a185485300e 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -25,6 +25,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 struct sh_cmt_device;
 
 /*
@@ -1109,7 +1113,10 @@ static void __exit sh_cmt_exit(void)
 	platform_driver_unregister(&sh_cmt_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_cmt_device_driver);
+#endif
+
 subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 354b27d14a19..d581060d33a2 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -23,6 +23,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 struct sh_mtu2_device;
 
 struct sh_mtu2_channel {
@@ -511,7 +515,10 @@ static void __exit sh_mtu2_exit(void)
 	platform_driver_unregister(&sh_mtu2_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_mtu2_device_driver);
+#endif
+
 subsys_initcall(sh_mtu2_init);
 module_exit(sh_mtu2_exit);
 
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 8c4f3753b36e..50e30ead050e 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -24,6 +24,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_SUPERH
+#include <asm/platform_early.h>
+#endif
+
 enum sh_tmu_model {
 	SH_TMU,
 	SH_TMU_SH3,
@@ -615,6 +619,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
+
 	if (is_early_platform_device(pdev))
 		return 0;
 
@@ -665,7 +670,10 @@ static void __exit sh_tmu_exit(void)
 	platform_driver_unregister(&sh_tmu_device_driver);
 }
 
+#ifdef CONFIG_SUPERH
 early_platform_init("earlytimer", &sh_tmu_device_driver);
+#endif
+
 subsys_initcall(sh_tmu_init);
 module_exit(sh_tmu_exit);
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4e754a4850e6..2a645fd7f07b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -54,6 +54,7 @@
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
+#include <asm/platform_early.h>
 #endif
 
 #include "serial_mctrl_gpio.h"
@@ -3086,6 +3087,7 @@ static struct console serial_console = {
 	.data		= &sci_uart_driver,
 };
 
+#ifdef CONFIG_SUPERH
 static struct console early_serial_console = {
 	.name           = "early_ttySC",
 	.write          = serial_console_write,
@@ -3114,6 +3116,7 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 	register_console(&early_serial_console);
 	return 0;
 }
+#endif
 
 #define SCI_CONSOLE	(&serial_console)
 
@@ -3314,8 +3317,10 @@ static int sci_probe(struct platform_device *dev)
 	 * the special early probe. We don't have sufficient device state
 	 * to make it beyond this yet.
 	 */
+#ifdef CONFIG_SUPERH
 	if (is_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
+#endif
 
 	if (dev->dev.of_node) {
 		p = sci_parse_dt(dev, &dev_id);
@@ -3410,7 +3415,7 @@ static void __exit sci_exit(void)
 		uart_unregister_driver(&sci_uart_driver);
 }
 
-#ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
+#if defined(CONFIG_SUPERH) && defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
 early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1b5cec067533..85aa28a041a9 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -292,58 +292,6 @@ void platform_unregister_drivers(struct platform_driver * const *drivers,
 #define platform_register_drivers(drivers, count) \
 	__platform_register_drivers(drivers, count, THIS_MODULE)
 
-/* early platform driver interface */
-struct early_platform_driver {
-	const char *class_str;
-	struct platform_driver *pdrv;
-	struct list_head list;
-	int requested_id;
-	char *buffer;
-	int bufsize;
-};
-
-#define EARLY_PLATFORM_ID_UNSET -2
-#define EARLY_PLATFORM_ID_ERROR -3
-
-extern int early_platform_driver_register(struct early_platform_driver *epdrv,
-					  char *buf);
-extern void early_platform_add_devices(struct platform_device **devs, int num);
-
-static inline int is_early_platform_device(struct platform_device *pdev)
-{
-	return !pdev->dev.driver;
-}
-
-extern void early_platform_driver_register_all(char *class_str);
-extern int early_platform_driver_probe(char *class_str,
-				       int nr_probe, int user_only);
-extern void early_platform_cleanup(void);
-
-#define early_platform_init(class_string, platdrv)		\
-	early_platform_init_buffer(class_string, platdrv, NULL, 0)
-
-#ifndef MODULE
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static __initdata struct early_platform_driver early_driver = {		\
-	.class_str = class_string,					\
-	.buffer = buf,							\
-	.bufsize = bufsiz,						\
-	.pdrv = platdrv,						\
-	.requested_id = EARLY_PLATFORM_ID_UNSET,			\
-};									\
-static int __init early_platform_driver_setup_func(char *buffer)	\
-{									\
-	return early_platform_driver_register(&early_driver, buffer);	\
-}									\
-early_param(class_string, early_platform_driver_setup_func)
-#else /* MODULE */
-#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)	\
-static inline char *early_platform_driver_setup_func(void)		\
-{									\
-	return bufsiz ? buf : NULL;					\
-}
-#endif /* MODULE */
-
 #ifdef CONFIG_SUSPEND
 extern int platform_pm_suspend(struct device *dev);
 extern int platform_pm_resume(struct device *dev);
@@ -378,4 +326,16 @@ extern int platform_dma_configure(struct device *dev);
 #define USE_PLATFORM_PM_SLEEP_OPS
 #endif
 
+#ifndef CONFIG_SUPERH
+/*
+ * REVISIT: This stub is needed for all non-SuperH users of early platform
+ * drivers. It should go away once we introduce the new platform_device-based
+ * early driver framework.
+ */
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif /* CONFIG_SUPERH */
+
 #endif /* _PLATFORM_DEVICE_H_ */
-- 
2.23.0

