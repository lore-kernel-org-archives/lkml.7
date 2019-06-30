Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F965C4646D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C520B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKrCJ0TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF3Flk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34514 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfF3Fli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id c4so3804539uad.1;
        Sat, 29 Jun 2019 22:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5j3IO2fR8dGnJJ8Bw7OG2mF2AzsT5n4q6VZYnXcfGiQ=;
        b=jKrCJ0TVooJHi5QtAxAP4XXnEcrlDfVsQjhUvs/Bscwtj1ekGeu1yniJez589G6TRd
         LJmX6n4p0ZVhGBZHMmUszrPnBANpDADN+wX2KYOg7J9GU2DQorFeBzgsh8X/vAGnsC/b
         d6cCdD4ES25sikbVAU3OfTCP1cF+VbT71TwLb04eRbVHOlXYMhdRTdk8p3DoFz0XLZXD
         myhoSz/Jb2j7MlbouCiCvuQQE+T5dp1rQzq8zbC4/+yboLYFS3eW3ie9ErPjblYMeONM
         r4QWaEdM6HOnKscnMD9IvOVlwPuV3A8AXikWQCIb0aUuH63xCOyQU0dm0Y3KXJeO4pXs
         axDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5j3IO2fR8dGnJJ8Bw7OG2mF2AzsT5n4q6VZYnXcfGiQ=;
        b=QvnTEFwoY7o2fFCD6FJevBwupdKT2cy1a+FHWldTxLM3wnTMH5WqZvv7TnW4pgWXwj
         pjyN8NiN6M2ZREaTLPubrJxEsOPji475EBwGA1ApftaqlJn3Im7MXeJBpM0VAso0pjvQ
         5zvi2BZt7TO+pDHvlwOE16czHZUpASYpULjtvxzCAvkuY2izc4i5LGQpMprIGJINTydp
         ARsOrPuFR7tm+E9zsOqbXjv8yIBADC6lYGgdJSL/KikKhLWyFHUgz6OeWa6+q7qOthCt
         bAmfQCwM1Cdpn3f+k2VIc3BJ0HS/0DfCgONilOsvsEDC7CaREk8U9tnhcBCTQ4bZN43i
         Obuw==
X-Gm-Message-State: APjAAAXvlGYRJrHoPUypHMEKMXZqy3z/vqKvtMpyKcV2sCaqURs3UBpm
        ugI4GfzRZAarJEWO8zt/CQ==
X-Google-Smtp-Source: APXvYqy35onY5fRiWtGb2iVB4/MUqm6vOP2+g6/JLxHApc1OVYj+wkIDkqbTS2v73bIHtCe8Pcaoew==
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr10564584uam.129.1561873297607;
        Sat, 29 Jun 2019 22:41:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:37 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 4/9] platform/x86: huawei-wmi: Add quirks and module parameters
Date:   Sun, 30 Jun 2019 01:41:03 -0400
Message-Id: <20190630054108.19205-5-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
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
   prevent a race condition when two processes read/write.
3. Matebook X (2017) handles micmute led through the "legacy" interface
   which is not currently implemented. Use ACPI EC method to control
   this led.

2 module parameters are added to enable this short delay and/or report
  brightness keys through this driver.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 27520b0f8956..8f918138053a 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
@@ -34,6 +35,14 @@ enum {
 	MICMUTE_LED_SET			= 0x00000b04, /* \SMLS */
 };
 
+struct quirk_entry {
+	bool battery_sleep;
+	bool ec_micmute;
+	bool report_brightness;
+};
+
+static struct quirk_entry *quirks;
+
 struct huawei_wmi_priv {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
@@ -62,6 +71,58 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+static bool battery_sleep;
+static bool report_brightness;
+
+module_param(battery_sleep, bool, 0444);
+MODULE_PARM_DESC(battery_sleep,
+		"Delay after setting battery charging thresholds.");
+module_param(report_brightness, bool, 0444);
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
 /* Utils */
 
 static int huawei_wmi_call(struct device *dev, struct acpi_buffer *in,
@@ -264,6 +325,11 @@ static void huawei_wmi_process_key(struct input_dev *idev, int code)
 		return;
 	}
 
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
 	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
@@ -377,6 +443,11 @@ static __init int huawei_wmi_init(void)
 {
 	int err;
 
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	quirks->battery_sleep |= battery_sleep;
+	quirks->report_brightness |= report_brightness;
+
 	err = platform_driver_register(&huawei_wmi_driver);
 	if (err)
 		return err;
-- 
2.20.1

