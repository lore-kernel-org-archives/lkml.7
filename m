Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97DA20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VutXAb0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbfFMQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:28 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35341 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfFMDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:04:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id k128so7722156ywf.2;
        Wed, 12 Jun 2019 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqCxhNeEWil84q36/Sys5ftTAQmLJC4n80rNp/IVug4=;
        b=VutXAb0c+5lKewp/tBCeiy5CGo25sALtiZ6571IrotqBU4FqXP8Eo+2j8p5FJOUaES
         zPpPJ5NiuvbdaAvSPDrGP56K3Wty9/eqiXbmg/JU3lpo+aIg240wCYZZAgHn6w6z4cZk
         shs+xJShsK1/8J7/YqE2X06nsPt+/YtpzbpYe28+sJgQCKDBlhno+L8F+qFBhQCuSLDg
         A42pJYHgawfrIZA5E8xtrMBLZzmBis2Gs5H19r5IqJ2BmBHkugklAhEa3Vy5LxjmLB48
         o/v7l4utCJK5rhNit0kqMvkWjXkV5Z4fcvzB8HkheDcmwH6Yd2iEwl14vUgZ3KxlkSfF
         kQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqCxhNeEWil84q36/Sys5ftTAQmLJC4n80rNp/IVug4=;
        b=VxfzXErXg4tg9EjKxUF4JHvDXOW5GQhK789xSkXdFwtzWRCWw3nw7D0lu8r4RbaFIu
         8JnnGdvcuwV2JC9Jz0+iL1Xr++mtD0QWgm/PTUGeVMZ15adLHOUOhc6oQkSJxqrZExmY
         UPKyVtVp9EZqATh4slv92HdfJEbS4+MtATad8Fosk7dYFqt3UUbZ2SG4sD/wvZdTwWtS
         Q5Uvsr/IkYY9FfFgsTI/QYO3R7ysu0PYKzy30dMmmeUxkxDPE7Ja4To4FMg6tmOQIw3d
         BpUn0wDKyqKulpidQebGuatK9ds0wKygEaAOmfzL+N2Il7EcC1PYpHvB+idp4NooapNo
         Nejg==
X-Gm-Message-State: APjAAAXXwRlQOlcLGGe+xc3NrSYHNRXrUBOF5nFjroajUIiZBMUFckfz
        KRJuKHwdchlW+5o32+isu19vJSQTJA==
X-Google-Smtp-Source: APXvYqxvoGSjdgmHm01n5liUF8gSTS4akWtHRKTd7bplTm5t9cWomHS4EjKb2HsZ8Wo8GbCEcS89AQ==
X-Received: by 2002:a81:5597:: with SMTP id j145mr45273222ywb.328.1560395094928;
        Wed, 12 Jun 2019 20:04:54 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:04:54 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v1] platform/x86: Huawei laptop extras driver
Date:   Wed, 12 Jun 2019 23:04:08 -0400
Message-Id: <20190613030416.25807-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new features to the driver and also moves the
driver from wmi_driver to platform_driver.

This move is necessary because the driver is no longer only a hotkeys
driver and platform_driver offers easier future extensibility. The patch
introduces a WMI BIOS interface that brings on new features and enables
controlling micmute LED through this interface on supported models. New
features are controlling battery charging thresholds and fn-lock state
among with module parameters and quirks check.

Currently, micmute LED is controlled through an ACPI method under EC.
This method ("SPIN", "WPIN") is specific to some models and wouldn't
work on all Huawei laptops.

Using this interface, controlling this LED should work with any model.
Except `MateBook X` from 2017, this one doesn't provide controlling the
LED through this interface instead it uses another "legacy" interface
that is not "fully" implemented yet due to lack of hardware. Currently,
this "legacy" interface is used for hotkeys on this specific model. A
quirk is set to use ACPI method to control micmute LED on this model.

Some models that implement the new WMI BIOS interface can control
battery charging thresholds where it limits charging the battery once it
reaches certain thresholds.

The behavior of hotkeys is not the same among all models. Some models
require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
key is toggled on, the hotkeys with or without a modifier, behave as
F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
`Ins`.

Now, some models fix this by excluding `PrtSc` and `Ins` keys from
being treated as F11 and F12 keys with the use of a modifier. However,
some models do not, and fixes this by the so called fn-lock.

Fn-lock inverts the behavior of the top row from special keys to F1-F12
keys. So a modifier and a special key would be possible which make
things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:
* Fn-key off & fn-lock off - hotkeys treated as special keys using a
  modifier gives F1-F12 keys.
* Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
  modifier gives F1-F12.
* Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
  a modifier gives special keys.
* Fn-key on & fn-lock on - hotkeys are treated as special keys and using
  a modifier gives special keys.

The driver introduces two parameters to force reporting brightness keys
and sleeping after setting a threshold value.

All newer models that "fully" implement the new interface report
brightness key events twice, once through WMI and once through
acpi-video. Older models, such as `MateBook X`, don't report brightness
events using WMI. This is implemented as a quirk and can be forced using
module parameters.

Some models don't allow setting thresholds to (0, 100), due to bad ASL
code, which indicates reset values, instead, it only turns off battery
charging protection. This would return the previously set values even
though battery protection is off which doesn't make sense. A sane value
like (0, 100) indicates no charging protection, but since it's not
possible to set such values, (0, 0) is set before turning protection
off with (0, 100). This requires a delay after setting (0, 0) and after
(0, 100) so that these values make their way to EC memory.

These parameters are implemented as quirks along with `ec_micmute` quirk
which controls the micmute LED through ACPI EC interface.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 630 +++++++++++++++++++++++++-----
 1 file changed, 541 insertions(+), 89 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 52fcac5b393a..3f945b4cf115 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -1,32 +1,65 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Huawei WMI hotkeys
+ *  Huawei WMI laptop extras driver
  *
  *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include <linux/wmi.h>
 
 /*
  * Huawei WMI GUIDs
  */
-#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+#define AMW0_METHOD_GUID "ABBC0F5B-8EA1-11D1-A000-C90629100000"
 #define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
 
+/* Legacy GUIDs */
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
+#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+
+/* AMW0_commands */
+
+enum wmaa_cmd {
+	BATTERY_GET, /* \GBTT 0x00001103 */
+	BATTERY_SET, /* \SBTT 0xXXYY1003 */
+	FN_LOCK_GET, /* \GFRS 0x00000604 */
+	FN_LOCK_SET, /* \SFRS 0x000X0704 */
+	MICMUTE_LED, /* \SMLS 0x000X0b04 */
+};
+
+enum fn_state {
+	FN_LOCK_OFF = 0x01,
+	FN_LOCK_ON = 0x02,
+};
+
+struct quirk_entry {
+	bool battery_sleep;
+	bool ec_micmute;
+	bool report_brightness;
+};
 
-struct huawei_wmi_priv {
-	struct input_dev *idev;
+static struct quirk_entry *quirks;
+
+struct huawei_wmi {
 	struct led_classdev cdev;
-	acpi_handle handle;
-	char *acpi_method;
+	struct mutex wmi_lock;
+	struct mutex battery_lock;
+	struct input_dev *idev[2];
+	struct platform_device *pdev;
 };
 
+struct platform_device *huawei_wmi_pdev;
+
 static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
@@ -37,73 +70,183 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
-	// Keyboard backlight
+	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
 	{ KE_END,	 0 }
 };
 
-static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
-		enum led_brightness brightness)
+static bool battery_sleep;
+static bool report_brightness;
+
+module_param(battery_sleep, bool, 0444);
+MODULE_PARM_DESC(battery_sleep,
+		"Delay after setting battery charging thresholds.");
+module_param(report_brightness, bool, 0444);
+MODULE_PARM_DESC(report_brightness,
+		"Report brightness key events.");
+
+/* Quirks */
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
+	quirks = dmi->driver_data;
+	return 1;
+}
+
+static struct quirk_entry quirk_unknown = {
+};
+
+static struct quirk_entry quirk_battery_sleep = {
+	.battery_sleep = true,
+};
+
+static struct quirk_entry quirk_matebook_x = {
+	.ec_micmute = true,
+	.report_brightness = true,
+};
+
+static const struct dmi_system_id huawei_quirks[] = {
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MACH-WX9",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MACH-WX9"),
+		},
+		.driver_data = &quirk_battery_sleep
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Huawei MateBook X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HUAWEI MateBook X")
+		},
+		.driver_data = &quirk_matebook_x
+	},
+	{  }
+};
+
+/* Utils */
+
+static int huawei_wmi_eval(struct device *dev, u8 *arg,
+		u8 *buf, size_t buflen)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in;
+	union acpi_object *obj;
 	acpi_status status;
-	union acpi_object args[3];
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
-
-	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
-	args[1].integer.value = 0x04;
-
-	if (strcmp(priv->acpi_method, "SPIN") == 0) {
-		args[0].integer.value = 0;
-		args[2].integer.value = brightness ? 1 : 0;
-	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
-		args[0].integer.value = 1;
-		args[2].integer.value = brightness ? 0 : 1;
-	} else {
-		return -EINVAL;
+	size_t len;
+	int err = -EIO;
+
+	in.length = sizeof(u8) * 4;
+	in.pointer = (u32 *)arg;
+	mutex_lock(&huawei->wmi_lock);
+	status = wmi_evaluate_method(AMW0_METHOD_GUID, 0, 1, &in, &out);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to evaluate wmi method\n");
+		err = -ENODEV;
+		goto wmi_eval_fail;
+	}
+
+	/* WMAA takes a 4 bytes buffer as an input. It returns a package
+	 * with two buffer elements. The first buffer is 4 bytes long and
+	 * the second is 0x100 (256) bytes long. The first buffer is always
+	 * zeros. The second stores the output from every call. The first
+	 * byte of the second buffer always have the return status of the
+	 * called command.
+	 */
+	obj = out.pointer;
+	if (!obj)
+		goto wmi_eval_fail;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 2) {
+		dev_err(dev, "Unknown response type %d\n", obj->type);
+		goto wmi_eval_fail;
 	}
 
-	status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
-	if (ACPI_FAILURE(status))
-		return -ENXIO;
+	obj = &(obj->package.elements[1]);
+	if (!obj || obj->type != ACPI_TYPE_BUFFER)
+		goto wmi_eval_fail;
 
-	return 0;
+	if (buf) {
+		len = min(buflen, obj->buffer.length);
+		memcpy(buf, obj->buffer.pointer, len);
+	}
+	err = 0;
+
+wmi_eval_fail:
+	mutex_unlock(&huawei->wmi_lock);
+	kfree(out.pointer);
+	return err;
 }
 
-static int huawei_wmi_leds_setup(struct wmi_device *wdev)
+static int huawei_wmi_cmd(struct device *dev, enum wmaa_cmd cmd, u8 *arg,
+		u8 *out, size_t outlen)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
-
-	priv->handle = ec_get_handle();
-	if (!priv->handle)
-		return 0;
+	u8 parm[4] = { 0 };
+	u8 buf[0x100] = { 0xff };
+	int err;
 
-	if (acpi_has_method(priv->handle, "SPIN"))
-		priv->acpi_method = "SPIN";
-	else if (acpi_has_method(priv->handle, "WPIN"))
-		priv->acpi_method = "WPIN";
-	else
-		return 0;
+	if (!arg)
+		arg = parm;
+
+	switch (cmd) {
+	case BATTERY_SET:
+		arg[0] = 0x03;
+		arg[1] = 0x10;
+		break;
+	case BATTERY_GET:
+		arg[0] = 0x03;
+		arg[1] = 0x11;
+		break;
+	case FN_LOCK_GET:
+		arg[0] = 0x04;
+		arg[1] = 0x06;
+		break;
+	case FN_LOCK_SET:
+		arg[0] = 0x04;
+		arg[1] = 0x07;
+		break;
+	case MICMUTE_LED:
+		arg[0] = 0x04;
+		arg[1] = 0x0b;
+		break;
+	default:
+		dev_err(dev, "Unsupported command, got: 0x%08x\n", *(u32 *)arg);
+		return -EINVAL;
+	}
 
-	priv->cdev.name = "platform::micmute";
-	priv->cdev.max_brightness = 1;
-	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
-	priv->cdev.default_trigger = "audio-micmute";
-	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
-	priv->cdev.dev = &wdev->dev;
-	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
+	/* Some models require calling WMAA twice to execute
+	 * a command. We call WMAA and if we get a non-zero return
+	 * status we evaluate WMAA again. If we get another non-zero
+	 * return, we return -EIO. This way we don't need to
+	 * check for return status anywhere we call huawei_wmi_cmd.
+	 */
+	err = huawei_wmi_eval(dev, arg, buf, 0x100);
+	if (err)
+		return err;
+	if (buf[0]) {
+		err = huawei_wmi_eval(dev, arg, buf, 0x100);
+		if (err)
+			return err;
+		if (buf[0]) {
+			dev_err(dev, "Invalid response, got: %d\n", buf[0]);
+			return -EIO;
+		}
+	}
+	if (out)
+		memcpy(out, buf, outlen);
 
-	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
+	return 0;
 }
 
-static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
+/* Input */
+
+static void huawei_wmi_process_key(struct input_dev *idev, int code)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	const struct key_entry *key;
 
 	/*
@@ -127,81 +270,390 @@ static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
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
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
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
+	if (!idev) {
+		dev_err(&huawei_wmi_pdev->dev, "No input_dev\n");
+		return;
+	}
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
+static int huawei_wmi_input_setup(struct platform_device *pdev,
+		struct input_dev **idev)
 {
-	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
 	int err;
 
-	priv->idev = devm_input_allocate_device(&wdev->dev);
-	if (!priv->idev)
+	*idev = devm_input_allocate_device(&pdev->dev);
+	if (!*idev)
 		return -ENOMEM;
 
-	priv->idev->name = "Huawei WMI hotkeys";
-	priv->idev->phys = "wmi/input0";
-	priv->idev->id.bustype = BUS_HOST;
-	priv->idev->dev.parent = &wdev->dev;
+	(*idev)->name = "Huawei WMI hotkeys";
+	(*idev)->phys = "wmi/input0";
+	(*idev)->id.bustype = BUS_HOST;
+	(*idev)->dev.parent = &pdev->dev;
+
+	err = sparse_keymap_setup(*idev, huawei_wmi_keymap, NULL);
+	if (err)
+		return err;
+
+	return input_register_device(*idev);
+}
+
+/* LEDs */
+
+static void huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	/* This is a workaround until the "legacy" interface is implemented. */
+	if (quirks && quirks->ec_micmute) {
+		char *acpi_method;
+		acpi_handle handle;
+		union acpi_object args[3];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		handle = ec_get_handle();
+		if (!handle) {
+			dev_err(led_cdev->dev->parent, "Failed to get EC handle\n");
+			return;
+		}
+
+		args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+		args[1].integer.value = 0x04;
+
+		if (acpi_has_method(handle, "SPIN")) {
+			acpi_method = "SPIN";
+			args[0].integer.value = 0;
+			args[2].integer.value = brightness ? 1 : 0;
+		} else if (acpi_has_method(handle, "WPIN")) {
+			acpi_method = "WPIN";
+			args[0].integer.value = 1;
+			args[2].integer.value = brightness ? 0 : 1;
+		} else {
+			return;
+		}
+
+		acpi_evaluate_object(handle, acpi_method, &arg_list, NULL);
+	} else {
+		u8 arg[] = { 0, 0, brightness, 0 };
+
+		huawei_wmi_cmd(led_cdev->dev->parent, MICMUTE_LED, arg, NULL, NULL);
+	}
+}
+
+static int huawei_wmi_leds_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
 
-	err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
+	huawei->cdev.name = "platform::micmute";
+	huawei->cdev.max_brightness = 1;
+	huawei->cdev.brightness_set = huawei_wmi_micmute_led_set;
+	huawei->cdev.default_trigger = "audio-micmute";
+	huawei->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	huawei->cdev.dev = dev->parent;
+	huawei->cdev.flags = LED_CORE_SUSPENDRESUME;
+
+	return devm_led_classdev_register(dev, &huawei->cdev);
+}
+
+/* Battery protection */
+
+static int huawei_wmi_battery_get(struct device *dev, int *low, int *high)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	u8 ret[0x100] = { 0 };
+	int err, i = 0x100;
+
+	mutex_lock(&huawei->battery_lock);
+	err = huawei_wmi_cmd(dev, BATTERY_GET, NULL, ret, 0x100);
+	mutex_unlock(&huawei->battery_lock);
 	if (err)
 		return err;
 
-	return input_register_device(priv->idev);
+	/* Returned buffer positions battery thresholds either in index
+	 * 3 and 2 or in 2 and 1. 0 reserved for return status. We
+	 * find the first non-zero value.
+	 */
+	while (i > 0 && !ret[i--])
+		;
+	*low = ret[i];
+	*high = ret[i+1];
+
+	return 0;
 }
 
-static int huawei_wmi_probe(struct wmi_device *wdev)
+static int huawei_wmi_battery_set(struct device *dev, int low, int high)
 {
-	struct huawei_wmi_priv *priv;
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	u8 arg[] = { 0, 0, low, high };
 	int err;
 
-	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	/* This is an edge case were some models turn battery protection
+	 * off without changing their thresholds values. We clear the
+	 * values before turning off protection. We need a blocking delay to
+	 * make sure these values make their way to EC.
+	 */
+	if (low == 0 && high == 100)
+		huawei_wmi_battery_set(dev, 0, 0);
 
-	dev_set_drvdata(&wdev->dev, priv);
+	mutex_lock(&huawei->battery_lock);
+	err = huawei_wmi_cmd(dev, BATTERY_SET, arg, NULL, NULL);
+	if (quirks && quirks->battery_sleep)
+		msleep(1000);
+	mutex_unlock(&huawei->battery_lock);
 
-	err = huawei_wmi_input_setup(wdev);
+	return err;
+}
+
+/* Fn lock */
+
+static int huawei_wmi_fn_lock_get(struct device *dev, int *on)
+{
+	u8 ret[0x100] = { 0 };
+	int err, i = 0;
+
+	err = huawei_wmi_cmd(dev, FN_LOCK_GET, NULL, ret, 0x100);
 	if (err)
 		return err;
 
-	return huawei_wmi_leds_setup(wdev);
+	/* Find the first non-zero value */
+	while (i <= 0x100 && !ret[i++])
+		;
+	*on = (ret[i-1] == FN_LOCK_OFF) ? 0 : 1;
+
+	return 0;
 }
 
-static const struct wmi_device_id huawei_wmi_id_table[] = {
-	{ .guid_string = WMI0_EVENT_GUID },
-	{ .guid_string = AMW0_EVENT_GUID },
-	{  }
+static int huawei_wmi_fn_lock_set(struct device *dev, int on)
+{
+	u8 arg[] = { 0, 0, (on) ? FN_LOCK_ON : FN_LOCK_OFF, 0 };
+
+	return huawei_wmi_cmd(dev, FN_LOCK_SET, arg, NULL, NULL);
+}
+
+/* sysfs */
+
+static ssize_t charge_thresholds_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int low, high, err;
+
+	if (sscanf(buf, "%d %d", &low, &high) != 2 ||
+			low < 0 || high > 100 ||
+			low > high)
+		return -EINVAL;
+
+	err = huawei_wmi_battery_set(dev, low, high);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t fn_lock_state_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int on, err;
+
+	if (kstrtoint(buf, 10, &on) ||
+			on < 0 || on > 1)
+		return -EINVAL;
+
+	err = huawei_wmi_fn_lock_set(dev, on);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_thresholds_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, low = -1, high = -1;
+
+	err = huawei_wmi_battery_get(dev, &low, &high);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d %d\n", low, high);
+}
+
+static ssize_t fn_lock_state_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, on = -1;
+
+	err = huawei_wmi_fn_lock_get(dev, &on);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", on);
+}
+
+static DEVICE_ATTR_RW(charge_thresholds);
+static DEVICE_ATTR_RW(fn_lock_state);
+
+static struct attribute *huawei_wmi_attrs[] = {
+	&dev_attr_charge_thresholds.attr,
+	&dev_attr_fn_lock_state.attr,
+	NULL
+};
+
+static const struct attribute_group huawei_wmi_group = {
+	.attrs = huawei_wmi_attrs
 };
 
-static struct wmi_driver huawei_wmi_driver = {
+/* Huawei driver */
+
+static int huawei_wmi_probe(struct platform_device *pdev)
+{
+	struct huawei_wmi *huawei;
+	int err;
+
+	huawei = devm_kzalloc(&pdev->dev, sizeof(struct huawei_wmi), GFP_KERNEL);
+	if (!huawei)
+		return -ENOMEM;
+
+	huawei->pdev = pdev;
+	dev_set_drvdata(&pdev->dev, huawei);
+
+	if (wmi_has_guid(WMI0_EVENT_GUID)) {
+		err = huawei_wmi_input_setup(pdev, &huawei->idev[0]);
+		if (err)
+			dev_err(&pdev->dev, "Failed to setup input device\n");
+		err = wmi_install_notify_handler(WMI0_EVENT_GUID,
+				huawei_wmi_input_notify, huawei->idev[0]);
+		if (err)
+			dev_err(&pdev->dev, "Failed to install notify handler\n");
+	}
+
+	if (wmi_has_guid(AMW0_EVENT_GUID)) {
+		err = huawei_wmi_input_setup(pdev, &huawei->idev[1]);
+		if (err)
+			dev_err(&pdev->dev, "Failed to setup input device\n");
+		err = wmi_install_notify_handler(AMW0_EVENT_GUID,
+				huawei_wmi_input_notify, huawei->idev[1]);
+		if (err)
+			dev_err(&pdev->dev, "Failed to install notify handler\n");
+	}
+
+	if (wmi_has_guid(AMW0_METHOD_GUID)) {
+
+		mutex_init(&huawei->wmi_lock);
+		mutex_init(&huawei->battery_lock);
+
+		err = sysfs_create_group(&pdev->dev.kobj, &huawei_wmi_group);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to create sysfs interface\n");
+			return err;
+		}
+
+		err = huawei_wmi_leds_setup(&pdev->dev);
+		if (err)
+			dev_err(&pdev->dev, "Failed to setup leds\n");
+	}
+
+	return 0;
+}
+
+static int huawei_wmi_remove(struct platform_device *pdev)
+{
+	if (wmi_has_guid(WMI0_EVENT_GUID))
+		wmi_remove_notify_handler(WMI0_EVENT_GUID);
+
+	if (wmi_has_guid(AMW0_EVENT_GUID))
+		wmi_remove_notify_handler(AMW0_EVENT_GUID);
+
+	if (wmi_has_guid(AMW0_METHOD_GUID))
+		sysfs_remove_group(&pdev->dev.kobj, &huawei_wmi_group);
+
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
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	quirks->battery_sleep |= battery_sleep;
+	quirks->report_brightness |= report_brightness;
+
+	err = platform_driver_register(&huawei_wmi_driver);
+	if (err) {
+		pr_err("Failed to register platform driver\n");
+		return err;
+	}
+
+	huawei_wmi_pdev = platform_device_register_simple("huawei-wmi", -1, NULL, 0);
+	if (IS_ERR(huawei_wmi_pdev)) {
+		pr_err("Failed to register platform device\n");
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
+MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
+MODULE_ALIAS("wmi:"AMW0_METHOD_GUID);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
-MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

