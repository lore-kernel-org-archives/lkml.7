Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C75BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF09207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgAARa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 12:30:26 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:55976 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAARaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:30:25 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id CCB46200A62;
        Wed,  1 Jan 2020 17:30:22 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id CB22920342; Wed,  1 Jan 2020 18:24:38 +0100 (CET)
Date:   Wed, 1 Jan 2020 18:24:38 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     youling 257 <youling257@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
Message-ID: <20200101172438.GA38218@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan>
 <20200101104313.GA666771@light.dominikbrodowski.net>
 <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 09:27:27PM +0800, youling 257 wrote:
> Unfortunately, test this patch still no help, has system/bin/sh warning.

Thanks for testing! Could you test one more try, please (on top of current
mainline)? It's mainly a revert, and then an attempt to get ksys_open()
right.

Thanks,
	Dominik


NOTE: test patch only. Do not commit.

diff --git a/fs/file.c b/fs/file.c
index 2f4fcf985079..3da91a112bab 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -960,7 +960,7 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 	return ksys_dup3(oldfd, newfd, 0);
 }
 
-SYSCALL_DEFINE1(dup, unsigned int, fildes)
+int ksys_dup(unsigned int fildes)
 {
 	int ret = -EBADF;
 	struct file *file = fget_raw(fildes);
@@ -975,6 +975,11 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 	return ret;
 }
 
+SYSCALL_DEFINE1(dup, unsigned int, fildes)
+{
+	return ksys_dup(fildes);
+}
+
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
 	int err;
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..270767c9966b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1079,7 +1079,50 @@ struct file *file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(file_open_root);
 
-long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
+/**
+ * ksys_open - open file and return fd
+ *
+ * @filename:	path to open
+ * @flags:	open flags as per the open(2) second argument
+ * @mode:	mode for the new file if O_CREAT is set, else ignored
+ *
+ * This is the helper to open a file from kernelspace if you really
+ * have to.  But in generally you should not do this, so please move
+ * along, nothing to see here..
+ */
+long ksys_open(const char *filename, int flags, umode_t mode)
+{
+	struct open_flags op;
+	struct filename *tmp;
+	int fd;
+
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+
+	fd = build_open_flags(flags, mode, &op);
+	if (fd)
+		return fd;
+
+	tmp = getname_kernel(filename);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	fd = get_unused_fd_flags(flags);
+	if (fd >= 0) {
+		struct file *f = do_filp_open(AT_FDCWD, tmp, &op);
+		if (IS_ERR(f)) {
+			put_unused_fd(fd);
+			fd = PTR_ERR(f);
+		} else {
+			fsnotify_open(f);
+			fd_install(fd, f);
+		}
+	}
+	putname(tmp);
+	return fd;
+}
+
+static long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 {
 	struct open_flags op;
 	int fd = build_open_flags(flags, mode, &op);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..8ffe1fd6b6dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2528,8 +2528,6 @@ extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
 		       struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
-			umode_t mode);
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2960dedcfde8..6aa988e66e7b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1232,6 +1232,7 @@ asmlinkage long sys_ni_syscall(void);
  */
 
 int ksys_umount(char __user *name, int flags);
+int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
@@ -1371,16 +1372,7 @@ static inline int ksys_close(unsigned int fd)
 	return __close_fd(current->files, fd);
 }
 
-extern long do_sys_open(int dfd, const char __user *filename, int flags,
-			umode_t mode);
-
-static inline long ksys_open(const char __user *filename, int flags,
-			     umode_t mode)
-{
-	if (force_o_largefile())
-		flags |= O_LARGEFILE;
-	return do_sys_open(AT_FDCWD, filename, flags, mode);
-}
+extern long ksys_open(const char *filename, int flags, umode_t mode);
 
 extern long do_sys_truncate(const char __user *pathname, loff_t length);
 
diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..72aa063bf29e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -93,7 +93,6 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
-#include <linux/file.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1158,26 +1157,13 @@ static int __ref kernel_init(void *unused)
 
 void console_on_rootfs(void)
 {
-	struct file *file;
-	unsigned int i;
-
-	/* Open /dev/console in kernelspace, this should never fail */
-	file = filp_open("/dev/console", O_RDWR, 0);
-	if (IS_ERR(file))
-		goto err_out;
-
-	/* create stdin/stdout/stderr, this should never fail */
-	for (i = 0; i < 3; i++) {
-		if (f_dupfd(i, file, 0) != i)
-			goto err_out;
-	}
-
-	return;
+	/* Open the /dev/console as stdin, this should never fail */
+	if (ksys_open("/dev/console", O_RDWR, 0) < 0)
+		pr_err("Warning: unable to open an initial console.\n");
 
-err_out:
-	/* no panic -- this might not be fatal */
-	pr_err("Warning: unable to open an initial console.\n");
-	return;
+	/* create stdout/stderr */
+	(void) ksys_dup(0);
+	(void) ksys_dup(0);
 }
 
 static noinline void __init kernel_init_freeable(void)
