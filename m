Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893DC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5DE233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbfHWJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:58:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfHWJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:58:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5C1524C3D1AA0FF058E;
        Fri, 23 Aug 2019 17:58:46 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 23 Aug 2019 17:58:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: clean up __bio_alloc()'s parameter
Date:   Fri, 23 Aug 2019 17:58:35 +0800
Message-ID: <20190823095836.28569-2-yuchao0@huawei.com>
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

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9fcfbd4f0b8c..769c548e955a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -259,26 +259,25 @@ static bool __same_bdev(struct f2fs_sb_info *sbi,
 /*
  * Low-level block read/write IO operations.
  */
-static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
-				struct writeback_control *wbc,
-				int npages, bool is_read,
-				enum page_type type, enum temp_type temp)
+static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 {
+	struct f2fs_sb_info *sbi = fio->sbi;
 	struct bio *bio;
 
 	bio = f2fs_bio_alloc(sbi, npages, true);
 
-	f2fs_target_device(sbi, blk_addr, bio);
-	if (is_read) {
+	f2fs_target_device(sbi, fio->new_blkaddr, bio);
+	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
 		bio->bi_private = NULL;
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
-		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, type, temp);
+		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
+						fio->type, fio->temp);
 	}
-	if (wbc)
-		wbc_init_bio(wbc, bio);
+	if (fio->io_wbc)
+		wbc_init_bio(fio->io_wbc, bio);
 
 	return bio;
 }
@@ -461,8 +460,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	/* Allocate a new bio */
-	bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
-				1, is_read_io(fio->op), fio->type, fio->temp);
+	bio = __bio_alloc(fio, 1);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		bio_put(bio);
@@ -538,8 +536,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 alloc_new:
 	if (!bio) {
-		bio = __bio_alloc(fio->sbi, fio->new_blkaddr, fio->io_wbc,
-				BIO_MAX_PAGES, false, fio->type, fio->temp);
+		bio = __bio_alloc(fio, BIO_MAX_PAGES);
 		bio_set_op_attrs(bio, fio->op, fio->op_flags);
 	}
 
@@ -616,9 +613,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 			fio->retry = true;
 			goto skip;
 		}
-		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
-						BIO_MAX_PAGES, false,
-						fio->type, fio->temp);
+		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
 		io->fio = *fio;
 	}
 
-- 
2.18.0.rc1

