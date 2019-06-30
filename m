Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67BAC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90636208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfm41T5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfF3Flf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:35 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40187 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3Fld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:33 -0400
Received: by mail-vs1-f67.google.com with SMTP id a186so6754913vsd.7;
        Sat, 29 Jun 2019 22:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfQ7zt4ue0d5+MuKHGtuF9dNlgHqd2O2zESfTSx+XfI=;
        b=tfm41T5CVYsCgLrEYbcEjkVe2f5DxffEK8IGPk/l8m2aPzPrEyfOLTMNWXTuBlF+g4
         ymPt872OMiKX9gfqnVgUpAls5shlL1FHYf38YEw/5KJGcfixzeJ5gTgS7JvMMA6dFpak
         U/xYXR6PhosfH9C0syGgVpvx7svuB0hr1HF/Mv6/Anvf79Opu3+7TfkkQXV7ktjXHbfy
         OAS4/q3AMMux3bv3kXsxv6UB59+lIxVKPYTa7h+y5pbebezo1JxvhAlq97LKPQDdWj6N
         DHGC1VheRfro5pwANBwxAKtneA36617ZrO+9HMdFfvvRQF71pnzEiZgYsr7JmT5lExzm
         ND8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfQ7zt4ue0d5+MuKHGtuF9dNlgHqd2O2zESfTSx+XfI=;
        b=Y2d4+JTPePpCqgmdtWGXI2HJY8TQCSxCfGOtWq3nmpoxf6Wht403ykPNq6Agz+o5Qd
         ExolFhPFu2MBwmQAspEKcZMxSO8+JnHhiZ8O3KRfF9nsXQkSeAdPr15xoNhDlqze1x0+
         F7IUkrT6dC2jBuN2sBMNfao1Qp7wJOhjL4UuA3659tSlVDf8Lz9Hdx0EKig9m08iiZ+Y
         jKFQc4NR1l473lvkuv74wiM4rCSs8e+wJ0mOppzTpM2J2ZziiGQmT8kkVIR0VzaNQYxT
         GQRdxXRtC1ttUdVMsHSXTUci4NDhQu/y9xrBgMpv6lGdIeRqaiZvcW4T7TcFhQluqOvN
         1ytQ==
X-Gm-Message-State: APjAAAVQd6C9/8Pb/8dq4UXVhFC1YQtPEUwaqZZCZTn6DevV2VKZl9tK
        MpCVIjhwf/ryzsRcAeRu7g==
X-Google-Smtp-Source: APXvYqwu7+v6qg1XZ7YJKwpWFDsuUWY5BP6N8hH+ojyutn+eGOGSFfxddkhEh68wXXZUJ7bWPEJAdQ==
X-Received: by 2002:a67:cd9a:: with SMTP id r26mr10903718vsl.152.1561873291840;
        Sat, 29 Jun 2019 22:41:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:31 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 2/9] platform/x86: huawei-wmi: Move to platform driver
Date:   Sun, 30 Jun 2019 01:41:01 -0400
Message-Id: <20190630054108.19205-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from WMI driver to platform driver. This move is necessary since
the driver is no longer a hotkeys driver only. Platform driver makes it
easier for users to access sysfs attributes under (i.e.
/sys/devices/platform/huawei-wmi) compared to wmi driver.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
Do you think we should stick to wmi driver especially after
"platform/x86: wmi: add context pointer field to struct wmi_device_id"
https://patchwork.kernel.org/patch/10963421/ which is basically was my
issue with wmi driver where there wasn't a way to distinguish what wmi
device is associated with which guid.

I believe that platform driver is more suitable for this since it has
grown from just a hotkeys driver and users can access sysfs of this
easily with platform driver. What do you think?

 drivers/platform/x86/huawei-wmi.c | 152 +++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index a1159850a16c..12cae450fc1f 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -10,6 +10,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 
 /*
@@ -23,12 +24,15 @@
 
 
 struct huawei_wmi_priv {
-	struct input_dev *idev;
+	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	acpi_handle handle;
 	char *acpi_method;
+	struct platform_device *pdev;
 };
 
+struct platform_device *huawei_wmi_pdev;
+
 static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
@@ -46,6 +50,8 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+/* LEDs */
+
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
@@ -77,9 +83,9 @@ static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 	return 0;
 }
 
-static int huawei_wmi_leds_setup(struct wmi_device *wdev)
+static int huawei_wmi_leds_setup(struct device *dev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
 
 	priv->handle = ec_get_handle();
 	if (!priv->handle)
@@ -97,15 +103,16 @@ static int huawei_wmi_leds_setup(struct wmi_device *wdev)
 	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
 	priv->cdev.default_trigger = "audio-micmute";
 	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	priv->cdev.dev = &wdev->dev;
+	priv->cdev.dev = dev;
 	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
+	return devm_led_classdev_register(dev, &priv->cdev);
 }
 
-static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
+/* Input */
+
+static void huawei_wmi_process_key(struct input_dev *idev, int code)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
 
 	/*
@@ -129,81 +136,142 @@ static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
 		kfree(response.pointer);
 	}
 
-	key = sparse_keymap_entry_from_scancode(priv->idev, code);
+	key = sparse_keymap_entry_from_scancode(idev, code);
 	if (!key) {
-		dev_info(&wdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
+		dev_info(&idev->dev, "Unknown key pressed, code: 0x%04x\n", code);
 		return;
 	}
 
-	sparse_keymap_report_entry(priv->idev, key, 1, true);
+	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
-static void huawei_wmi_notify(struct wmi_device *wdev,
-		union acpi_object *obj)
+static void huawei_wmi_input_notify(u32 value, void *context)
 {
-	if (obj->type == ACPI_TYPE_INTEGER)
-		huawei_wmi_process_key(wdev, obj->integer.value);
+	struct input_dev *idev = (struct input_dev *)context;
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&idev->dev, "Unable to get event data\n");
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(idev, obj->integer.value);
 	else
-		dev_info(&wdev->dev, "Bad response type %d\n", obj->type);
+		dev_err(&idev->dev, "Bad response type\n");
+
+	kfree(response.pointer);
 }
 
-static int huawei_wmi_input_setup(struct wmi_device *wdev)
+static int huawei_wmi_input_setup(struct device *dev,
+		struct input_dev **idev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	int err;
 
-	priv->idev = devm_input_allocate_device(&wdev->dev);
-	if (!priv->idev)
+	*idev = devm_input_allocate_device(dev);
+	if (!*idev)
 		return -ENOMEM;
 
-	priv->idev->name = "Huawei WMI hotkeys";
-	priv->idev->phys = "wmi/input0";
-	priv->idev->id.bustype = BUS_HOST;
-	priv->idev->dev.parent = &wdev->dev;
+	(*idev)->name = "Huawei WMI hotkeys";
+	(*idev)->phys = "wmi/input0";
+	(*idev)->id.bustype = BUS_HOST;
+	(*idev)->dev.parent = dev;
 
-	err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
+	err = sparse_keymap_setup(*idev, huawei_wmi_keymap, NULL);
 	if (err)
 		return err;
 
-	return input_register_device(priv->idev);
+	return input_register_device(*idev);
 }
 
-static int huawei_wmi_probe(struct wmi_device *wdev)
+/* Huawei driver */
+
+static int huawei_wmi_probe(struct platform_device *pdev)
 {
 	struct huawei_wmi_priv *priv;
 	int err;
 
-	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	dev_set_drvdata(&wdev->dev, priv);
+	priv->pdev = pdev;
+	dev_set_drvdata(&pdev->dev, priv);
+
+	if (wmi_has_guid(WMI0_EVENT_GUID)) {
+		err = huawei_wmi_input_setup(&pdev->dev, &priv->idev[0]) ||
+				wmi_install_notify_handler(WMI0_EVENT_GUID,
+					huawei_wmi_input_notify, priv->idev[0]);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to setup input device\n");
+			return err;
+		}
+	}
 
-	err = huawei_wmi_input_setup(wdev);
-	if (err)
-		return err;
+	if (wmi_has_guid(HWMI_EVENT_GUID)) {
+		err = huawei_wmi_input_setup(&pdev->dev, &priv->idev[1]) ||
+				wmi_install_notify_handler(HWMI_EVENT_GUID,
+					huawei_wmi_input_notify, priv->idev[1]);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to setup input device\n");
+			return err;
+		}
+	}
 
-	return huawei_wmi_leds_setup(wdev);
+	return huawei_wmi_leds_setup(&pdev->dev);
 }
 
-static const struct wmi_device_id huawei_wmi_id_table[] = {
-	{ .guid_string = WMI0_EVENT_GUID },
-	{ .guid_string = HWMI_EVENT_GUID },
-	{  }
-};
+static int huawei_wmi_remove(struct platform_device *pdev)
+{
+	if (wmi_has_guid(WMI0_EVENT_GUID))
+		wmi_remove_notify_handler(WMI0_EVENT_GUID);
+
+	if (wmi_has_guid(HWMI_EVENT_GUID))
+		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
-static struct wmi_driver huawei_wmi_driver = {
+	return 0;
+}
+
+static struct platform_driver huawei_wmi_driver = {
 	.driver = {
 		.name = "huawei-wmi",
 	},
-	.id_table = huawei_wmi_id_table,
 	.probe = huawei_wmi_probe,
-	.notify = huawei_wmi_notify,
+	.remove = huawei_wmi_remove,
 };
 
-module_wmi_driver(huawei_wmi_driver);
+static __init int huawei_wmi_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&huawei_wmi_driver);
+	if (err)
+		return err;
+
+	huawei_wmi_pdev = platform_device_register_simple("huawei-wmi", -1, NULL, 0);
+	if (IS_ERR(huawei_wmi_pdev)) {
+		platform_driver_unregister(&huawei_wmi_driver);
+		return PTR_ERR(huawei_wmi_pdev);
+	}
+
+	return 0;
+}
+
+static __exit void huawei_wmi_exit(void)
+{
+	platform_device_unregister(huawei_wmi_pdev);
+	platform_driver_unregister(&huawei_wmi_driver);
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
 
-MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
+MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
+MODULE_ALIAS("wmi:"HWMI_EVENT_GUID);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

