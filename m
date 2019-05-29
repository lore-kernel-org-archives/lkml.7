Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F71C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB40B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dNeWGeHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE2IfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:35:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfE2IfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n7yoVkhKpAqi+lqCMTPRH0YV1JfvuDb3vl6aJ/78F2g=; b=dNeWGeHlt/e1Aj/mSEc3wilX7
        kMnI9uP0ujtPmAUt+RNwXBVjMxK1v01Teu17CJgIBx5o22KKzpUtMlTZ5ifv4FO90xSozEVyyZGpV
        Z0S89tDNA/INzYRs/YW1suB3njaOOwvbQXVXIlHW6h0Vz3B8ARo88NUoWolIe7HlA/GEWOw/HTZQe
        4SJyHemdSSjunl50faFlyf0KKVYfOI4Y/TDFbDbgu6TMAFyTh65tRB+cfrv3Jtn/PgO2YWa/7a7P8
        EA6yLGu9NYTDH+u1CzgPJKSx00X2Bq0IZdNqFGeJUclAmP+4yo341kw86K8CkVagwYQfdr0JW/C5W
        sHFdBAj9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVu23-0006jN-SI; Wed, 29 May 2019 08:34:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C66AB201A7E41; Wed, 29 May 2019 10:33:57 +0200 (CEST)
Date:   Wed, 29 May 2019 10:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 2/3] preempt_tracer: Disable IRQ while starting/stopping
 due to a preempt_counter change
Message-ID: <20190529083357.GF2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:16:23PM +0200, Daniel Bristot de Oliveira wrote:
> The preempt_disable/enable tracepoint only traces in the disable <-> enable
> case, which is correct. But think about this case:
> 
> ---------------------------- %< ------------------------------
> 	THREAD					IRQ
> 	   |					 |
> preempt_disable() {
>     __preempt_count_add(1)
> 	------->	    smp_apic_timer_interrupt() {
> 				preempt_disable()
> 				    do not trace (preempt count >= 1)
> 				    ....
> 				preempt_enable()
> 				    do not trace (preempt count >= 1)
> 			    }
>     trace_preempt_disable();
> }
> ---------------------------- >% ------------------------------
> 
> The tracepoint will be skipped.

.... for the IRQ. But IRQs are not preemptible anyway, so what the
problem?

> To avoid skipping the trace, the change in the counter should be "atomic"
> with the start/stop, w.r.t the interrupts.
> 
> Disable interrupts while the adding/starting stopping/subtracting.

> +static inline void preempt_add_start_latency(int val)
> +{
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	__preempt_count_add(val);
> +	preempt_latency_start(val);
> +	raw_local_irq_restore(flags);
> +}

> +static inline void preempt_sub_stop_latency(int val)
> +{
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	preempt_latency_stop(val);
> +	__preempt_count_sub(val);
> +	raw_local_irq_restore(flags);
> +}

That is hideously expensive :/
