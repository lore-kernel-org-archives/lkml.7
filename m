Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C75C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586D229F8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfE2NmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2NmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:42:17 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15313229F7;
        Wed, 29 May 2019 13:42:16 +0000 (UTC)
Date:   Wed, 29 May 2019 09:42:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190529094213.3e344965@oasis.local.home>
In-Reply-To: <20190529131957.GV2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
        <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
        <20190529083357.GF2623@hirez.programming.kicks-ass.net>
        <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
        <20190529102038.GO2623@hirez.programming.kicks-ass.net>
        <20190529083930.5541130e@oasis.local.home>
        <20190529131957.GV2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 15:19:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 29, 2019 at 08:39:30AM -0400, Steven Rostedt wrote:
> > I believe I see what Daniel is talking about, but I hate the proposed
> > solution ;-)
> > 
> > First, if you care about real times that the CPU can't preempt
> > (preempt_count != 0 or interrupts disabled), then you want the
> > preempt_irqsoff tracer. The preempt_tracer is more academic where it
> > just shows you when we disable preemption via the counter. But even
> > with the preempt_irqsoff tracer you may not get the full length of time
> > due to the above explained race.  
> 
> IOW, that tracer gives a completely 'make believe' number? What's the
> point? Just delete the pure preempt tracer.

The preempt_tracer is there as part of the preempt_irqsoff tracer
implementation. By removing it, the only code we would remove is
displaying preemptoff as a tracer. I stated this when it was created,
that it was more of an academic exercise if you use it, but that code
was required to get preempt_irqsoff working.

> 
> And the preempt_irqoff tracer had better also consume the IRQ events,
> and if it does that it can DTRT without extra bits on, even with that
> race.
> 
> Consider:
> 
> 	preempt_disable()
> 	  preempt_count += 1;
> 	  <IRQ>
> 	    trace_irq_enter();
> 
> 	    trace_irq_exit();
> 	  </IRQ>
> 	  trace_preempt_disable();
> 
> 	/* does stuff */
> 
> 	preempt_enable()
> 	  preempt_count -= 1;
> 	  trace_preempt_enable();
> 
> You're saying preempt_irqoff() fails to connect the two because of the
> hole between trace_irq_exit() and trace_preempt_disable() ?
> 
> But trace_irq_exit() can see the raised preempt_count and set state
> for trace_preempt_disable() to connect.

That's basically what I was suggesting as the solution to this ;-)

> 
> > What I would recommend is adding a flag to the task_struct that gets
> > set before the __preempt_count_add() and cleared by the tracing
> > function. If an interrupt goes off during this time, it will start
> > the total time to record, and not end it on the trace_hardirqs_on()
> > part. Now since we set this flag before disabling preemption, what
> > if we get preempted before calling __preempt_count_add()?. Simple,
> > have a hook in the scheduler (just connect to the sched_switch
> > tracepoint) that checks that flag, and if it is set, it ends the
> > preempt disable recording time. Also on scheduling that task back
> > in, if that flag is set, start the preempt disable timer.  
> 
> I don't think that works, you also have to consider softirq. And yes
> you can make it more complicated, but I still don't see the point.

Note, there's places that disable preemption without being traced. If
we trigger only on preemption being disabled and start the "timer",
there may not be any code to stop it. That was why I recommended the
flag in the code that starts the timing.

> 
> And none of this is relevant for Daniels model stuff. He just needs to
> consider in-IRQ as !preempt.

But he does bring up an issues that preempt_irqsoff fails.

-- Steve
