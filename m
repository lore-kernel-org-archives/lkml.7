Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A649BC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6110720882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5mEu253"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408069AbfIXCsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:48:46 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33054 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbfIXCsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:48:46 -0400
Received: by mail-vs1-f65.google.com with SMTP id p13so325460vso.0;
        Mon, 23 Sep 2019 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SfG1Kf1+1y7qh1YDizLFhcQ065mmcEQ+JVK4jm48LKg=;
        b=s5mEu25388n7Xg5VPJvOvXKwmeC0r9wMHstdYS/T7sl2MCgr0F8Ywg3zJUBj5Xqyeu
         3TEOAs4ft9NKLruo9H3Z6XbMZ/cA1oP2K7leqK1EQY5x7REzuE3dNAODlpzzH8UKUBf+
         pMMBbZwXd5AyBOTpcq68CiniH2pqh1zpIGtXTElf/VLNfkYq7PV5L2xxKVRXozyUkAlB
         eiP4f2tsultamrO08OwJhKa6XdprSIs5s/FZ+gS0KHpP4LfoQ19NwXyiklBtsaT/EKNg
         U0gE3cv1BTh8YQTNwDGBvVZWOkj5Dt5A5wibPq6hklU5bCfyIlNMDYOAlqUj0yDwa5Te
         EBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SfG1Kf1+1y7qh1YDizLFhcQ065mmcEQ+JVK4jm48LKg=;
        b=XXZgg7+4BDP/DFBGvdl69LQafpOkxptVyDtNioidLQnvNDU5rJUF0vGakgTc4mW6jT
         4uLxUDGAFkysvom8MafAbCs8w9dSA5k+aG15xwW5MKw7IxST11WdMjdUeGWvQHA/D8Kl
         PIWH0A7aKapi0wRZztv8k9A2jA6a5uW3HzVRQvO24St0LFEMgBfAaQvIVdjJcHcMnH37
         dXGjzegdnm5Quvo50U3kYp0Cwgjb3w01sZRhRFbry1xbxfqZtjpFIaPJSckrVk7cn5ZG
         oDt+KW29JMHY4O1QtEJ9UzM6JSg29hdVUvbgNDh1pR5EHR6LkfopoxniJPsE3eCC7oR0
         H1wA==
X-Gm-Message-State: APjAAAWRhzX8SgNsSqiC3QR6Td7wvanw8SjzLhefCaQfzvQTiLJLm9wz
        YUuKi6EvlaBWNIuZfXN6mw==
X-Google-Smtp-Source: APXvYqxUiqPnXqT2UOvcgFpGyXQC9cqcxD2v1/Wg2Z7hudcOfDqnCDtqLLX1bAADczjngHWdAILfOQ==
X-Received: by 2002:a67:c494:: with SMTP id d20mr309945vsk.126.1569293324711;
        Mon, 23 Sep 2019 19:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id o16sm46547uar.2.2019.09.23.19.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:48:44 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sinan Kaya <okaya@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] platform/x86: huawei-wmi: Move to platform driver
Date:   Mon, 23 Sep 2019 22:48:06 -0400
Message-Id: <20190924024821.497-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924024821.497-1-ayman.bagabas@gmail.com>
References: <20190924024821.497-1-ayman.bagabas@gmail.com>
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

Use WMI device UID, AMW0 has a UID of HWMI. WMI0 is the device name
and doesn't have a UID so keep it as it is.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |   7 +-
 drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++----------
 2 files changed, 156 insertions(+), 77 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ae21d08c65e8..754405e19ef1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1305,7 +1305,7 @@ config INTEL_ATOMISP2_PM
 	  will be called intel_atomisp2_pm.
 
 config HUAWEI_WMI
-	tristate "Huawei WMI hotkeys driver"
+	tristate "Huawei WMI laptop extras driver"
 	depends on ACPI_WMI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
@@ -1314,9 +1314,8 @@ config HUAWEI_WMI
 	select LEDS_TRIGGER_AUDIO
 	select NEW_LEDS
 	help
-	  This driver provides support for Huawei WMI hotkeys.
-	  It enables the missing keys and adds support to the micmute
-	  LED found on some of these laptops.
+	  This driver provides support for Huawei WMI hotkeys, battery charge
+	  control, fn-lock, mic-mute LED, and other extra features.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called huawei-wmi.
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 195a7f3638cb..9496ea3c78b5 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Huawei WMI hotkeys
+ *  Huawei WMI laptop extras driver
  *
  *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
  */
@@ -10,23 +10,28 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 
 /*
  * Huawei WMI GUIDs
  */
-#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
-#define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+#define HWMI_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
 
+/* Legacy GUIDs */
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
+#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
 
-struct huawei_wmi_priv {
-	struct input_dev *idev;
+struct huawei_wmi {
+	struct input_dev *idev[2];
 	struct led_classdev cdev;
+	struct platform_device *pdev;
 	acpi_handle handle;
 	char *acpi_method;
 };
 
+struct huawei_wmi *huawei_wmi;
+
 static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
@@ -37,7 +42,7 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
-	// Keyboard backlight
+	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
@@ -47,7 +52,7 @@ static const struct key_entry huawei_wmi_keymap[] = {
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
+	struct huawei_wmi *huawei = dev_get_drvdata(led_cdev->dev->parent);
 	acpi_status status;
 	union acpi_object args[3];
 	struct acpi_object_list arg_list = {
@@ -58,52 +63,53 @@ static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
 	args[1].integer.value = 0x04;
 
-	if (strcmp(priv->acpi_method, "SPIN") == 0) {
+	if (strcmp(huawei->acpi_method, "SPIN") == 0) {
 		args[0].integer.value = 0;
 		args[2].integer.value = brightness ? 1 : 0;
-	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
+	} else if (strcmp(huawei->acpi_method, "WPIN") == 0) {
 		args[0].integer.value = 1;
 		args[2].integer.value = brightness ? 0 : 1;
 	} else {
 		return -EINVAL;
 	}
 
-	status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
+	status = acpi_evaluate_object(huawei->handle, huawei->acpi_method, &arg_list, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENXIO;
 
 	return 0;
 }
 
-static int huawei_wmi_leds_setup(struct wmi_device *wdev)
+static void huawei_wmi_leds_setup(struct device *dev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
 
-	priv->handle = ec_get_handle();
-	if (!priv->handle)
-		return 0;
+	huawei->handle = ec_get_handle();
+	if (!huawei->handle)
+		return;
 
-	if (acpi_has_method(priv->handle, "SPIN"))
-		priv->acpi_method = "SPIN";
-	else if (acpi_has_method(priv->handle, "WPIN"))
-		priv->acpi_method = "WPIN";
+	if (acpi_has_method(huawei->handle, "SPIN"))
+		huawei->acpi_method = "SPIN";
+	else if (acpi_has_method(huawei->handle, "WPIN"))
+		huawei->acpi_method = "WPIN";
 	else
-		return 0;
+		return;
 
-	priv->cdev.name = "platform::micmute";
-	priv->cdev.max_brightness = 1;
-	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
-	priv->cdev.default_trigger = "audio-micmute";
-	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	priv->cdev.dev = &wdev->dev;
-	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
+	huawei->cdev.name = "platform::micmute";
+	huawei->cdev.max_brightness = 1;
+	huawei->cdev.brightness_set_blocking = &huawei_wmi_micmute_led_set;
+	huawei->cdev.default_trigger = "audio-micmute";
+	huawei->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	huawei->cdev.dev = dev;
+	huawei->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
+	devm_led_classdev_register(dev, &huawei->cdev);
 }
 
-static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
+/* Input */
+
+static void huawei_wmi_process_key(struct input_dev *idev, int code)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
 
 	/*
@@ -127,81 +133,155 @@ static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
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
+		const char *guid,
+		struct input_dev **idev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
-	int err;
-
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
-	if (err)
-		return err;
+	return sparse_keymap_setup(*idev, huawei_wmi_keymap, NULL) ||
+		input_register_device(*idev) ||
+		wmi_install_notify_handler(guid, huawei_wmi_input_notify,
+				*idev);
+}
 
-	return input_register_device(priv->idev);
+static void huawei_wmi_input_exit(struct device *dev, const char *guid)
+{
+	wmi_remove_notify_handler(guid);
 }
 
-static int huawei_wmi_probe(struct wmi_device *wdev, const void *context)
+/* Huawei driver */
+
+static const struct wmi_device_id huawei_wmi_events_id_table[] = {
+	{ .guid_string = WMI0_EVENT_GUID },
+	{  }
+};
+
+static int huawei_wmi_probe(struct platform_device *pdev)
 {
-	struct huawei_wmi_priv *priv;
+	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
 	int err;
 
-	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	platform_set_drvdata(pdev, huawei_wmi);
+	huawei_wmi->pdev = pdev;
 
-	dev_set_drvdata(&wdev->dev, priv);
+	while (*guid->guid_string) {
+		struct input_dev *idev = *huawei_wmi->idev;
 
-	err = huawei_wmi_input_setup(wdev);
-	if (err)
-		return err;
+		if (wmi_has_guid(guid->guid_string)) {
+			err = huawei_wmi_input_setup(&pdev->dev, guid->guid_string, &idev);
+			if (err) {
+				dev_err(&pdev->dev, "Failed to setup input on %s\n", guid->guid_string);
+				return err;
+			}
+		}
 
-	return huawei_wmi_leds_setup(wdev);
+		idev++;
+		guid++;
+	}
+
+	huawei_wmi_leds_setup(&pdev->dev);
+	return 0;
 }
 
-static const struct wmi_device_id huawei_wmi_id_table[] = {
-	{ .guid_string = WMI0_EVENT_GUID },
-	{ .guid_string = AMW0_EVENT_GUID },
-	{  }
-};
+static int huawei_wmi_remove(struct platform_device *pdev)
+{
+	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
+
+	while (*guid->guid_string) {
+		if (wmi_has_guid(guid->guid_string))
+			huawei_wmi_input_exit(&pdev->dev, guid->guid_string);
+
+		guid++;
+	}
 
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
+	struct platform_device *pdev;
+	int err;
+
+	huawei_wmi = kzalloc(sizeof(struct huawei_wmi), GFP_KERNEL);
+	if (!huawei_wmi)
+		return -ENOMEM;
+
+	err = platform_driver_register(&huawei_wmi_driver);
+	if (err)
+		goto pdrv_err;
+
+	pdev = platform_device_register_simple("huawei-wmi", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		err = PTR_ERR(pdev);
+		goto pdev_err;
+	}
+
+	return 0;
+
+pdev_err:
+	platform_driver_unregister(&huawei_wmi_driver);
+pdrv_err:
+	kfree(huawei_wmi);
+	return err;
+}
+
+static __exit void huawei_wmi_exit(void)
+{
+	platform_device_unregister(huawei_wmi->pdev);
+	platform_driver_unregister(&huawei_wmi_driver);
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
 
-MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
+MODULE_DEVICE_TABLE(wmi, huawei_wmi_events_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
-MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");

base-commit: b5b3bd898ba99fb0fb6aed3b23ec6353a1724d6f
-- 
2.21.0

