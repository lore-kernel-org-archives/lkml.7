Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A582C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEF22072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 19:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgAATFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 14:05:24 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59564 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAATFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 14:05:23 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 418D72009FC;
        Wed,  1 Jan 2020 19:05:21 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 97A2820343; Wed,  1 Jan 2020 20:05:03 +0100 (CET)
Date:   Wed, 1 Jan 2020 20:05:03 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        youling257@gmail.com, Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH] Revert "fs: remove ksys_dup()"
Message-ID: <20200101190503.GA43718@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8243186f0cc7c57cf9d6a110cd7315c44e3e0be8 and
additionally the fix in commit 2d3145f8d2809592ef803a30c8a342b5a9e2de9a.

Trying to use filp_open() and f_dupfd() instead of pseudo-syscalls
caused more trouble than what is worth it: it requires accessing
vfs internals and causes a strange issue on Androidx86 long after
boot.

Reported-by: youling 257 <youling257@gmail.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

Instead of that (seemingly suboptimal) approach in trying to get the
fake __user char out of init/main.c, I'll prepare some patches which
have ksys_open() [and a few other ksys_*() functions] operate on
kernelspace pointers instead. That will be more compatible with
keeping vfs internals internal, and actually move us faster in the
direction to let kernel init run with USER_DS. Moreover, that approach
doesn't seem to break youling 257's setup.

Thanks,
	Dominik


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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2960dedcfde8..5262b7a76d39 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1232,6 +1232,7 @@ asmlinkage long sys_ni_syscall(void);
  */
 
 int ksys_umount(char __user *name, int flags);
+int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
diff --git a/init/main.c b/init/main.c
index 1ecfd43ed464..2cd736059416 100644
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
+	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
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
