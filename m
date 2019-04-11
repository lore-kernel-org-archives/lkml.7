Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E60C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8701E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldTb74ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKFoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:44:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32964 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:44:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so1100113wmi.0;
        Wed, 10 Apr 2019 22:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6WQnX/JC3lRgrjrWTjwX0RIKT+6jc5mLxFDDGJ1MLAY=;
        b=ldTb74neXXeAofxnMTWX7mSkgsUQ8OotOoptousg4mJV3JfZ1OWzlHoWncly2uXUmy
         mSPJ0GVhv6mXqwKaECtaG19UQsCrVMb3sihO0tGcdM6rpnWsVYxczXZtu7KOuBL79vUo
         Kyo2xqKlMc9P2Kz3+pNg2vAxORWd/UlcyzxIWrMElQHaPXDWVqgKZEbeQtAuW0KFpEtt
         Zb2rieEZlJLOpn2Oh7qj9c5Rcanng5njux6K0xuRR53IRKyjfRMzDo0fKtKKrR1pCzEB
         Da5LOwNzZTronpmfPJe7NRgjU8oSz9/6nbuLPbYD7I8GxopF0Q+3n7Qc2EMHmmZnjshd
         gf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WQnX/JC3lRgrjrWTjwX0RIKT+6jc5mLxFDDGJ1MLAY=;
        b=SfQHrYMIOhdjrHUPD4WRAEQ0Ptz4fxkTfMvrfZg0GbHZCXJqAKb5n6MhyaRaEIr82p
         KBBDfE9f8wMl0JGqgjQAFd1+sXJCGttUBf0MqcL0KKKLF/yQxQej/6D9V6jAA3zVtDwZ
         UDN70oCFwNYoYaAmdxeSu5Mz6QtpgnL/h8lVJBstwsbrvwl+vO8KdboRil4jkPSlQW4Y
         DtwGpu+fmml/h+IWID/z4X3LQ2v8HkdzXwm2/HAaF+Pl9KFyOdi9Nb40IryjuDoIU/IM
         iOMgCZCXlJxIrolEoKGZGYvb7rDUeDGXTS4mID4ozE9tlv71R9B6XPYbiuSifgBTTL1n
         EAUg==
X-Gm-Message-State: APjAAAVfWnFqZ1nH8wHhsYRrfO26NzRED1Vm4Xl84SUEuWTrhw0dRPp0
        CO4SGsEkHwI+EO0+xbdoktfkkbgcJ4A=
X-Google-Smtp-Source: APXvYqwFv0by26Yrg+lswAKQ9Ysrk15+Lku5jNbONjQBf/DeuNj2Ss/ZUhjK/PXlWIIMomzNTAiZ+g==
X-Received: by 2002:a1c:cc15:: with SMTP id h21mr5056667wmb.85.1554961444916;
        Wed, 10 Apr 2019 22:44:04 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id s203sm6377608wmf.14.2019.04.10.22.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:44:04 -0700 (PDT)
Subject: [PATCH v2 05/11] platform/x86: asus-wmi: Support queued WMI event
 codes
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <777027ac-921e-ee37-493e-974b49242d18@gmail.com>
Message-ID: <142fe2e3-b560-6136-32df-b14bb4ac46f7@gmail.com>
Date:   Thu, 11 Apr 2019 07:44:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <777027ac-921e-ee37-493e-974b49242d18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event codes are expected to be polled from a queue on at least some
models.

The WMI event codes are pushed into queue based on circular buffer. After
INIT method is called ACPI code is allowed to push events into this buffer
the INIT method can not be reverted. If the module is unloaded and an
event (such as hotkey press) gets emitted before inserting it back the
events get processed delayed by one or, if the queue overflows,
additionally delayed by about 3 seconds.

Patch was tested on a newer TUF Gaming FX505GM and older K54C model.

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

The fix flushes the old key codes out of the queue on load and after
receiving event the queue is read until either ..FFFF or 1 is encountered.

It might be considered a minor issue and no normal user would likely to
observe this (there is little reason unloading the driver), but it does
significantly frustrate a developer who is unlucky enough to encounter
this.

Introduce functionality for flushing and processing queued codes, which is
enabled via quirk flag for ASUS7000. It might be considered if it is
reasonable to enable it everywhere (might introduce regressions) or always
try to flush the queue on module load and try to detect if this quirk is
present in the future.

This patch limits the effect to the specific hardware defined by ASUS7000
device that is used for driver detection by vendor driver of Fx505. The
fallback is also implemented in case initial flush fails.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c |   1 +
 drivers/platform/x86/asus-wmi.c    | 122 ++++++++++++++++++++++-------
 drivers/platform/x86/asus-wmi.h    |   2 +
 3 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index cc5f0765a8d9..357d273ed336 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -438,6 +438,7 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 
 	if (acpi_dev_found("ASUS7000")) {
 		driver->quirks->force_dsts = true;
+		driver->quirks->wmi_event_queue = true;
 	}
 }
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 80f3447734fc..5aa30f8a2a38 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -80,6 +80,12 @@ MODULE_LICENSE("GPL");
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
+#define WMI_EVENT_QUEUE_SIZE		0x10
+#define WMI_EVENT_QUEUE_END		0x1
+#define WMI_EVENT_MASK			0xFFFF
+/* The event value is always the same. */
+#define WMI_EVENT_VALUE			0xFF
+
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static bool ashs_present(void)
@@ -143,6 +149,7 @@ struct asus_wmi {
 	int dsts_id;
 	int spec;
 	int sfun;
+	bool wmi_event_queue;
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
@@ -1637,77 +1644,126 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
-static void asus_wmi_notify(u32 value, void *context)
+static int asus_poll_wmi_event(u32 value)
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
+static void asus_wmi_handle_notify(int code, struct asus_wmi *asus)
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
+		code = asus_poll_wmi_event(value);
+
+		if (code < 0) {
+			pr_warn("Failed to get event code: 0x%x\n", code);
+			return;
+		}
+
+		if (code == WMI_EVENT_QUEUE_END || code == WMI_EVENT_MASK)
+			return;
+
+		asus_wmi_handle_notify(code, asus);
+
+		if (!asus->wmi_event_queue)
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
+		code = asus_poll_wmi_event(WMI_EVENT_VALUE);
+
+		if (code < 0) {
+			pr_warn("Failed to poll event during flush: %d\n",
+					code);
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
@@ -2159,8 +2215,18 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	} else
+	} else {
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
+	}
+
+	/** Try to initialize queue and fallback if it fails. */
+	if (asus->driver->quirks->wmi_event_queue) {
+		err = asus_wmi_notify_queue_flush(asus);
+		if (err)
+			asus->driver->quirks->wmi_event_queue = false;
+		else
+			pr_info("WMI event queue enabled\n");
+	}
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 94056da02fde..1248658d6442 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -54,6 +54,8 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	/* Multiple event codes can be queued in buffer. */
+	bool wmi_event_queue;
 	/**
 	 * Force DSTS instead of DSCS and skip detection. Useful if WMNB
 	 * returns nothing on unknown method call.
-- 
2.17.1

