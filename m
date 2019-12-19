Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46269C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B252467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W253Br09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLSUOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:14:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40530 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:14:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so3897160pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/X2nCSQhAbyDdeFNb7VfahtMULqeKEj32AxsHWJfw4=;
        b=W253Br09e3JbexcMTCTMWx52GeE4+723Iw3wJIQQGeaQGiPeZRZTvypErjrtXn3n6x
         md5U+kLPCCVOwSzuXR3kw6dn3QOw7qIiml9PSpJ74yxZs4w0Ri1wJ0wWpxIUq+d3pa4F
         gXQy4l8tOdQ9yG/j8CjgE2MdJSoYsrTaSN6To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/X2nCSQhAbyDdeFNb7VfahtMULqeKEj32AxsHWJfw4=;
        b=Mi980zZvmCsqqgtyyeZ78gSg/g5I6NSZesKWi8PKQW4kb6fCmfTUqDdbyhLegm+uOJ
         qpjTjlt/FMD56hgwo96NIlr3FaqPxgd/es7TSpHsycefZZe13AWzQT0VjLdieelJdq7M
         8CvXIpoHrc1cQtR33DtjFezJIunEPbbndE38wvYDkNhLq3+Kwgf7oE7XMTG8uC3zvl1I
         UFHxkuAsCp1FxN/iGOyp5RX989CTEhxW86FTBU13cQJSkWGy8weXUhNXzRtpA+HiKqJz
         AafydN/4gpumEYp7U8j2tT9P4B6rSCzVSOn+RngGao2QFELH5k4yXt8T8kBXOU1/u/mb
         d6FA==
X-Gm-Message-State: APjAAAV0CD0+aR98jl3udicmn0hweLegduJhHSWlMj7ili9YxCEBelFb
        9abZIETkcSZRuHGLwwK7nsL9xo0B100=
X-Google-Smtp-Source: APXvYqzhnE6+Bchq7pgMrirLVw2f5qaOGKUNCHnsUYdytgLGIw+4836Pwv7Yr59u0CN2uV3VdXI+1w==
X-Received: by 2002:a63:5203:: with SMTP id g3mr10429555pgb.377.1576786462355;
        Thu, 19 Dec 2019 12:14:22 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id m101sm7841100pje.13.2019.12.19.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:14:21 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, groeck@chromium.org,
        bleung@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/2] platform: chrome: Add cros-usbpd-notify driver
Date:   Thu, 19 Dec 2019 12:13:40 -0800
Message-Id: <20191219201340.196259-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

ChromiumOS uses ACPI device with HID "GOOG0003" for power delivery
related events. The existing cros-usbpd-charger driver relies on these
events without ever actually receiving them on ACPI platforms. This is
because in the ChromeOS kernel trees, the GOOG0003 device is owned by an
ACPI driver that offers firmware updates to USB-C chargers.

Introduce a new platform driver under cros-ec, the ChromeOS embedded
controller, that handles these PD events and dispatches them
appropriately over a notifier chain to all drivers that use them.

On non-ACPI platforms, the driver gets instantiated for ECs which
support the EC_FEATURE_USB_PD feature bit, and on such platforms, the
notification events will get delivered using the MKBP event handling
mechanism.

Co-Developed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3 (pmalani@chromium.org):
- Renamed driver and files from "cros_ec_pd_notify" to
  "cros_usbpd_notify" to be more consistent with other naming.
- Moved the change to include cros-usbpd-notify in the charger MFD into
  a separate follow-on patch.

Changes in v2 (pmalani@chromium.org):
- Removed dependency on DT entry; instead, we will instantiate the
  driver on detecting EC_FEATURE_USB_PD for non-ACPI platforms.
- Modified the cros-ec-pd-notify device to be an mfd_cell under
  usbpdcharger for non-ACPI platforms. Altered the platform_probe() call
  to derive the cros EC structs appropriately.
- Replaced "usbpd_notify" with "pd_notify" in functions and structures.
- Addressed comments from upstream maintainer.

 drivers/platform/chrome/Kconfig               |   9 ++
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_usbpd_notify.c   | 151 ++++++++++++++++++
 .../linux/platform_data/cros_usbpd_notify.h   |  17 ++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_usbpd_notify.h

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 5f57282a28da0..3a8a98f2fb4d1 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -226,6 +226,15 @@ config CROS_USBPD_LOGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_usbpd_logger.
 
+config CROS_USBPD_NOTIFY
+	tristate "ChromeOS Type-C power delivery event notifier"
+	depends on CROS_EC
+	help
+	  If you say Y here, you get support for Type-C PD event notifications
+	  from the ChromeOS EC. On ACPI platorms this driver will bind to the
+	  GOOG0003 ACPI device, and on non-ACPI platforms this driver will get
+	  initialized on ECs which support the feature EC_FEATURE_USB_PD.
+
 source "drivers/platform/chrome/wilco_ec/Kconfig"
 
 endif # CHROMEOS_PLATFORMS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index aacd5920d8a18..f6465f8ef0b5e 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
+obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
new file mode 100644
index 0000000000000..05a7db834d2e0
--- /dev/null
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2019 Google LLC
+ *
+ * This driver serves as the receiver of cros_ec PD host events.
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "cros-usbpd-notify"
+#define ACPI_DRV_NAME "GOOG0003"
+
+static BLOCKING_NOTIFIER_HEAD(cros_usbpd_notifier_list);
+
+/**
+ * cros_usbpd_register_notify - Register a notifier callback for PD events.
+ * @nb: Notifier block pointer to register
+ *
+ * On ACPI platforms this corresponds to host events on the ECPD
+ * "GOOG0003" ACPI device. On non-ACPI platforms this will filter mkbp events
+ * for USB PD events.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_usbpd_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(
+			&cros_usbpd_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(cros_usbpd_register_notify);
+
+
+/**
+ * cros_usbpd_unregister_notify - Unregister notifier callback for PD events.
+ * @nb: Notifier block pointer to unregister
+ *
+ * Unregister a notifier callback that was previously registered with
+ * cros_usbpd_register_notify().
+ */
+void cros_usbpd_unregister_notify(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&cros_usbpd_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
+
+#ifdef CONFIG_ACPI
+
+static int cros_usbpd_notify_add_acpi(struct acpi_device *adev)
+{
+	return 0;
+}
+
+static void cros_usbpd_notify_acpi(struct acpi_device *adev, u32 event)
+{
+	blocking_notifier_call_chain(&cros_usbpd_notifier_list, event, NULL);
+}
+
+static const struct acpi_device_id cros_usbpd_notify_acpi_device_ids[] = {
+	{ ACPI_DRV_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_usbpd_acpi_device_ids);
+
+static struct acpi_driver cros_usbpd_notify_driver = {
+	.name = DRV_NAME,
+	.class = DRV_NAME,
+	.ids = cros_usbpd_notify_acpi_device_ids,
+	.ops = {
+		.add = cros_usbpd_notify_add_acpi,
+		.notify = cros_usbpd_notify_acpi,
+	},
+};
+module_acpi_driver(cros_usbpd_notify_driver);
+
+#else /* CONFIG_ACPI */
+
+static int cros_usbpd_notify_plat(struct notifier_block *nb,
+		unsigned long queued_during_suspend, void *data)
+{
+	struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
+	u32 host_event = cros_ec_get_host_event(ec_dev);
+
+	if (!host_event)
+		return NOTIFY_BAD;
+
+	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
+		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
+				host_event, NULL);
+		return NOTIFY_OK;
+	}
+	return NOTIFY_DONE;
+}
+
+static int cros_usbpd_notify_probe_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb;
+	int ret;
+
+	nb = devm_kzalloc(dev, sizeof(*nb), GFP_KERNEL);
+	if (!nb)
+		return -ENOMEM;
+
+	nb->notifier_call = cros_usbpd_notify_plat;
+	dev_set_drvdata(dev, nb);
+
+	ret = blocking_notifier_chain_register(&ecdev->ec_dev->event_notifier,
+						nb);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cros_usbpd_notify_remove_plat(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ecdev = dev_get_drvdata(dev->parent);
+	struct notifier_block *nb =
+		(struct notifier_block *)dev_get_drvdata(dev);
+
+	blocking_notifier_chain_unregister(&ecdev->ec_dev->event_notifier,
+			nb);
+
+	return 0;
+}
+
+static struct platform_driver cros_usbpd_notify_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_usbpd_notify_probe_plat,
+	.remove = cros_usbpd_notify_remove_plat,
+};
+module_platform_driver(cros_usbpd_notify_driver);
+
+#endif /* CONFIG_ACPI */
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
+MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
new file mode 100644
index 0000000000000..cd7c7bebf18da
--- /dev/null
+++ b/include/linux/platform_data/cros_usbpd_notify.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ChromeOS EC Power Delivery Notifier Driver
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
+#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
+
+#include <linux/notifier.h>
+
+int cros_usbpd_register_notify(struct notifier_block *nb);
+
+void cros_usbpd_unregister_notify(struct notifier_block *nb);
+
+#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
-- 
2.24.1.735.g03f4e72817-goog

