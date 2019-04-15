Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5CE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDOHbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:31:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2549 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfDOHbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:31:04 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id DB06544539B7C6B8AE39;
        Mon, 15 Apr 2019 15:31:02 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:31:02 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:31:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 09/13] f2fs: fix to do sanity check on valid node/block count
Date:   Mon, 15 Apr 2019 15:30:50 +0800
Message-ID: <20190415073054.2577-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Jungyeon reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=203229

- Overview
When mounting the attached crafted image, following errors are reported.
Additionally, it hangs on sync after trying to mount it.

The image is intentionally fuzzed from a normal f2fs image for testing.
Compile options for F2FS are as follows.
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_CHECK_FS=y

- Reproduces
mkdir test
mount -t f2fs tmp.img test
sync

- Kernel message
 kernel BUG at fs/f2fs/recovery.c:591!
 RIP: 0010:recover_data+0x12d8/0x1780
 Call Trace:
  f2fs_recover_fsync_data+0x613/0x710
  f2fs_fill_super+0x1043/0x1aa0
  mount_bdev+0x16d/0x1a0
  mount_fs+0x4a/0x170
  vfs_kern_mount+0x5d/0x100
  do_mount+0x200/0xcf0
  ksys_mount+0x79/0xc0
  __x64_sys_mount+0x1c/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

With corrupted image wihch has out-of-range valid node/block count, during
recovery, once we failed due to no free space, it will trigger kernel
panic.

Adding sanity check on valid node/block count in f2fs_sanity_check_ckpt()
to detect such condition, so that potential panic can be avoided.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2cd78583218a..cbbb1e35070d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2592,7 +2592,8 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int log_blocks_per_seg;
 	unsigned int segment_count_main;
 	unsigned int cp_pack_start_sum, cp_payload;
-	block_t user_block_count;
+	block_t user_block_count, valid_user_blocks;
+	block_t avail_node_count, valid_node_count;
 	int i, j;
 
 	total = le32_to_cpu(raw_super->segment_count);
@@ -2627,6 +2628,24 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
+	valid_user_blocks = le64_to_cpu(ckpt->valid_block_count);
+	if (valid_user_blocks > user_block_count) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong valid_user_blocks: %u, user_block_count: %u",
+			valid_user_blocks, user_block_count);
+		return 1;
+	}
+
+	valid_node_count = le32_to_cpu(ckpt->valid_node_count);
+	avail_node_count = sbi->total_node_count - sbi->nquota_files -
+						F2FS_RESERVED_NODE_NUM;
+	if (valid_node_count > avail_node_count) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong valid_node_count: %u, avail_node_count: %u",
+			valid_node_count, avail_node_count);
+		return 1;
+	}
+
 	main_segs = le32_to_cpu(raw_super->segment_count_main);
 	blocks_per_seg = sbi->blocks_per_seg;
 
-- 
2.18.0.rc1

