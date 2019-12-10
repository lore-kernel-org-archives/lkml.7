Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F2CC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5392465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575952015;
	bh=4K4nv1sKgEVTq8xmM09614xBcGFIPf4ktcwU1FNDi7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g70PpCZsWvX5dRJ2dU6fkWbrCVX0tBXeQ5fzaJTfR71bEg/pvRJ4q9hYqAsm4dF9s
	 9MQyPyxFlOWvB8z63iaHgk9M9AgQ++l/HS5hsqgcLNDZKqj7rWdpT8ZAALNnPsBjSk
	 M+rCW8ZKfCvIor0dol1nDDYI9LZuYTNn6dx1G1LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLJE0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLJE0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:35 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B468B20838;
        Tue, 10 Dec 2019 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951994;
        bh=4K4nv1sKgEVTq8xmM09614xBcGFIPf4ktcwU1FNDi7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4dfInXLPO2H3vWkZQP7xDVNsi9x/qTxWpB+KyZnP/iQFWCxBB7//dvJuFfz7ZUjX
         wKFSCTlHF4x3RpXWiBtMSAw9dEPqlGkbvxj9Yc0Kj0wBi1qdIE/NOmjSN8NgAwLHgv
         u01TSOGlJDIeoHEBjCaUjL5zbAIFnq7/mJKkzFCc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/11] rcu: Make PREEMPT_RCU be a modifier to TREE_RCU
Date:   Mon,  9 Dec 2019 20:26:22 -0800
Message-Id: <20191210042629.3808-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Currently PREEMPT_RCU and TREE_RCU are mutually exclusive Kconfig
options.  But PREEMPT_RCU actually specifies a kind of TREE_RCU,
namely a preemptible TREE_RCU. This commit therefore makes PREEMPT_RCU
be a modifer to the TREE_RCU Kconfig option.  This has the benefit of
simplifying several of the #if expressions that formerly needed to
check both, but now need only check one or the other.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h   |  4 ++--
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/Kconfig         | 13 +++++++------
 kernel/rcu/Makefile        |  1 -
 kernel/rcu/rcu.h           |  2 +-
 kernel/rcu/update.c        |  2 +-
 kernel/sysctl.c            |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0b75063..70a41cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -167,7 +167,7 @@ do { \
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
  */
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 #include <linux/rcutree.h>
 #elif defined(CONFIG_TINY_RCU)
 #include <linux/rcutiny.h>
@@ -601,7 +601,7 @@ do {									      \
  * read-side critical section that would block in a !PREEMPT kernel.
  * But if you want the full story, read on!
  *
- * In non-preemptible RCU implementations (TREE_RCU and TINY_RCU),
+ * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
  * it is illegal to block while in an RCU read-side critical section.
  * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
  * kernel builds, RCU read-side critical sections may be preempted,
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 6612260..85019cf 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -41,7 +41,7 @@ TRACE_EVENT(rcu_utilization,
 	TP_printk("%s", __entry->s)
 );
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 
 /*
  * Tracepoint for grace-period events.  Takes a string identifying the
@@ -432,7 +432,7 @@ TRACE_EVENT_RCU(rcu_fqs,
 		  __entry->cpu, __entry->qsevent)
 );
 
-#endif /* #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) */
+#endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
  * Tracepoint for dyntick-idle entry/exit events.  These take a string
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 7644eda..0303934 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -7,7 +7,7 @@ menu "RCU Subsystem"
 
 config TREE_RCU
 	bool
-	default y if !PREEMPTION && SMP
+	default y if SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP system with hundreds or
@@ -17,6 +17,7 @@ config TREE_RCU
 config PREEMPT_RCU
 	bool
 	default y if PREEMPTION
+	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP systems with hundreds or
@@ -78,7 +79,7 @@ config TASKS_RCU
 	  user-mode execution as quiescent states.
 
 config RCU_STALL_COMMON
-	def_bool ( TREE_RCU || PREEMPT_RCU )
+	def_bool TREE_RCU
 	help
 	  This option enables RCU CPU stall code that is common between
 	  the TINY and TREE variants of RCU.  The purpose is to allow
@@ -86,13 +87,13 @@ config RCU_STALL_COMMON
 	  making these warnings mandatory for the tree variants.
 
 config RCU_NEED_SEGCBLIST
-	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
+	def_bool ( TREE_RCU || TREE_SRCU )
 
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
 	range 2 64 if 64BIT
 	range 2 32 if !64BIT
-	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
+	depends on TREE_RCU && RCU_EXPERT
 	default 64 if 64BIT
 	default 32 if !64BIT
 	help
@@ -112,7 +113,7 @@ config RCU_FANOUT_LEAF
 	int "Tree-based hierarchical RCU leaf-level fanout value"
 	range 2 64 if 64BIT
 	range 2 32 if !64BIT
-	depends on (TREE_RCU || PREEMPT_RCU) && RCU_EXPERT
+	depends on TREE_RCU && RCU_EXPERT
 	default 16
 	help
 	  This option controls the leaf-level fanout of hierarchical
@@ -187,7 +188,7 @@ config RCU_BOOST_DELAY
 
 config RCU_NOCB_CPU
 	bool "Offload RCU callback processing from boot-selected CPUs"
-	depends on TREE_RCU || PREEMPT_RCU
+	depends on TREE_RCU
 	depends on RCU_EXPERT || NO_HZ_FULL
 	default n
 	help
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 020e8b6..82d5fba 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -9,6 +9,5 @@ obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
-obj-$(CONFIG_PREEMPT_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ab504fb..eabafde 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -454,7 +454,7 @@ enum rcutorture_type {
 	INVALID_RCU_FLAVOR
 };
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
 void do_trace_rcu_torture_read(const char *rcutorturename,
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103..34a7452 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -435,7 +435,7 @@ struct debug_obj_descr rcuhead_debug_descr = {
 EXPORT_SYMBOL_GPL(rcuhead_debug_descr);
 #endif /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU) || defined(CONFIG_RCU_TRACE)
+#if defined(CONFIG_TREE_RCU) || defined(CONFIG_RCU_TRACE)
 void do_trace_rcu_torture_read(const char *rcutorturename, struct rcu_head *rhp,
 			       unsigned long secs,
 			       unsigned long c_old, unsigned long c)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7066593..d396aaa 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1268,7 +1268,7 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_do_static_key,
 	},
 #endif
-#if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
+#if defined(CONFIG_TREE_RCU)
 	{
 		.procname	= "panic_on_rcu_stall",
 		.data		= &sysctl_panic_on_rcu_stall,
-- 
2.9.5

