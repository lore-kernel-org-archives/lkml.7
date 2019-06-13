Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D2DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158C720665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgEVGNyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404446AbfFMQxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46648 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbfFMDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:04:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id p8so7189182ybo.13;
        Wed, 12 Jun 2019 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ki2D2489PS85Mw+OS3eiSgqoQG8BdIGhGbAH8PhBaTk=;
        b=WgEVGNyOzjz+qKInfXs9knL0X9RGoA4LC/YeP2WzGI2Ib0nrvhh63OlpPORlxnh1GB
         W7oH0YpL67lrV0LKWhJHWDg80dXjgj0nwqh4YQKhKauUTcYm1DX+VJoYm2uJNLZdiEeP
         tJIjSbU6lb+F/cA6GPQDXgLpwa3DSX8ITd/4m7lnrBudBlBAyEg0VHPx0S7RKn5JVoql
         cQxYiG7ZCRZzuYutXn9xLMYYv7OjV0vbOyV1dc59/JgBXZGXY/uLOZVGptD3TLB16/Ge
         p8qpm30sK4BW3QTT3/DePhmuGJLgZ3sBHzg6NuXVPw8KhK6ShTBd3m5GzYElPl7TL7jY
         VIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ki2D2489PS85Mw+OS3eiSgqoQG8BdIGhGbAH8PhBaTk=;
        b=ltuCoxpKrm0MmXrroWQitUhHD9hl+8KEtrp/qSf+InO3LEZqZfpO55MVCO2AZdFjMX
         PcIjERDk/2SCLu60Fc7yeSHdDZI70czeALReYUJku9sw8DOGZ2Cz8uxtO96IXd40BlMK
         Px2HVGHMAP57GOG2D5LmxxtxDO4EVuLt9aBhBOsA15UX0/g10C8io+5u9598zHuovHzs
         2bz+jtex7g6xM6wH01+VWtLnSwo4IecorsgxNPfBTcJYddITnkCRGmQ/Qr34SdVhWruA
         RkwUOGzWkzGcA4mVcQnoGqBxw/e6T2HYjsrUHx0/qA7k4fUxi6gBFaHuuLqy2/OnyDCV
         qQkg==
X-Gm-Message-State: APjAAAVdpQgXnewjozLoGm1o07tn5W8aGwM3aQbvtBM1CPPH0P3KlF3r
        PQIMLlT5Z1L39IDim5qV+w==
X-Google-Smtp-Source: APXvYqz7xuFPoZJ4rT70/zjIe43JLm8aduIypeLy3RbluurBb9OLlVitn12gnM54R6xndHOB96YvtA==
X-Received: by 2002:a25:83c7:: with SMTP id v7mr40085247ybm.345.1560395096377;
        Wed, 12 Jun 2019 20:04:56 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:04:55 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 2/8] platform/x86: huawei-wmi: implement WMI management interface
Date:   Wed, 12 Jun 2019 23:04:09 -0400
Message-Id: <20190613030416.25807-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces a WMI BIOS interface that can control various
device features like micmute LED, battery charging thresholds, and
fn-lock. This interface, with device UID of HWMI, is found on recent and
old models including MateBook X released in 2017. This model is kind of
"special" since it has two WMI interfaces, this interface and what we
call it the "legacy" interface. Due to lack of hardware and testers,
this "legacy" interface is not "fully" implemented yet. This "legacy"
interface supports setting the micmute LED for MateBook X (2017).

This device, HWMI, has only one method that takes a 64 bit argument and
returns a package with two elements, the first is 4 bytes and the second
is 256 bytes. The first 4 bytes are always skipped since they return
zero all the time. MateBook X (2017) is a bit different
where it takes 64 bit argument but returns one 260 byte buffer (265+4).
Right now, this interface doesn't offer any usability for MateBook X
(2017) except for fn-lock and debugfs.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 4a9e14d3b705..37b09d497f5e 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -10,22 +10,35 @@
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
 
+/* HWMI_commands */
+
+enum {
+	BATTERY_THRESH_GET 		= 0x00001103, /* \GBTT */
+	BATTERY_THRESH_SET 		= 0x00001003, /* \SBTT */
+	FAN_SPEED_GET			= 0x00000802, /* \GFNS */
+	FN_LOCK_GET				= 0x00000604, /* \GFRS */
+	FN_LOCK_SET 			= 0x00000704, /* \SFRS */
+	MICMUTE_LED_SET 		= 0x00000b04, /* \SMLS */
+};
 
 struct huawei_wmi {
 	struct led_classdev cdev;
 	struct input_dev *idev[2];
+	struct mutex wmi_lock;
 	struct platform_device *pdev;
 };
 
@@ -48,6 +61,118 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+/* Utils */
+
+static int huawei_wmi_call(struct device *dev, struct acpi_buffer *in,
+		struct acpi_buffer *out)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	acpi_status status;
+
+	mutex_lock(&huawei->wmi_lock);
+	status = wmi_evaluate_method(HWMI_METHOD_GUID, 0, 1, in, out);
+	mutex_unlock(&huawei->wmi_lock);
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
+	in.length = sizeof(u64);
+	in.pointer = &arg;
+
+	/* Some models require calling HWMI twice to execute a command. We evaluate
+	 * HWMI and if we get a non-zero return status we evaluate it again.
+	 */
+	for (i = 0; i < 2; i++) {
+		err = huawei_wmi_call(dev,  &in, &out);
+		if (err) {
+			goto fail_cmd;
+		}
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
+		if (!*obj->buffer.pointer) {
+			break;
+		}
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
@@ -222,6 +347,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		mutex_init(&huawei->wmi_lock);
 		err = huawei_wmi_leds_setup(&pdev->dev);
 		if (err)
 			dev_err(&pdev->dev, "Failed to setup leds\n");
@@ -279,6 +405,7 @@ module_exit(huawei_wmi_exit);
 
 MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
 MODULE_ALIAS("wmi:"HWMI_EVENT_GUID);
+MODULE_ALIAS("wmi:"HWMI_METHOD_GUID);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

