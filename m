Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9508C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC752145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfGAAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 20:41:26 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:39602 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfGAAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:41:26 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 1 Jul 2019 09:41:24 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 1 Jul 2019 09:41:24 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH v3] rcu: Change return type of rcu_spawn_one_boost_kthread()
Date:   Mon,  1 Jul 2019 09:40:39 +0900
Message-Id: <1561941639-14318-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tested again if the WARN_ON_ONCE() is fired with my box.

And it was OK.

Thanks,
Byungchul

Changes from v2
-. Port the patch to a1af11a24cb0 (Paul's request)
-. Add a few new lines for a better look

Changes from v1
-. WARN_ON_ONCE() on failing to create rcu_boost_kthread.
-. Changed title and commit message a bit.

---8<---
From 20c934c5657a7a0f13ebb050ffd350d4174965d0 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 1 Jul 2019 09:27:15 +0900
Subject: [PATCH v3] rcu: Change return type of rcu_spawn_one_boost_kthread()

The return value of rcu_spawn_one_boost_kthread() is not used any
longer. Change return type of that function from int to void.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree_plugin.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c588ef9..b8eea22 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1119,7 +1119,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  * already exist.  We only create this kthread for preemptible RCU.
  * Returns zero if all is well, a negated errno otherwise.
  */
-static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
@@ -1127,25 +1127,27 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return 0;
+		return;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
-		return 0;
+		return;
 
 	rcu_state.boost = 1;
+
 	if (rnp->boost_kthread_task != NULL)
-		return 0;
+		return;
+
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
-	if (IS_ERR(t))
-		return PTR_ERR(t);
+	if (WARN_ON_ONCE(IS_ERR(t)))
+		return;
+
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
-	return 0;
 }
 
 /*
@@ -1186,7 +1188,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1196,7 +1198,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
-- 
1.9.1

