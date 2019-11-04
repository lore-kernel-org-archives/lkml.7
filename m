Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D4CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8192B20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YywywOYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfKDS2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:28:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38412 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:28:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so3122668ljh.5;
        Mon, 04 Nov 2019 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9BkQFloRSV64INcQit1KezHLbgCAUZxVpxOp1Jw5hWA=;
        b=YywywOYb3xP5c44Erlikt9y1YFx7wsEtTV6qU+tVvWvIQthuNeP+GatDUwefUPPjRn
         6AuKsybYHjlyQMkpsVDN3iCxNhBgqbHOGMHXkiDYGMoWQgGkcUoTUUQqJtqC5yb1d/++
         3rGTXFdb+NFoeJ52Wrfg47CyOet6Pv5gRumzHmz1oyrZhSLrnc/HSTYolesvtnygu/r1
         8Z7i6+mCGy578VYP0KH6IxMyLbaHIBBYgJJdEWRflWRTf+6s0GbA5CYezw9g7ksEzovL
         JEj1IhIdjdOUmsACs+mZgy1FnoOTd2QFx0dulpcs4FVA5NcOLQuEFzy2CfL8l30w8ltw
         xr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9BkQFloRSV64INcQit1KezHLbgCAUZxVpxOp1Jw5hWA=;
        b=dN1J22XPaqG6e6A0BR4d0e+0aLa5gf3dTN7bTMkAqIOx00YVNFW9UDaFq/KI24uBHY
         zv9GawzDyP9C8KuhOlPfbIoiON51Kv7+6InnoezrMPLbxt+RdWUD+a47Ghg0F2Gvi86D
         0oOX1S4nbSQpalyMRObHgnQrqoYa9qzDtOnwv6JsHnhOzlTH4XKPEEbMtcWK5WoeCh4X
         qsRi5QuJaSPVYdGxkNq1v4GpiDE4z8difoZf/Qej8kd5e6o3+RhHw8wXx76PDYL5ZB56
         rK2zIc+G5VwiJQYpYWodDgH4VTzYu4vKboSdBy0D4q0Ci0rukUt8WAqASGo4/sO8oxxD
         LpZQ==
X-Gm-Message-State: APjAAAWpuEf3zY48oiszp0WhREJPeK3dz5iFy5Ehmgcceei8pLzJDO5g
        G8YKt+otOMxZwbFbKyE7yh0=
X-Google-Smtp-Source: APXvYqw+BMMV9j/4E2cuwMH5LcOk0YaqBDV0CDhZpvx/+k9WlbvBi7wkEPXT2+qFR2YC0WvsefyXuw==
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr16345273lju.51.1572892111614;
        Mon, 04 Nov 2019 10:28:31 -0800 (PST)
Received: from [10.0.0.92] ([91.237.107.85])
        by smtp.gmail.com with ESMTPSA id f5sm6790820ljn.24.2019.11.04.10.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:28:31 -0800 (PST)
Subject: [RFC PATCH 2/3] platform/x86: asus_wmi: Support fan boost mode on
 FX505DY/FX705DY
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com
References: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Message-ID: <2d524444-ba3f-40cf-a10a-1e3c638aae34@gmail.com>
Date:   Mon, 4 Nov 2019 20:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ASUS FX505DY/FX705DY laptops fan boost mode is same as in other
TUF laptop models but have different ACPI device ID and different key
code.

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
  drivers/platform/x86/asus-wmi.c            | 42 ++++++++++++++++++++----------
  include/linux/platform_data/x86/asus-wmi.h |  1 +
  2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 723aa4d..f4e5840 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -61,6 +61,7 @@
  #define NOTIFY_KBD_BRTDWN		0xc5
  #define NOTIFY_KBD_BRTTOGGLE		0xc7
  #define NOTIFY_KBD_FBM			0x99
+#define NOTIFY_KBD_FBM_2		0xae
  
  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
  
@@ -194,7 +195,7 @@ struct asus_wmi {
  	int fan_pwm_mode;
  	int agfn_pwm;
  
-	bool fan_boost_mode_available;
+	int fan_boost_mode_available;
  	u8 fan_boost_mode_mask;
  	u8 fan_boost_mode;
  
@@ -1616,24 +1617,33 @@ static int fan_boost_mode_check_present(struct asus_wmi *asus)
  	u32 result;
  	int err;
  
-	asus->fan_boost_mode_available = false;
+	asus->fan_boost_mode_available = 0;
  
  	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
  				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		else
-			return err;
+
+	if (err == 0 &&
+			(result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+			(result & ASUS_FAN_BOOST_MODES_MASK)) {
+		asus->fan_boost_mode_available = 1;
+		asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
+		return 0;
  	}
  
-	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE_2,
+				    &result);
+
+	if (err == 0 &&
+			(result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
  			(result & ASUS_FAN_BOOST_MODES_MASK)) {
-		asus->fan_boost_mode_available = true;
+		asus->fan_boost_mode_available = 2;
  		asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
  	}
  
-	return 0;
+	if (err == -ENODEV)
+		return 0;
+
+	return err;
  }
  
  static int fan_boost_mode_write(struct asus_wmi *asus)
@@ -1641,12 +1651,15 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
  	int err;
  	u8 value;
  	u32 retval;
+	u32 dev_id = asus->fan_boost_mode_available == 1 ?
+			ASUS_WMI_DEVID_FAN_BOOST_MODE :
+			ASUS_WMI_DEVID_FAN_BOOST_MODE_2;
  
  	value = asus->fan_boost_mode;
  
  	pr_info("Set fan boost mode: %u\n", value);
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
-				    &retval);
+	err = asus_wmi_set_devstate(dev_id, value, &retval);
+
  	if (err) {
  		pr_warn("Failed to set fan boost mode: %d\n", err);
  		return err;
@@ -2000,7 +2013,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
  		return;
  	}
  
-	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
+	if (asus->fan_boost_mode_available &&
+			(code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_FBM_2) {
  		fan_boost_mode_switch_next(asus);
  		return;
  	}
@@ -2177,7 +2191,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
  	else if (attr == &dev_attr_als_enable.attr)
  		devid = ASUS_WMI_DEVID_ALS_ENABLE;
  	else if (attr == &dev_attr_fan_boost_mode.attr)
-		ok = asus->fan_boost_mode_available;
+		ok = asus->fan_boost_mode_available != 0;
  
  	if (devid != -1)
  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 60249e2..714782b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,7 @@
  #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
  #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
  #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
+#define ASUS_WMI_DEVID_FAN_BOOST_MODE_2	0x00120075
  
  /* Misc */
  #define ASUS_WMI_DEVID_CAMERA		0x00060013
-- 
1.8.3.1

