Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00833208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jLRarsIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfE2KV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:21:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2KV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eaEmReJoktuMTB5S11KlWyhQ5sxMXJSXYo6lfdIwCU0=; b=jLRarsIRHF5opjV03oHEIT31q
        L8F8AKqtF9E3O5dU3TYoZ2PkJVrTJxhCBB84PoR1ODhLVpvYh7h+xtdIoallzxZ4KfnH/rStJD6N1
        PdR5Vw2uNE/QphhjaUUH48JadN3STvyKVw4oT0iKXOtqHSzh01xpAMiRNy3AarVAzoUgFbYiC5B0O
        BSQNFWU+nT8MlbD+Jl98kL6a7TynzXrP0Ovj9PacgMBo+wDbSIiraOhEoWxaBo38Ir50RSgbTsLkl
        BECzNv7lF2m6RMtySUzSzo3H8BUUacLlIB/PoCuDBj3XzNA8GNAl/w3H9KdxwwrexhRSVKVbJpYse
        gI4unhMAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvhI-0005BK-F2; Wed, 29 May 2019 10:20:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D5E8207762A4; Wed, 29 May 2019 12:20:38 +0200 (CEST)
Date:   Wed, 29 May 2019 12:20:38 +0200
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
Message-ID: <20190529102038.GO2623@hirez.programming.kicks-ass.net>
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

I'm not sure I follow, IRQs disabled fully implies !preemptible. I don't
see how the model would be more pessimistic than reality if it were to
use this knowledge.

Any !0 preempt_count(), which very much includes (Hard)IRQ and SoftIRQ
counts, means non-preemptible.

