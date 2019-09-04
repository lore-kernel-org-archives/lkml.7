Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0665C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1972339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567606278;
	bh=rFvqx1t57nbc+Hg21OUbKEcYTo2/giLTrk1qEwOXB0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=InKLdT6trhj45WIKy7D+aaq2GF9jsQpFojoULrKk4TK7223UVFLcMbn3pYKrvTece
	 7BNl9NEX+S41UhKyueAAg55+1QwxqqYKGoI6sqArnQVFul2nE4VFsk5VhNbWfG8X7D
	 oPVlGQNYNm+vYyeYHLtSkrV025dVqy7BNWzACA9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfIDOLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbfIDOLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:11:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CF322CEA;
        Wed,  4 Sep 2019 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567606276;
        bh=rFvqx1t57nbc+Hg21OUbKEcYTo2/giLTrk1qEwOXB0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URIUSDFJKgoNmYvjUlR5n4yVeTKuFkwBbb7wGzVnt/h20wF1bZJlain5U2KU1ae9j
         4zFKKrp0oJHIJZ48DD6amu1aNZ+R6iAGiqHG5dsg77ltmug3+o0h0+jiDDqTvBNo7u
         Qnt6hA7EV7pClHf1mKD0KFukCvIRxTZAEY3EwaUg=
Date:   Wed, 4 Sep 2019 15:11:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, kernel-team@android.com, will@kernel.org
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190904141109.4v6o2cxklpdlmldb@willie-the-truck>
References: <20190726161357.397880775@infradead.org>
 <20190802172104.GA134279@google.com>
 <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20190822122949.GA245353@google.com>
 <20190822165125.GW2369@hirez.programming.kicks-ass.net>
 <20190831144117.GA133727@google.com>
 <20190902091623.GQ2349@hirez.programming.kicks-ass.net>
 <20190904061616.25ce79e1@oasis.local.home>
 <20190904113038.GE2349@hirez.programming.kicks-ass.net>
 <20190904132418.GA237277@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904132418.GA237277@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Wed, Sep 04, 2019 at 09:24:18AM -0400, Joel Fernandes wrote:
> On Wed, Sep 04, 2019 at 01:30:38PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 04, 2019 at 06:16:16AM -0400, Steven Rostedt wrote:
> > > On Mon, 2 Sep 2019 11:16:23 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > in sched_dl_period_handler(). And do:
> > > > 
> > > > +	preempt_disable();
> > > > 	max = (u64)READ_ONCE(sysctl_sched_dl_period_max) * NSEC_PER_USEC;
> > > > 	min = (u64)READ_ONCE(sysctl_sched_dl_period_min) * NSEC_PER_USEC;
> > > > +	preempt_enable();
> > > 
> > > Hmm, I'm curious. Doesn't the preempt_disable/enable() also add
> > > compiler barriers which would remove the need for the READ_ONCE()s here?
> > 
> > They do add compiler barriers; but they do not avoid the compiler
> > tearing stuff up.
> 
> Neither does WRITE_ONCE() on some possibly buggy but currently circulating
> compilers :(

Hmm. The example above is using READ_ONCE, which is a different kettle of
frogs.

> As Will said in:
> https://lore.kernel.org/lkml/20190821103200.kpufwtviqhpbuv2n@willie-the-truck/
> 
> void bar(u64 *x)
> {
> 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> }
> 
> gives:
> 
> bar:
> 	mov	w1, 61200
> 	movk	w1, 0xabcd, lsl 16
> 	str	w1, [x0]
> 	str	w1, [x0, 4]
> 	ret
> 
> Speaking of which, Will, is there a plan to have compiler folks address this
> tearing issue and are bugs filed somewhere? I believe aarch64 gcc is buggy,
> and clang is better but is still buggy?

Well, it depends on your point of view. Personally, I think tearing a
volatile access (e.g. WRITE_ONCE) is buggy and it seems as though the GCC
developers agree:

https://gcc.gnu.org/ml/gcc-patches/2019-08/msg01500.html

so it's likely this will be fixed for AArch64 GCC. I couldn't persuade
clang to break the volatile case, so think we're good there too.

For the non-volatile case, I don't actually consider it to be a bug,
although I sympathise with the desire to avoid a retrospective tree-wide
sweep adding random WRITE_ONCE invocations to stores that look like they
might be concurrent. In other words, I think I'd suggest:

  * The use of WRITE_ONCE in new code (probably with a comment justifying it)
  * The introduction of WRITE_ONCE to existing code where it can be shown to
    be fixing a real bug (e.g. by demonstrating that a compiler actually
    gets it wrong)

For the /vast/ majority of cases, the compiler will do the right thing
even without WRITE_ONCE, simply because that's going to be the most
performant choice as well.

Will
