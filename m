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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88613CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt2rZ0Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfJ3BEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:04:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41515 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:04:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so396215wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li8SYVVToKcm+GjqSDDEUh/SU9rEz3LNKXw3QLALBSo=;
        b=Gt2rZ0ZuHRTC11v4jrS0jDDFVvM49JObOsZwXYRRXHJ2lccEpTV1Db5NkC52LCYKJD
         JjpsEBSXx8H1U/7keajxiPAV63sjAGzBXpJzubhSmBfw/6AKwiiqS1WgqBJdxPqautm2
         /T/kOc9rAsRakBYN2LAN5VQOF2/qUsodpzYoC46Ch3C13HH1a1BseAwe5/5+CMVuAShK
         WFmHz9oVZM6wYqDrlAP+e2cRXa20xt5x/fllZd6uriwX1I2Ioa0OSd3SKgA8mWfobfej
         D97wYsfbAaZVVCLOPTBi1X4rgMAis8Xc79T0zRZEvSwCH4RoCYDKBi/R8w+x06saQWKF
         Qaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li8SYVVToKcm+GjqSDDEUh/SU9rEz3LNKXw3QLALBSo=;
        b=bQeSGlBHujxpC87JzViXI8IonOJQmGJv/fAyLl49e79jHjH39z5iOkE9QbozQCoBJo
         +r2FCj994cmAd1G97Nt5NnmfFg1/TCm4/viGjzTv4jasQhaFRgoybspip/IK0NFP1+ZH
         iE9gHGpdG1eRSp4fjEkddupDvut1qMFd0xSngxPrzCNxUWooeui+6vhxawjr7ajCadWH
         mnphG6KuHaEI3+udqc/UzzDaB16HCzEY12PXYRhSSIe4e4XN2azlTcDbeG23K0rfH8n2
         xGLtp1DGXGdgOQTjW74jMIOkZ7+x67eUqQqa7p8XxnKh6g6RUZtEyqsCrx2ZY6MT+TYh
         FetA==
X-Gm-Message-State: APjAAAVyKQIgLG5vvXOKVl/s1IP+8DhzsqomQljdQB3q9WeMQFJ+bmEQ
        XctzbP7y6UmPpumCbC1cSC4=
X-Google-Smtp-Source: APXvYqyQnFy4TkkmcYaw3ae4BHGKbcsZehMxLn7fLZS2Wjw1eoLt63kmMEBoIWWhxL78rQvVypgOnA==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr6266169wri.130.1572397483621;
        Tue, 29 Oct 2019 18:04:43 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id b66sm424565wmh.39.2019.10.29.18.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:04:43 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 1/6] staging: exfat: remove unnecessary parentheses
Date:   Wed, 30 Oct 2019 02:03:23 +0100
Message-Id: <20191030010328.10203-2-jroi.martin@gmail.com>
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

	CHECK: Unnecessary parentheses around ...

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_core.c  | 24 ++++++++--------
 drivers/staging/exfat/exfat_super.c | 44 ++++++++++++++---------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 79174e5c4145..d8f4fad732c4 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -550,7 +550,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 
 				for (j = 0; j < p_fs->map_sectors; j++) {
 					p_fs->vol_amap[j] = NULL;
-					ret = sector_read(sb, sector + j, &(p_fs->vol_amap[j]), 1);
+					ret = sector_read(sb, sector + j, &p_fs->vol_amap[j], 1);
 					if (ret != FFS_SUCCESS) {
 						/*  release all buffers and free vol_amap */
 						i = 0;
@@ -910,10 +910,10 @@ u32 fat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
-	if (*(ep->name) == 0x0)
+	if (*ep->name == 0x0)
 		return TYPE_UNUSED;
 
-	else if (*(ep->name) == 0xE5)
+	else if (*ep->name == 0xE5)
 		return TYPE_DELETED;
 
 	else if (ep->attr == ATTR_EXTEND)
@@ -978,10 +978,10 @@ void fat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
 
 	if (type == TYPE_UNUSED)
-		*(ep->name) = 0x0;
+		*ep->name = 0x0;
 
 	else if (type == TYPE_DELETED)
-		*(ep->name) = 0xE5;
+		*ep->name = 0xE5;
 
 	else if (type == TYPE_EXTEND)
 		ep->attr = ATTR_EXTEND;
@@ -1562,7 +1562,7 @@ void update_dir_checksum_with_entry_set(struct super_block *sb,
 	u16 chksum = 0;
 	s32 chksum_type = CS_DIR_ENTRY, i;
 
-	ep = (struct dentry_t *)&(es->__buf);
+	ep = (struct dentry_t *)&es->__buf;
 	for (i = 0; i < es->num_entries; i++) {
 		pr_debug("%s ep %p\n", __func__, ep);
 		chksum = calc_checksum_2byte((void *)ep, DENTRY_SIZE, chksum,
@@ -1571,7 +1571,7 @@ void update_dir_checksum_with_entry_set(struct super_block *sb,
 		chksum_type = CS_DEFAULT;
 	}
 
-	ep = (struct dentry_t *)&(es->__buf);
+	ep = (struct dentry_t *)&es->__buf;
 	SET16_A(((struct file_dentry_t *)ep)->checksum, chksum);
 	write_whole_entry_set(sb, es);
 }
@@ -1832,7 +1832,7 @@ struct entry_set_cache_t *get_entry_set_in_dir(struct super_block *sb,
 	}
 
 	if (file_ep)
-		*file_ep = (struct dentry_t *)&(es->__buf);
+		*file_ep = (struct dentry_t *)&es->__buf;
 
 	pr_debug("%s exiting es %p sec %llu offset %d flags %d, num_entries %u buf ptr %p\n",
 		   __func__, es, (unsigned long long)es->sector, es->offset,
@@ -1859,7 +1859,7 @@ static s32 __write_partial_entries_in_entry_set(struct super_block *sb,
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	u32 clu;
-	u8 *buf, *esbuf = (u8 *)&(es->__buf);
+	u8 *buf, *esbuf = (u8 *)&es->__buf;
 
 	pr_debug("%s entered es %p sec %llu off %d count %d\n",
 		__func__, es, (unsigned long long)sec, off, count);
@@ -1929,7 +1929,7 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 	struct chain_t dir;
 
 	/* vaidity check */
-	if (ep + count  > ((struct dentry_t *)&(es->__buf)) + es->num_entries)
+	if (ep + count  > ((struct dentry_t *)&es->__buf) + es->num_entries)
 		return FFS_ERROR;
 
 	dir.dir = GET_CLUSTER_FROM_SECTOR(es->sector);
@@ -1938,7 +1938,7 @@ s32 write_partial_entries_in_entry_set(struct super_block *sb,
 
 	byte_offset = (es->sector - START_SECTOR(dir.dir)) <<
 			p_bd->sector_size_bits;
-	byte_offset += ((void **)ep - &(es->__buf)) + es->offset;
+	byte_offset += ((void **)ep - &es->__buf) + es->offset;
 
 	ret = _walk_fat_chain(sb, &dir, byte_offset, &clu);
 	if (ret != FFS_SUCCESS)
@@ -2122,7 +2122,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 				p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
 				buf_modify(sb, sector);
 
-				update_dir_checksum(sb, &(fid->dir),
+				update_dir_checksum(sb, &fid->dir,
 						    fid->entry);
 			}
 		}
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3b2b0ceb7297..aa0d492fc673 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1003,13 +1003,13 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* (3) update the direcoty entry */
 	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
+		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es)
 			goto err_out;
 		ep2 = ep + 1;
 	} else {
-		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
+		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep)
 			goto err_out;
 		ep2 = ep;
@@ -1142,7 +1142,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 			}
 		ep2 = ep + 1;
 	} else {
-		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
+		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
 			ret = FFS_MEDIAERR;
 			goto out;
@@ -1277,7 +1277,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 		update_parent_info(new_fid, new_parent_inode);
 
-		p_dir = &(new_fid->dir);
+		p_dir = &new_fid->dir;
 		new_entry = new_fid->entry;
 		ep = get_entry_in_dir(sb, p_dir, new_entry, NULL);
 		if (!ep)
@@ -1438,14 +1438,14 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 
 	/* get the directory entry of given file */
 	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
+		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
 			ret = FFS_MEDIAERR;
 			goto out;
 		}
 	} else {
-		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
+		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
 			ret = FFS_MEDIAERR;
 			goto out;
@@ -1554,7 +1554,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 	/* get the directory entry of given file or directory */
 	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
+		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_2_ENTRIES, &ep);
 		if (!es) {
 			ret = FFS_MEDIAERR;
@@ -1562,7 +1562,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 		}
 		ep2 = ep + 1;
 	} else {
-		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
+		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
 			ret = FFS_MEDIAERR;
 			goto out;
@@ -1594,11 +1594,11 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 	memset((char *)&info->AccessTimestamp, 0, sizeof(struct date_time_t));
 
-	*(uni_name.name) = 0x0;
+	*uni_name.name = 0x0;
 	/* XXX this is very bad for exfat cuz name is already included in es.
 	 * API should be revised
 	 */
-	p_fs->fs_func->get_uni_name_from_ext_entry(sb, &(fid->dir), fid->entry,
+	p_fs->fs_func->get_uni_name_from_ext_entry(sb, &fid->dir, fid->entry,
 						   uni_name.name);
 	if (*uni_name.name == 0x0 && p_fs->vol_type != EXFAT)
 		get_uni_name_from_dos_entry(sb, (struct dos_dentry_t *)ep,
@@ -1678,7 +1678,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 
 	/* get the directory entry of given file or directory */
 	if (p_fs->vol_type == EXFAT) {
-		es = get_entry_set_in_dir(sb, &(fid->dir), fid->entry,
+		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
 			ret = FFS_MEDIAERR;
@@ -1687,7 +1687,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		ep2 = ep + 1;
 	} else {
 		/* for other than exfat */
-		ep = get_entry_in_dir(sb, &(fid->dir), fid->entry, &sector);
+		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
 			ret = FFS_MEDIAERR;
 			goto out;
@@ -1845,7 +1845,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		/* (3) update directory entry */
 		if (modified) {
 			if (p_fs->vol_type != EXFAT) {
-				ep = get_entry_in_dir(sb, &(fid->dir),
+				ep = get_entry_in_dir(sb, &fid->dir,
 						      fid->entry, &sector);
 				if (!ep) {
 					ret = FFS_MEDIAERR;
@@ -2058,7 +2058,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			memset((char *)&dir_entry->AccessTimestamp, 0,
 			       sizeof(struct date_time_t));
 
-			*(uni_name.name) = 0x0;
+			*uni_name.name = 0x0;
 			fs_func->get_uni_name_from_ext_entry(sb, &dir, dentry,
 							     uni_name.name);
 			if (*uni_name.name == 0x0 && p_fs->vol_type != EXFAT)
@@ -2116,7 +2116,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		}
 	}
 
-	*(dir_entry->Name) = '\0';
+	*dir_entry->Name = '\0';
 
 	fid->rwoffset = (s64)(++dentry);
 
@@ -2202,7 +2202,7 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct dir_entry_t de;
 	unsigned long inum;
@@ -2293,7 +2293,7 @@ static int exfat_ioctl_volume_id(struct inode *dir)
 {
 	struct super_block *sb = dir->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
 
 	return p_fs->vol_id;
 }
@@ -2895,7 +2895,7 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
 	int err;
 
 	__lock_super(sb);
@@ -3073,8 +3073,8 @@ static int exfat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
-	struct bd_info_t *p_bd = &(sbi->bd_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
+	struct bd_info_t *p_bd = &sbi->bd_info;
 	const unsigned long blocksize = sb->s_blocksize;
 	const unsigned char blocksize_bits = sb->s_blocksize_bits;
 	sector_t last_block;
@@ -3302,7 +3302,7 @@ static struct inode *exfat_iget(struct super_block *sb, loff_t i_pos)
 static int exfat_fill_inode(struct inode *inode, struct file_id_t *fid)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
 	struct dir_entry_t info;
 
 	memcpy(&(EXFAT_I(inode)->fid), fid, sizeof(struct file_id_t));
@@ -3787,7 +3787,7 @@ static int exfat_read_root(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct fs_info_t *p_fs = &(sbi->fs_info);
+	struct fs_info_t *p_fs = &sbi->fs_info;
 	struct dir_entry_t info;
 
 	EXFAT_I(inode)->fid.dir.dir = p_fs->root_dir;
-- 
2.20.1

