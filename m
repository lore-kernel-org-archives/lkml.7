Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FED521882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfI2HkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:40:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfI2HkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:40:18 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iEToU-0007By-5W; Sun, 29 Sep 2019 09:40:14 +0200
Date:   Sun, 29 Sep 2019 09:40:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
In-Reply-To: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909290724160.2636@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de> <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
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

On Sat, 28 Sep 2019, Linus Torvalds wrote:

> On Sat, Sep 28, 2019 at 3:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Nicholas presented the idea to (ab)use speculative execution for random
> > number generation years ago at the Real-Time Linux Workshop:
> 
> What you describe is just a particularly simple version of the jitter
> entropy. Not very reliable.

I know that jitter entropy is not the most reliable source. Though its for
one better than no entropy and on the other hand the results are
interesting.

I just looked at the test I ran overnight on one of my machines which did
an aggregate test over 1024 runs both on the hacked up thing and the
veritable /dev/random. The overall difference is within the noise.

So I'm not trying to say that we should rely solely on that, but I think
it's something we should not dismiss upfront just because paranoid theory
says that jitter entropy is not reliable enough.

The point is that jitter entropy relies as any other entropy source on the
quality of the observed data. The non-deterministic behaviour of
speculative execution seems to yield quite good input.

There is another fun thing which I found while analyzing the crappy runtime
behaviour of a customer application:

static volatile unsigned int foo;

	t0 = rdtscp();
	for (i = 0; i < 10000; i++)
		foo++;
	/* rdtscp() or the fenced rdtsc() gives better results */
	t1 = rdtscp();

Even with interrupts disabled and no NMI disturbing the loop, the resulting
execution time varies depending on the microarchitecture:

       tmin < t < N * tmin

where N is >= 2 on all Intel machines which I tested. Feeding bit 0 of t1
mixed with t0 into the LSFR gives equally good results as the hacky loop I
used in the patch. Fun isn't it?

> Whatever. I'm entirely convinced this won't make everybody happy
> anyway, but it's _one_ approach to handle the issue.
> 
> Ahmed - would you be willing to test this on your problem case (with
> the ext4 optimization re-enabled, of course)?
> 
> And Thomas - mind double-checking that I didn't do anything
> questionable with the timer code..

Looks about right.
 
> And this goes without saying - this patch is ENTIRELY untested.  Apart
> from making people upset for the lack of rigor, it might do
> unspeakable crimes against your pets. You have been warned.

As I'm about to vanish for a 2 weeks vacation, I'm going to shut up now and
hope that experiment gave at least food for thought.

Thanks,

	tglx
