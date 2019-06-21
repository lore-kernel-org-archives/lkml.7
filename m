Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E2BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEAC2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iw35R/Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFUBVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:21:23 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44049 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfFUBU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id c207so5864915qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cGLXMU1YnQtnetBkOzKftKG7arjvZ1jbq9hetLwX05g=;
        b=Iw35R/Eu6FmNCrNhbSTqcI8DB4KZg9y8SE61Gi0a251zS4oBVJz/PKWo5dHEDcHuMA
         ulYfDpKSQ7DHuCNUjchUEJRqcRbx68VRynhJQwaLLu+VKOKHhnzPEV9wjkUu4S4UW+MP
         2IQ27BL0XyVTLaF5ziFegxSpsI/rB565Doy+F2sQnORusCLMLcLN6T2olgPMAg/jSxm/
         9nO1R23May7rA0O0PU+XqFBRYdHMtAJ4u5YP/e8c9LYTuB/oTbLa6UjGPVmPQGGTMCYk
         1af4rDqeqIcr6RBLb/zkgGGfddqdHGiaeOYvXDITWZLVYjFTmTJDHLIYxaZdpWzmU3gO
         EXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cGLXMU1YnQtnetBkOzKftKG7arjvZ1jbq9hetLwX05g=;
        b=IqA/7zwcJdkevznfyIv1Ue2pCafbbMvtZ4nO12XTeeEf7UFd3cibxW9wDmt7fGq+Lj
         11JQM3vxwSd/UnFpM/ULwrwjTUR6RO6jVB+traXOutX3frT6Mrx6dS+WQFmr8djWLwYM
         Wo1dPkv5YzcpgQj5EGEds10LDtdQ7wRbjhdLaktRPSX3lczPzSvnjvHoqHI86IUN04Z2
         plNujUZadhzVY0KtpZyw2Z9pv0FIHsx0cPk6QelJyvWCdeeFIcObi0PYgj5x4VvYwU3/
         wLdbLdXJnfWuQadb2764Nq/bMLWw9NYe/jXxWsGCQxMtAFUfn+S9hhGqSUlEE88Xfe3o
         Bkkw==
X-Gm-Message-State: APjAAAX7FY1yn1pwgOSW0sd0080teouZMvJN4R8exQ7Gj5Mrghhwjq6N
        4SZFdWJKvRKglSIQQwnA0VjordAjWqcCEY3TLatBMg==
X-Google-Smtp-Source: APXvYqyTpU2hpzgS+S8uINHmKPXYdlgG4t76TC4JvSOnqT0fI7MdeIWKOfI5e1RekIkFoXgCBRLlZyGtRlZBgaPorNLSrg==
X-Received: by 2002:ac8:458d:: with SMTP id l13mr117467574qtn.165.1561080058028;
 Thu, 20 Jun 2019 18:20:58 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:39 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 28/30] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 fs/debugfs/file.c            | 31 +++++++++++++++++++++++++++++++
 fs/debugfs/inode.c           | 31 +++++++++++++++++++++++++++++--
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..227b147350b7 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -19,6 +19,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/poll.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -136,6 +137,25 @@ void debugfs_file_put(struct dentry *dentry)
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
+	return security_is_locked_down(LOCKDOWN_DEBUGFS);
+}
+
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
@@ -147,6 +167,12 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	if (debugfs_is_locked_down(inode, filp, real_fops)) {
+		r = -EPERM;
+		goto out;
+	}
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not clean up after itself at exit? */
@@ -272,6 +298,11 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+	if (debugfs_is_locked_down(inode, filp, real_fops)) {
+		r = -EPERM;
+		goto out;
+	}
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not cleanup after itself at exit? */
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 95b5e78c22b1..76b24fb3c911 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -32,6 +33,31 @@ static struct vfsmount *debugfs_mount;
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
+	    security_is_locked_down(LOCKDOWN_DEBUGFS))
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
@@ -356,6 +382,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -516,7 +543,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return failed_creating(dentry);
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -611,7 +638,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		return failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
 	return end_creating(dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index 36a9daa13bb0..2563a9e3b415 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -94,6 +94,7 @@ enum lockdown_reason {
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
+	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 408f0048f8a2..a6f7b0770e78 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -30,6 +30,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
+	[LOCKDOWN_DEBUGFS] = "debugfs access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
-- 
2.22.0.410.gd8fdbe21b5-goog

