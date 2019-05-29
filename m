Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55259C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8E24061
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YIfCt4yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfE2SWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:22:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38610 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=46u7yWH7SEbkA+LGUDG+c1CeWmaboYlcCKtUzEnRpo8=; b=YIfCt4yrE3A4keXkYIi7JRIyx
        DIgQER+VsVxJJ0t+VdSGG6VF0tK5H87d+mbDQYY7AzUdJK3zGlBl/1jWQ41sDtNqQmkwRDdyJgkyZ
        Sjp/L/jB8y2DFH0nTYWSiJ9X+goO9gGWW/HirZu+iT/ufJdU/BitgcUik6T3/D+APf8LdmemSFnB0
        LsvI4AJ7OtILMHg4O8Q7c0XLb0A6sr1UVAwhvRK5GFMjo00KZwdKGdk8tO6UqbqvAsSNMWrAXf+81
        ckcngmi+jYUFgs3mMddy/Q3Y+7oxDixoE+OAPeR3AHX083gVTIU2TkIjSUWXeLe1ZRW8SbIZx7q/p
        DLuA+3JHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW3Cp-0000m8-Va; Wed, 29 May 2019 18:21:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1B03201B3992; Wed, 29 May 2019 20:21:42 +0200 (CEST)
Date:   Wed, 29 May 2019 20:21:42 +0200
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
Message-ID: <20190529182142.GF2623@hirez.programming.kicks-ass.net>
References: <cover.1559051152.git.bristot@redhat.com>
 <f2ca7336162b6dc45f413cfe4e0056e6aa32e7ed.1559051152.git.bristot@redhat.com>
 <20190529083357.GF2623@hirez.programming.kicks-ass.net>
 <b47631c3-d65a-4506-098a-355c8cf50601@redhat.com>
 <20190529102038.GO2623@hirez.programming.kicks-ass.net>
 <94669b5a-06dd-e9bf-cfb6-b5d507a90946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94669b5a-06dd-e9bf-cfb6-b5d507a90946@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:51:31PM +0200, Daniel Bristot de Oliveira wrote:
> On 29/05/2019 12:20, Peter Zijlstra wrote:

> > I'm not sure I follow, IRQs disabled fully implies !preemptible. I don't
> > see how the model would be more pessimistic than reality if it were to
> > use this knowledge.
> 
> Maybe I did not expressed myself well... and the example was not good either.
> 
> "IRQs disabled fully implies !preemptible" is a "to big" step. In modeling (or
> mathematical reasoning?), a good practice is to break the properties into small
> piece, and then build more complex reasoning/implications using these "small
> properties."
> 
> Doing "big steps" makes you prone "miss interpretations", creating ambiguity.
> Then, -RT people are prone to be pessimist, non-RT optimistic, and so on... and
> that is what models try to avoid.

You already construct the big model out of small generators, this is
just one more of those little generators.

> For instance, explaining this using words is contradictory:>
> > Any !0 preempt_count(), which very much includes (Hard)IRQ and SoftIRQ
> > counts, means non-preemptible.
> 
> One might argue that, the preemption of a thread always takes place with
> preempt_count() != 0, because __schedule() is always called with preemption
> disabled, so the preemption takes place while in non-preemptive.

Yeah, I know about that one; you've used it in your talks. Also, you've
modeled the schedule preempt disable as a special state. If you want we
can actually make it a special bit in the preempt_count word too, the
patch shouldn't be too hard, although it would make no practical
difference.

> - WAIT But you (daniel) wants to fake the atomicity between preempt_disable and
> its tracepoint!
> 
> Yes, I do, but this is a very straightforward step/assumption: the atomicity is
> about the real-event and the tracepoint that notifies it. It is not about two
> different events.
> 
> That is why it is worth letting the modeling rules to clarify the behavior of
> system, without doing non-obvious implication in the code part, so we can have a
> model that fits better in the Linux actions/events to avoid ambiguity.

You can easily build a little shim betwen the model and the tracehooks
that fix this up if you don't want to stick it in the model proper.

All the information is there. Heck you can even do that 3/3 thing
internally I think.
