Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0383BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EFD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfDOLjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:39:48 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfDOLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:39:48 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 3EB7EF6C5183527CC0E0;
        Mon, 15 Apr 2019 19:39:44 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 19:39:43 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 19:39:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 13/13] f2fs: don't recovery orphan inode on readonly device
Date:   Mon, 15 Apr 2019 19:39:33 +0800
Message-ID: <20190415113933.21621-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Park Ju Hyung reported in mailing list:

https://sourceforge.net/p/linux-f2fs/mailman/message/36639787/

generic_make_request: Trying to write to read-only block-device loop0 (partno 0)
WARNING: CPU: 0 PID: 23437 at block/blk-core.c:2174 generic_make_request_checks+0x594/0x630

 generic_make_request+0x46/0x3d0
 submit_bio+0x30/0x110
 __submit_merged_bio+0x68/0x390
 f2fs_submit_page_write+0x1bb/0x7f0
 f2fs_do_write_meta_page+0x7f/0x160
 __f2fs_write_meta_page+0x70/0x140
 f2fs_sync_meta_pages+0x140/0x250
 f2fs_write_checkpoint+0x5c5/0x17b0
 f2fs_sync_fs+0x9c/0x110
 sync_filesystem+0x66/0x80
 f2fs_recover_fsync_data+0x790/0xa30
 f2fs_fill_super+0xe4e/0x1980
 mount_bdev+0x518/0x610
 mount_fs+0x34/0x13f
 vfs_kern_mount.part.11+0x4f/0x120
 do_mount+0x2d1/0xe40
 __x64_sys_mount+0xbf/0xe0
 do_syscall_64+0x4a/0xf0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

print_req_error: I/O error, dev loop0, sector 4096

If block device is readonly, we should never trigger write IO from
filesystem layer, but previously, orphan recovery didn't consider
such condition, result in triggering above warning, fix it.

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- adjust Park's first/last name order.
 fs/f2fs/checkpoint.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a7ad1b1e5750..90e1bab86269 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -674,6 +674,12 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
+	if (bdev_read_only(sbi->sb->s_bdev)) {
+		f2fs_msg(sbi->sb, KERN_INFO, "write access "
+			"unavailable, skipping orphan cleanup");
+		return 0;
+	}
+
 	if (s_flags & SB_RDONLY) {
 		f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
 		sbi->sb->s_flags &= ~SB_RDONLY;
-- 
2.18.0.rc1

