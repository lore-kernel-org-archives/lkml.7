Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088FDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96D12070D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDIIxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:53:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33964 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIIxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:53:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B65FA78;
        Tue,  9 Apr 2019 01:53:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F163A3F557;
        Tue,  9 Apr 2019 01:53:32 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:53:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, jolsa@redhat.com
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190409085327.GA21979@lakrids.cambridge.arm.com>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
 <20190408082229.GI4038@hirez.programming.kicks-ass.net>
 <20190408095031.GG14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408095031.GG14281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 11:50:31AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 08, 2019 at 10:22:29AM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 08, 2019 at 09:12:28AM +0200, Thomas-Mich Richter wrote:
> 
> > > very good news, your fix ran over the weekend without any hit!!!
> > > 
> > > Thanks very much for your help. Do you submit this patch to the kernel mailing list?
> > 
> > Most excellent, let me go write a Changelog.
> 
> Hi Thomas, find below.
> 
> Sadly, while writing the Changelog I ended up with a 'completely'
> differet patch again, could I bother you to test this one too?
> 
> ---
> Subject: perf: Fix perf_event_disable_inatomic()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 4 Apr 2019 15:03:00 +0200
> 
> Thomas-Mich Richter reported he triggered a WARN from event_function_local()
> on his s390. The problem boils down to:
> 
>   CPU-A				CPU-B
> 
>   perf_event_overflow()
>     perf_event_disable_inatomic()
>       @pending_disable = 1
>       irq_work_queue();
> 
>   sched-out
>     event_sched_out()
>       @pending_disable = 0
> 
> 				sched-in
> 				perf_event_overflow()
> 				  perf_event_disable_inatomic()
> 				    @pending_disable = 1;
> 				    irq_work_queue(); // FAILS
> 
>   irq_work_run()
>     perf_pending_event()
>       if (@pending_disable)
>         perf_event_disable_local(); // WHOOPS
> 
> The problem exists in generic, but s390 is particularly sensitive
> because it doesn't implement arch_irq_work_raise(), nor does it call
> irq_work_run() from it's PMU interrupt handler (nor would that be
> sufficient in this case, because s390 also generates
> perf_event_overflow() from pmu::stop). Add to that the fact that s390
> is a virtual architecture and (virtual) CPU-A can stall long enough
> for the above race to happen, even if it would self-IPI.
> 
> Adding an irq_work_syn() to event_sched_in() would work for all hardare
> PMUs that properly use irq_work_run() but fails for software PMUs.

Typo: s/syn/sync/

> 
> Instead encode the CPU number in @pending_disable, such that we can
> tell which CPU requested the disable. This then allows us to detect
> the above scenario and even redirect the IPI to make up for the failed
> queue.
> 
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: acme@redhat.com
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Reported-by: Thomas-Mich Richter <tmricht@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I can't think of a nicer way of handling this, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/events/core.c |   52 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2009,8 +2009,8 @@ event_sched_out(struct perf_event *event
>  	event->pmu->del(event, 0);
>  	event->oncpu = -1;
>  
> -	if (event->pending_disable) {
> -		event->pending_disable = 0;
> +	if (READ_ONCE(event->pending_disable) >= 0) {
> +		WRITE_ONCE(event->pending_disable, -1);
>  		state = PERF_EVENT_STATE_OFF;
>  	}
>  	perf_event_set_state(event, state);
> @@ -2198,7 +2198,8 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
>  
>  void perf_event_disable_inatomic(struct perf_event *event)
>  {
> -	event->pending_disable = 1;
> +	WRITE_ONCE(event->pending_disable, smp_processor_id());
> +	/* can fail, see perf_pending_event_disable() */
>  	irq_work_queue(&event->pending);
>  }
>  
> @@ -5810,10 +5811,45 @@ void perf_event_wakeup(struct perf_event
>  	}
>  }
>  
> +static void perf_pending_event_disable(struct perf_event *event)
> +{
> +	int cpu = READ_ONCE(event->pending_disable);
> +
> +	if (cpu < 0)
> +		return;
> +
> +	if (cpu == smp_processor_id()) {
> +		WRITE_ONCE(event->pending_disable, -1);
> +		perf_event_disable_local(event);
> +		return;
> +	}
> +
> +	/*
> +	 *  CPU-A			CPU-B
> +	 *
> +	 *  perf_event_disable_inatomic()
> +	 *    @pending_disable = CPU-A;
> +	 *    irq_work_queue();
> +	 *
> +	 *  sched-out
> +	 *    @pending_disable = -1;
> +	 *
> +	 *				sched-in
> +	 *				perf_event_disable_inatomic()
> +	 *				  @pending_disable = CPU-B;
> +	 *				  irq_work_queue(); // FAILS
> +	 *
> +	 *  irq_work_run()
> +	 *    perf_pending_event()
> +	 *
> +	 * But the event runs on CPU-B and wants disabling there.
> +	 */
> +	irq_work_queue_on(&event->pending, cpu);
> +}
> +
>  static void perf_pending_event(struct irq_work *entry)
>  {
> -	struct perf_event *event = container_of(entry,
> -			struct perf_event, pending);
> +	struct perf_event *event = container_of(entry, struct perf_event, pending);
>  	int rctx;
>  
>  	rctx = perf_swevent_get_recursion_context();
> @@ -5822,10 +5858,7 @@ static void perf_pending_event(struct ir
>  	 * and we won't recurse 'further'.
>  	 */
>  
> -	if (event->pending_disable) {
> -		event->pending_disable = 0;
> -		perf_event_disable_local(event);
> -	}
> +	perf_pending_event_disable(event);
>  
>  	if (event->pending_wakeup) {
>  		event->pending_wakeup = 0;
> @@ -10236,6 +10269,7 @@ perf_event_alloc(struct perf_event_attr
>  
>  
>  	init_waitqueue_head(&event->waitq);
> +	event->pending_disable = -1;
>  	init_irq_work(&event->pending, perf_pending_event);
>  
>  	mutex_init(&event->mmap_mutex);
