Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B1A20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OYFqE6Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfCFRBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:01:02 -0500
Received: from mail.efficios.com ([167.114.142.138]:48148 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfCFRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:01:02 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 519B7AE5B9;
        Wed,  6 Mar 2019 12:01:00 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7Vsx7xkr1NIr; Wed,  6 Mar 2019 12:00:59 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 53D7BAE5AD;
        Wed,  6 Mar 2019 12:00:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 53D7BAE5AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551891659;
        bh=oGoYiVvG7Y+smUuMf17K3nlLZ45zVA5OK3/jIw8UKwc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OYFqE6Y77MJMroMMcUGHrSiW0aa1r2ruksShsprlWznN0VRc0KDrwoMZ9zm6zZ2e/
         QaVZ3KMrn44Vb7BC9fjoVTc4Rodhqa8d1u5sWgKOZPYGs85G1arKQz4P9Wgds1nrtW
         /ThX3KS+1JOWadbKkZGuweuAfOeX4EO7n2H9RoXlmvTv9oEIjJZzUrfJKS/UYQo2rQ
         I0qZqW7P7HBSvc9zG7Bpb3jS/BsI9wLE17UApDwiz0RU4MhGv6LbVAMqGXELIZP9uV
         IUYj+CSuu/c+5VrzlWAiH+71Oiog2ND0PH5fmzVKDV8wuwAXs4JlC8Xd7QFZN0ILd1
         MMfJl6GrzbXEw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id lQ_vuh5GKihU; Wed,  6 Mar 2019 12:00:59 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2DDD0AE5A5;
        Wed,  6 Mar 2019 12:00:59 -0500 (EST)
Date:   Wed, 6 Mar 2019 12:00:59 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Message-ID: <228767171.901.1551891659003.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190306083039.GS32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com> <20190305215848.GQ32477@hirez.programming.kicks-ass.net> <486623963.509.1551825130539.JavaMail.zimbra@efficios.com> <20190306083039.GS32477@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3780)
Thread-Topic: Restartable Sequences updates for 5.1
Thread-Index: cU6JtmV7FpZn0BnWRCPCMWgOJM/X3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 6, 2019, at 3:30 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 05, 2019 at 05:32:10PM -0500, Mathieu Desnoyers wrote:
> 
>> >> * Adaptative mutex improvements
>> >> 
>> >> I have done a prototype using rseq to implement an adaptative mutex which
>> >> can detect preemption using a rseq critical section. This ensures the
>> >> thread doesn't continue to busy-loop after it returns from preemption, and
>> >> calls sys_futex() instead. This is part of a user-space prototype branch [2],
>> >> and does not require any kernel change.
>> > 
>> > I'm still not convinced that is actually the right way to go about
>> > things. The kernel heuristic is spin while the _owner_ runs, and we
>> > don't get preempted, obviously.
>> > 
>> > And the only userspace spinning that makes sense is to cover the cost of
>> > the syscall. Now Obviously PTI wrecked everything, but before that
>> > syscalls were actually plenty fast and you didn't need many cmpxchg
>> > cycles to amortize the syscall itself -- which could then do kernel side
>> > adaptive spinning (when required).
>> 
>> Indeed with PTI the system calls are back to their slow self. ;)
>> 
>> You point about owner is interesting. Perhaps there is one tweak that I
>> should add in there. We could write the owner thread ID in the lock word.
> 
> This is already required for PI (and I think robust) futexes. There have
> been proposals for FUTEX_LOCK and FUTEX_UNLOCK (!PI) primitives that
> require the same.
> 
> Waiman had some patches; but I think all went under because 'important'
> stuff happened.
> 
>> When trying to grab a lock, one of a few situations can happen:
>> 
>> - It's unlocked, so we grab it by storing our thread ID,
>> - It's locked, and we can fetch the CPU number of the thread owning it
>>   if we can access its (struct rseq *)->cpu_id through a lookup using its
>>   thread ID, We can then check whether it's the same CPU we are running on.
> 
> That might just work with threads (private futexes; which are the
> majority these these I think), but will obviously not work with regular
> (shared) futexes.

If we have enough space available either in the lock word or just nearby,
we could write the CPU number that was current when the thread owning
the lock grabbed it. Considering that it should be infrequent that threads
get migrated to other CPUs while holding the lock, it might be a good enough
heuristic to figure out whether a thread needs to busy-wait or immediately
call futex.

Writing the CPU number would work both for private and shared futexes.

> 
>>   - If so, we _know_ we should let the owner run, so we call futex right away,
>>     no spinning. We can even boost it for priority inheritance mutexes,
>>   - If it's owned by a thread which was last running on a different CPU,
>>     then it may make sense to actively try to grab the lock by spinning
>>     up to a certain number of loops (which can be either fixed or adaptative).
>>     After that limit, call futex. If preempted while looping, call futex.
>> 
>> Do you see this as an improvement over what exists today, or am I
>> on the wrong track ?
> 
> That's probably better than what they have today. Last time I looked at
> libc pthread I got really sad -- arguably that was a long time ago, and
> some of that stuff is because POSIX, but still.
> 
> Some day we should redesign all that.. futex2 etc.

It sounds like an interesting topic to bring up at the next LPC! In the
meantime, a good start would be to state the desiderata of what requirements
should be covered by this redesign.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
