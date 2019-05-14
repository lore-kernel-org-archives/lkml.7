Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFDFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92DAF216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WanPv09y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfENTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:04:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:04:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so22587wrt.1;
        Tue, 14 May 2019 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CGGKxWzCjGjLD3yIJGbckhYKgkACoCZzEyygAEOtw4U=;
        b=WanPv09yYpjsOoDNKQ/yR66DAhsDJQ1jJy3yp/Cb3LVPT2UwKjPi7OrbcUkTH3Xj0R
         0sl6cAYx8hvuo1AqWH0+5o+/pxnYPhynGqexzftchESvwMTjtIkVTAaHF4wYwiBsRanY
         gF8A9vJBnYoeFjNuVJRMhlw/Hc493LC24pwrP8U+tRMI2NcVhESdm46pS2TyS4OH01LZ
         wdnClfcZ+yEDyNS3otKLkAUjaau2dq6XuthXT0Dc2qOPALOiLgq2xchj8F/yxPvJFJUA
         3Roe4YfjwijZN8tNYUQ88DD93GQRgop+kfcgyb6nI8ivRGRYo2m8oAz6Mn07FbB/SSgw
         6GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CGGKxWzCjGjLD3yIJGbckhYKgkACoCZzEyygAEOtw4U=;
        b=I5IvP4Vw4ECx8nbd9PqTlxUU16Bz1Cj9zXyHRNt7J1p6ayuiylSsqgstDpbVVmUuwf
         Vc/IbUKRjCVoW1MgnfLcRepKK9lBVlL56RQV4NTKDVxBOO0014B46Tv9LZiq0Z9Nr0A+
         3bW+jUGNvY65kuYBwXUw1KNSe61CYTIdPtFPb0k86zMGCiymfS0XyAyw3I/vN3DuRcpf
         Lu6Y/+NuNxXztwY36ayH0mr63J/bVURTBVWTNhlqmvnsrwSz1/FecktPZsGntXFJEJgF
         pYX02tnOritai3HAyF659UYhWh8lMJ9NP+h2hHVndr8Uz9dHx2vGnwyLHNv3acSoNnEQ
         mtMA==
X-Gm-Message-State: APjAAAVTCCTwx5hLviX4cY9vJK+2gMeC1nT5KORqnSDRcOLq2alCpVXf
        ZhKB84a0YDGngQ/SP1eM2lhB7pHa
X-Google-Smtp-Source: APXvYqzCa8t16ENhUMwee6cVnxgPEW/zY1GFfnPC/skO5VefUG8+TM3j/V9LvhLemaEGlERcRIrUsw==
X-Received: by 2002:adf:e8d2:: with SMTP id k18mr16033174wrn.329.1557860690815;
        Tue, 14 May 2019 12:04:50 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id o4sm4498916wmc.38.2019.05.14.12.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:04:50 -0700 (PDT)
Subject: [PATCH v4 10/13] platform/x86: asus-wmi: Organize code into sections
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <9634285d-df3c-f927-6f1c-e9d43c45bc37@gmail.com>
Date:   Tue, 14 May 2019 21:04:48 +0200
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

The driver has grown pretty big and will grow more, which makes it hard to
navigate and understand. Add uniform comments to the code and ensure that
it is sorted into logical sections.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 89 +++++++++++++++++----------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 090a00af4017..bd9eb00f3a27 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -200,6 +200,8 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
+/* Input **********************************************************************/
+
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
 	int err;
@@ -237,6 +239,8 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
+/* WMI ************************************************************************/
+
 static int asus_wmi_evaluate_method3(u32 method_id,
 		u32 arg0, u32 arg1, u32 arg2, u32 *retval)
 {
@@ -349,9 +353,8 @@ static int asus_wmi_get_devstate_simple(struct asus_wmi *asus, u32 dev_id)
 					  ASUS_WMI_DSTS_STATUS_BIT);
 }
 
-/*
- * LEDs
- */
+/* LEDs ***********************************************************************/
+
 /*
  * These functions actually update the LED's, and are called from a
  * workqueue. By doing this as separate work rather than when the LED
@@ -661,6 +664,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	return rv;
 }
 
+/* RF *************************************************************************/
 
 /*
  * PCI hotplug (for wlan rfkill)
@@ -1083,6 +1087,8 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	return result;
 }
 
+/* Quirks *********************************************************************/
+
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
 {
 	struct pci_dev *xhci_pdev;
@@ -1115,9 +1121,8 @@ static void asus_wmi_set_als(void)
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_ALS_ENABLE, 1, NULL);
 }
 
-/*
- * Hwmon device
- */
+/* Hwmon device ***************************************************************/
+
 static int asus_hwmon_agfn_fan_speed_read(struct asus_wmi *asus, int fan,
 					  int *speed)
 {
@@ -1456,9 +1461,27 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 	return 0;
 }
 
-/*
- * Backlight
- */
+static int asus_wmi_fan_init(struct asus_wmi *asus)
+{
+	int status;
+
+	asus->asus_hwmon_pwm = -1;
+	asus->asus_hwmon_num_fans = -1;
+	asus->asus_hwmon_fan_manual_mode = false;
+
+	status = asus_hwmon_get_fan_number(asus, &asus->asus_hwmon_num_fans);
+	if (status) {
+		asus->asus_hwmon_num_fans = 0;
+		pr_warn("Could not determine number of fans: %d\n", status);
+		return -ENXIO;
+	}
+
+	pr_info("Number of fans: %d\n", asus->asus_hwmon_num_fans);
+	return 0;
+}
+
+/* Backlight ******************************************************************/
+
 static int read_backlight_power(struct asus_wmi *asus)
 {
 	int ret;
@@ -1640,6 +1663,8 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* Fn-lock ********************************************************************/
+
 static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
 {
 	u32 result;
@@ -1657,6 +1682,8 @@ static void asus_wmi_fnlock_update(struct asus_wmi *asus)
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
 }
 
+/* WMI events *****************************************************************/
+
 static int asus_wmi_get_event_code(u32 value)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1790,9 +1817,8 @@ static int asus_wmi_notify_queue_flush(struct asus_wmi *asus)
 	return -EIO;
 }
 
-/*
- * Sys helpers
- */
+/* Sysfs **********************************************************************/
+
 static int parse_arg(const char *buf, unsigned long count, int *val)
 {
 	if (!count)
@@ -1931,9 +1957,8 @@ static int asus_wmi_sysfs_init(struct platform_device *device)
 	return sysfs_create_group(&device->dev.kobj, &platform_attribute_group);
 }
 
-/*
- * Platform device
- */
+/* Platform device ************************************************************/
+
 static int asus_wmi_platform_init(struct asus_wmi *asus)
 {
 	struct device *dev = &asus->platform_device->dev;
@@ -2017,9 +2042,8 @@ static void asus_wmi_platform_exit(struct asus_wmi *asus)
 	asus_wmi_sysfs_exit(asus->platform_device);
 }
 
-/*
- * debugfs
- */
+/* debugfs ********************************************************************/
+
 struct asus_wmi_debugfs_node {
 	struct asus_wmi *asus;
 	char *name;
@@ -2166,28 +2190,8 @@ static int asus_wmi_debugfs_init(struct asus_wmi *asus)
 	return -ENOMEM;
 }
 
-static int asus_wmi_fan_init(struct asus_wmi *asus)
-{
-	int status;
-
-	asus->asus_hwmon_pwm = -1;
-	asus->asus_hwmon_num_fans = -1;
-	asus->asus_hwmon_fan_manual_mode = false;
+/* Init / exit ****************************************************************/
 
-	status = asus_hwmon_get_fan_number(asus, &asus->asus_hwmon_num_fans);
-	if (status) {
-		asus->asus_hwmon_num_fans = 0;
-		pr_warn("Could not determine number of fans: %d\n", status);
-		return -ENXIO;
-	}
-
-	pr_info("Number of fans: %d\n", asus->asus_hwmon_num_fans);
-	return 0;
-}
-
-/*
- * WMI Driver
- */
 static int asus_wmi_add(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
@@ -2319,9 +2323,8 @@ static int asus_wmi_remove(struct platform_device *device)
 	return 0;
 }
 
-/*
- * Platform driver - hibernate/resume callbacks
- */
+/* Platform driver - hibernate/resume callbacks *******************************/
+
 static int asus_hotk_thaw(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
@@ -2397,6 +2400,8 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.resume = asus_hotk_resume,
 };
 
+/* Registration ***************************************************************/
+
 static int asus_wmi_probe(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
-- 
2.17.1

