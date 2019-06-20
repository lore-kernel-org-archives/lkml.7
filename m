Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF498C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A05C2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfFTOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:38:06 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41808 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:38:06 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id T2e3200063XaVaC012e3bi; Thu, 20 Jun 2019 16:38:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hdyCR-0000xm-0o; Thu, 20 Jun 2019 16:38:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hdyCQ-0005Ng-VN; Thu, 20 Jun 2019 16:38:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Qiuyang Sun <sunqiuyang@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH -next] f2fs: Use div_u64*() for 64-bit divisions
Date:   Thu, 20 Jun 2019 16:38:00 +0200
Message-Id: <20190620143800.20640-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit (e.g. m68k):

    fs/f2fs/gc.o: In function `f2fs_resize_fs':
    gc.c:(.text+0x3056): undefined reference to `__umoddi3'
    gc.c:(.text+0x30c4): undefined reference to `__udivdi3'

Fix this by using div_u64_rem() and div_u64() for 64-by-32 modulo resp.
division operations.

Reported-by: noreply@ellerman.id.au
Fixes: d2ae7494d043bfaf ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This assumes BLKS_PER_SEC(sbi) is 32-bit.

    #define BLKS_PER_SEC(sbi)                                       \
	    ((sbi)->segs_per_sec * (sbi)->blocks_per_seg)

Notes:
  1. f2fs_sb_info.segs_per_sec and f2fs_sb_info.blocks_per_seg are both
     unsigned int,
  2. The multiplication is done in 32-bit arithmetic, hence the result
     is of type unsigned int.
  3. Is it guaranteed that the result will always fit in 32-bit, or can
     this overflow?
  4. fs/f2fs/debug.c:update_sit_info() assigns BLKS_PER_SEC(sbi) to
     unsigned long long blks_per_sec, anticipating a 64-bit value.
---
 fs/f2fs/gc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5b1076505ade9f84..c65f87f11de029f4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1438,13 +1438,15 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	unsigned int secs;
 	int gc_mode, gc_type;
 	int err = 0;
+	__u32 rem;
 
 	old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
 	if (block_count > old_block_count)
 		return -EINVAL;
 
 	/* new fs size should align to section size */
-	if (block_count % BLKS_PER_SEC(sbi))
+	div_u64_rem(block_count, BLKS_PER_SEC(sbi), &rem);
+	if (rem)
 		return -EINVAL;
 
 	if (block_count == old_block_count)
@@ -1463,7 +1465,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 	freeze_bdev(sbi->sb->s_bdev);
 
 	shrunk_blocks = old_block_count - block_count;
-	secs = shrunk_blocks / BLKS_PER_SEC(sbi);
+	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 	spin_lock(&sbi->stat_lock);
 	if (shrunk_blocks + valid_user_blocks(sbi) +
 		sbi->current_reserved_blocks + sbi->unusable_block_count +
-- 
2.17.1

