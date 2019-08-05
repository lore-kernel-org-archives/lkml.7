Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC46C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B52067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D1Oaua35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfHEIGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:06:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ewu2VQx7ohjTv9REeCE3iKUZBfpdE7LS97SwyPI4rIw=; b=D1Oaua359olNxByaLu35WaYTo
        FT+J/OtFJoqrh9db+zAMRPY6k+7jQvK6iZZ9a2jOdSZefPYgoRUH6nZaprzobOz6Z1PeZnFIPgrTd
        tidbMsv01HsuBxh6nlh+YCNuNYJfLBUprxLm1Kk+2KjE4XwtMHGHq4B8PGM3RyZ8mrbqd0+4r8ZzY
        0MKckdEJLExMYwDX96KrnpyfpkdHFKlcGITdNPz6x+j/ka40TqCGA3GpVZ7PmNbtU2C9G9794abN6
        z+V4BWMtUEMEZGd6hDfGB8fr6Y1dSDjnjBqjRS04/VhLYOly7X1QSbC9y3gc0zEHY5NdyTvnc+xdg
        zK0SjYHmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huXzp-0006NN-Im; Mon, 05 Aug 2019 08:05:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBCA920268334; Mon,  5 Aug 2019 10:05:31 +0200 (CEST)
Date:   Mon, 5 Aug 2019 10:05:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190805080531.GH2349@hirez.programming.kicks-ass.net>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804184159.GC28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 11:41:59AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 04, 2019 at 04:48:35PM +0200, Peter Zijlstra wrote:
> > On Sun, Aug 04, 2019 at 04:43:17PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > > > The multi_cpu_stop() function relies on the scheduler to gain control from
> > > > whatever is running on the various online CPUs, including any nohz_full
> > > > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > > > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > > > and can also result in RCU CPU stall warnings.  This commit therefore
> > > > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > > > online CPUs.
> > > 
> > > This sounds wrong; should we be fixing sched_can_stop_tick() instead to
> > > return false when the stop task is runnable?
> 
> Agreed.  However, it is proving surprisingly hard to come up with a
> code sequence that has the effect of rcu_nocb without nohz_full.
> And rcu_nocb works just fine.  With nohz_full also in place, I am
> decreasing the failure rate, but it still fails, perhaps a few times
> per hour of TREE04 rcutorture on an eight-CPU system.  (My 12-CPU
> system stubbornly refuses to fail.  Good thing I kept the eight-CPU
> system around, I guess.)
> 
> When I arrive at some sequence of actions that actually work reliably,
> then by all means let's put it somewhere in the NO_HZ_FULL machinery!

I'm confused; what are you arguing? The patch as proposed is just wrong,
it needs to go.

> > And even without that; I don't understand how we're not instantly
> > preempted the moment we enqueue the stop task.
> 
> There is no preemption because CONFIG_PREEMPT=n for the scenarios still

That doesn't make sense; even with CONFIG_PREEMPT=n we set
TIF_NEED_RESCHED. We'll just not react to it as promptly (only explicit
rescheduling points and return to userspace). Enabling the tick will not
make any difference what so ever.

Tick based preemption will not 'fix' the lack of wakeup preemption. If
the stop task wakeup didn't set TIF_NEED_RESCHED, the OTHER/CFS tick
will not either.

> having trouble.  Yes, there are cond_resched() calls, but they don't do
> anything unless the appropriate flags are set, which won't always happen
> without the tick, apparently.  Or without -something- that isn't always
> happening as it should.

Right; so clearly we're not understanding what's happening. That seems
like a requirement for actually doing a patch.

> > Any enqueue, should go through check_preempt_curr() which will be an
> > instant resched_curr() when we just woke the stop class.
> 
> I did try hitting all of the CPUs with resched_cpu().  Ten times on each
> CPU with a ten-jiffy wait between each.  This might have decreased the
> probability of excessively long CPU-stopper waits by a factor of two or
> three, but it did not eliminate the excessively long waits.
> 
> What else should I try?
> 
> For example, are there any diagnostics I could collect, say from within
> the CPU stopper when things are taking too long?  I see CPU-stopper
> delays in excess of five -minutes-, so this is anything but subtle.

Catch the whole thing in a function trace?

The chain that should instantly set TIF_NEED_RESCHED:

  stop_machine()
    stop_machine_cpuslocked()
      stop_cpus()
        __stop_cpus()
          queue_stop_cpus_work()
            cpu_stop_queue_work()
	      wake_up_q()
	        wake_up_process()


  wake_up_process()
    try_to_wake_up()
      ttwu_queue()
        ttwu_queue_remote()
	  <- scheduler_ipi()
	    sched_ttwu_pending()
	      ttwu_do_activate()

        ttwu_do_activate()
	  activate_task()
	  ttwu_do_wakeup()
	    check_preempt_curr()
	      resched_curr()

You could frob some tracing into __stop_cpus(), before
wait_for_completion(), at that point all the CPUs in @cpumask should
either be running the stop task or have TIF_NEED_RESCHED set.


