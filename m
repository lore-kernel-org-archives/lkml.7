Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEAFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397CD206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SE3/kDHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfGZJlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:41:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33155 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfGZJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:41:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so53817452wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btd84rlt61xCmf/wxT0zLn6mpblKKLygpmGyUj0rpLE=;
        b=SE3/kDHSbj+/TsxIWQPwPCPrHPjO4RQg+XGYgIw5Kc+L7JaBZzQ8XFuPDZZeLbD6fi
         HLFJ4fAdILOg++fV2yszqW1TtiduTpdmU7pNxtg2Xu5U8uqjioZ2o4ml/YfbeOLE/WOC
         Ky1esXpnOjL2B9iAxuVATmhR1irjqgPg+m8IEBALJiEH4Rmnd85XdaenWy3IGajMhG6a
         B02Tkdiket5g8D9NvC8+c8AjASWocLV52SY95UFkq8HBzGg4N9lIYAZlrxtHWLdJDees
         s5iza6+3cYGiDsrX89Sh2itFAXw+n/rnXsB0WD96S1PZgKRzTDW9uGcwRhE1RhNgvDme
         8q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btd84rlt61xCmf/wxT0zLn6mpblKKLygpmGyUj0rpLE=;
        b=GJylP9WWKeiOF7iKWzDmcVhKxZA9qpyZV5bAOmziv5nHXMsR8hUxAOdkiZaxGeR/h0
         9QAYyHcy7QAWwUKGVtYThM+s+DHyOIvHhsUbQGuuxPq6gKRGsmLwLz7SzIHUjVXQOTYV
         qQJzoLxoqMDjpF1aW/lnB491Vk6F7L1NW645PQCyHFV41H8w1/BsJtLT6TXCbMFrMd9M
         AAzaLDLCNj3gsu4diqOPCelruJU3MrIoOUTDSpUCiu635XqFkBCQ/N7+2jaV7oYrsqDL
         EjN9K8p23+CDhOjP6BOJECzrTHbuiQf+aIhYsiHAdwmDGXMRaFhkbfhk4rkDhFo7Xwfd
         ECBQ==
X-Gm-Message-State: APjAAAW03gA2obvrjG0hVIC7cjNIXlDl0sOThrnDyp3G8HOK0ONZXiNZ
        7YhCxRMQ121bbqnY3U2Sx1AlTEp2DWI=
X-Google-Smtp-Source: APXvYqyROD/WBsRL8JHWCgZYJELWOKUiaxyAD4XBhxaKqt6XrtqII1CAA7lqWo/QAxxR6inBF/YWDw==
X-Received: by 2002:adf:de90:: with SMTP id w16mr3980946wrl.217.1564134065073;
        Fri, 26 Jul 2019 02:41:05 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm61664892wrt.95.2019.07.26.02.41.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:41:04 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 1/2] pidfd: add P_PIDFD to waitid()
Date:   Fri, 26 Jul 2019 11:39:33 +0200
Message-Id: <20190726093934.13557-2-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726093934.13557-1-christian@brauner.io>
References: <20190726093934.13557-1-christian@brauner.io>
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
---
 include/linux/pid.h       |  4 ++++
 include/uapi/linux/wait.h |  1 +
 kernel/exit.c             | 25 +++++++++++++++++++++++--
 kernel/fork.c             |  8 ++++++++
 kernel/signal.c           |  7 +++++--
 5 files changed, 41 insertions(+), 4 deletions(-)

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
index a75b6a7f458a..a9b49260b965 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1555,6 +1555,7 @@ static long do_wait(struct wait_opts *wo)
 static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 			  int options, struct rusage *ru)
 {
+	struct fd f;
 	struct wait_opts wo;
 	struct pid *pid = NULL;
 	enum pid_type type;
@@ -1580,11 +1581,27 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 		if (upid <= 0)
 			return -EINVAL;
 		break;
+	case P_PIDFD:
+		type = PIDTYPE_PID;
+		if (upid < 0)
+			return -EINVAL;
+
+		f = fdget(upid);
+		if (!f.file)
+			return -EBADF;
+
+		pid = pidfd_pid(f.file);
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return PTR_ERR(pid);
+		}
+
+		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (type < PIDTYPE_MAX)
+	if (type < PIDTYPE_MAX && !pid)
 		pid = find_get_pid(upid);
 
 	wo.wo_type	= type;
@@ -1594,7 +1611,11 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
 	wo.wo_rusage	= ru;
 	ret = do_wait(&wo);
 
-	put_pid(pid);
+	if (which == P_PIDFD)
+		fdput(f);
+	else
+		put_pid(pid);
+
 	return ret;
 }
 
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

