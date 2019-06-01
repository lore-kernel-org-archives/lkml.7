Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D9C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD8247A1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396551;
	bh=3jTmvq2cT+ZvZ9zG11JxSNmqh8KZfuc/h9w6ZwZ3sbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vqw2mkPxgJeJAGPGBm3UsfYTdB7GvSQ9aAQDgTddM5+kShQGySf9VG8dIQXioNFqW
	 Q4NouolHdErd79rgEhdSlTDgEjoSHmyJWtAwqoAXPRxQ10mU78SN+MOmz/bZ6uenAd
	 KgQ1fiwsqzGWebY5OhI9PjGfPlRQ0+KcGqZ7Xmto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFANma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfFANSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:18:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604C2272B4;
        Sat,  1 Jun 2019 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395128;
        bh=3jTmvq2cT+ZvZ9zG11JxSNmqh8KZfuc/h9w6ZwZ3sbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPvYAmnk9Fmvw0Fxv5oL04qCYvWiPuhKHRZeGtPE1jUA0kLOwfIkkUnD+FnEdwg/f
         UlfclVpUHixm5ZbPuW/SS/1uelzTooL3AK/BFBf51knWCwJwF7Fh6dCeYkABNhP0MW
         9+7gBgE2D8DdpEwKSJe6tv2wf4q2Y4xJ5VezKS/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.1 051/186] f2fs: fix to avoid panic in dec_valid_node_count()
Date:   Sat,  1 Jun 2019 09:14:27 -0400
Message-Id: <20190601131653.24205-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit ea6d7e72fea49402aa445345aade7a26b81732e3 ]

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
[Jaegeuk Kim: fix build warning and add unlikely]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 10240fbdd396d..e2cf567dcbd7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2029,7 +2029,6 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	f2fs_bug_on(sbi, !sbi->total_valid_block_count);
 	f2fs_bug_on(sbi, !sbi->total_valid_node_count);
-	f2fs_bug_on(sbi, !is_inode && !inode->i_blocks);
 
 	sbi->total_valid_node_count--;
 	sbi->total_valid_block_count--;
@@ -2039,10 +2038,19 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
 
 	spin_unlock(&sbi->stat_lock);
 
-	if (is_inode)
+	if (is_inode) {
 		dquot_free_inode(inode);
-	else
+	} else {
+		if (unlikely(inode->i_blocks == 0)) {
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"Inconsistent i_blocks, ino:%lu, iblocks:%llu",
+				inode->i_ino,
+				(unsigned long long)inode->i_blocks);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			return;
+		}
 		f2fs_i_blocks_write(inode, 1, false, true);
+	}
 }
 
 static inline unsigned int valid_node_count(struct f2fs_sb_info *sbi)
-- 
2.20.1

