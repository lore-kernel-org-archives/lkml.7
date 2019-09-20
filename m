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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C0BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054B621907
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3eURxzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394466AbfITAkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:40:19 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44838 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbfITAkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:40:18 -0400
Received: by mail-yb1-f195.google.com with SMTP id f1so1826954ybq.11;
        Thu, 19 Sep 2019 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2iXv5Hsh+1LBY24AKyClbwA95JiK12EU0d4z81X8e2E=;
        b=V3eURxzRx6ctIMG6Z0HK+Ozs2dmH2K/uj04fBhuzUp46qQkUJJbddUb1IFSthImJGf
         vUCY6DfL4QykVyp033mMSeFR6RAG4RqlmShdeDMPNB63+Hy2SP5LxMRvw1/FilXL5Zue
         eLOGdT1NnCag8dAoNcLimgR+KIAVtGLeXjoy8JtaRGO5sfmIgjacpfdW9PODn/BGKGrT
         guOZj2AyjubNvf/K2Mxv9F4uTKFE7u9+Rfh/S4GTOJHFJoWffxaN4EUS8bq8HpElyQH0
         v9YLdvjsPH3dO/AIi6KYgRDE2CKyrVfergolop107I8wD+Uom3GRrTw+bcrityrHacRb
         nf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2iXv5Hsh+1LBY24AKyClbwA95JiK12EU0d4z81X8e2E=;
        b=iDAVo5Xt73UPkV3xRbt01xWUK1v44+p91+idjXMEfh0032jGrA+WMO3haChD4Vz2kp
         xhjRNP4co/+HInotGW3+BV4yqx7pL8ADkku1Qi+9uzIifxwlUEo6pDWEeVKMVhYzeNII
         5p7eZHT+sBNRaI78ySPOA/+9C7uY50H7QFQzBNoKiX2EETQGfP7pfyi+wwJB6RlH7eQk
         epnBGmo7J6/8n1L4O53NWlqIa63DxKGPw3+0eUBEf9mfCPGKyBCvUwM8BcrhH1ATS6I6
         bXL17wYfpGVTdt1HWnQyqXvnGhwSuvAR/DBGmks7Oa57n58P/Jo7B3FvXOCPfZvWCI/S
         /kjw==
X-Gm-Message-State: APjAAAUnZAvzEDB4fOuazlzbXxPDu0K8fyXUWqz3giqofpEQKKUeTA52
        7nMJIHir3qtHLonuh5NB+g==
X-Google-Smtp-Source: APXvYqys+X8LyNOrnZu+2/u2TCu7pu0bIei8c3QiZb09aROhimETye2c9FsWHX7Mpvh/jxKeZWxfAw==
X-Received: by 2002:a25:c1c4:: with SMTP id r187mr8600869ybf.325.1568940017396;
        Thu, 19 Sep 2019 17:40:17 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id r63sm102802ywg.36.2019.09.19.17.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:40:17 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] platform/x86: huawei-wmi: Add quirks and module parameters
Date:   Thu, 19 Sep 2019 20:39:07 -0400
Message-Id: <20190920003938.21617-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920003938.21617-1-ayman.bagabas@gmail.com>
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
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
 drivers/platform/x86/huawei-wmi.c | 77 +++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 9496ea3c78b5..97ff3d868765 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/leds.h>
@@ -22,7 +23,21 @@
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
+struct huawei_wmi_debug {
+	struct dentry *root;
+	u64 arg;
+};
+
 struct huawei_wmi {
+	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
@@ -49,6 +64,58 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_END,	 0 }
 };
 
+static bool battery_reset;
+static bool report_brightness;
+
+module_param(battery_reset, bool, 0444);
+MODULE_PARM_DESC(battery_reset,
+		"Reset battery charge values to (0-0) before disabling it using (0-100)");
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
@@ -139,6 +206,11 @@ static void huawei_wmi_process_key(struct input_dev *idev, int code)
 		return;
 	}
 
+	if (quirks && !quirks->report_brightness &&
+			(key->sw.code == KEY_BRIGHTNESSDOWN ||
+			key->sw.code == KEY_BRIGHTNESSUP))
+		return;
+
 	sparse_keymap_report_entry(idev, key, 1, true);
 }
 
@@ -253,6 +325,11 @@ static __init int huawei_wmi_init(void)
 	if (!huawei_wmi)
 		return -ENOMEM;
 
+	quirks = &quirk_unknown;
+	dmi_check_system(huawei_quirks);
+	quirks->battery_reset |= battery_reset;
+	quirks->report_brightness |= report_brightness;
+
 	err = platform_driver_register(&huawei_wmi_driver);
 	if (err)
 		goto pdrv_err;
-- 
2.21.0

