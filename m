Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BEC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534472184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="I+eUfMb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfGEPi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:38:56 -0400
Received: from mail.efficios.com ([167.114.142.138]:43986 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGEPiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:38:55 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0038126814A;
        Fri,  5 Jul 2019 11:38:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id tmv_MsodI3cI; Fri,  5 Jul 2019 11:38:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7F87F268142;
        Fri,  5 Jul 2019 11:38:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7F87F268142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562341133;
        bh=gx/id1g8GUisqbjylZaPQg643OlUHlurECJ3/jf8+Xg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=I+eUfMb04YdeeRb63Knr6XjdjEwUGLJjmvk/3XgjMJEMDSFDEm82LSItqo31fzY4K
         tcUaEQciIK3DmL6RC4Y7WZMZiqollsH1I2pGl4KBYFWTWhjC2q/zmXziNi8QQGIrE6
         6eSn53vdu6NyUzmS1NS6DwS8Dx3pdZWqZPlBEfIQiW4FMAgvHs/jaygrM9mKjB2VY1
         4iV7A8ywbk7Z/sOtywfK+1bdRivAoQAvL1Ip7pHoMYBhNrtYvXp868WWjwLXuCxF8e
         0mNbbUEz9quD60QNcbxb8M1eM4i8zlmeO0vrlpEyUzl5KzYsXa42H549+KkmGBNFmf
         23tTv3I543lgg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id J4Iu3JDhnM8j; Fri,  5 Jul 2019 11:38:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 67CF426813C;
        Fri,  5 Jul 2019 11:38:53 -0400 (EDT)
Date:   Fri, 5 Jul 2019 11:38:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190705084910.GA6592@gmail.com>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de> <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com> <20190705084910.GA6592@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: nU6gdcLke6FMEQgIxAukHhBVhVlYHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Jul 5, 2019, at 4:49 AM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Jul 4, 2019, at 6:33 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> 
>> > On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:
>> >> ----- On Jul 4, 2019, at 5:10 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> >> >
>> >> > num_online_cpus() is racy today vs. CPU hotplug operations as
>> >> > long as you don't hold the hotplug lock.
>> >> 
>> >> Fair point, AFAIU none of the loads performed within num_online_cpus()
>> >> seem to rely on atomic nor volatile accesses. So not using a volatile
>> >> access to load the cached value should not introduce any regression.
>> >> 
>> >> I'm concerned that some code may rely on re-fetching of the cached
>> >> value between iterations of a loop. The lack of READ_ONCE() would
>> >> let the compiler keep a lifted load within a register and never
>> >> re-fetch, unless there is a cpu_relax() or a barrier() within the
>> >> loop.
>> > 
>> > If someone really wants to write code which can handle concurrent CPU
>> > hotplug operations and rely on that information, then it's probably better
>> > to write out:
>> > 
>> >     ncpus = READ_ONCE(__num_online_cpus);
>> > 
>> > explicitely along with a big fat comment.
>> > 
>> > I can't figure out why one wants to do that and how it is supposed to work,
>> > but my brain is in shutdown mode already :)
>> > 
>> > I'd rather write a proper kernel doc comment for num_online_cpus() which
>> > explains what the constraints are instead of pretending that the READ_ONCE
>> > in the inline has any meaning.
>> 
>> The other aspect I am concerned about is freedom given to the compiler
>> to perform the store to __num_online_cpus non-atomically, or the load
>> non-atomically due to memory pressure.
> 
> What connection does "memory pressure" have to what the compiler does?
> 
> Did you confuse it with "register pressure"?

My brain wires must have been crossed when I wrote that. Indeed, I mean
register pressure.

> 
>> Is that something we should be concerned about ?
> 
> Once I understand it :)
> 
>> I thought we had WRITE_ONCE and READ_ONCE to take care of that kind of
>> situation.
> 
> Store and load tearing is one of the minor properties of READ_ONCE() and
> WRITE_ONCE() - the main properties are the ordering guarantees.
> 
> Since __num_online_cpus is neither weirdly aligned nor is it written via
> constants I don't see how load/store tearing could occur. Can you outline
> such a scenario?

I'm referring to the examples provided in Documentation/core-api/atomic_ops.rst,
e.g.:

"For another example, consider the following code::

        tmp_a = a;
        do_something_with(tmp_a);
        do_something_else_with(tmp_a);

 If the compiler can prove that do_something_with() does not store to the
 variable a, then the compiler is within its rights to manufacture an
 additional load as follows::

        tmp_a = a;
        do_something_with(tmp_a);
        tmp_a = a;
        do_something_else_with(tmp_a);"

So if instead of "a" we have num_online_cpus(), the compiler would be
within its right to re-fetch the number of online cpus between the two
calls, which seems unexpected.

> 
>> The semantic I am looking for here is C11's relaxed atomics.
> 
> What does this mean?

C11 states:

"Atomic operations specifying memory_order_relaxed are  relaxed  only  with  respect
to memory ordering.  Implementations must still guarantee that any given atomic access
to a particular atomic object be indivisible with respect to all other atomic accesses
to that object."

So I am concerned that num_online_cpus() as proposed in this patch
try to access __num_online_cpus non-atomically, and without using
READ_ONCE().

Similarly, the update-side should use WRITE_ONCE(). Protecting with a mutex
does not provide mutual exclusion against concurrent readers of that variable.

Again based on Documentation/core-api/atomic_ops.rst:

"For a final example, consider the following code, assuming that the
 variable a is set at boot time before the second CPU is brought online
 and never changed later, so that memory barriers are not needed::

        if (a)
                b = 9;
        else
                b = 42;

 The compiler is within its rights to manufacture an additional store
 by transforming the above code into the following::

        b = 42;
        if (a)
                b = 9;

 This could come as a fatal surprise to other code running concurrently
 that expected b to never have the value 42 if a was zero.  To prevent
 the compiler from doing this, write something like::

        if (a)
                WRITE_ONCE(b, 9);
        else
                WRITE_ONCE(b, 42);"

If the compiler decides to manufacture additional stores when updating
the __num_online_cpus cached value, then loads could observe this
intermediate value because they fetch it without holding any mutex.

Thanks,

Mathieu

> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
