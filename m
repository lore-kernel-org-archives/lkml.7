Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF05204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbfHHVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27333 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732601AbfHHVWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:22:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09DFC60149;
        Thu,  8 Aug 2019 21:22:42 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F40CD5C231;
        Thu,  8 Aug 2019 21:22:35 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH v4 1/2] fork: extend clone3() to support CLONE_SET_TID
Date:   Thu,  8 Aug 2019 23:22:21 +0200
Message-Id: <20190808212222.28276-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 08 Aug 2019 21:22:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main motivation to add set_tid to clone3() is CRIU.

To restore a process with the same PID/TID CRIU currently uses
/proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
ns_last_pid and then (quickly) does a clone(). This works most of the
time, but it is racy. It is also slow as it requires multiple syscalls.

Extending clone3() to support set_tid makes it possible restore a
process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
race free (as long as the desired PID/TID is available).

This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
on clone3() with set_tid as they are currently in place for ns_last_pid.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
v2:
 - Removed (size < sizeof(struct clone_args)) as discussed with
   Christian and Dmitry
 - Added comment to ((set_tid != 1) && idr_get_cursor() <= 1) (Oleg)
 - Use idr_alloc() instead of idr_alloc_cyclic() (Oleg)

v3:
 - Return EEXIST if PID is already in use (Christian)
 - Drop CLONE_SET_TID (Christian and Oleg)
 - Use idr_is_empty() instead of idr_get_cursor() (Oleg)
 - Handle different `struct clone_args` sizes (Dmitry)

v4:
 - Rework struct size check with defines (Christian)
 - Reduce number of set_tid checks (Oleg)
 - Less parentheses and more robust code (Oleg)
 - Do ns_capable() on correct user_ns (Oleg, Christian)
---
 include/linux/pid.h        |  2 +-
 include/linux/sched/task.h |  1 +
 include/uapi/linux/sched.h |  1 +
 kernel/fork.c              | 25 +++++++++++++++++++++++--
 kernel/pid.c               | 34 +++++++++++++++++++++++++++-------
 5 files changed, 53 insertions(+), 10 deletions(-)

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
index b3105ac1381a..e1ce103a2c47 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -45,6 +45,7 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+	__aligned_u64 set_tid;
 };
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 2852d0e76ea3..2a03f0e201e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -117,6 +117,13 @@
  */
 #define MAX_THREADS FUTEX_TID_MASK
 
+/*
+ * Different sizes of struct clone_args
+ */
+#define CLONE3_ARGS_SIZE_V0 64
+/* V1 includes set_tid */
+#define CLONE3_ARGS_SIZE_V1 72
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -2031,7 +2038,13 @@ static __latent_entropy struct task_struct *copy_process(
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
+		if (args->set_tid && !ns_capable(
+				p->nsproxy->pid_ns_for_children->user_ns,
+				CAP_SYS_ADMIN)) {
+			retval = -EPERM;
+			goto bad_fork_cleanup_thread;
+		}
+		pid = alloc_pid(p->nsproxy->pid_ns_for_children, args->set_tid);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
 			goto bad_fork_cleanup_thread;
@@ -2535,9 +2548,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	if (unlikely(size > PAGE_SIZE))
 		return -E2BIG;
 
-	if (unlikely(size < sizeof(struct clone_args)))
+	/* The struct needs to be at least the size of the original struct. */
+	if (unlikely(size < CLONE3_ARGS_SIZE_V0))
 		return -EINVAL;
 
+	if (size < sizeof(struct clone_args))
+		memset((void *)&args + size, 0,
+				sizeof(struct clone_args) - size);
+
 	if (unlikely(!access_ok(uargs, size)))
 		return -EFAULT;
 
@@ -2573,6 +2591,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.tls		= args.tls,
 	};
 
+	if (size >= CLONE3_ARGS_SIZE_V1)
+		kargs->set_tid = args.set_tid;
+
 	return 0;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 0a9f2e437217..9ce89c35c5be 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -157,7 +157,7 @@ void free_pid(struct pid *pid)
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
-struct pid *alloc_pid(struct pid_namespace *ns)
+struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
 {
 	struct pid *pid;
 	enum pid_type type;
@@ -186,12 +186,32 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
 			pid_min = RESERVED_PIDS;
 
-		/*
-		 * Store a null pointer so find_pid_ns does not find
-		 * a partially initialized PID (see below).
-		 */
-		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-				      pid_max, GFP_ATOMIC);
+		if (set_tid) {
+			/*
+			 * Also fail if a PID != 1 is requested
+			 * and no PID 1 exists.
+			 */
+			nr = -EINVAL;
+			if (set_tid < pid_max && set_tid > 0 &&
+			    (set_tid == 1 || !idr_is_empty(&tmp->idr)))
+				nr = idr_alloc(&tmp->idr, NULL, set_tid,
+					       set_tid + 1, GFP_ATOMIC);
+			/*
+			 * If ENOSPC is returned it means that the PID is
+			 * alreay in use. Return EEXIST in that case.
+			 */
+			if (nr == -ENOSPC)
+				nr = -EEXIST;
+			/* Only use set_tid for one PID namespace. */
+			set_tid = 0;
+		} else {
+			/*
+			 * Store a null pointer so find_pid_ns does not find
+			 * a partially initialized PID (see below).
+			 */
+			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
+					      pid_max, GFP_ATOMIC);
+		}
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
 
-- 
2.21.0

