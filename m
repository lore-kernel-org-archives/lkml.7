Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2431C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B3C217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfI0KBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:01:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:01:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F29BE8B5480A3CF5A6CF;
        Fri, 27 Sep 2019 18:01:52 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 27 Sep 2019 18:01:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update time in lazytime mode
Date:   Fri, 27 Sep 2019 18:01:35 +0800
Message-ID: <20190927100135.8285-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic/018 reports an inconsistent status of atime, the
testcase is as below:
- open file with O_SYNC
- write file to construct fraged space
- calc md5 of file
- record {a,c,m}time
- defrag file --- do nothing
- umount & mount
- check {a,c,m}time

The root cause is, as f2fs enables lazytime by default, atime
update will dirty vfs inode, rather than dirtying f2fs inode (by set
with FI_DIRTY_INODE), so later f2fs_write_inode() called from VFS will
fail to update inode page due to our skip:

f2fs_write_inode()
	if (is_inode_flag_set(inode, FI_DIRTY_INODE))
		return 0;

So eventually, after evict(), we lose last atime for ever.

To fix this issue, we need to check whether {a,c,m,cr}time is
consistent in between inode cache and inode page, and only skip
f2fs_update_inode() if f2fs inode is not dirty and time is
consistent as well.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 23 +++++++++++++++--------
 fs/f2fs/inode.c |  6 +++++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bc7d7ab70dea..a2f6403bdcb0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2709,6 +2709,20 @@ static inline void clear_file(struct inode *inode, int type)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+static inline bool f2fs_is_time_consistent(struct inode *inode)
+{
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
+						&F2FS_I(inode)->i_crtime))
+		return false;
+	return true;
+}
+
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
 	bool ret;
@@ -2726,14 +2740,7 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
-						&F2FS_I(inode)->i_crtime))
+	if (!f2fs_is_time_consistent(inode))
 		return false;
 
 	down_read(&F2FS_I(inode)->i_sem);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 137ba1c6873d..540280cee614 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -615,7 +615,11 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
-	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
+	/*
+	 * atime could be updated without dirtying f2fs inode in lazytime mode
+	 */
+	if (f2fs_is_time_consistent(inode) &&
+		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
 	if (!f2fs_is_checkpoint_ready(sbi))
-- 
2.18.0.rc1

