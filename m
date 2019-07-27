Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6017C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B14C20644
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="T09BDq7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfG0IxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:53:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37611 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfG0IxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:53:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so31613028wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxUhMBWw5d33TUgfZi6bnqKIshxt6dPaJsT3Wm9MnDo=;
        b=T09BDq7hdJrgKBl4bs7We3Mbujy6rf3riUupRYss7VtGRwFKHP7M8oQHkH7lCFX3cn
         5busPohZwbvhE7F7YXvjQgU7bNkfAdX2Y99/3w2BMXSK92O1wFRPHd2ttHhY4Wul9D/6
         RBMgfrZ2vdi2k3yFDISQd4RWT261O75H3uDDDaGpRmjelAd95GyVG4Gw2c7FEA7x01aX
         LPb3Aahsurd7d0YfyIEPyWBFfXte2+ixgrhbRYnyZAYEiTEPv0I3N8u4S3BtSNevYC/O
         B2KF05Ova2MCYDGtbUJfB5ePe6QWZfARakbNLl3y4w6pT8Sw8LtV2xMlS3ocy66vfbcP
         90mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxUhMBWw5d33TUgfZi6bnqKIshxt6dPaJsT3Wm9MnDo=;
        b=TMmUC7QnZcq4sAWlLbcueJp9i7aA2+kktib+5ieA+qeoQnVzamKd4ohNkERlkvwRZh
         JW9WOx1DU7MPmEgnmNNmsDEaSGOOuMvW8rz9ex9dwC6gv4H0pupVUQgjSvh4p93ZEZjg
         EFzM2Y4D7TyFBafadG3/rbz4eeMfi6AQ8L92lcG746geQtrayO4UZfMeSTHy1wQBraE2
         CFpDgpXFVqqcejBCAmK7OxyXkNEIKrtPyKXPkZ2ooZ53jAVRKyDMoVM/+c1fapZP6jbS
         +00WYY84Q+eKe0dVscxPxAwaFzFU8Ocpdb8aSs6HgJeCiFBO2TQxpbuLn3GxyRqPb1VD
         bXTQ==
X-Gm-Message-State: APjAAAX9Yzoc8aB4pJxNARv05qA4Vb8XF/RdxNNMaqMhLaS4pTxaKuAM
        dqwMdZknNpfgKl7Zq+doPWu5P/68/CU=
X-Google-Smtp-Source: APXvYqzXjja7AN3RHOwV33q+4OevLRW5aNQsS5turRzAzgq2BKCeP3IU2ihfu7ep3Qb4oKPx6HJO3Q==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr67633442wrv.219.1564217599090;
        Sat, 27 Jul 2019 01:53:19 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id y24sm40114584wmi.10.2019.07.27.01.53.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 01:53:18 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
Date:   Sat, 27 Jul 2019 10:52:00 +0200
Message-Id: <20190727085201.11743-2-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727085201.11743-1-christian@brauner.io>
References: <20190727085201.11743-1-christian@brauner.io>
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
---
 include/linux/pid.h       |  4 ++++
 include/uapi/linux/wait.h |  1 +
 kernel/exit.c             | 29 +++++++++++++++++++++++++----
 kernel/fork.c             |  8 ++++++++
 kernel/signal.c           |  7 +++++--
 5 files changed, 43 insertions(+), 6 deletions(-)

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
index a75b6a7f458a..207f7a37b2d0 100644
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
@@ -1574,19 +1575,35 @@ static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
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
+		f = fdget(upid);
+		if (!f.file)
+			return -EBADF;
+
+		pid = pidfd_pid(f.file);
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return PTR_ERR(pid);
+		}
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

