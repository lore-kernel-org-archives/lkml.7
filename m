Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDC9C10F06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B2B2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tynZpQX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDDAeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:04 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:57064 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfDDAeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:34:01 -0400
Received: by mail-pl1-f202.google.com with SMTP id n23so597882plp.23
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Dcb0Qj0LUavzChJOHbrHpuPY7bvPXNOYdMmn52tha6Y=;
        b=tynZpQX5Z+CztCjr916yNwtl6L+XGXjjGUrFXtQpZ5usSFz4YxlaEAEqhz0HWi2GPr
         3ZndnJqV7lpkt9h2o1qG7ELJPsyc2I6qQfJqaPQ8qrjE47FdeNRJqRq9YFd9POsjU5sP
         mjNoY4lJFK5uRIc84lLf6gub0gv0VEkFb+/wSAU5EUUfHXlRxsobEde4POuj7TCBcWua
         Qi396U9FARAElVVNjubCrxlIQV4ragxeyikFWjDUQaMomsLmWw+6OvivoD7fMKyI5dvv
         wN59ND9OWQ2IQrSevwR0t5KI5uJ6H51qQJrtt7Oj8xfDDhovLufB5SOcc8M1b6S27Jcu
         ZzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Dcb0Qj0LUavzChJOHbrHpuPY7bvPXNOYdMmn52tha6Y=;
        b=ll6ZKP0sMhsPKp/XAjMYqbjuQoLvDTdrMXAZTZ+Rg7TmwuHWu2j1YD00WWjiDyCNG4
         Z2uX5DIdQZFsQQjku52zWl2+1hyqgLnLjhwAAdZDOCYSczZXoBRA13wZ/JqTUrctNKNu
         ECS7kDhAGZq1fwFa6qJX3MO1Is777r3oUmnsxw7RSATa5YtqtamrfyXhpNJlmSzmg0uw
         dYkqfvmiV/zTZPQifbauQNTsiqE3J9Qb4Il1skuaumbVb2yKOarZZszR/bvRMFr1NP/H
         Y2bQCOdMqarAQFNAe4ETGjgUO2PpwMmxFZkRTCf4Aef10XWYYr5V1Ju7WpYOU+U6jf5m
         ci/g==
X-Gm-Message-State: APjAAAXq7o18ZiAqO9UU7ry9dGuh1bFOFp/tkBeAdFjfJWrAT/P9V6RG
        YUz4AojHFiejkDxJlXCTVPz422bwH2Uu2ewfQR5gKw==
X-Google-Smtp-Source: APXvYqxU+tVV28xQIhgdT/FVHPkyo6fMTrvZk4rLlPIu3rL4x8+P0psjSA0AtuCUikHEC1c/qdoCFYdxcp84BXPXHLvofw==
X-Received: by 2002:a17:902:7487:: with SMTP id h7mr134354pll.86.1554338040783;
 Wed, 03 Apr 2019 17:34:00 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:48 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-27-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 26/27] debugfs: Restrict debugfs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
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
 fs/debugfs/file.c  | 28 ++++++++++++++++++++++++++++
 fs/debugfs/inode.c | 30 ++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..2d18e7711fca 100644
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
+	return kernel_is_locked_down("debugfs", LOCKDOWN_INTEGRITY);
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
index 13b01351dd1c..4b877cb1431d 100644
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
+	    kernel_is_locked_down("debugfs", LOCKDOWN_INTEGRITY))
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

