Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A57C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120920842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405225AbfIFWrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:47:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48746 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfIFWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:47:33 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i6N0k-0004QP-Ej; Sat, 07 Sep 2019 00:47:22 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <20190906090627.GX2386@hirez.programming.kicks-ass.net>
        <20190906124211.2dionk2kzcslaotz@pathway.suse.cz>
        <20190906140126.GY2349@hirez.programming.kicks-ass.net>
Date:   Sat, 07 Sep 2019 00:47:20 +0200
In-Reply-To: <20190906140126.GY2349@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 6 Sep 2019 16:01:26 +0200")
Message-ID: <87mufhqbyf.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-06, Peter Zijlstra <peterz@infradead.org> wrote:
>> I wish it was that simple. It is possible that I see it too
>> complicated. But this comes to my mind:
>> 
>> 1. The simple printk_buffer_store(buf, n) is not NMI safe. For this,
>>    we might need the reserve-store approach.
>
> Of course it is, and sure it has a reserve+commit internally. I'm sure
> I posted an implenentation of something like this at some point.
>
> It is lockless (wait-free in fact, which is stronger) and supports
> multi-readers. I'm sure I posted something like that before, and ISTR
> John has something like that around somewhere too.

Yes. It was called RFCv1[0].

> The only thing I'm omitting is doing vscnprintf() twice, first to
> determine the length, and then into the reservation. Partly because I
> think that is silly and 256 chars should be plenty for everyone,
> partly because that avoids having vscnprintf() inside the cpu_lock()
> and partly because it is simpler to not do that.

Yes, this approach is more straight forward and was suggested in the
feedback to RFCv1. Although I think the current limit (1024) should
still be OK. Then we have 1 dedicated page per CPU for vscnprintf().

>> 2. The simple approach works only with lockless consoles. We need
>>    something else for the rest at least for NMI. Simle offloading
>>    to a kthread has been blocked for years. People wanted the
>>    trylock-and-flush-immediately approach.
>
> Have an irq_work to wake up a kthread that will print to shit
> consoles.

This is the approach in all the RFC versions.

>> 5. John planed to use the cpu_lock in the lockless consoles.
>>    I wonder if it was only in the console->write() callback
>>    or if it would spread the lock more widely.

The 8250 driver in RFCv1 uses the cpu-lock in console->write() on a
per-character basis and in console->write_atomic() on a per-line
basis. This is necessary because the 8250 driver cannot run lockless. It
requires synchronization for its UART_IER clearing/setting before/after
transmit.

IMO the existing early console implementations are _not_ safe for
preemption. This was the reason for the new write_atomic() callback in
RFCv1.

> Right, I'm saying that since you need it anyway, lift it up one layer.
> It makes everything simpler. More simpler is more better.

This was my reasoning for using the cpu-lock in RFCv1. Moving to a
lockless ringbuffer for RFCv2 was because there was too much
resistance/concern surrounding the cpu-lock. But yes, if we want to
support atomic consoles, the cpu-lock will still be needed.

The cpu-lock (and the related concerns) were discussed here[1].

>> 7. People would complain when continuous lines become less
>>    reliable. It might be most visible when mixing backtraces
>>    from all CPUs. Simple sorting by prefix will not make
>>    it readable. The historic way was to synchronize CPUs
>>    by a spin lock. But then the cpu_lock() could cause
>>    deadlock.
>
> Why? I'm running with that thing on, I've never seen a deadlock ever
> because of it.

As was discussed in the thread I just mentioned, introducing the
cpu-lock means that _all_ NMI functions taking spinlocks need to use the
cpu-lock. Even though Peter has never seen a deadlock, a deadlock is
possible if a BUG is triggered while one such spinlock is held. Also
note that it is not allowed to have 2 cpu-locks in the system. This is
where the BKL references started showing up.

Spinlocks in NMI context are rare, but they have existed in the past and
could exist again in the future. My suggestion was to create the policy
that any needed locking in NMI context must be done using the one
cpu-lock.

John Ogness

[0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz
