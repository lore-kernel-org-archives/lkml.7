Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D04E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGEbQhHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfDSTYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:24:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35176 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfDSTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:24:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id o12so4673758wrn.2;
        Fri, 19 Apr 2019 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nbmr2w5/0wlcA5OCIjXqH8b8jg348eXwm/j8E2b8gwc=;
        b=VGEbQhHcqcHmqC/N8ddol3NVQo48qPjGNaykxHoA4RKKNNRzsTAzYsZyWbH4mHTPI3
         xrcv9qJ/UNrwNYLszIr9UbGFcJK9XY+OGm2GZN4kc5zHrzg9DpoHVB+RH0gp8ggvxHY7
         BIG8SkaukMJGT1xaI5WcWDkcClN4XQ2ZnAWmJa5ZDVHCr7VDDKGiKZmlDLUgfVtBzSfI
         pn9n7hP90sbBE3cYYFZ8+YBDduHJ6L58PdLeEwL9bwkb0z1buKUFpNfnpgbVpIaeUhOJ
         mv3pHHkYc5BO/2ESoD5RBSqmP9U38G4FH2ei5bRsV2frkL+UVVf21dguFsLh3w5Wafrg
         QY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbmr2w5/0wlcA5OCIjXqH8b8jg348eXwm/j8E2b8gwc=;
        b=A8ODlamfvjgZiGe2pcfN9rDo7BeUIirkOpQtX2hOUJdH2sQwGGtuoKuHBUrr+BRRh2
         7nQGQqcoEw7OU/o8DwbY9S2vJMGGemJdw7HMq6XR662h5HHNGuIxlx0jBEVG+8t8ugrW
         wYaLcaUhvFPYBVzDaE8HJKjxYzgwbtD/lEPy/tnk4V3BwvrlXZha5kjXkJDPGVHv4ezG
         pFfwZqgzBzPMiWSGtA4Nufia/KuDT6khC+azBOYLIlvVkOZoIGzA1ZNfKhrx8sNCbhr9
         KulTFlSJ20qIs+qFDTqRSlywmlZ5UehmD6JfcR/IW2MZTjrnY+Vb3aAT5PQr1Vn1+BHH
         FhtA==
X-Gm-Message-State: APjAAAVfOJfaLSOG8mLm9wkFV5E3VZ/+TPx1E4dnsBzFZZM0Ktx14Hry
        xTngmwRFchjGI1yfEF+LXuGtUfvnCuI=
X-Google-Smtp-Source: APXvYqxTeIkY6HrtLXqdLaB04RltJhEunJXx+hreNyqXWksrxaf1qtJS2B5bSfRSkQ4zBxxnz3r2rQ==
X-Received: by 2002:adf:ed90:: with SMTP id c16mr2292654wro.74.1555668770298;
        Fri, 19 Apr 2019 03:12:50 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id j3sm5710118wre.51.2019.04.19.03.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:12:49 -0700 (PDT)
Subject: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of thermal
 data
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
Date:   Fri, 19 Apr 2019 12:12:47 +0200
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

The obviously wrong value 1 for temperature device ID in this driver is
returned by at least some devices, including TUF Gaming series laptops,
instead of 0 as expected previously. Observable effect is that a
temp1_input in hwmon reads temperature near absolute zero.

* Consider 0.1 K an erroneous value in addition to 0 K.
* Refactor detection of thermal input availability to a separate function.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 45 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index e69e55635afb..1b8272374660 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -178,6 +178,7 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	bool asus_hwmon_thermal_available;
 	bool asus_hwmon_fan_manual_mode;
 	int asus_hwmon_num_fans;
 	int asus_hwmon_pwm;
@@ -1375,6 +1376,32 @@ static struct attribute *hwmon_attributes[] = {
 	NULL
 };
 
+static int asus_hwmon_check_thermal_available(struct asus_wmi *asus)
+{
+	u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
+	int err;
+
+	asus->asus_hwmon_thermal_available = false;
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_THERMAL_CTRL, &value);
+
+	if (err < 0) {
+		if (err == -ENODEV)
+			return 0;
+
+		return err;
+	}
+
+	/*
+	 * If the temperature value in deci-Kelvin is near the absolute
+	 * zero temperature, something is clearly wrong.
+	 */
+	if (!value || value == 1)
+		return 0;
+
+	asus->asus_hwmon_thermal_available = true;
+	return 0;
+}
+
 static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 					  struct attribute *attr, int idx)
 {
@@ -1388,8 +1415,6 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_pwm1.attr)
 		dev_id = ASUS_WMI_DEVID_FAN_CTRL;
-	else if (attr == &dev_attr_temp1_input.attr)
-		dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
 
 	if (attr == &dev_attr_fan1_input.attr
 	    || attr == &dev_attr_fan1_label.attr
@@ -1414,15 +1439,13 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 		 * - reverved bits are non-zero
 		 * - sfun and presence bit are not set
 		 */
-		if (value == ASUS_WMI_UNSUPPORTED_METHOD || value & 0xFFF80000
+		if (value == ASUS_WMI_UNSUPPORTED_METHOD || (value & 0xFFF80000)
 		    || (!asus->sfun && !(value & ASUS_WMI_DSTS_PRESENCE_BIT)))
 			ok = false;
 		else
 			ok = fan_attr <= asus->asus_hwmon_num_fans;
-	} else if (dev_id == ASUS_WMI_DEVID_THERMAL_CTRL) {
-		/* If value is zero, something is clearly wrong */
-		if (!value)
-			ok = false;
+	} else if (attr == &dev_attr_temp1_input.attr) {
+		ok = asus->asus_hwmon_thermal_available;
 	} else if (fan_attr <= asus->asus_hwmon_num_fans && fan_attr != -1) {
 		ok = true;
 	} else {
@@ -1469,6 +1492,14 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	}
 
 	pr_info("Number of fans: %d\n", asus->asus_hwmon_num_fans);
+
+	status = asus_hwmon_check_thermal_available(asus);
+	if (status) {
+		pr_warn("Could not check if thermal available: %d\n", status);
+		return -ENXIO;
+	}
+
+	pr_info("Thermal available: %d\n", asus->asus_hwmon_thermal_available);
 	return 0;
 }
 
-- 
2.17.1

