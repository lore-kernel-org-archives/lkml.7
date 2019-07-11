Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CF8C74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC12621537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGKKi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:38:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfGKKi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:38:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 31C3FEE1B2607C849EF1;
        Thu, 11 Jul 2019 18:38:51 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 11 Jul 2019 18:38:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix panic of IO alignment feature
Date:   Thu, 11 Jul 2019 18:38:37 +0800
Message-ID: <1562841517-77910-2-git-send-email-yuchao0@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562841517-77910-1-git-send-email-yuchao0@huawei.com>
References: <1562841517-77910-1-git-send-email-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 07173c3ec276 ("block: enable multipage bvecs"), one bio vector
can store multi pages, so that we can not calculate max IO size of
bio as PAGE_SIZE * bio->bi_max_vecs. However IO alignment feature of
f2fs always has that assumption, so finally, it may cause panic during
IO submission as below stack.

 kernel BUG at fs/f2fs/data.c:317!
 RIP: 0010:__submit_merged_bio+0x8b0/0x8c0
 Call Trace:
  f2fs_submit_page_write+0x3cd/0xdd0
  do_write_page+0x15d/0x360
  f2fs_outplace_write_data+0xd7/0x210
  f2fs_do_write_data_page+0x43b/0xf30
  __write_data_page+0xcf6/0x1140
  f2fs_write_cache_pages+0x3ba/0xb40
  f2fs_write_data_pages+0x3dd/0x8b0
  do_writepages+0xbb/0x1e0
  __writeback_single_inode+0xb6/0x800
  writeback_sb_inodes+0x441/0x910
  wb_writeback+0x261/0x650
  wb_workfn+0x1f9/0x7a0
  process_one_work+0x503/0x970
  worker_thread+0x7d/0x820
  kthread+0x1ad/0x210
  ret_from_fork+0x35/0x40

This patch adds one extra condition to check left space in bio while
trying merging page to bio, to avoid panic.

This bug was reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=204043

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c          | 10 ++++++++++
 fs/f2fs/super.c         |  2 +-
 include/linux/f2fs_fs.h |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bdfd8fb..f106ada 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -508,6 +508,16 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 {
 	if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
 		return false;
+	if (F2FS_IO_ALIGNED(sbi)) {
+		unsigned int filled_blocks =
+				F2FS_BYTES_TO_BLK(bio->bi_iter.bi_size);
+		unsigned int io_size = F2FS_IO_SIZE(sbi);
+		unsigned int left_vecs = bio->bi_max_vecs - bio->bi_vcnt;
+
+		/* IOs in bio is aligned and left space of vectors is not enough */
+		if (!(filled_blocks % io_size) && left_vecs < io_size)
+			return false;
+	}
 	return io_type_is_mergeable(io, fio);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d95a681..a98e3b9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3204,7 +3204,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_bio_info;
 
-	if (F2FS_IO_SIZE(sbi) > 1) {
+	if (F2FS_IO_ALIGNED(sbi)) {
 		sbi->write_io_dummy =
 			mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
 		if (!sbi->write_io_dummy) {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6555990..52af9ac 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -41,6 +41,7 @@
 #define F2FS_IO_SIZE_BYTES(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 12)) /* B */
 #define F2FS_IO_SIZE_BITS(sbi)	(F2FS_OPTION(sbi).write_io_size_bits) /* power of 2 */
 #define F2FS_IO_SIZE_MASK(sbi)	(F2FS_IO_SIZE(sbi) - 1)
+#define F2FS_IO_ALIGNED(sbi)	(F2FS_IO_SIZE(sbi) > 1)
 
 /* This flag is used by node and meta inodes, and by recovery */
 #define GFP_F2FS_ZERO		(GFP_NOFS | __GFP_ZERO)
-- 
2.7.4

