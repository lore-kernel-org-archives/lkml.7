Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A4DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB212075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfC0XrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbfC0XrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E65A307B497;
        Wed, 27 Mar 2019 23:47:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDB855C582;
        Wed, 27 Mar 2019 23:47:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 51/68] vfs: Convert squashfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        squashfs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:47:00 +0000
Message-ID: <155373041994.7602.15748226547805104210.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Mar 2019 23:47:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the squashfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Phillip Lougher <phillip@squashfs.org.uk>
cc: squashfs-devel@lists.sourceforge.net
---

 fs/squashfs/super.c |  100 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 40e657386fa5..672011725eb2 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -30,6 +30,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -49,26 +50,27 @@
 static struct file_system_type squashfs_fs_type;
 static const struct super_operations squashfs_super_ops;
 
-static const struct squashfs_decompressor *supported_squashfs_filesystem(short
-	major, short minor, short id)
+static const struct squashfs_decompressor *supported_squashfs_filesystem(
+	struct fs_context *fc,
+	short major, short minor, short id)
 {
 	const struct squashfs_decompressor *decompressor;
 
 	if (major < SQUASHFS_MAJOR) {
-		ERROR("Major/Minor mismatch, older Squashfs %d.%d "
-			"filesystems are unsupported\n", major, minor);
+		errorf(fc, "Major/Minor mismatch, older Squashfs %d.%d "
+		       "filesystems are unsupported", major, minor);
 		return NULL;
 	} else if (major > SQUASHFS_MAJOR || minor > SQUASHFS_MINOR) {
-		ERROR("Major/Minor mismatch, trying to mount newer "
-			"%d.%d filesystem\n", major, minor);
-		ERROR("Please update your kernel\n");
+		errorf(fc, "Major/Minor mismatch, trying to mount newer "
+		       "%d.%d filesystem", major, minor);
+		errorf(fc, "Please update your kernel");
 		return NULL;
 	}
 
 	decompressor = squashfs_lookup_decompressor(id);
 	if (!decompressor->supported) {
-		ERROR("Filesystem uses \"%s\" compression. This is not "
-			"supported\n", decompressor->name);
+		errorf(fc, "Filesystem uses \"%s\" compression. This is not supported",
+		       decompressor->name);
 		return NULL;
 	}
 
@@ -76,7 +78,7 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(short
 }
 
 
-static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
+static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct squashfs_sb_info *msblk;
 	struct squashfs_super_block *sblk = NULL;
@@ -111,7 +113,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	sblk = squashfs_read_table(sb, SQUASHFS_START, sizeof(*sblk));
 
 	if (IS_ERR(sblk)) {
-		ERROR("unable to read squashfs_super_block\n");
+		errorf(fc, "unable to read squashfs_super_block");
 		err = PTR_ERR(sblk);
 		sblk = NULL;
 		goto failed_mount;
@@ -122,14 +124,15 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Check it is a SQUASHFS superblock */
 	sb->s_magic = le32_to_cpu(sblk->s_magic);
 	if (sb->s_magic != SQUASHFS_MAGIC) {
-		if (!silent)
-			ERROR("Can't find a SQUASHFS superblock on %pg\n",
-						sb->s_bdev);
+		if (!(fc->sb_flags & SB_SILENT))
+			errorf(fc, "Can't find a SQUASHFS superblock on %pg",
+			       sb->s_bdev);
 		goto failed_mount;
 	}
 
 	/* Check the MAJOR & MINOR versions and lookup compression type */
 	msblk->decompressor = supported_squashfs_filesystem(
+			fc,
 			le16_to_cpu(sblk->s_major),
 			le16_to_cpu(sblk->s_minor),
 			le16_to_cpu(sblk->compression));
@@ -146,15 +149,15 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Check block size for sanity */
 	msblk->block_size = le32_to_cpu(sblk->block_size);
 	if (msblk->block_size > SQUASHFS_FILE_MAX_SIZE)
-		goto failed_mount;
+		goto insanity;
 
 	/*
 	 * Check the system page size is not larger than the filesystem
 	 * block size (by default 128K).  This is currently not supported.
 	 */
 	if (PAGE_SIZE > msblk->block_size) {
-		ERROR("Page size > filesystem block size (%d).  This is "
-			"currently not supported!\n", msblk->block_size);
+		errorf(fc, "Page size > filesystem block size (%d).  This is "
+		       "currently not supported!", msblk->block_size);
 		goto failed_mount;
 	}
 
@@ -165,12 +168,12 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* Check that block_size and block_log match */
 	if (msblk->block_size != (1 << msblk->block_log))
-		goto failed_mount;
+		goto insanity;
 
 	/* Check the root inode for sanity */
 	root_inode = le64_to_cpu(sblk->root_inode);
 	if (SQUASHFS_INODE_OFFSET(root_inode) > SQUASHFS_METADATA_SIZE)
-		goto failed_mount;
+		goto insanity;
 
 	msblk->inode_table = le64_to_cpu(sblk->inode_table_start);
 	msblk->directory_table = le64_to_cpu(sblk->directory_table_start);
@@ -210,7 +213,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	msblk->read_page = squashfs_cache_init("data",
 		squashfs_max_decompressors(), msblk->block_size);
 	if (msblk->read_page == NULL) {
-		ERROR("Failed to allocate read_page block\n");
+		errorf(fc, "Failed to allocate read_page block");
 		goto failed_mount;
 	}
 
@@ -218,7 +221,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (IS_ERR(msblk->stream)) {
 		err = PTR_ERR(msblk->stream);
 		msblk->stream = NULL;
-		goto failed_mount;
+		goto insanity;
 	}
 
 	/* Handle xattrs */
@@ -233,7 +236,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	msblk->xattr_id_table = squashfs_read_xattr_id_table(sb,
 		xattr_id_table_start, &msblk->xattr_table, &msblk->xattr_ids);
 	if (IS_ERR(msblk->xattr_id_table)) {
-		ERROR("unable to read xattr id index table\n");
+		errorf(fc, "unable to read xattr id index table");
 		err = PTR_ERR(msblk->xattr_id_table);
 		msblk->xattr_id_table = NULL;
 		if (err != -ENOTSUPP)
@@ -247,7 +250,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 		le64_to_cpu(sblk->id_table_start), next_table,
 		le16_to_cpu(sblk->no_ids));
 	if (IS_ERR(msblk->id_table)) {
-		ERROR("unable to read id index table\n");
+		errorf(fc, "unable to read id index table");
 		err = PTR_ERR(msblk->id_table);
 		msblk->id_table = NULL;
 		goto failed_mount;
@@ -263,7 +266,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	msblk->inode_lookup_table = squashfs_read_inode_lookup_table(sb,
 		lookup_table_start, next_table, msblk->inodes);
 	if (IS_ERR(msblk->inode_lookup_table)) {
-		ERROR("unable to read inode lookup table\n");
+		errorf(fc, "unable to read inode lookup table");
 		err = PTR_ERR(msblk->inode_lookup_table);
 		msblk->inode_lookup_table = NULL;
 		goto failed_mount;
@@ -288,7 +291,7 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	msblk->fragment_index = squashfs_read_fragment_index_table(sb,
 		le64_to_cpu(sblk->fragment_table_start), next_table, fragments);
 	if (IS_ERR(msblk->fragment_index)) {
-		ERROR("unable to read fragment index table\n");
+		errorf(fc, "unable to read fragment index table");
 		err = PTR_ERR(msblk->fragment_index);
 		msblk->fragment_index = NULL;
 		goto failed_mount;
@@ -299,13 +302,13 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Sanity check directory_table */
 	if (msblk->directory_table > next_table) {
 		err = -EINVAL;
-		goto failed_mount;
+		goto insanity;
 	}
 
 	/* Sanity check inode_table */
 	if (msblk->inode_table >= msblk->directory_table) {
 		err = -EINVAL;
-		goto failed_mount;
+		goto insanity;
 	}
 
 	/* allocate root */
@@ -334,6 +337,8 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	kfree(sblk);
 	return 0;
 
+insanity:
+	errorf(fc, "squashfs image failed sanity check");
 failed_mount:
 	squashfs_cache_delete(msblk->block_cache);
 	squashfs_cache_delete(msblk->fragment_cache);
@@ -349,6 +354,28 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
+static int squashfs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_block_super(fc, squashfs_fill_super);
+}
+
+static int squashfs_reconfigure(struct fs_context *fc)
+{
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
+	return 0;
+}
+
+static const struct fs_context_operations squashfs_context_ops = {
+	.get_tree	= squashfs_get_tree,
+	.reconfigure	= squashfs_reconfigure,
+};
+
+static int squashfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &squashfs_context_ops;
+	return 0;
+}
 
 static int squashfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
@@ -371,14 +398,6 @@ static int squashfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 
-static int squashfs_remount(struct super_block *sb, int *flags, char *data)
-{
-	sync_filesystem(sb);
-	*flags |= SB_RDONLY;
-	return 0;
-}
-
-
 static void squashfs_put_super(struct super_block *sb)
 {
 	if (sb->s_fs_info) {
@@ -397,14 +416,6 @@ static void squashfs_put_super(struct super_block *sb)
 	}
 }
 
-
-static struct dentry *squashfs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
-{
-	return mount_bdev(fs_type, flags, dev_name, data, squashfs_fill_super);
-}
-
-
 static struct kmem_cache *squashfs_inode_cachep;
 
 
@@ -488,7 +499,7 @@ static void squashfs_destroy_inode(struct inode *inode)
 static struct file_system_type squashfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "squashfs",
-	.mount = squashfs_mount,
+	.init_fs_context = squashfs_init_fs_context,
 	.kill_sb = kill_block_super,
 	.fs_flags = FS_REQUIRES_DEV
 };
@@ -499,7 +510,6 @@ static const struct super_operations squashfs_super_ops = {
 	.destroy_inode = squashfs_destroy_inode,
 	.statfs = squashfs_statfs,
 	.put_super = squashfs_put_super,
-	.remount_fs = squashfs_remount
 };
 
 module_init(init_squashfs_fs);

