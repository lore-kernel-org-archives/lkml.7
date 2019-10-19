Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE5CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B57221D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfJSKt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 06:49:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59134 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfJSKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 06:49:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLmIz-0004gs-5f; Sat, 19 Oct 2019 12:49:53 +0200
Date:   Sat, 19 Oct 2019 12:49:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
In-Reply-To: <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910191214490.2098@nanos.tec.linutronix.de>
References: <20191018203704.GC31027@cork> <20191018204220.GD31027@cork> <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1132302849-1571482193=:2098"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1132302849-1571482193=:2098
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 18 Oct 2019, Linus Torvalds wrote:
> On Fri, Oct 18, 2019 at 4:42 PM Jörn Engel <joern@purestorage.com> wrote:
> >
> > We can generate entropy on almost any CPU, even if it doesn't provide a
> > high-resolution timer for random_get_entropy().  As long as the CPU is
> > not idle, it changed the register file every few cycles.  As long as the
> > ALU isn't fully synchronized with the timer, the drift between the
> > register file and the timer is enough to generate entropy from.
> 
> >  static void entropy_timer(struct timer_list *t)
> >  {
> > +     struct pt_regs *regs = get_irq_regs();
> > +
> > +     /*
> > +      * Even if we don't have a high-resolution timer in our system,
> > +      * the register file itself is a high-resolution timer.  It
> > +      * isn't monotonic or particularly useful to read the current
> > +      * time.  But it changes with every retired instruction, which
> > +      * is enough to generate entropy from.
> > +      */
> > +     mix_pool_bytes(&input_pool, regs, sizeof(*regs));
> 
> Ok, so I still like this conceptually, but I'm not entirely sure that
> get_irq_regs() works reliably in a timer. It's done from softirq
> TIMER_SOFTIRQ context, so not necessarily _in_ an interrupt.
> 
> Now, admittedly this code doesn't really need "reliably". The odd
> occasional hickup would arguably just add more noise. And I think the
> code works fine. get_irq_regs() will return a pointer to the last
> interrupt or exception frame on the current CPU, and I guess it's all
> fine. But let's bring in Thomas, who was not only active in the
> randomness discussion, but might also have stronger opinions on this
> get_irq_regs() usage.
> 
> Thomas, opinions? Using the register state (while we're doing the
> whole entropy load with scheduling etc) looks like a good source of
> high-entropy data outside of just the TSC, so it does seem like a very
> valid model. But I want to run it past more people first, and Thomas
> is the obvious victim^Wchoice.

The idea is good, but as Ingo pointed out this needs very careful checking
of 'regs'. get_irq_regs() is really only valid from interrupt context up to
the point where the old irq regs (default NULL) are restored, i.e. after
irq_exit() from where softirqs are invoked.

One slightly related thing I was looking into is that the mixing of
interrupt entropy is always done from hard interrupt context. That has a
few issues:

    1) It's pretty visible in profiles for high frequency interrupt
       scenarios.

    2) The regs content can be pretty boring non-deterministic when the
       interrupt hits idle.

       Not an issue in the try_to_generate_entropy() case probably, but
       that still needs some careful investigation.

For #1 I was looking into a trivial storage model with a per cpu ring
buffer, where each entry contains the entropy data of one interrupt and let
some thread or whatever handle the mixing later.

That would allow to filter out 'constant' data (#) but it would also give
Joerns approach a way to get to some 'random' register content independent
of the context in which the timer softirq is running in.

Thanks,

	tglx
--8323329-1132302849-1571482193=:2098--
