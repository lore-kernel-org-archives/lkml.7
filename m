Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23EFC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B226D2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yWdcwTjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfG2KaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:30:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45162 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfG2KaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gjj4owKXS61+aOLcK4Kpf98oFWq8xT7RivisxYBZ5eE=; b=yWdcwTjFmfouyg41jH87v9pQg
        IctmrGHLJJw3D9Z3kKe4hUw299hYfgiWUmyqhAuJ9rqQwYaRfpZPOdSV8LofaIfrPTHa5Fd9+wzue
        +wzccYlNHT2xaP2HTCOWBY4w56DwZktDofxkSrE2A5E2LRcUE9VuMBIypjQHrk+3JJSI+AUBg62k4
        C+j6W+phAOPG+gpQJghzzmomdqSzmIxJI7eMpNEVHTAzz3xVrp/iU6ugBE4NBMafuGnzT5AdQvABq
        NmZ3egFiflgBB7P+pxU0O5W51W8bCR6EKbKMMVfZ/uoi6WHUF5azuQStAvXM+TZtFEz+NddYNV4AI
        LRmkaTSCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs2uc-0000eV-0C; Mon, 29 Jul 2019 10:29:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52ACB20AF2C34; Mon, 29 Jul 2019 12:29:48 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:29:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Eiichi Tsukata <devel@etsukata.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
Message-ID: <20190729102948.GY31381@hirez.programming.kicks-ass.net>
References: <20190729010734.3352-1-devel@etsukata.com>
 <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVavLdQ8Rp+6fmTd7kJJwvRKdaEnudaiMAu8g9ZXuNfWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 09:25:58PM -0700, Andy Lutomirski wrote:
> On Sun, Jul 28, 2019 at 6:08 PM Eiichi Tsukata <devel@etsukata.com> wrote:

> > diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> > index 4d8e99fdbbbe..031b51cb94d0 100644
> > --- a/kernel/trace/trace_preemptirq.c
> > +++ b/kernel/trace/trace_preemptirq.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/module.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/kprobes.h>
> > +#include <linux/context_tracking.h>
> >  #include "trace.h"
> >
> >  #define CREATE_TRACE_POINTS
> > @@ -49,9 +50,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
> >
> >  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
> >  {
> > +       enum ctx_state prev_state;
> > +
> >         if (this_cpu_read(tracing_irq_cpu)) {
> > -               if (!in_nmi())
> > +               if (!in_nmi()) {
> > +                       prev_state = exception_enter();
> >                         trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> > +                       exception_exit(prev_state);
> > +               }
> >                 tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
> >                 this_cpu_write(tracing_irq_cpu, 0);
> >         }
> 
> This seems a bit distressing.  Now we're going to do a whole bunch of
> context tracking transitions for each kernel entry.  Would a better
> fix me to change trace_hardirqs_on_caller to skip the trace event if
> the previous state was already IRQs on and, more importantly, to skip
> tracing IRQs off if IRQs were already off?  The x86 code is very
> careful to avoid ever having IRQs on and CONTEXT_USER at the same
> time.

I think they already (try to) do that; see 'tracing_irq_cpu'.
