Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5D4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF592199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfGVJ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:58:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728223AbfGVJ57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:57:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2301ABC8BDB3F9827B7E;
        Mon, 22 Jul 2019 17:57:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 22 Jul 2019 17:57:45 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <drosen@google.com>, Chao Yu <yuchao0@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to spread f2fs_is_checkpoint_ready()
Date:   Mon, 22 Jul 2019 17:57:05 +0800
Message-ID: <20190722095706.116545-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We missed to call f2fs_is_checkpoint_ready() in several places, it may
allow space allocation even when free space was exhausted during
checkpoint is disabled, fix to add them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c  | 11 +++++++++++
 fs/f2fs/namei.c |  4 ++++
 fs/f2fs/xattr.c |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae0fec54cac6..43d878f3db0f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -57,6 +57,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		err = -EIO;
 		goto err;
 	}
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		goto err;
 
 	sb_start_pagefault(inode->i_sb);
 
@@ -1568,6 +1571,9 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
+	ret = f2fs_is_checkpoint_ready(F2FS_I_SB(inode));
+	if (ret)
+		return ret;
 
 	/* f2fs only support ->fallocate for regular file */
 	if (!S_ISREG(inode->i_mode))
@@ -3150,8 +3156,13 @@ static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
 
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	int ret;
+
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
 		return -EIO;
+	ret = f2fs_is_checkpoint_ready(F2FS_I_SB(file_inode(filp)));
+	if (ret)
+		return ret;
 
 	switch (cmd) {
 	case F2FS_IOC_GETFLAGS:
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c5b99042e6f2..09fb4f31576e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -801,9 +801,13 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	int ret;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
+	ret = f2fs_is_checkpoint_ready(sbi);
+	if (ret)
+		return ret;
 
 	if (IS_ENCRYPTED(dir) || DUMMY_ENCRYPTION_ENABLED(sbi)) {
 		int err = fscrypt_get_encryption_info(dir);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index b32c45621679..3c92f4122044 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -21,6 +21,7 @@
 #include <linux/posix_acl_xattr.h>
 #include "f2fs.h"
 #include "xattr.h"
+#include "segment.h"
 
 static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
@@ -729,6 +730,10 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
+	err = f2fs_is_checkpoint_ready(sbi);
+	if (err)
+		return err;
+
 	err = dquot_initialize(inode);
 	if (err)
 		return err;
-- 
2.18.0.rc1

