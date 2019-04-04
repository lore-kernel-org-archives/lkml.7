Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C8D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghU0cAfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDDLJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:09:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P9Uo0gsGIOVJBxcdSlv4TzSLV9TNxGiuBHFi22Ev8qQ=; b=ghU0cAfrcdxutybQJx/MZ6Ufb
        d8/uvy6/Mxqn9FIJZo0nQYhFIw/BzrmrLGkKcsPbdQ2hVMEyNPWcDEwM49B7cz15VSPL1YGA917/s
        tcY066G1547MwNv3SEEAqxkNXTeW3/ULA0FbQ7oERwq006PnBT7LFrhqARhiDbTtT1s6jFjWgBCRE
        Z0beoafM4F4Y38TG5yGQpWqASOeTJDe0HPq59/nWuAfM8+52COFd4mPz1sWXxXuaghGmZnSU0XeEG
        BDUvnWBaz2R0T3fo60U8UGyqXbNYWuKghNC+7/6pX94EAMmbrurGb3QW1D/KOlLZVFca5gUj2MSXw
        996V3gL2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC0F5-0000MT-Eh; Thu, 04 Apr 2019 11:09:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7C8E201AF566; Thu,  4 Apr 2019 13:09:09 +0200 (CEST)
Date:   Thu, 4 Apr 2019 13:09:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190404110909.GY4038@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:15:39AM +0200, Thomas-Mich Richter wrote:
> On 4/3/19 12:41 PM, Peter Zijlstra wrote:
> > On Wed, Apr 03, 2019 at 11:47:00AM +0200, Thomas-Mich Richter wrote:
> >> I use linux 5.1.0-rc3 on s390 and got this WARN_ON_ONCE message:
> >>
> >> WARNING: CPU: 15 PID: 0 at kernel/events/core.c:330
> >>                 event_function_local.constprop.79+0xe2/0xe8
> >>
> >> which was introduced with
> >>    commit cca2094605ef ("perf/core: Fix event_function_local()").
> >> ..snip.... 
> >>
> >> Any ideas or hints who to avoid/fix this warning?
> > 
> > Some thoughts here:
> > 
> >   https://lkml.kernel.org/r/20190213101644.GN32534@hirez.programming.kicks-ass.net
> > 
> > tl;dr, I've no frigging clue.
> > 
> 
> I have read this thread and at the end you mentioned:
> 
>     Humm, but in that case:
> 
>    context_switch()
>     prepare_task_switch()
>       perf_event_task_sched_out()
>         __perf_event_task_sched_out()
> 	  perf_event_context_sched_out()
> 	    task_ctx_sched_out()
> 	      ctx_sched_out()
> 	        group_sched_out()
> 		  event_sched_out()
> 		    if (event->pending_disable)
> 
>    Would have already cleared the pending_disable state, so the IPI would
>    not have ran perf_event_disable_local() in the first place.
> 
> Our test system is configured to panic in WARN_ON_ONCE(). I looked
> at the dump. The event triggering WARN_ON_ONCE:
> 
> crash> struct perf_event.oncpu 0x1f9b24800
>   oncpu = 0
> crash> struct perf_event.state 0x1f9b24800
>   state = PERF_EVENT_STATE_ACTIVE
> crash> 
> 
> This means the code in 
> static void event_sched_out(....)
> {
>         ....
>         event->pmu->del(event, 0);
>         event->oncpu = -1;
> 
>         if (event->pending_disable) {
>                 event->pending_disable = 0;
>                 state = PERF_EVENT_STATE_OFF;
>         }
>         perf_event_set_state(event, state);
>         ...
> }
> 
> has not finished and returned from this function. So the task was not completely context-switched
> out from CPU 0 while the interrupt handler was executing on CPU 15:
> 
> static void perf_pending_event(...)
> {
>         ....
>         if (event->pending_disable) {
>                 event->pending_disable = 0;
>                 perf_event_disable_local(event);  <--- Causes the WARN_ON_ONCE()
>         }
>         .....
> }
> 
> I think there is a race, especially when the interrupt handler on CPU 15
> was invoked via timer interrupt an runs on a different CPU.

That is not entirely the scenario I talked about, but *groan*.

So what I meant was:

	CPU-0							CPU-n

	__schedule()
	  local_irq_disable()

	  ...
	    deactivate_task(prev);

								try_to_wake_up(@p)
								  ...
								  smp_cond_load_acquire(&p->on_cpu, !VAL);

	  <PMI>
	    ..
	    perf_event_disable_inatomic()
	      event->pending_disable = 1;
	      irq_work_queue() /* self-IPI */
	  </PMI>

	  context_switch()
	    prepare_task_switch()
	      perf_event_task_sched_out()
	        // the above chain that clears pending_disable

	    finish_task_switch()
	      finish_task()
	        smp_store_release(prev->on_cpu, 0);
								  /* finally.... */
								// take woken
								// context_switch to @p
	      finish_lock_switch()
	        raw_spin_unlock_irq()
		/* w00t, IRQs enabled, self-IPI time */
	        <self-IPI>
		  perf_pending_event()
		    // event->pending_disable == 0
		</self-IPI>


What you're suggesting, is that the time between:

  smp_store_release(prev->on_cpu, 0);

and

  <self-IPI>

on CPU-0 is sufficient for CPU-n to context switch to the task, enable
the event there, trigger a PMI that calls perf_event_disable_inatomic()
_again_ (this would mean irq_work_queue() failing, which we don't check)
(and schedule out again, although that's not required).

This being virt that might actually be possible if (v)CPU-0 takes a nap
I suppose.

Let me think about this a little more...

> > Does it reproduce on x86 without virt on? I don't have a PPC LPAR to
> > test things on.
> > 
> 
> s390 LPARs run under hipervisor control, no chance to run any OS without it.

Yah, I know.. Same difference though; I also don't have an s390.
