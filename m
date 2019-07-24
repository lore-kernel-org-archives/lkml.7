Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41FB21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RkIECN6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfGXOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:47:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46588 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGXOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:47:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so22078934plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sU1zQBRTx+tjcZH3tpuIL4aXRbaDqB+lgEWHSSFsnfM=;
        b=RkIECN6zulgyHPa4sHRBBZ6otRBiKjdl3fjHramc9JSt2tYgv5wNIG8UwPstGvwR2q
         mVBSqLH3Is4Ih8yEiFgdYLIhgSmwAd4yHvbY74z5HxcHfSOtnJA8HRJ3ra2qnIUlVJtw
         RZzuj3G0XbgYSxvely4SeE6bqVyve6N+6Cgqs7AD1qRuJvEI+aSUA0jHrtm5qEw3r3Ya
         nj1L76nyOH67Tq+3MRb6KGdViGLHVg8rt8a+aF26wodmjjaJ4PUXdjEfH0E+QDvLVB0Y
         zynDzP8R0Zupb1MmcEQKGw9EDYQikpmbKlTHQZhkEZHjkGFECl1OrHTljdZxt7yCRGC9
         Xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sU1zQBRTx+tjcZH3tpuIL4aXRbaDqB+lgEWHSSFsnfM=;
        b=cIFLRRR3bWTqV+gfH/rKMBqjcDUaVxzKCGddnJrIrsNW9jcl2ML3ggpTBgJr/z0h+R
         D9kJOncjS28Owx4QHUbnXiCaliAif+BrpnrB82uvMuS60/KvzaE3gJtlj9lIrxHuAyfl
         IaS/UPUJEityrAjHdzYs6ScpA5bews04LH+5WRcCsSYdwvj1z6yZfge+ZQg1+yQSouXC
         s0RMHZnB5zSEy7tsJyIZ6UUzmdxl/gnLH0sjzzr2+sCrf3y/42TpjuQM5hklGITn+yLR
         bcla6RgKv0/r7Nae8P7P9vwzBZ+jcgrVAFBpuGWLY9KUuPjeFESR7O1VRnyyC3adkc7l
         fmuQ==
X-Gm-Message-State: APjAAAXGhUh1fEMRega5OzArf0UC71HSSML6VR4D5Z4H37eQFHJVa9dh
        qLsU+VQkAB0xwOKtIXKa6Q4T8IgUf8s=
X-Google-Smtp-Source: APXvYqxlXJn/yA8+MvE0jo1xNoxNr67K1BCIacvUaJw/FtVUS48EiQMhdCpebwdV5Hsf1sHUs7zmMQ==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr84460244plb.135.1563979658986;
        Wed, 24 Jul 2019 07:47:38 -0700 (PDT)
Received: from localhost.localdomain ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g6sm41125644pgh.64.2019.07.24.07.47.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:47:38 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org
Subject: [PATCH 2/5] pidfd: add pidfd_wait()
Date:   Wed, 24 Jul 2019 16:46:48 +0200
Message-Id: <20190724144651.28272-3-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724144651.28272-1-christian@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the pidfd_wait() syscall.

One of the last remaining bits for the pidfd api is to make it possible
to wait on pidfds. With this syscall implemented parts of userspace that
want to use this api can finally switch to managing processes completely
through pidfds if they so desire (cf. [1]).

The pidfd_wait() syscall does not allow scoping of the process
identified by the pidfd, i.e. it explicitly does not try to mirror the
behavior of: wait4(-1), wait4(0), waitid(P_ALL), waitid(P_PGID) etc. It
only allows for semantics equivalent to wait4(pid), waitid(P_PID). Users
that need scoping should rely on pid-based wait*() syscalls for now.

pidfd_wait() allows to specify which changes to wait for. The states to
wait for can be or-ed and are specified in the states argument:
	WEXITED		Wait for children that have terminated.
	WSTOPPED	Wait for children that have been stopped by
			delivery of a signal.
	WCONTINUED	Wait for (previously stopped) children that have
			been resumed by delivery of SIGCONT.
	WUNTRACED	Return if a child has stopped.

The behavior of pidfd_wait() can be further modified by specifying the
following or-able options in the flags argument:
	__WCLONE	Only wait for a process that delivers no signal
			or a different signal than SIGCHLD to the parent
			on termination.
	__WALL		Wait for all children indepedent of whether or
			not they deliver no signal or another signal
			than SIGCHLD to the parent on termination.
			parent
	__WNOTHREAD	Do not wait for children of other threads in the
			same thread-group.
	WNOHANG		Return immediately if no child has exited.
	WNOWAIT		Leave the child in a waitable state.

pidfd_wait() takes an additional siginfo_t argument. If it is non-NULL,
pidfd_wait() will fill in si_pid, si_uid, si_signo, si_status, and
si_code. The si_code field will be set to one of CLD_EXITED, CLD_KILLED,
CLD_DUMPED, CLD_STOPPED, CLD_TRAPPED, or CLD_CONTINUED.
Information about resource usage of the process in question is returned
in the struct rusage argument of pidfd_wait().

On success, pidfd_wait() will return the pid of the process the pidfd
referred to. On failure, a negative error code will be returned.

/* Prior approach */
The first implementation was based on a flag WPIDFD which got added to
the wait*() system calls. However, that involved passing the pidfd
through the pid_t pid argument and do in-kernel type switching based on
the flag which feels like a really unclean solution and overall like a
mishmash of two apis. This is something we luckily have avoided so far
and I think we're better off in the long run if we keep it that way.

/* References */
[1]: https://github.com/systemd/systemd/issues/13101

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-api@vger.kernel.org
---
 include/linux/pid.h |  5 +++
 kernel/exit.c       | 87 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c       |  8 +++++
 kernel/signal.c     |  7 ++--
 4 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 2a83e434db9d..443cd4108943 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -72,6 +72,11 @@ extern struct pid init_struct_pid;
 
 extern const struct file_operations pidfd_fops;
 
+struct file;
+
+extern struct pid *pidfd_pid(const struct file *file);
+
+
 static inline struct pid *get_pid(struct pid *pid)
 {
 	if (pid)
diff --git a/kernel/exit.c b/kernel/exit.c
index 73392a455b72..8086c76e1959 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1738,3 +1738,90 @@ __weak void abort(void)
 	panic("Oops failed to kill thread");
 }
 EXPORT_SYMBOL(abort);
+
+static int copy_rusage_to_user_any(struct rusage *kru, struct rusage __user *ru)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return put_compat_rusage(kru, (struct compat_rusage __user *)ru);
+#endif
+	return copy_to_user(ru, kru, sizeof(*kru));
+}
+
+static int copy_siginfo_to_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return copy_siginfo_to_user32(
+			(struct compat_siginfo __user *)info, kinfo);
+#endif
+	return copy_siginfo_to_user(info, kinfo);
+}
+
+SYSCALL_DEFINE6(pidfd_wait, int, pidfd, int __user *, stat_addr,
+		siginfo_t __user *, info, struct rusage __user *, ru,
+		unsigned int, states, unsigned int, flags)
+{
+	long ret;
+	struct fd f;
+	struct pid *pid;
+	struct wait_opts wo;
+	struct rusage kru = {};
+	kernel_siginfo_t kinfo = {
+		.si_signo = 0,
+	};
+
+	if (pidfd < 0)
+		return -EINVAL;
+
+	if (states & ~(WEXITED | WSTOPPED | WCONTINUED | WUNTRACED))
+		return -EINVAL;
+
+	if (!(states & (WEXITED | WSTOPPED | WCONTINUED | WUNTRACED)))
+		return -EINVAL;
+
+	if (flags & ~(__WNOTHREAD | __WCLONE | __WALL | WNOWAIT | WNOHANG))
+		return -EINVAL;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_pid(f.file);
+	if (IS_ERR(pid)) {
+		ret = PTR_ERR(pid);
+		goto out_fdput;
+	}
+
+	wo = (struct wait_opts){
+		.wo_type	= PIDTYPE_PID,
+		.wo_pid		= pid,
+		.wo_flags	= states | flags,
+		.wo_info	= info ? &kinfo : NULL,
+		.wo_rusage	= ru ? &kru : NULL,
+	};
+
+	ret = do_wait(&wo);
+	if (ret > 0) {
+		kinfo.si_signo = SIGCHLD;
+
+		if (stat_addr && put_user(wo.wo_stat, stat_addr)) {
+			ret = -EFAULT;
+			goto out_fdput;
+		}
+
+		if (ru && copy_rusage_to_user_any(&kru, ru)) {
+			ret = -EFAULT;
+			goto out_fdput;
+		}
+	} else {
+		kinfo.si_signo = 0;
+	}
+
+	if (info && copy_siginfo_to_user_any(&kinfo, info))
+		ret = -EFAULT;
+
+out_fdput:
+	fdput(f);
+	return ret;
+}
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..baaff6570517 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1743,6 +1743,14 @@ const struct file_operations pidfd_fops = {
 #endif
 };
 
+struct pid *pidfd_pid(const struct file *file)
+{
+	if (file->f_op == &pidfd_fops)
+		return file->private_data;
+
+	return ERR_PTR(-EBADF);
+}
+
 static void __delayed_free_task(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
diff --git a/kernel/signal.c b/kernel/signal.c
index 91b789dd6e72..2e567f64812f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3672,8 +3672,11 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
 
 static struct pid *pidfd_to_pid(const struct file *file)
 {
-	if (file->f_op == &pidfd_fops)
-		return file->private_data;
+	struct pid *pid;
+
+	pid = pidfd_pid(file);
+	if (!IS_ERR(pid))
+		return pid;
 
 	return tgid_pidfd_to_pid(file);
 }
-- 
2.22.0

