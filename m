Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5270C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3E320659
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RUDJWC4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfF1QkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:40:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41719 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfF1QkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:40:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so1343579pgj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r3LVYWWZ3Y4ZYbxYAZ3gdPBDcU6tBPeALFZn5bmxzDo=;
        b=RUDJWC4gCbdZ8eBa8XMpHybehrZrDF5RGrtkaiZ3M7o5djaYdPmoDQRuOvjZJcdN+u
         8m620VARdHMZYEbqgdKsnZciaK7J8A5bhXQ2kDM0w3hexHsSXtjl/JtrLpuLZGhFuD/u
         o8zJrJAWEFAK+3QnbVnO7lFGRnbcYlDQTPe7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3LVYWWZ3Y4ZYbxYAZ3gdPBDcU6tBPeALFZn5bmxzDo=;
        b=gdYwWT7lXq6KkTWHttF7OWxymCTElcPo6ym/bLxzKqZGpJrlVQCUY7wfewH8KKx5Sh
         R6FVKFwpSRVUmpcoGoj/LOeMppWQln3HJjb49JJVsYqgqUwC77b3VwuM0N66Ykn92ym+
         HWqSUz7Lc5n5q2pE+gqXRycjUlUNA22l7P1fixgEm07ApfJF93kMAgW2NxDrmeG7feew
         95S39yv5ezTh0pgPFfYxea34MjswuV/E0wRYEC61db5WnmR75aWeHZbsobZvBHaQVec4
         1C4jj9IePGR162fLbATQI4cnlP5gGNG4TRfjcPliY5q9CwwdD4fZaSERNapoZknJiss7
         Y79w==
X-Gm-Message-State: APjAAAU5IMrRENGAeWtn+XxS0DWCfb4MpeiBbcfgb8KMJGxpG/ofEHwN
        ZDJd+Cpch8gVMi58a+aGvI2YnL8vwqcgQw==
X-Google-Smtp-Source: APXvYqwznynpitn1lZRkcN1vpoBVOPQQpHHAHwBYCm91ypZfcKpQLHpYBhZ3C646520ME1k1YdASYA==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr7800046pgn.318.1561740010386;
        Fri, 28 Jun 2019 09:40:10 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y16sm2646225pjj.25.2019.06.28.09.40.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 09:40:09 -0700 (PDT)
Date:   Fri, 28 Jun 2019 12:40:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190628164008.GB240964@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
 <20190627153031.GA249127@google.com>
 <20190627155506.GU26519@linux.ibm.com>
 <CAEXW_YSEN_OL3ftTLN=M-W70WSuCgHJqU-R9VhS=A3uVj_AL+A@mail.gmail.com>
 <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627184107.GA26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:41:07AM -0700, Paul E. McKenney wrote:
[snip]
> > > > And we should document this somewhere for future sanity preservation
> > > > :-D
> > > 
> > > Or adjust the code and requirements to make it more sane, if feasible.
> > > 
> > > My current (probably wildly unreliable) guess that the conditions in
> > > rcu_read_unlock_special() need adjusting.  I was assuming that in_irq()
> > > implies a hardirq context, in other words that in_irq() would return
> > > false from a threaded interrupt handler.  If in_irq() instead returns
> > > true from within a threaded interrupt handler, then this code in
> > > rcu_read_unlock_special() needs fixing:
> > > 
> > > 		if ((exp || in_irq()) && irqs_were_disabled && use_softirq &&
> > > 		    (in_irq() || !t->rcu_read_unlock_special.b.deferred_qs)) {
> > > 			// Using softirq, safe to awaken, and we get
> > > 			// no help from enabling irqs, unlike bh/preempt.
> > > 			raise_softirq_irqoff(RCU_SOFTIRQ);
> > > 
> > > The fix would be replacing the calls to in_irq() with something that
> > > returns true only if called from within a hardirq context.
> > > Thoughts?
> > 
> > I am not sure if this will fix all cases though?
> > 
> > I think the crux of the problem is doing a recursive wake up. The threaded
> > IRQ probably just happens to be causing it here, it seems to me this problem
> > can also occur on a non-threaded irq system (say current_reader() in your
> > example executed in a scheduler path in process-context and not from an
> > interrupt). Is that not possible?
> 
> In the non-threaded case, invoking raise_softirq*() from hardirq context
> just sets a bit in a per-CPU variable.  Now, to Sebastian's point, we
> are only sort of in hardirq context in this case due to being called
> from irq_exit(), but the failure we are seeing might well be a ways
> downstream of the actual root-cause bug.

Hi Paul,
I was talking about calling of rcu_read_unlock_special from a normal process
context from the scheduler.

In the below traces, it shows that only the PREEMPT_MASK offset is set at the
time of the issue. Both HARD AND SOFT IRQ masks are not enabled, which means
the lock up is from a normal process context.

I think I finally understood why the issue shows up only with threadirqs in
my setup. If I build x86_64_defconfig, the CONFIG_IRQ_FORCED_THREADING=y
option is set. And booting this with threadirqs, it always tries to
wakeup_ksoftirqd in invoke_softirq.

I believe what happens is, at an in-opportune time when the .blocked field is
set for the preempted task, an interrupt is received. This timing is quite in
auspicious because t->rcu_read_unlock_special just happens to have its
.blocked field set even though it is not in a reader-section.

The interrupt return path now does a wake up on ksoftirqd. The wake-up path
calls cpuacct_charge() which starts a new reader section. During the unlock
of this section though, it notices .blocked and calls unlock_special(). That
does a raise_softirq.  in_interrupt() now says it is Ok to wake up ksoftirqd.
The wake up is attempted, and we have a recursive wake up. This probably does
not happen in non-threadirqs machines because ksoftirqd is probably not woken
up a lot (invoke_softirq()).

The traces for this looks like (patch to trace it is later in email) this.
rus stands for t->read_unlock_special. "cur1" means we just locked, and
"cur2" means we are about to unlock (sorry I am weird with names):

[   19.703436] rcu_tort-85      0d.s4 19528994us : sched_waking: comm=rcu_preempt pid=10 prio=120 target_cpu=000
[   19.704770] rcu_tort-85      0d.s5 19528995us : cpuacct_charge: cur1 rus=0
[   19.705706] rcu_tort-85      0d.s5 19528995us : cpuacct_charge: cur2 rus=0
[   19.706657] rcu_tort-85      0dNs5 19528996us : sched_wakeup: comm=rcu_preempt pid=10 prio=120 target_cpu=000
[   19.707947] rcu_tort-85      0dN.1 19528997us : rcu_note_context_switch: rcu_note_context_switch preempt=1
[   19.709239] rcu_tort-85      0d..2 19528998us : sched_switch: prev_comm=rcu_torture_rea prev_pid=85 prev_prio=139 prev_state=R+ ==>0
[   19.711361] rcu_pree-10      0d..1 19529001us : rcu_note_context_switch: rcu_note_context_switch preempt=0
[   19.712714] rcu_pree-10      0d..2 19529002us : cpuacct_charge: cur1 rus=0
[   19.713640] rcu_pree-10      0d..2 19529002us : cpuacct_charge: cur2 rus=0
[   19.714612] rcu_pree-10      0d..2 19529003us : sched_switch: prev_comm=rcu_preempt prev_pid=10 prev_prio=120 prev_state=I ==> next9
[   19.716639] rcu_tort-83      0d..1 19529022us : rcu_note_context_switch: rcu_note_context_switch preempt=0
[   19.717887] rcu_tort-83      0d..2 19529023us : cpuacct_charge: cur1 rus=0
[   19.718828] rcu_tort-83      0d..2 19529023us : cpuacct_charge: cur2 rus=0
[   19.719772] rcu_tort-83      0d..2 19529023us : sched_switch: prev_comm=rcu_torture_fak prev_pid=83 prev_prio=139 prev_state=D ==> 9
[   19.721985] rcu_tort-81      0d..1 19529752us : rcu_note_context_switch: rcu_note_context_switch preempt=0
[   19.723252] rcu_tort-81      0d..2 19529752us : cpuacct_charge: cur1 rus=0
[   19.724188] rcu_tort-81      0d..2 19529752us : cpuacct_charge: cur2 rus=0
[   19.725125] rcu_tort-81      0d..2 19529753us : sched_switch: prev_comm=rcu_torture_fak prev_pid=81 prev_prio=139 prev_state=D ==> 9
[   19.727372] rcu_tort-85      0.... 19529754us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.728587] rcu_tort-85      0.... 19529754us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.729955] rcu_tort-85      0dN.2 19530008us : irq_enter: irq_enter
[   19.730821] rcu_tort-85      0dNh2 19530010us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.732106] rcu_tort-85      0dNh2 19530010us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.733464] rcu_tort-85      0dNh2 19530011us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.734713] rcu_tort-85      0dNh2 19530011us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.736051] rcu_tort-85      0dNh3 19530012us : cpuacct_charge: cur1 rus=1
[   19.736995] rcu_tort-85      0dNh3 19530012us : cpuacct_charge: cur2 rus=1
[   19.737950] rcu_tort-85      0dNh3 19530012us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.739205] rcu_tort-85      0dNh3 19530012us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.740526] rcu_tort-85      0dNh3 19530012us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.741828] rcu_tort-85      0dNh3 19530013us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.743171] rcu_tort-85      0dNh2 19530014us : irq_exit: irq_exit
[   19.743984] rcu_tort-85      0dN.2 19530014us : irq_exit: invoke_softirq: wakeup_softirqd
[   19.745002] rcu_tort-85      0dN.3 19530015us : sched_waking: comm=ksoftirqd/0 pid=9 prio=120 target_cpu=000
[   19.746383] rcu_tort-85      0dN.4 19530015us : cpuacct_charge: cur1 rus=1
[   19.747300] rcu_tort-85      0dN.4 19530016us : cpuacct_charge: cur2 rus=1
[   19.748215] rcu_tort-85      0dN.4 19530016us : __rcu_read_unlock: call rcu_read_unlock_special nest=1
[   19.749487] rcu_tort-85      0dN.4 19530016us : rcu_read_unlock_special: unlock_special nest=-2147483647 c=1
[   19.750832] rcu_tort-85      0dN.4 19530016us : raise_softirq_irqoff: raise_softirq_irqoff: waking softirqd

---8<-----------------------

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c47788fa85f9..0a8d0805c5ef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2189,6 +2189,7 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	BUG();
 
 	return 0;
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1102765f91fd..cf825503a740 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -308,6 +308,8 @@ void rcu_note_context_switch(bool preempt)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
+	trace_printk("rcu_note_context_switch preempt=%d\n", preempt);
+
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
@@ -341,6 +343,7 @@ void rcu_note_context_switch(bool preempt)
 		 * Complete exit from RCU read-side critical section on
 		 * behalf of preempted instance of __rcu_read_unlock().
 		 */
+		trace_printk("rcu_note_context_switch->unlock_special pre=%d\n", preempt);
 		rcu_read_unlock_special(t);
 		rcu_preempt_deferred_qs(t);
 	} else {
@@ -403,15 +406,19 @@ EXPORT_SYMBOL_GPL(__rcu_read_lock);
 void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
+	int prev;
 
 	if (t->rcu_read_lock_nesting != 1) {
 		--t->rcu_read_lock_nesting;
 	} else {
 		barrier();  /* critical section before exit code. */
+		prev = t->rcu_read_lock_nesting;
 		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
 		barrier();  /* assign before ->rcu_read_unlock_special load */
-		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
+		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s))) {
+			trace_printk("call rcu_read_unlock_special nest=%d\n", prev);
 			rcu_read_unlock_special(t);
+		}
 		barrier();  /* ->rcu_read_unlock_special load before assign */
 		t->rcu_read_lock_nesting = 0;
 	}
@@ -618,6 +625,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
 	bool irqs_were_disabled;
 
+	trace_printk("unlock_special nest=%d c=%d\n",t->rcu_read_lock_nesting, t==current);
+
 	/* NMI handlers cannot block and cannot safely manipulate state. */
 	if (in_nmi())
 		return;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb10383434..1caacf936466 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -340,15 +340,20 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	struct cpuacct *ca;
 	int index = CPUACCT_STAT_SYSTEM;
 	struct pt_regs *regs = task_pt_regs(tsk);
+	struct task_struct *t = current;
 
 	if (regs && user_mode(regs))
 		index = CPUACCT_STAT_USER;
 
+	tracing_on();
 	rcu_read_lock();
 
+	trace_printk("cur1 rus=%lx\n", (unsigned long)t->rcu_read_unlock_special.s);
+
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
 
+	trace_printk("cur2 rus=%lx\n", (unsigned long)t->rcu_read_unlock_special.s);
 	rcu_read_unlock();
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index a6b81c6b6bff..17402467ae31 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -311,6 +311,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		    --max_restart)
 			goto restart;
 
+		trace_printk("__do_softirq recurse: wakeup_softirqd\n");
 		wakeup_softirqd();
 	}
 
@@ -344,6 +345,7 @@ asmlinkage __visible void do_softirq(void)
  */
 void irq_enter(void)
 {
+	trace_printk("irq_enter\n");
 	rcu_irq_enter();
 	if (is_idle_task(current) && !in_interrupt()) {
 		/*
@@ -380,6 +382,7 @@ static inline void invoke_softirq(void)
 		do_softirq_own_stack();
 #endif
 	} else {
+		trace_printk("invoke_softirq: wakeup_softirqd\n");
 		wakeup_softirqd();
 	}
 }
@@ -402,6 +405,7 @@ static inline void tick_irq_exit(void)
  */
 void irq_exit(void)
 {
+	trace_printk("irq_exit\n");
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
 #else
@@ -433,8 +437,10 @@ inline void raise_softirq_irqoff(unsigned int nr)
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt()) {
+		trace_printk("raise_softirq_irqoff: waking softirqd\n");
 		wakeup_softirqd();
+	}
 }
 
 void raise_softirq(unsigned int nr)
