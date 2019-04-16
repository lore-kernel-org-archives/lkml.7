Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA65C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ADA2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ESzyzH45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfDPRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:05:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32982 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfDPRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:05:00 -0400
Received: by mail-ua1-f65.google.com with SMTP id g8so6980077uaj.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUNsBiJl+4lFnjzgqa8G5zb1R0xs0aJk5cmyKoGPeds=;
        b=ESzyzH45itktg+LsRfaVNQmKjL8PaTjOETyqK4CvKY3K9qLrDt1mz1x7ODM34FabDC
         QqQHHfbfxJtNdUH+m0SUSBA/HchtchnTdYYWlwDQIFu6kJ5tpqrE48SItNN4BZRnY5jv
         JWLvQqwZnW7w3luiFm6B2yPXUj/DLWcydUXFN2ZqRrC75NzwVAEANgc40oBFnpaz+71/
         J1BairThzombfFc1CKNKxJc9tDyE6Iab5Al//eP13gFY3MP3UQ65iB24ulsz7pBfWjwZ
         B9TlI5bwggSMw/tET/tPCwcFbwXFfcACOpl5bneT/0siuiVZ0rRN/4KNmcaFTGNVQ/s/
         abSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUNsBiJl+4lFnjzgqa8G5zb1R0xs0aJk5cmyKoGPeds=;
        b=nj5dOiUWO5oBFoWNBunN4YtanRNZ2C4mzL1htNrz2uv+BbbxD6AmhRzFEsVYXTKqWr
         3Urcd/Zqw8M5nloh4UG2XhoVLX/HD7lZ7eqsQCyZj4/kb+LESR9uJL7UTry6dUkXxWep
         u6RDY/0aj+adjX5upOtEpt4OnISFBBAZZDowJ8xLz4FYCP+weGmBKUnPoCp1Qub61HpM
         WVlY/h2KFt2F3Y3/txA81Iy9cej4eJntZ1dR6Kox9adzPdmkRaITrT/U81EPyjfWd40v
         XHzJrC64SQ7dOH811j29zu+wxH1ucWDCDcaWJwi0DEICuEgHElZjy2uk+BHK9k+LT45v
         lDng==
X-Gm-Message-State: APjAAAUN4Ba9LbPXQuMDau2W1EaLgtWQz7q3z6QJuUbaMK2j8Mbfu7Yf
        un6x+YkaUg/n/GSW2MI0ihX5VA==
X-Google-Smtp-Source: APXvYqzZCvFj9bFwhLj//mai+Ai5eJf4HQnpGGAKaezY/Puk4j3Jfv34CVxNnXifQbIdymSkIG1OQA==
X-Received: by 2002:ab0:1591:: with SMTP id i17mr41878641uae.41.1555434298473;
        Tue, 16 Apr 2019 10:04:58 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
        by smtp.gmail.com with ESMTPSA id c192sm45178368vka.10.2019.04.16.10.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:04:57 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/4] clone: add CLONE_PIDFD
Date:   Tue, 16 Apr 2019 19:02:31 +0200
Message-Id: <20190416170233.10208-3-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416170233.10208-1-christian@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset makes it possible to retrieve pid file descriptors at process
creation time by introducing the new flag CLONE_PIDFD to the clone() system
call. Linus originally suggested to implement this as a new flag to clone()
instead of making it a separate system call. As spotted by Linus, there is
exactly one bit for clone() left.

CLONE_PIDFD creates file descriptors based on the anonymous inode
implementation in the kernel that will also be used to implement the new
mount api. They serve as a simple opaque handle on pids. Logically, this
makes it possible to interpret a pidfd differently, narrowing or widening
the scope of various operations (e.g. signal sending). Thus, a pidfd cannot
just refer to a tgid, but also a tid, or in theory - given appropriate flag
arguments in relevant syscalls - a process group or session. A pidfd does
not represent a privilege. This does not imply it cannot ever be that way
but for now this is not the case.

A pidfd comes with additional information in fdinfo if the kernel supports
procfs. The fdinfo file contains the pid of the process in the callers pid
namespace in the same format as the procfs status file, i.e. "Pid:\t%d".

As suggested by Oleg, with CLONE_PIDFD the pidfd is returned in the fourth
argument of clone. This has the advantage that we can give back the
associated pid and the pidfd at the same time.

To remove worries about missing metadata access this patchset comes with a
sample program that illustrates how a combination of CLONE_PIDFD, and
pidfd_send_signal() can be used to gain race-free access to process
metadata through /proc/<pid>. The sample program can easily be translated
into a helper that would be suitable for inclusion in libc so that users
don't have to worry about writing it themselves.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Jann Horn <jann@thejh.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
/* changelog */
v1:
- Oleg Nesterov <oleg@redhat.com>:
  - return pidfd in fourth argument of clone
    This way we can return the pid and the pidfd at the same time to the
    caller and can also start pid file descriptor numbering at 0 as is
    customary for file descriptors.
- Christian Brauner <christian@brauner.io>:
  - update comments to reflect changes based on Oleg's idea
---
 include/linux/pid.h        |   2 +
 include/uapi/linux/sched.h |   1 +
 kernel/fork.c              | 121 +++++++++++++++++++++++++++++++++++--
 3 files changed, 120 insertions(+), 4 deletions(-)

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
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..ed4ee170bee2 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -10,6 +10,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b..8eab00cc9c37 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -11,6 +11,7 @@
  * management can be a bitch. See 'mm/memory.c': 'copy_page_range()'
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
@@ -21,8 +22,10 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/seq_file.h>
 #include <linux/rtmutex.h>
 #include <linux/init.h>
+#include <linux/fsnotify.h>
 #include <linux/unistd.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
@@ -1662,6 +1665,81 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 }
 
+static int pidfd_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = file->private_data;
+
+	file->private_data = NULL;
+	put_pid(pid);
+	return 0;
+}
+
+#ifdef CONFIG_PROC_FS
+static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
+	struct pid *pid = f->private_data;
+
+	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+	seq_putc(m, '\n');
+}
+#endif
+
+const struct file_operations pidfd_fops = {
+	.release = pidfd_release,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = pidfd_show_fdinfo,
+#endif
+};
+
+/**
+ * pidfd_create() - Create a new pid file descriptor.
+ *
+ * @pid:  struct pid that the pidfd will reference
+ * @file: struct file referencing @pid to return to caller
+ *
+ * This creates a new pid file descriptor with the O_CLOEXEC flag set.
+ *
+ * Note, that this function can only be called after the fd table has
+ * been unshared to avoid leaking the pidfd to the new process.
+ *
+ * Return: On success, a cloexec pidfd ready to be installed through
+ *         fd_install() will be returned. The corresponding file will be
+ *         returned through @file.
+ *         On error, a negative errno number will be returned.
+ */
+static int pidfd_create(struct pid *pid, struct file **file)
+{
+	unsigned int flags = O_RDWR | O_CLOEXEC;
+	int error, fd;
+	struct file *f;
+
+	error = get_unused_fd_flags(flags);
+	if (error < 0)
+		return error;
+	fd = error;
+
+	f = anon_inode_getfile("pidfd", &pidfd_fops, get_pid(pid), flags);
+	if (IS_ERR(f)) {
+		put_pid(pid);
+		error = PTR_ERR(f);
+		goto err_put_unused_fd;
+	}
+
+	*file = f;
+	return fd;
+
+err_put_unused_fd:
+	put_unused_fd(fd);
+	return error;
+}
+
+static inline void pidfd_put(int fd, struct file *file)
+{
+	put_unused_fd(fd);
+	fput(file);
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -1674,15 +1752,17 @@ static __latent_entropy struct task_struct *copy_process(
 					unsigned long clone_flags,
 					unsigned long stack_start,
 					unsigned long stack_size,
+					int __user *parent_tidptr,
 					int __user *child_tidptr,
 					struct pid *pid,
 					int trace,
 					unsigned long tls,
 					int node)
 {
-	int retval;
+	int pidfd = -1, retval;
 	struct task_struct *p;
 	struct multiprocess_signals delayed;
+	struct file *pidfdf = NULL;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1730,6 +1810,19 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	/* Pidfds will be returned through parent_tidptr. */
+	if ((clone_flags & (CLONE_PIDFD | CLONE_PARENT_SETTID)) ==
+	    (CLONE_PIDFD | CLONE_PARENT_SETTID))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Ensure that we can potentially reuse CLONE_DETACHED for
+	 * CLONE_PIDFD in the future.
+	 */
+	if ((clone_flags & (CLONE_PIDFD | CLONE_DETACHED)) ==
+	    (CLONE_PIDFD | CLONE_DETACHED))
+		return ERR_PTR(-EINVAL);
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -1936,6 +2029,18 @@ static __latent_entropy struct task_struct *copy_process(
 		}
 	}
 
+	/*
+	 * This has to happen after we've potentially unshared the file
+	 * descriptor table (so that the pidfd doesn't leak into the child
+	 * if the fd table isn't shared).
+	 */
+	if (clone_flags & CLONE_PIDFD) {
+		retval = pidfd_create(pid, &pidfdf);
+		if (retval < 0)
+			goto bad_fork_free_pid;
+		pidfd = retval;
+	}
+
 #ifdef CONFIG_BLOCK
 	p->plug = NULL;
 #endif
@@ -1996,7 +2101,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	retval = cgroup_can_fork(p);
 	if (retval)
-		goto bad_fork_free_pid;
+		goto bad_fork_put_pidfd;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2097,6 +2202,11 @@ static __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
+	if (clone_flags & CLONE_PIDFD) {
+		fd_install(pidfd, pidfdf);
+		put_user(pidfd, parent_tidptr);
+	}
+
 	proc_fork_connector(p);
 	cgroup_post_fork(p);
 	cgroup_threadgroup_change_end(current);
@@ -2111,6 +2221,9 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p);
+bad_fork_put_pidfd:
+	if (clone_flags & CLONE_PIDFD)
+		pidfd_put(pidfd, pidfdf);
 bad_fork_free_pid:
 	cgroup_threadgroup_change_end(current);
 	if (pid != &init_struct_pid)
@@ -2176,7 +2289,7 @@ static inline void init_idle_pids(struct task_struct *idle)
 struct task_struct *fork_idle(int cpu)
 {
 	struct task_struct *task;
-	task = copy_process(CLONE_VM, 0, 0, NULL, &init_struct_pid, 0, 0,
+	task = copy_process(CLONE_VM, 0, 0, NULL, NULL, &init_struct_pid, 0, 0,
 			    cpu_to_node(cpu));
 	if (!IS_ERR(task)) {
 		init_idle_pids(task);
@@ -2223,7 +2336,7 @@ long _do_fork(unsigned long clone_flags,
 			trace = 0;
 	}
 
-	p = copy_process(clone_flags, stack_start, stack_size,
+	p = copy_process(clone_flags, stack_start, stack_size, parent_tidptr,
 			 child_tidptr, NULL, trace, tls, NUMA_NO_NODE);
 	add_latent_entropy();
 
-- 
2.21.0

