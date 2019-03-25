Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A1E20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7Xx65wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfCYWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:11:25 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:42407 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbfCYWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:11:04 -0400
Received: by mail-oi1-f201.google.com with SMTP id r84so2744925oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x7CSy5VUNpZirrVzUJKZsqK1/aML0MIeKkdBP16YKzM=;
        b=R7Xx65wIL06Y8y0QtQ8SG/vdw9oErMNuqyNB6rpB5YofGBaRNwZYi9l8tvDEOHq//V
         /7x3/yXesn18u/OkVNRZuU7tStW5UNqlnHJHIhVOhAP48zU7gjZ8VTuEGqyAyFngkllF
         USRMXhNXMQT/xjdXcye+DsqYj++Vp8TY8OnfRVUJHKTEzCLZEAl5bItoDD86rUuZknH3
         TMbWURksHGo9J7sZ+klskcUUP10Gm6KYDacPW4+2Wz85Kl4XvtXO49dphZRi1jJlKepQ
         gvB4JPRZ131v68n3RPdYm6VB8q3LYfoYDbhCcBR8jDlY8zNRQzk8JLG0G5fXKDc0fzBe
         YB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x7CSy5VUNpZirrVzUJKZsqK1/aML0MIeKkdBP16YKzM=;
        b=Y/lcQ8KQpsSVzCmQdutpyqAUPoTaiMh0QM/t1lWQkQNjERg5DS8pOrd8n3XHR45zbw
         lYAaVwquH2cZeU1HSWFXUcWODoRRM4W1sfmOm+PlQbkg6oY4uBTK/nChEvab/3TgSPAw
         lbQ0y7xrNKNniM6Qk3FSNKDgMKjtBv9nphZmxi0gbBNDs2P+fUpcsNx+zBbDCZT3Wimv
         CkOUjo6elD0al1YdGJUiIiUYZOPClYTccNc5zH25uIPr4PGH2ACwKgWY8sNm3hyWQlaW
         DDte3yMzYRqwtmSEK0W2EgDFbiQzaZM4SC+xYTlvnK3Fttw+WuZHxGtIkliN5ReFgvnf
         juAw==
X-Gm-Message-State: APjAAAVkLD+yIcDLtDMunXIA+9e0XBsdbLlcnr2Jkm0Zb0HUzU6un4P7
        juw6auzv5WaGLCNhMFlyI0jATqJvQv3E6u0ZOiDF4g==
X-Google-Smtp-Source: APXvYqxbvkDBtdhhh8lD62vZuxS8kradSSiukiXkadLNavl6KpgmoLZs1rLXZlzlDCrboZhOM501EYIRM+kDmvkrCLFvhQ==
X-Received: by 2002:aca:b589:: with SMTP id e131mr13718240oif.91.1553551863717;
 Mon, 25 Mar 2019 15:11:03 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:52 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 25/27] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow opening of debugfs files that might be used to muck around when
the kernel is locked down as various drivers give raw access to hardware
through debugfs.  Given the effort of auditing all 2000 or so files and
manually fixing each one as necessary, I've chosen to apply a heuristic
instead.  The following changes are made:

 (1) chmod and chown are disallowed on debugfs objects (though the root dir
     can be modified by mount and remount, but I'm not worried about that).

 (2) When the kernel is locked down, only files with the following criteria
     are permitted to be opened:

	- The file must have mode 00444
	- The file must not have ioctl methods
	- The file must not have mmap

 (3) When the kernel is locked down, files may only be opened for reading.

Normal device interaction should be done through configfs, sysfs or a
miscdev, not debugfs.

Note that this makes it unnecessary to specifically lock down show_dsts(),
show_devs() and show_call() in the asus-wmi driver.

I would actually prefer to lock down all files by default and have the
the files unlocked by the creator.  This is tricky to manage correctly,
though, as there are 19 creation functions and ~1600 call sites (some of
them in loops scanning tables).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: acpi4asus-user@lists.sourceforge.net
cc: platform-driver-x86@vger.kernel.org
cc: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 fs/debugfs/file.c  | 28 ++++++++++++++++++++++++++++
 fs/debugfs/inode.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..c33042c1eff3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -136,6 +136,25 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+/*
+ * Only permit access to world-readable files when the kernel is locked down.
+ * We also need to exclude any file that has ways to write or alter it as root
+ * can bypass the permissions check.
+ */
+static bool debugfs_is_locked_down(struct inode *inode,
+				   struct file *filp,
+				   const struct file_operations *real_fops)
+{
+	if ((inode->i_mode & 07777) == 0444 &&
+	    !(filp->f_mode & FMODE_WRITE) &&
+	    !real_fops->unlocked_ioctl &&
+	    !real_fops->compat_ioctl &&
+	    !real_fops->mmap)
+		return false;
+
+	return kernel_is_locked_down("debugfs");
+}
+
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
@@ -147,6 +166,11 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = -EPERM;
+	if (debugfs_is_locked_down(inode, filp, real_fops))
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not clean up after itself at exit? */
@@ -272,6 +296,10 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+	r = -EPERM;
+	if (debugfs_is_locked_down(inode, filp, real_fops))
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not cleanup after itself at exit? */
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..4daec17b8215 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -32,6 +32,31 @@ static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
 
+/*
+ * Don't allow access attributes to be changed whilst the kernel is locked down
+ * so that we can use the file mode as part of a heuristic to determine whether
+ * to lock down individual files.
+ */
+static int debugfs_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	if ((ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)) &&
+	    kernel_is_locked_down("debugfs"))
+		return -EPERM;
+	return simple_setattr(dentry, ia);
+}
+
+static const struct inode_operations debugfs_file_inode_operations = {
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.setattr	= debugfs_setattr,
+};
+static const struct inode_operations debugfs_symlink_inode_operations = {
+	.get_link	= simple_get_link,
+	.setattr	= debugfs_setattr,
+};
+
 static struct inode *debugfs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
@@ -356,6 +381,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -513,7 +539,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return failed_creating(dentry);
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -608,7 +634,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		return failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
 	return end_creating(dentry);
-- 
2.21.0.392.gf8f6787159e-goog

