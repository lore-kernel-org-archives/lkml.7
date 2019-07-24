Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9FB21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="IvGNtpiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbfGXOrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:47:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42488 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGXOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:47:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so21343664pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LF+TqzkdoxFIHCg2CjCscZk8IRSrnPu55eYCvRE1cQ=;
        b=IvGNtpiPO2xFlc/FmS9S7JdQgiQ5G1DB59NGUpzkzKAeFLhZkrnn4Wd33J1CvB2tpV
         x6SXtnpWu0iSjXvaBdDBEt6W2IMwmxk3pxkAkZCc7JGkgSBbKAu3T6alPEXj2h51dG1Z
         ELhU6hbNC2u2S47JY2pCwLxrnVOy5g4ApQZFe+tVedVWBr6yw2nlgaTz1SrHbOYN5m4F
         zEckuImuxPEG6bpRsRg37nCPlsqmO0BHRLMbazrPhPJeOvNB+kYFhYmNTcBkqhVgEaeR
         75BX/gU7xsSljULk1wvC8S60hWNxxYGzK095ctAhvEyodxgl3o18YKCMVES6rcRDzG9n
         oZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LF+TqzkdoxFIHCg2CjCscZk8IRSrnPu55eYCvRE1cQ=;
        b=bqoa9WUXgoLfKaJo7gkyfpKJkZCijeqpFR/s2PwRZb68dDzEk6rj34D/UpCfWAvTki
         8yvn+xgxLs23y/kpZmtTA0Z05i2hCNE4wkMRv6kL8OpWqcuclHPKNXZda2IEPMWDV5sZ
         Iu324D2cpvqLLr8LZQG03BaKjziTrCv8vstlA9EZ1Yd7Oi0C4ONAH/PaWUuPcK0+U+OS
         ePmpcoSCJYJ/231BQAW/iJgkwhwzfb7U4qHzz19noUyd8uUedG7tu5uA73mIr8mku9k6
         1VyaGYdEleJg7PeQWp68lreto4w+SqPdweiGP0ODG82p10EV+t1rbbycJ/54lxY78loJ
         Rryw==
X-Gm-Message-State: APjAAAXAFh5DM1LAkIklmlvh6JHV83jGH7vDNssbg3XaGZrymFClWrzZ
        1PzX3jtaK1MWr6O6ze3XATEurywwU2U=
X-Google-Smtp-Source: APXvYqxBCu0dpAjvCTNBrV/GS20uyXtHwaAWAG4VpES5i/CXZof5MB5/d9YgJddKCyYCpMpDug0Vsg==
X-Received: by 2002:a17:90a:3225:: with SMTP id k34mr86837702pjb.31.1563979650539;
        Wed, 24 Jul 2019 07:47:30 -0700 (PDT)
Received: from localhost.localdomain ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id g6sm41125644pgh.64.2019.07.24.07.47.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:47:29 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [RFC][PATCH 1/5] exit: kill struct waitid_info
Date:   Wed, 24 Jul 2019 16:46:47 +0200
Message-Id: <20190724144651.28272-2-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724144651.28272-1-christian@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code here uses a struct waitid_info to catch basic information about
process exit including the pid, uid, status, and signal that caused the
process to exit. This information is then stuffed into a struct siginfo
for the waitid() syscall. That seems like an odd thing to do. We can
just pass down a siginfo_t struct directly which let's us cleanup and
simplify the whole code quite a bit.
This patch also simplifies the following implementation of pidfd_wait().

Note that this changes how struct siginfo is filled in for users of
waitid. POSIX doesn't mandate anything else other than si_pid, si_uid,
si_code, and si_signo. So it seems up to the implementation. In case
anyone relies on the old behavior we can just revert but I highly doubt
that users fill in siginfo_t before a call to waitid and expect all
fields other then the ones mention above to be untouched.

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
---
 kernel/exit.c | 101 ++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 65 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index a75b6a7f458a..73392a455b72 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -994,19 +994,12 @@ SYSCALL_DEFINE1(exit_group, int, error_code)
 	return 0;
 }
 
-struct waitid_info {
-	pid_t pid;
-	uid_t uid;
-	int status;
-	int cause;
-};
-
 struct wait_opts {
 	enum pid_type		wo_type;
 	int			wo_flags;
 	struct pid		*wo_pid;
 
-	struct waitid_info	*wo_info;
+	kernel_siginfo_t	*wo_info;
 	int			wo_stat;
 	struct rusage		*wo_rusage;
 
@@ -1058,7 +1051,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 	int state, status;
 	pid_t pid = task_pid_vnr(p);
 	uid_t uid = from_kuid_munged(current_user_ns(), task_uid(p));
-	struct waitid_info *infop;
+	kernel_siginfo_t *infop;
 
 	if (!likely(wo->wo_flags & WEXITED))
 		return 0;
@@ -1169,14 +1162,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 	infop = wo->wo_info;
 	if (infop) {
 		if ((status & 0x7f) == 0) {
-			infop->cause = CLD_EXITED;
-			infop->status = status >> 8;
+			infop->si_code = CLD_EXITED;
+			infop->si_status = status >> 8;
 		} else {
-			infop->cause = (status & 0x80) ? CLD_DUMPED : CLD_KILLED;
-			infop->status = status & 0x7f;
+			infop->si_code = (status & 0x80) ? CLD_DUMPED : CLD_KILLED;
+			infop->si_status = status & 0x7f;
 		}
-		infop->pid = pid;
-		infop->uid = uid;
+		infop->si_pid = pid;
+		infop->si_uid = uid;
 	}
 
 	return pid;
@@ -1215,7 +1208,7 @@ static int *task_stopped_code(struct task_struct *p, bool ptrace)
 static int wait_task_stopped(struct wait_opts *wo,
 				int ptrace, struct task_struct *p)
 {
-	struct waitid_info *infop;
+	kernel_siginfo_t *infop;
 	int exit_code, *p_code, why;
 	uid_t uid = 0; /* unneeded, required by compiler */
 	pid_t pid;
@@ -1270,10 +1263,10 @@ static int wait_task_stopped(struct wait_opts *wo,
 
 	infop = wo->wo_info;
 	if (infop) {
-		infop->cause = why;
-		infop->status = exit_code;
-		infop->pid = pid;
-		infop->uid = uid;
+		infop->si_code = why;
+		infop->si_status = exit_code;
+		infop->si_pid = pid;
+		infop->si_uid = uid;
 	}
 	return pid;
 }
@@ -1286,7 +1279,7 @@ static int wait_task_stopped(struct wait_opts *wo,
  */
 static int wait_task_continued(struct wait_opts *wo, struct task_struct *p)
 {
-	struct waitid_info *infop;
+	kernel_siginfo_t *infop;
 	pid_t pid;
 	uid_t uid;
 
@@ -1316,13 +1309,13 @@ static int wait_task_continued(struct wait_opts *wo, struct task_struct *p)
 	put_task_struct(p);
 
 	infop = wo->wo_info;
-	if (!infop) {
-		wo->wo_stat = 0xffff;
+	if (infop) {
+		infop->si_code = CLD_CONTINUED;
+		infop->si_status = SIGCONT;
+		infop->si_pid = pid;
+		infop->si_uid = uid;
 	} else {
-		infop->cause = CLD_CONTINUED;
-		infop->pid = pid;
-		infop->uid = uid;
-		infop->status = SIGCONT;
+		wo->wo_stat = 0xffff;
 	}
 	return pid;
 }
@@ -1552,7 +1545,7 @@ static long do_wait(struct wait_opts *wo)
 	return retval;
 }
 
-static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
+static long kernel_waitid(int which, pid_t upid, kernel_siginfo_t *infop,
 			  int options, struct rusage *ru)
 {
 	struct wait_opts wo;
@@ -1602,33 +1595,22 @@ SYSCALL_DEFINE5(waitid, int, which, pid_t, upid, struct siginfo __user *,
 		infop, int, options, struct rusage __user *, ru)
 {
 	struct rusage r;
-	struct waitid_info info = {.status = 0};
-	long err = kernel_waitid(which, upid, &info, options, ru ? &r : NULL);
-	int signo = 0;
-
+	kernel_siginfo_t kinfo = {
+		.si_signo = 0,
+	};
+	long err = kernel_waitid(which, upid, infop ? &kinfo : NULL, options,
+				 ru ? &r : NULL);
 	if (err > 0) {
-		signo = SIGCHLD;
+		kinfo.si_signo = SIGCHLD;
 		err = 0;
 		if (ru && copy_to_user(ru, &r, sizeof(struct rusage)))
 			return -EFAULT;
 	}
-	if (!infop)
-		return err;
 
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (infop && copy_siginfo_to_user(infop, &kinfo))
 		return -EFAULT;
 
-	unsafe_put_user(signo, &infop->si_signo, Efault);
-	unsafe_put_user(0, &infop->si_errno, Efault);
-	unsafe_put_user(info.cause, &infop->si_code, Efault);
-	unsafe_put_user(info.pid, &infop->si_pid, Efault);
-	unsafe_put_user(info.uid, &infop->si_uid, Efault);
-	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
-	return err;
-Efault:
-	user_access_end();
-	return -EFAULT;
+	return err ;
 }
 
 long kernel_wait4(pid_t upid, int __user *stat_addr, int options,
@@ -1722,11 +1704,13 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 		struct compat_rusage __user *, uru)
 {
 	struct rusage ru;
-	struct waitid_info info = {.status = 0};
-	long err = kernel_waitid(which, pid, &info, options, uru ? &ru : NULL);
-	int signo = 0;
+	kernel_siginfo_t kinfo = {
+		.si_signo = 0,
+	};
+	long err = kernel_waitid(which, pid, infop ? &kinfo : NULL, options,
+				 uru ? &ru : NULL);
 	if (err > 0) {
-		signo = SIGCHLD;
+		kinfo.si_signo = SIGCHLD;
 		err = 0;
 		if (uru) {
 			/* kernel_waitid() overwrites everything in ru */
@@ -1739,23 +1723,10 @@ COMPAT_SYSCALL_DEFINE5(waitid,
 		}
 	}
 
-	if (!infop)
-		return err;
-
-	if (!user_access_begin(infop, sizeof(*infop)))
+	if (infop && copy_siginfo_to_user32(infop, &kinfo))
 		return -EFAULT;
 
-	unsafe_put_user(signo, &infop->si_signo, Efault);
-	unsafe_put_user(0, &infop->si_errno, Efault);
-	unsafe_put_user(info.cause, &infop->si_code, Efault);
-	unsafe_put_user(info.pid, &infop->si_pid, Efault);
-	unsafe_put_user(info.uid, &infop->si_uid, Efault);
-	unsafe_put_user(info.status, &infop->si_status, Efault);
-	user_access_end();
 	return err;
-Efault:
-	user_access_end();
-	return -EFAULT;
 }
 #endif
 
-- 
2.22.0

