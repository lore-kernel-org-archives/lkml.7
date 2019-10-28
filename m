Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FFACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B421208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfJ1Cqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfJ1Cqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E30CAABD3;
        Mon, 28 Oct 2019 02:46:45 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat: Replace binary semaphores for mutexes
Date:   Sun, 27 Oct 2019 19:45:19 -0700
Message-Id: <20191028024519.32344-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
than semaphores; it's also a nicer interface for mutual exclusion,
which is why they are encouraged over binary semaphores, when possible.
There is also lockdep support.

For both v_sem and z_sem, their semantics imply traditional lock
ownership; that is, the lock owner is the same for both lock/unlock
operations and nothing is done in irq context. Therefore it is safe
to convert.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
This is part of further reducing semaphore users in the kernel.

 drivers/staging/exfat/exfat.h       |  2 +-
 drivers/staging/exfat/exfat_super.c | 84 ++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 6c12f2d79f4d..95c02f55de60 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -618,7 +618,7 @@ struct fs_info_t {
 	u32 dev_ejected;	/* block device operation error flag */
 
 	struct fs_func *fs_func;
-	struct semaphore v_sem;
+	struct mutex v_mutex;
 
 	/* FAT cache */
 	struct buf_cache_t FAT_cache_array[FAT_CACHE_SIZE];
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..c0b09b2dbe96 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -283,7 +283,7 @@ static const struct dentry_operations exfat_dentry_ops = {
 	.d_compare      = exfat_cmp,
 };
 
-static DEFINE_SEMAPHORE(z_sem);
+static DEFINE_MUTEX(z_mutex);
 
 static inline void fs_sync(struct super_block *sb, bool do_sync)
 {
@@ -352,11 +352,11 @@ static int ffsMountVol(struct super_block *sb)
 
 	pr_info("[EXFAT] trying to mount...\n");
 
-	down(&z_sem);
+        mutex_lock(&z_mutex);
 
 	buf_init(sb);
 
-	sema_init(&p_fs->v_sem, 1);
+	mutex_init(&p_fs->v_mutex);
 	p_fs->dev_ejected = 0;
 
 	/* open the block device */
@@ -441,7 +441,7 @@ static int ffsMountVol(struct super_block *sb)
 	pr_info("[EXFAT] mounted successfully\n");
 
 out:
-	up(&z_sem);
+	mutex_unlock(&z_mutex);
 
 	return ret;
 }
@@ -453,10 +453,10 @@ static int ffsUmountVol(struct super_block *sb)
 
 	pr_info("[EXFAT] trying to unmount...\n");
 
-	down(&z_sem);
+	mutex_lock(&z_mutex);
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	fs_sync(sb, false);
 	fs_set_vol_flags(sb, VOL_CLEAN);
@@ -480,8 +480,8 @@ static int ffsUmountVol(struct super_block *sb)
 	buf_shutdown(sb);
 
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
-	up(&z_sem);
+	mutex_unlock(&p_fs->v_mutex);
+	mutex_unlock(&z_mutex);
 
 	pr_info("[EXFAT] unmounted successfully\n");
 
@@ -498,7 +498,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
@@ -513,7 +513,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 		err = FFS_MEDIAERR;
 
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return err;
 }
@@ -524,7 +524,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* synchronize the file system */
 	fs_sync(sb, do_sync);
@@ -534,7 +534,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 		err = FFS_MEDIAERR;
 
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return err;
 }
@@ -561,7 +561,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check the validity of directory name in the given pathname */
 	ret = resolve_path(inode, path, &dir, &uni_name);
@@ -635,7 +635,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 		ret = FFS_MEDIAERR;
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -654,7 +654,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check the validity of directory name in the given pathname */
 	ret = resolve_path(inode, path, &dir, &uni_name);
@@ -676,7 +676,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -703,7 +703,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
@@ -800,7 +800,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -833,7 +833,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
@@ -1057,7 +1057,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1080,7 +1080,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		 new_size);
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_FILE) {
@@ -1190,7 +1190,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 out:
 	pr_debug("%s exited (%d)\n", __func__, ret);
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1238,7 +1238,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	update_parent_info(fid, old_parent_inode);
 
@@ -1336,7 +1336,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 		ret = FFS_MEDIAERR;
 out2:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1355,7 +1355,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 		return FFS_INVALIDFID;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	dir.dir = fid->dir.dir;
 	dir.size = fid->dir.size;
@@ -1398,7 +1398,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 		ret = FFS_MEDIAERR;
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1433,7 +1433,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	}
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* get the directory entry of given file */
 	if (p_fs->vol_type == EXFAT) {
@@ -1487,7 +1487,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		ret = FFS_MEDIAERR;
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1511,7 +1511,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 	pr_debug("%s entered\n", __func__);
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	if (is_dir) {
 		if ((fid->dir.dir == p_fs->root_dir) &&
@@ -1640,7 +1640,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	pr_debug("%s exited successfully\n", __func__);
 	return ret;
@@ -1661,7 +1661,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	pr_debug("%s entered (inode %p info %p\n", __func__, inode, info);
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	if (is_dir) {
 		if ((fid->dir.dir == p_fs->root_dir) &&
@@ -1727,7 +1727,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	pr_debug("%s exited (%d)\n", __func__, ret);
 
@@ -1753,7 +1753,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	fid->rwoffset = (s64)(clu_offset) << p_fs->cluster_size_bits;
 
@@ -1881,7 +1881,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1905,7 +1905,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 		return FFS_ERROR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	/* check the validity of directory name in the given old pathname */
 	ret = resolve_path(inode, path, &dir, &uni_name);
@@ -1925,7 +1925,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 		ret = FFS_MEDIAERR;
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -1955,7 +1955,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		return FFS_PERMISSIONERR;
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	if (fid->entry == -1) {
 		dir.dir = p_fs->root_dir;
@@ -2124,7 +2124,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -2154,7 +2154,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	}
 
 	/* acquire the lock for file system critical section */
-	down(&p_fs->v_sem);
+	mutex_lock(&p_fs->v_mutex);
 
 	clu_to_free.dir = fid->start_clu;
 	clu_to_free.size = (s32)((fid->size - 1) >> p_fs->cluster_size_bits) + 1;
@@ -2187,7 +2187,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 
 out:
 	/* release the lock for file system critical section */
-	up(&p_fs->v_sem);
+	mutex_unlock(&p_fs->v_mutex);
 
 	return ret;
 }
@@ -3983,10 +3983,10 @@ static void exfat_debug_kill_sb(struct super_block *sb)
 			 * invalidate_bdev drops all device cache include
 			 * dirty. We use this to simulate device removal.
 			 */
-			down(&p_fs->v_sem);
+			mutex_lock(&p_fs->v_mutex);
 			FAT_release_all(sb);
 			buf_release_all(sb);
-			up(&p_fs->v_sem);
+			mutex_unlock(&p_fs->v_mutex);
 
 			invalidate_bdev(bdev);
 		}
-- 
2.16.4

