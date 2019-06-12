Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6635C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfFLTqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:46:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34125 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfFLTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:46:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so7498923qkt.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awKvrcBYA/jeY+x9Ws9Ds2K1tYqzjv4W7GVJwBBQDDg=;
        b=SZde0WKONbJuPjFOFKLmPYLVI+Y1GJJEQAyVCNMFASg2gsQLhUFXb/pJvpzw52GXAP
         CT57RDutwQmqukOxA9gQalIQ+MgTZzFcZDKiIYz0ZJ/OIyo2AGSX5QN00H8uHRoLHN+v
         1pK2DO4YR26H/LFyfO2tRhpVfI1bfUyo9Sa67kWGFn8tCzXQwMay7CFqDGwA1+d9gjIj
         hC9JNzv7WFhygrOkLA7+JeA7hwEnmaJoWzbZ/0n0k9os3s0iTUvpZb0sPGG6FLH52bZb
         FRBWNdAWYxqSPviHZ7LTCppbu/Ar5KkNo7h23JmmKbyOlc2Np+SXvc+D+emlH1JzkFub
         GHiA==
X-Gm-Message-State: APjAAAXL+lD8Emy+EYQaVDYQ8wDyN3UUDSgpwPF/gSrZz+6x2am761Me
        RE9eG7Gb5zUpw+afTmd3VcEOTkfHi+W3TSw1IQwelAoT
X-Google-Smtp-Source: APXvYqy/7C/DFlnMzV/EeJFMQfzpJc0KAxUTTJcZe7DDjR0J8qFAwH3G2Na2bn79BjnbgFudbyd3QmkL7cATMJ2PI+s=
X-Received: by 2002:a05:620a:10b2:: with SMTP id h18mr2594215qkk.14.1560368802397;
 Wed, 12 Jun 2019 12:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190612122843.GJ3436@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jun 2019 21:46:25 +0200
Message-ID: <CAK8P3a17e8Ox9FKW-OsBKuGqvbe5sEgeqqFd9RikHMi60WiSfA@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 7:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Jun 12, 2019 at 11:44:35AM +0200, Jason A. Donenfeld wrote:

> > But there's still the
> > issue of the 32-bit wraparound on the base implementation.
>
> If an architecture doesn't provide a sched_clock(), you're on a
> seriously handicapped arch. It wraps in ~500 days, and aside from
> changing jiffies_lock to a latch, I don't think we can do much about it.
>
> (the scheduler too expects sched_clock() to not wrap short of the u64
> and so having those machines online for 500 days will get you 'funny'
> results)
>
> AFAICT only: alpha, h8300, hexagon, m68knommu, nds32, nios2, openrisc
> are lacking any form of sched_clock(), the rest has it either natively
> or through sched_clock_register().

For completeness (as we already discussed on IRC), on many architectures
this would depend on the clocksource driver: many (older) arm, mips, sh
or m68k implementations don't have sched_clock(), as this depends on
the clocksource driver. All the modern ones tend to have one, but older
ones may only support an interval timer tick that cannot be read.

        Arnd
