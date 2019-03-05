Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C312064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S5LIMiQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCERN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:13:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43448 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCERN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:13:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so10333905wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0S7jnLKUDH4QMUioFL5K56iQIdgyBNjS6nQWSu80FsQ=;
        b=S5LIMiQ9r0V4Icb+3y4BzhwbdNiNyUe5zitrZhnZwprzfNZseYW9sh8SJD6hgPRu6R
         HNHLdaDsH1OhOjuEPLLaw8nhoiYzlxc0CTmSuAsYjPdE86O7yKuzTh39P6cgzJ6QeXae
         n4ztZoLHYca4xkksmKItV5A7IUWL4UTXBGq3Mq8vvU9xXSIjMW16vbo+lUh4IqMz3fZe
         CFTVQkztyHSLh/E/9Pc1fnFAeBszHmxZpjJgCTqYRqx3iDL/mr9h0X2z8x1sVvNQUynH
         HGfejBUUBpkicSzjTUjxzdFGWnrMvjaUZiE31QFcMwXmn22YVs/hAn/bY2U9CIAPshSM
         Yq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0S7jnLKUDH4QMUioFL5K56iQIdgyBNjS6nQWSu80FsQ=;
        b=mf5nJg5WsWn/xslc5z3xi9jndrFhgRGJo3nVFTOG21qgb/nut+sWU65XANAfQnZzdL
         PmthVR/bb+zAhPFYhrHc3HXcykQjAe3kl3N2amHBKCsnW+6LbJjV2lWUN4ziLWrU2bEm
         pnXcLbfwqCHcgWoiLtgzuSzzLRh6VSYCnHu5Seg/YuUd4zstIKQjFJG1F9yJx8EGwMT/
         BUG0Mmjjw9bAfIatGylsASH6PYqlJd8+B2P31SfUmV47DFWKChFUxh5ngXpDXIO43gjs
         VBLKTD1soGswb/zsv1MpY7tuCx3dECXcQfUhlYsYykT3uGB4cRnJClJEaP4LFx9wR9vo
         wRQQ==
X-Gm-Message-State: APjAAAXBHjYWVWG2FE+T56bJgToQlNqWoSnssfqCblRl0XEtB8IYm8fp
        ObOwzup6E/oQTmUmzHHS0NwRKA==
X-Google-Smtp-Source: APXvYqwtaBOOkwSAyhvbaCDcre/tWsgVx/Bj0dvm55mYMk9S+8YUSV630cwvk/YBJLEt4QBnbvyLqQ==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr17929045wrv.239.1551806033377;
        Tue, 05 Mar 2019 09:13:53 -0800 (PST)
Received: from localhost.localdomain ([81.92.17.132])
        by smtp.gmail.com with ESMTPSA id n6sm10688715wrt.23.2019.03.05.09.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:13:52 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, arnd@arndb.de
Cc:     Christian Brauner <christian@brauner.io>
Subject: [GIT PULL] pidfd patches for v5.1-rc1
Date:   Tue,  5 Mar 2019 18:13:01 +0100
Message-Id: <20190305171301.23147-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is the pull request for the pidfd_send_signal() syscall. The
patchset uses file descriptors (fd) from proc/<pid> as stable handles on
struct pid. Even if a pid is recycled the handle will not change. The fd
can be used to send signals to the process it refers to.

The patchset fixes a long-standing issue where after a process has
exited its pid can be reused by another process. If a caller sends a
signal to a reused pid it will end up signaling the wrong process.

The patchset has been sitting in linux-next for quite a while and has
not caused any issues. It comes with selftests to verify that it works
as expected.
The new syscall uses number 424 because Arnd and I aligned the patchset
with his y2038 and syscall numbering rework to minimize conflicts in the
linux-next tree and during merging.

At the beginning of last merge cycle it was suggested to move this
patchset into a separate tree on kernel.org as there will be more work
coming that will be dealing with using file descriptors for processes.

The pidfd tree is already tracked in linux-next since the beginning of
the 5.0 development cycle and I'm prepared to deal with any fallouts
coming from this work going forward.

The only thing that has changed recently in these patches was the
addition of two more Acked-by/Reviewed-by by David Howells and tglx
after the last round of reviews.
Since the patch including the selftest is not very large so I included
the full diff here.

This is the first direct pr I had to send so I hope I didn't make any
horrible mistakes.

Thanks!
Christian

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git tags/pidfd-v5.1-rc1

for you to fetch changes up to 575a0ae9744d571f7c6aae4487a05850baae9e1c:

  selftests: add tests for pidfd_send_signal() (2019-03-05 17:04:33 +0100)

----------------------------------------------------------------
pidfd patches for v5.1-rc1

----------------------------------------------------------------
Christian Brauner (2):
      signal: add pidfd_send_signal() syscall
      selftests: add tests for pidfd_send_signal()

 arch/x86/entry/syscalls/syscall_32.tbl     |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl     |   1 +
 fs/proc/base.c                             |   9 +
 include/linux/proc_fs.h                    |   6 +
 include/linux/syscalls.h                   |   3 +
 include/uapi/asm-generic/unistd.h          |   4 +-
 kernel/signal.c                            | 133 +++++++++-
 kernel/sys_ni.c                            |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/pidfd/Makefile     |   6 +
 tools/testing/selftests/pidfd/pidfd_test.c | 381 +++++++++++++++++++++++++++++
 11 files changed, 539 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/Makefile
 create mode 100644 tools/testing/selftests/pidfd/pidfd_test.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..234d91df8ca6 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,3 +398,4 @@
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq			__ia32_sys_rseq
+424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..58f4b3ad4fe0 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,7 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 633a63462573..b6627c471078 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3046,6 +3046,15 @@ static const struct file_operations proc_tgid_base_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+struct pid *tgid_pidfd_to_pid(const struct file *file)
+{
+	if (!d_is_dir(file->f_path.dentry) ||
+	    (file->f_op != &proc_tgid_base_operations))
+		return ERR_PTR(-EBADF);
+
+	return proc_pid(file_inode(file));
+}
+
 static struct dentry *proc_tgid_base_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	return proc_pident_lookup(dir, dentry,
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index d0e1f1522a78..52a283ba0465 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -73,6 +73,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 						    int (*show)(struct seq_file *, void *),
 						    proc_write_t write,
 						    void *data);
+extern struct pid *tgid_pidfd_to_pid(const struct file *file);
 
 #else /* CONFIG_PROC_FS */
 
@@ -114,6 +115,11 @@ static inline int remove_proc_subtree(const char *name, struct proc_dir_entry *p
 #define proc_create_net(name, mode, parent, state_size, ops) ({NULL;})
 #define proc_create_net_single(name, mode, parent, show, data) ({NULL;})
 
+static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
+{
+	return ERR_PTR(-EBADF);
+}
+
 #endif /* CONFIG_PROC_FS */
 
 struct net;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 257cccba3062..5eb2e351675e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -926,6 +926,9 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
+				       siginfo_t __user *info,
+				       unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d90127298f12..c861e7d1053b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,9 +740,11 @@ __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 425
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..268bed80244f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -19,7 +19,9 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/proc_fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/coredump.h>
@@ -3429,6 +3431,16 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 #endif
 #endif
 
+static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
+{
+	clear_siginfo(info);
+	info->si_signo = sig;
+	info->si_errno = 0;
+	info->si_code = SI_USER;
+	info->si_pid = task_tgid_vnr(current);
+	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
+}
+
 /**
  *  sys_kill - send a signal to a process
  *  @pid: the PID of the process
@@ -3438,16 +3450,125 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
 	struct kernel_siginfo info;
 
-	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_USER;
-	info.si_pid = task_tgid_vnr(current);
-	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
+	prepare_kill_siginfo(sig, &info);
 
 	return kill_something_info(sig, &info, pid);
 }
 
+#ifdef CONFIG_PROC_FS
+/*
+ * Verify that the signaler and signalee either are in the same pid namespace
+ * or that the signaler's pid namespace is an ancestor of the signalee's pid
+ * namespace.
+ */
+static bool access_pidfd_pidns(struct pid *pid)
+{
+	struct pid_namespace *active = task_active_pid_ns(current);
+	struct pid_namespace *p = ns_of_pid(pid);
+
+	for (;;) {
+		if (!p)
+			return false;
+		if (p == active)
+			break;
+		p = p->parent;
+	}
+
+	return true;
+}
+
+static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
+{
+#ifdef CONFIG_COMPAT
+	/*
+	 * Avoid hooking up compat syscalls and instead handle necessary
+	 * conversions here. Note, this is a stop-gap measure and should not be
+	 * considered a generic solution.
+	 */
+	if (in_compat_syscall())
+		return copy_siginfo_from_user32(
+			kinfo, (struct compat_siginfo __user *)info);
+#endif
+	return copy_siginfo_from_user(kinfo, info);
+}
+
+/**
+ * sys_pidfd_send_signal - send a signal to a process through a task file
+ *                          descriptor
+ * @pidfd:  the file descriptor of the process
+ * @sig:    signal to be sent
+ * @info:   the signal info
+ * @flags:  future flags to be passed
+ *
+ * The syscall currently only signals via PIDTYPE_PID which covers
+ * kill(<positive-pid>, <signal>. It does not signal threads or process
+ * groups.
+ * In order to extend the syscall to threads and process groups the @flags
+ * argument should be used. In essence, the @flags argument will determine
+ * what is signaled and not the file descriptor itself. Put in other words,
+ * grouping is a property of the flags argument not a property of the file
+ * descriptor.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
+		siginfo_t __user *, info, unsigned int, flags)
+{
+	int ret;
+	struct fd f;
+	struct pid *pid;
+	kernel_siginfo_t kinfo;
+
+	/* Enforce flags be set to 0 until we add an extension. */
+	if (flags)
+		return -EINVAL;
+
+	f = fdget_raw(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	/* Is this a pidfd? */
+	pid = tgid_pidfd_to_pid(f.file);
+	if (IS_ERR(pid)) {
+		ret = PTR_ERR(pid);
+		goto err;
+	}
+
+	ret = -EINVAL;
+	if (!access_pidfd_pidns(pid))
+		goto err;
+
+	if (info) {
+		ret = copy_siginfo_from_user_any(&kinfo, info);
+		if (unlikely(ret))
+			goto err;
+
+		ret = -EINVAL;
+		if (unlikely(sig != kinfo.si_signo))
+			goto err;
+
+		if ((task_pid(current) != pid) &&
+		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
+			/* Only allow sending arbitrary signals to yourself. */
+			ret = -EPERM;
+			if (kinfo.si_code != SI_USER)
+				goto err;
+
+			/* Turn this into a regular kill signal. */
+			prepare_kill_siginfo(sig, &kinfo);
+		}
+	} else {
+		prepare_kill_siginfo(sig, &kinfo);
+	}
+
+	ret = kill_pid_info(sig, &kinfo, pid);
+
+err:
+	fdput(f);
+	return ret;
+}
+#endif /* CONFIG_PROC_FS */
+
 static int
 do_send_specific(pid_t tgid, pid_t pid, int sig, struct kernel_siginfo *info)
 {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index ab9d0e3c6d50..f905f4f9f677 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -163,6 +163,7 @@ COND_SYSCALL(syslog);
 /* kernel/sched/core.c */
 
 /* kernel/signal.c */
+COND_SYSCALL(pidfd_send_signal);
 
 /* kernel/sys.c */
 COND_SYSCALL(setregid);
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1a2bd15c5b6e..cfbc3528e9ef 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -30,6 +30,7 @@ TARGETS += net
 TARGETS += netfilter
 TARGETS += networking/timestamping
 TARGETS += nsfs
+TARGETS += pidfd
 TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
new file mode 100644
index 000000000000..deaf8073bc06
--- /dev/null
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -0,0 +1,6 @@
+CFLAGS += -g -I../../../../usr/include/
+
+TEST_GEN_PROGS := pidfd_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
new file mode 100644
index 000000000000..d59378a93782
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -0,0 +1,381 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
+
+static int signal_received;
+
+static void set_signal_received_on_sigusr1(int sig)
+{
+	if (sig == SIGUSR1)
+		signal_received = 1;
+}
+
+/*
+ * Straightforward test to see whether pidfd_send_signal() works is to send
+ * a signal to ourself.
+ */
+static int test_pidfd_send_signal_simple_success(void)
+{
+	int pidfd, ret;
+	const char *test_name = "pidfd_send_signal send SIGUSR1";
+
+	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
+	if (pidfd < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to open process file descriptor\n",
+			test_name);
+
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
+	close(pidfd);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+				   test_name);
+
+	if (signal_received != 1)
+		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+				   test_name);
+
+	signal_received = 0;
+	ksft_test_result_pass("%s test: Sent signal\n", test_name);
+	return 0;
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (ret != pid)
+		goto again;
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static int test_pidfd_send_signal_exited_fail(void)
+{
+	int pidfd, ret, saved_errno;
+	char buf[256];
+	pid_t pid;
+	const char *test_name = "pidfd_send_signal signal exited process";
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: Failed to create new process\n",
+				   test_name);
+
+	if (pid == 0)
+		_exit(EXIT_SUCCESS);
+
+	snprintf(buf, sizeof(buf), "/proc/%d", pid);
+
+	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+
+	(void)wait_for_pid(pid);
+
+	if (pidfd < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to open process file descriptor\n",
+			test_name);
+
+	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
+	saved_errno = errno;
+	close(pidfd);
+	if (ret == 0)
+		ksft_exit_fail_msg(
+			"%s test: Managed to send signal to process even though it should have failed\n",
+			test_name);
+
+	if (saved_errno != ESRCH)
+		ksft_exit_fail_msg(
+			"%s test: Expected to receive ESRCH as errno value but received %d instead\n",
+			test_name, saved_errno);
+
+	ksft_test_result_pass("%s test: Failed to send signal as expected\n",
+			      test_name);
+	return 0;
+}
+
+/*
+ * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
+ * That means, when it wraps around any pid < 300 will be skipped.
+ * So we need to use a pid > 300 in order to test recycling.
+ */
+#define PID_RECYCLE 1000
+
+/*
+ * Maximum number of cycles we allow. This is equivalent to PID_MAX_DEFAULT.
+ * If users set a higher limit or we have cycled PIDFD_MAX_DEFAULT number of
+ * times then we skip the test to not go into an infinite loop or block for a
+ * long time.
+ */
+#define PIDFD_MAX_DEFAULT 0x8000
+
+/*
+ * Define a few custom error codes for the child process to clearly indicate
+ * what is happening. This way we can tell the difference between a system
+ * error, a test error, etc.
+ */
+#define PIDFD_PASS 0
+#define PIDFD_FAIL 1
+#define PIDFD_ERROR 2
+#define PIDFD_SKIP 3
+#define PIDFD_XFAIL 4
+
+static int test_pidfd_send_signal_recycled_pid_fail(void)
+{
+	int i, ret;
+	pid_t pid1;
+	const char *test_name = "pidfd_send_signal signal recycled pid";
+
+	ret = unshare(CLONE_NEWPID);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
+				   test_name);
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to unshare mount namespace\n",
+			test_name);
+
+	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to remount / private\n",
+				   test_name);
+
+	/* pid 1 in new pid namespace */
+	pid1 = fork();
+	if (pid1 < 0)
+		ksft_exit_fail_msg("%s test: Failed to create new process\n",
+				   test_name);
+
+	if (pid1 == 0) {
+		char buf[256];
+		pid_t pid2;
+		int pidfd = -1;
+
+		(void)umount2("/proc", MNT_DETACH);
+		ret = mount("proc", "/proc", "proc", 0, NULL);
+		if (ret < 0)
+			_exit(PIDFD_ERROR);
+
+		/* grab pid PID_RECYCLE */
+		for (i = 0; i <= PIDFD_MAX_DEFAULT; i++) {
+			pid2 = fork();
+			if (pid2 < 0)
+				_exit(PIDFD_ERROR);
+
+			if (pid2 == 0)
+				_exit(PIDFD_PASS);
+
+			if (pid2 == PID_RECYCLE) {
+				snprintf(buf, sizeof(buf), "/proc/%d", pid2);
+				ksft_print_msg("pid to recycle is %d\n", pid2);
+				pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+			}
+
+			if (wait_for_pid(pid2))
+				_exit(PIDFD_ERROR);
+
+			if (pid2 >= PID_RECYCLE)
+				break;
+		}
+
+		/*
+		 * We want to be as predictable as we can so if we haven't been
+		 * able to grab pid PID_RECYCLE skip the test.
+		 */
+		if (pid2 != PID_RECYCLE) {
+			/* skip test */
+			close(pidfd);
+			_exit(PIDFD_SKIP);
+		}
+
+		if (pidfd < 0)
+			_exit(PIDFD_ERROR);
+
+		for (i = 0; i <= PIDFD_MAX_DEFAULT; i++) {
+			char c;
+			int pipe_fds[2];
+			pid_t recycled_pid;
+			int child_ret = PIDFD_PASS;
+
+			ret = pipe2(pipe_fds, O_CLOEXEC);
+			if (ret < 0)
+				_exit(PIDFD_ERROR);
+
+			recycled_pid = fork();
+			if (recycled_pid < 0)
+				_exit(PIDFD_ERROR);
+
+			if (recycled_pid == 0) {
+				close(pipe_fds[1]);
+				(void)read(pipe_fds[0], &c, 1);
+				close(pipe_fds[0]);
+
+				_exit(PIDFD_PASS);
+			}
+
+			/*
+			 * Stop the child so we can inspect whether we have
+			 * recycled pid PID_RECYCLE.
+			 */
+			close(pipe_fds[0]);
+			ret = kill(recycled_pid, SIGSTOP);
+			close(pipe_fds[1]);
+			if (ret) {
+				(void)wait_for_pid(recycled_pid);
+				_exit(PIDFD_ERROR);
+			}
+
+			/*
+			 * We have recycled the pid. Try to signal it. This
+			 * needs to fail since this is a different process than
+			 * the one the pidfd refers to.
+			 */
+			if (recycled_pid == PID_RECYCLE) {
+				ret = sys_pidfd_send_signal(pidfd, SIGCONT,
+							    NULL, 0);
+				if (ret && errno == ESRCH)
+					child_ret = PIDFD_XFAIL;
+				else
+					child_ret = PIDFD_FAIL;
+			}
+
+			/* let the process move on */
+			ret = kill(recycled_pid, SIGCONT);
+			if (ret)
+				(void)kill(recycled_pid, SIGKILL);
+
+			if (wait_for_pid(recycled_pid))
+				_exit(PIDFD_ERROR);
+
+			switch (child_ret) {
+			case PIDFD_FAIL:
+				/* fallthrough */
+			case PIDFD_XFAIL:
+				_exit(child_ret);
+			case PIDFD_PASS:
+				break;
+			default:
+				/* not reached */
+				_exit(PIDFD_ERROR);
+			}
+
+			/*
+			 * If the user set a custom pid_max limit we could be
+			 * in the millions.
+			 * Skip the test in this case.
+			 */
+			if (recycled_pid > PIDFD_MAX_DEFAULT)
+				_exit(PIDFD_SKIP);
+		}
+
+		/* failed to recycle pid */
+		_exit(PIDFD_SKIP);
+	}
+
+	ret = wait_for_pid(pid1);
+	switch (ret) {
+	case PIDFD_FAIL:
+		ksft_exit_fail_msg(
+			"%s test: Managed to signal recycled pid %d\n",
+			test_name, PID_RECYCLE);
+	case PIDFD_PASS:
+		ksft_exit_fail_msg("%s test: Failed to recycle pid %d\n",
+				   test_name, PID_RECYCLE);
+	case PIDFD_SKIP:
+		ksft_print_msg("%s test: Skipping test\n", test_name);
+		ret = 0;
+		break;
+	case PIDFD_XFAIL:
+		ksft_test_result_pass(
+			"%s test: Failed to signal recycled pid as expected\n",
+			test_name);
+		ret = 0;
+		break;
+	default /* PIDFD_ERROR */:
+		ksft_exit_fail_msg("%s test: Error while running tests\n",
+				   test_name);
+	}
+
+	return ret;
+}
+
+static int test_pidfd_send_signal_syscall_support(void)
+{
+	int pidfd, ret;
+	const char *test_name = "pidfd_send_signal check for support";
+
+	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
+	if (pidfd < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to open process file descriptor\n",
+			test_name);
+
+	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
+	if (ret < 0) {
+		/*
+		 * pidfd_send_signal() will currently return ENOSYS when
+		 * CONFIG_PROC_FS is not set.
+		 */
+		if (errno == ENOSYS)
+			ksft_exit_skip(
+				"%s test: pidfd_send_signal() syscall not supported (Ensure that CONFIG_PROC_FS=y is set)\n",
+				test_name);
+
+		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+				   test_name);
+	}
+
+	close(pidfd);
+	ksft_test_result_pass(
+		"%s test: pidfd_send_signal() syscall is supported. Tests can be executed\n",
+		test_name);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+
+	test_pidfd_send_signal_syscall_support();
+	test_pidfd_send_signal_simple_success();
+	test_pidfd_send_signal_exited_fail();
+	test_pidfd_send_signal_recycled_pid_fail();
+
+	return ksft_exit_pass();
+}
