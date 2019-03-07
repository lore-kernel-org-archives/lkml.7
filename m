Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD20C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4806720652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m7IeWrsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCGJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:14:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k4aaE8VpuibnJfq/I5hDYDrBFPhgCTiTGp/rbN6c6/8=; b=m7IeWrsrCQ8hWXZpRb9v2uyh4
        BEfw7G09xwMoJWRQ87vCSq5zS3FQOZ+mV0T1Q6Z3YPICstvnSw1m5gB14ULANsJKEg7gnX2GChItk
        3Oss3YuGO4I923amhFW+r6P8HDlPF1fmd3bi82pU46Mwus3EfFpm95X/Qd78FhrJaIaRnQtdcRgeb
        N5Jo5IbWjvlT3ydD04b8PkRYPy6pNx6rL/rdzks/1MeEJvL99QrtX334v36LeWLNaVxSHSHUwkAF+
        Yc1POZt1PB0ytf9r+uR6RLjeVLwHiU58RdYSzM54OUb0PM2T4KOYSm5dQYrGhLIvOqkrVozeTbZCy
        zsezRF/sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1p5c-0004SU-Qd; Thu, 07 Mar 2019 09:13:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36E0F2029B186; Thu,  7 Mar 2019 10:13:18 +0100 (CET)
Date:   Thu, 7 Mar 2019 10:13:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Message-ID: <20190307091318.GA32477@hirez.programming.kicks-ass.net>
References: <20190301140348.25175-1-will.deacon@arm.com>
 <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none>
 <87ef7n7x9v.fsf@concordia.ellerman.id.au>
 <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
 <87k1hbv7ba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1hbv7ba.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:47:53AM +1100, Michael Ellerman wrote:
> The mutex unlock fast path is just:
> 
> 	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) == curr)
> 		return true;
> 
> And because it's the "release" variant we just use lwsync, which doesn't
> order MMIO. If it was just atomic_long_cmpxchg() that would work because
> we use sync for those.
> 
> __up_write() uses atomic_long_sub_return_release(), so same story.

As does spin_unlock() of course, which is a great segway into...

  my RCsc desires :-)

If all your unlocks were to have SYNC, your locks would, aside from
ordering MMIO, also be RCsc, Win-Win :-)

There is, of course, that pesky little performance detail that keeps
getting in the way.
