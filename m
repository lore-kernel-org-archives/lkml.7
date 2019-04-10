Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3920EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24F821841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en5Oe4H8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDJUcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:32:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37673 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:32:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so4487340wrm.4;
        Wed, 10 Apr 2019 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tcR4SQD/Dnitpphmo0Ew8bryddr84Vmt+X3uV843Su4=;
        b=en5Oe4H8r3utt/vhJKQPUjaIr82lb8fRQF0lkqcaLHPESZjOPBxeqE8htMvd05Pkbx
         8CUCLU2wsxR2CTICP/A5yfCRpdwIM2Pu84wvN5d/NHltQ7uJYb6ik+SkUuKpHETse5Zw
         mUFEylWLFZSquskTzhNGdkVgwIBlUSB+spwJ7oWppEyT+wiHgRMEooVQ6J/9Z5bOz59V
         d7BXM1/e4ek1ABMiEHP1pQBA/Nh1cGk/PLnFbCsXlPUD+3z7dRE/jBb7BI72Z9zNW7oP
         uxziNDQOv89fHArP6CL5A/WAdXJDU+w+7Eq70duaTl00DZd55CvhRImhlnaNHFYbnC4T
         T63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcR4SQD/Dnitpphmo0Ew8bryddr84Vmt+X3uV843Su4=;
        b=HXxPvbbIa8IqJTFr6XLn9CJ5KBqbOamkxE+XpYbzJ1JLprT+QtcfCD4o+NaPQjkD/q
         DIk27E7Dae3ww1gltYd4cMFSqKFdAkzTCdZc/Yd9J85zZezvetM8vENu5C70dzK/AzgO
         TwHG/Ee46r16YcV2im7vz+wzZ5HvMgpW56X34Tcx1A0EMF0+aaEiNVgu1eorf2Q9XIN5
         0JT4aJo1WXQFy2zGrdF2mt/0+i0fmltbJvucBV/VTpZxTWLcLS2esIYEj4l90FijqGIP
         uJeG8YJROAlDI0NlmztLNDKeMw49QZ0yw+6sqbWOW+My421if+njRFhV57ml5W0VjZS8
         0fnQ==
X-Gm-Message-State: APjAAAVbSz0k5K+uINsR2qb503nUcaZyjqUUjwf8l0EEpsbeEHOZwAx4
        Zz5v84VBCHaujJpX/xg1qZoxoRvMpBg=
X-Google-Smtp-Source: APXvYqz99ImHy8X4gHBs030K48khLugxOWFe9/9+CqrbxZxxYq2ElD8ognp2gHoZ3aAeE+0BwWPSRQ==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr11023159wrb.252.1554928349386;
        Wed, 10 Apr 2019 13:32:29 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id w9sm8517883wmi.0.2019.04.10.13.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:32:28 -0700 (PDT)
Subject: [PATCH 08/11] platform/x86: asus-wmi: Enhance detection of thermal
 data
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <91702752-5e6d-43c8-5b41-a52a34b10d26@gmail.com>
Date:   Wed, 10 Apr 2019 22:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
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
 drivers/platform/x86/asus-wmi.c | 46 ++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b9a6dc224e08..175ecd5b7c51 100644
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
@@ -1476,6 +1499,15 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	}
 
 	pr_info("Number of fans: %d\n", asus->asus_hwmon_num_fans);
+
+	status = asus_hwmon_check_thermal_available(asus);
+	if (status) {
+		pr_warn("Could not check if thermal available: %d\n", status);
+		return -ENXIO;
+	}
+
+	pr_info(PR "Thermal available: %d\n",
+			asus->asus_hwmon_thermal_available);
 	return 0;
 }
 
-- 
2.17.1

