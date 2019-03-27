Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfC0XsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0XsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CFD42D7F3;
        Wed, 27 Mar 2019 23:48:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78A1C19C5A;
        Wed, 27 Mar 2019 23:48:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 61/68] vfs: Kill mount_single()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:19 +0000
Message-ID: <155373049974.7602.11782552287499131710.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Mar 2019 23:48:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill mount_single() as nothing now uses it.  It has been replaced by
vfs_get_super() keyed with vfs_get_single_super or
vfs_get_single_reconf_super.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/vfs.txt |    4 +--
 fs/super.c                        |   55 -------------------------------------
 include/linux/fs.h                |    3 --
 3 files changed, 2 insertions(+), 60 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 761c6fd24a53..6ef83fdfffdc 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -181,8 +181,8 @@ and provides a fill_super() callback instead. The generic variants are:
 
   mount_nodev: mount a filesystem that is not backed by a device
 
-  mount_single: mount a filesystem which shares the instance between
-  	all mounts
+  vfs_get_super: mount a filesystem with one of a number of superblock
+		 sharing options.
 
 A fill_super() callback implementation has the following arguments:
 
diff --git a/fs/super.c b/fs/super.c
index 60c9caeae3c7..b94c50288636 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1449,61 +1449,6 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_nodev);
 
-static int reconfigure_single(struct super_block *s,
-			      int flags, void *data)
-{
-	struct fs_context *fc;
-	int ret;
-
-	/* The caller really need to be passing fc down into mount_single(),
-	 * then a chunk of this can be removed.  [Bollocks -- AV]
-	 * Better yet, reconfiguration shouldn't happen, but rather the second
-	 * mount should be rejected if the parameters are not compatible.
-	 */
-	fc = fs_context_for_reconfigure(s->s_root, flags, MS_RMT_MASK);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	ret = parse_monolithic_mount_data(fc, data);
-	if (ret < 0)
-		goto out;
-
-	ret = reconfigure_super(fc);
-out:
-	put_fs_context(fc);
-	return ret;
-}
-
-static int compare_single(struct super_block *s, void *p)
-{
-	return 1;
-}
-
-struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	struct super_block *s;
-	int error;
-
-	s = sget(fs_type, compare_single, set_anon_super, flags, NULL);
-	if (IS_ERR(s))
-		return ERR_CAST(s);
-	if (!s->s_root) {
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
-		if (!error)
-			s->s_flags |= SB_ACTIVE;
-	} else {
-		error = reconfigure_single(s, flags, data);
-	}
-	if (unlikely(error)) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-	return dget(s->s_root);
-}
-EXPORT_SYMBOL(mount_single);
-
 /**
  * vfs_get_tree - Get the mountable root
  * @fc: The superblock configuration context.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 646f4ccaeee9..5ca14600dcf6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2206,9 +2206,6 @@ static inline struct dentry *mount_bdev(struct file_system_type *fs_type,
 	return ERR_PTR(-ENODEV);
 }
 #endif
-extern struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));

