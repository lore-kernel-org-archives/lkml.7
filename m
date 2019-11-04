Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249CCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6120848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZupAyKsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfKDViq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:38:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34134 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfKDVip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:38:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so13431294lfp.1;
        Mon, 04 Nov 2019 13:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BkQFloRSV64INcQit1KezHLbgCAUZxVpxOp1Jw5hWA=;
        b=ZupAyKslevX7lHR58O2vVYahTOF8MjiPtfoUvO0B9MJROl8D31lMVJJPEXfYZFmO0a
         O9yY1724jEBcCNWXRWfm0onez+chxgPnsTCHYiPLLiw5Rtci5YRMy5oLYYYP45z6Se4y
         dLlJiDTZSK65MADgTlO2IY5zG2amJOc4QaK/yieu4aVaNi7r8kkMK8GdXif5WaUAPcaB
         eE2pwXHRtEv1bFz3ekfpbV6PanMUqXBmgTJ0eBYly3BC7ynF/lZd6oLI9LJw+bZoWOzM
         7a9Mvr+rdOsGLKf//PVVxWhYr94yB21Owu44va9Rf5ssdhHHrYbQr2kWm7HWDukZJuXh
         L6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BkQFloRSV64INcQit1KezHLbgCAUZxVpxOp1Jw5hWA=;
        b=pZkJ+KLknvm8HXvA7Qq9+lz1dZN05MyhPKGifxuhk0cA2shuXo0cgMK/CpdAYb4ah0
         /uqjswEd3eeLGd6FjBKyjqiF9PJSXhLjwaslkB2Akq6mYbLJ+RiT3hGFTper1xPfYzrT
         GSCrFdspxH/7c2YIvuc/kbXkkEIa/Tr6NQ2uPma13iD59aaADwfEdekIIVsz3WH1LaBG
         fpywUvW83ceMGUcOvSjBWhj9vFo93vCfy1RDuXBaA5fCYoukkK6Zbhs+B5kOgyRLjt2H
         Vuxf3G+oIWgBs2GkzM6ogpJrafoVVYvCFXJUuQZqN4qUft5SSGX4Znckwo4cN4QTc4Ko
         uwyw==
X-Gm-Message-State: APjAAAWc4cMUbdcfFFlYACft+pbZARGEQGU8YEdtFzXsxU0UZ9YqPBUX
        72ck6QFzwql7v281BmdKqYM81D3eH9Y=
X-Google-Smtp-Source: APXvYqycZ2ltjnulbJQ/lZ7axjxbF88W5SJLV4KWAkukgWyHYsv8dtn+8K6Xw0EdRNhYnRjSf4na7g==
X-Received: by 2002:a19:d7:: with SMTP id 206mr18034693lfa.22.1572903520163;
        Mon, 04 Nov 2019 13:38:40 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id q124sm8182137ljb.28.2019.11.04.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:38:39 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v2 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
Date:   Mon,  4 Nov 2019 23:38:28 +0200
Message-Id: <20191104213828.18278-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104213417.18036-1-leonmaxx@gmail.com>
References: <20191104213417.18036-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

