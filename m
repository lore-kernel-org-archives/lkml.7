Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07075C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09952171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfB1KgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:36:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfB1KgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:36:00 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gzJ2i-0001zT-D5; Thu, 28 Feb 2019 11:35:56 +0100
Date:   Thu, 28 Feb 2019 11:35:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] posix-cpu-timers: Avoid undefined behaviour in
 timespec64_to_ns()
In-Reply-To: <CAK8P3a0ip8+UaqnjGsC8GVY8CSEtccB4uUB-b5Zk1nrVqcY0eQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902281123550.1821@nanos.tec.linutronix.de>
References: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com> <CABeXuvoJ3oKRp0z=CO_8kPhZ+-AHGwTaDBqzK2FuC_v5t6kU=A@mail.gmail.com> <CAK8P3a0ip8+UaqnjGsC8GVY8CSEtccB4uUB-b5Zk1nrVqcY0eQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019, Arnd Bergmann wrote:
> On Thu, Feb 28, 2019 at 5:25 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > On Tue, Feb 26, 2019 at 11:52 PM Xiongfeng Wang
> > <wangxiongfeng2@huawei.com> wrote:
> > >
> > > +++ b/kernel/time/posix-timers.c
> > > @@ -853,8 +853,8 @@ static int do_timer_settime(timer_t timer_id, int flags,
> > >         unsigned long flag;
> > >         int error = 0;
> > >
> > > -       if (!timespec64_valid(&new_spec64->it_interval) ||
> > > -           !timespec64_valid(&new_spec64->it_value))
> > > +       if (!timespec64_valid_strict(&new_spec64->it_interval) ||
> > > +           !timespec64_valid_strict(&new_spec64->it_value))
> > >                 return -EINVAL;
> > >
> > >         if (old_spec64)
> >
> > sys_timer_settime() is a POSIX interface:
> > http://pubs.opengroup.org/onlinepubs/7908799/xsh/timer_settime.html
> >
> > The timer_settime() function will fail if:
> >
> > [EINVAL] The timerid argument does not correspond to an id returned by
> > timer_create() but not yet deleted by timer_delete().
> >
> > [EINVAL] A value structure specified a nanosecond value less than zero
> > or greater than or equal to 1000 million.
> >
> > So we cannot return EINVAL here if we want to maintain POSIX compatibility.
> > Maybe we should check for limit and saturate here at the syscall interface?
> 
> I think returning EINVAL here is better than silently truncating, we
> just need to
> document it in the Linux man page.
> Note that truncation would set the time to just before the overflow,
> it bad things
> start to happen the instant after it returns from the kernel. This is possibly
> worse than setting a random value that may or may not crash the system.

Not necessarily. On the hrtimer based side, we clamp the values to
KTIME_MAX. That means in theory the overflow could happen when the timer
expires and the interval is added. There are two things which prevent that:

1) The timer expires in about 292 years from now, which I really can't be
   worried about

2) The rearming code prevents the overflow into undefined space as well.

So, it's not unreasonable to do clamping as long as the handed in value is
at least formally correct.

Of course we need to look at the posix-cpu-timer side of affairs to ensure
that the limits are handled correctly.

Thanks,

	tglx

