Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA850216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303340;
	bh=HUowgapcKvM2imJYDWUjZDUj1s3I+j+zfX+Jrh6XD1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P72X9mHUWUqZstUNlr213LJmPefirvEv5eiVUFyrJNh39tAis75h+EMmZioXykXuu
	 Yv62eMenemBwIq4OH+Nt01yq+SSSiA9sGgnhUoFw1ofiKvLo8Tl65qSkd0UMKpPMom
	 7HZytfSbVNxg1In8RNxE+9riHusJKr39bzdR6JXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDZS27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDZS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:57 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BCBC2166E;
        Fri, 26 Apr 2019 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303336;
        bh=HUowgapcKvM2imJYDWUjZDUj1s3I+j+zfX+Jrh6XD1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ff2KBv0LzPtNTAtN95HZD/4UxMj+PufRhJMtAFD2tiHFKqIBKI6ZL5EojGZhtVQWD
         iRieIrOhDCILs5875hWzrkoKLhhSeOzw25a2+Z1orNyLLR7TFPOqRQoOroUs1KNTa0
         x2aaIPW3+B2ssVFxB9nijq/i1Di/CoAXI8w8obco=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 4/5] fsnotify: change ->handle_event and send_to_group to take a qstr
Date:   Fri, 26 Apr 2019 14:28:46 -0400
Message-Id: <20190426182847.25088-5-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/notify/dnotify/dnotify.c          | 2 +-
 fs/notify/fanotify/fanotify.c        | 2 +-
 fs/notify/fsnotify.c                 | 4 ++--
 fs/notify/inotify/inotify.h          | 2 +-
 fs/notify/inotify/inotify_fsnotify.c | 6 +++---
 include/linux/fsnotify_backend.h     | 2 +-
 kernel/audit_fsnotify.c              | 5 +++--
 kernel/audit_tree.c                  | 2 +-
 kernel/audit_watch.c                 | 6 +++---
 9 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 58d77dc696eb..250369d6901d 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -81,7 +81,7 @@ static void dnotify_recalc_inode_mask(struct fsnotify_mark *fsn_mark)
 static int dnotify_handle_event(struct fsnotify_group *group,
 				struct inode *inode,
 				u32 mask, const void *data, int data_type,
-				const unsigned char *file_name, u32 cookie,
+				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..a34d7e003d7d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -361,7 +361,7 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 static int fanotify_handle_event(struct fsnotify_group *group,
 				 struct inode *inode,
 				 u32 mask, const void *data, int data_type,
-				 const unsigned char *file_name, u32 cookie,
+				 const struct qstr *file_name, u32 cookie,
 				 struct fsnotify_iter_info *iter_info)
 {
 	int ret = 0;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9cbb5ae11d2f..5433e37fb0c5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -195,7 +195,7 @@ EXPORT_SYMBOL_GPL(__fsnotify_parent);
 static int send_to_group(struct inode *to_tell,
 			 __u32 mask, const void *data,
 			 int data_is, u32 cookie,
-			 const unsigned char *file_name,
+			 const struct qstr *file_name,
 			 struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *group = NULL;
@@ -379,7 +379,7 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	 */
 	while (fsnotify_iter_select_report_types(&iter_info)) {
 		ret = send_to_group(to_tell, mask, data, data_is, cookie,
-				    file_name->name, &iter_info);
+				    file_name, &iter_info);
 
 		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
 			goto out;
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 74ae60305189..3f246f7b8a92 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -27,7 +27,7 @@ extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 extern int inotify_handle_event(struct fsnotify_group *group,
 				struct inode *inode,
 				u32 mask, const void *data, int data_type,
-				const unsigned char *file_name, u32 cookie,
+				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info);
 
 extern const struct fsnotify_ops inotify_fsnotify_ops;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index ff30abd6a49b..7e8b131029f8 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -67,7 +67,7 @@ static int inotify_merge(struct list_head *list,
 int inotify_handle_event(struct fsnotify_group *group,
 			 struct inode *inode,
 			 u32 mask, const void *data, int data_type,
-			 const unsigned char *file_name, u32 cookie,
+			 const struct qstr *file_name, u32 cookie,
 			 struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
@@ -89,7 +89,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 			return 0;
 	}
 	if (file_name) {
-		len = strlen(file_name);
+		len = file_name->len;
 		alloc_len += len + 1;
 	}
 
@@ -129,7 +129,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
-		strcpy(event->name, file_name);
+		strcpy(event->name, file_name->name);
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7eb7821766d5..c28f6ed1f59b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -117,7 +117,7 @@ struct fsnotify_ops {
 	int (*handle_event)(struct fsnotify_group *group,
 			    struct inode *inode,
 			    u32 mask, const void *data, int data_type,
-			    const unsigned char *file_name, u32 cookie,
+			    const struct qstr *file_name, u32 cookie,
 			    struct fsnotify_iter_info *iter_info);
 	void (*free_group_priv)(struct fsnotify_group *group);
 	void (*freeing_mark)(struct fsnotify_mark *mark, struct fsnotify_group *group);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 37ae95cfb7f4..6def7f426ba6 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -164,7 +164,7 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
 static int audit_mark_handle_event(struct fsnotify_group *group,
 				    struct inode *to_tell,
 				    u32 mask, const void *data, int data_type,
-				    const unsigned char *dname, u32 cookie,
+				    const struct qstr *dname, u32 cookie,
 				    struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
@@ -188,7 +188,8 @@ static int audit_mark_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
-		if (audit_compare_dname_path(dname, audit_mark->path, AUDIT_NAME_FULL))
+		if (audit_compare_dname_path(dname->name, audit_mark->path,
+					     AUDIT_NAME_FULL))
 			return 0;
 		audit_update_mark(audit_mark, inode);
 	} else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index abfb112f26aa..e49c912f862d 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -1040,7 +1040,7 @@ static void evict_chunk(struct audit_chunk *chunk)
 static int audit_tree_handle_event(struct fsnotify_group *group,
 				   struct inode *to_tell,
 				   u32 mask, const void *data, int data_type,
-				   const unsigned char *file_name, u32 cookie,
+				   const struct qstr *file_name, u32 cookie,
 				   struct fsnotify_iter_info *iter_info)
 {
 	return 0;
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e8d1adeb2223..3c12fd5b680e 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -482,7 +482,7 @@ void audit_remove_watch_rule(struct audit_krule *krule)
 static int audit_watch_handle_event(struct fsnotify_group *group,
 				    struct inode *to_tell,
 				    u32 mask, const void *data, int data_type,
-				    const unsigned char *dname, u32 cookie,
+				    const struct qstr *dname, u32 cookie,
 				    struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
@@ -507,9 +507,9 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
+		audit_update_watch(parent, dname->name, inode->i_sb->s_dev, inode->i_ino, 0);
 	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+		audit_update_watch(parent, dname->name, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
-- 
2.20.1

