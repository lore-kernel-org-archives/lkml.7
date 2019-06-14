Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422EC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C432168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfFNJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:44:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37277 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfFNJoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:44:09 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbikd-0006Lk-DM; Fri, 14 Jun 2019 11:44:03 +0200
Date:   Fri, 14 Jun 2019 11:44:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
In-Reply-To: <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906141131570.1722@nanos.tec.linutronix.de>
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com> <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de> <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com> <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com> <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com> <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
 <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de> <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com> <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
 <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Fri, 14 Jun 2019, Jason A. Donenfeld wrote:

> Hey Thomas,
> 
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> >         } while (read_seqcount_retry(&tk_core.seq, seq));
> >
> > -       return base;
> > -
> > +       return base + nsecs;
> 
> The rest of the file seems to use `ktime_add_ns(base, nsecs)`. I
> realize, of course, that these days that macro is the same thing as
> what you wrote, though.

Yeah, historical raisins when ktime_t was special on 32bit.

> One thing I'm curious about is the performance comparison with various
> ways of using jiffies directly:
> 
> ktime_mono_to_any(ns_to_ktime(jiffies64_to_nsecs(get_jiffies_64())),
> TK_OFFS_BOOT)
> 
> Or really giving up on the locking:
> 
> ktime_to_ns(tk_core.timekeeper.offs_boot) + jiffies64_to_nsecs(get_jiffies_64())
> 
> Or keeping things in units of jiffies, though that incurs a div_u64:
> 
> nsecs_to_jiffies64(ktime_to_ns(tk_core.timekeeper.offs_boot)) + get_jiffies_64()

jiffies64 uses a seqcount on 32bit as well.
 
> But since offs_boot is updated somewhat rarely, that div_u64 could be
> precomputed each time offs_boot is updated, allowing hypothetically:
> 
> tk_core.timekeeper.offs_boot_jiffies + get_jiffies_64()

Hrm, I'm not a great fan of these shortcuts which cut corners based on
'somewhat rarely, so it should not matter'. Should not matter always
strikes back at some point. :)

> Which then could be remade into a wrapper such as:
> 
> get_jiffies_boot_64()
> 
> The speed is indeed an important factor to me in accessing this time
> value. Are any of these remotely interesting to you in that light?
> Maybe I'll send a patch for the latter.

So what you are looking for is jiffies based on boot time?

Thanks,

	tglx
