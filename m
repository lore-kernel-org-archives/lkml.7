Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3FF2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfDBNkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43610 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731511AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002og-69; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004vR-2h; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.545690309@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 62/99] ext4: avoid declaring fs inconsistent due to
 invalid file handles
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8a363970d1dc38c4ec4ad575c862f776f468d057 upstream.

If we receive a file handle, either from NFS or open_by_handle_at(2),
and it points at an inode which has not been initialized, and the file
system has metadata checksums enabled, we shouldn't try to get the
inode, discover the checksum is invalid, and then declare the file
system as being inconsistent.

This can be reproduced by creating a test file system via "mke2fs -t
ext4 -O metadata_csum /tmp/foo.img 8M", mounting it, cd'ing into that
directory, and then running the following program.

#define _GNU_SOURCE
#include <fcntl.h>

struct handle {
	struct file_handle fh;
	unsigned char fid[MAX_HANDLE_SZ];
};

int main(int argc, char **argv)
{
	struct handle h = {{8, 1 }, { 12, }};

	open_by_handle_at(AT_FDCWD, &h.fh, O_RDONLY);
	return 0;
}

Google-Bug-Id: 120690101
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - Keep using EIO instead of EFSCORRUPTED and EFSBADCRC
 - Drop inapplicable changes
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2165,8 +2165,19 @@ int do_journal_get_write_access(handle_t
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
-extern struct inode *ext4_iget(struct super_block *, unsigned long);
-extern struct inode *ext4_iget_normal(struct super_block *, unsigned long);
+typedef enum {
+	EXT4_IGET_NORMAL =	0,
+	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
+	EXT4_IGET_HANDLE = 	0x0002	/* Inode # is from a handle */
+} ext4_iget_flags;
+
+extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+				 ext4_iget_flags flags, const char *function,
+				 unsigned int line);
+
+#define ext4_iget(sb, ino, flags) \
+	__ext4_iget((sb), (ino), (flags), __func__, __LINE__)
+
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct dentry *, struct iattr *);
 extern int  ext4_getattr(struct vfsmount *mnt, struct dentry *dentry,
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1094,7 +1094,7 @@ struct inode *ext4_orphan_get(struct sup
 	if (!ext4_test_bit(bit, bitmap_bh->b_data))
 		goto bad_orphan;
 
-	inode = ext4_iget(sb, ino);
+	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4174,7 +4174,9 @@ static inline int ext4_iget_extra_inode(
 	return 0;
 }
 
-struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
+struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+			  ext4_iget_flags flags, const char *function,
+			  unsigned int line)
 {
 	struct ext4_iloc iloc;
 	struct ext4_inode *raw_inode;
@@ -4187,6 +4189,18 @@ struct inode *ext4_iget(struct super_blo
 	uid_t i_uid;
 	gid_t i_gid;
 
+	if (((flags & EXT4_IGET_NORMAL) &&
+	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
+	    (ino < EXT4_ROOT_INO) ||
+	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
+		if (flags & EXT4_IGET_HANDLE)
+			return ERR_PTR(-ESTALE);
+		__ext4_error(sb, function, line,
+			     "inode #%lu: comm %s: iget: illegal inode #",
+			     ino, current->comm);
+		return ERR_PTR(-EIO);
+	}
+
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
@@ -4202,18 +4216,27 @@ struct inode *ext4_iget(struct super_blo
 	raw_inode = ext4_raw_inode(&iloc);
 
 	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
-		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: root inode unallocated");
 		ret = -EIO;
 		goto bad_inode;
 	}
 
+	if ((flags & EXT4_IGET_HANDLE) &&
+	    (raw_inode->i_links_count == 0) && (raw_inode->i_mode == 0)) {
+		ret = -ESTALE;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
 		    EXT4_INODE_SIZE(inode->i_sb)) {
-			EXT4_ERROR_INODE(inode, "bad extra_isize (%u != %u)",
-				EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize,
-				EXT4_INODE_SIZE(inode->i_sb));
+			ext4_error_inode(inode, function, line, 0,
+					 "iget: bad extra_isize %u "
+					 "(inode size %u)",
+					 ei->i_extra_isize,
+					 EXT4_INODE_SIZE(inode->i_sb));
 			ret = -EIO;
 			goto bad_inode;
 		}
@@ -4233,7 +4256,8 @@ struct inode *ext4_iget(struct super_blo
 	}
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
-		EXT4_ERROR_INODE(inode, "checksum invalid");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: checksum invalid");
 		ret = -EIO;
 		goto bad_inode;
 	}
@@ -4281,7 +4305,8 @@ struct inode *ext4_iget(struct super_blo
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size = ext4_isize(raw_inode);
 	if ((size = i_size_read(inode)) < 0) {
-		EXT4_ERROR_INODE(inode, "bad i_size value: %lld", size);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad i_size value: %lld", size);
 		ret = -EIO;
 		goto bad_inode;
 	}
@@ -4354,7 +4379,8 @@ struct inode *ext4_iget(struct super_blo
 	ret = 0;
 	if (ei->i_file_acl &&
 	    !ext4_data_block_valid(EXT4_SB(sb), ei->i_file_acl, 1)) {
-		EXT4_ERROR_INODE(inode, "bad extended attribute block %llu",
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad extended attribute block %llu",
 				 ei->i_file_acl);
 		ret = -EIO;
 		goto bad_inode;
@@ -4404,7 +4430,8 @@ struct inode *ext4_iget(struct super_blo
 		make_bad_inode(inode);
 	} else {
 		ret = -EIO;
-		EXT4_ERROR_INODE(inode, "bogus i_mode (%o)", inode->i_mode);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
 	brelse(iloc.bh);
@@ -4418,13 +4445,6 @@ bad_inode:
 	return ERR_PTR(ret);
 }
 
-struct inode *ext4_iget_normal(struct super_block *sb, unsigned long ino)
-{
-	if (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)
-		return ERR_PTR(-EIO);
-	return ext4_iget(sb, ino);
-}
-
 static int ext4_inode_blocks_set(handle_t *handle,
 				struct ext4_inode *raw_inode,
 				struct ext4_inode_info *ei)
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -127,7 +127,7 @@ static long swap_inode_boot_loader(struc
 	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO);
+	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(inode_bl))
 		return PTR_ERR(inode_bl);
 	ei_bl = EXT4_I(inode_bl);
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1439,7 +1439,7 @@ static struct dentry *ext4_lookup(struct
 					 dentry);
 			return ERR_PTR(-EIO);
 		}
-		inode = ext4_iget_normal(dir->i_sb, ino);
+		inode = ext4_iget(dir->i_sb, ino, EXT4_IGET_NORMAL);
 		if (inode == ERR_PTR(-ESTALE)) {
 			EXT4_ERROR_INODE(dir,
 					 "deleted inode referenced: %u",
@@ -1472,7 +1472,7 @@ struct dentry *ext4_get_parent(struct de
 		return ERR_PTR(-EIO);
 	}
 
-	return d_obtain_alias(ext4_iget_normal(child->d_inode->i_sb, ino));
+	return d_obtain_alias(ext4_iget(child->d_inode->i_sb, ino, EXT4_IGET_NORMAL));
 }
 
 /*
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1609,7 +1609,7 @@ int ext4_group_add(struct super_block *s
 				     "No reserved GDT blocks, can't resize");
 			return -EPERM;
 		}
-		inode = ext4_iget(sb, EXT4_RESIZE_INO);
+		inode = ext4_iget(sb, EXT4_RESIZE_INO, EXT4_IGET_SPECIAL);
 		if (IS_ERR(inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(inode);
@@ -1936,7 +1936,8 @@ retry:
 		}
 
 		if (!resize_inode)
-			resize_inode = ext4_iget(sb, EXT4_RESIZE_INO);
+			resize_inode = ext4_iget(sb, EXT4_RESIZE_INO,
+						 EXT4_IGET_SPECIAL);
 		if (IS_ERR(resize_inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(resize_inode);
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1013,20 +1013,11 @@ static struct inode *ext4_nfs_get_inode(
 {
 	struct inode *inode;
 
-	if (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)
-		return ERR_PTR(-ESTALE);
-	if (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
-		return ERR_PTR(-ESTALE);
-
-	/* iget isn't really right if the inode is currently unallocated!!
-	 *
-	 * ext4_read_inode will return a bad_inode if the inode had been
-	 * deleted, so we should be safe.
-	 *
+	/*
 	 * Currently we don't know the generation for parent directory, so
 	 * a generation of 0 means "accept any"
 	 */
-	inode = ext4_iget_normal(sb, ino);
+	inode = ext4_iget(sb, ino, EXT4_IGET_HANDLE);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (generation && inode->i_generation != generation) {
@@ -4221,7 +4212,7 @@ no_journal:
 	 * so we can safely mount the rest of the filesystem now.
 	 */
 
-	root = ext4_iget(sb, EXT4_ROOT_INO);
+	root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(root)) {
 		ext4_msg(sb, KERN_ERR, "get root inode failed");
 		ret = PTR_ERR(root);
@@ -4456,7 +4447,7 @@ static journal_t *ext4_get_journal(struc
 	 * things happen if we iget() an unused inode, as the subsequent
 	 * iput() will try to delete it. */
 
-	journal_inode = ext4_iget(sb, journal_inum);
+	journal_inode = ext4_iget(sb, journal_inum, EXT4_IGET_SPECIAL);
 	if (IS_ERR(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "no journal found");
 		return NULL;
@@ -5396,7 +5387,7 @@ static int ext4_quota_enable(struct supe
 	if (!qf_inums[type])
 		return -EPERM;
 
-	qf_inode = ext4_iget(sb, qf_inums[type]);
+	qf_inode = ext4_iget(sb, qf_inums[type], EXT4_IGET_SPECIAL);
 	if (IS_ERR(qf_inode)) {
 		ext4_error(sb, "Bad quota inode # %lu", qf_inums[type]);
 		return PTR_ERR(qf_inode);

