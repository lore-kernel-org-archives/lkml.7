Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8897CC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6FE25CC4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfE3PTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:19:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbfE3PTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:19:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UFIV3Q008227;
        Thu, 30 May 2019 11:18:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfmrxj8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:54 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x4UFIqYt009838;
        Thu, 30 May 2019 11:18:52 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfmrxhxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 11:18:52 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4UDHUFu009286;
        Thu, 30 May 2019 13:18:37 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 2spwb96ts0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 13:18:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UFHCPZ31653968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:17:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 706D2B207A;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4442BB2074;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:17:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C87E816C5DA2; Thu, 30 May 2019 08:17:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 12/21] rcutorture: Add trivial RCU implementation
Date:   Thu, 30 May 2019 08:17:03 -0700
Message-Id: <20190530151712.1612-12-paulmck@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530151650.GA422@linux.ibm.com>
References: <20190530151650.GA422@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been showing off a trivial RCU implementation for non-preemptive
environments for some time now:

	#define rcu_read_lock()
	#define rcu_read_unlock()
	#define rcu_dereference(p) READ_ONCE(p)
	#define rcu_assign_pointer(p, v) smp_store_release(&(p), (v))
	void synchronize_rcu(void)
	{
	int cpu;
		for_each_online_cpu(cpu)
			sched_setaffinity(current->pid, cpumask_of(cpu));
	}

Trivial or not, as the old saying goes, "if it ain't tested, it don't
work!".  This commit therefore adds a "trivial" flavor to rcutorture
and a corresponding TRIVIAL test scenario.  This variant does not handle
CPU hotplug, which is unconditionally enabled on x86 for post-v5.1-rc3
kernels, which is why the TRIVIAL.boot says "rcutorture.onoff_interval=0".
This commit actually does handle CONFIG_PREEMPT=y kernels, but only
because it turns back the Linux-kernel clock in order to provide these
alternative definitions (or the moral equivalent thereof):

	#define rcu_read_lock() preempt_disable()
	#define rcu_read_unlock() preempt_enable()

In CONFIG_PREEMPT=n kernels without debugging, these are equivalent to
empty macros give or take a compiler barrier.  However, the have been
successfully tested with actual empty macros as well.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
[ paulmck: Fix symbol issue reported by kbuild test robot <lkp@intel.com>. ]
[ paulmck: Work around sched_setaffinity() issue noted by Andrea Parri. ]
[ paulmck: Add rcutorture.shuffle_interval=0 to TRIVIAL.boot to fix
  interaction with shuffler task noted by Peter Zijlstra. ]
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 kernel/rcu/rcu.h                              |  5 +++
 kernel/rcu/rcutorture.c                       | 45 ++++++++++++++++++-
 kernel/rcu/update.c                           | 13 ++++++
 .../selftests/rcutorture/configs/rcu/TRIVIAL  | 14 ++++++
 .../rcutorture/configs/rcu/TRIVIAL.boot       |  3 ++
 5 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 390aab20115e..5290b01de534 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -446,6 +446,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t);
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
+	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
 };
@@ -479,6 +480,10 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
+long rcutorture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask);
+#endif
+
 #ifdef CONFIG_TINY_SRCU
 
 static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a3f5488a319a..6b803fb2f7ca 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -672,6 +672,47 @@ static struct rcu_torture_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for trivial CONFIG_PREEMPT=n-only torture testing.
+ * This implementation does not necessarily work well with CPU hotplug.
+ */
+
+static void synchronize_rcu_trivial(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
+		WARN_ON_ONCE(raw_smp_processor_id() != cpu);
+	}
+}
+
+static int rcu_torture_read_lock_trivial(void) __acquires(RCU)
+{
+	preempt_disable();
+	return 0;
+}
+
+static void rcu_torture_read_unlock_trivial(int idx) __releases(RCU)
+{
+	preempt_enable();
+}
+
+static struct rcu_torture_ops trivial_ops = {
+	.ttype		= RCU_TRIVIAL_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= rcu_torture_read_lock_trivial,
+	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
+	.readunlock	= rcu_torture_read_unlock_trivial,
+	.get_gp_seq	= rcu_no_completed,
+	.sync		= synchronize_rcu_trivial,
+	.exp_sync	= synchronize_rcu_trivial,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.name		= "trivial"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1789,6 +1830,8 @@ static void rcu_torture_fwd_prog_cr(void)
 
 	if (READ_ONCE(rcu_fwd_emergency_stop))
 		return; /* Get out of the way quickly, no GP wait! */
+	if (!cur_ops->call)
+		return; /* Can't do call_rcu() fwd prog without ->call. */
 
 	/* Loop continuously posting RCU callbacks. */
 	WRITE_ONCE(rcu_fwd_cb_nodelay, true);
@@ -2265,7 +2308,7 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops,
+		&busted_srcud_ops, &tasks_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c3bf44ba42e5..61df2bf08563 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -423,6 +423,19 @@ EXPORT_SYMBOL_GPL(do_trace_rcu_torture_read);
 	do { } while (0)
 #endif
 
+#if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
+/* Get rcutorture access to sched_setaffinity(). */
+long rcutorture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
+{
+	int ret;
+
+	ret = sched_setaffinity(pid, in_mask);
+	WARN_ONCE(ret, "%s: sched_setaffinity() returned %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
+#endif
+
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_suppress __read_mostly; /* 1 = suppress stall warnings. */
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
new file mode 100644
index 000000000000..4d8eb5bfb6f6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL
@@ -0,0 +1,14 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot
new file mode 100644
index 000000000000..7017f5f5a55f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL.boot
@@ -0,0 +1,3 @@
+rcutorture.torture_type=trivial
+rcutorture.onoff_interval=0
+rcutorture.shuffle_interval=0
-- 
2.17.1

