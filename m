Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2G1RD1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDCCFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:05:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34565 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:05:31 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so4229698itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VdZPtrThr4C1OBrKuvp7zyDzmGvmTq99WUT1hk4NPWU=;
        b=S2G1RD1KaDyiFsrhPDQ1O0XLi5FfNRJ220cXotyny/lY3rLkeGNJxgvQ0iUX/jXjiw
         3/iqSaDXPdcuwaeQGP6tDBEzBqHQPJvVBa+Z7kpjXm4da32zW/5x124Rg1ohNCtxzbNc
         kPslCz4GnikE0pYXvvokicA17umFSwyXWHhcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdZPtrThr4C1OBrKuvp7zyDzmGvmTq99WUT1hk4NPWU=;
        b=agd63VN4J0VwT6gmP3PvoVhaS9IrviSmGKwe0jAhIwTqw0NOG3kvRBSJbsnH2uFeo4
         qSmjSE1r1TzyJFzJvktdliOr3npwKnZxbaeu1QsGILo0PD73M2OnPoWCz1YewKfSgbCk
         DwFCU59RUPaXJFCVf+ASiC4Uo8+nyIt50nR0iiVhFNlMEo37xtwST6EEQH8S4rzY6gHy
         CrjP9AX+iaZUBHncaiSjMSAd4SHkjnVXPJnYZnjW7ubBvD/RaZROId3f66WpPfhciUOW
         g/d/OfzsdJTck4xqFUL4jJaN2dzOV7P4a7Rd/iLSw9kKlgvJmtjGD+PcetKHLqTn5Mu2
         9r3g==
X-Gm-Message-State: APjAAAVvmb1v1jKhugTuvH1C09CEInk7mai7wXQylUC1pF2HmrS0Z2jN
        5VVYCnNhIhy8roVHSVfhmOj8prg78EM=
X-Google-Smtp-Source: APXvYqydxn0n0ssc9I0AQ6PvGNbT2qRpSqpcMnzDzOmOhERtHhl0XVQyzVhc+wrLcXqVBCZI5az5gw==
X-Received: by 2002:a24:7993:: with SMTP id z141mr53429itc.133.1554257129506;
        Tue, 02 Apr 2019 19:05:29 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id d138sm7853605itc.15.2019.04.02.19.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 19:05:28 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3 2/2] platform/chrome: Add Wilco EC keyboard backlight LEDs support
Date:   Tue,  2 Apr 2019 20:05:19 -0600
Message-Id: <20190403020519.211483-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403020519.211483-1-ncrews@chromium.org>
References: <20190403020519.211483-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC is in charge of controlling the keyboard backlight on
the Wilco platform. We expose a standard LED class device at
/sys/class/leds/chromeos::kbd_backlight. This driver is modeled
after the standard Chrome OS keyboard backlight driver at
drivers/platform/chrome/cros_kbd_led_backlight.c

Some Wilco devices do not support a keyboard backlight. This
is checked via wilco_ec_keyboard_leds_exist() in the core driver,
and a platform_device will only be registered by the core if
a backlight is supported.

After an EC reset the backlight could be in a non-PWM mode.
Earlier in the boot sequence the BIOS should send a command to
the EC to set the brightness, so things **should** be set up,
but we double check in probe() as we query the initial brightness.
If not set up, then set the brightness to 0.

Since the EC will never change the backlight level of its own accord,
we don't need to implement a brightness_get() method.

v3 changes:
-Since this behaves the same as the standard Chrome OS keyboard
 backlight, rename the led device to "chromeos::kbd_backlight"
-Move wilco_ec_keyboard_backlight_exists() into core module, so
 that the core does not depend upon the keyboard backlight driver.
-This required moving some code into wilco-ec.h
-Refactor out some common code in set_brightness() and
 initialize_brightness()

v2 changes:
-Remove and fix uses of led vs LED in kconfig
-Assume BIOS initializes brightness, but double check in probe()
-Remove get_brightness() callback, as EC never changes brightness
 by itself.
-Use a __packed struct as message instead of opaque array
-Add exported wilco_ec_keyboard_leds_exist() so the core driver
 now only creates a platform _device if relevant
-Fix use of keyboard_led_set_brightness() since it can sleep

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Kconfig      |   9 +
 drivers/platform/chrome/wilco_ec/Makefile     |   2 +
 drivers/platform/chrome/wilco_ec/core.c       |  58 ++++++
 .../chrome/wilco_ec/kbd_led_backlight.c       | 167 ++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  38 ++++
 5 files changed, 274 insertions(+)
 create mode 100644 drivers/platform/chrome/wilco_ec/kbd_led_backlight.c

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index e09e4cebe9b4..d8cf4a60d1b5 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -18,3 +18,12 @@ config WILCO_EC_DEBUGFS
 	  manipulation and allow for testing arbitrary commands.  This
 	  interface is intended for debug only and will not be present
 	  on production devices.
+
+config WILCO_EC_KBD_BACKLIGHT
+	tristate "Enable keyboard backlight control"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support to set the keyboard backlight
+	  brightness. This happens via a standard LED driver that uses the
+	  Wilco EC mailbox interface. A standard LED class device will
+	  appear under /sys/class/leds/chromeos::kbd_backlight
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..8436539813cd 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_kbd_backlight-objs		:= kbd_led_backlight.o
+obj-$(CONFIG_WILCO_EC_KBD_BACKLIGHT)	+= wilco_kbd_backlight.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..3c45c157b7da 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -38,11 +38,47 @@ static struct resource *wilco_get_resource(struct platform_device *pdev,
 				   dev_name(dev));
 }
 
+/**
+ * wilco_ec_keyboard_backlight_exists() - Is the keyboad backlight supported?
+ * @ec: EC device to query.
+ * @exists: Return value to fill in.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int wilco_ec_keyboard_backlight_exists(struct wilco_ec_device *ec,
+					      bool *exists)
+{
+	struct wilco_ec_kbbl_msg request;
+	struct wilco_ec_kbbl_msg response;
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.command = WILCO_EC_COMMAND_KBBL;
+	request.subcmd = WILCO_KBBL_SUBCMD_GET_FEATURES;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &request;
+	msg.request_size = sizeof(request);
+	msg.response_data = &response;
+	msg.response_size = sizeof(response);
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	*exists = response.status != 0xFF;
+
+	return 0;
+}
+
 static int wilco_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct wilco_ec_device *ec;
 	int ret;
+	bool kbbl_exists;
 
 	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
 	if (!ec)
@@ -89,8 +125,29 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child dev to be found by the keyboard backlight driver. */
+	ret = wilco_ec_keyboard_backlight_exists(ec, &kbbl_exists);
+	if (ret) {
+		dev_err(ec->dev,
+			"Failed checking keyboard backlight support: %d", ret);
+		goto unregister_rtc;
+	}
+	if (kbbl_exists) {
+		ec->kbbl_pdev = platform_device_register_data(dev,
+						"wilco-kbd-backlight",
+						PLATFORM_DEVID_AUTO, NULL, 0);
+		if (IS_ERR(ec->kbbl_pdev)) {
+			dev_err(dev,
+				"Failed to create keyboard backlight pdev\n");
+			ret = PTR_ERR(ec->kbbl_pdev);
+			goto unregister_rtc;
+		}
+	}
+
 	return 0;
 
+unregister_rtc:
+	platform_device_unregister(ec->rtc_pdev);
 unregister_debugfs:
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
@@ -102,6 +159,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->kbbl_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
new file mode 100644
index 000000000000..922ac8717b23
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Keyboard backlight LED driver for the Wilco Embedded Controller
+ *
+ * Copyright 2019 Google LLC
+ *
+ * The EC is in charge of controlling the keyboard backlight on
+ * the Wilco platform. We expose a standard LED class device at
+ * /sys/class/leds/chromeos::kbd_backlight. Power Manager normally
+ * controls the backlight by writing a percentage in range [0, 100]
+ * to the brightness property. This driver is modeled after the
+ * standard Chrome OS keyboard backlight driver at
+ * drivers/platform/chrome/cros_kbd_led_backlight.c
+ *
+ * Some Wilco devices do not support a keyboard backlight. This
+ * is checked via wilco_ec_keyboard_backlight_exists() in the core driver,
+ * and a platform_device will only be registered by the core if
+ * a backlight is supported.
+ *
+ * After an EC reset the backlight could be in a non-PWM mode.
+ * Earlier in the boot sequence the BIOS should send a command to
+ * the EC to set the brightness, so things **should** be set up,
+ * but we double check in probe() as we query the initial brightness.
+ * If not set up, then we set the brightness to KBBL_DEFAULT_BRIGHTNESS.
+ *
+ * Since the EC will never change the backlight level of its own accord,
+ * we don't need to implement a brightness_get() method.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME		"wilco-kbd-backlight"
+
+#define KBBL_DEFAULT_BRIGHTNESS	0
+
+struct wilco_keyboard_led_data {
+	struct wilco_ec_device *ec;
+	struct led_classdev keyboard;
+};
+
+/* Send a request, get a response, and check that the response is good. */
+static int send_kbbl_msg(struct wilco_ec_device *ec,
+			 const struct wilco_ec_kbbl_msg *request,
+			 struct wilco_ec_kbbl_msg *response)
+{
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &request;
+	msg.request_size = sizeof(request);
+	msg.response_data = &response;
+	msg.response_size = sizeof(response);
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		dev_err(ec->dev, "Failed sending brightness command: %d", ret);
+
+	if (response->status) {
+		dev_err(ec->dev,
+			"EC reported failure sending brightness command: %d",
+			response->status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* This may sleep because it uses wilco_ec_mailbox() */
+static int keyboard_led_set_brightness(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct wilco_ec_kbbl_msg request;
+	struct wilco_ec_kbbl_msg response;
+	struct wilco_keyboard_led_data *data;
+
+	memset(&request, 0, sizeof(request));
+	request.command = WILCO_EC_COMMAND_KBBL;
+	request.subcmd = WILCO_KBBL_SUBCMD_GET_STATE;
+	request.mode = WILCO_KBBL_MODE_FLAG_PWM;
+	request.percent = brightness;
+
+	data = container_of(cdev, struct wilco_keyboard_led_data, keyboard);
+	return send_kbbl_msg(data->ec, &request, &response);
+}
+
+/*
+ * Get the current brightness, ensuring that we are in PWM mode. If not
+ * in PWM mode, then the current brightness is meaningless, so set the
+ * brightness to KBBL_DEFAULT_BRIGHTNESS.
+ *
+ * Return: Final brightness of the keyboard, or negative error code on failure.
+ */
+static int initialize_brightness(struct wilco_keyboard_led_data *data)
+{
+	struct wilco_ec_kbbl_msg request;
+	struct wilco_ec_kbbl_msg response;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.command = WILCO_EC_COMMAND_KBBL;
+	request.subcmd = WILCO_KBBL_SUBCMD_GET_STATE;
+
+	ret = send_kbbl_msg(data->ec, &request, &response);
+	if (ret < 0)
+		return ret;
+
+	if (response.mode & WILCO_KBBL_MODE_FLAG_PWM)
+		return response.percent;
+
+	dev_warn(data->ec->dev, "Keyboard brightness not initialized by BIOS");
+	ret = led_set_brightness_sync(&data->keyboard, KBBL_DEFAULT_BRIGHTNESS);
+	if (ret < 0)
+		return ret;
+
+	return KBBL_DEFAULT_BRIGHTNESS;
+}
+
+static int keyboard_led_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct wilco_keyboard_led_data *data;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ec = ec;
+	/* This acts the same as the CrOS backlight, so use the same name */
+	data->keyboard.name = "chromeos::kbd_backlight";
+	data->keyboard.max_brightness = 100;
+	data->keyboard.flags = LED_CORE_SUSPENDRESUME;
+	data->keyboard.brightness_set_blocking = keyboard_led_set_brightness;
+	ret = initialize_brightness(data);
+	if (ret < 0)
+		return ret;
+	data->keyboard.brightness = ret;
+
+	ret = devm_led_classdev_register(&pdev->dev, &data->keyboard);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver keyboard_led_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = keyboard_led_probe,
+};
+module_platform_driver(keyboard_led_driver);
+
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_DESCRIPTION("Wilco keyboard backlight LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 1ff224793c99..c3965b7f397d 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -32,6 +32,7 @@
  * @data_size: Size of the data buffer used for EC communication.
  * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  * @rtc_pdev: The child platform_device used by the RTC sub-driver.
+ * @kbbl_pdev: The child pdev used by the keyboard backlight sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	size_t data_size;
 	struct platform_device *debugfs_pdev;
 	struct platform_device *rtc_pdev;
+	struct platform_device *kbbl_pdev;
 };
 
 /**
@@ -114,6 +116,42 @@ struct wilco_ec_message {
 	void *response_data;
 };
 
+/* Constants and structs useful for keyboard backlight (KBBL) control */
+
+#define WILCO_EC_COMMAND_KBBL		0x75
+#define WILCO_KBBL_MODE_FLAG_PWM	BIT(1)	/* Set brightness by percent. */
+
+/**
+ * enum kbbl_subcommand - What action does the EC perform?
+ * @WILCO_KBBL_SUBCMD_GET_FEATURES: Request available functionality from EC.
+ * @WILCO_KBBL_SUBCMD_GET_STATE: Request current mode and brightness from EC.
+ * @WILCO_KBBL_SUBCMD_SET_STATE: Write mode and brightness to EC.
+ */
+enum kbbl_subcommand {
+	WILCO_KBBL_SUBCMD_GET_FEATURES = 0x00,
+	WILCO_KBBL_SUBCMD_GET_STATE = 0x01,
+	WILCO_KBBL_SUBCMD_SET_STATE = 0x02,
+};
+
+/**
+ * struct wilco_ec_kbbl_msg - Message to/from EC for keyboard backlight control.
+ * @command: Always WILCO_EC_COMMAND_KBBL.
+ * @status: Set by EC to 0 on success, 0xFF on failure.
+ * @subcmd: One of enum kbbl_subcommand.
+ * @mode: Bit flags for used mode, we want to use WILCO_KBBL_MODE_FLAG_PWM.
+ * @percent: Brightness in 0-100. Only meaningful in PWM mode.
+ */
+struct wilco_ec_kbbl_msg {
+	u8 command;
+	u8 status;
+	u8 subcmd;
+	u8 reserved3;
+	u8 mode;
+	u8 reserved5to8[4];
+	u8 percent;
+	u8 reserved10to15[6];
+} __packed;
+
 /**
  * wilco_ec_mailbox() - Send request to the EC and receive the response.
  * @ec: Wilco EC device.
-- 
2.20.1

