Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94B1C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878E422CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfICCGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:06:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfICCGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:06:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2BC6DC61656970BAF950;
        Tue,  3 Sep 2019 10:06:35 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 10:06:30 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: convert inline_data in prior to i_size_write
Date:   Tue, 3 Sep 2019 10:06:26 +0800
Message-ID: <20190903020626.93020-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190903020626.93020-1-yuchao0@huawei.com>
References: <20190903020626.93020-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

In below call path, we change i_size before inline conversion, however,
if we failed to convert inline inode, the inode may have wrong i_size
which is larger than max inline size, result inline inode corruption.

- f2fs_setattr
 - truncate_setsize
 - f2fs_convert_inline_inode

This patch reorders truncate_setsize() and f2fs_convert_inline_inode()
to guarantee inline_data has valid i_size.

Fixes: 0cab80ee0c9e ("f2fs: fix to convert inline inode in ->setattr")
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6528216ab832..10927a0b8df3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -814,14 +814,24 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		bool to_smaller = (attr->ia_size <= i_size_read(inode));
+		loff_t old_size = i_size_read(inode);
+
+		if (attr->ia_size > MAX_INLINE_DATA(inode)) {
+			/*
+			 * should convert inline inode before i_size_write to
+			 * keep smaller than inline_data size with inline flag.
+			 */
+			err = f2fs_convert_inline_inode(inode);
+			if (err)
+				return err;
+		}
 
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 
 		truncate_setsize(inode, attr->ia_size);
 
-		if (to_smaller)
+		if (attr->ia_size <= old_size)
 			err = f2fs_truncate(inode);
 		/*
 		 * do not trim all blocks after i_size if target size is
@@ -829,21 +839,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		 */
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-
 		if (err)
 			return err;
 
-		if (!to_smaller) {
-			/* should convert inline inode here */
-			if (!f2fs_may_inline_data(inode)) {
-				err = f2fs_convert_inline_inode(inode);
-				if (err)
-					return err;
-			}
-			inode->i_mtime = inode->i_ctime = current_time(inode);
-		}
-
 		down_write(&F2FS_I(inode)->i_sem);
+		inode->i_mtime = inode->i_ctime = current_time(inode);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		up_write(&F2FS_I(inode)->i_sem);
 	}
-- 
2.18.0.rc1

