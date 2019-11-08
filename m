Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A0FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1690215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214781;
	bh=KBCPrtaK8CUF7LqGnIIJRU4tEy3EaC6ukV+sjBbT34A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uv0VemDknJlZfcpK3YKbH0CqjV/7pDqKg6Jtlhyjwgs9UgrFYefXrDBbrWyIWi82X
	 c9ZE14ZAp8b3xtnJxfh2TjnKu2HLnOGMnnTQet11oG4Kwhxortj1GUTAibcndbKhun
	 Qw5yZAyKefZLtURhJHmwe0dBZaL1OeyfYK+Aorro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbfKHLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732718AbfKHLlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E384A222C4;
        Fri,  8 Nov 2019 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213274;
        bh=KBCPrtaK8CUF7LqGnIIJRU4tEy3EaC6ukV+sjBbT34A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wx7cEvQPuV9PYv6mhZjEiEsJbAdwWD/UgZ3gTsegSqSowLX/on8Y16Hhgjf8k+5kq
         AHVns+34Od5XdK4wqZdbhyFPyNLR1K9zwGv4G3nWnXJ32G1/MWEDPrvaRzMwHyAjhM
         wsLgV0Ea6ogNVLGNdr/uzQMB5vcTnOZzoHGHhQEU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Wang Shilong <wshilong@ddn.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 136/205] f2fs: fix setattr project check upon fssetxattr ioctl
Date:   Fri,  8 Nov 2019 06:36:43 -0500
Message-Id: <20191108113752.12502-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Shilong <wangshilong1991@gmail.com>

[ Upstream commit c8e927579e00a182eda07e4c45df9c8c699c8ded ]

Currently, project quota could be changed by fssetxattr
ioctl, and existed permission check inode_owner_or_capable()
is obviously not enough, just think that common users could
change project id of file, that could make users to
break project quota easily.

This patch try to follow same regular of xfs project
quota:

"Project Quota ID state is only allowed to change from
within the init namespace. Enforce that restriction only
if we are trying to change the quota ID state.
Everything else is allowed in user namespaces."

Besides that, check and set project id'state should
be an atomic operation, protect whole operation with
inode lock.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 60 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6972c6d7c3893..c7ea122997695 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2618,34 +2618,26 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	if (projid_eq(kprojid, F2FS_I(inode)->i_projid))
 		return 0;
 
-	err = mnt_want_write_file(filp);
-	if (err)
-		return err;
-
 	err = -EPERM;
-	inode_lock(inode);
-
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
-		goto out_unlock;
+		return err;
 
 	ipage = f2fs_get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage)) {
-		err = PTR_ERR(ipage);
-		goto out_unlock;
-	}
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
 
 	if (!F2FS_FITS_IN_INODE(F2FS_INODE(ipage), fi->i_extra_isize,
 								i_projid)) {
 		err = -EOVERFLOW;
 		f2fs_put_page(ipage, 1);
-		goto out_unlock;
+		return err;
 	}
 	f2fs_put_page(ipage, 1);
 
 	err = dquot_initialize(inode);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
 	if (!IS_ERR(transfer_to[PRJQUOTA])) {
@@ -2659,9 +2651,6 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	inode->i_ctime = current_time(inode);
 out_dirty:
 	f2fs_mark_inode_dirty_sync(inode, true);
-out_unlock:
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	return err;
 }
 #else
@@ -2737,6 +2726,30 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
+{
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() == &init_user_ns)
+		return 0;
+
+	if (__kprojid_val(F2FS_I(inode)->i_projid) != fa->fsx_projid)
+		return -EINVAL;
+
+	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL) {
+		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
+			return -EINVAL;
+	} else {
+		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -2764,19 +2777,20 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 		return err;
 
 	inode_lock(inode);
+	err = f2fs_ioctl_check_project(inode, &fa);
+	if (err)
+		goto out;
 	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
 				(flags & F2FS_FL_XFLAG_VISIBLE);
 	err = __f2fs_ioc_setflags(inode, flags);
-	inode_unlock(inode);
-	mnt_drop_write_file(filp);
 	if (err)
-		return err;
+		goto out;
 
 	err = f2fs_ioc_setproject(filp, fa.fsx_projid);
-	if (err)
-		return err;
-
-	return 0;
+out:
+	inode_unlock(inode);
+	mnt_drop_write_file(filp);
+	return err;
 }
 
 int f2fs_pin_file_control(struct inode *inode, bool inc)
-- 
2.20.1

