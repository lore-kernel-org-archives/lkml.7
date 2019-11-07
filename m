Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DAC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177C121882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKGGM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:12:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfKGGM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:12:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89D4ACF001A7AC68CC88;
        Thu,  7 Nov 2019 14:12:24 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 7 Nov 2019 14:12:18 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update dir's i_pino during cross_rename
Date:   Thu, 7 Nov 2019 14:12:05 +0800
Message-ID: <20191107061205.120972-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Eric reported:

RENAME_EXCHANGE support was just added to fsstress in xfstests:

	commit 65dfd40a97b6bbbd2a22538977bab355c5bc0f06
	Author: kaixuxia <xiakaixu1987@gmail.com>
	Date:   Thu Oct 31 14:41:48 2019 +0800

	    fsstress: add EXCHANGE renameat2 support

This is causing xfstest generic/579 to fail due to fsck.f2fs reporting errors.
I'm not sure what the problem is, but it still happens even with all the
fs-verity stuff in the test commented out, so that the test just runs fsstress.

generic/579 23s ... 	[10:02:25]
[    7.745370] run fstests generic/579 at 2019-11-04 10:02:25
_check_generic_filesystem: filesystem on /dev/vdc is inconsistent
(see /results/f2fs/results-default/generic/579.full for details)
 [10:02:47]
Ran: generic/579
Failures: generic/579
Failed 1 of 1 tests
Xunit report: /results/f2fs/results-default/result.xml

Here's the contents of 579.full:

_check_generic_filesystem: filesystem on /dev/vdc is inconsistent
*** fsck.f2fs output ***
[ASSERT] (__chk_dots_dentries:1378)  --> Bad inode number[0x24] for '..', parent parent ino is [0xd10]

The root cause is that we forgot to update directory's i_pino during
cross_rename, fix it.

Fixes: 32f9bc25cbda0 ("f2fs: support ->rename2()")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 4faf06e8bf89..a1c507b0b4ac 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -981,7 +981,8 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (!old_dir_entry || whiteout)
 		file_lost_pino(old_inode);
 	else
-		F2FS_I(old_inode)->i_pino = new_dir->i_ino;
+		/* adjust dir's i_pino to pass fsck check */
+		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_inode->i_ctime = current_time(old_inode);
@@ -1141,7 +1142,11 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_set_link(old_dir, old_entry, old_page, new_inode);
 
 	down_write(&F2FS_I(old_inode)->i_sem);
-	file_lost_pino(old_inode);
+	if (!old_dir_entry)
+		file_lost_pino(old_inode);
+	else
+		/* adjust dir's i_pino to pass fsck check */
+		f2fs_i_pino_write(old_inode, new_dir->i_ino);
 	up_write(&F2FS_I(old_inode)->i_sem);
 
 	old_dir->i_ctime = current_time(old_dir);
@@ -1156,7 +1161,11 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_set_link(new_dir, new_entry, new_page, old_inode);
 
 	down_write(&F2FS_I(new_inode)->i_sem);
-	file_lost_pino(new_inode);
+	if (!new_dir_entry)
+		file_lost_pino(new_inode);
+	else
+		/* adjust dir's i_pino to pass fsck check */
+		f2fs_i_pino_write(new_inode, old_dir->i_ino);
 	up_write(&F2FS_I(new_inode)->i_sem);
 
 	new_dir->i_ctime = current_time(new_dir);
-- 
2.18.0.rc1

