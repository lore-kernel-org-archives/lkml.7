Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF870C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FE12080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575930238;
	bh=GVlYvsMRRyavxn/zXjrz3uDCgvOaDXX411kOrF5IbxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+izdfVySR25bp5+mLor/VcNGGXnxupngGGMl+t9MESFjM2CbjD+u2jeQJl7TjRBw
	 QDyPBUQ/dan5fTlEesp4v3wk2c6X9Z/KDPnGhzuqr7HvXkR0ANxuyWOW6+ll9gKCmT
	 5YR5wf1JVBx7B4XcskdbZgw5gVdy8AZSIszGDzwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLIWXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLIWXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:51 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092792077B;
        Mon,  9 Dec 2019 22:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930230;
        bh=GVlYvsMRRyavxn/zXjrz3uDCgvOaDXX411kOrF5IbxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XR0W5USgZHzG07sOfWJ+ubFjq+I6N+kRIQeyWBCCKrSrgXbDpt26yGGazqqXogFEz
         N7kvMXysmOh/pKZitWqMXVRyJT5yxR+dlnRvwDknxMoO+9WPrmW0ZNNI5BvsY4Si79
         ZKLgZgR82aj2yi3QmEm75W32A43j1VBFC5LQizAg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/6] f2fs: set I_LINKABLE early to avoid wrong access by vfs
Date:   Mon,  9 Dec 2019 14:23:45 -0800
Message-Id: <20191209222345.1078-6-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves setting I_LINKABLE early in rename2(whiteout) to avoid the
below warning.

[ 3189.163385] WARNING: CPU: 3 PID: 59523 at fs/inode.c:358 inc_nlink+0x32/0x40
[ 3189.246979] Call Trace:
[ 3189.248707]  f2fs_init_inode_metadata+0x2d6/0x440 [f2fs]
[ 3189.251399]  f2fs_add_inline_entry+0x162/0x8c0 [f2fs]
[ 3189.254010]  f2fs_add_dentry+0x69/0xe0 [f2fs]
[ 3189.256353]  f2fs_do_add_link+0xc5/0x100 [f2fs]
[ 3189.258774]  f2fs_rename2+0xabf/0x1010 [f2fs]
[ 3189.261079]  vfs_rename+0x3f8/0xaa0
[ 3189.263056]  ? tomoyo_path_rename+0x44/0x60
[ 3189.265283]  ? do_renameat2+0x49b/0x550
[ 3189.267324]  do_renameat2+0x49b/0x550
[ 3189.269316]  __x64_sys_renameat2+0x20/0x30
[ 3189.271441]  do_syscall_64+0x5a/0x230
[ 3189.273410]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3189.275848] RIP: 0033:0x7f270b4d9a49

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a1c507b0b4ac..5d9584281935 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -797,6 +797,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 
 	if (whiteout) {
 		f2fs_i_links_write(inode, false);
+		inode->i_state |= I_LINKABLE;
 		*whiteout = inode;
 	} else {
 		d_tmpfile(dentry, inode);
@@ -867,6 +868,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			F2FS_I(old_dentry->d_inode)->i_projid)))
 		return -EXDEV;
 
+	if (flags & RENAME_WHITEOUT) {
+		err = f2fs_create_whiteout(old_dir, &whiteout);
+		if (err)
+			return err;
+	}
+
 	err = dquot_initialize(old_dir);
 	if (err)
 		goto out;
@@ -898,17 +905,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		}
 	}
 
-	if (flags & RENAME_WHITEOUT) {
-		err = f2fs_create_whiteout(old_dir, &whiteout);
-		if (err)
-			goto out_dir;
-	}
-
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
 		if (old_dir_entry && !f2fs_empty_dir(new_inode))
-			goto out_whiteout;
+			goto out_dir;
 
 		err = -ENOENT;
 		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
@@ -916,7 +917,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (!new_entry) {
 			if (IS_ERR(new_page))
 				err = PTR_ERR(new_page);
-			goto out_whiteout;
+			goto out_dir;
 		}
 
 		f2fs_balance_fs(sbi, true);
@@ -948,7 +949,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		err = f2fs_add_link(new_dentry, old_inode);
 		if (err) {
 			f2fs_unlock_op(sbi);
-			goto out_whiteout;
+			goto out_dir;
 		}
 
 		if (old_dir_entry)
@@ -972,7 +973,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				if (IS_ERR(old_page))
 					err = PTR_ERR(old_page);
 				f2fs_unlock_op(sbi);
-				goto out_whiteout;
+				goto out_dir;
 			}
 		}
 	}
@@ -991,7 +992,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
 	if (whiteout) {
-		whiteout->i_state |= I_LINKABLE;
 		set_inode_flag(whiteout, FI_INC_LINK);
 		err = f2fs_add_link(old_dentry, whiteout);
 		if (err)
@@ -1027,15 +1027,14 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_unlock_op(sbi);
 	if (new_page)
 		f2fs_put_page(new_page, 0);
-out_whiteout:
-	if (whiteout)
-		iput(whiteout);
 out_dir:
 	if (old_dir_entry)
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
 out:
+	if (whiteout)
+		iput(whiteout);
 	return err;
 }
 
-- 
2.19.0.605.g01d371f741-goog

