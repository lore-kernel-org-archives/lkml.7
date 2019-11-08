Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E3BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C805B20865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyHZ5XeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfKHQpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:45:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39020 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:45:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id p18so6914376ljc.6;
        Fri, 08 Nov 2019 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCwDRHsjMshwUjrnqGW1EzKHumkWqiiCQKHVnFSnF9E=;
        b=RyHZ5XeSBZdOFsYP3XbnSFbcW5JAvJ/lbSGnoyyZ78hyCwaQ2x+kSZ1DTXU6wg3ilt
         RZEsOTsq7qqpn+fTm6ATTEJ0x0Y7Fx82cBjpl39ESZlVYf2xLYTTMst7w9wnhuMfS8je
         Nya4qVRhOJxtgYH8OLEG5jJ4+7irdC2X8rJumxzR7qMDHHL3hi3GRIZLH9wtJRDhYb4l
         F66cP6zPTPXFUc7nD05c4JjXENsNCf+s4m6UZCMuU5MUAO1IrA02LFpOctaiJBIHcAf+
         e2meX7kS5gGLV+eyO6q+BerCnKrQNv45tfFD6dSsnrz2q+OVJuYhk5n5l8N69Xrl6TCg
         Y1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCwDRHsjMshwUjrnqGW1EzKHumkWqiiCQKHVnFSnF9E=;
        b=tyT3HlhV/ppP7I73epp07k/BZQhWWyLvE52RPepYUilMDUI4XPrr5Unu22LMJCp+/q
         ksD/MKCK8mi85LrqURaXE9O90kl8UyLv6I0TIvcQ5R7RYmsHA/GLy0JUiwwMlVrrv7xR
         zsOp/ZVVGVmRig7D7jYuBWA4CTuFeiV4fOGWZ9EfYk8wvAUJbhkhtrnwTsWkQCif5LIQ
         zS9+O6TyLo/W1SI8JA/Bg3lWZCltXtciDP3mHunFlDNo19NAQhWA5uhwyV76oJ7JuEYE
         BveieJHEJeG1spztN/wB06uJC/aCSPlfpReOPOKqYEpcLbP/bWYhDzwxkSGwR5kpXrSU
         7Leg==
X-Gm-Message-State: APjAAAV2fcT27H3oKx/tAKKhUgX1nWpgwNEQxfKDLKMPQuQM8tSe4jN8
        avuPVn87EB/kaqXqiYOrZYCx9dETKzg=
X-Google-Smtp-Source: APXvYqxNeXNznXar9K/SaRmW1l/terky20bwTvI63gvGUqLPzCfSMQrwm9riTTcHnNu4NbIhrxwf8w==
X-Received: by 2002:a2e:4703:: with SMTP id u3mr424645lja.126.1573231551883;
        Fri, 08 Nov 2019 08:45:51 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id d4sm2727416lfi.32.2019.11.08.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:45:51 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v4 2/3] asus_wmi: Support fan boost mode on FX505DY/FX705DY
Date:   Fri,  8 Nov 2019 18:45:37 +0200
Message-Id: <20191108164537.3123-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108164317.2874-1-leonmaxx@gmail.com>
References: <20191108164317.2874-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ASUS FX505DY/FX705DY laptops fan boost mode is same as in other
TUF laptop models but have different ACPI device ID and different hotkey
code.

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c            | 29 ++++++++++++++++------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 723aa4d969dc..4f9c0b99f352 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -61,6 +61,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
 #define NOTIFY_KBD_FBM			0x99
+#define NOTIFY_KBD_FBM_2		0xae
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -195,6 +196,7 @@ struct asus_wmi {
 	int agfn_pwm;
 
 	bool fan_boost_mode_available;
+	u32 fan_boost_mode_dev_id;
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
@@ -1611,15 +1613,12 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 
 /* Fan mode *******************************************************************/
 
-static int fan_boost_mode_check_present(struct asus_wmi *asus)
+static int fan_boost_mode_check_device(struct asus_wmi *asus, u32 dev_id)
 {
 	u32 result;
 	int err;
 
-	asus->fan_boost_mode_available = false;
-
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
-				    &result);
+	err = asus_wmi_get_devstate(asus, dev_id, &result);
 	if (err) {
 		if (err == -ENODEV)
 			return 0;
@@ -1630,12 +1629,27 @@ static int fan_boost_mode_check_present(struct asus_wmi *asus)
 	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
 			(result & ASUS_FAN_BOOST_MODES_MASK)) {
 		asus->fan_boost_mode_available = true;
+		asus->fan_boost_mode_dev_id = dev_id;
 		asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
 	}
 
 	return 0;
 }
 
+static int fan_boost_mode_check_present(struct asus_wmi *asus)
+{
+	int err;
+
+	asus->fan_boost_mode_available = false;
+	err = fan_boost_mode_check_device(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE);
+
+	if (err || asus->fan_boost_mode_available)
+		return err;
+
+	return fan_boost_mode_check_device(asus,
+					   ASUS_WMI_DEVID_FAN_BOOST_MODE_2);
+}
+
 static int fan_boost_mode_write(struct asus_wmi *asus)
 {
 	int err;
@@ -1645,7 +1659,7 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
 	value = asus->fan_boost_mode;
 
 	pr_info("Set fan boost mode: %u\n", value);
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
+	err = asus_wmi_set_devstate(asus->fan_boost_mode_dev_id, value,
 				    &retval);
 	if (err) {
 		pr_warn("Failed to set fan boost mode: %d\n", err);
@@ -2000,7 +2014,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
+	if (asus->fan_boost_mode_available &&
+			(code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_FBM_2)) {
 		fan_boost_mode_switch_next(asus);
 		return;
 	}
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 60249e22e844..714782b193b3 100644
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
2.23.0

