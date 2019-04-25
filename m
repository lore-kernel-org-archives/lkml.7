Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1636DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569CE2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="D9amvk7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfDYTA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:00:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46813 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:00:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so280912pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiYXLK7Tf5Qbjvl0oGyu8yhpajL4qMdWQdIN0gBiHWs=;
        b=D9amvk7URcyGLGrVBPmMAbroP7VJp4xohyxcmkx8tXZAdg0kKAeqx3rRDe/s5u6/jG
         YgDz7fpcibNSCh8AwefMwo+hMIAZJ2GadMgwqz8uzbMyQX1Xsrjp/0rFopnAwx3FJ0HR
         eHMHm/B/eS/f3QAM3+30ukJYQmU5CV5Eg0gB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiYXLK7Tf5Qbjvl0oGyu8yhpajL4qMdWQdIN0gBiHWs=;
        b=Qt/f72d7A8vLk4ndWh+peWnTTxbw++tOvw1MIvoaj4R5uJcvMnVluQKykxojZg6tM5
         fBmtJ8tlkmpy8eOhdHFHL6U3e/Q+lAy4Iv7V1mUmJm57oU0YF5mWkGK1Ka/1+yvadG8a
         NadhWkexY+uhVebBULKSK9wIoQZ9+2cEKsBovCDRBoUZFzM6qzxWSJ7qHBuyd+r5ROFZ
         mXO+PwW66Cw49v7EijpcAHBQoDwnZzf6zxfznJtJxh6T4GymfmniVyVTuH4JErWvA1VE
         CkIteWXagQAsNsuXACc7MB2Svk8XqXwm5RZUWJCfDH5NQRTNFIqUfVtRq8Wrwk/1kbhc
         Ah8g==
X-Gm-Message-State: APjAAAWt6xJkcGkrh1zOkRmlH+1R0LhnEk7PhwpCuBsBC//xz621bmmP
        DDVRh8sudntq1PEDG7575BKAUa2wVzc=
X-Google-Smtp-Source: APXvYqzkgYCDs6Gu24z3xReV3enQ2TUz2QLK6qjWhAZEZ6M4A5n0wqIx7MK7+z61SMaFkN5aOm8DBw==
X-Received: by 2002:aa7:8052:: with SMTP id y18mr954369pfm.36.1556218827264;
        Thu, 25 Apr 2019 12:00:27 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o14sm25480683pgn.4.2019.04.25.12.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:00:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        luto@amacapital.net, rostedt@goodmis.org, dancol@google.com,
        sspatil@google.com, christian@brauner.io, jannh@google.com,
        surenb@google.com, timmurray@google.com,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        torvalds@linux-foundation.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jann@thejh.net>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v1 1/2] Add polling support to pidfd
Date:   Thu, 25 Apr 2019 15:00:09 -0400
Message-Id: <20190425190010.46489-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pidfd are file descriptors referring to a process created with the
CLONE_PIDFD clone(2) flag. Android low memory killer (LMK) needs pidfd
polling support to replace code that currently checks for existence of
/proc/pid for knowing that a process that is signalled to be killed has
died, which is both racy and slow. The pidfd poll approach is race-free,
and also allows the LMK to do other things (such as by polling on other
fds) while awaiting the process being killed to die.

It prevents a situation where a PID is reused between when LMK sends a
kill signal and checks for existence of the PID, since the wrong PID is
now possibly checked for existence.

In this patch, we follow the same existing mechanism in the kernel used
when the parent of the task group is to be notified (do_notify_parent).
This is when the tasks waiting on a poll of pidfd are also awakened.

We have decided to include the waitqueue in struct pid for the following
reasons:
1. The wait queue has to survive for the lifetime of the poll. Including
it in task_struct would not be option in this case because the task can
be reaped and destroyed before the poll returns.

2. By including the struct pid for the waitqueue means that during
de_thread(), the new thread group leader automatically gets the new
waitqueue/pid even though its task_struct is different.

Appropriate test cases are added in the second patch to provide coverage
of all the cases the patch is handling.

Andy had a similar patch [1] in the past which was a good reference
however this patch tries to handle different situations properly related
to thread group existence, and how/where it notifies. And also solves
other bugs (waitqueue lifetime).  Daniel had a similar patch [2]
recently which this patch supercedes.

[1] https://lore.kernel.org/patchwork/patch/345098/
[2] https://lore.kernel.org/lkml/20181029175322.189042-1-dancol@google.com/

Cc: luto@amacapital.net
Cc: rostedt@goodmis.org
Cc: dancol@google.com
Cc: sspatil@google.com
Cc: christian@brauner.io
Cc: jannh@google.com
Cc: surenb@google.com
Cc: timmurray@google.com
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: torvalds@linux-foundation.org
Cc: kernel-team@android.com
Co-developed-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

RFC -> v1:
* Based on CLONE_PIDFD patches: https://lwn.net/Articles/786244/
* Updated selftests.
* Renamed poll wake function to do_notify_pidfd.
* Removed depending on EXIT flags
* Removed POLLERR flag since semantics are controversial and
  we don't have usecases for it right now (later we can add if there's
  a need for it).

 include/linux/pid.h |  3 +++
 kernel/fork.c       | 33 +++++++++++++++++++++++++++++++++
 kernel/pid.c        |  2 ++
 kernel/signal.c     | 14 ++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 3c8ef5a199ca..1484db6ca8d1 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rculist.h>
+#include <linux/wait.h>
 
 enum pid_type
 {
@@ -60,6 +61,8 @@ struct pid
 	unsigned int level;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
+	/* wait queue for pidfd notifications */
+	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
 	struct upid numbers[1];
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 5525837ed80e..fb3b614f6456 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1685,8 +1685,41 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 }
 #endif
 
+static unsigned int pidfd_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct task_struct *task;
+	struct pid *pid;
+	int poll_flags = 0;
+
+	/*
+	 * tasklist_lock must be held because to avoid racing with
+	 * changes in exit_state and wake up. Basically to avoid:
+	 *
+	 * P0: read exit_state = 0
+	 * P1: write exit_state = EXIT_DEAD
+	 * P1: Do a wake up - wq is empty, so do nothing
+	 * P0: Queue for polling - wait forever.
+	 */
+	read_lock(&tasklist_lock);
+	pid = file->private_data;
+	task = pid_task(pid, PIDTYPE_PID);
+	WARN_ON_ONCE(task && !thread_group_leader(task));
+
+	if (!task || (task->exit_state && thread_group_empty(task)))
+		poll_flags = POLLIN | POLLRDNORM;
+
+	if (!poll_flags)
+		poll_wait(file, &pid->wait_pidfd, pts);
+
+	read_unlock(&tasklist_lock);
+
+	return poll_flags;
+}
+
+
 const struct file_operations pidfd_fops = {
 	.release = pidfd_release,
+	.poll = pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = pidfd_show_fdinfo,
 #endif
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..5c90c239242f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
+	init_waitqueue_head(&pid->wait_pidfd);
+
 	upid = pid->numbers + ns->level;
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
diff --git a/kernel/signal.c b/kernel/signal.c
index 1581140f2d99..16e7718316e5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1800,6 +1800,17 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+static void do_notify_pidfd(struct task_struct *task)
+{
+	struct pid *pid;
+
+	lockdep_assert_held(&tasklist_lock);
+
+	pid = get_task_pid(task, PIDTYPE_PID);
+	wake_up_all(&pid->wait_pidfd);
+	put_pid(pid);
+}
+
 /*
  * Let a parent know about the death of a child.
  * For a stopped/continued status change, use do_notify_parent_cldstop instead.
@@ -1823,6 +1834,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
+	/* Wake up all pidfd waiters */
+	do_notify_pidfd(tsk);
+
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.
-- 
2.21.0.593.g511ec345e18-goog
