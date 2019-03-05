Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4434DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F271420652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LhxWSYHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfCEWcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:32:13 -0500
Received: from mail.efficios.com ([167.114.142.138]:54076 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEWcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:32:13 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 65D77AE282;
        Tue,  5 Mar 2019 17:32:11 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id SW3CvKQPVOD2; Tue,  5 Mar 2019 17:32:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B940CAE27A;
        Tue,  5 Mar 2019 17:32:10 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B940CAE27A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551825130;
        bh=ax7B7oLc1o9AUMV+wodZRGsqtra/aAnOc45Q/Ac5dQ4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LhxWSYHUtPw7tuHiRtlwASKYYOmZleWs6APU6QeVCwQtoaF54wREkFTVc7jtuj6o/
         M1NTvGrJ7rBHaIlQnXlf5w3R1d1BPukBQ2orhufOkQP63Q5HcNJ3QyUDOmXXhTgxti
         XHAtcbQlP5MOXkmecbFfGsHcTA+VKa8NM+PTdOmU7jEkCVg/X4tNgGujwmDCVyPsNF
         9v1UWp9Oymm67meta4kpePCsQIkeo99RQQkI7uHn540W9EG+lPvBlzRAgWbEeoqlaH
         2HVJwaecRgf/nQ5qykEKw1+uUDvNlBeFSuTgs+7wfZqz0esvLSHgKHRCLw7y5m6DTo
         UuiMt98kpEqKg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id w8ytWTwfEmSo; Tue,  5 Mar 2019 17:32:10 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9EA10AE272;
        Tue,  5 Mar 2019 17:32:10 -0500 (EST)
Date:   Tue, 5 Mar 2019 17:32:10 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Joel Fernandes <joelaf@google.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Message-ID: <486623963.509.1551825130539.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190305215848.GQ32477@hirez.programming.kicks-ass.net>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com> <20190305215848.GQ32477@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3780)
Thread-Topic: Restartable Sequences updates for 5.1
Thread-Index: LPOx5FAolDyV2SsF1jcLtD2BwfsXcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 5, 2019, at 4:58 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Mar 05, 2019 at 03:18:35PM -0500, Mathieu Desnoyers wrote:
>> * NUMA node ID in TLS
>> 
>> Having the NUMA node ID available in a TLS variable would allow glibc to
>> perform interesting NUMA performance improvements within its locking
>> implementation, so I have a patch adding NUMA node ID support to rseq
>> as a new rseq system call flag.
> 
> Details? There's just not much room in the futex word, and futexes
> themselves are not numa aware.

It was discussed in this libc-alpha mailing list thread:

https://public-inbox.org/libc-alpha/CAMe9rOo7i_-keOooa0D+P_wzatVCdKkTRiFiJ-cxpnvi+eApuQ@mail.gmail.com/

(adding the relevant people in CC)

I'd like to hear in more details on how they intend to design
NUMA-aware spinlocks within glibc. All I know is that quick
access to the node ID would help for this.

I would suspect we could split a lock into per-numa-node locks.
Grabbing the local numa lock would then allow grabbing the global
lock. This should help reducing remote NUMA accesses on the global
lock in contended cases, but I'm really just guessing here.

> 
> Before all this spectre nonsense; tglx and me were looking at a futex2
> syscall that would, among other things, cure this.

The email thread I point to above talks about "spinlocks", so I'm not
sure whether their intent is to apply this to mutexes as well.

> 
>> * Adaptative mutex improvements
>> 
>> I have done a prototype using rseq to implement an adaptative mutex which
>> can detect preemption using a rseq critical section. This ensures the
>> thread doesn't continue to busy-loop after it returns from preemption, and
>> calls sys_futex() instead. This is part of a user-space prototype branch [2],
>> and does not require any kernel change.
> 
> I'm still not convinced that is actually the right way to go about
> things. The kernel heuristic is spin while the _owner_ runs, and we
> don't get preempted, obviously.
> 
> And the only userspace spinning that makes sense is to cover the cost of
> the syscall. Now Obviously PTI wrecked everything, but before that
> syscalls were actually plenty fast and you didn't need many cmpxchg
> cycles to amortize the syscall itself -- which could then do kernel side
> adaptive spinning (when required).

Indeed with PTI the system calls are back to their slow self. ;)

You point about owner is interesting. Perhaps there is one tweak that I
should add in there. We could write the owner thread ID in the lock word.

When trying to grab a lock, one of a few situations can happen:

- It's unlocked, so we grab it by storing our thread ID,
- It's locked, and we can fetch the CPU number of the thread owning it
  if we can access its (struct rseq *)->cpu_id through a lookup using its
  thread ID, We can then check whether it's the same CPU we are running on.
  - If so, we _know_ we should let the owner run, so we call futex right away,
    no spinning. We can even boost it for priority inheritance mutexes,
  - If it's owned by a thread which was last running on a different CPU,
    then it may make sense to actively try to grab the lock by spinning
    up to a certain number of loops (which can be either fixed or adaptative).
    After that limit, call futex. If preempted while looping, call futex.

Do you see this as an improvement over what exists today, or am I
on the wrong track ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
