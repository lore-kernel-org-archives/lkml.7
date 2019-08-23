Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0810C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA722233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbfHWJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:58:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfHWJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:58:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADB76A3E56D603C648FA;
        Fri, 23 Aug 2019 17:58:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 23 Aug 2019 17:58:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: enhance f2fs_is_checkpoint_ready()'s readability
Date:   Fri, 23 Aug 2019 17:58:36 +0800
Message-ID: <20190823095836.28569-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190823095836.28569-1-yuchao0@huawei.com>
References: <20190823095836.28569-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes sematics of f2fs_is_checkpoint_ready()'s return
value as: return true when checkpoint is ready, other return false,
it can improve readability of below conditions.

f2fs_submit_page_write()
...
	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
				!f2fs_is_checkpoint_ready(sbi))
		__submit_merged_bio(io);

f2fs_balance_fs()
...
	if (!f2fs_is_checkpoint_ready(sbi))
		return;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    |  7 ++++---
 fs/f2fs/file.c    | 18 ++++++++----------
 fs/f2fs/inode.c   |  2 +-
 fs/f2fs/namei.c   | 36 ++++++++++++++----------------------
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/segment.h |  8 ++++----
 fs/f2fs/xattr.c   |  5 ++---
 7 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 769c548e955a..bf648c8c50ad 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -634,7 +634,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		goto next;
 out:
 	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
-				f2fs_is_checkpoint_ready(sbi))
+				!f2fs_is_checkpoint_ready(sbi))
 		__submit_merged_bio(io);
 	up_write(&io->io_rwsem);
 }
@@ -2571,9 +2571,10 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
+	if (!f2fs_is_checkpoint_ready(sbi)) {
+		err = -ENOSPC;
 		goto fail;
+	}
 
 	if ((f2fs_is_atomic_file(inode) &&
 			!f2fs_available_free_memory(sbi, INMEM_PAGES)) ||
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05d60082da3a..97038a9a91e3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -57,9 +57,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		err = -EIO;
 		goto err;
 	}
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
+
+	if (!f2fs_is_checkpoint_ready(sbi)) {
+		err = -ENOSPC;
 		goto err;
+	}
 
 	sb_start_pagefault(inode->i_sb);
 
@@ -1575,9 +1577,8 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
-	ret = f2fs_is_checkpoint_ready(F2FS_I_SB(inode));
-	if (ret)
-		return ret;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
+		return -ENOSPC;
 
 	/* f2fs only support ->fallocate for regular file */
 	if (!S_ISREG(inode->i_mode))
@@ -3162,13 +3163,10 @@ static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
 
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	int ret;
-
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
 		return -EIO;
-	ret = f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(filp)));
-	if (ret)
-		return ret;
+	if (!f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(filp))))
+		return -ENOSPC;
 
 	switch (cmd) {
 	case F2FS_IOC_GETFLAGS:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 88af85e0db62..87214414936b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -616,7 +616,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
-	if (f2fs_is_checkpoint_ready(sbi))
+	if (!f2fs_is_checkpoint_ready(sbi))
 		return -ENOSPC;
 
 	/*
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7a2d43a9f1a6..8b02c69df199 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -272,9 +272,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	err = dquot_initialize(dir);
 	if (err)
@@ -321,9 +320,8 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	err = fscrypt_prepare_link(old_dentry, dir, dentry);
 	if (err)
@@ -592,9 +590,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
 				      &disk_link);
@@ -724,9 +721,8 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	err = dquot_initialize(dir);
 	if (err)
@@ -822,13 +818,11 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	int ret;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	ret = f2fs_is_checkpoint_ready(sbi);
-	if (ret)
-		return ret;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) {
 		int err = fscrypt_get_encryption_info(dir);
@@ -865,9 +859,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	if (is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			(!projid_eq(F2FS_I(new_dir)->i_projid,
@@ -1060,9 +1053,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	if ((is_inode_flag_set(new_dir, FI_PROJ_INHERIT) &&
 			!projid_eq(F2FS_I(new_dir)->i_projid,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b6f838c055d7..ccee5fb69479 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -501,7 +501,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (need && excess_cached_nats(sbi))
 		f2fs_balance_fs_bg(sbi);
 
-	if (f2fs_is_checkpoint_ready(sbi))
+	if (!f2fs_is_checkpoint_ready(sbi))
 		return;
 
 	/*
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 38ae95301169..bdcce35be077 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -593,13 +593,13 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 		reserved_sections(sbi) + needed);
 }
 
-static inline int f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
+static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
 {
 	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		return 0;
+		return true;
 	if (likely(!has_not_enough_free_secs(sbi, 0, 0)))
-		return 0;
-	return -ENOSPC;
+		return true;
+	return false;
 }
 
 static inline bool excess_prefree_segs(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index f85c810e33ca..181900af2576 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -732,9 +732,8 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
-	err = f2fs_is_checkpoint_ready(sbi);
-	if (err)
-		return err;
+	if (!f2fs_is_checkpoint_ready(sbi))
+		return -ENOSPC;
 
 	err = dquot_initialize(inode);
 	if (err)
-- 
2.18.0.rc1

