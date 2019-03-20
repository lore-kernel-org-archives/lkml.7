Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4221E218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VstqouIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfCTWn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:43:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52518 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:43:59 -0400
Received: by mail-it1-f194.google.com with SMTP id g17so1535645ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fl/CUxCABAmxe+Llf6wo6ebySjALKSa8m/h8/EOIlp0=;
        b=VstqouIzpbbIYmb/G3f7svpKqQJURMJ5qMKAxmtRzjNmWUm8vrp3BwqlM0UnE7oQJy
         4MpMycWJYWGWh+3HHyjZb+KnjCHpCavGxxZnJsbPYql4wNUNHsuu6eYbfS2HQ8xou5Yx
         616ZQKcEUGATIqvRJr+Ys1kmBNbGEhkdWr2aFwqdpQD/uIHx7AJD7rHPw9OKoJ7ukXga
         sPUBxGHxgHS4V2vfjx+Mgcwj9Uw9KguBPTQYRcsJ4bwd03CLVJ9J82ckFOZjMkqHgNGB
         fi4Wcabw47xq7yuuPkPiqWbW9KbqdIrWmq7UZdNboqNaZ3STfRkK3rPZPW5VwdFxdWZl
         Cj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fl/CUxCABAmxe+Llf6wo6ebySjALKSa8m/h8/EOIlp0=;
        b=lkGD1FFI4f3wZGss9pWYcaPASPDn5FZgX+BpdHW3XDwAOpuCQRbyjBUsnRhmaKZ/Sk
         y3jLeobtthDiPudbQEA9v7eEKu6fACBw3Tp+KxJUc1PfPjylwOh+0wsEEkUW2UXvP9i+
         uaf1Ce7cnca8uLMhgCuc30CCGwYeyvhBuRMiEXOwdWZHrG/rxjBk9swdKzoVQEuXop3H
         VvoBlSeAOanMMsr+/6TteKzVmt4TbuUjuvenKkSFj7vPeAtIdMaX4ZLqeq9qPtp6huvH
         cWGaYFv5+10g2oo6kyWh51HvhbUyrGWmFbq844LHft2FLdXWnXDZl6GJvwRCxna5dLsb
         aDMg==
X-Gm-Message-State: APjAAAXWQQtOARre969ll5L1xOLHp/b+rMK22pQ1+2/JJD/kgnpKVbhP
        CzTHavMUlpnxRtboChLmjXA=
X-Google-Smtp-Source: APXvYqykh7DvXUCYJV1nHh1vZAkAd9H7rKV0D9Fpw0Z6TaMPhIhZycwJhlfGEjpx8kTYNC4hmA75Aw==
X-Received: by 2002:a24:97d4:: with SMTP id k203mr585920ite.16.1553121837900;
        Wed, 20 Mar 2019 15:43:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id 139sm1805554itk.28.2019.03.20.15.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:43:57 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v3 1/3] staging: mt7621-mmc: Fix warning when reloading module with debug msgs enabled
Date:   Wed, 20 Mar 2019 16:42:03 -0600
Message-Id: <20190320224204.10243-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320224204.10243-1-thirtythreeforty@gmail.com>
References: <20190320224204.10243-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel complained:

    [  510.277151] WARNING: CPU: 0 PID: 395 at fs/proc/generic.c:360 proc_register+0xf0/0x108
    [  510.292891] proc_dir_entry '/proc/msdc_debug' already registered

when doing a modprobe/rmmod/modprobe of this module if debug messages
are compiled in.  Fix this by removing the proc entry when the module is
unloaded.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v1: Initial attempt
v2: Rebased from v1
v3: Use #ifdef in header file, not implementation

 drivers/staging/mt7621-mmc/dbg.c | 15 ++++++++++++---
 drivers/staging/mt7621-mmc/dbg.h |  9 +++++++--
 drivers/staging/mt7621-mmc/sd.c  |  5 +++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index fda3ba38ba37..2310f3bcc16e 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -294,9 +294,18 @@ static const struct file_operations msdc_debug_fops = {
 	.release	= single_release,
 };
 
-void msdc_debug_proc_init(void)
+// Keep ahold of the proc entry we create so it can be freed during
+// module removal
+struct proc_dir_entry *msdc_debug_proc_entry;
+
+void __init msdc_debug_proc_init(void)
 {
-	proc_create("msdc_debug", 0660, NULL, &msdc_debug_fops);
+	msdc_debug_proc_entry = proc_create("msdc_debug", 0660,
+					    NULL, &msdc_debug_fops);
+}
+
+void __exit msdc_debug_proc_deinit(void)
+{
+	proc_remove(msdc_debug_proc_entry);
 }
-EXPORT_SYMBOL_GPL(msdc_debug_proc_init);
 #endif
diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2d447b2d92ae..b6a09876d7ae 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -92,8 +92,13 @@ enum msdc_dbg {
 #define DBG_EVT_MASK        (DBG_EVT_ALL)
 
 extern unsigned int sd_debug_zone[4];
-#define TAG "msdc"
-void msdc_debug_proc_init(void);
+#ifdef MT6575_SD_DEBUG
+void __init msdc_debug_proc_init(void);
+void __exit msdc_debug_proc_deinit(void);
+#else
+static inline void msdc_debug_proc_init(void) {}
+static inline void msdc_debug_proc_deinit(void) {}
+#endif
 
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
 void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 40f23e200c7a..ff01872ab972 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1825,14 +1825,15 @@ static int __init mt_msdc_init(void)
 		return ret;
 	}
 
-#if defined(MT6575_SD_DEBUG)
 	msdc_debug_proc_init();
-#endif
+
 	return 0;
 }
 
 static void __exit mt_msdc_exit(void)
 {
+	msdc_debug_proc_deinit();
+
 	platform_driver_unregister(&mt_msdc_driver);
 }
 
-- 
2.21.0

