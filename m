Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8FC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001E4208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOAXaniq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF3Fla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:30 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41827 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3Fl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id 2so6745293vso.8;
        Sat, 29 Jun 2019 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=tOAXaniq5JK92eAo4mvDn9Vl4LFpLvqTWv4qJ8jZ+7jsx3KhCTePu06gbaKs7V6MgI
         A5Z4Yo3leKLoqZTgYpXWhQETy9DxJpQjVgaF0Y7E1M8gpQ28HgMtj1TQR2E3rkmDJGtj
         +jxqzixcs/mFqH8mDLL4J+PlrHRUVF9x5b5OzE8FAFQjriTpgVNJ7SbGltyyazkyCNyv
         O72+KQiB4SDFEr/38EzWDNlB9A+LDxQ8p26I00a8RwKgWSolYqQRwd2hqPXN5nK1emRz
         dizNLE2RSMn7ZgD6pKCHY/Nxmcoqj3al40AMEYe45cBfQV6YwWL6LW5f+bLy51j/DDHq
         8slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df8HZ1GC9xOAmz5J1hSYCy+taJAv5J2Wpa+VxaLhh1Y=;
        b=B6nZqC+r+hM7GZyigqVlQCXPza/g8FyrbstHqEwggh+JqGe444cGWjfTKmvph0EZFn
         v2m4oEUIbv1LkZFfOatK12FpH9BBofOcDJeTrwC7/B2i/hJsZmV8RvtbM/M46+KZ9JrL
         CT9rripqI/FuTn3edDuqOneuYEra5xr58vJL9rjkrOLGYRNfvj+kPIL0gl56lVxlh16u
         6CxnE/Q8GWV7T8WoiFYoX7AC95upFFxe9svbFtVexSF8H7ioAorNc6uHnACUgRiGt6tK
         SdoUu/mEZN37pzhRjzVqVYkMo8uCEIlkm5R/rGFY3HTCxEsw3QTZ/Zo3q1Re3MxAG5yV
         M7zA==
X-Gm-Message-State: APjAAAXRG4cby8/FvBNJXjHPWMyQ+0AnUl/xeeNk/rvOnlajZa/Te7Xk
        LVJ1Sr6G/EitNjqzbeNB9A==
X-Google-Smtp-Source: APXvYqwJsrLcbzha/wqICM9mdlRLeUxbBmb9KHkFsRv6GEMQFbkF6080wk05pCUqHumpRowuy9ITNw==
X-Received: by 2002:a67:fb02:: with SMTP id d2mr10868712vsr.207.1561873288288;
        Sat, 29 Jun 2019 22:41:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:27 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 1/9] platform/x86: huawei-wmi: Rename guid and driver name
Date:   Sun, 30 Jun 2019 01:41:00 -0400
Message-Id: <20190630054108.19205-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
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

