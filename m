Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73BAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CDA2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AN44rskY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDKRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:51:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:51:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so3808331pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjMt776EX1mggAi0SX8QhnKDJrAdXEXm05sYg4GeKXE=;
        b=AN44rskYuNIjpgl9Op9GG0xoiFFbjTiCakuLv81kkQ6KUg+u02SwLQqNj2uBDO8+yI
         S2nYWCK3fFyVH937oRk5zpJt9A8RpvWPrEseBnRl5+MtrO5pocKp1kFftghLObKIsmQs
         s/HO5colCjfKOnSGz199spGar4t6DpbVfdPBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjMt776EX1mggAi0SX8QhnKDJrAdXEXm05sYg4GeKXE=;
        b=RrZNEWghQQMXmQXEXqiA6m63qGH9z/r2Q0A4u22Ugi5Dz9XcrmgqYqADJb3Mjw4Pee
         svQ0cZCAwq/6naa1rdR6fcdF6c3XS9Zsn0Q8cdV9utmXMuE0s5R3VVrDvCsFxrAPoyxj
         5NJTj8/whQZ+ipX20BX7O7yhmqqNkcwjb6o5W4qD94xxUKrVpDI3tfRljvoU1qfLmbrq
         gnuUsQG4we8yyuTqQbcdBJxjfhopvoANnDGxPH7+FWQS4ImWGzSPiM+uziU/cBHhqYaI
         aKEBMTq8TlvTyeixfj2dBSaToZJv8pg2W5u4EmQOoNxQ0DQ03XVVU0wLxpiRqhUNwDIQ
         kWgw==
X-Gm-Message-State: APjAAAXu17x4WAgZtVyJXIWwUdBUVdP2Aw9ijRPj5B5ZtpV/ob+zVFhc
        q02KFzquHJMIdYKbji4ELbtLn54AllU=
X-Google-Smtp-Source: APXvYqxs3guNftei60Leepnz9UpLN+1Gc70GScpCwTo4fJaiUH6e2ypmC39E61ck5PQ2PJZ2OQBhTA==
X-Received: by 2002:a65:484a:: with SMTP id i10mr48880145pgs.408.1555005061340;
        Thu, 11 Apr 2019 10:51:01 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d68sm58776474pfg.16.2019.04.11.10.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:51:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        luto@amacapital.net, rostedt@goodmis.org, dancol@google.com,
        christian@brauner.io, jannh@google.com, surenb@google.com,
        torvalds@linux-foundation.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH RFC 1/2] Add polling support to pidfd
Date:   Thu, 11 Apr 2019 13:50:42 -0400
Message-Id: <20190411175043.31207-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pidfd are /proc/pid directory file descriptors referring to a task group
leader. Android low memory killer (LMK) needs pidfd polling support to
replace code that currently checks for existence of /proc/pid for
knowing a process that is signalled to be killed has died, which is both
racy and slow. The pidfd poll approach is race-free, and also allows the
LMK to do other things (such as by polling on other fds) while awaiting
the process being killed to die.

It prevents a situation where a PID is reused between when LMK sends a
kill signal and checks for existence of the PID, since the wrong PID is
now possibly checked for existence.

In this patch, we follow the same mechanism used uhen the parent of the
task group is to be notified, that is when the tasks waiting on a poll
of pidfd are also awakened.

We have decided to include the waitqueue in struct pid for the following
reasons:
1. The wait queue has to survive for the lifetime of the poll. Including
it in task_struct would not be option in this case because the task can
be reaped and destroyed before the poll returns.

2. By including the struct pid for the waitqueue means that during
de_exec, the thread doing de_thread() automatically gets the new
waitqueue/pid even though its task_struct is different.

Appropriate test cases are added in the second patch to provide coverage
of all the cases the patch is handling.

Andy had a similar patch [1] in the past which was a good reference
however this patch tries to handle different situations properly related
to thread group existence, and how/where it notifies. And also solves
other bugs (existence of taks_struct).  Daniel had a similar patch [2]
recently which this patch supercedes.

[1] https://lore.kernel.org/patchwork/patch/345098/
[2] https://lore.kernel.org/lkml/20181029175322.189042-1-dancol@google.com/

Cc: luto@amacapital.net
Cc: rostedt@goodmis.org
Cc: dancol@google.com
Cc: christian@brauner.io
Cc: jannh@google.com
Cc: surenb@google.com
Cc: torvalds@linux-foundation.org
Co-developed-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 fs/proc/base.c      | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/pid.h |  3 +++
 kernel/exit.c       |  1 -
 kernel/pid.c        |  2 ++
 kernel/signal.c     | 14 ++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..879900082647 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3069,8 +3069,47 @@ static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
+static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
+{
+	int poll_flags = 0;
+	struct task_struct *task;
+	struct pid *pid;
+
+	task = get_proc_task(file->f_path.dentry->d_inode);
+
+	WARN_ON_ONCE(task && !thread_group_leader(task));
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
+	if (!task)
+		poll_flags = POLLIN | POLLRDNORM | POLLERR;
+	else if (task->exit_state == EXIT_DEAD)
+		poll_flags = POLLIN | POLLRDNORM;
+	else if (task->exit_state == EXIT_ZOMBIE && thread_group_empty(task))
+		poll_flags = POLLIN | POLLRDNORM;
+
+	if (!poll_flags) {
+		pid = proc_pid(file->f_path.dentry->d_inode);
+		poll_wait(file, &pid->wait_pidfd, pts);
+	}
+	read_unlock(&tasklist_lock);
+
+	if (task)
+		put_task_struct(task);
+	return poll_flags;
+}
+
 static const struct file_operations proc_tgid_base_operations = {
 	.read		= generic_read_dir,
+	.poll		= proc_tgid_base_poll,
 	.iterate_shared	= proc_tgid_base_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/include/linux/pid.h b/include/linux/pid.h
index b6f4ba16065a..2e0dcbc6d14e 100644
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
+	/* wait queue for pidfd pollers */
+	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
 	struct upid numbers[1];
 };
diff --git a/kernel/exit.c b/kernel/exit.c
index 2166c2d92ddc..c386ec52687d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -181,7 +181,6 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 	put_task_struct(tsk);
 }
 
-
 void release_task(struct task_struct *p)
 {
 	struct task_struct *leader;
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
index f98448cf2def..e3781703ef7e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1800,6 +1800,17 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+static void do_wakeup_pidfd_pollers(struct task_struct *task)
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
+	do_wakeup_pidfd_pollers(tsk);
+
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.
-- 
2.21.0.392.gf8f6787159e-goog

