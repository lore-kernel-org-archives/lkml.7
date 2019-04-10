Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4576EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1DF2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n30UhWj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDJUVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:21:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:21:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so3973310wml.4;
        Wed, 10 Apr 2019 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9qGS43LXuN/3IxIfwnAzCcj/kwmX0C+pVvSGJunHK78=;
        b=n30UhWj6LoOOuHY0cP5OhLA9BvThyzrmlh9QjixIpFToR829skm92QLfCyXjBNY6KD
         +C5pjIfLazqrOlh22zm+RSS/TPz6E8b3EHd4fySycJv1wMMek2oRPYMENs8GoRxpL/vf
         Nw6U0VDvMiO2uRMUwMjiLiYs+/SXajQni22g1YyWhBxEP2SS4R/4271K01C3+nyWZwZo
         nzLe1jqFlZjGu+HqpEEab4nEzzgBFUHes6kzgazh2QgcBLQ55DYbLsx9e+SwZW//zL8m
         R3B1XWnMx8woep3ufuh2uf49CM1HYrhaIkIhbAtuglAED7UnwjskfQmZdrkI/Hs7GF2J
         bxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9qGS43LXuN/3IxIfwnAzCcj/kwmX0C+pVvSGJunHK78=;
        b=Xlw47MEb0uWI2slQ4R7OvSjMaKqRnof0tN7O2yP9rH4/arILxYtVBqu3Bgst5cDGOe
         rnqJ/p6Auf2AW8p8U7ICWihkOOHZuwDrAh2/cB5E1TKzPwTg8gGSqjjpUn9PtW8bVFAg
         MnJ+DyNXPEEg5dbS8V5zvo418GXr5hB9JOE9esQTrN3M5lXJuaTLykXn1UqLx190epmO
         moG9VaS2vvUEgKTVOBEt46pxtin6dYWLvqFELjsUet1yyII61ICJOI9e6o6TJDLi+/eT
         CWDFcUHXmA3x6P8XFvH4VO9z6mhPbzPUDgu9B/sntL9uWWts4t903C3wlwdw35e/iPnP
         g33A==
X-Gm-Message-State: APjAAAUWe+mA2GDWasi1Vp1+EU3FHN8vcnT5qhOVuvPAzBumhIqKIMxI
        mHcT+RQc++FMZsI4M3ySLeSRlFq78M8=
X-Google-Smtp-Source: APXvYqyAkDPF3s04NCSosZH96XKV95dR68r+yxOlMr5GDgzmv+3YQGXKbkDApH0vKJTP47mb+lZnWA==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr4202982wmc.76.1554927661252;
        Wed, 10 Apr 2019 13:21:01 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id x205sm4965130wmg.9.2019.04.10.13.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:21:00 -0700 (PDT)
Subject: [PATCH 01/11] platform/x86: asus-wmi: Fix hwmon device cleanup
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <f2822519-c137-560e-fe78-172202e52bfa@gmail.com>
Date:   Wed, 10 Apr 2019 22:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asus-wmi driver does not clean up the hwmon device on exit or error.
To reproduce the bug, repeat rmmod, insmod to verify that device number
/sys/devices/platform/asus-nb-wmi/hwmon/hwmon?? grows every time. Add
pointer to the device in module state and call cleanup on error.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ee1fa93708ec..6b736a9375ef 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -145,6 +145,7 @@ struct asus_wmi {
 
 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
+	struct device *hwmon_device;
 	struct platform_device *platform_device;
 
 	struct led_classdev wlan_led;
@@ -1432,9 +1433,19 @@ static int asus_wmi_hwmon_init(struct asus_wmi *asus)
 		pr_err("Could not register asus hwmon device\n");
 		return PTR_ERR(hwmon);
 	}
+
+	asus->hwmon_device = hwmon;
 	return 0;
 }
 
+static void asus_wmi_hwmon_exit(struct asus_wmi *asus)
+{
+	if (asus->hwmon_device) {
+		asus_hwmon_fan_set_auto(asus);
+		hwmon_device_unregister(asus->hwmon_device);
+	}
+}
+
 /*
  * Backlight
  */
@@ -2157,6 +2168,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_rfkill:
 	asus_wmi_led_exit(asus);
 fail_leds:
+	asus_wmi_hwmon_exit(asus);
 fail_hwmon:
 	asus_wmi_input_exit(asus);
 fail_input:
@@ -2178,7 +2190,7 @@ static int asus_wmi_remove(struct platform_device *device)
 	asus_wmi_rfkill_exit(asus);
 	asus_wmi_debugfs_exit(asus);
 	asus_wmi_platform_exit(asus);
-	asus_hwmon_fan_set_auto(asus);
+	asus_wmi_hwmon_exit(asus);
 
 	kfree(asus);
 	return 0;
-- 
2.17.1

