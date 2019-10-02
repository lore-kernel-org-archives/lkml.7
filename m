Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEBC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6821920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajn7nzoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfJBPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:17:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45021 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfJBPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:17:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so10491856pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DZSOt9Pzw/sZocePyfLHQpL8Fkq0jbtYd2wgMDKhCqM=;
        b=Ajn7nzoWgwuFExiQu4a64f5qiRKcBxnoUUA2BEjU4mmf93CJyplrjXQD4sA3IYpBF+
         SBdS/dd/ukcqblpmQhU1pSRs0U6oVi2zUasvgBZNH2Dz0mj9SWEuLBmfzam1WjbI6TOH
         ranrd13sFUSaloX3j9J07mIF/nXR5kPZ2Ou0feXo0CvjbLMwWQwtMKm23nrouwJn4z6M
         MZtXGGQ0zVODOo6bOm/aQLUh1cJl9PI2aQ5BO7LFVhSxc7TnzzhDhXydP7LiygwiMLqV
         aj3ZWg0vakY+dp0u484aod38Fxenaq4vfQ4DINteuItZdxQxyS1nJHm0lmukLYTCNx10
         xmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DZSOt9Pzw/sZocePyfLHQpL8Fkq0jbtYd2wgMDKhCqM=;
        b=o8EG7A7W/YyyIMVCcD2DGOKCpQe0lT7k/Z0eGNKVMiWSX3102/1XmeL2BIehKw3I8e
         I0gI93ywbxo2d/D5sTGOmSzeUWHHUgp4NBCL6Bdwk4d62frSbr0L14eJGRLxOHZdRSjI
         4eqk5YLtoVwtvY9FHUTIb5qpYLRnWfeT7yrhx4pDZdoIQpwpHg79NPLefWQ8w20qD8pB
         z0DxhanHM8qrNnS7zQ0jVavBYoa0tcm8fSs5SSf3V+GfNzDSQHIsL/FubzQ8n0zPvvs7
         qYI9XIBOkA8ozTE6DBL/gYIm9Mq+fxYo96LW9fpHvLLZH6M4kTiD6KbT5vZPGGYrCQuc
         9S/A==
X-Gm-Message-State: APjAAAXeRDm8RYYsJ8wukoCWNW1YZXXtNmn5KQMmIGbOvvCoYg6nlpBB
        3dlrXV4kMZfaxy61pgkU79EDa/td
X-Google-Smtp-Source: APXvYqyFO35UL16HG5jpoiu0hk9yaM4WsKFIVqvWMZWwVLFqGkfUZpOxTcNsoLLfJ6lnXaz/NvTmeg==
X-Received: by 2002:a62:1888:: with SMTP id 130mr5274314pfy.72.1570029435297;
        Wed, 02 Oct 2019 08:17:15 -0700 (PDT)
Received: from SD ([106.222.11.213])
        by smtp.gmail.com with ESMTPSA id q71sm6509341pjb.26.2019.10.02.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:17:14 -0700 (PDT)
Date:   Wed, 2 Oct 2019 20:47:03 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: use bdev_sync function directly where needed
Message-ID: <20191002151703.GA6594@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs_sync() is wrapper to bdev_sync(). When fs_sync is called with
non-zero argument, bdev_sync gets called.

Most instances of fs_sync is called with false and very few with
true. Refactor this and makes direct call to bdev_sync() where
needed and removes fs_sync definition.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 229ecabe7a93..3d3b0f0eebdc 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -285,12 +285,6 @@ static const struct dentry_operations exfat_dentry_ops = {
 
 static DEFINE_SEMAPHORE(z_sem);
 
-static inline void fs_sync(struct super_block *sb, bool do_sync)
-{
-	if (do_sync)
-		bdev_sync(sb);
-}
-
 /*
  * If ->i_mode can't hold S_IWUGO (i.e. ATTR_RO), we use ->i_attrs to
  * save ATTR_RO instead of ->i_mode.
@@ -458,7 +452,6 @@ static int ffsUmountVol(struct super_block *sb)
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
 
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
 	if (p_fs->vol_type == EXFAT) {
@@ -527,7 +520,9 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 	down(&p_fs->v_sem);
 
 	/* synchronize the file system */
-	fs_sync(sb, do_sync);
+	if (do_sync)
+		bdev_sync(sb);
+
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
 	if (p_fs->dev_ejected)
@@ -667,7 +662,6 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	ret = create_file(inode, &dir, &uni_name, mode, fid);
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1040,7 +1034,6 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 	}
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1180,7 +1173,6 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		fid->rwoffset = fid->size;
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1328,7 +1320,6 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	}
 out:
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1390,7 +1381,6 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1479,7 +1469,6 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	}
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -1917,7 +1906,6 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 	ret = create_dir(inode, &dir, &uni_name, fid);
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
@@ -2178,7 +2166,6 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	fid->flags = (p_fs->vol_type == EXFAT) ? 0x03 : 0x01;
 
 #ifdef CONFIG_EXFAT_DELAYED_SYNC
-	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
 #endif
 
-- 
2.20.1

