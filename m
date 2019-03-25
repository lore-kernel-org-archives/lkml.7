Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HAtOT8bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfCYNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:41:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44584 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCYNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:41:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so337198pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vmZ886XeEq2t6F/JowIHIfVi6NNlD5g4LWQjuV2UsAs=;
        b=HAtOT8bPUUK6HLoHZFMCSdvQq+tBf8VlQYWxBdTc9CIeOV9GF77DFhZd0gwXC6EBF6
         KeNe3curwr/ud6HPIuYL9MeN0Czr68cwiJn9L8f/VQQf7g62Ii0bteihNgyGQhvyO/1Y
         2pfrGw2A5/gNq0kEaTsAWe+AeXujObl0kruY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vmZ886XeEq2t6F/JowIHIfVi6NNlD5g4LWQjuV2UsAs=;
        b=GxvokYppBZuwXHnxrHHVQoEuRnlJvekYTERQ9Sg9VwzTsWaUwa/Lh+LLy31KNdnhtc
         iNi3syud8vKzTlY9YdXc1d6UrxIjLVwPiqvn0i6clvi75CjJfp8IEDSozLDgMz3ARrFZ
         KOvHy0lfk0kwtG/5Et1tGgaD4tWAi3XQoynpCE5isQG0bpzB8zeOjzvhffKGC4dmzjXC
         SuAOPblJYlWxug5tdVFuEnKLt70GOTZXRluu8oLgTsJFj3Ca4ORyYEyratIhfjUhTs6E
         l05pn315rUK/z3lxtt1lCAoctK8ADfH4fm0pCQYGU2zi18s3XFFRY6YbDGByPw5O2Dpa
         BNjQ==
X-Gm-Message-State: APjAAAXTypO0HI178izyjFRtGbfm3/qQg9oQlevsnNOJ23zqc+2lee5D
        +6zxZO9GxMfM2V5kyUYYysd0bA==
X-Google-Smtp-Source: APXvYqwGB7NOycumzzY72q+dCcov1K4cdEOFY7Du6yDuNZA2EAHQ1qL4WwuCykSwLwz9s9fdTY52Ag==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr23169501pgv.339.1553521291764;
        Mon, 25 Mar 2019 06:41:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e21sm10288619pfd.177.2019.03.25.06.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 06:41:30 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:41:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190325134129.GB182885@google.com>
References: <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190322234819.GA99360@google.com>
 <20190323002519.GV4102@linux.ibm.com>
 <20190323161002.GA17112@linux.ibm.com>
 <20190324234211.GA28064@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324234211.GA28064@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 04:42:11PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 23, 2019 at 09:10:02AM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 22, 2019 at 05:25:19PM -0700, Paul E. McKenney wrote:
> > > On Fri, Mar 22, 2019 at 07:48:19PM -0400, Joel Fernandes wrote:
> > > > On Wed, Mar 20, 2019 at 10:13:33PM +0100, Sebastian Andrzej Siewior wrote:
> > > > > Running RCU out of softirq is a problem for some workloads that would
> > > > > like to manage RCU core processing independently of other softirq
> > > > > work, for example, setting kthread priority.  This commit therefore
> > > > > introduces the `rcunosoftirq' option which moves the RCU core work
> > > > > from softirq to a per-CPU/per-flavor SCHED_OTHER kthread named rcuc.
> > > > > The SCHED_OTHER approach avoids the scalability problems that appeared
> > > > > with the earlier attempt to move RCU core processing to from softirq
> > > > > to kthreads.  That said, kernels built with RCU_BOOST=y will run the
> > > > > rcuc kthreads at the RCU-boosting priority.
> > > > [snip]
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 0f31b79eb6761..05a1e42fdaf10 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -51,6 +51,12 @@
> > > > >  #include <linux/tick.h>
> > > > >  #include <linux/sysrq.h>
> > > > >  #include <linux/kprobes.h>
> > > > > +#include <linux/gfp.h>
> > > > > +#include <linux/oom.h>
> > > > > +#include <linux/smpboot.h>
> > > > > +#include <linux/jiffies.h>
> > > > > +#include <linux/sched/isolation.h>
> > > > > +#include "../time/tick-internal.h"
> > > > >  
> > > > >  #include "tree.h"
> > > > >  #include "rcu.h"
> > > > > @@ -92,6 +98,9 @@ struct rcu_state rcu_state = {
> > > > >  /* Dump rcu_node combining tree at boot to verify correct setup. */
> > > > >  static bool dump_tree;
> > > > >  module_param(dump_tree, bool, 0444);
> > > > > +/* Move RCU_SOFTIRQ to rcuc kthreads. */
> > > > > +static bool use_softirq = 1;
> > > > > +module_param(use_softirq, bool, 0444);
> > > > >  /* Control rcu_node-tree auto-balancing at boot time. */
> > > > >  static bool rcu_fanout_exact;
> > > > >  module_param(rcu_fanout_exact, bool, 0444);
> > > > > @@ -2253,7 +2262,7 @@ void rcu_force_quiescent_state(void)
> > > > >  EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
> > > > >  
> > > > >  /* Perform RCU core processing work for the current CPU.  */
> > > > > -static __latent_entropy void rcu_core(struct softirq_action *unused)
> > > > > +static __latent_entropy void rcu_core(void)
> > > > >  {
> > > > >  	unsigned long flags;
> > > > >  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> > > > > @@ -2295,6 +2304,34 @@ static __latent_entropy void rcu_core(struct softirq_action *unused)
> > > > >  	trace_rcu_utilization(TPS("End RCU core"));
> > > > >  }
> > > > >  
> > > > > +static void rcu_core_si(struct softirq_action *h)
> > > > > +{
> > > > > +	rcu_core();
> > > > > +}
> > > > > +
> > > > > +static void rcu_wake_cond(struct task_struct *t, int status)
> > > > > +{
> > > > > +	/*
> > > > > +	 * If the thread is yielding, only wake it when this
> > > > > +	 * is invoked from idle
> > > > > +	 */
> > > > > +	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> > > > > +		wake_up_process(t);
> > > > > +}
> > > > > +
> > > > > +static void invoke_rcu_core_kthread(void)
> > > > > +{
> > > > > +	struct task_struct *t;
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	local_irq_save(flags);
> > > > > +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> > > > > +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> > > > > +	if (t != NULL && t != current)
> > > > > +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> > > > > +	local_irq_restore(flags);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Schedule RCU callback invocation.  If the running implementation of RCU
> > > > >   * does not support RCU priority boosting, just do a direct call, otherwise
> > > > > @@ -2306,19 +2343,95 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > > > >  {
> > > > >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > > > >  		return;
> > > > > -	if (likely(!rcu_state.boost)) {
> > > > > -		rcu_do_batch(rdp);
> > > > > -		return;
> > > > > -	}
> > > > > -	invoke_rcu_callbacks_kthread();
> > > > > +	if (rcu_state.boost || !use_softirq)
> > > > > +		invoke_rcu_core_kthread();
> > > > > +	rcu_do_batch(rdp);
> > > > 
> > > > Shouldn't there be an else before the rcu_do_batch? If we are waking up the
> > > > rcuc thread, then that will do the rcu_do_batch when it runs right?
> > > > 
> > > > Something like:
> > > > 	if (rcu_state.boost || !use_softirq)
> > > > 		invoke_rcu_core_kthread();
> > > > 	else
> > > > 		rcu_do_batch(rdp);
> > > > 
> > > > Previous code similarly had a return; also.
> > > 
> > > I believe that you are correct, so I will give it a shot.  Good eyes!
> > 
> > Yet rcutorture disagrees.  Actually, if we are using rcuc kthreads, this
> > is only ever invoked from within tha thread, so the only check we need is
> > for the scheduler being operational.  I am therefore trying this one out.
> > 
> > Thoughts?
> 
> And rcutorture likes this one, though at this point this function should
> be pulled into its sole callsite.  ;-)

Great, I'm glad the testing is going well.

By the way I enlightened that jitter.sh script about CPU offline issues as
well (sent patch last week).  Let me know if you agree with it.

thanks!

 - Joel

