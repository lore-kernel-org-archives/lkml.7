Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8344C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE19212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303336;
	bh=PhejF+uxD/AHiOpiaxpAzIe9h8Sj4miG+Hyie5o3Cco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pu9tNvP/Wiowbf97qZWNapVUHuCnQcK0+vjQXejp1mAkKtzp9BiVoDN+PDv5kU3kW
	 cSByODquflP3B0rVqrmkgHsZ5qoDIE3xxY5TkkOGrXx3ZjCbOy7agVKhV2eOEWs301
	 0+LqZAIdw/+ghalP0puOuBh3iYka51MDOuqI2zAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDZS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:28:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDZS2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:53 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63182146E;
        Fri, 26 Apr 2019 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303332;
        bh=PhejF+uxD/AHiOpiaxpAzIe9h8Sj4miG+Hyie5o3Cco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGuQeqOu5G6ShYokxkvA2F+UX3xSLZQOFY1MPpCN301MaVQ/SxGyCL9KcPaSZSMie
         25Y6Y4uaEc8YIiku1i81MChYxVy4Ut+ncJla+C/cJ0Qz6kx9QUerpMZU05xUj9b4LR
         ZTPSJrLbE6wCB5Z8IFORmjjzwE+w9lUol8HNKa4c=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 1/5] dcache: track the length of the string in struct name_snapshot
Date:   Fri, 26 Apr 2019 14:28:43 -0400
Message-Id: <20190426182847.25088-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several existing callers end up having to strlen the string, so just
convert the code over to set up a qstr instead and copy the length
from the original.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dcache.c              | 11 +++++++----
 fs/debugfs/inode.c       |  2 +-
 fs/namei.c               |  2 +-
 fs/notify/fsnotify.c     |  4 ++--
 fs/overlayfs/export.c    |  2 +-
 include/linux/dcache.h   |  2 +-
 include/linux/fsnotify.h |  2 +-
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index aac41adf4743..a8dcc27ce2d0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -287,22 +287,25 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
 		atomic_inc(&p->u.count);
+		name->name.len = dentry->d_name.len;
 		spin_unlock(&dentry->d_lock);
-		name->name = p->name;
+		name->name.name = p->name;
 	} else {
 		memcpy(name->inline_name, dentry->d_iname,
 		       dentry->d_name.len + 1);
+		name->name.len = dentry->d_name.len;
 		spin_unlock(&dentry->d_lock);
-		name->name = name->inline_name;
+		name->name.name = name->inline_name;
 	}
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
 void release_dentry_name_snapshot(struct name_snapshot *name)
 {
-	if (unlikely(name->name != name->inline_name)) {
+	if (unlikely(name->name.name != name->inline_name)) {
 		struct external_name *p;
-		p = container_of(name->name, struct external_name, name[0]);
+		p = container_of(name->name.name, struct external_name,
+				 name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
 			kfree_rcu(p, u.head);
 	}
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f25daa207421..37c0a025d7e8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -824,7 +824,7 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 		goto exit;
 	}
 	d_move(old_dentry, dentry);
-	fsnotify_move(d_inode(old_dir), d_inode(new_dir), old_name.name,
+	fsnotify_move(d_inode(old_dir), d_inode(new_dir), old_name.name.name,
 		d_is_dir(old_dentry),
 		NULL, old_dentry);
 	release_dentry_name_snapshot(&old_name);
diff --git a/fs/namei.c b/fs/namei.c
index dede0147b3f6..c96713077326 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4498,7 +4498,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
-		fsnotify_move(old_dir, new_dir, old_name.name, is_dir,
+		fsnotify_move(old_dir, new_dir, old_name.name.name, is_dir,
 			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
 		if (flags & RENAME_EXCHANGE) {
 			fsnotify_move(new_dir, old_dir, old_dentry->d_name.name,
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index df06f3da166c..fb22f76329ae 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -179,10 +179,10 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 		take_dentry_name_snapshot(&name, dentry);
 		if (path)
 			ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
-				       name.name, 0);
+				       name.name.name, 0);
 		else
 			ret = fsnotify(p_inode, mask, dentry->d_inode, FSNOTIFY_EVENT_INODE,
-				       name.name, 0);
+				       name.name.name, 0);
 		release_dentry_name_snapshot(&name);
 	}
 
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 54e5d17d7f3e..cc1c9e5606ba 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -398,7 +398,7 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 * pointer because we hold no lock on the real dentry.
 	 */
 	take_dentry_name_snapshot(&name, real);
-	this = lookup_one_len(name.name, connected, strlen(name.name));
+	this = lookup_one_len(name.name.name, connected, name.name.len);
 	err = PTR_ERR(this);
 	if (IS_ERR(this)) {
 		goto fail;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 60996e64c579..2ff5f3bb9ddc 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -594,7 +594,7 @@ static inline struct inode *d_real_inode(const struct dentry *dentry)
 }
 
 struct name_snapshot {
-	const unsigned char *name;
+	struct qstr name;
 	unsigned char inline_name[DNAME_INLINE_LEN];
 };
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 09587e2860b5..e09cfff69bb2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -178,7 +178,7 @@ static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
 	take_dentry_name_snapshot(&name, dentry);
 
 	fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-		 name.name, 0);
+		 name.name.name, 0);
 
 	release_dentry_name_snapshot(&name);
 	dput(parent);
-- 
2.20.1

