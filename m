Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE36C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AF621A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zc0ZDTzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfKMDLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:11:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46799 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfKMDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:11:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id r18so382406pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 19:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i26ZBxXDn87sGbNbIpNxwCMuVmBotccN5cgQ9c2g9+A=;
        b=Zc0ZDTzTy0ztS0nQeRGUWRYuUeWNABwp7IeYcPzOJRkZtJUEj5LROHPrMpVMF6vReK
         erNxHeUSvQ+7DaFPqNnGpaixq32fhlrlptHHtHr1WzJ5S8Oqi2Ov04k/WXeTYP1QpTgD
         6SGCNDYqeeNfwE92Tx39szdS8vN91l52Xoj6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i26ZBxXDn87sGbNbIpNxwCMuVmBotccN5cgQ9c2g9+A=;
        b=fnge/fx92R4SwLK+GDBCGUmbed5x4c2lX2bxkBwm0z/lZTv2BJ92PgMkdJoenu22Z/
         JngQjRjBa7USo+v/fMzYnBZ9NJU/sbnsKbJzuvpt1xHI3D1TF1hL4hYpo1xVIfGLtN/Z
         KHAAJyYOgDfnVJitwfTgHo3pkrL7pIbrdJHzrA6m24hp0dYdNTm5rtni2s7ViIWK8Ol+
         cc3lEvFGp47bf8gd37QJHzFJq243UtgQZf9eKMRoshz8QRAXDnezbRZYyfTaKpKxjs8n
         CWXGCLgZ8Rcxfiyn8IeoxtqD+bnkOi4ii5xpTOWf3xv8GJTef/50QoSf0CZG8rS0AlnN
         12PA==
X-Gm-Message-State: APjAAAWP9mTlWBIcZAQ0SSkp/VGXIpEQk/OUz6/Uwbj+waCaxCf2PUHA
        vXrlTyk3NzKP/DCdMIH4hQ+QCEGaxXE=
X-Google-Smtp-Source: APXvYqzQNoc8rZlsI3jovVqX7DFRPqG6o89TaleOtPTssKqo7/SMRyvBZ4Jfwgg7uJFn7lS4V+kjbQ==
X-Received: by 2002:a63:e750:: with SMTP id j16mr1098138pgk.30.1573614681714;
        Tue, 12 Nov 2019 19:11:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:1b1f:9c69:179b:de9a])
        by smtp.gmail.com with ESMTPSA id b5sm417582pfp.149.2019.11.12.19.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 19:11:21 -0800 (PST)
From:   Jon Flatley <jflat@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org, sre@kernel.org,
        jflat@chromium.org
Subject: [PATCH 1/3] platform: chrome: Add cros-ec-usbpd-notify driver
Date:   Tue, 12 Nov 2019 19:10:42 -0800
Message-Id: <20191113031044.136232-2-jflat@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191113031044.136232-1-jflat@chromium.org>
References: <20191113031044.136232-1-jflat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
related events. The existing cros-usbpd-charger driver relies on these
events without ever actually receiving them on ACPI platforms. This is
because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
ACPI driver that offers firmware updates to USB-C chargers.

Let's introduce a new platform driver under cros-ec, the ChromeOS
embedded controller, that handles these PD events and dispatches them
appropriately over a notifier chain to all drivers that use them.

Signed-off-by: Jon Flatley <jflat@chromium.org>
---
 drivers/platform/chrome/Kconfig               |   9 +
 drivers/platform/chrome/Makefile              |   1 +
 .../platform/chrome/cros_ec_usbpd_notify.c    | 156 ++++++++++++++++++
 .../platform_data/cros_ec_usbpd_notify.h      |  40 +++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_ec_usbpd_notify.h

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ee5f08ea57b6..d4a55b64bc29 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -118,6 +118,15 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_USBPD_NOTIFY
+	tristate "ChromeOS USB-C power delivery event notifier"
+	depends on CROS_EC
+	help
+	  If you say Y here, you get support for USB-C PD event notifications
+	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
+	  GOOG0003 ACPI device, and on non-ACPI platform this driver will match
+	  "google,cros-ec-pd-update" in device tree.
+
 config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
 	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 477ec3d1d1c9..efa355ab526f 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -21,5 +21,6 @@ obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
+obj-$(CONFIG_CROS_EC_USBPD_NOTIFY)      += cros_ec_usbpd_notify.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
diff --git a/drivers/platform/chrome/cros_ec_usbpd_notify.c b/drivers/platform/chrome/cros_ec_usbpd_notify.c
new file mode 100644
index 000000000000..f654586dea2a
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_usbpd_notify.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cros_ec_usbpd - ChromeOS EC Power Delivery Driver
+ *
+ * Copyright (C) 2019 Google, Inc
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver serves as the receiver of cros_ec PD host events.
+ */
+
+#include <linux/acpi.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_usbpd_notify.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "cros-ec-usbpd-notify"
+#define ACPI_DRV_NAME "GOOG0003"
+
+static BLOCKING_NOTIFIER_HEAD(cros_ec_usbpd_notifier_list);
+
+int cros_ec_usbpd_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(
+			&cros_ec_usbpd_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(cros_ec_usbpd_register_notify);
+
+void cros_ec_usbpd_unregister_notify(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&cros_ec_usbpd_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(cros_ec_usbpd_unregister_notify);
+
+static void cros_ec_usbpd_notify(u32 event)
+{
+	blocking_notifier_call_chain(&cros_ec_usbpd_notifier_list, event, NULL);
+}
+
+#ifdef CONFIG_ACPI
+
+static int cros_ec_usbpd_add_acpi(struct acpi_device *adev)
+{
+	return 0;
+}
+
+static int cros_ec_usbpd_remove_acpi(struct acpi_device *adev)
+{
+	return 0;
+}
+static void cros_ec_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
+{
+	cros_ec_usbpd_notify(event);
+}
+
+static const struct acpi_device_id cros_ec_usbpd_acpi_device_ids[] = {
+	{ ACPI_DRV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_usbpd_acpi_device_ids);
+
+static struct acpi_driver cros_ec_usbpd_driver = {
+	.name = DRV_NAME,
+	.class = DRV_NAME,
+	.ids = cros_ec_usbpd_acpi_device_ids,
+	.ops = {
+		.add = cros_ec_usbpd_add_acpi,
+		.remove = cros_ec_usbpd_remove_acpi,
+		.notify = cros_ec_usbpd_notify_acpi,
+	},
+};
+module_acpi_driver(cros_ec_usbpd_driver);
+
+#else /* CONFIG_ACPI */
+
+static int cros_ec_usbpd_notify_plat(struct notifier_block *nb,
+		unsigned long queued_during_suspend, void *data)
+{
+	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
+		cros_ec_usbpd_notify(host_event);
+		return NOTIFY_OK;
+	} else {
+		return NOTIFY_DONE;
+	}
+
+}
+
+static int cros_ec_usbpd_probe_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb;
+	int ret;
+
+	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	nb->notifier_call = cros_ec_usbpd_notify_plat;
+	dev_set_drvdata(dev, nb);
+	ret = blocking_notifier_chain_register(&ec_dev->event_notifier, nb);
+
+	if (ret < 0)
+		dev_warn(dev, "Failed to register notifier\n");
+
+	return 0;
+}
+
+static int cros_ec_usbpd_remove_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb =
+		(struct notifier_block *)dev_get_drvdata(dev);
+
+	blocking_notifier_chain_unregister(&ec_dev->event_notifier, nb);
+
+	return 0;
+}
+
+static const struct of_device_id cros_ec_usbpd_of_match[] = {
+	{ .compatible = "google,cros-ec-pd-update" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cros_ec_usbpd_of_match);
+
+static struct platform_driver cros_ec_usbpd_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(cros_ec_usbpd_of_match),
+	},
+	.probe = cros_ec_usbpd_probe_plat,
+	.remove = cros_ec_usbpd_remove_plat,
+};
+module_platform_driver(cros_ec_usbpd_driver);
+
+#endif /* CONFIG_ACPI */
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS power delivery device");
+MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/cros_ec_usbpd_notify.h b/include/linux/platform_data/cros_ec_usbpd_notify.h
new file mode 100644
index 000000000000..fdcea146b7c4
--- /dev/null
+++ b/include/linux/platform_data/cros_ec_usbpd_notify.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * cros_ec_usbpd - ChromeOS EC Power Delivery Driver
+ *
+ * Copyright (C) 2019 Google, Inc
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H
+#define __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H
+
+#include <linux/notifier.h>
+
+/**
+ * cros_ec_usbpd_register_notify - register a notifier callback for USB PD
+ * events. On ACPI platforms this corrisponds to to host events on the ECPD
+ * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
+ * for USB PD events.
+ *
+ * @nb: Notifier block pointer to register
+ */
+int cros_ec_usbpd_register_notify(struct notifier_block *nb);
+
+/**
+ * cros_ec_usbpd_unregister_notify - unregister a notifier callback that was
+ * previously registered with cros_ec_usbpd_register_notify().
+ *
+ * @nb: Notifier block pointer to unregister
+ */
+void cros_ec_usbpd_unregister_notify(struct notifier_block *nb);
+
+#endif  /* __LINUX_PLATFORM_DATA_CROS_EC_USBPD_NOTIFY_H */
-- 
2.24.0.432.g9d3f5f5b63-goog

