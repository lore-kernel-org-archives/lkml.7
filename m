Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A296CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A3021734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfKAJyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:54:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727550AbfKAJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:54:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 30EE6A0A1A06B8B505F8;
        Fri,  1 Nov 2019 17:53:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 17:53:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: show f2fs instance in printk_ratelimited
Date:   Fri, 1 Nov 2019 17:53:23 +0800
Message-ID: <20191101095324.9902-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20191101095324.9902-1-yuchao0@huawei.com>
References: <20191101095324.9902-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eric mentioned, bare printk{,_ratelimited} won't show which
filesystem instance these message is coming from, this patch tries
to show fs instance with sb->s_id field in all places we missed
before.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       |  9 +++++----
 fs/f2fs/dir.c        |  7 ++++---
 fs/f2fs/f2fs.h       | 24 +++++++++++++-----------
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  9 +++++----
 9 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a0eef95b9e0e..ffdaba0c55d2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -581,7 +581,7 @@ int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
 
 	if (time_to_inject(sbi, FAULT_ORPHAN)) {
 		spin_unlock(&im->ino_lock);
-		f2fs_show_injection_info(FAULT_ORPHAN);
+		f2fs_show_injection_info(sbi, FAULT_ORPHAN);
 		return -ENOSPC;
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ca7161e38d1f..0bcb28d70894 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -168,9 +168,10 @@ static bool f2fs_bio_post_read_required(struct bio *bio)
 
 static void f2fs_read_end_io(struct bio *bio)
 {
-	if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)),
-						FAULT_READ_IO)) {
-		f2fs_show_injection_info(FAULT_READ_IO);
+	struct f2fs_sb_info *sbi = F2FS_P_SB(bio_first_page_all(bio));
+
+	if (time_to_inject(sbi, FAULT_READ_IO)) {
+		f2fs_show_injection_info(sbi, FAULT_READ_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
@@ -192,7 +193,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
-		f2fs_show_injection_info(FAULT_WRITE_IO);
+		f2fs_show_injection_info(sbi, FAULT_WRITE_IO);
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 4033778bcbbf..c967cacf979e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -628,7 +628,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 start:
 	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
-		f2fs_show_injection_info(FAULT_DIR_DEPTH);
+		f2fs_show_injection_info(F2FS_I_SB(dir), FAULT_DIR_DEPTH);
 		return -ENOSPC;
 	}
 
@@ -919,8 +919,9 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			bit_pos++;
 			ctx->pos = start_pos + bit_pos;
 			printk_ratelimited(
-				"%s, invalid namelen(0), ino:%u, run fsck to fix.",
-				KERN_WARNING, le32_to_cpu(de->ino));
+				"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
+				KERN_WARNING, sbi->sb->s_id,
+				le32_to_cpu(de->ino));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			continue;
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c681f51e351b..3f6204202788 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1374,9 +1374,10 @@ struct f2fs_private_dio {
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-#define f2fs_show_injection_info(type)					\
-	printk_ratelimited("%sF2FS-fs : inject %s in %s of %pS\n",	\
-		KERN_INFO, f2fs_fault_name[type],			\
+#define f2fs_show_injection_info(sbi, type)					\
+	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
+		KERN_INFO, sbi->sb->s_id,				\
+		f2fs_fault_name[type],					\
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
@@ -1396,7 +1397,7 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 #else
-#define f2fs_show_injection_info(type) do { } while (0)
+#define f2fs_show_injection_info(sbi, type) do { } while (0)
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
 	return false;
@@ -1781,7 +1782,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 		return ret;
 
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
-		f2fs_show_injection_info(FAULT_BLOCK);
+		f2fs_show_injection_info(sbi, FAULT_BLOCK);
 		release = *count;
 		goto release_quota;
 	}
@@ -2033,7 +2034,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	}
 
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
-		f2fs_show_injection_info(FAULT_BLOCK);
+		f2fs_show_injection_info(sbi, FAULT_BLOCK);
 		goto enospc;
 	}
 
@@ -2148,7 +2149,8 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 			return page;
 
 		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
-			f2fs_show_injection_info(FAULT_PAGE_ALLOC);
+			f2fs_show_injection_info(F2FS_M_SB(mapping),
+							FAULT_PAGE_ALLOC);
 			return NULL;
 		}
 	}
@@ -2163,7 +2165,7 @@ static inline struct page *f2fs_pagecache_get_page(
 				int fgp_flags, gfp_t gfp_mask)
 {
 	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
-		f2fs_show_injection_info(FAULT_PAGE_GET);
+		f2fs_show_injection_info(F2FS_M_SB(mapping), FAULT_PAGE_GET);
 		return NULL;
 	}
 
@@ -2232,7 +2234,7 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
 		return bio;
 	}
 	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
-		f2fs_show_injection_info(FAULT_ALLOC_BIO);
+		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
 		return NULL;
 	}
 
@@ -2799,7 +2801,7 @@ static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 	void *ret;
 
 	if (time_to_inject(sbi, FAULT_KMALLOC)) {
-		f2fs_show_injection_info(FAULT_KMALLOC);
+		f2fs_show_injection_info(sbi, FAULT_KMALLOC);
 		return NULL;
 	}
 
@@ -2820,7 +2822,7 @@ static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
 	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
-		f2fs_show_injection_info(FAULT_KVMALLOC);
+		f2fs_show_injection_info(sbi, FAULT_KVMALLOC);
 		return NULL;
 	}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f6c038e8a6a7..e5ce697c0544 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -681,7 +681,7 @@ int f2fs_truncate(struct inode *inode)
 	trace_f2fs_truncate(inode);
 
 	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
-		f2fs_show_injection_info(FAULT_TRUNCATE);
+		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_TRUNCATE);
 		return -EIO;
 	}
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ef7686a82722..24a3b6b52210 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -54,7 +54,7 @@ static int gc_thread_func(void *data)
 		}
 
 		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
-			f2fs_show_injection_info(FAULT_CHECKPOINT);
+			f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
 			f2fs_stop_checkpoint(sbi, false);
 		}
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 386ad54c13c3..502bd491336a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -681,7 +681,7 @@ void f2fs_evict_inode(struct inode *inode)
 		err = f2fs_truncate(inode);
 
 	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
-		f2fs_show_injection_info(FAULT_EVICT_INODE);
+		f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);
 		err = -EIO;
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8b66bc4c004b..6912faba811e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2399,7 +2399,7 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct free_nid *i = NULL;
 retry:
 	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
-		f2fs_show_injection_info(FAULT_ALLOC_NID);
+		f2fs_show_injection_info(sbi, FAULT_ALLOC_NID);
 		return false;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 253d72c2663c..c525d8c87ddf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -480,7 +480,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
 	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
-		f2fs_show_injection_info(FAULT_CHECKPOINT);
+		f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
 		f2fs_stop_checkpoint(sbi, false);
 	}
 
@@ -1008,8 +1008,9 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 
 	if (dc->error)
 		printk_ratelimited(
-			"%sF2FS-fs: Issue discard(%u, %u, %u) failed, ret: %d",
-			KERN_INFO, dc->lstart, dc->start, dc->len, dc->error);
+			"%sF2FS-fs (%s): Issue discard(%u, %u, %u) failed, ret: %d",
+			KERN_INFO, sbi->sb->s_id,
+			dc->lstart, dc->start, dc->len, dc->error);
 	__detach_discard_cmd(dcc, dc);
 }
 
@@ -1149,7 +1150,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->len += len;
 
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
-			f2fs_show_injection_info(FAULT_DISCARD);
+			f2fs_show_injection_info(sbi, FAULT_DISCARD);
 			err = -EIO;
 			goto submit;
 		}
-- 
2.18.0.rc1

