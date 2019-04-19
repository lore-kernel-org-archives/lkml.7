Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AE7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872BB20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmNVyqKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfDSSzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39591 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDSSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so7921977wrn.6;
        Fri, 19 Apr 2019 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=I3dd98omRXec5fhk5/RnYCCTGikhhFY2HueNh1URl4w=;
        b=RmNVyqKV+YOwTpRkAQjSBZXx8RDltuVS78IIPGOhYDbi1MxMGphL/iOlAiDwQFW7ct
         +Qc2y7uRcc0Y1qQncaDkTa1GjjYJ25D81Sop0e9jhPLuvYAnxz2jQt/BSzmWykBeyoC2
         Mha1Qi3fx+TC4xQVLKEDs6NMgvROigiV+Ux/czhBgppm81mQNTa28g3Cm3e5oLRJVdN0
         Cf7i5kB2MGO3ZFwzigdJrgGjhby0BuubJhSsz94cULM1uCzq3QfYLCNZxNyXHI/F7zC7
         M/iCzKDPtmOq7IW7MxaVg36S7sTsE2XboFdCKug+OcG3KZZ+E3snxt8Kt+SatDnyC+aT
         PxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I3dd98omRXec5fhk5/RnYCCTGikhhFY2HueNh1URl4w=;
        b=rc3IM+OBRXa+3B5rURx8x18ckQj3lDtIHWYw/ZhobERQ3JjZ5DUADRQa0PxrhzhsJI
         EOwOsRLlxWDeEIdMomR4Y9wdDp5HrZDfvOWnG9Bxovw6nsotOG2Itn/ONS/gPeeOsgfW
         dTP03vBJ5JwZsrfBtDnmgaPJK+TfUojqUVACuUr7ph8KUqnNoytptbeXjVbQa/e0dgRK
         WRmf4THuEwAcyszQnDYriLoTpg3SblPtytC4QzI6TBlMZLKNYTN5kZGAASDqVM6oo0M0
         vxsBXAj5OaZaRP822DH4yiAAMCYCQUKZN65b2dYRgva+EzFW3p5+X2L3Y8Hsm/Mw4Wnn
         wf9Q==
X-Gm-Message-State: APjAAAWdwd7N7ORKjZVENSLLbO2jiEAu2EVduXn+J78vRIF6Hj84BBlj
        oHDk8E5gaacprMfQIXSBqbTCKpdtxw0=
X-Google-Smtp-Source: APXvYqzA+Hdc1G3g+9brljf2582Z4HHUnhSfzdIc1i/Au4kF8SIasjUMSoShPc3H1Gl0syLldLUChg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr2230532wrj.228.1555668734131;
        Fri, 19 Apr 2019 03:12:14 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id o6sm5786455wre.60.2019.04.19.03.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:12:13 -0700 (PDT)
Subject: [PATCH v3 07/11] platform/x86: asus-wmi: Organize code into sections
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <9a4351a5-ab04-2ebb-9961-1c50dda9800d@gmail.com>
Date:   Fri, 19 Apr 2019 12:12:11 +0200
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

The driver has grown pretty big and will grow more, which makes it hard to
navigate and understand. Add uniform comments to the code and ensure that
it is sorted into logical sections.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 94 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f782dac4cbe7..e69e55635afb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -193,6 +193,8 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
+/* Input **********************************************************************/
+
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
 	int err;
@@ -230,6 +232,8 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
+/* WMI ************************************************************************/
+
 static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 		u32 arg2, u32 *retval)
 {
@@ -248,7 +252,7 @@ static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 				     &input, &output);
 
 	if (ACPI_FAILURE(status))
-		goto exit;
+		return -EIO;
 
 	obj = (union acpi_object *)output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
@@ -259,10 +263,6 @@ static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 
 	kfree(obj);
 
-exit:
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
 	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
 		return -ENODEV;
 
@@ -346,9 +346,8 @@ static int asus_wmi_get_devstate_simple(struct asus_wmi *asus, u32 dev_id)
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
@@ -658,6 +657,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	return rv;
 }
 
+/* RF *************************************************************************/
 
 /*
  * PCI hotplug (for wlan rfkill)
@@ -1080,6 +1080,8 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	return result;
 }
 
+/* Quirks *********************************************************************/
+
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
 {
 	struct pci_dev *xhci_pdev;
@@ -1112,9 +1114,8 @@ static void asus_wmi_set_als(void)
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
@@ -1390,7 +1391,6 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_temp1_input.attr)
 		dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
 
-
 	if (attr == &dev_attr_fan1_input.attr
 	    || attr == &dev_attr_fan1_label.attr
 	    || attr == &dev_attr_pwm1.attr
@@ -1453,9 +1453,27 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
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
@@ -1637,6 +1655,8 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* WMI events *****************************************************************/
+
 static int asus_wmi_get_next_event(u32 value)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1762,9 +1782,8 @@ static int asus_wmi_notify_queue_flush(struct asus_wmi *asus)
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
@@ -1903,9 +1922,8 @@ static int asus_wmi_sysfs_init(struct platform_device *device)
 	return sysfs_create_group(&device->dev.kobj, &platform_attribute_group);
 }
 
-/*
- * Platform device
- */
+/* Platform device ************************************************************/
+
 static int asus_wmi_platform_init(struct asus_wmi *asus)
 {
 	int rv;
@@ -1990,9 +2008,8 @@ static void asus_wmi_platform_exit(struct asus_wmi *asus)
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
@@ -2139,28 +2156,8 @@ static int asus_wmi_debugfs_init(struct asus_wmi *asus)
 	return -ENOMEM;
 }
 
-static int asus_wmi_fan_init(struct asus_wmi *asus)
-{
-	int status;
-
-	asus->asus_hwmon_pwm = -1;
-	asus->asus_hwmon_num_fans = -1;
-	asus->asus_hwmon_fan_manual_mode = false;
-
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
+/* Init / exit ****************************************************************/
 
-/*
- * WMI Driver
- */
 static int asus_wmi_add(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
@@ -2288,9 +2285,8 @@ static int asus_wmi_remove(struct platform_device *device)
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
@@ -2362,6 +2358,8 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.resume = asus_hotk_resume,
 };
 
+/* Registration ***************************************************************/
+
 static int asus_wmi_probe(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
-- 
2.17.1

