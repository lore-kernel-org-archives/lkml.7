Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8060206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkgjJbAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfITQDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:03:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44563 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfITQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:03:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id u187so2646015ywa.11;
        Fri, 20 Sep 2019 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mDRWgzAX5BzQRDnjOLDKf4M+7Qn9M6zsk32ycuv6xH4=;
        b=tkgjJbAL/w8dExIaZzY63NUGa99MfsPUhokfbZ0x962LcmI/zhaiQpB3+PNEpAJPSh
         4oIuQhcJ112OxvCeCdgSswvVGeQ8c9G/ZoCnQLw+5IWzxxajWGHd34Nq4uQRcMAz6VCL
         v4vo7Ngr1aMFM9msk8oeiDyf9gjtiOZGsOqnR8MAwBJcn5McIn6hyh/VhqnzMYG7PLGT
         m90luQWBcghkDuL+wLbspVx137iFRjl9eYjopXgT6vqjXnXVmwF5uHwivDlPM42ZB6vu
         hm9htIs4T78ZFy8QbChbwUU3N4Ok8PREXpdj9i50oeN4jbewah1feWoE/PQcgb1tChGn
         qlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDRWgzAX5BzQRDnjOLDKf4M+7Qn9M6zsk32ycuv6xH4=;
        b=mg213GxHtdQPCzdMsiClq9NgPGfvIT5qt2uKvF49+GOsicLbC+nX6nKwCu+9YJ467A
         JvQ1t3qd4ZEOJ3vOCzcV3GsZKifiazdtX1zvjgHS8w17k/bHWw/ckmVtMQTBjXW7g2BM
         j3zWPB/QASRlFwiu7c9KGEUVe1zfQpDG3B5XrNMkBldaIUwbLKG+K3/Z802dpNqFkMXp
         IjfGm4i32w6owyvKjaljshARwupT1np3LcC2xdugWD7BmnWDXBGsOlisFYSSyjSMZJ2L
         eyxR5HBymNytA7cKD6XFwd8I5b+mk/YIodzrtf174BnqvrpzAVEwwGCJuj3Hd3cS7pDf
         A9zg==
X-Gm-Message-State: APjAAAW4jylZ3/kVC+58KOlu4V8Zj3IzeuPv9bp/9wPXuRjogWjxRLbK
        VOxmhuOXKd3CUXxaXKvuyQ==
X-Google-Smtp-Source: APXvYqyUb/RjNgsaIlaget/WadHgtRrtngo/Be9QajxJZxEZlEFAQY3S/jXIwQ0s+LhNP4PjXSKo1w==
X-Received: by 2002:a81:4702:: with SMTP id u2mr13665436ywa.53.1568995420868;
        Fri, 20 Sep 2019 09:03:40 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 207sm518086ywu.106.2019.09.20.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:03:39 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] platform/x86: huawei-wmi: Add quirks and module parameters
Date:   Fri, 20 Sep 2019 12:02:35 -0400
Message-Id: <20190920160250.12510-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920160250.12510-1-ayman.bagabas@gmail.com>
References: <20190920160250.12510-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce quirks and module parameters. 3 quirks are added:
1. Fixes reporting brightness keys twice since it's already handled by
   acpi-video.
2. Some models need a short delay when setting battery thresholds to
   prevent a race condition when two processes read/write. (will be used later)
3. Matebook X (2017) handles micmute led through the "legacy" interface
   which is not currently implemented. Use ACPI EC method to control
   this led. (will be used later)

2 module parameters are added to enable this short delay and/or report
  brightness keys through this driver.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 9496ea3c78b5..0e919bf56ad1 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
@@ -22,6 +23,14 @@
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
 #define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
 
+struct quirk_entry {
+	bool battery_reset;
+	bool ec_micmute;
+	bool report_brightness;
+};
+
+static struct quirk_entry *quirks;
+
 struct huawei_wmi {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
@@ -49,6 +58,58 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+static int battery_reset = -1;
+static int report_brightness = -1;
+
+module_param(battery_reset, bint, 0444);
+MODULE_PARM_DESC(battery_reset,
+		"Reset battery charge values to (0-0) before disabling it using (0-100)");
+module_param(report_brightness, bint, 0444);
+MODULE_PARM_DESC(report_brightness,
+		"Report brightness keys.");
+
+/* Quirks */
+
+static int __init dmi_matched(const struct dmi_system_id *dmi)
+{
+	quirks = dmi->driver_data;
+	return 1;
+}
+
+static struct quirk_entry quirk_unknown = {
+};
+
+static struct quirk_entry quirk_battery_reset = {
+	.battery_reset = true,
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
+		.driver_data = &quirk_battery_reset
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
 static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
 		enum led_brightness brightness)
 {
@@ -139,6 +200,11 @@ static void huawei_wmi_process_key(struct input_dev *idev, int code)
 		return;
 	}
 
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
 	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
@@ -253,6 +319,13 @@ static __init int huawei_wmi_init(void)
 	if (!huawei_wmi)
 		return -ENOMEM;
 
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	if (battery_reset != -1)
+		quirks->battery_reset = battery_reset;
+	if (report_brightness != -1)
+		quirks->report_brightness = report_brightness;
+
 	err = platform_driver_register(&huawei_wmi_driver);
 	if (err)
 		goto pdrv_err;
-- 
2.21.0

