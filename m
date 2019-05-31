Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66EFC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9976257A6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Nta5JwyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEaHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:47:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:47:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id x3so162146pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yFiBFS3YJewgSrxZxwvXs8opxzJGD2ag0QKFTiVhgRg=;
        b=Nta5JwyX0hwpprGGkS/wpy9JlQYD3T7/2zElvCrxLoDKX4Ynqqa406OUqBcDc4Spoh
         qeSodXsi2caRwDB1iOoIJh0uieV+6g9tcLgzBY0GkvXgVUyoJw5ehTdsQSzSjbMMqqit
         lQu4cE2zJzr3LyFEdPgKWDyPxrU789djjprFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yFiBFS3YJewgSrxZxwvXs8opxzJGD2ag0QKFTiVhgRg=;
        b=Gt/ZnHTiEHR3GQPPE5mIB6OQnOIV5hukO0QuSmCnixJnPibUN3mKaIEIm7OWWBN4O5
         49TM24xUhOKh97cmJF31W1l4lMbS+fthDT/N9NIy5ngp+bGxkEB7Pb141LdN4NPt8a+T
         bQJfPOk75BE7S9/hhAyK5BYSG16xRI3OzHdl7vBwUih6uPNtW4mrE18Dul1JdD38rmjJ
         n3TPyfYCEO7dvzsUn3Jg/lyfLMVnvK+8JHupwFon/MkDEacQ+h9A34nwbnCYj8cxN62b
         /9oWTi6XchqgtLr9XGm18IeJ2Wz1o4gEHspi5aQ4JAz7VsdUKrMvXAheyYhNMudVCDXT
         GKQw==
X-Gm-Message-State: APjAAAUii6AJeeqUfRPL6Yj7sEvicakQZWri40snWKD02iSTVvr/IcEQ
        AI67TUERkTrGCb6zqkSzj1GGZe35Tvg=
X-Google-Smtp-Source: APXvYqzK7X0E398LM5ennuL+FWZUU862/nuoH2ogPrf8tJL5MXgcHWSScVJaNPkWwni2xPYHAtZDVQ==
X-Received: by 2002:a65:5304:: with SMTP id m4mr7449105pgq.126.1559288852273;
        Fri, 31 May 2019 00:47:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h18sm4187968pgv.38.2019.05.31.00.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 00:47:30 -0700 (PDT)
Date:   Fri, 31 May 2019 03:47:29 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190531074729.GA153831@google.com>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:40:34AM +0200, Daniel Bristot de Oliveira wrote:
> On 29/05/2019 10:33, Peter Zijlstra wrote:
> > On Tue, May 28, 2019 at 05:16:23PM +0200, Daniel Bristot de Oliveira wrote:
> >> The preempt_disable/enable tracepoint only traces in the disable <-> enable
> >> case, which is correct. But think about this case:
> >>
> >> ---------------------------- %< ------------------------------
> >> 	THREAD					IRQ
> >> 	   |					 |
> >> preempt_disable() {
> >>     __preempt_count_add(1)
> >> 	------->	    smp_apic_timer_interrupt() {
> >> 				preempt_disable()
> >> 				    do not trace (preempt count >= 1)
> >> 				    ....
> >> 				preempt_enable()
> >> 				    do not trace (preempt count >= 1)
> >> 			    }
> >>     trace_preempt_disable();
> >> }
> >> ---------------------------- >% ------------------------------
> >>
> >> The tracepoint will be skipped.
> > 
> > .... for the IRQ. But IRQs are not preemptible anyway, so what the
> > problem?
> 
> 
> right, they are.
> 
> exposing my problem in a more specific way:
> 
> To show in a model that an event always takes place with preemption disabled,
> but not necessarily with IRQs disabled, it is worth having the preemption
> disable events separated from IRQ disable ones.
> 
> The main reason is that, although IRQs disabled postpone the execution of the
> scheduler, it is more pessimistic, as it also delays IRQs. So the more precise
> the model is, the less pessimistic the analysis will be.
> 
> But there are other use-cases, for instance:
> 
> (Steve, correct me if I am wrong)
> 
> The preempt_tracer will not notice a "preempt disabled" section in an IRQ
> handler if the problem above happens.
> 
> (Yeah, I know these problems are very specific... but...)

I agree with the problem. I think Daniel does not want to miss the preemption
disabled event caused by the IRQ disabling.

> >> To avoid skipping the trace, the change in the counter should be "atomic"
> >> with the start/stop, w.r.t the interrupts.
> >>
> >> Disable interrupts while the adding/starting stopping/subtracting.
> > 
> >> +static inline void preempt_add_start_latency(int val)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	raw_local_irq_save(flags);
> >> +	__preempt_count_add(val);
> >> +	preempt_latency_start(val);
> >> +	raw_local_irq_restore(flags);
> >> +}
> > 
> >> +static inline void preempt_sub_stop_latency(int val)
> >> +{
> >> +	unsigned long flags;
> >> +
> >> +	raw_local_irq_save(flags);
> >> +	preempt_latency_stop(val);
> >> +	__preempt_count_sub(val);
> >> +	raw_local_irq_restore(flags);
> >> +}
> > 
> > That is hideously expensive :/
> 
> Yeah... :-( Is there another way to provide such "atomicity"?
> 
> Can I use the argument "if one has these tracepoints enabled, they are not
> considering it as a hot-path?"

The only addition here seems to  the raw_local_irq_{save,restore} around the
calls to increment the preempt counter and start the latency tracking.

Is there any performance data with the tracepoint enabled and with/without
this patch? Like with hackbench?

Thanks.

