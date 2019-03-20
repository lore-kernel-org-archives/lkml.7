Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B029C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfCTL2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:28:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCTL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:28:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6ZOd-00028d-Un; Wed, 20 Mar 2019 12:28:36 +0100
Date:   Wed, 20 Mar 2019 12:28:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mike Galbraith <bitbucket@online.de>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Allow to eliminate softirq processing from rcutree
Message-ID: <20190320112835.prq22vsto3ecckff@linutronix.de>
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190320002613.GA129907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320002613.GA129907@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-19 20:26:13 [-0400], Joel Fernandes wrote:
> > @@ -2769,19 +2782,121 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> >  {
> >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> >  		return;
> > -	if (likely(!rcu_state.boost)) {
> > -		rcu_do_batch(rdp);
> > -		return;
> > -	}
> > -	invoke_rcu_callbacks_kthread();
> > +	rcu_do_batch(rdp);
> 
> Looks like a nice change, but one question...
> 
> Consider the case where rcunosoftirq boot option is not passed.
> 
> Before, if RCU_BOOST=y, then callbacks would be invoked in rcuc threads if
> possible, by those threads being woken up from within the softirq context
> (in invoke_rcu_callbacks).
> 
> Now, if RCU_BOOST=y, then callbacks would only be invoked in softirq context
> and not in the threads at all. Because rcu_softirq_enabled = false, so the
> path executes:
>   rcu_read_unlock_special() ->
>         raise_softirq_irqsoff() ->
>                 rcu_process_callbacks_si() ->
>                         rcu_process_callbacks() ->
>                                 invoke_rcu_callbacks() ->
>                                         rcu_do_batch()
> 
> This seems like a behavioral change to me. This makes the callbacks always
> execute from the softirq context and not the threads when boosting is
> configured. IMO in the very least, such behavioral change should be
> documented in the change.
> 
> One way to fix this I think could be, if boosting is enabled, then set
> rcu_softirq_enabled to false by default so the callbacks are still executed
> in the rcuc threads.
> 
> Did I miss something? Sorry if I did, thanks!

So with all the swaps and reorder we talking about this change:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0a719f726e149..82810483bfc6c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2306,20 +2306,6 @@ static void rcu_core_si(struct softirq_action *h)
 	rcu_core();
 }
 
-/*
- * Schedule RCU callback invocation.  If the running implementation of RCU
- * does not support RCU priority boosting, just do a direct call, otherwise
- * wake up the per-CPU kernel kthread.  Note that because we are running
- * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
- * cannot disappear out from under us.
- */
-static void invoke_rcu_callbacks(struct rcu_data *rdp)
-{
-	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
-		return;
-	rcu_do_batch(rdp);
-}
-
 static void rcu_wake_cond(struct task_struct *t, int status)
 {
 	/*
@@ -2330,6 +2316,19 @@ static void rcu_wake_cond(struct task_struct *t, int status)
 		wake_up_process(t);
 }
 
+static void invoke_rcu_core_kthread(void)
+{
+	struct task_struct *t;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
+	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
+	if (t != NULL && t != current)
+		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
+	local_irq_restore(flags);
+}
+
 static bool rcu_softirq_enabled = true;
 
 static int __init rcunosoftirq_setup(char *str)
@@ -2339,26 +2338,33 @@ static int __init rcunosoftirq_setup(char *str)
 }
 __setup("rcunosoftirq", rcunosoftirq_setup);
 
+/*
+ * Schedule RCU callback invocation.  If the running implementation of RCU
+ * does not support RCU priority boosting, just do a direct call, otherwise
+ * wake up the per-CPU kernel kthread.  Note that because we are running
+ * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
+ * cannot disappear out from under us.
+ */
+static void invoke_rcu_callbacks(struct rcu_data *rdp)
+{
+	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
+		return;
+	if (rcu_state.boost || rcu_softirq_enabled)
+		invoke_rcu_core_kthread();
+	rcu_do_batch(rdp);
+}
+
 /*
  * Wake up this CPU's rcuc kthread to do RCU core processing.
  */
 static void invoke_rcu_core(void)
 {
-	unsigned long flags;
-	struct task_struct *t;
-
 	if (!cpu_online(smp_processor_id()))
 		return;
-	if (rcu_softirq_enabled) {
+	if (rcu_softirq_enabled)
 		raise_softirq(RCU_SOFTIRQ);
-	} else {
-		local_irq_save(flags);
-		__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
-		t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
-		if (t != NULL && t != current)
-			rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
-		local_irq_restore(flags);
-	}
+	else
+		invoke_rcu_core_kthread();
 }
 
 static void rcu_cpu_kthread_park(unsigned int cpu)
@@ -2426,7 +2432,8 @@ static int __init rcu_spawn_core_kthreads(void)
 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
 	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
 		return 0;
-	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
+	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
+		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
 	return 0;
 }
 early_initcall(rcu_spawn_core_kthreads);
-- 
2.20.1

>  - Joel

Sebastian
