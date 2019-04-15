Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D0C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0139520874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfDOH2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:28:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2547 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfDOH2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:28:51 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 92197F17DB7EEC30DC74;
        Mon, 15 Apr 2019 15:28:49 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:28:48 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:28:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 02/13] f2fs: fix to avoid panic in dec_valid_node_count()
Date:   Mon, 15 Apr 2019 15:28:31 +0800
Message-ID: <20190415072842.2438-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415072842.2438-1-yuchao0@huawei.com>
References: <20190415072842.2438-1-yuchao0@huawei.com>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203213

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the this script.

The image is intentionally fuzzed from a normal f2fs image for testing and I enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

 kernel BUG at fs/f2fs/f2fs.h:2012!
 RIP: 0010:truncate_node+0x2c9/0x2e0
 Call Trace:
  f2fs_truncate_xattr_node+0xa1/0x130
  f2fs_remove_inode_page+0x82/0x2d0
  f2fs_evict_inode+0x2a3/0x3a0
  evict+0xba/0x180
  __dentry_kill+0xbe/0x160
  dentry_kill+0x46/0x180
  dput+0xbb/0x100
  do_renameat2+0x3c9/0x550
  __x64_sys_rename+0x17/0x20
  do_syscall_64+0x43/0xf0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is dec_valid_node_count() will trigger kernel panic due to
inconsistent count in between inode.i_blocks and actual block.

To avoid panic, let's just print debug message and set SBI_NEED_FSCK to
give a hint to fsck for latter repairing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8952ce8f94b8..b98b22039f58 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2028,7 +2028,6 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	f2fs_bug_on(sbi, !sbi->total_valid_block_count);
 	f2fs_bug_on(sbi, !sbi->total_valid_node_count);
-	f2fs_bug_on(sbi, !is_inode && !inode->i_blocks);
 
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
@@ -2038,10 +2037,18 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_unlock(&sbi->stat_lock);
 
-	if (is_inode)
+	if (is_inode) {
 		dquot_free_inode(inode);
-	else
+	} else {
+		if (!inode->i_blocks) {
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"Inconsistent i_blocks, ino:%lu, iblocks:%zu",
+				inode->i_ino, inode->i_blocks);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			return;
+		}
 		f2fs_i_blocks_write(inode, 1, false, true);
+	}
 }
 
 static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
-- 
2.18.0.rc1

