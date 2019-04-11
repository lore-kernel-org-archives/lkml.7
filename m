Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D910C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E6A20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueO3VLTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKFqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:46:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37667 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfDKFqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:46:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so5548463wrm.4;
        Wed, 10 Apr 2019 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X6wWgQlleU1+2uTT3b8K3Off/KPLV+q5bQoPl5JGty4=;
        b=ueO3VLTe9+hi0j+6zYJHWn/1nZn5pNcxxx4fYBVfJlcunUIw6zWIWAZsPD2NyYZ8tg
         eb/Dlg+BNDbxSXBd5YilEZcZ0CGaF66hmRdwvJweJP6LSDf3u0wS5HQIutXycgQnZMk6
         xVEBJSq3rkQ4YS7TcbGtAiKjz3REXZdvOim1tDCXxmIl7kJNd+Y73BZB+tX/nm6f/jkF
         nZdSdbC0c36tOOowH9ZHFigfw/6aIH5ehLHOpBrfScptvHx7csUmtDmgtqOjc55fL25d
         6j15xHZ6NJeipl+J6Xc9DOYlbflPXFeY9+qE9xlZ8YioKuVAlluJ+3DgpWCR+7iZ7rL9
         MS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6wWgQlleU1+2uTT3b8K3Off/KPLV+q5bQoPl5JGty4=;
        b=nRMVrY0QM2RLZa5lNaJTn5WTkh6UyNyyvC8kl/x9reIVmryW/egTgE7LtY9LhDYP75
         oqhsruwQJT/TnJCvHR1D1pjy0Jp42NT47O2Mu9okZ8FAQnlZpuIBcxqLukIJ+vN58UJP
         PlHxJ1S0KRXzIgNzGLQfcwqM3dFH1ZJdVxgl8aL7piFCwnckAlG8vmR32ly5hVOerfhe
         V1d1vp8PYgxfaVeBnn9YiZbi8uUNzVkUT3ykrSmBTaIfN2vx0X3KF1uA6KZDd5P9OOc1
         AkNUr6PX8bBUrUkPVtrAH6bamterdTWu3bZ7Xn+tW5wa/zfA14WocBEVJMY1aOEScrVK
         6s0g==
X-Gm-Message-State: APjAAAWVoDkHK3V9ifkaC3JB7SVqeQ9ks7K110AxUu/M19v3FqUiVgHP
        M4+kb0Ka+cG7hXfXpjj5xwhthvc+APk=
X-Google-Smtp-Source: APXvYqyqnQAtMQ/rtM2ai7ga2Uv0nJmzBUW1L4ACUzwP0E0TuXh2R8cBlUzT2UE3e5uaHYglDUZGtg==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr29812783wrl.154.1554961561011;
        Wed, 10 Apr 2019 22:46:01 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id l20sm4160061wme.20.2019.04.10.22.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:46:00 -0700 (PDT)
Subject: [PATCH v2 08/11] platform/x86: asus-wmi: Enhance detection of thermal
 data
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <91702752-5e6d-43c8-5b41-a52a34b10d26@gmail.com>
Message-ID: <ee220162-27d2-87ad-0f0f-bedd2cdc7192@gmail.com>
Date:   Thu, 11 Apr 2019 07:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <91702752-5e6d-43c8-5b41-a52a34b10d26@gmail.com>
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

* Consider 0.1 K as erroneous value in addition to 0 K.
* Refactor detection of thermal input availability to a separate function.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 45 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a98df005d6cb..de0a8f61d4a1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -176,6 +176,7 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	bool asus_hwmon_thermal_available;
 	bool asus_hwmon_fan_manual_mode;
 	int asus_hwmon_num_fans;
 	int asus_hwmon_pwm;
@@ -1373,6 +1374,32 @@ static struct attribute *hwmon_attributes[] = {
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
@@ -1386,8 +1413,6 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_pwm1.attr)
 		dev_id = ASUS_WMI_DEVID_FAN_CTRL;
-	else if (attr == &dev_attr_temp1_input.attr)
-		dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
 
 	if (attr == &dev_attr_fan1_input.attr
 	    || attr == &dev_attr_fan1_label.attr
@@ -1412,15 +1437,13 @@ static umode_t asus_hwmon_sysfs_is_visible(struct kobject *kobj,
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
@@ -1476,6 +1499,14 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
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

