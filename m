Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854F220652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551712577;
	bh=RnBPjpke3GJ6X9V4BZGlsCmHgfDuUs88KoFbg++X594=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aII+6NEm7nOwJxPDzYEmwdyNxlc1mYaSkjdIkOW3mema6gTW/D1+YKVjw9eRvoWnz
	 /O3DgtghSLqMVqJE2lbmz3r1DbTWQXWnMAfdd6iEDUda2bFelKYlpNaptHOoyeXIcU
	 9nQNgLj16mmNhR5RSdMBmiTyMLidywHb01atNIg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCDPQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCDPQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:16:15 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8B520449;
        Mon,  4 Mar 2019 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551712573;
        bh=RnBPjpke3GJ6X9V4BZGlsCmHgfDuUs88KoFbg++X594=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KexmTFog+E5ELNhNXUaeilj0vQz4IVvc11On3sdNBe7d7nGuoY1Rdb7/roMA+Q/DT
         8hc4XRIkDVqyHIqiVQ7+XIR6/380P9V9sJr7lYjrhlO2B8bBtBEPWGcW5TcX3s9ZgQ
         V90lpdyERoR08wsigDvhTUXeCkxLODmdjkShZfrs=
Date:   Tue, 5 Mar 2019 00:16:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Subject: Re: [uaccess] 780464aed0:
 WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
Message-Id: <20190305001609.10f950fd4f8089e1ae07c9f1@kernel.org>
In-Reply-To: <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
References: <155136980507.2968.15165201054223875356.stgit@devbox>
        <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
        <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
        <20190304101434.8429ffffb17813c0e7930130@kernel.org>
        <CAHk-=whYMvevgF4yh7uhQug=Wt1A1Eg7abyM=RCi=bQiqiMBvQ@mail.gmail.com>
        <20190304180610.2d4f6f08d9ad89d6abae3597@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 4 Mar 2019 18:06:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sun, 3 Mar 2019 18:37:59 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Sun, Mar 3, 2019 at 5:14 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > I think it comes from WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS)) in
> > > user_access_ok(). The call trace shows that strndup_user might be called
> > > from kernel daemon context.
> > 
> > Ahh, yes.
> > 
> > We've had this before. We've gotten rid of the actual "use system
> > calls", but we still have some of the init sequence in particular just
> > calling the wrappers instead.
> 
> Are those safe if we are in init sequence?
> 
> > 
> > And yes, ksys_mount() takes __user pointers.
> > 
> > It would be a lot better to use "do_mount()", which is the interface
> > that takes actual "char *" pointers.
> 
> Unfortunately, it still takes a __user pointer.
> 
> long do_mount(const char *dev_name, const char __user *dir_name,
>                 const char *type_page, unsigned long flags, void *data_page)
> 
> So what we need is
> 
> long do_mount(const char *dev_name, struct path *dir_path,
>                 const char *type_page, unsigned long flags, void *data_page)
> 
> or introduce kern_do_mount()?

Would this work?

( BTW, what is this code for? It seems totally insane termination.
  at least this should be done in copy_mount_options().
	if (data_page)
		((char *)data_page)[PAGE_SIZE - 1] = 0;
)

=======
devtmpfs: Avoid passing kernel memory to __user parameter

From: Masami Hiramatsu <mhiramat@kernel.org>

Since ksys_mount(), ksys_chdir() and ksys_chroot() takes
__user parameters, devtmpfsd must not pass the kernel memory
to them. On some arch, it is not possible to pass th kernel
memory to them, since the memory address spaces can be
different.

This introduces kern_do_mount(), kern_chdir() and kern_chroot()
and replaces ksys_* in devtmpfsd().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 drivers/base/devtmpfs.c  |   12 +++++++++---
 fs/namespace.c           |   31 +++++++++++++++++++++++++------
 fs/open.c                |   34 ++++++++++++++++++++++++++++++----
 include/linux/fs.h       |    2 ++
 include/linux/syscalls.h |    6 ++++++
 5 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 0dbc43068eeb..e418b004d6c6 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -381,14 +381,20 @@ static int devtmpfsd(void *p)
 {
 	char options[] = "mode=0755";
 	int *err = p;
+
 	*err = ksys_unshare(CLONE_NEWNS);
 	if (*err)
 		goto out;
-	*err = ksys_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
+
+	*err = kern_do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, options);
+	if (*err)
+		goto out;
+	*err = kern_chdir("/.."); /* will traverse into overmounted root */
+	if (*err)
+		goto out;
+	*err = kern_chroot(".");
 	if (*err)
 		goto out;
-	ksys_chdir("/.."); /* will traverse into overmounted root */
-	ksys_chroot(".");
 	complete(&setup_done);
 	while (1) {
 		spin_lock(&req_lock);
diff --git a/fs/namespace.c b/fs/namespace.c
index 678ef175d63a..68a6b573107d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2761,8 +2761,9 @@ char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-long do_mount(const char *dev_name, const char __user *dir_name,
-		const char *type_page, unsigned long flags, void *data_page)
+static inline long __do_mount(const char *dev_name, const char *kdir_name,
+		const char __user *dir_name, const char *type_page,
+		unsigned long flags, void *data_page)
 {
 	struct path path;
 	unsigned int mnt_flags = 0, sb_flags;
@@ -2773,14 +2774,14 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 		flags &= ~MS_MGC_MSK;
 
 	/* Basic sanity checks */
-	if (data_page)
-		((char *)data_page)[PAGE_SIZE - 1] = 0;
-
 	if (flags & MS_NOUSER)
 		return -EINVAL;
 
 	/* ... and get the mountpoint */
-	retval = user_path(dir_name, &path);
+	if (kdir_name)
+		retval = kern_path(kdir_name, LOOKUP_FOLLOW, &path);
+	else
+		retval = user_path(dir_name, &path);
 	if (retval)
 		return retval;
 
@@ -2849,6 +2850,24 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 	return retval;
 }
 
+long kern_do_mount(const char *dev_name, const char *dir_name,
+		   const char *type_page, unsigned long flags, void *data_page)
+{
+	return __do_mount(dev_name, dir_name, NULL, type_page, flags,
+			  data_page);
+}
+
+long do_mount(const char *dev_name, const char __user *dir_name,
+	      const char *type_page, unsigned long flags, void *data_page)
+{
+	/* This must come from copy_mount_options */
+	if (data_page)
+		((char *)data_page)[PAGE_SIZE - 1] = 0;
+
+	return __do_mount(dev_name, NULL, dir_name, type_page, flags,
+			  data_page);
+}
+
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_MNT_NAMESPACES);
diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..2a9eee753d3a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -430,13 +430,16 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 	return do_faccessat(AT_FDCWD, filename, mode);
 }
 
-int ksys_chdir(const char __user *filename)
+static int __do_chdir(const char *kfname, const char __user *ufname)
 {
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 retry:
-	error = user_path_at(AT_FDCWD, filename, lookup_flags, &path);
+	if (kfname)
+		error = kern_path(kfname, lookup_flags, &path);
+	else
+		error = user_path_at(AT_FDCWD, ufname, lookup_flags, &path);
 	if (error)
 		goto out;
 
@@ -456,6 +459,16 @@ int ksys_chdir(const char __user *filename)
 	return error;
 }
 
+int kern_chdir(const char *filename)
+{
+	return __do_chdir(filename, NULL);
+}
+
+int ksys_chdir(const char __user *filename)
+{
+	return __do_chdir(NULL, filename);
+}
+
 SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
 	return ksys_chdir(filename);
@@ -483,13 +496,16 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	return error;
 }
 
-int ksys_chroot(const char __user *filename)
+static int __do_chroot(const char *kfname, const char __user *ufname)
 {
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 retry:
-	error = user_path_at(AT_FDCWD, filename, lookup_flags, &path);
+	if (kfname)
+		error = kern_path(kfname, lookup_flags, &path);
+	else
+		error = user_path_at(AT_FDCWD, ufname, lookup_flags, &path);
 	if (error)
 		goto out;
 
@@ -516,6 +532,16 @@ int ksys_chroot(const char __user *filename)
 	return error;
 }
 
+int kern_chroot(const char *filename)
+{
+	return __do_chroot(filename, NULL);
+}
+
+int ksys_chroot(const char __user *filename)
+{
+	return __do_chroot(NULL, filename);
+}
+
 SYSCALL_DEFINE1(chroot, const char __user *, filename)
 {
 	return ksys_chroot(filename);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 29d8e2cfed0e..38be90b86435 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,6 +2279,8 @@ extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
+extern long kern_do_mount(const char *, const char *,
+		     const char *, unsigned long, void *);
 extern struct vfsmount *collect_mounts(const struct path *);
 extern void drop_collected_mounts(struct vfsmount *);
 extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..ec8bfca990c9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1146,6 +1146,10 @@ asmlinkage long sys_ni_syscall(void);
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
  * Instead, use one of the functions which work equivalently, such as
  * the ksys_xyzyyz() functions prototyped below.
+ * However, ksys_xyzxyz() functions should be used carefully, because
+ * kernel must not pass kernel memory to __user parameter. Force type
+ * casting is meaningless, since those address will be accessed by
+ * copy_from_user() etc. which will reject accessing kernel memory.
  */
 
 int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
@@ -1153,8 +1157,10 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
 int ksys_umount(char __user *name, int flags);
 int ksys_dup(unsigned int fildes);
 int ksys_chroot(const char __user *filename);
+int kern_chroot(const char *filename);
 ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count);
 int ksys_chdir(const char __user *filename);
+int kern_chdir(const char *filename);
 int ksys_fchmod(unsigned int fd, umode_t mode);
 int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 int ksys_getdents64(unsigned int fd, struct linux_dirent64 __user *dirent,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
