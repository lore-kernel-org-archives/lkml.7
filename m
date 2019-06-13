Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06541C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD40820679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441976;
	bh=6q3+a1H37V+tVzxjQKaFzwYJA5aGRelYPMBVYYr0JMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFKIFXLkMA3B1YQIXWpVr4GP1/BE0PH0CHOrrD1/7uG1B62xo//fJn8jWQjEJsNwG
	 ea63crmRXmhzhEaZigjnnm6ec6AIsjpPT2lxg5kL363tHQgyOPA7p/OIQlWC52jCQ/
	 Q7rhX5IsmNRv2G/6eduysMkPcMeipCCmfull1sLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbfFMQGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfFMIqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E02C20851;
        Thu, 13 Jun 2019 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415573;
        bh=6q3+a1H37V+tVzxjQKaFzwYJA5aGRelYPMBVYYr0JMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqvEjYWaZ2IU4HqvkmQ8xA9ojG9z+w6wnDBavfWA263Uj0Gtghb0g/peDMm42yhM9
         Eco4vCQHECNa51TnpcQK0P52ih70u50DGkD3R3D4jwBF+KqL3LeKJHcBi0imGch/6O
         4WVd0MCDULiuNJNs6vzYDV2Fw4ebVddsxvrxALNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 050/155] f2fs: fix to avoid panic in dec_valid_node_count()
Date:   Thu, 13 Jun 2019 10:32:42 +0200
Message-Id: <20190613075655.926310450@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 10240fbdd396..e2cf567dcbd7 100644
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



