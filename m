Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640031;
	bh=Qji1BoCGTTAPDqJKTuEXCmG0trL/XGWNdGLGCsvx7QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KQ/snQOdOBWqvXUJvUTp+Dy+HKcSwokgrE8LRbswXS4FS0fXaZDDejoNjwsf4B7+M
	 CbbSrilf+wESLYdcFTIThABB9Jfzk6YL3/iHzlZ1C2n5Vlxn8SITY6wC4wS15m/HQ9
	 pzcY3FgfkFAX73Qn31U/WjDwVBmbRYX20ALzHOsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391991AbfEWTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391201AbfEWT2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:28:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D2720879;
        Thu, 23 May 2019 19:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639718;
        bh=Qji1BoCGTTAPDqJKTuEXCmG0trL/XGWNdGLGCsvx7QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWY4QrG55wR3GvTyN3a4jHaFvougXfsxsPhy7oLt9RdofqqHHeA8cNvUcjFqt0Kbx
         2Lb311Wn78Wf6A2FLuhKZK02vO5nzRiN9Df8vm5MtAC5nI+uaZ6jh1SXw6Cv+L6EpB
         zrQMEYt1o+CNSip6KDE9mOpdsnNP9lQ/RJa9oNXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.1 069/122] fsnotify: fix unlink performance regression
Date:   Thu, 23 May 2019 21:06:31 +0200
Message-Id: <20190523181713.866884475@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 4d8e7055a4058ee191296699803c5090e14f0dff upstream.

__fsnotify_parent() has an optimization in place to avoid unneeded
take_dentry_name_snapshot().  When fsnotify_nameremove() was changed
not to call __fsnotify_parent(), we left out the optimization.
Kernel test robot reported a 5% performance regression in concurrent
unlink() workload.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Link: https://lore.kernel.org/lkml/20190505062153.GG29809@shao2-debian/
Link: https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
Fixes: 5f02a8776384 ("fsnotify: annotate directory entry modification events")
CC: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/fsnotify.c             |   41 +++++++++++++++++++++++++++++++++++++++
 include/linux/fsnotify.h         |   33 -------------------------------
 include/linux/fsnotify_backend.h |    4 +++
 3 files changed, 45 insertions(+), 33 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -108,6 +108,47 @@ void fsnotify_sb_delete(struct super_blo
 }
 
 /*
+ * fsnotify_nameremove - a filename was removed from a directory
+ *
+ * This is mostly called under parent vfs inode lock so name and
+ * dentry->d_parent should be stable. However there are some corner cases where
+ * inode lock is not held. So to be on the safe side and be reselient to future
+ * callers and out of tree users of d_delete(), we do not assume that d_parent
+ * and d_name are stable and we use dget_parent() and
+ * take_dentry_name_snapshot() to grab stable references.
+ */
+void fsnotify_nameremove(struct dentry *dentry, int isdir)
+{
+	struct dentry *parent;
+	struct name_snapshot name;
+	__u32 mask = FS_DELETE;
+
+	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
+	if (IS_ROOT(dentry))
+		return;
+
+	if (isdir)
+		mask |= FS_ISDIR;
+
+	parent = dget_parent(dentry);
+	/* Avoid unneeded take_dentry_name_snapshot() */
+	if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
+	    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
+		goto out_dput;
+
+	take_dentry_name_snapshot(&name, dentry);
+
+	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
+		 name.name, 0);
+
+	release_dentry_name_snapshot(&name);
+
+out_dput:
+	dput(parent);
+}
+EXPORT_SYMBOL(fsnotify_nameremove);
+
+/*
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
  * on a child we run all of our children and set a dentry flag saying that the
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -152,39 +152,6 @@ static inline void fsnotify_vfsmount_del
 }
 
 /*
- * fsnotify_nameremove - a filename was removed from a directory
- *
- * This is mostly called under parent vfs inode lock so name and
- * dentry->d_parent should be stable. However there are some corner cases where
- * inode lock is not held. So to be on the safe side and be reselient to future
- * callers and out of tree users of d_delete(), we do not assume that d_parent
- * and d_name are stable and we use dget_parent() and
- * take_dentry_name_snapshot() to grab stable references.
- */
-static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
-{
-	struct dentry *parent;
-	struct name_snapshot name;
-	__u32 mask = FS_DELETE;
-
-	/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
-	if (IS_ROOT(dentry))
-		return;
-
-	if (isdir)
-		mask |= FS_ISDIR;
-
-	parent = dget_parent(dentry);
-	take_dentry_name_snapshot(&name, dentry);
-
-	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 name.name, 0);
-
-	release_dentry_name_snapshot(&name);
-	dput(parent);
-}
-
-/*
  * fsnotify_inoderemove - an inode is going away
  */
 static inline void fsnotify_inoderemove(struct inode *inode)
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -355,6 +355,7 @@ extern int __fsnotify_parent(const struc
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
+extern void fsnotify_nameremove(struct dentry *dentry, int isdir);
 extern u32 fsnotify_get_cookie(void);
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
@@ -524,6 +525,9 @@ static inline void __fsnotify_vfsmount_d
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
+static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
+{}
+
 static inline void fsnotify_update_flags(struct dentry *dentry)
 {}
 


