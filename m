Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1CCC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD020882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCdwP4H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfISA4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:56:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34037 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfISA4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:56:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id h73so666567ywa.1;
        Wed, 18 Sep 2019 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/bNZabNGLHB87Rzq5DTh/axmlVusQyTfuEgOsN7+REI=;
        b=GCdwP4H/CTyz2DhEReoNf3F6sz+X5lkmJudqdy04dZ9+Kr0msDbnHOf+LT9kLAsqbL
         0cAbK3EocSwIqr22J62okksLaQFsVoKj/Lnkz8CDkLOJ2pM7KXkkbZKYtRMibxtCG6bs
         kCSSjQ42Z++TQFZnVCKc6h+5UreYIk4suddnv38PapN/ZZ1FTbpNwyfY6xmHCiYDDmBP
         FFQbSzZ3WBrhrs0nQniveNHqWg0H3Z1Xp+EBIlwUNyeqAFAfJEhFJe1zMPKauFiUw8fo
         i3voWCNSnT625m0x6ZumJtAAvo4BuftFAvhEaLhTsaU5d9BFP+OC1VwcOyTisaiMbhAo
         bDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bNZabNGLHB87Rzq5DTh/axmlVusQyTfuEgOsN7+REI=;
        b=i61rYLjZjtg3tsg+7vUDO7PcTGd1n2l49Q0zzQy+mMFmhr2vTQs+/uzxLI09EnqYmC
         pg4Zmee7f8Sgk2BnH7bZFyNBQGDnKGaX1RLF9ITPtbCR4WEbxmR61gGHoBlK+7bSKGoG
         /i3w8FjkYovtK6Gu/hAjo/dfjdU6MEdHG33RzSLBAx4JcaFX6kbPtLfn2DljTY2OeUXz
         sccyHx9RTTsmZ8BLSerGe0KkIKD5aYx7VHfgzLSu89WMby8yTTMh0Nt/10LbnAFlIV8/
         p2t2yH4HCRLd2/tYpQ68usf4V1jXbgvIMBuvWszifNNyC3skb2t76ZeFP1TJhriZ405c
         MqiA==
X-Gm-Message-State: APjAAAVzgxAqbcB3f8N7kx1xDLGPEtSnp2oz7xEvXTpfJ1bTD73c1ntH
        GsdIqdc8IdxrseB5I5d7pQ==
X-Google-Smtp-Source: APXvYqz2yMmiBjtamFO+yV/mpktguTsyvRMaf7w5xxspud7Qqo43wNqOoSlHYgZD9TPOMz60yAfwGQ==
X-Received: by 2002:a0d:d850:: with SMTP id a77mr5552670ywe.90.1568854567198;
        Wed, 18 Sep 2019 17:56:07 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id u69sm1692475ywu.93.2019.09.18.17.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:56:06 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] platform/x86: huawei-wmi: Implement huawei wmi management
Date:   Wed, 18 Sep 2019 20:54:55 -0400
Message-Id: <20190919005505.23822-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919005505.23822-1-ayman.bagabas@gmail.com>
References: <20190919005505.23822-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huawei Matebook laptops come with a WMI management interface that can
control various aspects of the device. This interface is also found on
the old Matebook X released in 2017.

Use that to control the mic mute LED.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 217 +++++++++++++++++++++++++-----
 1 file changed, 180 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 97ff3d868765..904ef38944b6 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -11,18 +11,35 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/wmi.h>
 
 /*
  * Huawei WMI GUIDs
  */
+#define HWMI_METHOD_GUID "ABBC0F5B-8EA1-11D1-A000-C90629100000"
 #define HWMI_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
 
 /* Legacy GUIDs */
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
 #define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
 
+/* HWMI commands */
+
+enum {
+	BATTERY_THRESH_GET		= 0x00001103, /* \GBTT */
+	BATTERY_THRESH_SET		= 0x00001003, /* \SBTT */
+	FN_LOCK_GET			= 0x00000604, /* \GFRS */
+	FN_LOCK_SET			= 0x00000704, /* \SFRS */
+	MICMUTE_LED_SET			= 0x00000b04, /* \SMLS */
+};
+
+union hwmi_arg {
+	u64 cmd;
+	u8 args[8];
+};
+
 struct quirk_entry {
 	bool battery_reset;
 	bool ec_micmute;
@@ -41,8 +58,8 @@ struct huawei_wmi {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
-	acpi_handle handle;
-	char *acpi_method;
+
+	struct mutex wmi_lock;
 };
 
 struct huawei_wmi *huawei_wmi;
@@ -116,52 +133,168 @@ static const struct dmi_system_id huawei_quirks[] = {
 	{  }
 };
 
+/* Utils */
+
+static int huawei_wmi_call(struct acpi_buffer *in, struct acpi_buffer *out)
+{
+	acpi_status status;
+
+	mutex_lock(&huawei_wmi->wmi_lock);
+	status = wmi_evaluate_method(HWMI_METHOD_GUID, 0, 1, in, out);
+	mutex_unlock(&huawei_wmi->wmi_lock);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&huawei_wmi->pdev->dev, "Failed to evaluate wmi method\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/* HWMI takes a 64 bit input and returns either a package with 2 buffers, one of
+ * 4 bytes and the other of 256 bytes, or one buffer of size 0x104 (260) bytes.
+ * The first 4 bytes are ignored, we ignore the first 4 bytes buffer if we got a
+ * package, or skip the first 4 if a buffer of 0x104 is used. The first byte of
+ * the remaining 0x100 sized buffer has the return status of every call. In case
+ * the return status is non-zero, we return -ENODEV but still copy the returned
+ * buffer to the given buffer parameter (buf).
+ */
+static int huawei_wmi_cmd(u64 arg, u8 *buf, size_t buflen)
+{
+	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer in;
+	union acpi_object *obj;
+	size_t len;
+	int err, i;
+
+	in.length = sizeof(arg);
+	in.pointer = &arg;
+
+	/* Some models require calling HWMI twice to execute a command. We evaluate
+	 * HWMI and if we get a non-zero return status we evaluate it again.
+	 */
+	for (i = 0; i < 2; i++) {
+		err = huawei_wmi_call(&in, &out);
+		if (err)
+			goto fail_cmd;
+
+		obj = out.pointer;
+		if (!obj) {
+			err = -EIO;
+			goto fail_cmd;
+		}
+
+		switch (obj->type) {
+		/* Models that implement both "legacy" and HWMI tend to return a 0x104
+		 * sized buffer instead of a package of 0x4 and 0x100 buffers.
+		 */
+		case ACPI_TYPE_BUFFER:
+			if (obj->buffer.length == 0x104) {
+				// Skip the first 4 bytes.
+				obj->buffer.pointer += 4;
+				len = 0x100;
+			} else {
+				dev_err(&huawei_wmi->pdev->dev, "Bad buffer length, got %d\n", obj->buffer.length);
+				err = -EIO;
+				goto fail_cmd;
+			}
+
+			break;
+		/* HWMI returns a package with 2 buffer elements, one of 4 bytes and the
+		 * other is 256 bytes.
+		 */
+		case ACPI_TYPE_PACKAGE:
+			if (obj->package.count != 2) {
+				dev_err(&huawei_wmi->pdev->dev, "Bad package count, got %d\n", obj->package.count);
+				err = -EIO;
+				goto fail_cmd;
+			}
+
+			obj = &obj->package.elements[1];
+			if (obj->type != ACPI_TYPE_BUFFER) {
+				dev_err(&huawei_wmi->pdev->dev, "Bad package element type, got %d\n", obj->type);
+				err = -EIO;
+				goto fail_cmd;
+			}
+			len = obj->buffer.length;
+
+			break;
+		/* Shouldn't get here! */
+		default:
+			dev_err(&huawei_wmi->pdev->dev, "Unexpected obj type, got: %d\n", obj->type);
+			err = -EIO;
+			goto fail_cmd;
+		}
+
+		if (!*obj->buffer.pointer)
+			break;
+	}
+
+	err = (*obj->buffer.pointer) ? -ENODEV : 0;
+
+	if (buf) {
+		len = min(buflen, len);
+		memcpy(buf, obj->buffer.pointer, len);
+	}
+
+fail_cmd:
+	kfree(out.pointer);
+	return err;
+}
+
+/* LEDs */
+
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
-	struct huawei_wmi *huawei = dev_get_drvdata(led_cdev->dev->parent);
-	acpi_status status;
-	union acpi_object args[3];
-	struct acpi_object_list arg_list = {
-		.pointer = args,
-		.count = ARRAY_SIZE(args),
-	};
-
-	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
-	args[1].integer.value = 0x04;
-
-	if (strcmp(huawei->acpi_method, "SPIN") == 0) {
-		args[0].integer.value = 0;
-		args[2].integer.value = brightness ? 1 : 0;
-	} else if (strcmp(huawei->acpi_method, "WPIN") == 0) {
-		args[0].integer.value = 1;
-		args[2].integer.value = brightness ? 0 : 1;
+	/* This is a workaround until the "legacy" interface is implemented. */
+	if (quirks && quirks->ec_micmute) {
+		char *acpi_method;
+		acpi_handle handle;
+		acpi_status status;
+		union acpi_object args[3];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		handle = ec_get_handle();
+		if (!handle)
+			return -ENODEV;
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
+			return -ENODEV;
+		}
+
+		status = acpi_evaluate_object(handle, acpi_method, &arg_list, NULL);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		return 0;
 	} else {
-		return -EINVAL;
-	}
+		union hwmi_arg arg;
 
-	status = acpi_evaluate_object(huawei->handle, huawei->acpi_method, &arg_list, NULL);
-	if (ACPI_FAILURE(status))
-		return -ENXIO;
+		arg.cmd = MICMUTE_LED_SET;
+		arg.args[2] = brightness;
 
-	return 0;
+		return huawei_wmi_cmd(arg.cmd, NULL, NULL);
+	}
 }
 
 static void huawei_wmi_leds_setup(struct device *dev)
 {
 	struct huawei_wmi *huawei = dev_get_drvdata(dev);
 
-	huawei->handle = ec_get_handle();
-	if (!huawei->handle)
-		return;
-
-	if (acpi_has_method(huawei->handle, "SPIN"))
-		huawei->acpi_method = "SPIN";
-	else if (acpi_has_method(huawei->handle, "WPIN"))
-		huawei->acpi_method = "WPIN";
-	else
-		return;
-
 	huawei->cdev.name = "platform::micmute";
 	huawei->cdev.max_brightness = 1;
 	huawei->cdev.brightness_set_blocking = &huawei_wmi_micmute_led_set;
@@ -264,6 +397,7 @@ static void huawei_wmi_input_exit(struct device *dev, const char *guid)
 
 static const struct wmi_device_id huawei_wmi_events_id_table[] = {
 	{ .guid_string = WMI0_EVENT_GUID },
+	{ .guid_string = HWMI_EVENT_GUID },
 	{  }
 };
 
@@ -290,7 +424,12 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		guid++;
 	}
 
-	huawei_wmi_leds_setup(&pdev->dev);
+	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		mutex_init(&huawei_wmi->wmi_lock);
+
+		huawei_wmi_leds_setup(&pdev->dev);
+	}
+
 	return 0;
 }
 
@@ -305,6 +444,9 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 		guid++;
 	}
 
+	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+	}
+
 	return 0;
 }
 
@@ -358,6 +500,7 @@ static __exit void huawei_wmi_exit(void)
 module_init(huawei_wmi_init);
 module_exit(huawei_wmi_exit);
 
+MODULE_ALIAS("wmi:"HWMI_METHOD_GUID);
 MODULE_DEVICE_TABLE(wmi, huawei_wmi_events_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
-- 
2.21.0

