Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D292147A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552059029;
	bh=LoUNdu8zcrAquYzmh6OQn3jcRuVJq7eYnHHWxd3DBrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rkJ+nPXvA1jVPAVmRcbjyI3TC1v8oJfVUXjLzVKc25FAEsxVqbKeAOmEqxEU0oceU
	 4iA2uzoie4lbOHGYLv6GWz9vbbBsx6tmUnfJouei1RVG7BX3X1Y+B8GY9zP9jJvZXj
	 I+IOMh4sT5f487YukmAY+cyRVOrDoxt+9RMxVh5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCHPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHPa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:30:27 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1908A208E4;
        Fri,  8 Mar 2019 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552059026;
        bh=LoUNdu8zcrAquYzmh6OQn3jcRuVJq7eYnHHWxd3DBrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJ1JRlBd19WsmnJo6Bj2/bsgSH/3rIQUrHSi+/mR2z9v07+B2Dq+kF+tiyus2JfX+
         kA7/MX1WgY6BxYNvGHrJRxpRLU/Huf560AnmqFv0ftSCQrp9ga+09GTZytDqmCYQLn
         ZbuTgRLhC6M1ljCLXDAhUa9/pDbdysjyRP1Va71c=
Date:   Fri, 8 Mar 2019 16:30:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/37] softirq: Per vector masking v3
Message-ID: <20190308153022.GA23080@lenoir>
References: <20190228171242.32144-1-frederic@kernel.org>
 <CAHk-=wh5MQiXNUBCN6VKNGRR2gDekhXpaTc914D3y4=dHpmh4Q@mail.gmail.com>
 <20190301034536.GA19200@lenoir>
 <CAHk-=wgOZuGZaVOOiC=drG6ykVkOGk8RRXZ_CrPBMXHKjTg0dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOZuGZaVOOiC=drG6ykVkOGk8RRXZ_CrPBMXHKjTg0dg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 08:51:38AM -0800, Linus Torvalds wrote:
> On Thu, Feb 28, 2019 at 7:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Numbers are indeed missing. In fact this patchset mostly just brings an
> > infrastructure. We have yet to pinpoint the most latency-inducing
> > softirq disabled sites and make them disable only the vectors that
> > are involved in a given lock.
> 
> Note that I think we pretty much know that already: the people who
> have had issues have never actually really had issues with the actual
> "disable softirq" paths, they've all been about actually *running* the
> softirq's (and that in turn being a latency issue for running _other_
> softirqs, and in particular for delaying them into softirqd).
> 
> Now, it may well be that yes, we'll have "block softirqs" code that
> has issues too, but it's absolutely been swamped by the latencies for
> actually running them so far.
> 
> Note that this is all really fairly independent of the whole masking
> logic. Yes, the masking logic comes into play too (allowing you to run
> a subset of softirq's at a time), but on the whole the complaints I've
> seen have not been "the networking softirq takes so long that it
> delays USB tasklet handling", but they have been along the lines of
> "the networking softirq gets invoked so often that it then floods the
> system and triggers softirqd, and _that_ then makes tasklet handling
> latency go up insanely".
> 
> See the difference? Not the latency of softirq's disabled, but the
> latency of one group of softirqs causing problems for another when
> they all get batched together (and soft-scheduled to another context
> together).

I see, so that's an entirely different problem that vector
soft-interruptibility can't fix, at least not alone.

The only solution I can imagine is to have a seperate pending mask
for normal softirq processing and ksoftirqd, so that only vectors
that have been enqueued for threaded processing are delayed.

I can work on that first, but I really need to be able to reproduce
an example of the issue. The USB capture thing seems to be one the best.
Let's browse some history to see if I can find some details on the
relevant scenario.
