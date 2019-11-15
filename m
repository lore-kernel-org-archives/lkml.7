Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B942073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573856706;
	bh=HVIIr56nYSAJIBDSratfjG4I/R8T/8LpSDDbBjkuMnE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=m8aQiaLlxmWCOhRj5VfTWvkRUHTIdquIoA4Y20AQBuUKAXjmPd/HvMHMlSCrCPU+w
	 73q4BrwG6dJLfy0lKsstKrgE2AtezZrwTVRDA+iTTQlacN7hD9pT9Oc8gMszmbNJw5
	 3zQC6BUIh240wtyNobAxUPjzZi/g/lpJoC84gssY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfKOWZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfKOWZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:25:05 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB1920733;
        Fri, 15 Nov 2019 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573856704;
        bh=HVIIr56nYSAJIBDSratfjG4I/R8T/8LpSDDbBjkuMnE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IagDsTcNy8KaWnqM5nMptvN1QrMfN1/71lWYvfqzN6Wyj4zwZ51psjkP6fmXlsmZP
         tAJAbbFy3Lamm6oUVrTTHHmvj/RkrQprGlbg3gxcEkdz2YSnpiM60+X/ABoig23lKF
         +UHydMHtlYrCeszDIAwYmG83UqhHFy/7qZiq2+1s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DAF0E35227A8; Fri, 15 Nov 2019 14:25:03 -0800 (PST)
Date:   Fri, 15 Nov 2019 14:25:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 5/7] rcu: wrap usages of rcu_read_lock_nesting
Message-ID: <20191115222503.GA2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-6-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-6-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:57PM +0000, Lai Jiangshan wrote:
> Prepare for using percpu rcu_preempt_depth on x86

This one makes a lot of sense just by itself -- I probably should have
done something like this years ago.  I hand-applied this due to conflicts
from not having the earlier commits.  Please see comments inline.
The resulting patch is at the end, so please let me know if I messed
anything up.

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/rcu/tree_exp.h    |  4 ++--
>  kernel/rcu/tree_plugin.h | 43 ++++++++++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index afa9f573b00f..dcb2124203cf 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -608,7 +608,7 @@ static void rcu_exp_handler(void *unused)
>  	 * critical section.  If also enabled or idle, immediately
>  	 * report the quiescent state, otherwise defer.
>  	 */
> -	if (!t->rcu_read_lock_nesting) {
> +	if (!rcu_preempt_depth()) {
>  		rdp->exp_deferred_qs = true;
>  		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
>  		    rcu_dynticks_curr_cpu_in_eqs()) {
> @@ -632,7 +632,7 @@ static void rcu_exp_handler(void *unused)
>  	 * can have caused this quiescent state to already have been
>  	 * reported, so we really do need to check ->expmask.
>  	 */
> -	if (t->rcu_read_lock_nesting > 0) {
> +	if (rcu_preempt_depth() > 0) {
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		if (rnp->expmask & rdp->grpmask) {
>  			rdp->exp_deferred_qs = true;
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 98644966c808..eb5906c55c8d 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -290,8 +290,8 @@ void rcu_note_context_switch(bool preempt)
>  
>  	trace_rcu_utilization(TPS("Start context switch"));
>  	lockdep_assert_irqs_disabled();
> -	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
> -	if (t->rcu_read_lock_nesting > 0 &&
> +	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
> +	if (rcu_preempt_depth() > 0 &&
>  	    !t->rcu_read_unlock_special.b.blocked) {
>  
>  		/* Possibly blocking in an RCU read-side critical section. */
> @@ -346,6 +346,21 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>  /* Bias and limit values for ->rcu_read_lock_nesting. */
>  #define RCU_NEST_PMAX (INT_MAX / 2)
>  
> +static inline void rcu_preempt_depth_inc(void)
> +{
> +	current->rcu_read_lock_nesting++;
> +}
> +
> +static inline bool rcu_preempt_depth_dec_and_test(void)
> +{
> +	return --current->rcu_read_lock_nesting == 0;
> +}

I made an rcu_preempt_depth_dec() for the time being.  Hopefully we
can get something set up to require rcu_preempt_depth_dec_and_test()
soon, but we are not there yet.

> +static inline void rcu_preempt_depth_set(int val)
> +{
> +	current->rcu_read_lock_nesting = val;
> +}

These can just be static (rather than static inline) because this .h
file is included into only one .c file.  Best to let the compiler make
the inlining decisions.

>  /*
>   * Preemptible RCU implementation for rcu_read_lock().
>   * Just increment ->rcu_read_lock_nesting, shared state will be updated
> @@ -353,9 +368,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>   */
>  void __rcu_read_lock(void)
>  {
> -	current->rcu_read_lock_nesting++;
> +	rcu_preempt_depth_inc();
>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
> -		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
> +		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
>  	barrier();  /* critical section after entry code. */
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_lock);
> @@ -371,15 +386,13 @@ void __rcu_read_unlock(void)
>  {
>  	struct task_struct *t = current;
>  
> -	if (--t->rcu_read_lock_nesting == 0) {
> +	if (rcu_preempt_depth_dec_and_test()) {
>  		barrier();  /* critical section before exit code. */
>  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>  			rcu_read_unlock_special(t);
>  	}
>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> -		int rrln = t->rcu_read_lock_nesting;
> -
> -		WARN_ON_ONCE(rrln < 0);
> +		WARN_ON_ONCE(rcu_preempt_depth() < 0);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(__rcu_read_unlock);
> @@ -531,7 +544,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
>  {
>  	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
>  		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> -	       !t->rcu_read_lock_nesting;
> +	       !rcu_preempt_depth();
>  }
>  
>  /*
> @@ -662,7 +675,7 @@ static void rcu_flavor_sched_clock_irq(int user)
>  	if (user || rcu_is_cpu_rrupt_from_idle()) {
>  		rcu_note_voluntary_context_switch(current);
>  	}
> -	if (t->rcu_read_lock_nesting > 0 ||
> +	if (rcu_preempt_depth() > 0 ||
>  	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
>  		/* No QS, force context switch if deferred. */
>  		if (rcu_preempt_need_deferred_qs(t)) {
> @@ -672,13 +685,13 @@ static void rcu_flavor_sched_clock_irq(int user)
>  	} else if (rcu_preempt_need_deferred_qs(t)) {
>  		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
>  		return;
> -	} else if (!t->rcu_read_lock_nesting) {
> +	} else if (!rcu_preempt_depth()) {
>  		rcu_qs(); /* Report immediate QS. */
>  		return;
>  	}
>  
>  	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
> -	if (t->rcu_read_lock_nesting > 0 &&
> +	if (rcu_preempt_depth() > 0 &&
>  	    __this_cpu_read(rcu_data.core_needs_qs) &&
>  	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
>  	    !t->rcu_read_unlock_special.b.need_qs &&
> @@ -699,11 +712,11 @@ void exit_rcu(void)
>  	struct task_struct *t = current;
>  
>  	if (unlikely(!list_empty(&current->rcu_node_entry))) {
> -		t->rcu_read_lock_nesting = 1;
> +		rcu_preempt_depth_set(1);
>  		barrier();
>  		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
> -	} else if (unlikely(t->rcu_read_lock_nesting)) {
> -		t->rcu_read_lock_nesting = 1;
> +	} else if (unlikely(rcu_preempt_depth())) {
> +		rcu_preempt_depth_set(1);
>  	} else {
>  		return;
>  	}
> -- 
> 2.20.1

------------------------------------------------------------------------

commit 2f19afd3450c855007e1b355df6f215a0477d809
Author: Lai Jiangshan <laijs@linux.alibaba.com>
Date:   Fri Nov 15 14:08:53 2019 -0800

    rcu: Provide wrappers for uses of ->rcu_read_lock_nesting
    
    This commit provides wrapper functions for uses of ->rcu_read_lock_nesting
    to improve readability and to ease future changes to support inlining
    of __rcu_read_lock() and __rcu_read_unlock().
    
    Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e4b77d3..6ce598d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -608,7 +608,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!t->rcu_read_lock_nesting) {
+	if (!rcu_preempt_depth()) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
@@ -632,7 +632,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (t->rcu_read_lock_nesting > 0) {
+	if (rcu_preempt_depth() > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 96dc3aa..b5605bd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -292,8 +292,8 @@ void rcu_note_context_switch(bool preempt)
 
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
-	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
-	if (t->rcu_read_lock_nesting > 0 &&
+	WARN_ON_ONCE(!preempt && rcu_preempt_depth() > 0);
+	if (rcu_preempt_depth() > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
 		/* Possibly blocking in an RCU read-side critical section. */
@@ -350,6 +350,21 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 #define RCU_NEST_NMAX (-INT_MAX / 2)
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
+static void rcu_preempt_read_enter(void)
+{
+	current->rcu_read_lock_nesting++;
+}
+
+static void rcu_preempt_read_exit(void)
+{
+	current->rcu_read_lock_nesting--;
+}
+
+static void rcu_preempt_depth_set(int val)
+{
+	current->rcu_read_lock_nesting = val;
+}
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -357,9 +372,9 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
  */
 void __rcu_read_lock(void)
 {
-	current->rcu_read_lock_nesting++;
+	rcu_preempt_read_enter();
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
+		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -375,19 +390,19 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (t->rcu_read_lock_nesting != 1) {
-		--t->rcu_read_lock_nesting;
+	if (rcu_preempt_depth() != 1) {
+		rcu_preempt_read_exit();
 	} else {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
+		rcu_preempt_depth_set(-RCU_NEST_BIAS);
 		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 		barrier();  /* ->rcu_read_unlock_special load before assign */
-		t->rcu_read_lock_nesting = 0;
+		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		int rrln = t->rcu_read_lock_nesting;
+		int rrln = rcu_preempt_depth();
 
 		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
 	}
@@ -541,7 +556,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       t->rcu_read_lock_nesting <= 0;
+	       rcu_preempt_depth() <= 0;
 }
 
 /*
@@ -554,16 +569,16 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
+	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
 	if (couldrecurse)
-		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 	if (couldrecurse)
-		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
+		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
@@ -674,7 +689,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
-	if (t->rcu_read_lock_nesting > 0 ||
+	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
 		if (rcu_preempt_need_deferred_qs(t)) {
@@ -684,13 +699,13 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!t->rcu_read_lock_nesting) {
+	} else if (!rcu_preempt_depth()) {
 		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
 
 	/* If GP is oldish, ask for help from rcu_read_unlock_special(). */
-	if (t->rcu_read_lock_nesting > 0 &&
+	if (rcu_preempt_depth() > 0 &&
 	    __this_cpu_read(rcu_data.core_needs_qs) &&
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
@@ -711,11 +726,11 @@ void exit_rcu(void)
 	struct task_struct *t = current;
 
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
-		t->rcu_read_lock_nesting = 1;
+		rcu_preempt_depth_set(1);
 		barrier();
 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
-	} else if (unlikely(t->rcu_read_lock_nesting)) {
-		t->rcu_read_lock_nesting = 1;
+	} else if (unlikely(rcu_preempt_depth())) {
+		rcu_preempt_depth_set(1);
 	} else {
 		return;
 	}
