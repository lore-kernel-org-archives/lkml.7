Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E2420880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfGQJGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:06:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfGQJGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:06:31 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83541B80C45060901816;
        Wed, 17 Jul 2019 17:06:29 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 17 Jul 2019 17:06:20 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support FS_IOC_{GET,SET}FSLABEL
Date:   Wed, 17 Jul 2019 17:06:11 +0800
Message-ID: <20190717090611.46011-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support two generic fs ioctls FS_IOC_{GET,SET}FSLABEL, letting
f2fs pass generic/492 testcase.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  3 ++
 fs/f2fs/file.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 17382da7f0bd..76d2e82f2519 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -417,6 +417,9 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
 #define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
 
+#define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
+#define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
+
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e58a6f697dd..7ca545874060 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -20,6 +20,7 @@
 #include <linux/uio.h>
 #include <linux/uuid.h>
 #include <linux/file.h>
+#include <linux/nls.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3060,6 +3061,77 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_get_volume_name(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	char *vbuf;
+	int count;
+	int err = 0;
+
+	vbuf = f2fs_kzalloc(sbi, MAX_VOLUME_NAME, GFP_KERNEL);
+	if (!vbuf)
+		return -ENOMEM;
+
+	down_read(&sbi->sb_lock);
+	count = utf16s_to_utf8s(sbi->raw_super->volume_name,
+			sizeof(sbi->raw_super->volume_name),
+			UTF16_LITTLE_ENDIAN, vbuf, MAX_VOLUME_NAME);
+	up_read(&sbi->sb_lock);
+
+	if (copy_to_user((char __user *)arg, vbuf,
+				min(FSLABEL_MAX, count)))
+		err = -EFAULT;
+
+	kvfree(vbuf);
+	return err;
+}
+
+static int f2fs_set_volume_name(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	char *vbuf;
+	int len;
+	int err = 0;
+
+	vbuf = f2fs_kzalloc(sbi, MAX_VOLUME_NAME, GFP_KERNEL);
+	if (!vbuf)
+		return -ENOMEM;
+
+	if (copy_from_user(vbuf, (char __user *)arg, FSLABEL_MAX)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	len = strnlen(vbuf, FSLABEL_MAX);
+	if (len > FSLABEL_MAX - 1) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = mnt_want_write_file(filp);
+	if (err)
+		goto out;
+
+	down_write(&sbi->sb_lock);
+
+	memset(sbi->raw_super->volume_name, 0,
+			sizeof(sbi->raw_super->volume_name));
+	utf8s_to_utf16s(vbuf, MAX_VOLUME_NAME, UTF16_LITTLE_ENDIAN,
+			sbi->raw_super->volume_name,
+			sizeof(sbi->raw_super->volume_name));
+
+	err = f2fs_commit_super(sbi, false);
+
+	up_write(&sbi->sb_lock);
+
+	mnt_drop_write_file(filp);
+out:
+	kvfree(vbuf);
+	return err;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3118,6 +3190,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_precache_extents(filp, arg);
 	case F2FS_IOC_RESIZE_FS:
 		return f2fs_ioc_resize_fs(filp, arg);
+	case F2FS_IOC_GET_VOLUME_NAME:
+		return f2fs_get_volume_name(filp, arg);
+	case F2FS_IOC_SET_VOLUME_NAME:
+		return f2fs_set_volume_name(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -3232,6 +3308,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
 	case F2FS_IOC_RESIZE_FS:
+	case F2FS_IOC_GET_VOLUME_NAME:
+	case F2FS_IOC_SET_VOLUME_NAME:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.18.0.rc1

