Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD13CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9440B216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfG2Qec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfG2Qea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09C98307D9D1;
        Mon, 29 Jul 2019 16:34:30 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A9A5D6A7;
        Mon, 29 Jul 2019 16:34:25 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH 1/2] fork: extend clone3() to support CLONE_SET_TID
Date:   Mon, 29 Jul 2019 18:33:54 +0200
Message-Id: <20190729163355.4530-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 29 Jul 2019 16:34:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main motivation to add CLONE_SET_TID to clone3() is CRIU.

To restore a process with the same PID/TID CRIU currently uses
/proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
ns_last_pid and then (quickly) does a clone(). This works most of the
time, but it is racy. It is also slow as it requires multiple syscalls.

Extending clone3() to support CLONE_SET_TID makes it possible restore a
process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
race free (as long as the desired PID/TID is available).

This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
on clone3() with set_tid as they are currently in place for ns_last_pid.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 include/linux/pid.h        |  2 +-
 include/linux/sched/task.h |  1 +
 include/uapi/linux/sched.h |  2 ++
 kernel/fork.c              | 22 ++++++++++++++++------
 kernel/pid.c               | 21 ++++++++++++++++++---
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 2a83e434db9d..052000db0ced 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -116,7 +116,7 @@ extern struct pid *find_vpid(int nr);
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
 
-extern struct pid *alloc_pid(struct pid_namespace *ns);
+extern struct pid *alloc_pid(struct pid_namespace *ns, pid_t set_tid);
 extern void free_pid(struct pid *pid);
 extern void disable_pid_allocation(struct pid_namespace *ns);
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0497091e40c1..4f2a80564332 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -26,6 +26,7 @@ struct kernel_clone_args {
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
+	pid_t set_tid;
 };
 
 /*
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..8c4e803e8147 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -32,6 +32,7 @@
 #define CLONE_NEWPID		0x20000000	/* New pid namespace */
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
+#define CLONE_SET_TID		0x100000000ULL	/* set if the desired TID is set in set_tid */
 
 /*
  * Arguments for the clone3 syscall
@@ -45,6 +46,7 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+	__aligned_u64 set_tid;
 };
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..8c59441ac153 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2031,7 +2031,7 @@ static __latent_entropy struct task_struct *copy_process(
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
+		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
 			goto bad_fork_cleanup_thread;
@@ -2530,6 +2530,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t size)
 {
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
 	struct clone_args args;
 
 	if (unlikely(size > PAGE_SIZE))
@@ -2562,6 +2563,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	if (copy_from_user(&args, uargs, size))
 		return -EFAULT;
 
+	if ((args.flags & CLONE_SET_TID) && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
@@ -2571,6 +2575,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.stack		= args.stack,
 		.stack_size	= args.stack_size,
 		.tls		= args.tls,
+		.set_tid	= args.set_tid,
 	};
 
 	return 0;
@@ -2578,11 +2583,16 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 
 static bool clone3_args_valid(const struct kernel_clone_args *kargs)
 {
-	/*
-	 * All lower bits of the flag word are taken.
-	 * Verify that no other unknown flags are passed along.
-	 */
-	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
+	/* Verify that no other unknown flags are passed along. */
+	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_SET_TID))
+		return false;
+
+	/* Fail if set_tid is set without CLONE_SET_TID */
+	if (kargs->set_tid && !(kargs->flags & CLONE_SET_TID))
+		return false;
+
+	/* Also fail if set_tid is invalid */
+	if ((kargs->set_tid <= 0) && (kargs->flags & CLONE_SET_TID))
 		return false;
 
 	/*
diff --git a/kernel/pid.c b/kernel/pid.c
index 0a9f2e437217..d3db8090bb10 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -157,11 +157,12 @@ void free_pid(struct pid *pid)
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
-struct pid *alloc_pid(struct pid_namespace *ns)
+struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
 {
 	struct pid *pid;
 	enum pid_type type;
 	int i, nr;
+	int max_p, min_p;
 	struct pid_namespace *tmp;
 	struct upid *upid;
 	int retval = -ENOMEM;
@@ -186,12 +187,26 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
 			pid_min = RESERVED_PIDS;
 
+		if (set_tid) {
+			if ((set_tid >= pid_max) || ((set_tid != 1) &&
+				(idr_get_cursor(&tmp->idr) <= 1))) {
+				spin_unlock_irq(&pidmap_lock);
+				retval = -EINVAL;
+				goto out_free;
+			}
+			min_p = set_tid;
+			max_p = set_tid + 1;
+			set_tid = 0;
+		} else {
+			min_p = pid_min;
+			max_p = pid_max;
+		}
 		/*
 		 * Store a null pointer so find_pid_ns does not find
 		 * a partially initialized PID (see below).
 		 */
-		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-				      pid_max, GFP_ATOMIC);
+		nr = idr_alloc_cyclic(&tmp->idr, NULL, min_p,
+				      max_p, GFP_ATOMIC);
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
 
-- 
2.21.0

