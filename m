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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B652067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPLontfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfGaRxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:30 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40529 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbfGaRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:27 -0400
Received: by mail-yw1-f65.google.com with SMTP id b143so25249370ywb.7;
        Wed, 31 Jul 2019 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5j3IO2fR8dGnJJ8Bw7OG2mF2AzsT5n4q6VZYnXcfGiQ=;
        b=RPLontfBxz6EnXqQjCfVk2e0ngDlCKruYe2/+ozxbIhTq3aQ9Jy4gsi7rAQSTcbYEf
         HewDWMj8GkkX0Tfno/A7YOZVt52fYEbXvOLLbSUKGQ8JjPGy0KsDyXsY/qhQ7f7OoVHD
         qSLMInRmoVsthtz+UhfsahggoNidlCUgrq/RBKfaw0dpHyviEdsmie6txSXeRijCMDIk
         YDXOUPI9XqUbjcCNaxkggykO4lG4L/6aF4wmLtvtlkLoYbfGL2aDBxYpKLSWUJtSVdGW
         rw7y9jYxY7GrSXCb+PesvDg6hOYT0x9JmKjz2ESAe6jJLHomvRYrYt48CgNcq74PB3tm
         EMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5j3IO2fR8dGnJJ8Bw7OG2mF2AzsT5n4q6VZYnXcfGiQ=;
        b=Ssne8cA+mLhrDf12LKpk4A6/qq7XZmvFy1v5QolLFxyXwMsdgfPl/HZxIWQEedMbsa
         3oQP6hivu0WWUxpMI+eyMIgOcQzz0x8r0+PsQEhkCzhvrBFrcm6Ld3s6D95DccQuYmqH
         w/5aIAqSozIolgt8MaonZbLSSANLgN2AkHBc9et1zZe7BCTlD7VzIMvbIa4mRA9QhT7F
         n1qiCZxns69+N6G2+2QsLQSWp1qnYbSq7c5eQHFOMm2a4umGivqRRiPSj1tzZgCTUN37
         SGPFSYjYswlNwU1+Ofon2M9kyuI5r1tv7jnjMu0rnY+ygtk9xzboCqOdY8BtBK8QxWNn
         Icmw==
X-Gm-Message-State: APjAAAXTBe1kcWS6TeSzB+LviqjBGbIjA90qW1VlgTGrNcnPo4EiB8hf
        2cOJXuw8wTYLzOZAKKX7ap4l7FM=
X-Google-Smtp-Source: APXvYqxeLfizgBb7E2bUU1iFT8lyaE+xSWDb2ThZKdNcKWX9IM21R09cuJ7nXHYMaijpFtYe4Awx1w==
X-Received: by 2002:a81:ad5a:: with SMTP id l26mr78435686ywk.388.1564595606052;
        Wed, 31 Jul 2019 10:53:26 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:25 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 4/9] platform/x86: huawei-wmi: Add quirks and module parameters
Date:   Wed, 31 Jul 2019 13:52:50 -0400
Message-Id: <20190731175255.25676-5-ayman.bagabas@gmail.com>
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


