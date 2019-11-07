Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C21C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93439214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz6MCXfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfKGXEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:04:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43269 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfKGXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:04:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id y23so4107281ljh.10;
        Thu, 07 Nov 2019 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJ905JhgVEMWkxx1d3CbO+F8gnJEKM2/B3X+ka6FihM=;
        b=Jz6MCXfc18X4aCt4FPfRBM9pzhfePwV7t/Tn2fey66tQnJGFJ3sQlyH4LEIzp69lfA
         8OlZIh+bwlJO4wR9LTmcQtTSirrCMOyha33MSVpn6tyQHBFxVBdmY0f0/DJ5BAteoTsp
         hBs5Q+fof4bVTrOJfuyUvsFytTRDwuRgT3kdXu60n4e1Tu/z/L9W4tdHFPmsqrXtypLk
         Z7kM8dDEgVx1zRr5ZqqACFlyuGKvWUTphAaeD/oHFUiwQYFsisbLfA/rhmllL5SXHP9r
         JlHbRCAi4Y2RDI6bE28R32G/vj2U+slGCcU/zsWizmxWFl2O3u5RmeP7Kme2paRB2NOG
         2NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJ905JhgVEMWkxx1d3CbO+F8gnJEKM2/B3X+ka6FihM=;
        b=ebhHwwW4NApsK7r+fgkb2L+0Cc5ZwYQUWo9clOdhuSkFKoK/5V/8UeU2gd6nOppGUF
         kapzDwl4kkBq36A6EjVCTWtngVUClhkaTHuP3FtxCC3PJUHolk6GEgFnJ9b9tRLZZAuJ
         5Vu33JIcTg3V+9gMJ/gEOH/4qCHkOYrXWwS8LjA6k20atwmUrZQto4/2f/UPme78LTdc
         mYzrV+Vxtz6543KHlHDVEi253KkUXzAWCQHtAB3+u0sPoC0mQ9+Q6kz+V6n79kGa/Pwx
         YkbiKZX1itQHZ8hG0s9eK7Rtyzi0tO6o4EbFPdMEkLn6qyVHbkg/rdy1LJGFfukW5MNf
         abgQ==
X-Gm-Message-State: APjAAAVXCdBHI/i58M3f1rdZ8QkV7RUZUFXMVBVrI7QrrRDZQUBwOu26
        XYyTmmMNCdfsZWxUC988XG7LRlcpFhM=
X-Google-Smtp-Source: APXvYqxa5u3IKz4aukYucY3WwsSeSoKwJzFuIh6+SbpspCEokV5eGn04QxPo1da7+O8gggJK8dYAVg==
X-Received: by 2002:a2e:63c9:: with SMTP id s70mr4422997lje.73.1573167852432;
        Thu, 07 Nov 2019 15:04:12 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id 77sm2219131lfj.41.2019.11.07.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:04:11 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v3 2/3] asus_wmi: Support fan boost mode on FX505DY/FX705DY
Date:   Fri,  8 Nov 2019 01:04:01 +0200
Message-Id: <20191107230401.30836-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107230105.30574-1-leonmaxx@gmail.com>
References: <20191107230105.30574-1-leonmaxx@gmail.com>
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
 drivers/platform/x86/asus-wmi.c            | 42 +++++++++++++++-------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 723aa4d969dc..311658807dfe 100644
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
 
@@ -1611,31 +1613,46 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 
 /* Fan mode *******************************************************************/
 
-static int fan_boost_mode_check_present(struct asus_wmi *asus)
+static int fan_boost_mode_check_device(struct asus_wmi *asus, u32 dev_id)
 {
 	u32 result;
 	int err;
 
-	asus->fan_boost_mode_available = false;
+	err = asus_wmi_get_devstate(asus, dev_id, &result);
 
-	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		else
-			return err;
-	}
+	if (err)
+		return err;
 
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
+	if (err && err != -ENODEV)
+		return err;
+	else if (asus->fan_boost_mode_available)
+		return 0;
+
+	err = fan_boost_mode_check_device(asus,
+					  ASUS_WMI_DEVID_FAN_BOOST_MODE_2);
+	if (err == -ENODEV)
+		return 0;
+
+	return err;
+}
+
 static int fan_boost_mode_write(struct asus_wmi *asus)
 {
 	int err;
@@ -1645,7 +1662,7 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
 	value = asus->fan_boost_mode;
 
 	pr_info("Set fan boost mode: %u\n", value);
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
+	err = asus_wmi_set_devstate(asus->fan_boost_mode_dev_id, value,
 				    &retval);
 	if (err) {
 		pr_warn("Failed to set fan boost mode: %d\n", err);
@@ -2000,7 +2017,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
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

