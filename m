Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8953BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC4020811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfCZXAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:00:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49625 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfCZXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:00:45 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8v3g-0007xp-DU; Wed, 27 Mar 2019 00:00:40 +0100
Date:   Wed, 27 Mar 2019 00:00:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] timekeeping: Force upper bound for setting
 CLOCK_REALTIME
In-Reply-To: <CAK8P3a0PSSvYGS7fwg7iT0tu6njBnuFKq7MFqJcA2hJ1-RmmHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903262339090.1789@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de> <20190326092607.GE14186@localhost> <alpine.DEB.2.21.1903261329040.1789@nanos.tec.linutronix.de> <CAK8P3a0PSSvYGS7fwg7iT0tu6njBnuFKq7MFqJcA2hJ1-RmmHw@mail.gmail.com>
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

On Tue, 26 Mar 2019, Arnd Bergmann wrote:
> On Tue, Mar 26, 2019 at 1:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, 26 Mar 2019, Miroslav Lichvar wrote:
> > > On Sat, Mar 23, 2019 at 11:36:19AM +0100, Thomas Gleixner wrote:
> > > > It is reasonable to force an upper bound for the various methods of setting
> > > > CLOCK_REALTIME. Year 2262 is the absolute upper bound. Assume a maximum
> > > > uptime of 30 years which is plenty enough even for esoteric embedded
> > > > systems. That results in an upper bound of year 2232 for setting the time.
> > >
> > > The patch looks good to me.
> > >
> > > I like this approach better than using a larger value closer to the
> > > overflow (e.g. one week) and stepping the clock back automatically
> > > when the clock reaches that time, but I suspect it might possibly
> > > break more tests (or any unusual applications messing with time) as a
> > > much larger interval is now EINVAL.
> >
> > I'm fine with breaking a few tests on the way rather than having undefined
> > behaviour and the constant flow of patches tackling the wrong end of the
> > stick.
> 
> I think the one downside of your approach is that it introduces a second
> arbitrary cut-off point after which the system almost functions perfectly,
> but is no longer able to do ntp updates or set the right time after a reboot.

Yes, I'm aware of that. But we talk about 113 years from now. Assume we can
fix that proper before the two of us retire. Then you'd need a system which
runs an 80-100 years old kernel in 2232 to run into that problem for real.

There is actually a proper solution for this (ignore RTCs). All user space
interfaces are going to be timespec64 based soon. So they can accomodate
more than 1e11 years.

Now if the kernel internally uses special functions to convert from and to
timespec64 for all interfaces which deal with CLOCK_REALTIME absolute time,
then we still can manage the internal representation in u64 nanoseconds and
have an offset added/subtracted on the relevant interfaces.

That's going to be a bit hairy when time is set back or forth so it needs
to adjust that internal offset, but for regular operation it might be good
enough to have the possible time setting limited to a fixed range depending
on the initial offset.

But even updating the offset should be managable. The conversion functions
would need a seqcount loop and the resulting internal values would be a
struct containing the value and the offset at conversion time. That'd allow
to fix them up at any boundary later on. Not that I want to to that, but if
absolutely necessary, it can be done.

> That said, all other ideas I've managed to come up with are worse,
>  so I agree on going ahead with this version.
> 
> We could still bikeshed over the exact cutoff time, as the one you
> picked isn't particularly intuitive. It's almost exactly 30 years before
> the final end point, but your calculation is off by a few days because
> of leap years. And no, I don't have a particular preference for any
> other color of this bikeshed either, it's probably as good as any other
> time within 20 years of what you suggested.

Haha, we surely could bikeshed that until retirement and then hand it over
to the next generations which might come to an agreement shortly before
2262 :)

Thanks,

	tglx
