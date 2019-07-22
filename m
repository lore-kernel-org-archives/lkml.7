Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DEC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DA5219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdXa6GX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbfGVV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:26:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34517 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGVV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:26:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so7060722edb.1;
        Mon, 22 Jul 2019 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bRZKFPZcTX7fMyUb8/I2gLfJHJqWPBkkotjXmJnSu0=;
        b=rdXa6GX1TcSZ5GStG9bQ1cyz3RvjQfJP/NfGkOVlWyse770pEjq7AaSe+8sci73fLH
         +x3rm5nT7/NnE12o4DKDD04ASsjmkuY+0L7b8GZqGDqvuIb3o8gtJQH6xNjOmWDYbH7T
         FrJrUKeFdeD9x8e0IqsxEcLju3naCChqYf/hOgTXCzs8WSbwbwBH3SrVptrplqdRnoQQ
         DNHzGxqSh2FKZLNt/oghEDFptRCJ5eBduQ2DCoBsonaDERNzVakjfIPtKAY7DQmVQ1XY
         nzl/0RxHwz5uy5s7OsJyhEPGNpMFBaDUqHI0Ws60F6l9z155aVzZuYOrurgKFJ71tv1o
         sMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bRZKFPZcTX7fMyUb8/I2gLfJHJqWPBkkotjXmJnSu0=;
        b=KPC0yc0o6mK/wn3GAWZqxDLQQt/baf57AaMK/yVp3wYf54sWyUC1TWV81L5jqFo7Lk
         DR+sq2Zf9tIelhlmK3jAlvSYW7hwMKsyPJchL4/ECwZpxSVBfXlsA5WOzxYqXpwWntGg
         fKmrFiXGxYYrAGmOjSKoGtDZkDl5eTyZl9FUdaca/OZGO9OGZ3nmOhuyG8OlFhR7gcwU
         cMZn+jcPQH1jJj/XbkcZJVsyisqin8MnkqqThuDttIY5x2DPHl1emCAdZc7FgvmFy6Ah
         nUERuHEsIEtAExpk65qmxH0uFJZt6BBcgJPcydhcDnnROv4b78VVgzQNZ8Yg1bQg2f+e
         hVng==
X-Gm-Message-State: APjAAAXbPeR6mStmeS2tH102HaaXQ2D9dTji6aN1wvKAoGyYZJZg/5HF
        SmbltpyC0khPMX9x7jrcOao=
X-Google-Smtp-Source: APXvYqw7dg/YwFhrgjgLsUOUlwUbBZaoENW9FClXuY2WxF6BmzPpNaxvrwXl9AvuopjNhllkKtaOoA==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25mr53899459eji.293.1563830789944;
        Mon, 22 Jul 2019 14:26:29 -0700 (PDT)
Received: from localhost.localdomain ([65.154.66.198])
        by smtp.gmail.com with ESMTPSA id a67sm11469524edf.6.2019.07.22.14.26.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:26:29 -0700 (PDT)
From:   stillcompiling@gmail.com
To:     Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 1/3] HID: core: reformat and reduce hid_printk macros
Date:   Mon, 22 Jul 2019 15:26:11 -0600
Message-Id: <20190722212613.24906-1-stillcompiling@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722163642.10417-2-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

Reformat hid_printk macros to use standard __VA_ARGS__ syntax
Remove hid_printk(), hid_emerg(), hid_crit(), and hid_alert().
Per Joe Perches these unused and likely never to be used.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/hid.h | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d770ab1a0479..b5e73331100e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1154,29 +1154,21 @@ int hid_pidff_init(struct hid_device *hid);
 #define hid_pidff_init NULL
 #endif
 
-#define dbg_hid(format, arg...)						\
+#define dbg_hid(fmt, ...)						\
 do {									\
 	if (hid_debug)							\
-		printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);	\
+		printk(KERN_DEBUG "%s: " fmt, __FILE__, ##__VA_ARGS__)	\
 } while (0)
 
-#define hid_printk(level, hid, fmt, arg...)		\
-	dev_printk(level, &(hid)->dev, fmt, ##arg)
-#define hid_emerg(hid, fmt, arg...)			\
-	dev_emerg(&(hid)->dev, fmt, ##arg)
-#define hid_crit(hid, fmt, arg...)			\
-	dev_crit(&(hid)->dev, fmt, ##arg)
-#define hid_alert(hid, fmt, arg...)			\
-	dev_alert(&(hid)->dev, fmt, ##arg)
-#define hid_err(hid, fmt, arg...)			\
-	dev_err(&(hid)->dev, fmt, ##arg)
-#define hid_notice(hid, fmt, arg...)			\
-	dev_notice(&(hid)->dev, fmt, ##arg)
-#define hid_warn(hid, fmt, arg...)			\
-	dev_warn(&(hid)->dev, fmt, ##arg)
-#define hid_info(hid, fmt, arg...)			\
-	dev_info(&(hid)->dev, fmt, ##arg)
-#define hid_dbg(hid, fmt, arg...)			\
-	dev_dbg(&(hid)->dev, fmt, ##arg)
+#define hid_err(hid, fmt, ...)				\
+	dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice(hid, fmt, ...)			\
+	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn(hid, fmt, ...)				\
+	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info(hid, fmt, ...)				\
+	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg(hid, fmt, ...)				\
+	dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
 
 #endif
-- 
2.21.0

