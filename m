Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40F7208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEAQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:01:45 -0400
Received: from foss.arm.com ([217.140.101.70]:33208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:01:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D73FBA78;
        Wed,  1 May 2019 09:01:44 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719143F719;
        Wed,  1 May 2019 09:01:43 -0700 (PDT)
Date:   Wed, 1 May 2019 17:01:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jan Glauber <jglauber@marvell.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        peterz@infradead.org, torvalds@linux-foundation.org
Subject: Re: [RFC] Disable lockref on arm64
Message-ID: <20190501160140.GC28109@fuggles.cambridge.arm.com>
References: <20190429145159.GA29076@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429145159.GA29076@hc>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

[+Peter and Linus, since they enjoy this stuff]

On Mon, Apr 29, 2019 at 02:52:11PM +0000, Jan Glauber wrote:
> I've been looking into performance issues that were reported for several
> test-cases, for instance an nginx benchmark.

Could you share enough specifics here so that we can reproduce the issue
locally, please? That would help us in our attempts to develop a fix without
simply disabling the option for everybody else.

> It turned out the issue we have on ThunderX2 is the file open-close sequence
> with small read sizes. If the used files are opened read-only the
> lockref code (enabled by ARCH_USE_CMPXCHG_LOCKREF) is used.
> 
> The lockref CMPXCHG_LOOP uses an unbound (as long as the associated
> spinlock isn't taken) while loop to change the lock count. This behaves
> badly under heavy contention (~25x retries for one cmpxchg to succeed
> with 28 threads operating on the same file). In case of a NUMA system
> it also behaves badly as the access from the other socket is much slower.

It's surprising that this hasn't been reported on x86. I suspect their
implementation of cmpxchg is a little more forgiving under contention.

> The fact that on ThunderX2 cpu_relax() turns only into one NOP
> instruction doesn't help either. On Intel pause seems to block the thread
> much longer, avoiding the heavy contention thereby.

NOPing out the yield instruction seems like a poor choice for an SMT CPU
such as TX2. That said, the yield was originally added to cpu_relax() as
a scheduling hint for QEMU.

> With the queued spinlocks implementation I can see a major improvement
> when I disable lockref. A trivial open-close test-case improves by
> factor 2 while system time is decreasing also 2x. Looking at kernel compile
> and dbench numbers didn't show any regression with lockref disabled.
> 
> Can we simply disable lockref? Is anyone else seeing this issue? Is there
> an arm64 platform that actually implements yield?

There are two issues with disabling lockref like this:

  1. It's a compile-time thing, so systems that would benefit from the code
     are unfairly penalised.

  2. You're optimising for the contended case at the cost of the
     uncontended case, which should actually be the common case as well.

Now, nobody expects contended CAS to scale well, so the middle ground
probably involves backing off to the lock under contention, a bit like
an optimistic trylock(). Unfortunately, that will need some tuning, hence
my initial request for a reproducer.

Cheers,

Will
