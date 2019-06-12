Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E65EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35867208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZK8CGvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408782AbfFLJ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:29:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37228 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408714AbfFLJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M0lGJDKgqsxi9gTFrPdyZeIM8sJJKJoUyuIKIv8e2Qk=; b=EZK8CGvzTpMm/zA5qFOHusqGf
        EiNd1NU+a9mktPbqKPmDz3xHdGpp9APR6gaPxRU0Y3sc0E7wlP17RUa2sHsPQC4LU518nLSCO5EqA
        mh8AU79qdRW1QDbtNaIaBEHOfB96ydTMF0UbicwyxgaASCKQZ6S4kZ/vmrSefDNHtRhNdiJS92qX7
        WJcxWwi2kV4pilQSL9B/hN+d1sqetPGlXUP5p9S8L6i9Jwfrp141oNpSHyNpRntYytoHWrxiBYoP3
        XuEx4r5pscK/ZKF1Xlbv5d192Mt02cPQf0ErpaACpxP86fxWzreoyC3QS4A0+D6tD684tkQ+7VUJu
        DiW3bOhcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hazZN-0004f3-NZ; Wed, 12 Jun 2019 09:29:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5885F2096E50D; Wed, 12 Jun 2019 11:29:24 +0200 (CEST)
Date:   Wed, 12 Jun 2019 11:29:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, x86@kernel.org
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
Message-ID: <20190612092924.GG3436@hirez.programming.kicks-ass.net>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:09:20PM +0200, Thomas Gleixner wrote:

> > CPU: 1 PID: 7927 Comm: kworker/1:3 Tainted: G           OE     4.19.47-1-lts #1
> > Hardware name: Dell Inc. XPS 15 9570/02MJVY, BIOS 1.10.1 04/26/2019

That's a laptop, limited number of CPUs in those.

> > Workqueue: wg-crypt-interface wg_packet_tx_worker [wireguard]
> > RIP: 0010:read_hpet+0x67/0xc0
> > Code: c0 75 11 ba 01 00 00 00 f0 0f b1 15 a3 3d 1a 01 85 c0 74 37 48
> > 89 cf 57 9d 0f 1f 44 00 00 48 c1 ee 20 eb 04 85 c9 74 12 f3 90 <49> 8b
> > 08 48 89 ca 48 c1 ea 20 89 d0 39 f2 74 ea c3 48 8b 05 89 56
> > RSP: 0018:ffffb8d382533e18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> > RAX: 0000000018a4c89e RBX: 0000000000000000 RCX: 18a4c89e00000001
> > RDX: 0000000018a4c89e RSI: 0000000018a4c89e RDI: ffffffffb8227980
> > RBP: 000006c1c3f602a2 R08: ffffffffb8205040 R09: 0000000000000000
> > R10: 000001d58fd28efc R11: 0000000000000000 R12: ffffffffb8259a80
> > R13: 00000000ffffffff R14: 0000000518a0d8c4 R15: 000000000010fa5a
> > FS:  0000000000000000(0000) GS:ffff9b90ac240000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00003663b14d9ce8 CR3: 000000030f20a006 CR4: 00000000003606e0
> > Call Trace:
> >  ktime_get_mono_fast_ns+0x53/0xa0
> >  ktime_get_boot_fast_ns+0x5/0x10
> >  wg_packet_tx_worker+0x183/0x220 [wireguard]
> >  process_one_work+0x1f4/0x3e0
> >  worker_thread+0x2d/0x3e0

This is process context, no IRQs or NMIs around.

> >  ? process_one_work+0x3e0/0x3e0
> >  kthread+0x112/0x130
> >  ? kthread_park+0x80/0x80
> >  ret_from_fork+0x35/0x40
> > watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/1:3:7927]
> > 
> > It looks like RIP is spinning in this loop in read_hpet:
> > 
> > do {
> >     cpu_relax();
> >     new.lockval = READ_ONCE(hpet.lockval);
> > } while ((new.value == old.value) && arch_spin_is_locked(&new.lock));

> I think your code is fine. Just 'fast' is relative with the HPET selected
> as clocksource (it's actually aweful slow).

Yeah, the _fast suffix is mostly to denote the NMI safeness of the
accessor, and the corners it cuts to be so, which violate strict
monotonicity.

If you land on the HPET, there is nothing fast about it, HPET sucks,
always has, always will.

(on a personal note, I'd return any hardware that ends up on HPET as
broken to the vendor)

> It probably livelocks in the HPET optimization Waiman did for large
> machines. I'm having a dejavu with that spinlock livelock we debugged last
> year. Peter?

Sorry, no memories left of that :/

  CPU0				CPU1

				if (trylock(lock))
					new = hpet_read();
					WRITE_ONCE(hpet, new);
  old = READ_ONCE(hpet)
  r = READ_ONCE(lock)
  if (r)
    goto contended
					unlock(lock);
					return new;
				}

  do {
	  new = READ_ONCE(hpet);
  } while (new == old && READ_ONCE(lock));

I don't see how we can stay stuck in that loop, either @hpet changing or
@lock being unlocked should terminate it.

Either (or both) must happen given the code.

> Can you please ask the reporter to try the hack below?
> 
> Thanks,
> 
> 	tglx
> 
> 8<---------------
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index a0573f2e7763..0c9044698489 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -795,8 +795,7 @@ static u64 read_hpet(struct clocksource *cs)
>  	/*
>  	 * Read HPET directly if in NMI.
>  	 */
> -	if (in_nmi())
> -		return (u64)hpet_readl(HPET_COUNTER);
> +	return (u64)hpet_readl(HPET_COUNTER);

That basically kills the entire optimization. At which point we'll get
even slower. That said, the laptop doesn't have enough CPUs in to
credibly life-lock on this.

