Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5917DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF6021872
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKgbZi0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfE2NYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:24:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2NYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UAADxwxT6tx6lBr1tunJYn8T5v+uyVuwmaIKsyOB1k8=; b=AKgbZi0KQ1t2Byq/+qYeTQlx8
        5Zk6Wh1iPXKpKZjKkRe0R461W9XyCy56UX3A2h6knc4wXd0aEWQBIcBQ5cV8dp2iMnSPn2F4sXjDs
        7U7GyCSUxopx6delIu2Odqo9AGVC2/4Y1YErsibRbj2Y7Os4fez8ueckeVNOs02iFqUmwU3Ps5Kqr
        +cSOs01pQFgYSMx15l1nxBOU98MwJiQS/8Ohw6Hp8Uyv4SRiZMPwO3KZVF+ggau43CLLZeEUlLOUl
        YG1iskTIMI6GwzZ0W8pYfWoIVl/pf8+SUXoA1A0jEvnfGBCW+hAqIvfrwpfMrYOwFMvj/o6Fva/bC
        b4TlKMLfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVyUq-00012k-4l; Wed, 29 May 2019 13:20:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91307201DB7FA; Wed, 29 May 2019 15:19:57 +0200 (CEST)
Date:   Wed, 29 May 2019 15:19:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190529131957.GV2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190529102038.GO2623@hirez.programming.kicks-ass.net>
 <20190529083930.5541130e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529083930.5541130e@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 08:39:30AM -0400, Steven Rostedt wrote:
> I believe I see what Daniel is talking about, but I hate the proposed
> solution ;-)
> 
> First, if you care about real times that the CPU can't preempt
> (preempt_count != 0 or interrupts disabled), then you want the
> preempt_irqsoff tracer. The preempt_tracer is more academic where it
> just shows you when we disable preemption via the counter. But even
> with the preempt_irqsoff tracer you may not get the full length of time
> due to the above explained race.

IOW, that tracer gives a completely 'make believe' number? What's the
point? Just delete the pure preempt tracer.

And the preempt_irqoff tracer had better also consume the IRQ events,
and if it does that it can DTRT without extra bits on, even with that
race.

Consider:

	preempt_disable()
	  preempt_count += 1;
	  <IRQ>
	    trace_irq_enter();

	    trace_irq_exit();
	  </IRQ>
	  trace_preempt_disable();

	/* does stuff */

	preempt_enable()
	  preempt_count -= 1;
	  trace_preempt_enable();

You're saying preempt_irqoff() fails to connect the two because of the
hole between trace_irq_exit() and trace_preempt_disable() ?

But trace_irq_exit() can see the raised preempt_count and set state for
trace_preempt_disable() to connect.

> What I would recommend is adding a flag to the task_struct that gets
> set before the __preempt_count_add() and cleared by the tracing
> function. If an interrupt goes off during this time, it will start the
> total time to record, and not end it on the trace_hardirqs_on() part.
> Now since we set this flag before disabling preemption, what if we get
> preempted before calling __preempt_count_add()?. Simple, have a hook in
> the scheduler (just connect to the sched_switch tracepoint) that checks
> that flag, and if it is set, it ends the preempt disable recording
> time. Also on scheduling that task back in, if that flag is set, start
> the preempt disable timer.

I don't think that works, you also have to consider softirq. And yes you
can make it more complicated, but I still don't see the point.

And none of this is relevant for Daniels model stuff. He just needs to
consider in-IRQ as !preempt.
