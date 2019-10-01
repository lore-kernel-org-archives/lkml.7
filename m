Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841BCC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552E920B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHg8JxlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfJAS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:58:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36852 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJAS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:58:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so1801194pgk.3;
        Tue, 01 Oct 2019 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rgKM+gSKdAvEPz1q3YgyrAMBx1ZEgZu8VXbIIzyUx7E=;
        b=nHg8JxlOUhjCqeVpdQ+kppAjIL9/bKVm+aZYcY1PFlLnwa9r6q7Nn4UL/9+1k1GjsA
         W893HGKcxMdCqdo3bc5ADC44hklEndiCvRUHl21BTLe7c+p9r58jnimANW7S/bT8aKwo
         VlyYhjXK0f2CNybs5aJuTHGtk8vgXg95AIps1UW1/iMJJ5A5/6avp64ZG3UwH3ThjoIM
         0xXT01PaX6rcwx25Q9BfCUQsnVaeMEv7MAYJ57Bibhr6R9k8iTEYPaPkFPOUAtu1aJPe
         uZ5uiIo+8M2SI/BgU7J1jnlLZqWdFJYspnpBZNTHnUA7EFsj13TG7d+vfxnLNjbGjikP
         TrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rgKM+gSKdAvEPz1q3YgyrAMBx1ZEgZu8VXbIIzyUx7E=;
        b=gMWjPLd7wgxWe+r6YOayaG+AWI+XnMZ6vLgIsX+DlQvSjwluTrEbyLLZV6up9LMmgZ
         hIBLSNCgWi4oSntanqhCNObktK+hgsyHOTKP19i00cBh204r9RcfSPUTCqG/pAHTr0xK
         +CeBsnh+a/6xVqdpMr1o+AIjRxQyqaIZ5faczCT3lQORvwkweHFxAoDhRZn9vtZBZUdN
         DBHHh7tUGqHD0xfYcsexmJqvICMwm88tfZjE+Lbh4hn8nsphF9vlYTjPf4OTLnrgzi6S
         BRIRTAgO31AvMea1qUQGXtqq+vSpCXmDl+3GnRDPRlFMRoLgQw2kHch1a+XRX3xfFi1B
         tsCQ==
X-Gm-Message-State: APjAAAXX7mV3Oy+cs2Nm0rqzKwstBIkyegMGMPeQiqRCjT8wHIT6+8Ah
        xytHnrHURz0yp4ZsmvRfN+E=
X-Google-Smtp-Source: APXvYqwUMxxtwGQ+/Vz72xXwSnPlrwjofBxSqZxK59ynONJvC0kkiBd1wyg6/J92UGbWQlrqI5KRzg==
X-Received: by 2002:a63:114b:: with SMTP id 11mr31472766pgr.42.1569956305075;
        Tue, 01 Oct 2019 11:58:25 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d5sm3180157pjw.31.2019.10.01.11.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:58:24 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:58:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: peaq-wmi: switch to using polled mode of
 input devices
Message-ID: <20191001185822.GA48020@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added polled mode to the normal input devices with the intent of
retiring input_polled_dev. This converts peaq-wmi driver to use the
polling mode of standard input devices and removes dependency on
INPUT_POLLDEV.

Because the new polling coded does not allow peeking inside the poller
structure to get the poll interval, we change the "debounce" process to
operate on the time basis, instead of counting events.

We also fix error handling during initialization, as previously we leaked
input device structure when we failed to register it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: include input.h instead of input-polldev.h

 drivers/platform/x86/Kconfig    |  1 -
 drivers/platform/x86/peaq-wmi.c | 66 +++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f0a93f630455..c703c78c59f3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -804,7 +804,6 @@ config PEAQ_WMI
 	tristate "PEAQ 2-in-1 WMI hotkey driver"
 	depends on ACPI_WMI
 	depends on INPUT
-	select INPUT_POLLDEV
 	help
 	 Say Y here if you want to support WMI-based hotkeys on PEAQ 2-in-1s.
 
diff --git a/drivers/platform/x86/peaq-wmi.c b/drivers/platform/x86/peaq-wmi.c
index fdeb3624c529..cf9c44c20a82 100644
--- a/drivers/platform/x86/peaq-wmi.c
+++ b/drivers/platform/x86/peaq-wmi.c
@@ -6,7 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -18,8 +18,7 @@
 
 MODULE_ALIAS("wmi:"PEAQ_DOLBY_BUTTON_GUID);
 
-static unsigned int peaq_ignore_events_counter;
-static struct input_polled_dev *peaq_poll_dev;
+static struct input_dev *peaq_poll_dev;
 
 /*
  * The Dolby button (yes really a Dolby button) causes an ACPI variable to get
@@ -28,8 +27,10 @@ static struct input_polled_dev *peaq_poll_dev;
  * (if polling after the release) or twice (polling between press and release).
  * We ignore events for 0.5s after the first event to avoid reporting 2 presses.
  */
-static void peaq_wmi_poll(struct input_polled_dev *dev)
+static void peaq_wmi_poll(struct input_dev *input_dev)
 {
+	static unsigned long last_event_time;
+	static bool had_events;
 	union acpi_object obj;
 	acpi_status status;
 	u32 dummy = 0;
@@ -44,22 +45,25 @@ static void peaq_wmi_poll(struct input_polled_dev *dev)
 		return;
 
 	if (obj.type != ACPI_TYPE_INTEGER) {
-		dev_err(&peaq_poll_dev->input->dev,
+		dev_err(&input_dev->dev,
 			"Error WMBC did not return an integer\n");
 		return;
 	}
 
-	if (peaq_ignore_events_counter && peaq_ignore_events_counter--)
+	if (!obj.integer.value)
 		return;
 
-	if (obj.integer.value) {
-		input_event(peaq_poll_dev->input, EV_KEY, KEY_SOUND, 1);
-		input_sync(peaq_poll_dev->input);
-		input_event(peaq_poll_dev->input, EV_KEY, KEY_SOUND, 0);
-		input_sync(peaq_poll_dev->input);
-		peaq_ignore_events_counter = max(1u,
-			PEAQ_POLL_IGNORE_MS / peaq_poll_dev->poll_interval);
-	}
+	if (had_events && time_before(jiffies, last_event_time +
+					msecs_to_jiffies(PEAQ_POLL_IGNORE_MS)))
+		return;
+
+	input_event(input_dev, EV_KEY, KEY_SOUND, 1);
+	input_sync(input_dev);
+	input_event(input_dev, EV_KEY, KEY_SOUND, 0);
+	input_sync(input_dev);
+
+	last_event_time = jiffies;
+	had_events = true;
 }
 
 /* Some other devices (Shuttle XS35) use the same WMI GUID for other purposes */
@@ -75,6 +79,8 @@ static const struct dmi_system_id peaq_dmi_table[] __initconst = {
 
 static int __init peaq_wmi_init(void)
 {
+	int err;
+
 	/* WMI GUID is not unique, also check for a DMI match */
 	if (!dmi_check_system(peaq_dmi_table))
 		return -ENODEV;
@@ -82,24 +88,36 @@ static int __init peaq_wmi_init(void)
 	if (!wmi_has_guid(PEAQ_DOLBY_BUTTON_GUID))
 		return -ENODEV;
 
-	peaq_poll_dev = input_allocate_polled_device();
+	peaq_poll_dev = input_allocate_device();
 	if (!peaq_poll_dev)
 		return -ENOMEM;
 
-	peaq_poll_dev->poll = peaq_wmi_poll;
-	peaq_poll_dev->poll_interval = PEAQ_POLL_INTERVAL_MS;
-	peaq_poll_dev->poll_interval_max = PEAQ_POLL_MAX_MS;
-	peaq_poll_dev->input->name = "PEAQ WMI hotkeys";
-	peaq_poll_dev->input->phys = "wmi/input0";
-	peaq_poll_dev->input->id.bustype = BUS_HOST;
-	input_set_capability(peaq_poll_dev->input, EV_KEY, KEY_SOUND);
+	peaq_poll_dev->name = "PEAQ WMI hotkeys";
+	peaq_poll_dev->phys = "wmi/input0";
+	peaq_poll_dev->id.bustype = BUS_HOST;
+	input_set_capability(peaq_poll_dev, EV_KEY, KEY_SOUND);
+
+	err = input_setup_polling(peaq_poll_dev, peaq_wmi_poll);
+	if (err)
+		goto err_out;
+
+	input_set_poll_interval(peaq_poll_dev, PEAQ_POLL_INTERVAL_MS);
+	input_set_max_poll_interval(peaq_poll_dev, PEAQ_POLL_MAX_MS);
+
+	err = input_register_device(peaq_poll_dev);
+	if (err)
+		goto err_out;
+
+	return 0;
 
-	return input_register_polled_device(peaq_poll_dev);
+err_out:
+	input_free_device(peaq_poll_dev);
+	return err;
 }
 
 static void __exit peaq_wmi_exit(void)
 {
-	input_unregister_polled_device(peaq_poll_dev);
+	input_unregister_device(peaq_poll_dev);
 }
 
 module_init(peaq_wmi_init);
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
