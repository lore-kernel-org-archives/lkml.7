Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DBC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEEC2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CVYDLx8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfFEPQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:16:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41849 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfFEPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:16:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so15021276pfq.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKxYptXoHM6GLEx++P/ndvkvTbITV98BzGUYgtjyNGc=;
        b=CVYDLx8UXqMmfwpK0WdzUanmOyVxq/pzh3X6mo9qie8IM16VS95h1XZIyJbJPPbCRu
         V4Nb+3oC39AJ4ksVEyrr9NVGTdSgi6mZGzJz84gJwNja4PgLJrJ+PkHBv6OkoRIktDTF
         9D0SoWFK2vH6Eavce7El4mvZFDE3h6/2yi5C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKxYptXoHM6GLEx++P/ndvkvTbITV98BzGUYgtjyNGc=;
        b=cr3R5YBI9ZGUe4oG7qiD5KyPLM+FzwjEj+CiuQpdU0+qDQEG6Lrc8ifMboZRtYK/uW
         lB9o/JyoSLQ7wTsnEx/qmR4N2vrgHPqbsDQbW46VpcBNPJzqku/RFo9lp8DLYgIET3M1
         Stc/4zQAtCbwY2W1Pe2J+zZe8863gDL6/Sf6LfhKYcxS5R3Tt6xiqnR8b7WH871IHaFb
         S0pkACvaHVFzhDsFuiv+4IZAcD5u0jrZt3O/YuI7GPWvumG4S8q5U8x2wzwVCnuqcWae
         FUg4rYgp8bmyltz3YfbQGIaZQ3Q8eCtie7XYcK62F4qHZ7bjpJ9ACf6Ilc0t9d4zCete
         3JYw==
X-Gm-Message-State: APjAAAVrMxRIqS0PE9yiJL4eOC6+GAcfB2Wf3M+Iw95NhsGy6bFDzbhE
        zp0RVA3G5Rqg7ijX7KPwlybINw==
X-Google-Smtp-Source: APXvYqx/BcpJM8sh9cYQ2wrL9iO1YyX1O4JoNzD/1J9SHaPq34N6/gi+IVDRzJihFHdywreN+IskVg==
X-Received: by 2002:a17:90a:33c5:: with SMTP id n63mr45425792pjb.16.1559747797184;
        Wed, 05 Jun 2019 08:16:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t5sm16818610pgh.46.2019.06.05.08.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 08:16:36 -0700 (PDT)
Date:   Wed, 5 Jun 2019 11:16:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190605151634.GA31515@google.com>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190531074729.GA153831@google.com>
 <3a17724b-f903-bc18-1a35-84efd3ea90c9@redhat.com>
 <20190604110127.60f1a7eb@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604110127.60f1a7eb@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:01:27AM -0400, Steven Rostedt wrote:
> On Tue, 4 Jun 2019 12:12:36 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> > I discussed this with Steve at the Summit on the Summit (the reason why I did
> > not reply this email earlier is because I was in the conf/traveling), and he
> > also agrees with peterz, disabling and (mainly) re-enabling IRQs costs too much.
> > 
> > We need to find another way to resolve this problem (or mitigate the cost).... :-(.
> > 
> > Ideas?
> 
> I thought we talked about using flags in the pc to let us know that we
> are about to trace the preemption off?
> 
> 
> If an interrupt comes in, we check the flag:
> 
> 	irq_enter()
> 		preempt_count_add(HARDIRQ_OFFSET)
> 
> 
> Then we can have something like:
> 
> preempt_count_add(val) {
> 	int pc = preempt_count();
> 	int trace_val = TRACE_FLAG;
> 
> 	if (val == HARDIRQ_OFFSET && (pc & TRACE_FLAG)) {
> 		__preempt_count_sub(TRACE_FLAG);
> 		trace_val |= TRACE_SET;
> 	}
> 
> 	__preempt_count_add(val + trace_val);
> 	if (!pc)
> 		trace_preempt_disable();
> 	__preempt_count_sub(trace_val);
> 
> 
> And in trace_preempt_enable() we have:
> 
> 	if ((preempt_count() & TRACE_SET) && in_irq())
> 		return;
> 
> Thus, we wont call the preempt_enable tracing code if we started it due
> to an interrupt preempting the process of setting the trace.

Hmm, the interrupt handler will not be calling preempt_enable anyway since
the preempt counter was already set by the interrupted code. The situation
Daniel describes in patch 2/3 is:

---------------------------- %< ------------------------------
	THREAD					IRQ
	   |					 |
preempt_disable() {
    __preempt_count_add(1)
	------->	    smp_apic_timer_interrupt() {
				preempt_disable()
				    do not trace (preempt count >= 1)
				    ....
				preempt_enable()
				    do not trace (preempt count >= 1)
			    }
    trace_preempt_disable();
}
---------------------------- >% ------------------------------

Here the preempt_enable in the IRQ will not call tracing. If I understand
correctly, he *does* want to call tracing since the IRQ's preempt
disable/enable section could be running for some time, and so
it would not be nice to miss these events from the traces.

Regarding the preempt count flag idea, I really like your idea. I did not
fully follow the code snip you shared above though. My understanding of your
idea initially was, we set a flag in pc, then increment the preempt count,
call tracing and the reset the pc flag. In between the increment and the call
to the tracer, if we get interrupted, then we check the flag from IRQ
context, and still call tracing. If we get interrupted after calling tracing,
but before resetting the flag, then we may end up with a nested pair of
preempt enable/disable calls, but that's Ok. At least we wont miss any
events.

At least I think we only need to modify the preempt disable path, something
like this in pseudo code in the preempt disable path (of the THREAD context):

set   pc flag
inc   pc
		<--- if interrupted here, still trace from IRQ.
call  tracer
		<--- if interrupted here, still trace from IRQ.
reset pc flag
		<--- if interrupted here, no need to trace from IRQ since
		     we already recorded at least one preempt disable event.


Did I get your idea right?

I need to think about this some more, but got to run to an appointment. Will
take a look once I'm back.

> Note, I'm writing this while extremely tired (still have yet to get
> more than 4 hours of sleep) so it may still have bugs, but you should
> get the idea ;-)

No problem ;-)

thanks,

 - Joel

