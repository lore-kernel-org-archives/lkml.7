Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8530C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EACC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riuXydw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfDSSrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33979 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfDSSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:47:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so9485436wmf.1;
        Fri, 19 Apr 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9GOWv/O3l597N/qj/ikOGyIb8Gy6jzCldfYlQgtg5H0=;
        b=riuXydw94ehoRb/fU1dhiDapPonMwPK1yQTfksbKk5crfupxSIMWKdG9aEUzC8NEGu
         Ap6Zyxzv/trOPtq9AeMjdgw3owuMYj/4cqg9ezcCdG9qDJdJyjBeZKSKKlwgclL+xhiP
         rl2Skk3bc+5asIWYgCEAWyRHacvp7akWV/UEfDGeUCejnT4NnzHKKn8/WrC0/16RtBf1
         nUj2ryxrnaqlSZ8i80n9Kby7eQIq5NYaZrMzRbD5s5/Fwz2RTtpM6MrlCAmK3vGY883v
         iGPCAvXufozjg8H4yd2G0sCn2gT8hanPHnwDuO6HxcvGS2f8ZomkvNJPXAKdlog2W63O
         tq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GOWv/O3l597N/qj/ikOGyIb8Gy6jzCldfYlQgtg5H0=;
        b=UP1uQ474XTAcwj9jcoMM6cRIT6d+q9yAkJ2bHA++9VLrMvK4FYfS2XHs688OHasfKA
         5s54V17ZuTX7Nf5hXJtuJr2mm5KVhxMSU94ZZx00L9xQeXFIUQTDCPOL9+AF7cJL1Zlz
         JPb3KiiCdTIM4lfMLCvj8hJZMJJO5uSRTkQBTAh0pJvqmGMRNAe0jCztuUx3XxREcGim
         qQrWJwST37Q1f/CAKB6c8FXmYLzP/STFhYYdLKEZ5CZzDfWDFANv7FZhyx4V/ohhF8ab
         LbHUA0JVW7YyjL3K5L8+0UYxn5SgDkK+w60USw54AQDB5BXbxaMYl2q4UoKFZ6KZP86L
         1nJg==
X-Gm-Message-State: APjAAAVJlrd5Mwxz0zAl+lRHcJwo9a3nAlUUkGXPEHShSeXsA87esH0e
        zj0TdQFWpI/bAH2rjklk7StGmwjlXS0=
X-Google-Smtp-Source: APXvYqx+K/FodaJbr3QHnqVg/SuYWsxZEhCORfo/J8xllg65hcY0+P2rZiXNL/HL4mPXUlzCSTb7YQ==
X-Received: by 2002:a1c:b088:: with SMTP id z130mr2063429wme.5.1555668635618;
        Fri, 19 Apr 2019 03:10:35 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id a126sm3698342wmh.4.2019.04.19.03.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:10:35 -0700 (PDT)
Subject: [PATCH v3 05/11] platform/x86: asus-wmi: Support WMI event queue
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <22dc9bfe-af2f-7ea9-e5bc-95647d5411a8@gmail.com>
Date:   Fri, 19 Apr 2019 12:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event codes are expected to be retrieved from a queue on at least some
models. Specifically, very likely the ACPI WMI devices with _UID ATK are
queued whereas those with ASUSWMI are not [1].

The WMI event codes are pushed into a circular buffer queue. After the INIT
method is called, ACPI code is allowed to push events into this buffer.
The INIT method cannot be reverted. If the module is unloaded and an event
(such as hotkey press) gets emitted before inserting it back the events get
processed delayed by one or if the queue overflows, additionally delayed by
about 3 seconds.

It might be considered a minor issue and no normal user would likely
observe this (there is little reason unloading the driver), but it does
significantly frustrate a developer who is unlucky enough to encounter
this. Therefore, the fallback to unqueued behavior occurs whenever
something unexpected happens.

The fix flushes the old key codes out of the queue on load. After receiving
event the queue is read until either ..FFFF or 1 is encountered. Also as
noted in [1] it is checked whether notify code is equal to 0xFF before
enabling queue processing in WMI notify handler.

DSDT examples:

FX505GM
Device (ATKD)
{ ..
    Name (ATKQ, Package (0x10)
    {
        0xFFFFFFFF, ..
    }

    Method (IANQ, 1, Serialized)
    {
        If ((AQNO >= 0x10))
        {
            Local0 = 0x64
            While ((Local0 && (AQNO >= 0x10)))
            {
                Local0--
                Sleep (0x0A)
            }
            ...
        ..
        AQTI++
        AQTI &= 0x0F
        ATKQ [AQTI] = Arg0
        ...
    }

    Method (GANQ, 0, Serialized)
    {
        ..
        If (AQNO)
        {
            ...
            Local0 = DerefOf (ATKQ [AQHI])
            AQHI++
            AQHI &= 0x0F
            Return (Local0)
        }

        Return (One)
    }

This code is almost identical to K54C, which does return Ones on empty
queue.

K54C:
Method (GANQ, 0, Serialized)
{
    If (AQNO)
    {
        ...
        Return (Local0)
    }

    Return (Ones)
}

[1] https://lkml.org/lkml/2019/4/12/104

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Suggested-by: Daniel Drake <drake@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c | 136 +++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 266d0eda5476..f782dac4cbe7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -81,6 +81,13 @@ MODULE_LICENSE("GPL");
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
 #define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
+#define ASUS_ACPI_UID_ATK		"ATK"
+
+#define WMI_EVENT_QUEUE_SIZE		0x10
+#define WMI_EVENT_QUEUE_END		0x1
+#define WMI_EVENT_MASK			0xFFFF
+/* The WMI hotkey event value is always the same. */
+#define WMI_EVENT_VALUE_ATK		0xFF
 
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
@@ -145,6 +152,7 @@ struct asus_wmi {
 	int dsts_id;
 	int spec;
 	int sfun;
+	bool wmi_event_queue;
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
@@ -1629,77 +1637,129 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
-static void asus_wmi_notify(u32 value, void *context)
+static int asus_wmi_get_next_event(u32 value)
 {
-	struct asus_wmi *asus = context;
-	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	acpi_status status;
-	int code;
-	int orig_code;
-	unsigned int key_value = 1;
-	bool autorelease = 1;
+	int code = -EIO;
 
-	status = wmi_get_event_data(value, &response);
-	if (status != AE_OK) {
-		pr_err("bad event status 0x%x\n", status);
-		return;
+	status = wmi_get_event_data(value, &output);
+	if (ACPI_FAILURE(status)) {
+		pr_warn("Failed to get WMI event code: %s\n",
+				acpi_format_exception(status));
+		return code;
 	}
 
-	obj = (union acpi_object *)response.pointer;
+	obj = (union acpi_object *)output.pointer;
 
-	if (!obj || obj->type != ACPI_TYPE_INTEGER)
-		goto exit;
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		code = (int)(obj->integer.value & WMI_EVENT_MASK);
+
+	kfree(obj);
+	return code;
+}
+
+static void asus_wmi_handle_notify_code(int code, struct asus_wmi *asus)
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
+	int code;
+	int i;
+
+	for (i = 0; i < WMI_EVENT_QUEUE_SIZE + 1; i++) {
+		code = asus_wmi_get_next_event(value);
+
+		if (code < 0) {
+			pr_warn("Failed to get event code: 0x%x\n", code);
+			return;
+		}
+
+		if (code == WMI_EVENT_QUEUE_END || code == WMI_EVENT_MASK)
+			return;
+
+		asus_wmi_handle_notify_code(code, asus);
+
+		/*
+		 * Double check that queue is present:
+		 * ATK (with queue) uses 0xff, ASUSWMI (without) 0xd2.
+		 */
+		if (!asus->wmi_event_queue || value != WMI_EVENT_VALUE_ATK)
+			return;
+	}
+
+	pr_warn("Failed to process event queue, last code: 0x%x\n", code);
+}
+
+static int asus_wmi_notify_queue_flush(struct asus_wmi *asus)
+{
+	int code;
+	int i;
+
+	for (i = 0; i < WMI_EVENT_QUEUE_SIZE + 1; i++) {
+		code = asus_wmi_get_next_event(WMI_EVENT_VALUE_ATK);
+
+		if (code < 0) {
+			pr_warn("Failed to get event during flush: %d\n", code);
+			return code;
+		}
+
+		if (code == WMI_EVENT_QUEUE_END || code == WMI_EVENT_MASK)
+			return 0;
+	}
+
+	pr_warn("Failed to flush event queue\n");
+	return -EIO;
 }
 
 /*
@@ -1850,6 +1910,7 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 {
 	int rv;
 	char *wmi_uid;
+	int err;
 
 	/* INIT enable hotkeys on some models */
 	if (!asus_wmi_evaluate_method(ASUS_WMI_METHODID_INIT, 0, 0, &rv))
@@ -1897,6 +1958,24 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 		asus->dsts_id = ASUS_WMI_METHODID_DSTS2;
 	}
 
+	/*
+	 * Some devices can have multiple event codes stored in a queue before
+	 * the module load if it was unloaded intermittently after calling
+	 * the INIT method (enables event handling). The WMI notify handler is
+	 * expected to retrieve all event codes until a retrieved code equals
+	 * queue end marker (One or Ones). Old codes are flushed from the queue
+	 * upon module load. Not enabling this when it should be has minimal
+	 * visible impact so fall back if anything goes wrong.
+	 */
+	wmi_uid = wmi_get_acpi_device_uid(asus->driver->event_guid);
+	if (wmi_uid && !strcmp(wmi_uid, ASUS_ACPI_UID_ATK)) {
+		pr_info("Detected ATK, enable event queue\n");
+
+		err = asus_wmi_notify_queue_flush(asus);
+		if (!err)
+			asus->wmi_event_queue = true;
+	}
+
 	/* CWAP allow to define the behavior of the Fn+F2 key,
 	 * this method doesn't seems to be present on Eee PCs */
 	if (asus->driver->quirks->wapf >= 0)
@@ -2155,8 +2234,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	} else
+	} else {
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
+	}
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
-- 
2.17.1

