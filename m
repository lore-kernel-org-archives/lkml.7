Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AF3C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBBE21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563413848;
	bh=QyYFsZxXZWnmVJMpuh5ZwNXY/+BLv5Jmy5x+kjaFSGo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AE7haTtwM9AWew/kgUihLrjf6623eCKPgOGuWdFxjMgN6PHSjRnCMVQ3qlQbeR4HC
	 yegVWhRFWYQkJy3zb6mESHZ7xEzLK5qMgqnuUKv8Th30kcDlg9yhHIitt+sKIvobHI
	 HTSwi70p6RE5uHRr0rW+GS7CHjRdtNIOyIJjDhfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfGRBh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732948AbfGRBhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:21 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8888621848;
        Thu, 18 Jul 2019 01:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563413840;
        bh=QyYFsZxXZWnmVJMpuh5ZwNXY/+BLv5Jmy5x+kjaFSGo=;
        h=From:To:Cc:Subject:Date:From;
        b=1kJ4AeOEG8INgoFgmiFNxAdXLAmPzGWb+Fnl5r3ZDZZBcWBr7d+wZ8B5U5PQLGUlK
         4DnoGGyGjK39IR+N5FjmvudA8lQ0brlPg8h7xUZmXIdpvBdcrUAfEtPP07aOOP3/Qn
         cv+yodGTe+6HFutlx2jjaau7o6Q2rnXY2S3xb12Q=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix to read source block before invalidating it
Date:   Wed, 17 Jul 2019 18:37:18 -0700
Message-Id: <20190718013718.70335-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_allocate_data_block() invalidates old block address and enable new block
address. Then, if we try to read old block by f2fs_submit_page_bio(), it will
give WARN due to reading invalid blocks.

Let's make the order sanely back.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 57 ++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6691f526fa40..35c5453ab874 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -740,6 +740,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	block_t newaddr;
 	int err = 0;
 	bool lfs_mode = test_opt(fio.sbi, LFS);
+	bool submitted = false;
 
 	/* do not read out */
 	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
@@ -796,6 +797,20 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	if (lfs_mode)
 		down_write(&fio.sbi->io_order_lock);
 
+	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
+			fio.old_blkaddr, false);
+	if (!mpage)
+		goto put_out;
+
+	if (!PageUptodate(mpage)) {
+		err = f2fs_submit_page_bio(&fio);
+		if (err) {
+			f2fs_put_page(mpage, 1);
+			goto put_out;
+		}
+		submitted = true;
+	}
+
 	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 					&sum, CURSEG_COLD_DATA, NULL, false);
 
@@ -803,44 +818,34 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
 	if (!fio.encrypted_page) {
 		err = -ENOMEM;
-		goto recover_block;
-	}
-
-	mpage = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
-					fio.old_blkaddr, FGP_LOCK, GFP_NOFS);
-	if (mpage) {
-		bool updated = false;
-
-		if (PageUptodate(mpage)) {
-			memcpy(page_address(fio.encrypted_page),
-					page_address(mpage), PAGE_SIZE);
-			updated = true;
-		}
 		f2fs_put_page(mpage, 1);
-		invalidate_mapping_pages(META_MAPPING(fio.sbi),
-					fio.old_blkaddr, fio.old_blkaddr);
-		if (updated)
-			goto write_page;
+		goto recover_block;
 	}
 
-	err = f2fs_submit_page_bio(&fio);
-	if (err)
-		goto put_page_out;
-
-	/* write page */
-	lock_page(fio.encrypted_page);
+	if (!submitted)
+		goto write_page;
 
-	if (unlikely(fio.encrypted_page->mapping != META_MAPPING(fio.sbi))) {
+	/* read source block */
+	lock_page(mpage);
+	if (unlikely(mpage->mapping != META_MAPPING(fio.sbi))) {
 		err = -EIO;
+		f2fs_put_page(mpage, 1);
 		goto put_page_out;
 	}
-	if (unlikely(!PageUptodate(fio.encrypted_page))) {
+	if (unlikely(!PageUptodate(mpage))) {
 		err = -EIO;
+		f2fs_put_page(mpage, 1);
 		goto put_page_out;
 	}
-
 write_page:
+	/* write target block */
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
+	memcpy(page_address(fio.encrypted_page),
+				page_address(mpage), PAGE_SIZE);
+	f2fs_put_page(mpage, 1);
+	invalidate_mapping_pages(META_MAPPING(fio.sbi),
+				fio.old_blkaddr, fio.old_blkaddr);
+
 	set_page_dirty(fio.encrypted_page);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
 		dec_page_count(fio.sbi, F2FS_DIRTY_META);
-- 
2.19.0.605.g01d371f741-goog

