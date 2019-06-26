Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B6C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359EF216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4+Gr70n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFZWxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:53:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZWxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:53:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMmc2p105606;
        Wed, 26 Jun 2019 22:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=T1CZumxN3DGythKvRQMx6vSWwCTZQ6T8u7YlPa/U67c=;
 b=4+Gr70n5McxGzRF7Ux3coKwQm/FNWglkExsyyYAyxgvVWPn1JI1eCRICCFCd4zQj+NHd
 mABiM76X+wyfSroo+oC4PK5bxdFRUx4t4jwyfnFklvkg+8Fu/hzgspujoOdTKbmJTU21
 5jW9dNCiYlkpFytLPy53rhoY2BaVrCyrY57FOSJtYws/yY3r/WdHkAFclqKIemuy4/Nk
 t9QndFg9Zl7xjjoidKPJfdJMVJvHJneuHRSKGCaDS76v3KdY0/li8uWIaG02o23UI7gr
 wnxkj0AtEmfh/eX7of+O32pC68ZCQu1tEZ68F2D1umX2RWkRRejcW7fSDy0uZvB3X4EN Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqmwaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMpg0f012762;
        Wed, 26 Jun 2019 22:52:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9accxudn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QMqP0N024179;
        Wed, 26 Jun 2019 22:52:26 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 15:52:25 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [RFC PATCH 1/3] sched: Introduce new interface for scheduler soft affinity
Date:   Wed, 26 Jun 2019 15:47:16 -0700
Message-Id: <20190626224718.21973-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New system call sched_setaffinity2 is introduced for scheduler soft
affinity. It takes an extra parameter to specify hard or soft affinity,
where hard implies same as existing sched_setaffinity. New cpumask
cpus_preferred is introduced for this purpose which is always a subset of
cpus_allowed. A boolean affinity_unequal is used to store if they are
unequal for fast lookup. Setting hard affinity resets soft affinity set to
be equal to it. Soft affinity is only allowed for CFS class threads.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/sched.h                  |   5 +-
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/sched.h             |   3 +
 init/init_task.c                       |   2 +
 kernel/compat.c                        |   2 +-
 kernel/rcu/tree_plugin.h               |   3 +-
 kernel/sched/core.c                    | 167 ++++++++++++++++++++++++++++-----
 9 files changed, 162 insertions(+), 28 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e..1dccdd2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	sched_setaffinity2	__x64_sys_sched_setaffinity2
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1183741..b863fa8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -652,6 +652,8 @@ struct task_struct {
 	unsigned int			policy;
 	int				nr_cpus_allowed;
 	cpumask_t			cpus_allowed;
+	cpumask_t			cpus_preferred;
+	bool				affinity_unequal;
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1784,7 +1786,8 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 # define vcpu_is_preempted(cpu)	false
 #endif
 
-extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
+extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask,
+			      int flags);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
 #ifndef TASK_SIZE_OF
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe..147a4e5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -669,6 +669,9 @@ asmlinkage long sys_sched_rr_get_interval(pid_t pid,
 				struct __kernel_timespec __user *interval);
 asmlinkage long sys_sched_rr_get_interval_time32(pid_t pid,
 						 struct old_timespec32 __user *interval);
+asmlinkage long sys_sched_setaffinity2(pid_t pid, unsigned int len,
+				       unsigned long __user *user_mask_ptr,
+				       int flags);
 
 /* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904d..d77b366 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,11 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_sched_setaffinity2 434
+__SYSCALL(__NR_sched_setaffinity2, sys_sched_setaffinity2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index ed4ee17..f910cd5 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -52,6 +52,9 @@
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
 
+#define SCHED_HARD_AFFINITY	0
+#define SCHED_SOFT_AFFINITY	1
+
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN)
diff --git a/init/init_task.c b/init/init_task.c
index c70ef65..aa226a3 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -73,6 +73,8 @@ struct task_struct init_task
 	.normal_prio	= MAX_PRIO - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_allowed	= CPU_MASK_ALL,
+	.cpus_preferred = CPU_MASK_ALL,
+	.affinity_unequal = false,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/compat.c b/kernel/compat.c
index b5f7063..96621d7 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -226,7 +226,7 @@ COMPAT_SYSCALL_DEFINE3(sched_setaffinity, compat_pid_t, pid,
 	if (retval)
 		goto out;
 
-	retval = sched_setaffinity(pid, new_mask);
+	retval = sched_setaffinity(pid, new_mask, SCHED_HARD_AFFINITY);
 out:
 	free_cpumask_var(new_mask);
 	return retval;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765..bdff600 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2287,7 +2287,8 @@ static bool init_nocb_callback_list(struct rcu_data *rdp)
 void rcu_bind_current_to_nocb(void)
 {
 	if (cpumask_available(rcu_nocb_mask) && cpumask_weight(rcu_nocb_mask))
-		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask));
+		WARN_ON(sched_setaffinity(current->pid, rcu_nocb_mask,
+					  SCHED_HARD_AFFINITY));
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427..eca3e98b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1060,6 +1060,12 @@ void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_ma
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
+void set_cpus_preferred_common(struct task_struct *p,
+			       const struct cpumask *new_mask)
+{
+	cpumask_copy(&p->cpus_preferred, new_mask);
+}
+
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct rq *rq = task_rq(p);
@@ -1082,6 +1088,37 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, new_mask);
+	set_cpus_preferred_common(p, new_mask);
+
+	if (queued)
+		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
+	if (running)
+		set_curr_task(rq, p);
+}
+
+void do_set_cpus_preferred(struct task_struct *p,
+			   const struct cpumask *new_mask)
+{
+	struct rq *rq = task_rq(p);
+	bool queued, running;
+
+	lockdep_assert_held(&p->pi_lock);
+
+	queued = task_on_rq_queued(p);
+	running = task_current(rq, p);
+
+	if (queued) {
+		/*
+		 * Because __kthread_bind() calls this on blocked tasks without
+		 * holding rq->lock.
+		 */
+		lockdep_assert_held(&rq->lock);
+		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	}
+	if (running)
+		put_prev_task(rq, p);
+
+	set_cpus_preferred_common(p, new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1170,6 +1207,41 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	return ret;
 }
 
+static int
+__set_cpus_preferred_ptr(struct task_struct *p, const struct cpumask *new_mask)
+{
+	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	unsigned int dest_cpu;
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0;
+
+	rq = task_rq_lock(p, &rf);
+	update_rq_clock(rq);
+
+	if (p->flags & PF_KTHREAD) {
+		/*
+		 * Kernel threads are allowed on online && !active CPUs
+		 */
+		cpu_valid_mask = cpu_online_mask;
+	}
+
+	if (cpumask_equal(&p->cpus_preferred, new_mask))
+		goto out;
+
+	if (!cpumask_intersects(new_mask, cpu_valid_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	do_set_cpus_preferred(p, new_mask);
+
+out:
+	task_rq_unlock(rq, p, &rf);
+
+	return ret;
+}
+
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
 	return __set_cpus_allowed_ptr(p, new_mask, false);
@@ -4724,7 +4796,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
-long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+long sched_setaffinity(pid_t pid, const struct cpumask *in_mask, int flags)
 {
 	cpumask_var_t cpus_allowed, new_mask;
 	struct task_struct *p;
@@ -4742,6 +4814,11 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	get_task_struct(p);
 	rcu_read_unlock();
 
+	if (flags == SCHED_SOFT_AFFINITY &&
+	    p->sched_class != &fair_sched_class) {
+		retval = -EINVAL;
+		goto out_put_task;
+	}
 	if (p->flags & PF_NO_SETAFFINITY) {
 		retval = -EINVAL;
 		goto out_put_task;
@@ -4790,18 +4867,37 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
-
-	if (!retval) {
-		cpuset_cpus_allowed(p, cpus_allowed);
-		if (!cpumask_subset(new_mask, cpus_allowed)) {
-			/*
-			 * We must have raced with a concurrent cpuset
-			 * update. Just reset the cpus_allowed to the
-			 * cpuset's cpus_allowed
-			 */
-			cpumask_copy(new_mask, cpus_allowed);
-			goto again;
+	if (flags == SCHED_HARD_AFFINITY) {
+		retval = __set_cpus_allowed_ptr(p, new_mask, true);
+
+		if (!retval) {
+			cpuset_cpus_allowed(p, cpus_allowed);
+			if (!cpumask_subset(new_mask, cpus_allowed)) {
+				/*
+				 * We must have raced with a concurrent cpuset
+				 * update. Just reset the cpus_allowed to the
+				 * cpuset's cpus_allowed
+				 */
+				cpumask_copy(new_mask, cpus_allowed);
+				goto again;
+			}
+			p->affinity_unequal = false;
+		}
+	} else if (flags == SCHED_SOFT_AFFINITY) {
+		retval = __set_cpus_preferred_ptr(p, new_mask);
+		if (!retval) {
+			cpuset_cpus_allowed(p, cpus_allowed);
+			if (!cpumask_subset(new_mask, cpus_allowed)) {
+				/*
+				 * We must have raced with a concurrent cpuset
+				 * update.
+				 */
+				cpumask_and(new_mask, new_mask, cpus_allowed);
+				goto again;
+			}
+			if (!cpumask_equal(&p->cpus_allowed,
+					   &p->cpus_preferred))
+				p->affinity_unequal = true;
 		}
 	}
 out_free_new_mask:
@@ -4824,30 +4920,53 @@ static int get_user_cpu_mask(unsigned long __user *user_mask_ptr, unsigned len,
 	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
 }
 
-/**
- * sys_sched_setaffinity - set the CPU affinity of a process
- * @pid: pid of the process
- * @len: length in bytes of the bitmask pointed to by user_mask_ptr
- * @user_mask_ptr: user-space pointer to the new CPU mask
- *
- * Return: 0 on success. An error code otherwise.
- */
-SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
-		unsigned long __user *, user_mask_ptr)
+static bool
+valid_affinity_flags(int flags)
+{
+	return flags == SCHED_HARD_AFFINITY || flags == SCHED_SOFT_AFFINITY;
+}
+
+static int
+sched_setaffinity_common(pid_t pid, unsigned int len,
+			 unsigned long __user *user_mask_ptr, int flags)
 {
 	cpumask_var_t new_mask;
 	int retval;
 
+	if (!valid_affinity_flags(flags))
+		return -EINVAL;
+
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
 		return -ENOMEM;
 
 	retval = get_user_cpu_mask(user_mask_ptr, len, new_mask);
 	if (retval == 0)
-		retval = sched_setaffinity(pid, new_mask);
+		retval = sched_setaffinity(pid, new_mask, flags);
 	free_cpumask_var(new_mask);
 	return retval;
 }
 
+SYSCALL_DEFINE4(sched_setaffinity2, pid_t, pid, unsigned int, len,
+		unsigned long __user *, user_mask_ptr, int, flags)
+{
+	return sched_setaffinity_common(pid, len, user_mask_ptr, flags);
+}
+
+/**
+ * sys_sched_setaffinity - set the CPU affinity of a process
+ * @pid: pid of the process
+ * @len: length in bytes of the bitmask pointed to by user_mask_ptr
+ * @user_mask_ptr: user-space pointer to the new CPU mask
+ *
+ * Return: 0 on success. An error code otherwise.
+ */
+SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
+		unsigned long __user *, user_mask_ptr)
+{
+	return sched_setaffinity_common(pid, len, user_mask_ptr,
+					SCHED_HARD_AFFINITY);
+}
+
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
-- 
2.9.3

