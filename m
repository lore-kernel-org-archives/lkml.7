Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6FAC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60AE2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfG3B7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfG3B7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:59:47 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C65E206E0;
        Tue, 30 Jul 2019 01:59:45 +0000 (UTC)
Date:   Mon, 29 Jul 2019 21:59:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
Message-ID: <20190729215943.63ff2081@oasis.local.home>
In-Reply-To: <d8384113-a5a7-4370-e7fb-a6c4b88325e1@etsukata.com>
References: <20190729010734.3352-1-devel@etsukata.com>
        <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
        <20190729102948.GY31381@hirez.programming.kicks-ass.net>
        <d8384113-a5a7-4370-e7fb-a6c4b88325e1@etsukata.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 10:50:36 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> > 
> > I think they already (try to) do that; see 'tracing_irq_cpu'.
> >   
> 
> Or you mean something like this?
> As for trace_hardirqs_off_caller:

You missed what Peter said.

> 
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 4d8e99fdbbbe..d39478bcf0f2 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -66,7 +66,7 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
>         if (!this_cpu_read(tracing_irq_cpu)) {
                             ^^^^^^^^^^^^^^^
The above makes this called only the first time we disable interrupts.

>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
> -               if (!in_nmi())
> +               if (!in_nmi() && !irqs_disabled())

This would always be false. This function is always called with irqs_disabled()!

So no, this is not what is meant.

>                         trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
>         }
> 
> Or
> 
> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> index 4d8e99fdbbbe..e08c5c6ff2b3 100644
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -66,8 +66,6 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
>         if (!this_cpu_read(tracing_irq_cpu)) {
>                 this_cpu_write(tracing_irq_cpu, 1);
>                 tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
> -               if (!in_nmi())
> -                       trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);

And this just removes the tracepoint completely?

-- Steve

>         }
> 
> 
> As for trace_hardirqs_on_caller, it is called when IRQs off and CONTEXT_USER.
> So even though we skipped the trace event if the previous state was already IRQs on,
> we will fall into the same situation.

