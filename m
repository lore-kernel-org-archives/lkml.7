Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A330C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C532168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558796899;
	bh=8+q4Zssz7rb0t6IthvndGsVaCVXTKJumxhD/Z4lonK4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ntJGl3Y0jfgADFqONi30pM3Tz0vXolO6HMcPR1KxL3PFNLWrAucizqdJ5CNraPXxg
	 a3XRT1ubzyMbenvrXWnnc97Gd8nBBDV3Wbe5/iJp/kszvC98bCI7Y3kFTu5zPZjlSM
	 f8C3K8tUB7TOb6k3jFhdsJMf9ZzlBTCk5Y/5nMIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEYPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 11:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfEYPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 11:08:17 -0400
Received: from localhost.localdomain (unknown [58.212.135.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8FB2075E;
        Sat, 25 May 2019 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558796896;
        bh=8+q4Zssz7rb0t6IthvndGsVaCVXTKJumxhD/Z4lonK4=;
        h=From:To:Cc:Subject:Date:From;
        b=ddTPviWhU2UKgUAASn8DJn9XZdQeiBJBaupbdkbL4hJMnWJ/DV/GbDpKMt6XDF/at
         zlkG9gsCIVGlgSwnZXEXEowNHpEVvgC2p4bt8JOgxsAKjuuuBfN00Gjf+lc6k0pDam
         A7fE0gd95YmLpIaCoSYUwB4nfhst2rPz29KGzPJI=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] f2fs: fix to do sanity check on segment bitmap of LFS curseg
Date:   Sat, 25 May 2019 23:07:25 +0800
Message-Id: <20190525150725.3113-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Jungyeon Reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203233

- Reproduces
gcc poc_13.c
./run.sh f2fs

- Kernel messages
 F2FS-fs (sdb): Bitmap was wrongly set, blk:4608
 kernel BUG at fs/f2fs/segment.c:2133!
 RIP: 0010:update_sit_entry+0x35d/0x3e0
 Call Trace:
  f2fs_allocate_data_block+0x16c/0x5a0
  do_write_page+0x57/0x100
  f2fs_do_write_node_page+0x33/0xa0
  __write_node_page+0x270/0x4e0
  f2fs_sync_node_pages+0x5df/0x670
  f2fs_write_checkpoint+0x364/0x13a0
  f2fs_sync_fs+0xa3/0x130
  f2fs_do_sync_file+0x1a6/0x810
  do_fsync+0x33/0x60
  __x64_sys_fsync+0xb/0x10
  do_syscall_64+0x43/0x110
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The testcase fails because that, in fuzzed image, current segment was
allocated with LFS type, its .next_blkoff should point to an unused
block address, but actually, its bitmap shows it's not. So during
allocation, f2fs crash when setting bitmap.

Introducing sanity_check_curseg() to check such inconsistence of
current in-used segment.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- make sanity_check_curseg() static.
 fs/f2fs/segment.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5f6e4cd2eff2..a034e0da004a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4239,6 +4239,41 @@ static int build_dirty_segmap(struct f2fs_sb_info *sbi)
 	return init_victim_secmap(sbi);
 }
 
+static int sanity_check_curseg(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	/*
+	 * In LFS/SSR curseg, .next_blkoff should point to an unused blkaddr;
+	 * In LFS curseg, all blkaddr after .next_blkoff should be unused.
+	 */
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		struct seg_entry *se = get_seg_entry(sbi, curseg->segno);
+		unsigned int blkofs = curseg->next_blkoff;
+
+		if (f2fs_test_bit(blkofs, se->cur_valid_map))
+			goto out;
+
+		if (curseg->alloc_type == SSR)
+			continue;
+
+		for (blkofs += 1; blkofs < sbi->blocks_per_seg; blkofs++) {
+			if (!f2fs_test_bit(blkofs, se->cur_valid_map))
+				continue;
+out:
+			f2fs_msg(sbi->sb, KERN_ERR,
+				"Current segment's next free block offset is "
+				"inconsistent with bitmap, logtype:%u, "
+				"segno:%u, type:%u, next_blkoff:%u, blkofs:%u",
+				i, curseg->segno, curseg->alloc_type,
+				curseg->next_blkoff, blkofs);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 /*
  * Update min, max modified time for cost-benefit GC algorithm
  */
@@ -4334,6 +4369,10 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
+	err = sanity_check_curseg(sbi);
+	if (err)
+		return err;
+
 	init_min_max_mtime(sbi);
 	return 0;
 }
-- 
2.18.0

