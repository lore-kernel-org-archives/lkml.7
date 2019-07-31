Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE33C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3472067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTPOIKUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfGaRx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:28 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41011 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfGaRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:25 -0400
Received: by mail-yw1-f68.google.com with SMTP id i138so25269678ywg.8;
        Wed, 31 Jul 2019 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdPbODA0z2TZ5tYy71TYwrIsVN8PGj8ecEakmSP6UzE=;
        b=vTPOIKUkH6041laPC7baGx/L3DTOzOF/jHi9HXRZA+hCqKelK9HUgyKJQx0Tv0qwo7
         4g+K/zvRYtyivGkK5tT8o5eJWaLz266a4GYjAixrnMIFhLz2OeW4fNgPbiEcwvY04yMN
         oLCdeGejYE0VZ6G/kdnKQg6XO/jIBqbtbtNF40i9+aOL7MdWoKZTOIJWYaEz93+101cV
         GZ/ADDdV1mn5gxQUUIYrMBG+TCKRXQvOqwBv0FAwf3SvZCPNaggRsRwyreFbv86GEaDD
         K/rlVFx4SQeOAz7ir0FqnMppfceq62hEQYQKp9Jec5RiB5k2WMaU/0xz1HfgoU11V97Z
         KQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdPbODA0z2TZ5tYy71TYwrIsVN8PGj8ecEakmSP6UzE=;
        b=B1kgj2vt0f580grNiUXf3YV4Gch/tkss8xLl79TF3/+flLPldFJJ0Cf62h5d21o1Rp
         60KBScwPDKdxVyLzqCGrusCWQ1HvVC2mIzdk2M9JxyoZ+RcZ9xGj3fyIRv8z8fqiFq1m
         oWJEwHSbtk/Fvtnog/0ADDIt8rojhwDc/+Tkf509qgZPb8N6uXmuAxikIpVLH5IMd2wC
         u6KGCxXbIMWTE7zISxWUQvJr8tk6nIu9rizc9MqoWN0G/l2o5bIZnUCnXLKm23zgKp9t
         fm+XVwiMr4OhHe3lk3eNte+zx5zgkoXnic/FNQCtSlbgYUqg6uL/nP9C9EqvyA1S/VyL
         40wA==
X-Gm-Message-State: APjAAAWZdSlBlvn6tgXajmaXUYtKZ1B9TN3jfL0OYc/T/q5u/ZDJjtea
        FTdxEJVgTVMG0QiyayVpZ35irP0=
X-Google-Smtp-Source: APXvYqzWs//VXf/O6rc1PgbiaDnArGR2YEtvTtEcwGVVyAIBOoLbgaE6rgwihyNWsO4rqa1oe8mQhg==
X-Received: by 2002:a81:230a:: with SMTP id j10mr75078006ywj.259.1564595604273;
        Wed, 31 Jul 2019 10:53:24 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:23 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 3/9] platform/x86: huawei-wmi: Implement huawei wmi management interface
Date:   Wed, 31 Jul 2019 13:52:49 -0400
Message-Id: <20190731175255.25676-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
References: <20190731175255.25676-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huawei Matebook laptops come with a WMI management interface that can
control various aspects of the device. This interface is also found on
the old Matebook X released in 2017.

Implement basic functionality of this interface along with supported
command IDs that are implemented in this series.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 130 ++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 12cae450fc1f..27520b0f8956 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -10,24 +10,36 @@
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
 
 struct huawei_wmi_priv {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	acpi_handle handle;
 	char *acpi_method;
+	struct mutex wmi_lock;
 	struct platform_device *pdev;
 };
 
@@ -50,6 +62,116 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+/* Utils */
+
+static int huawei_wmi_call(struct device *dev, struct acpi_buffer *in,
+		struct acpi_buffer *out)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
+	acpi_status status;
+
+	mutex_lock(&priv->wmi_lock);
+	status = wmi_evaluate_method(HWMI_METHOD_GUID, 0, 1, in, out);
+	mutex_unlock(&priv->wmi_lock);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to evaluate wmi method\n");
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
+static int huawei_wmi_cmd(struct device *dev, u64 arg, u8 *buf, size_t buflen)
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
+		err = huawei_wmi_call(dev,  &in, &out);
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
+				dev_err(dev, "Bad buffer length, got %d\n", obj->buffer.length);
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
+				dev_err(dev, "Bad package count, got %d\n", obj->package.count);
+				err = -EIO;
+				goto fail_cmd;
+			}
+
+			obj = &obj->package.elements[1];
+			if (obj->type != ACPI_TYPE_BUFFER) {
+				dev_err(dev, "Bad package element type, got %d\n", obj->type);
+				err = -EIO;
+				goto fail_cmd;
+			}
+			len = obj->buffer.length;
+
+			break;
+		/* Shouldn't get here! */
+		default:
+			dev_err(dev, "Unexpected obj type, got: %d\n", obj->type);
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
 /* LEDs */
 
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
@@ -222,6 +344,10 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		mutex_init(&priv->wmi_lock);
+	}
+
 	return huawei_wmi_leds_setup(&pdev->dev);
 }
 
@@ -233,6 +359,9 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	if (wmi_has_guid(HWMI_EVENT_GUID))
 		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
+	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+	}
+
 	return 0;
 }
 
@@ -272,6 +401,7 @@ module_exit(huawei_wmi_exit);
 
 MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
 MODULE_ALIAS("wmi:"HWMI_EVENT_GUID);
+MODULE_ALIAS("wmi:"HWMI_METHOD_GUID);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1


