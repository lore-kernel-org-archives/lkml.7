Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1ABC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 23:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC062086A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 23:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBsWkQDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfI1XTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 19:19:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38235 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfI1XTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 19:19:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id m16so8170434oic.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08U8kTj+7ryuF4wWVDEoa5n7c+9tXfifBOgV/g1kdoc=;
        b=dBsWkQDFUaMjDerdVT/Mn5JeLyErILKZRtAfzEfKowY1YhLX2EVfCBVw7FXBqL7JNm
         8Gfc4/RTKsIkbEyyYaOTWcnCB/g3JoRQhrzb4ObT0CjzvkwkBbF2V5xL50yHK+ZZWR6U
         mNvYu7+7eEK89SyK9WP83EmXd0LxO1QwIEttJw8WiHtk5zx/+UCF8h9kiHprefS/C4kU
         f9mjEky6rPeUrOgPt+3CVbqYI7HG+ErIq5uN1wgnEn9Tfl3qVg0bQBLDr0r6xbfKyu+l
         b0zZa0XvJGHi6fS8BqJfln4MrzjZyxM2GvA9aJYHUEmId7K928+LB6T+pGS5OEZrXUnA
         WwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08U8kTj+7ryuF4wWVDEoa5n7c+9tXfifBOgV/g1kdoc=;
        b=P5wcZkXNtgf+u48pZivrzMPJM1/TED69i5qplY7LguL/lOkgjK259QklCqUJhNTnRf
         q8ypg+VXmkAYs7ZF39vnJHEa0/f2E+4x9pU1g940lORaqOhxeIykof1J/ujpyWru216K
         6hdBoapx0/NcC7+G1G/IYXhvv1+M/QsDHEy9zpyUutSd2h/ffiryeHxnnRAsiy6MqS0F
         JUwDQX4wUnpIBOcZpJJjr9MfJhkFiIUf+D1sEhkx8BLZeA6xt9uxbBMx8vBn/ygXwMeQ
         KOUNtpASBrM1y0xqrIkIysmzAkANyNzO06SJqYs4NZvup2IFzIl00cAL12CV3of14orh
         w1Aw==
X-Gm-Message-State: APjAAAVJk2Tav1e+6SxIsQjz3mkK2dUB8LsanGMPfT+jEHeBV0wKbsKK
        4GgJbsLJFc1QvQNS/kaJgHQ=
X-Google-Smtp-Source: APXvYqwl2Lec9Lxg2DpYBKwaU2Wgo4r5Hpw9nW1el6IAIrmMXTIJq3uWZb62eQWuZZ+0ufrYVOzP/A==
X-Received: by 2002:aca:d708:: with SMTP id o8mr12667771oig.68.1569712755799;
        Sat, 28 Sep 2019 16:19:15 -0700 (PDT)
Received: from localhost (ip72-210-101-152.tu.ok.cox.net. [72.210.101.152])
        by smtp.gmail.com with ESMTPSA id 34sm2402154otf.55.2019.09.28.16.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 16:19:15 -0700 (PDT)
From:   Jesse Barton <jessebarton95@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jesse Barton <jessebarton95@gmail.com>
Subject: [PATCH] Staging: exfat: exfat_super.c: fixed camelcase coding style issue
Date:   Sat, 28 Sep 2019 18:19:10 -0500
Message-Id: <20190928231910.16898-1-jessebarton95@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..665eb25e318d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -342,7 +342,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
 }
 
-static int ffsMountVol(struct super_block *sb)
+static int ffs_mount_vol(struct super_block *sb)
 {
 	int i, ret;
 	struct pbr_sector_t *p_pbr;
@@ -446,7 +446,7 @@ static int ffsMountVol(struct super_block *sb)
 	return ret;
 }
 
-static int ffsUmountVol(struct super_block *sb)
+static int ffs_umount_vol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	int err = FFS_SUCCESS;
@@ -518,7 +518,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	return err;
 }
 
-static int ffsSyncVol(struct super_block *sb, bool do_sync)
+static int ffs_sync_vol(struct super_block *sb, bool do_sync)
 {
 	int err = FFS_SUCCESS;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -3043,7 +3043,7 @@ static int exfat_file_release(struct inode *inode, struct file *filp)
 	struct super_block *sb = inode->i_sb;
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
-	ffsSyncVol(sb, false);
+	ffs_sync_vol(sb, false);
 	return 0;
 }
 
@@ -3460,7 +3460,7 @@ static void exfat_put_super(struct super_block *sb)
 	if (__is_sb_dirty(sb))
 		exfat_write_super(sb);
 
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 
 	sb->s_fs_info = NULL;
 	exfat_free_super(sbi);
@@ -3473,7 +3473,7 @@ static void exfat_write_super(struct super_block *sb)
 	__set_sb_clean(sb);
 
 	if (!sb_rdonly(sb))
-		ffsSyncVol(sb, true);
+		ffs_sync_vol(sb, true);
 
 	__unlock_super(sb);
 }
@@ -3485,7 +3485,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	if (__is_sb_dirty(sb)) {
 		__lock_super(sb);
 		__set_sb_clean(sb);
-		err = ffsSyncVol(sb, true);
+		err = ffs_sync_vol(sb, true);
 		__unlock_super(sb);
 	}
 
@@ -3865,10 +3865,10 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	sb_min_blocksize(sb, 512);
 	sb->s_maxbytes = 0x7fffffffffffffffLL;    /* maximum file size */
 
-	ret = ffsMountVol(sb);
+	ret = ffs_mount_vol(sb);
 	if (ret) {
 		if (!silent)
-			pr_err("[EXFAT] ffsMountVol failed\n");
+			pr_err("[EXFAT] ffs_mount_vol failed\n");
 
 		goto out_fail;
 	}
@@ -3919,7 +3919,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_fail2:
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 out_fail:
 	if (root_inode)
 		iput(root_inode);
-- 
2.23.0

