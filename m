Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B6FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B558121019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfE2Mjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2Mjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:39:36 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E03208C3;
        Wed, 29 May 2019 12:39:33 +0000 (UTC)
Date:   Wed, 29 May 2019 08:39:30 -0400
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
Message-ID: <20190529083930.5541130e@oasis.local.home>
In-Reply-To: <20190529102038.GO2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
        <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
        <20190529083357.GF2623@hirez.programming.kicks-ass.net>
        <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
        <20190529102038.GO2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 12:20:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 29, 2019 at 11:40:34AM +0200, Daniel Bristot de Oliveira wrote:
> > On 29/05/2019 10:33, Peter Zijlstra wrote:  
> > > On Tue, May 28, 2019 at 05:16:23PM +0200, Daniel Bristot de Oliveira wrote:  
> > >> The preempt_disable/enable tracepoint only traces in the disable <-> enable
> > >> case, which is correct. But think about this case:
> > >>
> > >> ---------------------------- %< ------------------------------
> > >> 	THREAD					IRQ
> > >> 	   |					 |
> > >> preempt_disable() {
> > >>     __preempt_count_add(1)  
> > >> 	------->	    smp_apic_timer_interrupt() {  
> > >> 				preempt_disable()
> > >> 				    do not trace (preempt count >= 1)
> > >> 				    ....
> > >> 				preempt_enable()
> > >> 				    do not trace (preempt count >= 1)
> > >> 			    }
> > >>     trace_preempt_disable();
> > >> }  
> > >> ---------------------------- >% ------------------------------  
> > >>
> > >> The tracepoint will be skipped.  
> > > 
> > > .... for the IRQ. But IRQs are not preemptible anyway, so what the
> > > problem?  
> > 
> > 
> > right, they are.
> > 
> > exposing my problem in a more specific way:
> > 
> > To show in a model that an event always takes place with preemption disabled,
> > but not necessarily with IRQs disabled, it is worth having the preemption
> > disable events separated from IRQ disable ones.
> > 
> > The main reason is that, although IRQs disabled postpone the execution of the
> > scheduler, it is more pessimistic, as it also delays IRQs. So the more precise
> > the model is, the less pessimistic the analysis will be.  
> 
> I'm not sure I follow, IRQs disabled fully implies !preemptible. I don't
> see how the model would be more pessimistic than reality if it were to
> use this knowledge.
> 
> Any !0 preempt_count(), which very much includes (Hard)IRQ and SoftIRQ
> counts, means non-preemptible.

I believe I see what Daniel is talking about, but I hate the proposed
solution ;-)

First, if you care about real times that the CPU can't preempt
(preempt_count != 0 or interrupts disabled), then you want the
preempt_irqsoff tracer. The preempt_tracer is more academic where it
just shows you when we disable preemption via the counter. But even
with the preempt_irqsoff tracer you may not get the full length of time
due to the above explained race.

	__preempt_count_add(1) <-- CPU now prevents preemption

	<interrupt>
		---->
			trace_hardirqs_off() <-- Start preempt disable timer
			handler();
			trace_hardirqs_on() <-- Stop preempt disable timer (Diff A)
		<----
	trace_preempt_disable() <-- Start preempt disable timer

	[..]

	trace_preempt_enable() <-- Stop preempt disable timer (Diff B)

	__preempt_count_sub(1) <-- CPU re-enables preemption

The preempt_irqsoff tracer will break this into two parts: Diff A and
Diff B, when in reality, the total time the CPU prevented preemption
was A + B.

Note, we can have the same race if an interrupt came in just after
calling trace_preempt_enable() and before the __preempt_count_sub().

What I would recommend is adding a flag to the task_struct that gets
set before the __preempt_count_add() and cleared by the tracing
function. If an interrupt goes off during this time, it will start the
total time to record, and not end it on the trace_hardirqs_on() part.
Now since we set this flag before disabling preemption, what if we get
preempted before calling __preempt_count_add()?. Simple, have a hook in
the scheduler (just connect to the sched_switch tracepoint) that checks
that flag, and if it is set, it ends the preempt disable recording
time. Also on scheduling that task back in, if that flag is set, start
the preempt disable timer.

It may get a bit more complex, but we can contain that complexity
within the tracing code, and we don't have to do added irq disabling.

-- Steve
