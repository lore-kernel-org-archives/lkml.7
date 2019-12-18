Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF3EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87C424679
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699790;
	bh=/KD7EM6C7AOfwLcr9C9xpVsfMo+pOZkTit5WAuTRmPU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ymvXpihW0fDjkm9WQWNKkN2EppIDNPYSH8ATHSaN9d9fOllRI1wxQTceZ34KOUwA6
	 tzWOMQd8eAOQuHjMqAwVciH6ad7Z05UkU00y1+bANWB2v5xt9u0lMaD8tpTMZVn69k
	 CAW2waPKvZk3plQ9r/d0jqqmN9ff9brOwbMVN4y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLRUJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLRUJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:09:49 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DFEA2176D;
        Wed, 18 Dec 2019 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699788;
        bh=/KD7EM6C7AOfwLcr9C9xpVsfMo+pOZkTit5WAuTRmPU=;
        h=From:To:Cc:Subject:Date:From;
        b=2csad9tys+XBfYmT6nRuod03RfXeQE02r+DxP54UNLUBf7n32ThbskR3t6v5WcKzO
         27xZeBLu3zNBIqVL45BPIS0vj2dZL3cD9/lcpIDGnjyiAQgCwceFGBBukcV2rZn8kX
         zLBO6TgZHPvKEAoWLzsCi04ew4/2uu5aW1opLFTI=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: convert inline_dir early before starting rename
Date:   Wed, 18 Dec 2019 12:09:44 -0800
Message-Id: <20191218200947.20445-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we hit an error during rename, we'll get two dentries in different
directories.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/inline.c | 30 ++++++++++++++++++++++++++++--
 fs/f2fs/namei.c  | 36 +++++++++++++-----------------------
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dbc20d33d0e1..8d64525743cb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3490,6 +3490,7 @@ void f2fs_truncate_inline_inode(struct inode *inode,
 int f2fs_read_inline_data(struct inode *inode, struct page *page);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
+int f2fs_convert_inline_dir(struct inode *dir);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
 bool f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 52f85ed07a15..f82c3d9cf333 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -530,7 +530,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	return err;
 }
 
-static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
+static int do_convert_inline_dir(struct inode *dir, struct page *ipage,
 							void *inline_dentry)
 {
 	if (!F2FS_I(dir)->i_dir_level)
@@ -539,6 +539,32 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 		return f2fs_move_rehashed_dirents(dir, ipage, inline_dentry);
 }
 
+int f2fs_convert_inline_dir(struct inode *dir)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	struct page *ipage;
+	void *inline_dentry = NULL;
+	int err;
+
+	if (!f2fs_has_inline_dentry(dir))
+		return 0;
+
+	f2fs_lock_op(sbi);
+
+	ipage = f2fs_get_node_page(sbi, dir->i_ino);
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	inline_dentry = inline_data_addr(dir, ipage);
+
+	err = do_convert_inline_dir(dir, ipage, inline_dentry);
+	if (!err)
+		f2fs_put_page(ipage, 1);
+
+	f2fs_unlock_op(sbi);
+	return err;
+}
+
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 				const struct qstr *orig_name,
 				struct inode *inode, nid_t ino, umode_t mode)
@@ -562,7 +588,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 	if (bit_pos >= d.max) {
-		err = f2fs_convert_inline_dir(dir, ipage, inline_dentry);
+		err = do_convert_inline_dir(dir, ipage, inline_dentry);
 		if (err)
 			return err;
 		err = -EAGAIN;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5d9584281935..61615ab466c2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -855,7 +855,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
-	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -868,6 +867,19 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			F2FS_I(old_dentry->d_inode)->i_projid)))
 		return -EXDEV;
 
+	/*
+	 * old entry and new entry can locate in the same inline
+	 * dentry in inode, when attaching new entry in inline dentry,
+	 * it could force inline dentry conversion, after that,
+	 * old_entry and old_page will point to wrong address, in
+	 * order to avoid this, let's do the check and update here.
+	 */
+	if (old_dir == new_dir && !new_inode) {
+		err = f2fs_convert_inline_dir(old_dir);
+		if (err)
+			return err;
+	}
+
 	if (flags & RENAME_WHITEOUT) {
 		err = f2fs_create_whiteout(old_dir, &whiteout);
 		if (err)
@@ -954,28 +966,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 		if (old_dir_entry)
 			f2fs_i_links_write(new_dir, true);
-
-		/*
-		 * old entry and new entry can locate in the same inline
-		 * dentry in inode, when attaching new entry in inline dentry,
-		 * it could force inline dentry conversion, after that,
-		 * old_entry and old_page will point to wrong address, in
-		 * order to avoid this, let's do the check and update here.
-		 */
-		if (is_old_inline && !f2fs_has_inline_dentry(old_dir)) {
-			f2fs_put_page(old_page, 0);
-			old_page = NULL;
-
-			old_entry = f2fs_find_entry(old_dir,
-						&old_dentry->d_name, &old_page);
-			if (!old_entry) {
-				err = -ENOENT;
-				if (IS_ERR(old_page))
-					err = PTR_ERR(old_page);
-				f2fs_unlock_op(sbi);
-				goto out_dir;
-			}
-		}
 	}
 
 	down_write(&F2FS_I(old_inode)->i_sem);
-- 
2.24.0.525.g8f36a354ae-goog

