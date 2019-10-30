Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3383CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843812080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfJ3Dyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:54:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbfJ3Dyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:54:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 133EAF416A0042295C05;
        Wed, 30 Oct 2019 11:54:35 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 11:54:25 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: bio_alloc should never fail
Date:   Wed, 30 Oct 2019 11:55:18 +0800
Message-ID: <20191030035518.65477-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove such useless code and related fault injection.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/f2fs.txt |  1 -
 fs/f2fs/data.c                     |  6 ++----
 fs/f2fs/f2fs.h                     | 21 ---------------------
 fs/f2fs/segment.c                  |  5 +----
 fs/f2fs/super.c                    |  1 -
 5 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 7e1991328473..3477c3e4c08b 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -172,7 +172,6 @@ fault_type=%d          Support configuring fault injection type, should be
                        FAULT_KVMALLOC		0x000000002
                        FAULT_PAGE_ALLOC		0x000000004
                        FAULT_PAGE_GET		0x000000008
-                       FAULT_ALLOC_BIO		0x000000010
                        FAULT_ALLOC_NID		0x000000020
                        FAULT_ORPHAN		0x000000040
                        FAULT_BLOCK		0x000000080
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5755e897a5f0..3b88dcb15de6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -288,7 +288,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct f2fs_sb_info *sbi = fio->sbi;
 	struct bio *bio;
 
-	bio = f2fs_bio_alloc(sbi, npages, true);
+	bio = bio_alloc(GFP_NOIO, npages);
 
 	f2fs_target_device(sbi, fio->new_blkaddr, bio);
 	if (is_read_io(fio->op)) {
@@ -682,9 +682,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio_post_read_ctx *ctx;
 	unsigned int post_read_steps = 0;
 
-	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES), false);
-	if (!bio)
-		return ERR_PTR(-ENOMEM);
+	bio = bio_alloc(GFP_KERNEL, min_t(int, nr_pages, BIO_MAX_PAGES));
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4024790028aa..40012f874be0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -44,7 +44,6 @@ enum {
 	FAULT_KVMALLOC,
 	FAULT_PAGE_ALLOC,
 	FAULT_PAGE_GET,
-	FAULT_ALLOC_BIO,
 	FAULT_ALLOC_NID,
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
@@ -2210,26 +2209,6 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
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
-		f2fs_show_injection_info(FAULT_ALLOC_BIO);
-		return NULL;
-	}
-
-	return bio_alloc(GFP_KERNEL, npages);
-}
-
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
 	if (sbi->gc_mode == GC_URGENT)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 808709581481..28457c878d0d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -552,10 +552,7 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 	struct bio *bio;
 	int ret;
 
-	bio = f2fs_bio_alloc(sbi, 0, false);
-	if (!bio)
-		return -ENOMEM;
-
+	bio = bio_alloc(GFP_KERNEL, 0);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio_set_dev(bio, bdev);
 	ret = submit_bio_wait(bio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1443cee15863..51945dd27f00 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -44,7 +44,6 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
 	[FAULT_PAGE_GET]	= "page get",
-	[FAULT_ALLOC_BIO]	= "alloc bio",
 	[FAULT_ALLOC_NID]	= "alloc nid",
 	[FAULT_ORPHAN]		= "orphan",
 	[FAULT_BLOCK]		= "no more block",
-- 
2.17.1

