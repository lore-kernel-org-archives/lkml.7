Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93412083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4qcxpCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:45:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:45:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so5570226wrd.3;
        Wed, 10 Apr 2019 22:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GQsS/uzXqkm0SASWDdmGdSSipFWEz+3qBvVZruJu9ZM=;
        b=k4qcxpCwGUy9LWIuhOzgi8YsylWceVTMRfllF0gqb1DV5vxO3hmCw6FiiW/OopIF9i
         AxrPbMRmO39Uzlo273E3Oq1EATO97QBaMGREu0iCyCGOFpFI2f715xKQMEZ/88ex5gJu
         O7zO77CrYWpgwcyeQ4HkQZZdsD3UuRZNOHxcTKBs4OM23b0l0tDH2jlT5Cap0+q7OIX0
         7R5eqoAm2d0Kl6HH6OO6fLZGT1jommxgRDIEmpI0mrJgw1OpVdhsCiNNKAjV1IuRfo/G
         TSdndRk5bhYkf9BW+1zfXrBs3AkV4sz6y0ua6Zb+2DdUcAfv6jBn+QnJLjb2+VY5ZPdr
         tvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQsS/uzXqkm0SASWDdmGdSSipFWEz+3qBvVZruJu9ZM=;
        b=D4f7T5Yl20eHBCxn9W51gUhZSPhlqQqm07Q2uNdr9CSPVYoTNZx9RsVAPZ5rtKF5oE
         OPRJldCMfPobbYN7G6tt5lLOcugwn9ibHO5wGxOhRhKJMB8JDx/YQrI5Sy4z7y5ZNRU4
         KF9G+7K81+/xCUsCrkBX5KXSycNPFCbPA7AUajUZcVzyUKyvv7ny41+NYZvRqBZEszYJ
         EVsk4E6yqOVuxfVuugc9Hzg57Zf4f4jusPIeC9OUZhgenEcRADxR7bObPMPyu7E9vm+P
         xpY0OkAyx2I4zOzS+5FA1NCMzlwNTBEjxJoReCb4aIG+1XgjBdIN7dPkMX8W126OToSh
         tQIw==
X-Gm-Message-State: APjAAAVjUKhvlOQ+IqwEbybUeaiS6wtI2WXIr/koEbv6FR82FlpuZpol
        MnGnLYCL3kJeKjsYXXVLJuEWe/+iINw=
X-Google-Smtp-Source: APXvYqy59UsrQtSmenhKDHwUAZ4Z8xHX+OaJc0z2+b4kfJwk2SKflklAkiCDCaNO7FMJjfW+PSNuew==
X-Received: by 2002:adf:9c91:: with SMTP id d17mr28436222wre.285.1554961511761;
        Wed, 10 Apr 2019 22:45:11 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id z8sm37596141wrh.80.2019.04.10.22.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:45:11 -0700 (PDT)
Subject: [PATCH v2 07/11] platform/x86: asus-wmi: Organize code into sections
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <300d9410-1de5-a4ab-a55a-378ec8c4d5b9@gmail.com>
Message-ID: <f5e183e7-a6c8-074e-661e-61bc24bfe0e8@gmail.com>
Date:   Thu, 11 Apr 2019 07:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <300d9410-1de5-a4ab-a55a-378ec8c4d5b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has grown (and will more) pretty big which makes it hard to
navigate and understand. Add uniform comments to the code and ensure that
it is sorted into logical sections.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 94 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5aa30f8a2a38..a98df005d6cb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -191,6 +191,8 @@ struct asus_wmi {
 	struct asus_wmi_driver *driver;
 };
 
+/* Input **********************************************************************/
+
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
 	int err;
@@ -228,6 +230,8 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
+/* WMI ************************************************************************/
+
 static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 		u32 arg2, u32 *retval)
 {
@@ -246,7 +250,7 @@ static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 				     &input, &output);
 
 	if (ACPI_FAILURE(status))
-		goto exit;
+		return -EIO;
 
 	obj = (union acpi_object *)output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
@@ -257,10 +261,6 @@ static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
 
 	kfree(obj);
 
-exit:
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
 	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
 		return -ENODEV;
 
@@ -344,9 +344,8 @@ static int asus_wmi_get_devstate_simple(struct asus_wmi *asus, u32 dev_id)
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
@@ -656,6 +655,7 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 	return rv;
 }
 
+/* RF *************************************************************************/
 
 /*
  * PCI hotplug (for wlan rfkill)
@@ -1078,6 +1078,8 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	return result;
 }
 
+/* Quirks *********************************************************************/
+
 static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
 {
 	struct pci_dev *xhci_pdev;
@@ -1110,9 +1112,8 @@ static void asus_wmi_set_als(void)
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
@@ -1388,7 +1389,6 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_temp1_input.attr)
 		dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
 
-
 	if (attr == &dev_attr_fan1_input.attr
 	    || attr == &dev_attr_fan1_label.attr
 	    || attr == &dev_attr_pwm1.attr
@@ -1460,9 +1460,27 @@ static void asus_wmi_hwmon_exit(struct asus_wmi *asus)
 	}
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
@@ -1644,6 +1662,8 @@ static int is_display_toggle(int code)
 	return 0;
 }
 
+/* WMI events *****************************************************************/
+
 static int asus_poll_wmi_event(u32 value)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1766,9 +1786,8 @@ static int asus_wmi_notify_queue_flush(struct asus_wmi *asus)
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
@@ -1907,9 +1926,8 @@ static int asus_wmi_sysfs_init(struct platform_device *device)
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
@@ -1971,9 +1989,8 @@ static void asus_wmi_platform_exit(struct asus_wmi *asus)
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
@@ -2120,28 +2137,8 @@ static int asus_wmi_debugfs_init(struct asus_wmi *asus)
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
@@ -2279,9 +2276,8 @@ static int asus_wmi_remove(struct platform_device *device)
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
@@ -2353,6 +2349,8 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.resume = asus_hotk_resume,
 };
 
+/* Registration ***************************************************************/
+
 static int asus_wmi_probe(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
-- 
2.17.1

