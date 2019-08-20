Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A036FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DB92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXvX3MY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfHTATY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:24 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40077 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbfHTATT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id m19so3480181pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PnHD6PIrANA/H8RrQcEsi66/pL9qnyHyXS5DOBbHqXk=;
        b=MXvX3MY2xXIWb27rgFUrxEZj52T8rGOkdqnyr+R9wm3qqZxTf2D/libZyOrajCMAtT
         UHOJJohFD8mgBcyBvSlKSgu6K9DxhwpPrzztyrIKQtSqU7xtJIIRzhaHlFZObafIhGqd
         fEzGMon2wCJvAetekIz4A5i87fjpdZUzNpLf69Y2eWQHrKV4Ot/OxVXXuBSty3HAjZ7J
         ERh2quATDDJFIQ7l/eu2UUPwq6rZbs5vsCrkqDdqzKB/+3AtijCdbzZr5yA8yxIjC4Xb
         hnmk5tjHktAptd3LDGkyCE8vAa+l1PSB2Y9/w5axi2mNHfZ3zstDLOCokbqj+oI4YhkG
         MaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PnHD6PIrANA/H8RrQcEsi66/pL9qnyHyXS5DOBbHqXk=;
        b=Ai1XAXNCxq2Nvj5jLW5kKdBY5ElS09AWSxtf2luA/LVx7bLzVs4Yt/PJa8cWDC1UUv
         h/aOKfluJunE6ftBGsAyz2+RQWvOENvG2yVaS4K20HnsuXXKM8/U3ztSCESm8HqOmVCZ
         0okDntsIW3JYyB5f2VA7Vl3bCHoINTltg+hgKTyF10PPkC1V9Ts2veAx2aYzzJwtSIab
         kKuqFQkAnOPoUiqd3sKPqiRgypfof9VEVto21xaaBb8Z3iSfgssgoWauzSow0KPYlxT1
         2TTWqjxFmBrFPT20+a4hwTre44tzQL6Erwv+uR1qm5GDLSWihXVJSiKAz6IiuuMC2Aog
         rC3w==
X-Gm-Message-State: APjAAAUvT8OXtlADrGKAFtz0AtgqMwSbF+NMPWV3UcXhC/KjHOAnfbUC
        HIwkEMa/Iu7v9dpfUSY88PFSc5Zo7aBZimYQwl/JjA==
X-Google-Smtp-Source: APXvYqxYNIO09gpHlcZsmiJnEho4gqR876DcMBw4jRS1UaizEx6pcOYy7tlXCRdAED26e+N9db8K0rLxA0tYqx1XrhGDJQ==
X-Received: by 2002:a63:bf01:: with SMTP id v1mr21722751pgf.278.1566260357287;
 Mon, 19 Aug 2019 17:19:17 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:02 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 26/29] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
Cc: Greg KH <greg@kroah.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Signed-off-by: James Morris <jmorris@namei.org>
---
 fs/debugfs/file.c            | 30 ++++++++++++++++++++++++++++++
 fs/debugfs/inode.c           | 32 ++++++++++++++++++++++++++++++--
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index ddd708b09fa1..5d3e449b5988 100644
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
+	return security_locked_down(LOCKDOWN_DEBUGFS);
+}
+
 static int open_proxy_open(struct inode *inode, struct file *filp)
 {
 	struct dentry *dentry = F_DENTRY(filp);
@@ -147,6 +167,11 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not clean up after itself at exit? */
@@ -272,6 +297,11 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		return r == -EIO ? -ENOENT : r;
 
 	real_fops = debugfs_real_fops(filp);
+
+	r = debugfs_is_locked_down(inode, filp, real_fops);
+	if (r)
+		goto out;
+
 	real_fops = fops_get(real_fops);
 	if (!real_fops) {
 		/* Huh? Module did not cleanup after itself at exit? */
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index acef14ad53db..c8613bcad252 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -32,6 +33,32 @@ static struct vfsmount *debugfs_mount;
 static int debugfs_mount_count;
 static bool debugfs_registered;
 
+/*
+ * Don't allow access attributes to be changed whilst the kernel is locked down
+ * so that we can use the file mode as part of a heuristic to determine whether
+ * to lock down individual files.
+ */
+static int debugfs_setattr(struct dentry *dentry, struct iattr *ia)
+{
+	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
+
+	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
+		return ret;
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
@@ -355,6 +382,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	inode->i_mode = mode;
 	inode->i_private = data;
 
+	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
@@ -515,7 +543,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return failed_creating(dentry);
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
-	inode->i_op = &simple_dir_inode_operations;
+	inode->i_op = &debugfs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
@@ -610,7 +638,7 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 		return failed_creating(dentry);
 	}
 	inode->i_mode = S_IFLNK | S_IRWXUGO;
-	inode->i_op = &simple_symlink_inode_operations;
+	inode->i_op = &debugfs_symlink_inode_operations;
 	inode->i_link = link;
 	d_instantiate(dentry, inode);
 	return end_creating(dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index b94f1e697537..152824b6f456 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -115,6 +115,7 @@ enum lockdown_reason {
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_MMIOTRACE,
+	LOCKDOWN_DEBUGFS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 3d7b1039457b..edd1fff0147d 100644
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
2.23.0.rc1.153.gdeed80330f-goog

