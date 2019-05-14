Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90632C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621A620881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJPtOyES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfENTBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:01:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55977 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:01:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so170338wmb.5;
        Tue, 14 May 2019 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yKJtRNLjUlsE2AHcVMIA1x07TU3dSlb+s1DhsyS3+wE=;
        b=iJPtOyESOdvx9dnZIhnOoGHJy0PYv+xOrJEg5/QfqQuGBvfiuepkt7Zu3dmXEA58Ef
         wpq1aXA5AEYjRQpu/i4NjYlMZ9x+9+Ukzlo5f4OgIfnOAHjyjIeODV2zSqCqvqH6xZrg
         Gdqa/Bm73NZli+seeDAvdqDYYCGoZ9WpwN5gGYwIZYiVQDPUNkM0lCGXbEk0pLZTDDzb
         8oC9Sb6myG8oYripgTZUJUZGEGHYqLrB8pk73D2SkxP3PxGWuT+NhTkAjQBJXnmauN8/
         8QHY8svdTpYIGrvb3K/qe+cuSeT6M/wgUIslnm8mDNadJ7peGWUNyQhdMAxtt0oONvOw
         Vh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKJtRNLjUlsE2AHcVMIA1x07TU3dSlb+s1DhsyS3+wE=;
        b=IlDr1gaUp+vSZ/CQMEtORuqOMhxgc80sumWr+EVywfoYFwVL7mhb7FM3P5xKJvf4/9
         zLkLa/A9l17xsUoH4oeJDOZ0nIGIA0+RZjWTwqWGk8+oCDn3cuEicBZM9WQ2xoANNhkY
         49WTzwCii6UbB83yH9k6mNfb6A02Z3Sa0s+oi6Jhl4pTcqpO1Qsma+Jn7rfYdKxzQpda
         7H6FB+Tis4SebGOWBKTzBxHGZXRCp9jIPlCLZZan/V4FEmP86iG23qdDOdWjn9niqbYR
         Cs5riSiunhRb3BVJy1SGaSpGKlmX9qjNfFq+Tf/JITzdb7MJ6ap6sWmDxfTvy7Cclo9q
         l8zA==
X-Gm-Message-State: APjAAAXVF5LfMAxc8vxTqeODi+j6kFh5jkCtLYEp9JDWiJEwH19+NXjX
        5GrbB9lEUnfZTDmHGWzjZ0A7Vocr
X-Google-Smtp-Source: APXvYqzoxI6X6dueMRlGpARdmg4YhJtdbP6LCeRQwDtlyNLOa+h3wXxUIh03CMQvg25fem92RzzWhw==
X-Received: by 2002:a1c:3c2:: with SMTP id 185mr3024200wmd.91.1557860487478;
        Tue, 14 May 2019 12:01:27 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id z13sm2565466wrw.42.2019.05.14.12.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:01:27 -0700 (PDT)
Subject: [PATCH v4 06/13] platform/x86: asus-wmi: Refactor WMI event handling
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <6a62a746-6c0d-e786-1edc-febbfc083a64@gmail.com>
Date:   Tue, 14 May 2019 21:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor WMI event handling into separate functions for getting the event
code and handling the retrieved event code as a preparation for
introduction of WMI event queue support.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 66 +++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5bdb4ffdbee3..ed7c7857012e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -85,6 +85,8 @@ MODULE_LICENSE("GPL");
 
 #define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
 
+#define WMI_EVENT_MASK			0xFFFF
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static bool ashs_present(void)
@@ -1651,83 +1653,99 @@ static void asus_wmi_fnlock_update(struct asus_wmi *asus)
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
 }
 
-static void asus_wmi_notify(u32 value, void *context)
+static int asus_wmi_get_event_code(u32 value)
 {
-	struct asus_wmi *asus = context;
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	acpi_status status;
 	int code;
-	int orig_code;
-	unsigned int key_value = 1;
-	bool autorelease = 1;
 
 	status = wmi_get_event_data(value, &response);
-	if (status != AE_OK) {
-		pr_err("bad event status 0x%x\n", status);
-		return;
+	if (ACPI_FAILURE(status)) {
+		pr_warn("Failed to get WMI notify code: %s\n",
+				acpi_format_exception(status));
+		return -EIO;
 	}
 
 	obj = (union acpi_object *)response.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_INTEGER)
-		goto exit;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		code = (int)(obj->integer.value & WMI_EVENT_MASK);
+	else
+		code = -EIO;
+
+	kfree(obj);
+	return code;
+}
+
+static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
+{
+	int orig_code;
+	unsigned int key_value = 1;
+	bool autorelease = 1;
 
-	code = obj->integer.value;
 	orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
 					 &autorelease);
 		if (code == ASUS_WMI_KEY_IGNORE)
-			goto exit;
+			return;
 	}
 
 	if (code >= NOTIFY_BRNUP_MIN && code <= NOTIFY_BRNUP_MAX)
 		code = ASUS_WMI_BRN_UP;
-	else if (code >= NOTIFY_BRNDOWN_MIN &&
-		 code <= NOTIFY_BRNDOWN_MAX)
+	else if (code >= NOTIFY_BRNDOWN_MIN && code <= NOTIFY_BRNDOWN_MAX)
 		code = ASUS_WMI_BRN_DOWN;
 
 	if (code == ASUS_WMI_BRN_DOWN || code == ASUS_WMI_BRN_UP) {
 		if (acpi_video_get_backlight_type() == acpi_backlight_vendor) {
 			asus_wmi_backlight_notify(asus, orig_code);
-			goto exit;
+			return;
 		}
 	}
 
 	if (code == NOTIFY_KBD_BRTUP) {
 		kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
-		goto exit;
+		return;
 	}
 	if (code == NOTIFY_KBD_BRTDWN) {
 		kbd_led_set_by_kbd(asus, asus->kbd_led_wk - 1);
-		goto exit;
+		return;
 	}
 	if (code == NOTIFY_KBD_BRTTOGGLE) {
 		if (asus->kbd_led_wk == asus->kbd_led.max_brightness)
 			kbd_led_set_by_kbd(asus, 0);
 		else
 			kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
-		goto exit;
+		return;
 	}
 
 	if (code == NOTIFY_FNLOCK_TOGGLE) {
 		asus->fnlock_locked = !asus->fnlock_locked;
 		asus_wmi_fnlock_update(asus);
-		goto exit;
+		return;
 	}
 
-	if (is_display_toggle(code) &&
-	    asus->driver->quirks->no_display_toggle)
-		goto exit;
+	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
+		return;
 
 	if (!sparse_keymap_report_event(asus->inputdev, code,
 					key_value, autorelease))
 		pr_info("Unknown key %x pressed\n", code);
+}
 
-exit:
-	kfree(obj);
+static void asus_wmi_notify(u32 value, void *context)
+{
+	struct asus_wmi *asus = context;
+	int code = asus_wmi_get_event_code(value);
+
+	if (code < 0) {
+		pr_warn("Failed to get notify code: %d\n", code);
+		return;
+	}
+
+	asus_wmi_handle_event_code(code, asus);
 }
 
 /*
-- 
2.17.1

