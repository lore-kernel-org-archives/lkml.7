Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAFBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A442341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HV23bSo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfICQRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:17:15 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:45631 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfICQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:17:14 -0400
Received: by mail-yb1-f201.google.com with SMTP id p2so14440593ybk.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K0bb58sIVRPVof5l6bIsmNLs/S1EXwD/86fFZzshrEk=;
        b=HV23bSo9uIud4Nyd0cYXzDDTC9L1hxlQvl/0nLafwm09vTuJypzCTEjapJ3pNApQn1
         PZs7UMQ3/nvTE1xsYLCVLEPxg26eu45hO1aDNLkr2ehHbqNJq3SrLMxj50wELOO4/C7E
         k2rcfHdEfaHlbR6iT5vYhwb51bEHQaALDuU3u6MUP72uAJDhCIYVobCDsWhnzeRwuGHe
         0pFY3XuF3sf5WONa5dkOP2lQW7pK8yk35WviCmaodkRRkZYEUm1YD/N3Zy3HEZd2jQ7i
         qfp80NLZ/zpV+Qa3Nrp1IMbwBfm0vKToRbEohTwI5RFArJap7DNyCHRG0sOQCf1IpzUH
         rJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K0bb58sIVRPVof5l6bIsmNLs/S1EXwD/86fFZzshrEk=;
        b=OMeiWim1ojmWagB7KaVq28U6ufERbmZapVCejigkh0gSNu8jc1t8HhvuI2amKztZ4h
         k+4c0G2HPL5yLCHVawVryh1UIA1F0armP8ZYegR+VY06+eBb0HBj1ONkGBZ09fcHhAdd
         iX5ydclS8BI62e9MgWioKRn4ENeJpQAK93WE9fAjvmA4zijuFHeFBibsxJPKGA0bkGF7
         cJThMq7dJlmTetJBxgGvaXro12m2Fgl1bSvzYEt0pNV8FrortMjStui3IQ7KCWuu4+2G
         S27kaK9B+98uqHbLFUbIZVxrXAGj/3WOD6gqmGwEeXixMY0P3yZSOdK4KB8ylL4T590l
         1oAQ==
X-Gm-Message-State: APjAAAU/HCgPqFuaFlP0TpnG7KG7QJX54e6+wwOI9/oElZEVRlGjJgNV
        211FyJaI/H7fcs2ZuluRED/jCcf9lpk=
X-Google-Smtp-Source: APXvYqy9Ck9TyY1uDxJHieUSYSkyh3oRep/k05GPStqIsjUvZHnooR8w3TKQHNVMARgEdhlx7t/IS7jplR0=
X-Received: by 2002:a25:7701:: with SMTP id s1mr23195999ybc.231.1567527432819;
 Tue, 03 Sep 2019 09:17:12 -0700 (PDT)
Date:   Tue,  3 Sep 2019 09:16:53 -0700
In-Reply-To: <20190903161655.107408-1-hridya@google.com>
Message-Id: <20190903161655.107408-3-hridya@google.com>
Mime-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 2/4] binder: Add stats, state and transactions files
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following binder stat files currently live in debugfs.

/sys/kernel/debug/binder/state
/sys/kernel/debug/binder/stats
/sys/kernel/debug/binder/transactions

This patch makes these files available in a binderfs instance
mounted with the mount option 'stats=global'. For example, if a binderfs
instance is mounted at path /dev/binderfs, the above files will be
available at the following locations:

/dev/binderfs/binder_logs/state
/dev/binderfs/binder_logs/stats
/dev/binderfs/binder_logs/transactions

This provides a way to access them even when debugfs is not mounted.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

 Changes in v3:
 - Use set_nlink() instead of inc_nlink() in binderfs_create_dir() as
   per Christian Brauner.
 - Replace parent->d_inode usage with d_inode(parent) in
   binderfs_create_file() for consistency as per Christian Brauner.

 Changes in v2:
 - Consistently name variables across functions as per Christian
   Brauner.
 - Improve check for binderfs device in binderfs_evict_inode()
   as per Christian Brauner.

 drivers/android/binder.c          |  15 ++--
 drivers/android/binder_internal.h |   8 ++
 drivers/android/binderfs.c        | 140 +++++++++++++++++++++++++++++-
 3 files changed, 153 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ca6b21a53321..de795bd229c4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6055,7 +6055,7 @@ static void print_binder_proc_stats(struct seq_file *m,
 }
 
 
-static int state_show(struct seq_file *m, void *unused)
+int binder_state_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 	struct binder_node *node;
@@ -6094,7 +6094,7 @@ static int state_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int stats_show(struct seq_file *m, void *unused)
+int binder_stats_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6110,7 +6110,7 @@ static int stats_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static int transactions_show(struct seq_file *m, void *unused)
+int binder_transactions_show(struct seq_file *m, void *unused)
 {
 	struct binder_proc *proc;
 
@@ -6198,9 +6198,6 @@ const struct file_operations binder_fops = {
 	.release = binder_release,
 };
 
-DEFINE_SHOW_ATTRIBUTE(state);
-DEFINE_SHOW_ATTRIBUTE(stats);
-DEFINE_SHOW_ATTRIBUTE(transactions);
 DEFINE_SHOW_ATTRIBUTE(transaction_log);
 
 static int __init init_binder_device(const char *name)
@@ -6256,17 +6253,17 @@ static int __init binder_init(void)
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &state_fops);
+				    &binder_state_fops);
 		debugfs_create_file("stats",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &stats_fops);
+				    &binder_stats_fops);
 		debugfs_create_file("transactions",
 				    0444,
 				    binder_debugfs_dir_entry_root,
 				    NULL,
-				    &transactions_fops);
+				    &binder_transactions_fops);
 		debugfs_create_file("transaction_log",
 				    0444,
 				    binder_debugfs_dir_entry_root,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index fe8c745dc8e0..12ef96f256c6 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -57,4 +57,12 @@ static inline int __init init_binderfs(void)
 }
 #endif
 
+int binder_stats_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_stats);
+
+int binder_state_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_state);
+
+int binder_transactions_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(binder_transactions);
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7045bfe5b52b..01c1db463053 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -280,7 +280,7 @@ static void binderfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 
-	if (!device)
+	if (!S_ISCHR(inode->i_mode) || !device)
 		return;
 
 	mutex_lock(&binderfs_minors_mutex);
@@ -502,6 +502,141 @@ static const struct inode_operations binderfs_dir_inode_operations = {
 	.unlink = binderfs_unlink,
 };
 
+static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret;
+
+	ret = new_inode(sb);
+	if (ret) {
+		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
+		ret->i_mode = mode;
+		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
+	}
+	return ret;
+}
+
+static struct dentry *binderfs_create_dentry(struct dentry *parent,
+					     const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		return dentry;
+
+	/* Return error if the file/dir already exists. */
+	if (d_really_is_positive(dentry)) {
+		dput(dentry);
+		return ERR_PTR(-EEXIST);
+	}
+
+	return dentry;
+}
+
+static struct dentry *binderfs_create_file(struct dentry *parent,
+					   const char *name,
+					   const struct file_operations *fops,
+					   void *data)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = d_inode(parent);
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = fops;
+	new_inode->i_private = data;
+	d_instantiate(dentry, new_inode);
+	fsnotify_create(parent_inode, dentry);
+
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static struct dentry *binderfs_create_dir(struct dentry *parent,
+					  const char *name)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = d_inode(parent);
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = &simple_dir_operations;
+	new_inode->i_op = &simple_dir_inode_operations;
+
+	set_nlink(new_inode, 2);
+	d_instantiate(dentry, new_inode);
+	inc_nlink(parent_inode);
+	fsnotify_mkdir(parent_inode, dentry);
+
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static int init_binder_logs(struct super_block *sb)
+{
+	struct dentry *binder_logs_root_dir, *dentry;
+	int ret = 0;
+
+	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
+						   "binder_logs");
+	if (IS_ERR(binder_logs_root_dir)) {
+		ret = PTR_ERR(binder_logs_root_dir);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "stats",
+				      &binder_stats_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "state",
+				      &binder_state_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = binderfs_create_file(binder_logs_root_dir, "transactions",
+				      &binder_transactions_fops, NULL);
+	if (IS_ERR(dentry))
+		ret = PTR_ERR(dentry);
+
+out:
+	return ret;
+}
+
 static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int ret;
@@ -580,6 +715,9 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	}
 
+	if (info->mount_opts.stats_mode == STATS_GLOBAL)
+		return init_binder_logs(sb);
+
 	return 0;
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

