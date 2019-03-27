Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3AC20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfC0XqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfC0XqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:46:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9861E307EA83;
        Wed, 27 Mar 2019 23:46:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3EC35D9C5;
        Wed, 27 Mar 2019 23:46:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 46/68] mtd: Provide fs_context-aware mount_mtd()
 replacement
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:46:20 +0000
Message-ID: <155373037997.7602.10121636631236011522.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 27 Mar 2019 23:46:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a function, vfs_get_mtd_super(), to replace mount_mtd(), using an
fs_context struct to hold the parameters.  The mtd device pointer is cached
in the struct, along with a destructor pointer as the mtd core may be in a
module and, as such, unreachable by the core code that would release the
fs_context.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>
cc: Brian Norris <computersforpeace@gmail.com>
cc: Boris Brezillon <bbrezillon@kernel.org>
cc: Marek Vasut <marek.vasut@gmail.com>
cc: Richard Weinberger <richard@nod.at>
cc: linux-mtd@lists.infradead.org
---

 drivers/mtd/mtdcore.h      |    1 
 drivers/mtd/mtdsuper.c     |  192 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_context.h |    3 -
 include/linux/mtd/super.h  |    3 +
 4 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b31c868019ad..b5eefeabf310 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -5,6 +5,7 @@
  */
 
 extern struct mutex mtd_table_mutex;
+extern struct backing_dev_info *mtd_bdi;
 
 struct mtd_info *__mtd_next_device(int i);
 int __must_check add_mtd_device(struct mtd_info *mtd);
diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index d58a61c09304..cf165f7c8632 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -19,6 +19,196 @@
 #include <linux/slab.h>
 #include <linux/major.h>
 #include <linux/backing-dev.h>
+#include <linux/fs_context.h>
+#include "mtdcore.h"
+
+static void mtd_fc_destructor(struct fs_context *fc)
+{
+	if (fc->mtd)
+		put_mtd_device(fc->mtd);
+}
+
+/*
+ * compare superblocks to see if they're equivalent
+ * - they are if the underlying MTD device is the same
+ */
+static int mtd_test_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct mtd_info *mtd = fc->mtd;
+
+	if (sb->s_mtd == mtd) {
+		pr_debug("MTDSB: Match on device %d (\"%s\")\n",
+			 mtd->index, mtd->name);
+		return 1;
+	}
+
+	pr_debug("MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
+		 sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
+	return 0;
+}
+
+/*
+ * mark the superblock by the MTD device it is using
+ * - set the device number to be the correct MTD block device for pesuperstence
+ *   of NFS exports
+ */
+static int mtd_set_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct mtd_info *mtd = fc->mtd;
+
+	sb->s_mtd = mtd;
+	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+	sb->s_bdi = bdi_get(mtd_bdi);
+	fc->mtd = NULL;
+	return 0;
+}
+
+/*
+ * get a superblock on an MTD-backed filesystem
+ */
+static int mtd_get_sb(struct fs_context *fc,
+		      int (*fill_super)(struct super_block *,
+					struct fs_context *))
+{
+	struct super_block *sb;
+	struct mtd_info *mtd = fc->mtd;
+	int ret;
+
+	sb = sget_fc(fc, mtd_test_super, mtd_set_super);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (sb->s_root) {
+		/* new mountpoint for an already mounted superblock */
+		pr_debug("MTDSB: Device %d (\"%s\") is already mounted\n",
+			 mtd->index, mtd->name);
+		put_mtd_device(mtd);
+	} else {
+		/* fresh new superblock */
+		pr_debug("MTDSB: New superblock for device %d (\"%s\")\n",
+			 mtd->index, mtd->name);
+
+		ret = fill_super(sb, fc);
+		if (ret < 0)
+			goto error_sb;
+
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	BUG_ON(fc->root);
+	fc->root = dget(sb->s_root);
+	return 0;
+
+error_sb:
+	deactivate_locked_super(sb);
+	return ret;
+}
+
+/*
+ * get a superblock on an MTD-backed filesystem by MTD device number
+ */
+static int mtd_get_sb_by_nr(struct fs_context *fc, int mtdnr,
+			    int (*fill_super)(struct super_block *,
+					      struct fs_context *))
+{
+	struct mtd_info *mtd;
+
+	mtd = get_mtd_device(NULL, mtdnr);
+	if (IS_ERR(mtd)) {
+		errorf(fc, "MTDSB: Device #%u doesn't appear to exist\n", mtdnr);
+		return PTR_ERR(mtd);
+	}
+
+	fc->mtd = mtd;
+	fc->dev_destructor = mtd_fc_destructor;
+	return mtd_get_sb(fc, fill_super);
+}
+
+/**
+ * vfs_get_mtd_super - Get a superblock based on a single MTD device
+ * @fc: The filesystem context holding the parameters
+ * @fill_super: Helper to initialise a new superblock
+ */
+int vfs_get_mtd_super(struct fs_context *fc,
+		      int (*fill_super)(struct super_block *sb,
+					struct fs_context *fc))
+{
+#ifdef CONFIG_BLOCK
+	struct block_device *bdev;
+	int ret, major;
+#endif
+	int mtdnr;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	pr_debug("MTDSB: dev_name \"%s\"\n", fc->source);
+
+	/* the preferred way of mounting in future; especially when
+	 * CONFIG_BLOCK=n - we specify the underlying MTD device by number or
+	 * by name, so that we don't require block device support to be present
+	 * in the kernel.
+	 */
+	if (fc->source[0] == 'm' &&
+	    fc->source[1] == 't' &&
+	    fc->source[2] == 'd') {
+		if (fc->source[3] == ':') {
+			struct mtd_info *mtd;
+
+			/* mount by MTD device name */
+			pr_debug("MTDSB: mtd:%%s, name \"%s\"\n",
+				 fc->source + 4);
+
+			mtd = get_mtd_device_nm(fc->source + 4);
+			if (!IS_ERR(mtd)) {
+				fc->mtd = mtd;
+				fc->dev_destructor = mtd_fc_destructor;
+				return mtd_get_sb(fc, fill_super);
+			}
+
+			errorf(fc, "MTD: MTD device with name \"%s\" not found",
+			       fc->source + 4);
+
+		} else if (isdigit(fc->source[3])) {
+			/* mount by MTD device number name */
+			char *endptr;
+
+			mtdnr = simple_strtoul(fc->source + 3, &endptr, 0);
+			if (!*endptr) {
+				/* It was a valid number */
+				pr_debug("MTDSB: mtd%%d, mtdnr %d\n", mtdnr);
+				return mtd_get_sb_by_nr(fc, mtdnr, fill_super);
+			}
+		}
+	}
+
+#ifdef CONFIG_BLOCK
+	/* try the old way - the hack where we allowed users to mount
+	 * /dev/mtdblock$(n) but didn't actually _use_ the blockdev
+	 */
+	bdev = lookup_bdev(fc->source);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
+		errorf(fc, "MTD: Couldn't look up '%s': %d", fc->source, ret);
+		return ret;
+	}
+	pr_debug("MTDSB: lookup_bdev() returned 0\n");
+
+	major = MAJOR(bdev->bd_dev);
+	mtdnr = MINOR(bdev->bd_dev);
+	bdput(bdev);
+
+	if (major == MTD_BLOCK_MAJOR)
+		return mtd_get_sb_by_nr(fc, mtdnr, fill_super);
+
+#endif /* CONFIG_BLOCK */
+
+	if (!(fc->sb_flags & SB_SILENT))
+		errorf(fc, "MTD: Attempt to mount non-MTD device \"%s\"",
+		       fc->source);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(vfs_get_mtd_super);
 
 /*
  * compare superblocks to see if they're equivalent
@@ -39,8 +229,6 @@ static int get_sb_mtd_compare(struct super_block *sb, void *_mtd)
 	return 0;
 }
 
-extern struct backing_dev_info *mtd_bdi;
-
 /*
  * mark the superblock by the MTD device it is using
  * - set the device number to be the correct MTD block device for pesuperstence
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 70fdebf1dc85..7c7eefb35cc3 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -77,7 +77,8 @@ struct fs_context {
 	struct file_system_type	*fs_type;
 	void			*fs_private;	/* The filesystem's context */
 	union {
-		struct block_device *bdev;	/* The backing blockdev (if applicable) */
+		struct block_device	*bdev;	/* The backing blockdev (if applicable) */
+		struct mtd_info		*mtd;	/* The backing mtd (if applicable) */
 	};
 	struct dentry		*root;		/* The root and superblock */
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
diff --git a/include/linux/mtd/super.h b/include/linux/mtd/super.h
index f456230f9330..7ebd69e5c640 100644
--- a/include/linux/mtd/super.h
+++ b/include/linux/mtd/super.h
@@ -18,6 +18,9 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 
+extern int vfs_get_mtd_super(struct fs_context *fc,
+			     int (*fill_super)(struct super_block *sb,
+					       struct fs_context *fc));
 extern struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
 		      const char *dev_name, void *data,
 		      int (*fill_super)(struct super_block *, void *, int));

