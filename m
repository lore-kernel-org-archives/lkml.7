Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29262ECE59E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A262064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbfJOVum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:50:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732448AbfJOVuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:50:40 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iKUiB-0000tN-Rr; Tue, 15 Oct 2019 23:50:36 +0200
Date:   Tue, 15 Oct 2019 23:50:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: x86/random: Speculation to the rescue
In-Reply-To: <41646d76683844e7baf068bed35891ad@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1910152230070.2518@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de> <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com> <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com> <20190930033706.GD4994@mit.edu>
 <20190930131639.GF4994@mit.edu> <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com> <41646d76683844e7baf068bed35891ad@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Tue, 1 Oct 2019, David Laight wrote:
> From: Linus Torvalds
> > Sent: 30 September 2019 17:16
> > 
> > On Mon, Sep 30, 2019 at 6:16 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > Which is to say, I'm still worried that people with deep access to the
> > > implementation details of a CPU might be able to reverse engineer what
> > > a jitter entropy scheme produces.  This is why I'd be curious to see
> > > the results when someone tries to attack a jitter scheme on a fully
> > > open, simple architecture such as RISC-V.
> > 
> > Oh, I agree.
> > 
> > One of the reasons I didn't like some of the other jitter entropy
> > things was that they seemed to rely _entirely_ on just purely
> > low-level CPU unpredictability. I think that exists, but I think it
> > makes for problems for really simple cores.
> > 
> > Timing over a bigger thing and an actual interrupt (even if it's
> > "just" a timer interrupt, which is arguably much closer to the CPU and
> > has a much higher likelihood of having common frequency domains with
> > the cycle counter etc) means that I'm pretty damn convinced that a big
> > complex CPU will absolutely see issues, even if it has big caches.
> 
> Agreed, you need something that is actually non-deterministic.
> While 'speculation' is difficult to predict, it is actually fully deterministic.

I surely agree with Linus that simple architectures could have a more or
less predictable or at least searchable behaviour. If we talk about complex
x86 CPUs, I tend to disagree.

Even the Intel architects cannot explain why the following scenario is not
deterministic at all:

	Single CPU
	No NMIs
	No MCEs
	No DMAs in the background, nothing.
	CPU frequency is identical to TSC frequency

	volatile int foo;

	local_irq_disable();
	start = rdtscp();
	for (i = 0; i < 100000; i++)
		foo++;
	end = rdtscp();
	local_irq_enable();

Repeat that loop as often as you wish and observe the end - start
delta. You'll see

       min <= delta <= N * min

where N is something >= 2. The actual value of N depends on the micro
architecture, but is not identical on two systems and not even identical on
the same system after boot and 1e6 iterations of the above.

Aside of the fact that N is insane big there is absolutely no pattern in
the delta value even over a large number of runs.

> Until you get some perturbation from an outside source the cpu state
> (including caches and DRAM) is likely to be the same on every boot.

See above and read Nicholas paper. It's simply not that likely on anything
halfways modern.

> For a desktop (etc) PC booting from a disk (even SSD) you'll get some variation.
> Boot an embedded system from onboard flash and every boot could
> well be the same (or one of a small number of results).
>
> Synchronising a signal between frequency domains might generate
> some 'randomness', but maybe not if both come from the same PLL.
> 
> Even if there are variations, they may not be large enough to give
> a lot of variations in the state.
> The variations between systems could also be a lot larger than the
> variations within a system.

The variations between systems are going to be larger as any minimal
tolerance in the components have an influence.

But even between two boots on a 'noiseless' embedded system factors like
temperature, PLL lock times, swing in times of voltage regulators and other
tiny details create non-deterministic behaviour. In my former life as a
hardware engineer I had to analyze such issues deeply as they create
serious trouble for some application scenarios, but those systems where
based on very trivial and truly deterministic silicon parts. No commodity
hardware vendor will ever go the extra mile to address these things as the
effort required to get them under control is exponential vs. the effect.

Whether that's enough to create true entropy is a different question, but I
do not agree with the upfront dismissal of a potentially useful entropy
source. 

I'm in no way saying that this should be used as the sole source of
entropy, but I definitely want to explore the inherent non-determinism of
modern OoO machines further.

The results are way too interesting to ignore them and amazingly fast at
least with the algorithm which I used in my initial post which started this
whole discussion.

I let that thing run on a testbox for the last two weeks while I was on
vacation and gathered 32768 random bits via that debugfs hack every 100ms,
i.e. a total of 1.2e7 samples amounting to ~4e11 bits. The analysis is
still running, but so far it holds up.

Thanks,

	tglx
