Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9320C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3521734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577990179;
	bh=cAJch8E98Yde9Q6jB5a/DbOzzwQMU78RAg4MI6g8TjU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=op3ZSvvqzoO1TRHZYSrAZqR6uDOeSIFzp1qCHeSZZ6xTZddCwwgo8bt/MnzQ9TWxG
	 MDcXaKI/ZM0hFCsxGnrgSQk/5pz39puMAjgsSpipPKf7fa0MSh+SBkV285h6B8A1x0
	 SGTwN29TtEJxdXoKcEv6wuzNsST2kbEXcn6opC5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgABSgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgABSgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:36:18 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 516DA21655;
        Thu,  2 Jan 2020 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577990176;
        bh=cAJch8E98Yde9Q6jB5a/DbOzzwQMU78RAg4MI6g8TjU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=YZQXquIexwSdBelG2BheE5kncWA3EKX6ZqTlT4TQMx6fzFg58727D+80VV6mMK7n/
         3HAjtQVkTzcVL7z37r+M+eJ9HHUQAImrqnJOAwgzz8yvJXcP3qikKP+KZX/oZdAhVt
         U8fRGLTnvV1zzbEEgB6Ofv9R11T6z3Xyo+72a56o=
Date:   Thu, 2 Jan 2020 10:36:15 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4 v2] f2fs: convert inline_dir early before starting
 rename
Message-ID: <20200102183615.GB1953@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191218200947.20445-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218200947.20445-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we hit an error during rename, we'll get two dentries in different
directories.

Chao adds to check the room in inline_dir which can avoid needless
inversion. This should be done by inode_lock(&old_dir).

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c    | 14 ++++++++++++++
 fs/f2fs/f2fs.h   |  3 +++
 fs/f2fs/inline.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/namei.c  | 37 ++++++++++++++-----------------------
 4 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c967cacf979e..b56f6060c1a6 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -578,6 +578,20 @@ int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots)
 	goto next;
 }
 
+bool f2fs_has_enough_room(struct inode *dir, struct page *ipage,
+					struct fscrypt_name *fname)
+{
+	struct f2fs_dentry_ptr d;
+	unsigned int bit_pos;
+	int slots = GET_DENTRY_SLOTS(fname_len(fname));
+
+	make_dentry_ptr_inline(dir, &d, inline_data_addr(dir, ipage));
+
+	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
+
+	return bit_pos < d.max;
+}
+
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 				const struct qstr *name, f2fs_hash_t name_hash,
 				unsigned int bit_pos)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 740e4f11bd1f..0164c8279037 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3121,6 +3121,8 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
 			struct page **page);
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 			struct page *page, struct inode *inode);
+bool f2fs_has_enough_room(struct inode *dir, struct page *ipage,
+			struct fscrypt_name *fname);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 			const struct qstr *name, f2fs_hash_t name_hash,
 			unsigned int bit_pos);
@@ -3663,6 +3665,7 @@ void f2fs_truncate_inline_inode(struct inode *inode,
 int f2fs_read_inline_data(struct inode *inode, struct page *page);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
+int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
 bool f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 52f85ed07a15..4167e5408151 100644
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
@@ -539,6 +539,44 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 		return f2fs_move_rehashed_dirents(dir, ipage, inline_dentry);
 }
 
+int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	struct page *ipage;
+	struct fscrypt_name fname;
+	void *inline_dentry = NULL;
+	int err = 0;
+
+	if (!f2fs_has_inline_dentry(dir))
+		return 0;
+
+	f2fs_lock_op(sbi);
+
+	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
+	if (err)
+		goto out;
+
+	ipage = f2fs_get_node_page(sbi, dir->i_ino);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
+		goto out;
+	}
+
+	if (f2fs_has_enough_room(dir, ipage, &fname)) {
+		f2fs_put_page(ipage, 1);
+		goto out;
+	}
+
+	inline_dentry = inline_data_addr(dir, ipage);
+
+	err = do_convert_inline_dir(dir, ipage, inline_dentry);
+	if (!err)
+		f2fs_put_page(ipage, 1);
+out:
+	f2fs_unlock_op(sbi);
+	return err;
+}
+
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 				const struct qstr *orig_name,
 				struct inode *inode, nid_t ino, umode_t mode)
@@ -562,7 +600,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 	if (bit_pos >= d.max) {
-		err = f2fs_convert_inline_dir(dir, ipage, inline_dentry);
+		err = do_convert_inline_dir(dir, ipage, inline_dentry);
 		if (err)
 			return err;
 		err = -EAGAIN;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d479b91f9ca0..2aa035422c0f 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -906,7 +906,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
-	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -919,6 +918,20 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			F2FS_I(old_dentry->d_inode)->i_projid)))
 		return -EXDEV;
 
+	/*
+	 * If new_inode is null, the below renaming flow will
+	 * add a link in old_dir which can conver inline_dir.
+	 * After then, if we failed to get the entry due to other
+	 * reasons like ENOMEM, we had to remove the new entry.
+	 * Instead of adding such the error handling routine, let's
+	 * simply convert first here.
+	 */
+	if (old_dir == new_dir && !new_inode) {
+		err = f2fs_try_convert_inline_dir(old_dir, new_dentry);
+		if (err)
+			return err;
+	}
+
 	if (flags & RENAME_WHITEOUT) {
 		err = f2fs_create_whiteout(old_dir, &whiteout);
 		if (err)
@@ -1006,28 +1019,6 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
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

