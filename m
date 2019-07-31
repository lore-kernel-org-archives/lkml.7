Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ADEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE9E206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcbdxqgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGaSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:06:58 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:46336 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:06:58 -0400
Received: by mail-yw1-f45.google.com with SMTP id z197so25266994ywd.13;
        Wed, 31 Jul 2019 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=RcbdxqgrG3y+GDCzQOvIQ2f0PpzXyiUA4YWz6EhGtPVJhAGwrLjg9i1yza5fKgkkfN
         Hfm3Hr2nA28+1PrGms493NV13/FF7icOG96uqLUg9/QjWMBQiyaZxRxq6fotEg85Vrns
         dIIRhE46xRxor3Wbjk/v7UrZko82uJ0/u2DS2NbX5/yi8R2uv+ZSZH1J5ldKhlKnrJhk
         V879z8qB9i7ika0xSmJ+50776YGZC8BCHXSGyACSGclch8PFPXygnMEH0okR6ObHJRQC
         5Wo6by+9U1ogSFBD84bXtKmemuV9oBfAmfcNxzr0Q3fd5P8zjQZOEo72ygdP6frqc8Z7
         CkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=JKV1wr547ApVkdhJvVye79Qvglu0moQE22H9mqKrbWJMdGIfTRifH5M6SG4+zp9V+b
         6Uwe4Ykw0cQK5GN122AjnFTrATb9xO4j+F0c8SayAsv0g27tTEbJXeHyhKnDDa2C0eiR
         NlL4eMv43a/EjeAtpSg+MD2pEOs0dkWAka25NdI0Su/7JVjQfzVv0RfqNVEzJ23wNDFI
         4a9viQAxOFHre8hB2YvbzSmg/q29yxSpO7Yw3i/helLSjQLJIq26q6wAIm0n7UPCuwJ0
         mKiPwL+no/jn1eAZqmE4ncySNr2OqRK/e1OegwQOP4GJ9AC9vNXq2S1XC96ZATdZIMTd
         6CAA==
X-Gm-Message-State: APjAAAWFMS8zbzRq5yzlGmDsmhjD6+Uuov+G2rgUSuZxjljjOb9OCsZj
        A+SWPfsNlzGbciTAc9AjNEwO7IE=
X-Google-Smtp-Source: APXvYqxGAvGmxT/Xvwx8ft7lfG43YgFrxFXLXKUFG1vnBgPqstbweBPflRhHUg2sXHrsPjONu7UtMA==
X-Received: by 2002:a81:3313:: with SMTP id z19mr75142313ywz.188.1564596417093;
        Wed, 31 Jul 2019 11:06:57 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id v68sm16426317ywe.23.2019.07.31.11.06.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:06:56 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 1/9] platform/x86: huawei-wmi: Rename guid and driver name
Date:   Wed, 31 Jul 2019 14:06:41 -0400
Message-Id: <20190731180641.30121-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-2-ayman.bagabas@gmail.com>
References: <20190731175255.25676-2-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
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


