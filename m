Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67555C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F51520B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556303347;
	bh=qPguXvk3S40sXOgTeAXxt29eR11ACNXOhNQRyIoZS7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJwknDy5dZ34fAWj7a6YqpTjDmXpRi/cohf+0OL57UaTLHUdq88ZMiXfqTl/Um7FX
	 bTk2DfaBpiPzecmha9jMdpQb2g5tsfPNaOxeQ/POzKxU4x341umonaRnJKn8bpOtF5
	 ZaUMrgBD/GcW/+CfIhwhHz3/IewXPYOvUeKT+3w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfDZS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfDZS26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:28:58 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE81A21655;
        Fri, 26 Apr 2019 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556303337;
        bh=qPguXvk3S40sXOgTeAXxt29eR11ACNXOhNQRyIoZS7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBRasJCyL4p+vhW0pIUG8ly+IDXVGFUojd110zzACOkg6/Acop5Qe3hxZWPV7bLC6
         Hj9KFqPyudUOMKklwD6GVJfukmZdaqe5Y0j0Qh0GxIvheRg65t1Dmo3Wrbzutqs0eC
         RM5db/pAiEzJDatZjRg0zNczopQ6Fr60Fbig2lFI=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, gregkh@linuxfoundation.org, tj@kernel.org,
        jack@suse.cz, amir73il@gmail.com, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com, rafael@kernel.org
Subject: [PATCH 5/5] audit: fix audit_compare_dname_path to take a qstr
Date:   Fri, 26 Apr 2019 14:28:47 -0400
Message-Id: <20190426182847.25088-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426182847.25088-1-jlayton@kernel.org>
References: <20190426182847.25088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...and eliminate its strlen call.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 kernel/audit.h          | 3 ++-
 kernel/audit_fsnotify.c | 2 +-
 kernel/audit_watch.c    | 6 +++---
 kernel/auditfilter.c    | 7 ++++---
 kernel/auditsc.c        | 7 +++----
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 958d5b8fc1b3..8c581fd38050 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -231,7 +231,8 @@ extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
 extern int parent_len(const char *path);
-extern int audit_compare_dname_path(const char *dname, const char *path, int plen);
+extern int audit_compare_dname_path(const struct qstr *dname, const char *path,
+				    int plen);
 extern struct sk_buff *audit_make_reply(int seq, int type, int done, int multi,
 					const void *payload, int size);
 extern void		    audit_panic(const char *message);
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 6def7f426ba6..af281e965d24 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -188,7 +188,7 @@ static int audit_mark_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
-		if (audit_compare_dname_path(dname->name, audit_mark->path,
+		if (audit_compare_dname_path(dname, audit_mark->path,
 					     AUDIT_NAME_FULL))
 			return 0;
 		audit_update_mark(audit_mark, inode);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 3c12fd5b680e..b50c574223fa 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -255,7 +255,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
-			       const char *dname, dev_t dev,
+			       const struct qstr *dname, dev_t dev,
 			       unsigned long ino, unsigned invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
@@ -507,9 +507,9 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname->name, inode->i_sb->s_dev, inode->i_ino, 0);
+		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
 	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname->name, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f26fab..6f585b48f4ef 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1290,12 +1290,13 @@ int parent_len(const char *path)
  * @parentlen:	length of the parent if known. Passing in AUDIT_NAME_FULL
  * 		here indicates that we must compute this value.
  */
-int audit_compare_dname_path(const char *dname, const char *path, int parentlen)
+int audit_compare_dname_path(const struct qstr *dname, const char *path,
+			     int parentlen)
 {
 	int dlen, pathlen;
 	const char *p;
 
-	dlen = strlen(dname);
+	dlen = dname->len;
 	pathlen = strlen(path);
 	if (pathlen < dlen)
 		return 1;
@@ -1306,7 +1307,7 @@ int audit_compare_dname_path(const char *dname, const char *path, int parentlen)
 
 	p = path + parentlen;
 
-	return strncmp(p, dname, dlen);
+	return strncmp(p, dname->name, dlen);
 }
 
 int audit_filter(int msgtype, unsigned int listtype)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1eab1d4a930..05e06b766af1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2045,7 +2045,6 @@ void __audit_inode_child(struct inode *parent,
 {
 	struct audit_context *context = audit_context();
 	struct inode *inode = d_backing_inode(dentry);
-	const char *dname = dentry->d_name.name;
 	struct audit_names *n, *found_parent = NULL, *found_child = NULL;
 	struct audit_entry *e;
 	struct list_head *list = &audit_filter_list[AUDIT_FILTER_FS];
@@ -2083,7 +2082,7 @@ void __audit_inode_child(struct inode *parent,
 			continue;
 
 		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
-		    !audit_compare_dname_path(dname,
+		    !audit_compare_dname_path(&dentry->d_name,
 					      n->name->name, n->name_len)) {
 			if (n->type == AUDIT_TYPE_UNKNOWN)
 				n->type = AUDIT_TYPE_PARENT;
@@ -2099,8 +2098,8 @@ void __audit_inode_child(struct inode *parent,
 		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
 			continue;
 
-		if (!strcmp(dname, n->name->name) ||
-		    !audit_compare_dname_path(dname, n->name->name,
+		if (!strcmp(dentry->d_name.name, n->name->name) ||
+		    !audit_compare_dname_path(&dentry->d_name, n->name->name,
 						found_parent ?
 						found_parent->name_len :
 						AUDIT_NAME_FULL)) {
-- 
2.20.1

