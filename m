Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6827120818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKLVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:13:48 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37626 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727495AbfKLVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:46 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDiU8029695
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:44 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDdaQ007278
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:44 -0500
Received: by mail-qt1-f199.google.com with SMTP id 2so21196729qtg.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kG7Ptaq+86UuiddtLF3z6ZZhHPb5HLJn9YbpAAIlC6g=;
        b=H2L03Fp5vPmT0g7zWLDEp9ugkJNADf83iiSTlFJOBmkMSk3XbILOkpTV0iZGMLjCdZ
         eKXMWJcC851jpNc07RaRBiSzBDIwjM5IF0YZrBcoTJ++d503QxsbJIR8O9D0r3TtAW+T
         CjXvAssh9LQeDkNN0kDCS4lI2GXR4eXnyF6rxZ+49ysGhAy+w/3bksvQtTuVv877ks9R
         M6LL62uuHzH2Lv7qc3Y3WxjG28BqtLOlmO11uMbd55T8xoqoX4VayceDECnMkNQ286Wg
         v6Po41LvnaBxdwD8s9s5BKswVCwob3/g9sdJDHrlWQvDPS4fB41vMiUn1hZQgWR04Hj5
         rEyw==
X-Gm-Message-State: APjAAAWoE/xWoMzo3ulRL2GpkSMHz1wG3h5eBhv99Sts+1YokkUsZorM
        XOl4bV0zsQOFrf9nbjQ4pi5iqAPVpYxJnwr9vpqwFHVVB8XViC+dzRF60dBctWiuGNHORVZ+gH6
        WpR4CWOdpdSyonKvJ3erklrvuQSLfuPYHOTM=
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr33362160qtk.31.1573593218508;
        Tue, 12 Nov 2019 13:13:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVIlNCsK9Ac0q93isCUr3PgF+MgibBGZqIuHluMITzT2edSbTc9sATSaQOnX7hr6yi/9BQvQ==
X-Received: by 2002:ac8:1c03:: with SMTP id a3mr33362137qtk.31.1573593218178;
        Tue, 12 Nov 2019 13:13:38 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:37 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] staging: exfat: Clean up the namespace pollution part 2
Date:   Tue, 12 Nov 2019 16:12:32 -0500
Message-Id: <20191112211238.156490-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename all the bdev_* to exfat_bdev_*

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h        | 10 +++++-----
 drivers/staging/exfat/exfat_blkdev.c | 10 +++++-----
 drivers/staging/exfat/exfat_core.c   |  8 ++++----
 drivers/staging/exfat/exfat_super.c  | 16 ++++++++--------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 5efba3d4259b..5044523ccb97 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -842,13 +842,13 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 int multi_sector_write(struct super_block *sb, sector_t sec,
 		       struct buffer_head *bh, s32 num_secs, bool sync);
 
-void bdev_open(struct super_block *sb);
-void bdev_close(struct super_block *sb);
-int bdev_read(struct super_block *sb, sector_t secno,
+void exfat_bdev_open(struct super_block *sb);
+void exfat_bdev_close(struct super_block *sb);
+int exfat_bdev_read(struct super_block *sb, sector_t secno,
 	      struct buffer_head **bh, u32 num_secs, bool read);
-int bdev_write(struct super_block *sb, sector_t secno,
+int exfat_bdev_write(struct super_block *sb, sector_t secno,
 	       struct buffer_head *bh, u32 num_secs, bool sync);
-int bdev_sync(struct super_block *sb);
+int exfat_bdev_sync(struct super_block *sb);
 
 extern const u8 uni_upcase[];
 #endif /* _EXFAT_H */
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 0abae041f632..7bcd98b13109 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -8,7 +8,7 @@
 #include <linux/fs.h>
 #include "exfat.h"
 
-void bdev_open(struct super_block *sb)
+void exfat_bdev_open(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
@@ -23,14 +23,14 @@ void bdev_open(struct super_block *sb)
 	p_bd->opened = true;
 }
 
-void bdev_close(struct super_block *sb)
+void exfat_bdev_close(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	p_bd->opened = false;
 }
 
-int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
+int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	      u32 num_secs, bool read)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
@@ -65,7 +65,7 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	return -EIO;
 }
 
-int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
+int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	       u32 num_secs, bool sync)
 {
 	s32 count;
@@ -118,7 +118,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	return -EIO;
 }
 
-int bdev_sync(struct super_block *sb)
+int exfat_bdev_sync(struct super_block *sb)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 #ifdef CONFIG_EXFAT_KERNEL_DEBUG
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 2dc07e81bad0..5a01fc25f31d 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -2569,7 +2569,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_read(sb, sec, bh, 1, read);
+		ret = exfat_bdev_read(sb, sec, bh, 1, read);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2598,7 +2598,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_write(sb, sec, bh, 1, sync);
+		ret = exfat_bdev_write(sb, sec, bh, 1, sync);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2621,7 +2621,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_read(sb, sec, bh, num_secs, read);
+		ret = exfat_bdev_read(sb, sec, bh, num_secs, read);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
@@ -2649,7 +2649,7 @@ int multi_sector_write(struct super_block *sb, sector_t sec,
 	}
 
 	if (!p_fs->dev_ejected) {
-		ret = bdev_write(sb, sec, bh, num_secs, sync);
+		ret = exfat_bdev_write(sb, sec, bh, num_secs, sync);
 		if (ret != 0)
 			p_fs->dev_ejected = 1;
 	}
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index cf094458b5d2..7309053105d8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -289,7 +289,7 @@ static DEFINE_MUTEX(z_mutex);
 static inline void fs_sync(struct super_block *sb, bool do_sync)
 {
 	if (do_sync)
-		bdev_sync(sb);
+		exfat_bdev_sync(sb);
 }
 
 /*
@@ -361,7 +361,7 @@ static int ffsMountVol(struct super_block *sb)
 	p_fs->dev_ejected = 0;
 
 	/* open the block device */
-	bdev_open(sb);
+	exfat_bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
 		printk(KERN_INFO "EXFAT: maont failed - sector size %d less than blocksize %ld\n",
@@ -385,7 +385,7 @@ static int ffsMountVol(struct super_block *sb)
 	/* check the validity of PBR */
 	if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
 		brelse(tmp_bh);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
@@ -407,26 +407,26 @@ static int ffsMountVol(struct super_block *sb)
 	brelse(tmp_bh);
 
 	if (ret) {
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 
 	ret = load_alloc_bitmap(sb);
 	if (ret) {
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 	ret = load_upcase_table(sb);
 	if (ret) {
 		free_alloc_bitmap(sb);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		goto out;
 	}
 
 	if (p_fs->dev_ejected) {
 		free_upcase_table(sb);
 		free_alloc_bitmap(sb);
-		bdev_close(sb);
+		exfat_bdev_close(sb);
 		ret = -EIO;
 		goto out;
 	}
@@ -461,7 +461,7 @@ static int ffsUmountVol(struct super_block *sb)
 	buf_release_all(sb);
 
 	/* close the block device */
-	bdev_close(sb);
+	exfat_bdev_close(sb);
 
 	if (p_fs->dev_ejected) {
 		pr_info("[EXFAT] unmounted with media errors. Device is already ejected.\n");
-- 
2.24.0

