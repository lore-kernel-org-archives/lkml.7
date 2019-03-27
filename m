Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3610C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750B42087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfC0LXm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfC0LXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA61730642A8;
        Wed, 27 Mar 2019 11:23:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D61883B06;
        Wed, 27 Mar 2019 11:23:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ad854f75-6b42-7d8a-2cc6-cbcf528c8458@redhat.com>
References: <ad854f75-6b42-7d8a-2cc6-cbcf528c8458@redhat.com> <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk> <155301261082.7556.2558480789011010142.stgit@warthog.procyon.org.uk>
To:     Andrew Price <anprice@redhat.com>
Cc:     dhowells@redhat.com, miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] vfs: Create fs_context-aware mount_bdev() replacement
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14986.1553685803.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 27 Mar 2019 11:23:23 +0000
Message-ID: <14987.1553685803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 11:23:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Price <anprice@redhat.com> wrote:

> > +		up_write(&s->s_umount);
> > +		blkdev_put(bdev, fc->bdev_mode);
> > +		down_write(&s->s_umount);
> 
> fc->bdev should be NULLed here (or, on the way out of sget_fc() might be more
> appropriate) otherwise we get a double-blkdev_put() leading to NULL pointer
> derefs later. This happens when I mount a device twice and then unmount them,
> or mount it 3 times.

How about the attached changes?  Note that they conflict a bit with the mtd
changes from where I took the destructor piece.

David
---
commit 161602f963ae5a05bdb834461f7a4896286fbde0
Author: David Howells <dhowells@redhat.com>
Date:   Wed Mar 27 11:12:57 2019 +0000

    bdev handling fix

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 9e22fe6aafe7..fc8fda4b9fe9 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -425,10 +425,8 @@ void put_fs_context(struct fs_context *fc)
 
 	if (fc->need_free && fc->ops && fc->ops->free)
 		fc->ops->free(fc);
-#ifdef CONFIG_BLOCK
-	if (fc->bdev)
-		blkdev_put(fc->bdev, fc->bdev_mode);
-#endif
+	if (fc->dev_destructor)
+		fc->dev_destructor(fc);
 
 	security_free_mnt_opts(&fc->security);
 	put_net(fc->net_ns);
diff --git a/fs/super.c b/fs/super.c
index 85851adb0f19..e9e678d2c37c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1211,8 +1211,17 @@ int vfs_get_super(struct fs_context *fc,
 EXPORT_SYMBOL(vfs_get_super);
 
 #ifdef CONFIG_BLOCK
+static void fc_bdev_destructor(struct fs_context *fc)
+{
+	if (fc->bdev) {
+		blkdev_put(fc->bdev, fc->bdev_mode);
+		fc->bdev = NULL;
+	}
+}
+
 static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
+	s->s_mode = fc->bdev_mode;
 	s->s_bdev = fc->bdev;
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
@@ -1252,6 +1261,9 @@ int vfs_get_block_super(struct fs_context *fc,
 		return PTR_ERR(bdev);
 	}
 
+	fc->dev_destructor = fc_bdev_destructor;
+	fc->bdev = bdev;
+
 	/* Once the superblock is inserted into the list by sget_fc(), s_umount
 	 * will protect the lockfs code from trying to start a snapshot while
 	 * we are mounting
@@ -1260,18 +1272,14 @@ int vfs_get_block_super(struct fs_context *fc,
 	if (bdev->bd_fsfreeze_count > 0) {
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		error = -EBUSY;
-		goto error_bdev;
+		return -EBUSY;
 	}
 
-	fc->bdev = bdev;
 	fc->sb_flags |= SB_NOSEC;
 	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
-	if (IS_ERR(s)) {
-		error = PTR_ERR(s);
-		goto error_bdev;
-	}
+	if (IS_ERR(s))
+		return PTR_ERR(s);
 
 	if (s->s_root) {
 		/* Don't summarily change the RO/RW state. */
@@ -1281,16 +1289,10 @@ int vfs_get_block_super(struct fs_context *fc,
 			goto error_sb;
 		}
 
-		/* s_umount nests inside bd_mutex during __invalidate_device().
-		 * blkdev_put() acquires bd_mutex and can't be called under
-		 * s_umount.  Drop s_umount temporarily.  This is safe as we're
-		 * holding an active reference.
+		/* Leave fc->bdev to fc_bdev_destructor() to clean up to avoid
+		 * locking conflicts.
 		 */
-		up_write(&s->s_umount);
-		blkdev_put(bdev, fc->bdev_mode);
-		down_write(&s->s_umount);
 	} else {
-		s->s_mode = fc->bdev_mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		sb_set_blocksize(s, block_size(bdev));
 		error = fill_super(s, fc);
@@ -1307,11 +1309,7 @@ int vfs_get_block_super(struct fs_context *fc,
 
 error_sb:
 	deactivate_locked_super(s);
-error_bdev:
-	if (fc->bdev) {
-		blkdev_put(fc->bdev, fc->bdev_mode);
-		fc->bdev = NULL;
-	}
+	/* Leave fc->bdev to fc_bdev_destructor() to clean up */
 	return error;
 }
 EXPORT_SYMBOL(vfs_get_block_super);
@@ -1521,8 +1519,13 @@ int vfs_get_tree(struct fs_context *fc)
 	 * on the superblock.
 	 */
 	error = fc->ops->get_tree(fc);
-	if (error < 0)
+	if (error < 0) {
+		if (fc->dev_destructor) {
+			fc->dev_destructor(fc);
+			fc->dev_destructor = NULL;
+		}
 		return error;
+	}
 
 	if (!fc->root) {
 		pr_err("Filesystem %s get_tree() didn't set fc->root\n",
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index cb49b92f02af..9af788a3ef8e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -76,7 +76,9 @@ struct fs_context {
 	const struct fs_context_operations *ops;
 	struct file_system_type	*fs_type;
 	void			*fs_private;	/* The filesystem's context */
-	struct block_device	*bdev;		/* The backing blockdev (if applicable) */
+	union {
+		struct block_device *bdev;	/* The backing blockdev (if applicable) */
+	};
 	struct dentry		*root;		/* The root and superblock */
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
@@ -93,6 +95,7 @@ struct fs_context {
 	enum fs_context_purpose	purpose:8;
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
+	void (*dev_destructor)(struct fs_context *fc); /* For block or mtd */
 };
 
 struct fs_context_operations {
