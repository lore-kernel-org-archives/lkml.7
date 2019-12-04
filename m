Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB5E2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfLDByB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:54:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbfLDByB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:54:01 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03EB8429D63B65EB084F;
        Wed,  4 Dec 2019 09:53:59 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Dec 2019 09:53:50 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: introduce private bioset
Date:   Wed, 4 Dec 2019 09:52:58 +0800
Message-ID: <20191204015258.104738-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In low memory scenario, we can allocate multiple bios without
submitting any of them.

- f2fs_write_checkpoint()
 - block_operations()
  - f2fs_sync_node_pages()
   step 1) flush cold nodes, allocate new bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 2) flush hot nodes, allocate a bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 3) flush warm nodes, be stuck in below call path
   - bio_alloc()
    - mempool_alloc()
     - loop to wait mempool element release, as we only
       reserved memory for two bio allocation, however above
       allocated two bios may never be submitted.

So we need avoid using default bioset, in this patch we introduce a
private bioset, in where we enlarg mempool element count to total
number of log header, so that we can make sure we have enough
backuped memory pool in scenario of allocating/holding multiple
bios.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h  | 23 +++--------------------
 fs/f2fs/super.c |  7 ++++++-
 3 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a034cd0ce021..22fc45c36613 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -31,6 +31,47 @@
 static struct kmem_cache *bio_post_read_ctx_cache;
 static struct kmem_cache *bio_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
+static struct bio_set f2fs_bioset;
+
+#define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
+
+int __init f2fs_init_bioset(void)
+{
+	if (bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
+					0, BIOSET_NEED_BVECS))
+		return -ENOMEM;
+	return 0;
+}
+
+void f2fs_destroy_bioset(void)
+{
+	bioset_exit(&f2fs_bioset);
+}
+
+static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
+						unsigned int nr_iovecs)
+{
+	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
+}
+
+struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail)
+{
+	struct bio *bio;
+
+	if (no_fail) {
+		/* No failure on bio allocation */
+		bio = __f2fs_bio_alloc(GFP_NOIO, npages);
+		if (!bio)
+			bio = __f2fs_bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
+		return bio;
+	}
+	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
+		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
+		return NULL;
+	}
+
+	return __f2fs_bio_alloc(GFP_KERNEL, npages);
+}
 
 static bool __is_cp_guaranteed(struct page *page)
 {
@@ -3328,7 +3369,7 @@ int __init f2fs_init_bio_entry_cache(void)
 	return 0;
 }
 
-void __exit f2fs_destroy_bio_entry_cache(void)
+void f2fs_destroy_bio_entry_cache(void)
 {
 	kmem_cache_destroy(bio_entry_slab);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a063c7f..a1bf53ddcfc8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2222,26 +2222,6 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 	return entry;
 }
 
-static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
-						int npages, bool no_fail)
-{
-	struct bio *bio;
-
-	if (no_fail) {
-		/* No failure on bio allocation */
-		bio = bio_alloc(GFP_NOIO, npages);
-		if (!bio)
-			bio = bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
-		return bio;
-	}
-	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
-		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
-		return NULL;
-	}
-
-	return bio_alloc(GFP_KERNEL, npages);
-}
-
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (sbi->gc_mode == GC_URGENT)
@@ -3205,6 +3185,9 @@ void f2fs_destroy_checkpoint_caches(void);
 /*
  * data.c
  */
+int __init f2fs_init_bioset(void);
+void f2fs_destroy_bioset(void);
+struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail);
 int f2fs_init_post_read_processing(void);
 void f2fs_destroy_post_read_processing(void);
 int f2fs_init_bio_entry_cache(void);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 75a3b7220ecb..715c91b11946 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3767,8 +3767,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_bio_entry_cache();
 	if (err)
 		goto free_post_read;
+	err = f2fs_init_bioset();
+	if (err)
+		goto free_bio_enrty_cache;
 	return 0;
-
+free_bio_enrty_cache:
+	f2fs_destroy_bio_entry_cache();
 free_post_read:
 	f2fs_destroy_post_read_processing();
 free_root_stats:
@@ -3794,6 +3798,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	f2fs_destroy_bioset();
 	f2fs_destroy_bio_entry_cache();
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
-- 
2.18.0.rc1

