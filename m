Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7452DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303345;
	bh=Tmqzy32XGQfb99U/hUBF1rbLUPylqVacMlS2Hrby3j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qx2+YXElYIs/rRQc4Pa73sxsb6yjBm8QcVEvrjec9hz7yochWuEImhLQAZM7csnnK
	 H16dL5W4U4HQahgH4kaNkDzc62Hv8lwd8sUsdBC+l9XBYUn8t4OWA5M6RThNmeqJs7
	 x1w0ajWZx7kgqwktTKuVv4x4u6Pwk3qEydZnaEag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfDZS26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfDZS24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:56 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B1920B7C;
        Fri, 26 Apr 2019 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303335;
        bh=Tmqzy32XGQfb99U/hUBF1rbLUPylqVacMlS2Hrby3j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WORJQH/P5NuYNOEARycZEMFB2PNYuFM/fkEPqczwA2glTHwA6o2J/VEHRLX/PEOIr
         XjBtBkMoanEhgfYC3+yliQE1RiOIBGYGCkkzPwmYaXYzAtf0zBUbkxbyBEGzQ3Y4tX
         FUIMitHRvjtJOd4bktPvQ4/aUmVB9V/ORdz9FtKE=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 3/5] fsnotify: have fsnotify() take a qstr instead of a string
Date:   Fri, 26 Apr 2019 14:28:45 -0400
Message-Id: <20190426182847.25088-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This means that kernfs_notify_workfn has to grow a strlen as well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/kernfs/file.c                 |  6 ++++--
 fs/notify/fsnotify.c             |  8 ++++----
 include/linux/fsnotify.h         | 10 +++++-----
 include/linux/fsnotify_backend.h |  4 ++--
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index ae948aaa4c53..a43283c515f4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -885,6 +885,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
 		struct inode *inode;
+		const struct qstr name = { .name = kn->name,
+					   .len  = strlen(kn->name) };
 
 		/*
 		 * We want fsnotify_modify() on @kn but as the
@@ -903,7 +905,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 			p_inode = ilookup(info->sb, parent->id.ino);
 			if (p_inode) {
 				fsnotify(p_inode, FS_MODIFY | FS_EVENT_ON_CHILD,
-					 inode, FSNOTIFY_EVENT_INODE, kn->name, 0);
+					 inode, FSNOTIFY_EVENT_INODE, &name, 0);
 				iput(p_inode);
 			}
 
@@ -911,7 +913,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		}
 
 		fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
-			 kn->name, 0);
+			 &name, 0);
 		iput(inode);
 	}
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index fb22f76329ae..9cbb5ae11d2f 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -179,10 +179,10 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 		take_dentry_name_snapshot(&name, dentry);
 		if (path)
 			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
-				       name.name.name, 0);
+				       &name.name, 0);
 		else
 			ret = fsnotify(p_inode, mask, dentry->d_inode, FSNOTIFY_EVENT_INODE,
-				       name.name.name, 0);
+				       &name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
@@ -325,7 +325,7 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
  * notification event in whatever means they feel necessary.
  */
 int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-	     const unsigned char *file_name, u32 cookie)
+	     const struct qstr *file_name, u32 cookie)
 {
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb = to_tell->i_sb;
@@ -379,7 +379,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	 */
 	while (fsnotify_iter_select_report_types(&iter_info)) {
 		ret = send_to_group(to_tell, mask, data, data_is, cookie,
-				    file_name, &iter_info);
+				    file_name->name, &iter_info);
 
 		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
 			goto out;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 2de90a7e388b..66e322df78a3 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -27,7 +27,7 @@ static inline int fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 				  __u32 mask)
 {
 	return fsnotify(dir, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-			dentry->d_name.name, 0);
+			&dentry->d_name, 0);
 }
 
 /* Notify this dentry's parent about a child's events. */
@@ -122,9 +122,9 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	}
 
 	fsnotify(old_dir, old_dir_mask, source, FSNOTIFY_EVENT_INODE,
-		 old_name->name, fs_cookie);
+		 old_name, fs_cookie);
 	fsnotify(new_dir, new_dir_mask, source, FSNOTIFY_EVENT_INODE,
-		 moved->d_name.name, fs_cookie);
+		 &moved->d_name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
@@ -177,7 +177,7 @@ static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
 	take_dentry_name_snapshot(&name, dentry);
 
 	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 name.name.name, 0);
+		 &name.name, 0);
 
 	release_dentry_name_snapshot(&name);
 	dput(parent);
@@ -217,7 +217,7 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode, struct
 	fsnotify_link_count(inode);
 	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, new_dentry->d_name.name, 0);
+	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, &new_dentry->d_name, 0);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index dfc28fcb4de8..7eb7821766d5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -350,7 +350,7 @@ struct fsnotify_mark {
 
 /* main fsnotify call to send events */
 extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-		    const unsigned char *name, u32 cookie);
+		    const struct qstr *name, u32 cookie);
 extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask);
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
@@ -505,7 +505,7 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
 #else
 
 static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
-			   const unsigned char *name, u32 cookie)
+			   const struct qstr *name, u32 cookie)
 {
 	return 0;
 }
-- 
2.20.1

