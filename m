Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A23C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394CC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="1pY426B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfDRGrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:47:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRGrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:47:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so717648pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PUESG3Iig+nm5BSbt1XrWH31Tj3mZ8Y0DmCac0DaFpM=;
        b=1pY426B/dH8y3DHTFT99WKYDEZCKMUmvWyGhJz8VrNGmQLT7gfod4A1CmyICaoAcS8
         8wbnnaAsobZXw296ONZUI84jua6eUbWMIUkZpWt4EQgY33YfRNvfVZEMD1AUx3ppKy+o
         fyD8BKlCiX1HV5B/f5bbQojkH1iT6NiIg1fdeNiQ21NPtFBaTZ503Jy2fT3BEe4meE2F
         ZrMU83ylecdB0K1cjaR8icibovAw2tH2+Ar+CmOol37RzKhW3yMUNbU2jmZcZeYjhgs0
         6ftvZbhQMUe/bw++R5Im1FuIQ4SvQlBZE1ssNP2HWL/Z2KI/wBdcvh35ctvooFyN4M2d
         ztpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PUESG3Iig+nm5BSbt1XrWH31Tj3mZ8Y0DmCac0DaFpM=;
        b=mgEZrnA0rpvj1ZOuHAvX93GoLRXoD48wlMJHt461bNp1MajAKIBwRCoC2rJqGXYGiC
         eGiRqDjvwY69mrMsiG99wDxhTBmxx5B3bxRbxs/dIqygNteVljjATaVfaKOwD667U/LC
         C3fFZH33D/BYujsCv9A6x799JB4KG2sb8grxKGZ21pM0P5ty8+ZCPIubV9mPSh61wUll
         Eiz4sTpXmTIZGGguJ9cXW/YwAkyUJb7F+u+z3CWuGFuOO5oGB5WMuQX0BoahGzuDSvTy
         2mhUkPuFLP7QtzeTEYNXORukwMHJlRTZbqgQXTwkxNntR0ZqQmClTeQct9L0L36r88Dt
         qGYA==
X-Gm-Message-State: APjAAAWx+oyEGIBpgBqg9Uu7xQlqDDK/PEoU3y+dNj+oq5ELz7ka2cdk
        Nn1UIgLvyyK8wcQJpnoJBprktA==
X-Google-Smtp-Source: APXvYqykZxhaNJHwW2moNKA3+HHyg0Kac+dymoC0i9IfTW1ICaIwiWnyPKwx2WEVhqwKT0Jo+RQtlg==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr83219221pgm.160.1555570019535;
        Wed, 17 Apr 2019 23:46:59 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id p3sm1438045pfn.167.2019.04.17.23.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 23:46:58 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     andriy.shevchenko@linux.intel.com, corentin.chary@gmail.com,
        dvhart@infradead.org
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] platform/x86: asus-wmi: Add fn-lock mode switch support
Date:   Thu, 18 Apr 2019 14:46:48 +0800
Message-Id: <20190418064648.25706-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of latest ASUS laptops support new fn-lock mode switching.
This commit detect whether if the fn-lock option is enabled in
BIOS setting, and toggle the fn-lock mode via a new WMI DEVID
0x00100023 when the corresponding notify code captured.

The ASUS fn-lock mode switch is activated by pressing Fn+Esc.
When on, keys F1 to F12 behave as applicable, with meanings
defined by the application being used at the time. When off,
F1 to F12 directly triggers hardware features, well known audio
volume up/down, brightness up/down...etc, which were triggered
by holding down Fn key and F-keys.

Because there's no way to retrieve the fn-lock mode via existing
WMI methods per ASUS spec, driver need to initialize and keep the
fn-lock mode by itself.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 37b5de541270..5f52b66e40cb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -69,6 +69,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
+#define NOTIFY_FNLOCK_TOGGLE		0x4e
 
 #define ASUS_FAN_DESC			"cpu_fan"
 #define ASUS_FAN_MFUN			0x13
@@ -177,6 +178,8 @@ struct asus_wmi {
 	struct workqueue_struct *hotplug_workqueue;
 	struct work_struct hotplug_work;
 
+	bool fnlock_locked;
+
 	struct asus_wmi_debug debug;
 
 	struct asus_wmi_driver *driver;
@@ -1619,6 +1622,24 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
+{
+#define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
+	u32 result;
+
+	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FNLOCK, &result);
+
+	return (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+		!(result & ASUS_WMI_FNLOCK_BIOS_DISABLED);
+}
+
+static void asus_wmi_fnlock_update(struct asus_wmi *asus)
+{
+	int mode = asus->fnlock_locked;
+
+	asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
+}
+
 static void asus_wmi_notify(u32 value, void *context)
 {
 	struct asus_wmi *asus = context;
@@ -1680,6 +1701,12 @@ static void asus_wmi_notify(u32 value, void *context)
 		goto exit;
 	}
 
+	if (code == NOTIFY_FNLOCK_TOGGLE) {
+		asus->fnlock_locked = !asus->fnlock_locked;
+		asus_wmi_fnlock_update(asus);
+		goto exit;
+	}
+
 	if (is_display_toggle(code) &&
 	    asus->driver->quirks->no_display_toggle)
 		goto exit;
@@ -2134,6 +2161,11 @@ static int asus_wmi_add(struct platform_device *pdev)
 	} else
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
+	if (asus_wmi_has_fnlock_key(asus)) {
+		asus->fnlock_locked = true;
+		asus_wmi_fnlock_update(asus);
+	}
+
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
 	if (ACPI_FAILURE(status)) {
@@ -2213,6 +2245,8 @@ static int asus_hotk_resume(struct device *device)
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
 		kbd_led_update(asus);
 
+	if (asus_wmi_has_fnlock_key(asus))
+		asus_wmi_fnlock_update(asus);
 	return 0;
 }
 
@@ -2249,6 +2283,8 @@ static int asus_hotk_restore(struct device *device)
 	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
 		kbd_led_update(asus);
 
+	if (asus_wmi_has_fnlock_key(asus))
+		asus_wmi_fnlock_update(asus);
 	return 0;
 }
 
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 53dfc2541960..bfba245636a7 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -67,6 +67,7 @@
 /* Input */
 #define ASUS_WMI_DEVID_TOUCHPAD		0x00100011
 #define ASUS_WMI_DEVID_TOUCHPAD_LED	0x00100012
+#define ASUS_WMI_DEVID_FNLOCK		0x00100023
 
 /* Fan, Thermal */
 #define ASUS_WMI_DEVID_THERMAL_CTRL	0x00110011
-- 
2.11.0

