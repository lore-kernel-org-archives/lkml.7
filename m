Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB055CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXgHWT0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ3BFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:05:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:05:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so395472wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/4BZGd4O1yv6lCbqmKKgvt0nUlmbNU11wmyhOv3bw0=;
        b=QXgHWT0KZ/ADd5UM2sUsqDTR2hP1+P3dwrN+R0MuU4V53UgEcHktzqbmSC4FBkgd+R
         djJc2njD5g+iNU5Z/YD1CzboPO+PrNgTarREy5csnRUbxasN01CyV7p5mv08w/TpK8Ib
         2u4/Cgxs9H9Z1RRtoHf0Lb9SNi+jGXZUhWxrfskQagAwz5qfKdzKCODNdGLTiNH17d14
         buHZHoXj6NPteS9R8uHCmX7GABVdTkmId/DESdWPPToUyS/tJutMDYnbcu7dc3ia7zAv
         3aP6VTHX5KCCEX3MJPnqcFWEpCkVP/GVTs2bSno59iINoK4PHytXikpTTKPGRjVCe+Sp
         M/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/4BZGd4O1yv6lCbqmKKgvt0nUlmbNU11wmyhOv3bw0=;
        b=Ipt7oUSNGz6Bfd2vK6OV656F8oqGCQO3n6rqbO4owEhZwCAYjO9VBqxdAdhymb9//P
         5X2uFnnfdpuEIJFuaYsQJXPXtNbI/HcQc4Vps9jH/DA/6PBYzHFLA5md8dKBL/odvLVk
         EwS+iU5d5EHn9DsP4zrucU22Ui6J1Q75tPide9DisXpuP1OWyr+xTup//bl5LdEek48f
         W8mZl7XF42W0/QCiNUAYzzHzyReIm/clR0EcbgO3Z9r++VWuclIpGeF9jyEzZOzRhBFd
         9yBGJKOWm9YDN3uouFsndyGGRKbLkJnhSnUQ7w95M3LhmssPPVZyajAh88jF66wrOb69
         e6Rg==
X-Gm-Message-State: APjAAAUF5+tWshjotl6Go4VWxKd/3SQUksfA2DflnxSfaWgh7FHE9VPV
        e0OgN80z9fdmYX22Vb3VZQQ=
X-Google-Smtp-Source: APXvYqzcm1HO4FsbbrKaP6O6XOhdapTQEeBs+pJ1P7eAaKvml8i1b4kujpThShlFocJyBCgOHHDU6A==
X-Received: by 2002:adf:e886:: with SMTP id d6mr10045425wrm.188.1572397503985;
        Tue, 29 Oct 2019 18:05:03 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id r5sm608402wrl.86.2019.10.29.18.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:05:03 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 5/6] staging: exfat: avoid multiple assignments
Date:   Wed, 30 Oct 2019 02:03:27 +0100
Message-Id: <20191030010328.10203-6-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030010328.10203-1-jroi.martin@gmail.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:

	CHECK: multiple assignments should be avoided

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_core.c  |  3 +-
 drivers/staging/exfat/exfat_super.c | 90 +++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 4d6ea5c809d3..f446e6e6c4ee 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -470,7 +470,8 @@ s32 exfat_count_used_clusters(struct super_block *sb)
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
-	map_i = map_b = 0;
+	map_i = 0;
+	map_b = 0;
 
 	for (i = 2; i < p_fs->num_clusters; i += 8) {
 		k = *(((u8 *)p_fs->vol_amap[map_i]->b_data) + map_b);
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 401f057fe924..278270a3cad6 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -864,7 +864,8 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	while (count > 0) {
 		clu_offset = (s32)(fid->rwoffset >> p_fs->cluster_size_bits);
-		clu = last_clu = fid->start_clu;
+		clu = fid->start_clu;
+		last_clu = fid->start_clu;
 
 		if (fid->flags == 0x03) {
 			if ((clu_offset > 0) && (clu != CLUSTER_32(~0))) {
@@ -2351,6 +2352,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			bool excl)
 {
 	struct super_block *sb = dir->i_sb;
+	struct timespec64 curtime;
 	struct inode *inode;
 	struct file_id_t fid;
 	loff_t i_pos;
@@ -2375,7 +2377,10 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		goto out;
 	}
 	INC_IVERSION(dir);
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	curtime = current_time(dir);
+	dir->i_ctime = curtime;
+	dir->i_mtime = curtime;
+	dir->i_atime = curtime;
 	if (IS_DIRSYNC(dir))
 		(void)exfat_sync_inode(dir);
 	else
@@ -2389,7 +2394,10 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		goto out;
 	}
 	INC_IVERSION(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
+	inode->i_ctime = curtime;
 	/*
 	 * timestamp is already written, so mark_inode_dirty() is unnecessary.
 	 */
@@ -2522,6 +2530,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	struct super_block *sb = dir->i_sb;
+	struct timespec64 curtime;
 	int err;
 
 	__lock_super(sb);
@@ -2539,14 +2548,18 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 		goto out;
 	}
 	INC_IVERSION(dir);
-	dir->i_mtime = dir->i_atime = current_time(dir);
+	curtime = current_time(dir);
+	dir->i_mtime = curtime;
+	dir->i_atime = curtime;
 	if (IS_DIRSYNC(dir))
 		(void)exfat_sync_inode(dir);
 	else
 		mark_inode_dirty(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
 	exfat_detach(inode);
 	remove_inode_hash(inode);
 
@@ -2560,6 +2573,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 			 const char *target)
 {
 	struct super_block *sb = dir->i_sb;
+	struct timespec64 curtime;
 	struct inode *inode;
 	struct file_id_t fid;
 	loff_t i_pos;
@@ -2597,7 +2611,10 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	}
 
 	INC_IVERSION(dir);
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	curtime = current_time(dir);
+	dir->i_ctime = curtime;
+	dir->i_mtime = curtime;
+	dir->i_atime = curtime;
 	if (IS_DIRSYNC(dir))
 		(void)exfat_sync_inode(dir);
 	else
@@ -2611,7 +2628,10 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 		goto out;
 	}
 	INC_IVERSION(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
+	inode->i_ctime = curtime;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	EXFAT_I(inode)->target = kmemdup(target, len + 1, GFP_KERNEL);
@@ -2632,6 +2652,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
+	struct timespec64 curtime;
 	struct inode *inode;
 	struct file_id_t fid;
 	loff_t i_pos;
@@ -2656,7 +2677,10 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 	}
 	INC_IVERSION(dir);
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	curtime = current_time(dir);
+	dir->i_ctime = curtime;
+	dir->i_mtime = curtime;
+	dir->i_atime = curtime;
 	if (IS_DIRSYNC(dir))
 		(void)exfat_sync_inode(dir);
 	else
@@ -2671,7 +2695,10 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 	}
 	INC_IVERSION(inode);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
+	inode->i_ctime = curtime;
 	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
 
 	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
@@ -2687,6 +2714,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	struct super_block *sb = dir->i_sb;
+	struct timespec64 curtime;
 	int err;
 
 	__lock_super(sb);
@@ -2710,7 +2738,9 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out;
 	}
 	INC_IVERSION(dir);
-	dir->i_mtime = dir->i_atime = current_time(dir);
+	curtime = current_time(dir);
+	dir->i_mtime = curtime;
+	dir->i_atime = curtime;
 	if (IS_DIRSYNC(dir))
 		(void)exfat_sync_inode(dir);
 	else
@@ -2718,7 +2748,9 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	drop_nlink(dir);
 
 	clear_nlink(inode);
-	inode->i_mtime = inode->i_atime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
 	exfat_detach(inode);
 	remove_inode_hash(inode);
 
@@ -2734,6 +2766,7 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct inode *old_inode, *new_inode;
 	struct super_block *sb = old_dir->i_sb;
+	struct timespec64 curtime;
 	loff_t i_pos;
 	int err;
 
@@ -2767,8 +2800,11 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 	}
 	INC_IVERSION(new_dir);
-	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
-				current_time(new_dir);
+	curtime = current_time(new_dir);
+	new_dir->i_ctime = curtime;
+	new_dir->i_mtime = curtime;
+	new_dir->i_atime = curtime;
+
 	if (IS_DIRSYNC(new_dir))
 		(void)exfat_sync_inode(new_dir);
 	else
@@ -2790,7 +2826,9 @@ static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 			inc_nlink(new_dir);
 	}
 	INC_IVERSION(old_dir);
-	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
+	curtime = current_time(old_dir);
+	old_dir->i_ctime = curtime;
+	old_dir->i_mtime = curtime;
 	if (IS_DIRSYNC(old_dir))
 		(void)exfat_sync_inode(old_dir);
 	else
@@ -2814,13 +2852,16 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 {
 	struct address_space *mapping = inode->i_mapping;
 	loff_t start = i_size_read(inode), count = size - i_size_read(inode);
+	struct timespec64 curtime;
 	int err, err2;
 
 	err = generic_cont_expand_simple(inode, size);
 	if (err != 0)
 		return err;
 
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_ctime = curtime;
+	inode->i_mtime = curtime;
 	mark_inode_dirty(inode);
 
 	if (IS_SYNC(inode)) {
@@ -2896,6 +2937,7 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct fs_info_t *p_fs = &sbi->fs_info;
+	struct timespec64 curtime;
 	int err;
 
 	__lock_super(sb);
@@ -2914,7 +2956,9 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 	if (err)
 		goto out;
 
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_ctime = curtime;
+	inode->i_mtime = curtime;
 	if (IS_DIRSYNC(inode))
 		(void)exfat_sync_inode(inode);
 	else
@@ -3215,6 +3259,7 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
+	struct timespec64 curtime;
 	int err;
 
 	err = generic_write_end(file, mapping, pos, len, copied, pagep, fsdata);
@@ -3223,7 +3268,9 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
 		exfat_write_failed(mapping, pos + len);
 
 	if (!(err < 0) && !(fid->attr & ATTR_ARCHIVE)) {
-		inode->i_mtime = inode->i_ctime = current_time(inode);
+		curtime = current_time(inode);
+		inode->i_mtime = curtime;
+		inode->i_ctime = curtime;
 		fid->attr |= ATTR_ARCHIVE;
 		mark_inode_dirty(inode);
 	}
@@ -3674,7 +3721,8 @@ static int parse_options(char *options, int silent, int *debug,
 
 	opts->fs_uid = current_uid();
 	opts->fs_gid = current_gid();
-	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
+	opts->fs_fmask = current->fs->umask;
+	opts->fs_dmask = current->fs->umask;
 	opts->allow_utime = U16_MAX;
 	opts->codepage = exfat_default_codepage;
 	opts->iocharset = exfat_default_iocharset;
@@ -3788,6 +3836,7 @@ static int exfat_read_root(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct fs_info_t *p_fs = &sbi->fs_info;
+	struct timespec64 curtime;
 	struct dir_entry_t info;
 
 	EXFAT_I(inode)->fid.dir.dir = p_fs->root_dir;
@@ -3818,7 +3867,10 @@ static int exfat_read_root(struct inode *inode)
 	EXFAT_I(inode)->mmu_private = i_size_read(inode);
 
 	exfat_save_attr(inode, ATTR_SUBDIR);
-	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	curtime = current_time(inode);
+	inode->i_mtime = curtime;
+	inode->i_atime = curtime;
+	inode->i_ctime = curtime;
 	set_nlink(inode, info.NumSubdirs + 2);
 
 	return 0;
-- 
2.20.1

