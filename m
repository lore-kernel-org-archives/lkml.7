Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1E5C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844742190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfI3Kxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:53:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730444AbfI3Kxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:53:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 512C5FDCAA5BEA49B81F;
        Mon, 30 Sep 2019 18:53:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 18:53:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: cache global IPU bio
Date:   Mon, 30 Sep 2019 18:53:25 +0800
Message-ID: <20190930105325.42870-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8648de2c581e ("f2fs: add bio cache for IPU"), we added
f2fs_submit_ipu_bio() in __write_data_page() as below:

__write_data_page()

	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode)) {
		f2fs_submit_ipu_bio(sbi, bio, page);
		....
	}

in order to avoid below deadlock:

Thread A				Thread B
- __write_data_page (inode x, page y)
 - f2fs_do_write_data_page
  - set_page_writeback        ---- set writeback flag in page y
  - f2fs_inplace_write_data
 - f2fs_balance_fs
					 - lock gc_mutex
 - lock gc_mutex
					  - f2fs_gc
					   - do_garbage_collect
					    - gc_data_segment
					     - move_data_page
					      - f2fs_wait_on_page_writeback
					       - wait_on_page_writeback  --- wait writeback of page y

However, the bio submission breaks the merge of IPU IOs.

So in this patch let's add a global bio cache for merged IPU pages,
then f2fs_wait_on_page_writeback() is able to submit bio if a
writebacked page is cached in global bio cache.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 179 +++++++++++++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h    |  11 +++
 fs/f2fs/segment.c |   3 +
 fs/f2fs/super.c   |   8 +++
 4 files changed, 169 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 28665acb35a5..3eef7caee064 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -29,6 +29,7 @@
 #define NUM_PREALLOC_POST_READ_CTXS	128
 
 static struct kmem_cache *bio_post_read_ctx_cache;
+static struct kmem_cache *bio_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
 
 static bool __is_cp_guaranteed(struct page *page)
@@ -540,6 +541,126 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 	return io_type_is_mergeable(io, fio);
 }
 
+static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
+				struct page *page, enum temp_type temp)
+{
+	struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
+	struct bio_entry *be;
+
+	be = f2fs_kmem_cache_alloc(bio_entry_slab, GFP_NOFS);
+	be->bio = bio;
+	bio_get(bio);
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
+		f2fs_bug_on(sbi, 1);
+
+	down_write(&io->bio_list_lock);
+	list_add_tail(&be->list, &io->bio_list);
+	up_write(&io->bio_list_lock);
+}
+
+static void del_bio_entry(struct bio_entry *be)
+{
+	list_del(&be->list);
+	kmem_cache_free(bio_entry_slab, be);
+}
+
+static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
+							struct page *page)
+{
+	enum temp_type temp;
+	bool found = false;
+	int ret = -EAGAIN;
+
+	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
+		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
+		struct list_head *head = &io->bio_list;
+		struct bio_entry *be;
+
+		down_write(&io->bio_list_lock);
+		list_for_each_entry(be, head, list) {
+			if (be->bio != *bio)
+				continue;
+
+			found = true;
+
+			if (bio_add_page(*bio, page, PAGE_SIZE, 0) == PAGE_SIZE) {
+				ret = 0;
+				break;
+			}
+
+			/* bio is full */
+			del_bio_entry(be);
+			__submit_bio(sbi, *bio, DATA);
+			break;
+		}
+		up_write(&io->bio_list_lock);
+	}
+
+	if (ret) {
+		bio_put(*bio);
+		*bio = NULL;
+	}
+
+	return ret;
+}
+
+void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
+					struct bio **bio, struct page *page)
+{
+	enum temp_type temp;
+	bool found = false;
+	struct bio *target = bio ? *bio : NULL;
+
+	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
+		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
+		struct list_head *head = &io->bio_list;
+		struct bio_entry *be;
+
+		if (list_empty(head))
+			continue;
+
+		down_read(&io->bio_list_lock);
+		list_for_each_entry(be, head, list) {
+			if (target)
+				found = (target == be->bio);
+			else
+				found = __has_merged_page(be->bio, NULL,
+								page, 0);
+			if (found)
+				break;
+		}
+		up_read(&io->bio_list_lock);
+
+		if (!found)
+			continue;
+
+		found = false;
+
+		down_write(&io->bio_list_lock);
+		list_for_each_entry(be, head, list) {
+			if (target)
+				found = (target == be->bio);
+			else
+				found = __has_merged_page(be->bio, NULL,
+								page, 0);
+			if (found) {
+				target = be->bio;
+				del_bio_entry(be);
+				break;
+			}
+		}
+		up_write(&io->bio_list_lock);
+	}
+
+	if (found)
+		__submit_bio(sbi, target, DATA);
+	if (bio && *bio) {
+		bio_put(*bio);
+		*bio = NULL;
+	}
+}
+
 int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio = *fio->bio;
@@ -554,20 +675,17 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
-						fio->new_blkaddr)) {
-		__submit_bio(fio->sbi, bio, fio->type);
-		bio = NULL;
-	}
+						fio->new_blkaddr))
+		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_PAGES);
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
-	}
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		__submit_bio(fio->sbi, bio, fio->type);
-		bio = NULL;
-		goto alloc_new;
+		add_bio_entry(fio->sbi, bio, page, fio->temp);
+	} else {
+		if (add_ipu_page(fio->sbi, &bio, page))
+			goto alloc_new;
 	}
 
 	if (fio->io_wbc)
@@ -581,19 +699,6 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
-static void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
-							struct page *page)
-{
-	if (!bio)
-		return;
-
-	if (!__has_merged_page(*bio, NULL, page, 0))
-		return;
-
-	__submit_bio(sbi, *bio, DATA);
-	*bio = NULL;
-}
-
 void f2fs_submit_page_write(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -2206,14 +2311,12 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 	unlock_page(page);
 	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
-					!F2FS_I(inode)->cp_task) {
-		f2fs_submit_ipu_bio(sbi, bio, page);
+					!F2FS_I(inode)->cp_task)
 		f2fs_balance_fs(sbi, need_balance_fs);
-	}
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_submit_ipu_bio(sbi, bio, page);
 		f2fs_submit_merged_write(sbi, DATA);
+		f2fs_submit_merged_ipu_write(sbi, bio, NULL);
 		submitted = NULL;
 	}
 
@@ -2333,13 +2436,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			}
 
 			if (PageWriteback(page)) {
-				if (wbc->sync_mode != WB_SYNC_NONE) {
+				if (wbc->sync_mode != WB_SYNC_NONE)
 					f2fs_wait_on_page_writeback(page,
 							DATA, true, true);
-					f2fs_submit_ipu_bio(sbi, &bio, page);
-				} else {
+				else
 					goto continue_unlock;
-				}
 			}
 
 			if (!clear_page_dirty_for_io(page))
@@ -2397,7 +2498,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 								NULL, 0, DATA);
 	/* submit cached bio of IPU write */
 	if (bio)
-		__submit_bio(sbi, bio, DATA);
+		f2fs_submit_merged_ipu_write(sbi, &bio, NULL);
 
 	return ret;
 }
@@ -3202,8 +3303,22 @@ int __init f2fs_init_post_read_processing(void)
 	return -ENOMEM;
 }
 
-void __exit f2fs_destroy_post_read_processing(void)
+void f2fs_destroy_post_read_processing(void)
 {
 	mempool_destroy(bio_post_read_ctx_pool);
 	kmem_cache_destroy(bio_post_read_ctx_cache);
 }
+
+int __init f2fs_init_bio_entry_cache(void)
+{
+	bio_entry_slab = f2fs_kmem_cache_create("bio_entry_slab",
+			sizeof(struct bio_entry));
+	if (!bio_entry_slab)
+		return -ENOMEM;
+	return 0;
+}
+
+void __exit f2fs_destroy_bio_entry_cache(void)
+{
+	kmem_cache_destroy(bio_entry_slab);
+}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 797e95933ce9..eed7918389ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1068,6 +1068,11 @@ struct f2fs_io_info {
 	unsigned char version;		/* version of the node */
 };
 
+struct bio_entry {
+	struct bio *bio;
+	struct list_head list;
+};
+
 #define is_read_io(rw) ((rw) == READ)
 struct f2fs_bio_info {
 	struct f2fs_sb_info *sbi;	/* f2fs superblock */
@@ -1077,6 +1082,8 @@ struct f2fs_bio_info {
 	struct rw_semaphore io_rwsem;	/* blocking op for bio */
 	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
 	struct list_head io_list;	/* track fios */
+	struct list_head bio_list;	/* bio entry list head */
+	struct rw_semaphore bio_list_lock;	/* lock to protect bio entry list */
 };
 
 #define FDEV(i)				(sbi->devs[i])
@@ -3210,10 +3217,14 @@ void f2fs_destroy_checkpoint_caches(void);
  */
 int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
+int f2fs_init_bio_entry_cache(void);
+void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct page *page,
 				nid_t ino, enum page_type type);
+void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
+					struct bio **bio, struct page *page);
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_merge_page_bio(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 808709581481..25c750cd0272 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3379,7 +3379,10 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
+		/* submit cached LFS IO */
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
+		/* sbumit cached IPU IO */
+		f2fs_submit_merged_ipu_write(sbi, NULL, page);
 		if (ordered) {
 			wait_on_page_writeback(page);
 			f2fs_bug_on(sbi, locked && PageWriteback(page));
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0e6eb482e853..f770d0b347eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3342,6 +3342,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->write_io[i][j].bio = NULL;
 			spin_lock_init(&sbi->write_io[i][j].io_lock);
 			INIT_LIST_HEAD(&sbi->write_io[i][j].io_list);
+			INIT_LIST_HEAD(&sbi->write_io[i][j].bio_list);
+			init_rwsem(&sbi->write_io[i][j].bio_list_lock);
 		}
 	}
 
@@ -3753,8 +3755,13 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_post_read_processing();
 	if (err)
 		goto free_root_stats;
+	err = f2fs_init_bio_entry_cache();
+	if (err)
+		goto free_post_read;
 	return 0;
 
+free_post_read:
+	f2fs_destroy_post_read_processing();
 free_root_stats:
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
@@ -3778,6 +3785,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_bio_entry_cache();
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
-- 
2.18.0.rc1

