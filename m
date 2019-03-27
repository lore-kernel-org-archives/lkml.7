Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44871C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3F62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfC0Xq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbfC0Xqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF6317F7CC;
        Wed, 27 Mar 2019 23:46:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB9B6013C;
        Wed, 27 Mar 2019 23:46:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 50/68] mtd: Kill mount_mtd()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:46:51 +0000
Message-ID: <155373041192.7602.911634044154993052.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 27 Mar 2019 23:46:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill mount_mtd() as it has now been replaced by vfs_get_mtd_super() in the
new mount API and nothing now uses it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>
cc: Brian Norris <computersforpeace@gmail.com>
cc: Boris Brezillon <bbrezillon@kernel.org>
cc: Marek Vasut <marek.vasut@gmail.com>
cc: Richard Weinberger <richard@nod.at>
cc: linux-mtd@lists.infradead.org
---

 drivers/mtd/mtdsuper.c    |  189 ---------------------------------------------
 include/linux/mtd/super.h |    3 -
 2 files changed, 192 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index cf165f7c8632..428beb766166 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -210,195 +210,6 @@ int vfs_get_mtd_super(struct fs_context *fc,
 }
 EXPORT_SYMBOL_GPL(vfs_get_mtd_super);
 
-/*
- * compare superblocks to see if they're equivalent
- * - they are if the underlying MTD device is the same
- */
-static int get_sb_mtd_compare(struct super_block *sb, void *_mtd)
-{
-	struct mtd_info *mtd = _mtd;
-
-	if (sb->s_mtd == mtd) {
-		pr_debug("MTDSB: Match on device %d (\"%s\")\n",
-		      mtd->index, mtd->name);
-		return 1;
-	}
-
-	pr_debug("MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
-	      sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
-	return 0;
-}
-
-/*
- * mark the superblock by the MTD device it is using
- * - set the device number to be the correct MTD block device for pesuperstence
- *   of NFS exports
- */
-static int get_sb_mtd_set(struct super_block *sb, void *_mtd)
-{
-	struct mtd_info *mtd = _mtd;
-
-	sb->s_mtd = mtd;
-	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
-	sb->s_bdi = bdi_get(mtd_bdi);
-
-	return 0;
-}
-
-/*
- * get a superblock on an MTD-backed filesystem
- */
-static struct dentry *mount_mtd_aux(struct file_system_type *fs_type, int flags,
-			  const char *dev_name, void *data,
-			  struct mtd_info *mtd,
-			  int (*fill_super)(struct super_block *, void *, int))
-{
-	struct super_block *sb;
-	int ret;
-
-	sb = sget(fs_type, get_sb_mtd_compare, get_sb_mtd_set, flags, mtd);
-	if (IS_ERR(sb))
-		goto out_error;
-
-	if (sb->s_root)
-		goto already_mounted;
-
-	/* fresh new superblock */
-	pr_debug("MTDSB: New superblock for device %d (\"%s\")\n",
-	      mtd->index, mtd->name);
-
-	ret = fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-	if (ret < 0) {
-		deactivate_locked_super(sb);
-		return ERR_PTR(ret);
-	}
-
-	/* go */
-	sb->s_flags |= SB_ACTIVE;
-	return dget(sb->s_root);
-
-	/* new mountpoint for an already mounted superblock */
-already_mounted:
-	pr_debug("MTDSB: Device %d (\"%s\") is already mounted\n",
-	      mtd->index, mtd->name);
-	put_mtd_device(mtd);
-	return dget(sb->s_root);
-
-out_error:
-	put_mtd_device(mtd);
-	return ERR_CAST(sb);
-}
-
-/*
- * get a superblock on an MTD-backed filesystem by MTD device number
- */
-static struct dentry *mount_mtd_nr(struct file_system_type *fs_type, int flags,
-			 const char *dev_name, void *data, int mtdnr,
-			 int (*fill_super)(struct super_block *, void *, int))
-{
-	struct mtd_info *mtd;
-
-	mtd = get_mtd_device(NULL, mtdnr);
-	if (IS_ERR(mtd)) {
-		pr_debug("MTDSB: Device #%u doesn't appear to exist\n", mtdnr);
-		return ERR_CAST(mtd);
-	}
-
-	return mount_mtd_aux(fs_type, flags, dev_name, data, mtd, fill_super);
-}
-
-/*
- * set up an MTD-based superblock
- */
-struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
-	       const char *dev_name, void *data,
-	       int (*fill_super)(struct super_block *, void *, int))
-{
-#ifdef CONFIG_BLOCK
-	struct block_device *bdev;
-	int ret, major;
-#endif
-	int mtdnr;
-
-	if (!dev_name)
-		return ERR_PTR(-EINVAL);
-
-	pr_debug("MTDSB: dev_name \"%s\"\n", dev_name);
-
-	/* the preferred way of mounting in future; especially when
-	 * CONFIG_BLOCK=n - we specify the underlying MTD device by number or
-	 * by name, so that we don't require block device support to be present
-	 * in the kernel. */
-	if (dev_name[0] == 'm' && dev_name[1] == 't' && dev_name[2] == 'd') {
-		if (dev_name[3] == ':') {
-			struct mtd_info *mtd;
-
-			/* mount by MTD device name */
-			pr_debug("MTDSB: mtd:%%s, name \"%s\"\n",
-			      dev_name + 4);
-
-			mtd = get_mtd_device_nm(dev_name + 4);
-			if (!IS_ERR(mtd))
-				return mount_mtd_aux(
-					fs_type, flags,
-					dev_name, data, mtd,
-					fill_super);
-
-			printk(KERN_NOTICE "MTD:"
-			       " MTD device with name \"%s\" not found.\n",
-			       dev_name + 4);
-
-		} else if (isdigit(dev_name[3])) {
-			/* mount by MTD device number name */
-			char *endptr;
-
-			mtdnr = simple_strtoul(dev_name + 3, &endptr, 0);
-			if (!*endptr) {
-				/* It was a valid number */
-				pr_debug("MTDSB: mtd%%d, mtdnr %d\n",
-				      mtdnr);
-				return mount_mtd_nr(fs_type, flags,
-						     dev_name, data,
-						     mtdnr, fill_super);
-			}
-		}
-	}
-
-#ifdef CONFIG_BLOCK
-	/* try the old way - the hack where we allowed users to mount
-	 * /dev/mtdblock$(n) but didn't actually _use_ the blockdev
-	 */
-	bdev = lookup_bdev(dev_name);
-	if (IS_ERR(bdev)) {
-		ret = PTR_ERR(bdev);
-		pr_debug("MTDSB: lookup_bdev() returned %d\n", ret);
-		return ERR_PTR(ret);
-	}
-	pr_debug("MTDSB: lookup_bdev() returned 0\n");
-
-	ret = -EINVAL;
-
-	major = MAJOR(bdev->bd_dev);
-	mtdnr = MINOR(bdev->bd_dev);
-	bdput(bdev);
-
-	if (major != MTD_BLOCK_MAJOR)
-		goto not_an_MTD_device;
-
-	return mount_mtd_nr(fs_type, flags, dev_name, data, mtdnr, fill_super);
-
-not_an_MTD_device:
-#endif /* CONFIG_BLOCK */
-
-	if (!(flags & SB_SILENT))
-		printk(KERN_NOTICE
-		       "MTD: Attempt to mount non-MTD device \"%s\"\n",
-		       dev_name);
-	return ERR_PTR(-EINVAL);
-}
-
-EXPORT_SYMBOL_GPL(mount_mtd);
-
 /*
  * destroy an MTD-based superblock
  */
diff --git a/include/linux/mtd/super.h b/include/linux/mtd/super.h
index 7ebd69e5c640..c8bfaf0b8fe7 100644
--- a/include/linux/mtd/super.h
+++ b/include/linux/mtd/super.h
@@ -21,9 +21,6 @@
 extern int vfs_get_mtd_super(struct fs_context *fc,
 			     int (*fill_super)(struct super_block *sb,
 					       struct fs_context *fc));
-extern struct dentry *mount_mtd(struct file_system_type *fs_type, int flags,
-		      const char *dev_name, void *data,
-		      int (*fill_super)(struct super_block *, void *, int));
 extern void kill_mtd_super(struct super_block *sb);
 
 

