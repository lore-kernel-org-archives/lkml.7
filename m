Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007072083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfFTOmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:42:19 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:54454 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFTOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:42:19 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id T2iG2000D3XaVaC062iGxT; Thu, 20 Jun 2019 16:42:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hdyGW-0000yp-2h; Thu, 20 Jun 2019 16:42:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hdyGW-0007Ko-1M; Thu, 20 Jun 2019 16:42:16 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fsf2: Use DIV_ROUND_UP() instead of open-coding
Date:   Thu, 20 Jun 2019 16:42:08 +0200
Message-Id: <20190620144208.28151-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded divisions with round-up by calls to the
DIV_ROUND_UP() helper macro.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/f2fs/f2fs.h    | 4 ++--
 fs/f2fs/file.c    | 6 +++---
 fs/f2fs/segment.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9afe15675dbbd369..52f477eaaee93bc3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -480,8 +480,8 @@ static inline int get_inline_xattr_addrs(struct inode *inode);
 #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
 				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
 				BITS_PER_BYTE + 1))
-#define INLINE_DENTRY_BITMAP_SIZE(inode)	((NR_INLINE_DENTRY(inode) + \
-					BITS_PER_BYTE - 1) / BITS_PER_BYTE)
+#define INLINE_DENTRY_BITMAP_SIZE(inode) \
+	DIV_ROUND_UP(NR_INLINE_DENTRY(inode), BITS_PER_BYTE)
 #define INLINE_RESERVED_SIZE(inode)	(MAX_INLINE_DATA(inode) - \
 				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
 				NR_INLINE_DENTRY(inode) + \
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1180eca879331eba..fc00d8bdc31c18b0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1211,7 +1211,7 @@ static int __exchange_data_block(struct inode *src_inode,
 static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
+	pgoff_t nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	pgoff_t start = offset >> PAGE_SHIFT;
 	pgoff_t end = (offset + len) >> PAGE_SHIFT;
 	int ret;
@@ -1464,7 +1464,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	pg_start = offset >> PAGE_SHIFT;
 	pg_end = (offset + len) >> PAGE_SHIFT;
 	delta = pg_end - pg_start;
-	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
+	idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 
 	/* avoid gc operation during block exchange */
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -2362,7 +2362,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	if (!fragmented)
 		goto out;
 
-	sec_num = (total + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
+	sec_num = DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
 
 	/*
 	 * make sure there are enough free section for LFS allocation, this can
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 166ac0f07a4e472d..2ae6df03b9982d12 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -109,7 +109,7 @@
 #define	START_SEGNO(segno)		\
 	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
 #define SIT_BLK_CNT(sbi)			\
-	((MAIN_SEGS(sbi) + SIT_ENTRY_PER_BLOCK - 1) / SIT_ENTRY_PER_BLOCK)
+	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK)
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
 
-- 
2.17.1

