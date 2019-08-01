Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66179C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EF5206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWZ6NePL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfHAAVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:21:46 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:44844 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfHAAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:21:45 -0400
Received: by mail-ua1-f46.google.com with SMTP id 8so27723110uaz.11;
        Wed, 31 Jul 2019 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=iWZ6NePLLvdpYtpdUrDP4B81YojQkVVPtVLycLkg/KimUPdGLMNdTk7KB7wXpo6FEI
         3hFxZvcq9fWUTtBdQreH4zAmHj/pfMrLx5i2M4OFEGYlYFVb0YE1E3cEKwabhk+6s5YY
         jnjFSpHT24y6pdN7/4o8BBgznLaPjEdsp+tC15MD9CJ9pLq620cYvUB1aCjauIpHD4wG
         tYf3dYj9zlMf5KOXHcnD1M4vT/U+Q5MgiEe6JTqhdSimVZGfCzwR6wtyF1AHdbxnk4E6
         9KxCch7FspPRyq87e5pZxijibkUCkVukRtd0AUmn8YxEOl5TV2fLXTv59I08/6rJxIEK
         MFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=SN28j07myZeYy4S80JwI3i3FfpSr+OmxaUXflbX20Bah+2/uH8E0QY7fpksQxW+WI+
         a+XSw5kGvFtIeYC7cKStT6c8PvfnKVCbXOx55sa/eLPsUaAD/l2WntKr57U+ZhQ4BRKG
         CqtUs9nBsdLFxeVeQx5HvcscV1jPhI1W764Wh7jxkzRMpvh9M4lCresl3N6SybCucl5m
         0wmncEye1HpklAgEYcoGnlfau4E/yHB48mnf/wm7K/NOOdUMlRbxpmGp1qtmYTpY1Hrw
         RD523l0rnY8dy1vcaEjHDBMDpl+Zt6q2Mvh9PAVqtfVgOcc6JVSO+Q6CEGLpBS45K1NX
         70JQ==
X-Gm-Message-State: APjAAAUhILSR09ToIhroe2RdtvppftSbgmvwTQ6OImzQpDJwcoIh+blm
        ImKO2Bzz2ZDY4ePhbKp27Q==
X-Google-Smtp-Source: APXvYqxf8crUUBE0vfQ/jlquarLweIXJcQWQL86PfaI+H1yAW3/tqtwLaltLDYyi2wkyNgvLgqQefQ==
X-Received: by 2002:a9f:248b:: with SMTP id 11mr80748010uar.9.1564618904336;
        Wed, 31 Jul 2019 17:21:44 -0700 (PDT)
Received: from localhost ([2601:902:c200:6512:2cfe:a221:51c6:22f1])
        by smtp.gmail.com with ESMTPSA id q29sm23116553vsl.3.2019.07.31.17.21.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 17:21:43 -0700 (PDT)
Date:   Wed, 31 Jul 2019 20:21:42 -0400
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 1/9] platform/x86: huawei-wmi: Rename guid and driver name
Message-ID: <20190731175255.25676-2-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
X-Mailer: git-send-email 2.20.1
X-TUID: foDDCMXX6own
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WMI device UID, AMW0 has a UID of HWMI. WMI0 is the device name
and doesn't have a UID so keep it as it is.

Change module description to reflect the upcoming changes.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 52fcac5b393a..a1159850a16c 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Huawei WMI hotkeys
+ *  Huawei WMI laptop extras driver
  *
  *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
  */
@@ -15,10 +15,12 @@
 /*
  * Huawei WMI GUIDs
  */
-#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
-#define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+#define HWMI_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
 
+/* Legacy GUIDs */
 #define WMI0_EXPENSIVE_GUID "39142400-C6A3-40fa-BADB-8A2652834100"
+#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+
 
 struct huawei_wmi_priv {
 	struct input_dev *idev;
@@ -37,7 +39,7 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
-	// Keyboard backlight
+	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
@@ -186,7 +188,7 @@ static int huawei_wmi_probe(struct wmi_device *wdev)
 
 static const struct wmi_device_id huawei_wmi_id_table[] = {
 	{ .guid_string = WMI0_EVENT_GUID },
-	{ .guid_string = AMW0_EVENT_GUID },
+	{ .guid_string = HWMI_EVENT_GUID },
 	{  }
 };
 
@@ -203,5 +205,5 @@ module_wmi_driver(huawei_wmi_driver);
 
 MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
-MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_DESCRIPTION("Huawei WMI laptop extras driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1


