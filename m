Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51162C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048DD218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EK5rOodo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCUWOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:14:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52085 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfCUWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:13:57 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so735240itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKutjfQyFXVvvNEvEePOZfCqGyPUtS2QiNXeuAJnfCY=;
        b=EK5rOodoU0vqzLmYICRHccd6OFRA2gMYGnZIuqbBxZObcCS5rQJJwW6B6fTsfMYbLW
         24FrwSHzqFhmUlCWKXptGViKsHsPTVmMEOg0gULmCtQ+mIu4yjFaTZTgZ33F4KDGhMgf
         09mkR6YAJEmTUXfUYqEaNzU9KIUG2LJAWS95g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKutjfQyFXVvvNEvEePOZfCqGyPUtS2QiNXeuAJnfCY=;
        b=BGQ2v5mnZA4rqoxJ5WqNO/WJU/JvIiMUJyFj1/OcjOT1be0xtdgaisiJRJair+fw6m
         8oddK0RL1qUJ2ijC8LY9Ca7SFq4SN4Nn5/HVejhSVdX5pm8XAJLfa4BbVh8mBi7kuooI
         Jnxs4Dw3ZZ4H4zrsxFDHvvyUWXcbHyDeY0NdQQcPwetWNfB8BkhxoEkRD/fgrOP7d5L6
         0scn72g9ObwETtFSmD0743gfnlYomKEP2dGQ2QDJfzY6oqdiPelxNcCFniQDyFPfMtCG
         JypcKlWqSuxJPm91X23+Ru9T9sgR7CJMq2xRqVZsKMl7thMV4VsJ8cB1V99OG3SRAHlf
         zztQ==
X-Gm-Message-State: APjAAAWgrTEKs/bKXIk2WwKqGMPiAdS3H91tlkEt0MHNE98OF5Z/CUw0
        dxSlfMAFYGZxah7oEfnRuKR7eg==
X-Google-Smtp-Source: APXvYqytAA7eGpnc/cy1tXhWzEcW2GbuWYY29CP8jO51Onwp73K4v7TS/nrDktwWOqXKdIs37MGCKA==
X-Received: by 2002:a24:ac6e:: with SMTP id m46mr612108iti.49.1553206436180;
        Thu, 21 Mar 2019 15:13:56 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id o129sm582093ito.0.2019.03.21.15.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:13:55 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 3/3] platform/chrome: Add Wilco EC keyboard backlight LEDs support
Date:   Thu, 21 Mar 2019 16:13:34 -0600
Message-Id: <20190321221334.240059-3-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321221334.240059-1-ncrews@chromium.org>
References: <20190321221334.240059-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC is in charge of controlling the keyboard backlight on
the Wilco platform. We expose a standard LED class device at
/sys/class/leds/wilco::kbd_backlight. This driver is modeled
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
If not set up, then set the brightness to KBBL_DEFAULT_BRIGHTNESS.

Since the EC will never change the backlight level of its own accord,
we don't need to implement a brightness_get() method.

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
 drivers/platform/chrome/wilco_ec/core.c       |  16 ++
 .../chrome/wilco_ec/kbd_led_backlight.c       | 216 ++++++++++++++++++
 include/linux/platform_data/wilco-ec.h        |  10 +
 5 files changed, 253 insertions(+)
 create mode 100644 drivers/platform/chrome/wilco_ec/kbd_led_backlight.c

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index e09e4cebe9b4..82abd3377a67 100644
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
+	  appear under /sys/class/leds/wilco::kbd_backlight
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 9706aeb20ccb..114940aa9d53 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -6,3 +6,5 @@ wilco_ec_core-objs			:= core.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec_core.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_kbd_backlight-objs		:= kbd_led_backlight.o
+obj-$(CONFIG_WILCO_EC_KBD_BACKLIGHT)	+= wilco_kbd_backlight.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index ece30874f35f..c62990e4fa02 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -89,8 +89,23 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		goto unregister_debugfs;
 	}
 
+	/* Register child dev to be found by the keyboard backlight driver. */
+	if (wilco_ec_keyboard_leds_exist(ec)) {
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
@@ -102,6 +117,7 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	platform_device_unregister(ec->kbbl_pdev);
 	platform_device_unregister(ec->rtc_pdev);
 	if (ec->debugfs_pdev)
 		platform_device_unregister(ec->debugfs_pdev);
diff --git a/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
new file mode 100644
index 000000000000..14cbc54cd8db
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/kbd_led_backlight.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Keyboard backlight LED driver for the Wilco Embedded Controller
+ *
+ * Copyright 2019 Google LLC
+ *
+ * The EC is in charge of controlling the keyboard backlight on
+ * the Wilco platform. We expose a standard LED class device at
+ * /sys/class/leds/wilco::kbd_backlight. Power Manager normally
+ * controls the backlight by writing a percentage in range [0, 100]
+ * to the brightness property. This driver is modeled after the
+ * standard Chrome OS keyboard backlight driver at
+ * drivers/platform/chrome/cros_kbd_led_backlight.c
+ *
+ * Some Wilco devices do not support a keyboard backlight. This
+ * is checked via wilco_ec_keyboard_leds_exist() in the core driver,
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
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME		"wilco-kbd-backlight"
+
+#define EC_COMMAND_KB_BKLIGHT	0x75
+#define KBBL_MODE_PWM		BIT(1)	/* Flag to set brightness by percent */
+/* What action do we want the EC to perform? */
+enum kbbl_subcommand {
+	KBBL_SUBCMD_GET_FEATURES = 0x00,
+	KBBL_SUBCMD_GET_STATE = 0x01,
+	KBBL_SUBCMD_SET_STATE = 0x02,
+};
+
+#define KBBL_DEFAULT_BRIGHTNESS	0
+
+/* The message sent to and received by the EC */
+struct wilco_ec_kbbl_msg {
+	u8 command;		/* Always EC_COMMAND_KB_BKLIGHT */
+	u8 status;		/* Will be set to 0xFF by EC on failure */
+	u8 subcmd;		/* One of enum kbbl_subcommand */
+	u8 reserved3;
+	u8 mode;		/* Always KBBL_MODE_PWM */
+	u8 reserved5to8[4];
+	u8 percent;
+	u8 reserved10to15[6];
+} __packed;
+
+struct wilco_keyboard_led_data {
+	struct wilco_ec_device *ec;
+	struct led_classdev keyboard;
+};
+
+/**
+ * wilco_ec_keyboard_leds_exist() - Is the keyboad backlight supported?
+ * @ec: EC device to query.
+ *
+ * Return: true if backlight is supported, false if not or if error occurred.
+ */
+bool wilco_ec_keyboard_leds_exist(struct wilco_ec_device *ec)
+{
+	struct wilco_ec_kbbl_msg request;
+	struct wilco_ec_kbbl_msg response;
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.command = EC_COMMAND_KB_BKLIGHT;
+	request.subcmd = KBBL_SUBCMD_GET_FEATURES;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &request;
+	msg.request_size = sizeof(request);
+	msg.response_data = &response;
+	msg.response_size = sizeof(response);
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0) {
+		dev_err(ec->dev,
+			"Failed checking keyboard backlight support: %d", ret);
+		return false;
+	}
+
+	return response.status != 0xFF;
+}
+EXPORT_SYMBOL_GPL(wilco_ec_keyboard_leds_exist);
+
+/* This may sleep because it uses wilco_ec_mailbox() */
+static int keyboard_led_set_brightness(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct wilco_ec_kbbl_msg request;
+	struct wilco_ec_message msg;
+	struct wilco_keyboard_led_data *data;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.command = EC_COMMAND_KB_BKLIGHT;
+	request.subcmd = KBBL_SUBCMD_SET_STATE;
+	request.mode = KBBL_MODE_PWM;
+	request.percent = brightness;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &request;
+	msg.request_size = sizeof(request);
+	msg.response_size = 0;
+
+	data = container_of(cdev, struct wilco_keyboard_led_data, keyboard);
+	ret = wilco_ec_mailbox(data->ec, &msg);
+	if (ret < 0)
+		dev_err(cdev->dev, "Failed setting brightness: %d", ret);
+
+	return 0;
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
+	struct wilco_ec_message msg;
+	int ret;
+
+	memset(&request, 0, sizeof(request));
+	request.command = EC_COMMAND_KB_BKLIGHT;
+	request.subcmd = KBBL_SUBCMD_GET_STATE;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type = WILCO_EC_MSG_LEGACY;
+	msg.request_data = &request;
+	msg.request_size = sizeof(request);
+	msg.response_data = &response;
+	msg.response_size = sizeof(response);
+
+	ret = wilco_ec_mailbox(data->ec, &msg);
+	if (ret < 0) {
+		dev_err(data->ec->dev, "Failed getting brightness: %d", ret);
+		return ret;
+	}
+
+	if (response.mode & KBBL_MODE_PWM)
+		return response.percent;
+
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
+	if (!wilco_ec_keyboard_leds_exist(ec))
+		return -ENXIO;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->ec = ec;
+	/* To be found by Power Manager needs to end in ":kbd_backlight" */
+	data->keyboard.name = "wilco::kbd_backlight";
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
index 1ff224793c99..785aa50513c2 100644
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
@@ -114,6 +116,14 @@ struct wilco_ec_message {
 	void *response_data;
 };
 
+/**
+ * wilco_ec_keyboard_leds_exist() - Is the keyboad backlight supported?
+ * @ec: EC device to query.
+ *
+ * Return: true if backlight is supported, false if not or if error occurred.
+ */
+bool wilco_ec_keyboard_leds_exist(struct wilco_ec_device *ec);
+
 /**
  * wilco_ec_mailbox() - Send request to the EC and receive the response.
  * @ec: Wilco EC device.
-- 
2.20.1

