Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26409C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46AB206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NQCgeu0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfC2Pyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:54:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbfC2Pys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:54:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so9981579wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXv4kGkwtwD6Kqq42Dpi3ZSv7WVSx6p8jNSTbwal22c=;
        b=NQCgeu0fOwQQtKKO29ptqYod1M8Wu8jNlSGfzumZLdYZDqmNc9syQM+R3qv8i3o/WY
         NE6NBJIZRReU0jznIArmOUXgPwnhZ4e1u6Cngj2Jb9y1DOhBmmv+x2z7p6dlgm+8rb25
         I5zzHOCDJurF3Am8gb5kTdTSUU4MJSHsumYynKNJCCVkLpjFlD9i1yglELNXXGeU3Nuf
         DWYGefqx1wZce4rTz/TxTjEnEJgUWcT18/pUIt++C/fCnuAfVgOFnnkII/+QZAijuL3p
         eo/a8pe3+konssHaJFeFwEG78MZv6rjsVsRy9CJRwkktDhJBdSvq9vs5+qr7NnUvXPbc
         BobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXv4kGkwtwD6Kqq42Dpi3ZSv7WVSx6p8jNSTbwal22c=;
        b=XpU+49xKu8+/OPS5VzpSV2wmCUlP2nzQ+iTLCLym2088+2Z0XWnQY57PpZE5DhPExP
         M2QByllDGWkFt0hZ7zom+KpLL1/QegTRPcoG/7LkAEJNzgIIOPL/FJEtak5AO3uy8LcD
         9Vz69AHsN43X1HAn6t3uglgsfAK+7GVXEDA/11PrTYFbZf8Yti69bbh+gYQDYsKxgF3v
         NUabA0K00CtBwcy24RvEjtXs575iaiG781BmwfuteYNI8/2/0HSTQ3nzTx8Gemb46lCk
         Z0p36JrJ7zq1wiIOnDIsgiJWwmA1VZi/x71Y/WTfEKn88YPg7Tc3cCS70ZFk3NTQVxd3
         GJpw==
X-Gm-Message-State: APjAAAUMwqpPf55Y0ZV89mjVyYDLF7ORsYN+TUlRq7itmwnFAQ07XseD
        LcAXcli088MV9OgdhVR7v9eJhg==
X-Google-Smtp-Source: APXvYqzOtiPwauDU6r2QeUn1G/ebkv0YY7FHhmOQ8NVw+3ly8FcAg/vrpmbJYBH5tuUtae/sx9tBLw==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr4271991wmk.72.1553874885603;
        Fri, 29 Mar 2019 08:54:45 -0700 (PDT)
Received: from localhost.localdomain (p2E5A5955.dip0.t-ipconnect.de. [46.90.89.85])
        by smtp.gmail.com with ESMTPSA id e1sm4177959wrw.66.2019.03.29.08.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:54:45 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        keescook@chromium.org, adobriyan@gmail.com, tglx@linutronix.de,
        mtk.manpages@gmail.com, bl0pbl33p@gmail.com, ldv@altlinux.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/5] pid: add pidfd_open()
Date:   Fri, 29 Mar 2019 16:54:22 +0100
Message-Id: <20190329155425.26059-3-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329155425.26059-1-christian@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/* Introduction */
This adds the pidfd_open() syscall.
pidfd_open() allows to retrieve file descriptors for a given pid. This
includes both file descriptors for processes and file descriptors for
threads.

With the addition of this syscalls pidfd become independent of procfs just
as pids are. Of course, if CONFIG_PROC_FS is not set then metadata access
for processes will not be possible but everything else will just work fine.
In addition, this allows us to remove the dependency of pidfd_send_signal()
on procfs and enable it unconditionally.
With the ability to call pidfd_open() on tids we can now add a flag to
pidfd_send_signal() to signal to a specific thread capturing the
functionality of tgkill() and related thread-focused signal syscalls.

The desire to lift the restriction for pidfds on procfs has been expressed
by multiple people (cf. the commit message of commit
3eb39f47934f9d5a3027fe00d906a45fe3a15fad and [2]).

/* Signature */
int pidfd_open(pid_t pid, unsigned int flags);

/* pidfds are anon inode file descriptors */
These pidfds are allocated using anon_inode_getfd(), are O_CLOEXEC by
default and can be used with the pidfd_send_signal() syscall. They are not
dirfds and as such have the advantage that we can make them pollable or
readable in the future if we see a need to do so. The pidfds are not
associated with a specific pid namespaces but rather only reference struct
pid of a given process in their private_data member.
Additionally, Andy made an argument that we should go forward with
non-proc-dirfd file descriptors for the sake of security and extensibility
(cf. [3]). This will unblock or help move along work on pidfd_wait which
is currently ongoing.

/* Process Metadata Access */
One of the oustanding issues has been how to get information about a given
process if pidfds are regular file descriptors and do not provide access to
the process /proc/<pid> directory.
Various solutions have been proposed. The one that most people prefer is to
be able to retrieve a file descriptor to /proc/<pid> based on a pidfd
(cf. [5]). The prefered solution for how to do this has been to implement
an ioctl that for pidfds that translates a pidfd into a dirfd for
/proc/<pid>. This has been implemented in this patchset as well. If
PIDFD_GET_PROCFD is passed as a command to an ioctl() taking a pidfd and an
fd referring to a procfs directory as an argument a corresponding dirfd to
/proc/<pid> can be retrieved.
The ioctl() makes very sure that the struct pid associated with the
/proc/<pid> fd is identical to the struct pid stashed in the pidfd. This
ensures that we avoid pid recycling issues.

/* Example */
int pidfd = pidfd_open(1234, 0);
int procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
int procpidfd = ioctl(pidfd, PIDFD_GET_PROCFD, procfd);
int statusfd = openat(procpidfd, "status", O_RDONLY | O_CLOEXEC);
int ret = read(statusfd, buf, sizeof(buf));
ret = pidfd_send_signal(pidfd, SIGKILL, NULL, 0);

/* References */
[1]: https://lore.kernel.org/lkml/20181228233725.722tdfgijxcssg76@brauner.io/
[2]: https://lore.kernel.org/lkml/20190320203910.GA2842@avx2/
[3]: https://lore.kernel.org/lkml/CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com
[4]: https://lore.kernel.org/lkml/CAHk-=wgmKZm-fESEiLq_W37sKpqCY89nQkPNfWhvF_CQ1ANgcw@mail.gmail.com
[5]: https://lore.kernel.org/lkml/533075A9-A6CF-4549-AFC8-B90505B198FD@joelfernandes.org

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/pid.h                    |   2 +
 include/linux/syscalls.h               |   1 +
 include/uapi/linux/wait.h              |   2 +
 kernel/pid.c                           | 181 +++++++++++++++++++++++++
 6 files changed, 188 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1f9607ed087c..c8046f261bee 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -433,3 +433,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 92ee0b4378d4..f714a3d57b88 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	pidfd_open		__x64_sys_pidfd_open
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/pid.h b/include/linux/pid.h
index b6f4ba16065a..3c8ef5a199ca 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -66,6 +66,8 @@ struct pid
 
 extern struct pid init_struct_pid;
 
+extern const struct file_operations pidfd_fops;
+
 static inline struct pid *get_pid(struct pid *pid)
 {
 	if (pid)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e446806a561f..117463673fb5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -929,6 +929,7 @@ asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
 				struct old_timex32 __user *tx);
 asmlinkage long sys_syncfs(int fd);
 asmlinkage long sys_setns(int fd, int nstype);
+asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
 asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
 			     unsigned int vlen, unsigned flags);
 asmlinkage long sys_process_vm_readv(pid_t pid,
diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
index ac49a220cf2a..d6c7c0701997 100644
--- a/include/uapi/linux/wait.h
+++ b/include/uapi/linux/wait.h
@@ -18,5 +18,7 @@
 #define P_PID		1
 #define P_PGID		2
 
+/* Get a file descriptor for /proc/<pid> of the corresponding pidfd */
+#define PIDFD_GET_PROCFD _IOR('p', 1, int)
 
 #endif /* _UAPI_LINUX_WAIT_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..8c9e15e0e463 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -26,8 +26,10 @@
  *
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/mm.h>
 #include <linux/export.h>
+#include <linux/fsnotify.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rculist.h>
@@ -40,6 +42,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <linux/wait.h>
 
 struct pid init_struct_pid = {
 	.count 		= ATOMIC_INIT(1),
@@ -451,6 +454,184 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 	return idr_get_next(&ns->idr, &nr);
 }
 
+#ifdef CONFIG_PROC_FS
+static struct pid_namespace *pidfd_get_proc_pid_ns(const struct file *file)
+{
+	struct inode *inode;
+	struct super_block *sb;
+
+	inode = file_inode(file);
+	sb = inode->i_sb;
+	if (sb->s_magic != PROC_SUPER_MAGIC)
+		return ERR_PTR(-EINVAL);
+
+	if (inode->i_ino != PROC_ROOT_INO)
+		return ERR_PTR(-EINVAL);
+
+	return get_pid_ns(inode->i_sb->s_fs_info);
+}
+
+static struct pid *pidfd_get_pid(const struct file *file)
+{
+	if (file->f_op != &pidfd_fops)
+		return ERR_PTR(-EINVAL);
+
+	return get_pid(file->private_data);
+}
+
+static struct file *pidfd_open_proc_pid(const struct file *procf, pid_t pid,
+					const struct pid *pidfd_pid)
+{
+	char name[12]; /* int to strlen + \0 but with */
+	struct file *file;
+	struct pid *proc_pid;
+
+	snprintf(name, sizeof(name), "%d", pid);
+	file = file_open_root(procf->f_path.dentry, procf->f_path.mnt, name,
+			      O_DIRECTORY | O_RDONLY | O_NOFOLLOW, 0);
+	if (IS_ERR(file))
+		return file;
+
+	proc_pid = tgid_pidfd_to_pid(file);
+	if (IS_ERR(proc_pid)) {
+		filp_close(file, NULL);
+		return ERR_CAST(proc_pid);
+	}
+
+	if (pidfd_pid != proc_pid) {
+		filp_close(file, NULL);
+		return ERR_PTR(-ESRCH);
+	}
+
+	return file;
+}
+
+static inline int pidfd_to_procfd(int procfd, struct file *pidfd_file)
+{
+	long fd;
+	pid_t ns_pid;
+	struct fd fdproc;
+	struct file *file = NULL;
+	struct pid *pidfd_pid = NULL;
+	struct pid_namespace *proc_pid_ns = NULL;
+
+	fdproc = fdget(procfd);
+	if (!fdproc.file)
+		return -EBADF;
+
+	proc_pid_ns = pidfd_get_proc_pid_ns(fdproc.file);
+	if (IS_ERR(proc_pid_ns)) {
+		fd = PTR_ERR(proc_pid_ns);
+		proc_pid_ns = NULL;
+		goto err;
+	}
+
+	pidfd_pid = pidfd_get_pid(pidfd_file);
+	if (IS_ERR(pidfd_pid)) {
+		fd = PTR_ERR(pidfd_pid);
+		pidfd_pid = NULL;
+		goto err;
+	}
+
+	ns_pid = pid_nr_ns(pidfd_pid, proc_pid_ns);
+	if (!ns_pid) {
+		fd = -ESRCH;
+		goto err;
+	}
+
+	file = pidfd_open_proc_pid(fdproc.file, ns_pid, pidfd_pid);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		file = NULL;
+		goto err;
+	}
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0)
+		goto err;
+
+	fsnotify_open(file);
+	fd_install(fd, file);
+	file = NULL;
+
+err:
+	fdput(fdproc);
+	if (proc_pid_ns)
+		put_pid_ns(proc_pid_ns);
+	put_pid(pidfd_pid);
+	if (file)
+		filp_close(file, NULL);
+
+	return fd;
+}
+#else
+static inline int pidfd_to_procfd(int procfd, struct file *pidfd_file)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PROC_FS */
+
+static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int procfd = arg;
+
+	switch (cmd) {
+	case PIDFD_GET_PROCFD:
+		return pidfd_to_procfd(procfd, file);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int pidfd_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = file->private_data;
+
+	if (pid) {
+		file->private_data = NULL;
+		put_pid(pid);
+	}
+
+	return 0;
+}
+
+const struct file_operations pidfd_fops = {
+	.release = pidfd_release,
+	.unlocked_ioctl = pidfd_ioctl,
+};
+
+static int pidfd_create_fd_cloexec(pid_t pid)
+{
+	int fd;
+	struct pid *p;
+
+	p = find_get_pid(pid);
+	if (!p)
+		return -ESRCH;
+
+	fd = anon_inode_getfd("pidfd", &pidfd_fops, p, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		put_pid(p);
+
+	return fd;
+}
+
+/*
+ * pidfd_open - open a pidfd
+ * @pid:    pid for which to retrieve a pidfd
+ * @flags:  flags to pass
+ */
+SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
+{
+	if (flags)
+		return -EINVAL;
+
+	if (pid <= 0)
+		return -EINVAL;
+
+	return pidfd_create_fd_cloexec(pid);
+}
+
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
-- 
2.21.0

