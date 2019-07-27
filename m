Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB55C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C232075C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="G8cccBDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfG0WZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 18:25:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34603 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfG0WZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 18:25:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so40363151wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JiU+PkLcgB5TLwD3d5ClQX3fePK6hIWHRUw//Hj7xQg=;
        b=G8cccBDLiZGqsD5yYf8N4xOEukBo+QNP+XkrkFxktAXyEkTVGNVI57KYJTOjUwfMqO
         r+5NnDflGeCLWhS3KAUdBefO0Ya4kj/NIH1HrFERKyo2RjS+/9jq+rxU8jtkQTxdZgvX
         cojUZ4AD5bGkLYys0RRDdJ4aDsgfkMlT9ADT35pEH8ej+KmhUW8T2pvFdu1lavMSnRi1
         mhWiQ0yPW5BTdH0Kl14Ef7jAGBx2g/VU6iYpH33DHvxHlKnZkt+GNU/qlcI5t3xQGJBs
         8NbSjlwQCaPofn1VY2ZkqxG3769jeKq3xRSUQFYTyH/VvOeSgyXX/CbmTXVfqa+HRtEm
         gQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiU+PkLcgB5TLwD3d5ClQX3fePK6hIWHRUw//Hj7xQg=;
        b=GK3ZwErppy9ROL9Zdy4pML2ig8sBF4lvJ6uZOh/AJxuXaUHq8Y2mPnrxhIKtzfW2xl
         dQSGHAYSq+agWYxdHTGRWZ9fLiBu6/Q17c/G0YlQ5CxQV0AoSqXTkq5gwy3hLR3f2Rkj
         g/hHIh/MXaGffQDVFsxieIqvDQfiuDo1lCKRPpTwoy2WiFvrpPGSHYI1v6Ny+oc+2FkQ
         NWYHzPqBSmqqvajJvuYNf2iCp/TSIYqkGNw+BsYGILkGFAnobRYTlYDCfSgwNCWgPU0v
         KIpaJVWXJg9e8lgeYPmiDCumXvmPQmwh2azaAikcs3KOeeEqoVPKrWrYFewhW3uWvtP+
         /TAw==
X-Gm-Message-State: APjAAAVAXQpN1N54v9+kxyWFVbwd2gKYKjuPYSt7HgxBVmYyXKLwQD2O
        ZvHtOQHD6D+4y5jrxl1w4Dmx3Pk+Y2U=
X-Google-Smtp-Source: APXvYqyU24ljcIN7zNry/hm6if4+V3WtmPfEMkdxHsfAUBga1neSf5DAr46Hrui6VpckxNUatVNupQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr95927568wmm.81.1564266319762;
        Sat, 27 Jul 2019 15:25:19 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id g8sm54978721wmf.17.2019.07.27.15.25.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 15:25:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 1/2] pidfd: add P_PIDFD to waitid()
Date:   Sun, 28 Jul 2019 00:22:29 +0200
Message-Id: <20190727222229.6516-2-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727222229.6516-1-christian@brauner.io>
References: <20190727222229.6516-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the P_PIDFD type to waitid().
One of the last remaining bits for the pidfd api is to make it possible
to wait on pidfds. With P_PIDFD added to waitid() the parts of userspace
that want to use the pidfd api to exclusively manage processes can do so
now.

One of the things this will unblock in the future is the ability to make
it possible to retrieve the exit status via waitid(P_PIDFD) for
non-parent processes if handed a _suitable_ pidfd that has this feature
set. This is similar to what you can do on FreeBSD with kqueue(). It
might even end up being possible to wait on a process as a non-parent if
an appropriate property is enabled on the pidfd.

With P_PIDFD no scoping of the process identified by the pidfd is
possible, i.e. it explicitly blocks things such as wait4(-1), wait4(0),
waitid(P_ALL), waitid(P_PGID) etc. It only allows for semantics
equivalent to wait4(pid), waitid(P_PID). Users that need scoping should
rely on pid-based wait*() syscalls for now.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
v1:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - use flag as discussed before, not a dedicated pidfd_wait() syscall
- Oleg Nesterov <oleg@redhat.com>:
  - use flag as discussed before, not a dedicated pidfd_wait() syscall

v2:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - move find_get_pid() calls into switch statements to avoid checking
    the type argument twice

v3:
- Linus Torvalds <torvalds@linux-foundation.org>:
  - add a dedicated helper which does the transformation from pidfd to
    struct pid to avoid open coding this
  - take an additional reference to struct pid to keep the exit code
    unified
---
 include/linux/pid.h       |  4 ++++
 include/uapi/linux/wait.h |  1 +
 kernel/exit.c             | 33 ++++++++++++++++++++++++++++++---
 kernel/fork.c             |  8 ++++++++
 kernel/signal.c           |  7 +++++--
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 2a83e434db9d..9645b1194c98 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -72,6 +72,10 @@ extern struct pid init_struct_pid;
 
 extern const struct file_operations pidfd_fops;
 
+struct file;
+
+extern struct pid *pidfd_pid(const struct file *file);
+
 static inline struct pid *get_pid(struct pid *pid)
 {
 	if (pid)
diff --git a/include/uapi/linux/wait.h b/include/uapi/linux/wait.h
index ac49a220cf2a..85b809fc9f11 100644
--- a/include/uapi/linux/wait.h
+++ b/include/uapi/linux/wait.h
@@ -17,6 +17,7 @@
 #define P_ALL		0
 #define P_PID		1
 #define P_PGID		2
+#define P_PIDFD		3
 
 
 #endif /* _UAPI_LINUX_WAIT_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index a75b6a7f458a..64bb6893a37d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1552,6 +1552,23 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
+static struct pid *pidfd_get_pid(unsigned int fd)
+{
+	struct fd f;
+	struct pid *pid;
+
+	f = fdget(fd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	pid = pidfd_pid(f.file);
+	if (!IS_ERR(pid))
+		get_pid(pid);
+
+	fdput(f);
+	return pid;
+}
+
 static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 			  int options, struct rusage *ru)
 {
@@ -1574,19 +1591,29 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		type = PIDTYPE_PID;
 		if (upid <= 0)
 			return -EINVAL;
+
+		pid = find_get_pid(upid);
 		break;
 	case P_PGID:
 		type = PIDTYPE_PGID;
 		if (upid <= 0)
 			return -EINVAL;
+
+		pid = find_get_pid(upid);
+		break;
+	case P_PIDFD:
+		type = PIDTYPE_PID;
+		if (upid < 0)
+			return -EINVAL;
+
+		pid = pidfd_get_pid(upid);
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (type < PIDTYPE_MAX)
-		pid = find_get_pid(upid);
-
 	wo.wo_type	= type;
 	wo.wo_pid	= pid;
 	wo.wo_flags	= options;
diff --git a/kernel/fork.c b/kernel/fork.c
index d8ae0f1b4148..b169e2ca2d84 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1690,6 +1690,14 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 }
 
+struct pid *pidfd_pid(const struct file *file)
+{
+	if (file->f_op == &pidfd_fops)
+		return file->private_data;
+
+	return ERR_PTR(-EBADF);
+}
+
 static int pidfd_release(struct inode *inode, struct file *file)
 {
 	struct pid *pid = file->private_data;
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

