Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D942147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asxiamFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfCSCVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:24 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36434 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCSCUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:36 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so2426427itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6L9u+5sfGiPTE3aM9s6FFeu91hanztAVaLTnZ+ksu4=;
        b=asxiamFXthx9htnSDZPCK3RT5FImXMg2Xgo+ekQzaB3J+M2PWMLfiSEHJ1S25JSjei
         X8/Nu6LzxSXikMQWP+74llfuLK3lN8TOFtTb8DJ8G6TDm0+BG8cQewJ7YmpeeiTtJ+8X
         fl5VhpG6+LYTHTK8YVTCneSQICGSLhPyWmn8FT+87e8zvUVpMLrUgaNSj9YT6F6/r3wK
         pOg4ibYQgj5K3TDBN0EGuHIehxcthNZF8uE+QDi0qxgHFUYc6s4mAEs2EDWDfXZpEEGh
         WapN1UWbg/J9rJp2rv9VZXNZZASuLuWaLCs1216k20eulGcfQnwyM6yU3smIebBiZzOp
         0IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6L9u+5sfGiPTE3aM9s6FFeu91hanztAVaLTnZ+ksu4=;
        b=k6hf469rtYS3PSynLEHGJ2k8TPqS5pEZQNnXuGSG+QAAZ+DWOQIaobFf2D8ljUU6OG
         TtNpYapsMNvPwBg1Y5iw+2xtrcqg7fkoCnHHGiuuRYJ9FFelhkK7GJPJHRedgzR5L2kA
         NWG1DJdMwuO8S7TqECv0l+YIPUEVI37Svul81dH7Jyb8jLqQGStf8wz3ptpETvPse611
         JFktvvrs53X8C98jF2uTZhNk+xwTCkX+DdzGmNrQV/kGbpc5NeYWFU+7anlf+AOVsOAy
         XF7h6sntOYRM0fjmyc+S6xAnRfO0qEx4aLdogZfM9aC8TpuFZQJGxyv3uIlaDIZcxEUp
         nEtQ==
X-Gm-Message-State: APjAAAWHphS+1v2lx8aNx3B59IyYKCGPRn4DOv/ZK6tHLapSfpIjNZK9
        hwG/bQXXlCNLAwZSRfGYLB4=
X-Google-Smtp-Source: APXvYqxv/5Vp0rezmupAplX7bTtHUnSni4NhfbzDSQaCslHXCyuNYjPmtXhj9RGwQz2WEkItKKnJ5Q==
X-Received: by 2002:a24:e00e:: with SMTP id c14mr250737ith.8.1552962036255;
        Mon, 18 Mar 2019 19:20:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:35 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 03/11] staging: mt7621-mmc: Fix warning when reloading module with debug msgs enabled
Date:   Mon, 18 Mar 2019 20:20:04 -0600
Message-Id: <20190319022012.11051-4-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
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
 drivers/staging/mt7621-mmc/dbg.c | 15 ++++++++++++---
 drivers/staging/mt7621-mmc/dbg.h |  3 ++-
 drivers/staging/mt7621-mmc/sd.c  |  4 ++++
 3 files changed, 18 insertions(+), 4 deletions(-)

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
index 2d447b2d92ae..d100324aa3fe 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -93,7 +93,8 @@ enum msdc_dbg {
 
 extern unsigned int sd_debug_zone[4];
 #define TAG "msdc"
-void msdc_debug_proc_init(void);
+void __init msdc_debug_proc_init(void);
+void __exit msdc_debug_proc_deinit(void);
 
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
 void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 9074848a8251..306b3b46f7c9 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1841,6 +1841,10 @@ static int __init mt_msdc_init(void)
 
 static void __exit mt_msdc_exit(void)
 {
+#if defined(MT6575_SD_DEBUG)
+	msdc_debug_proc_deinit();
+#endif
+
 	platform_driver_unregister(&mt_msdc_driver);
 }
 
-- 
2.21.0

