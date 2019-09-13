Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91CCC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B320717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="a17y1qZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfIMOWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:22:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:40776 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfIMOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:22:30 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B6CC32D11D7;
        Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2w65EiQcfVCw; Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4DF352D11D4;
        Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4DF352D11D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568384548;
        bh=zyAhigWU92W1dtrcEnIh1pSwQol9rPOoZNQGUNIEmvE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=a17y1qZgEDs/Brk4Gz3JXfM9+tAyIiDI7FVjlmgwQdNHiKQtNbxFAO0t7Qxrp1D9B
         pAbSkk8ayJvFZgDM99G7A3CJmFthcV1Bs43Ap9JmlWw/KqsH1BH8fRabyq8dyrx4II
         HmkNqP8t0Tm0OIdAmKSzdvviM9npghFuBVVpkJFDu7kO9AnRFouPb2jgO3BYBqLA2S
         jsKeW4VufId4yeigvjWVWH/DCmTvmG/HGV1rloJ20wiywMo/TwsRHVEc6ACqyBg23T
         UXwvT0eQjZa9T7AuLvlCkE/Xk4PnwV/2Z/H1T3DdxX/GNP5t/p11khntoOSbObSP89
         3mTAkWcMu4O2A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7jhUEguWebVF; Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 313DB2D11C9;
        Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
Date:   Fri, 13 Sep 2019 10:22:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1283729551.2396.1568384548023.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190912154734.j3mmjmqf2iltbenm@willie-the-truck>
References: <20190906082305.GU2349@hirez.programming.kicks-ass.net> <20190908134909.12389-1-mathieu.desnoyers@efficios.com> <CAHk-=wg3AANn8K3OyT7KRNvVC5s0rvWVxXJ=_R+TAd3CGdcF+A@mail.gmail.com> <137355288.1941.1568108882233.JavaMail.zimbra@efficios.com> <20190912134802.mhxyy25xemy5sycm@willie-the-truck> <CAHk-=wgC8YspwtUeaV9ZwHjZDfXaJaT7i4v==Dp-vnVOF5i6qg@mail.gmail.com> <20190912154734.j3mmjmqf2iltbenm@willie-the-truck>
Subject: Re: [RFC PATCH 4/4] Fix: sched/membarrier: p->mm->membarrier_state
 racy load (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load (v2)
Thread-Index: wlym/uNPLv9pS2WwFYb7SBQkPrpN0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 12, 2019, at 11:47 AM, Will Deacon will@kernel.org wrote:

> On Thu, Sep 12, 2019 at 03:24:35PM +0100, Linus Torvalds wrote:
>> On Thu, Sep 12, 2019 at 2:48 PM Will Deacon <will@kernel.org> wrote:
>> >
>> > So the man page for sys_membarrier states that the expedited variants "never
>> > block", which feels pretty strong. Do any other system calls claim to
>> > provide this guarantee without a failure path if blocking is necessary?
>> 
>> The traditional semantics for "we don't block" is that "we block on
>> memory allocations and locking and user accesses etc, but  we don't
>> wait for our own IO".
>> 
>> So there may be new IO started (and waited on) as part of allocating
>> new memory etc, or in just paging in user memory, but the IO that the
>> operation _itself_ explicitly starts is not waited on.
> 
> Thanks, that makes sense, and I'd be inclined to suggest an update to the
> sys_membarrier manpage to make this more clear since the "never blocks"
> phrasing doesn't seem to be used like this for other system calls.

The current wording from membarrier(2) is:

              The  "expedited" commands complete faster than the non-expedited
              ones; they never block, but have the downside of  causing  extra
              overhead.

We could simply remove the "; they never block" part then ?

> 
>> No system call should ever be considered "atomic" in any sense. If
>> you're doing RT, you should maybe expect "getpid()" to not ever block,
>> but that's just about the exclusive list of truly nonblocking system
>> calls, and even that can be preempted.
> 
> In which case, why can't we just use GFP_KERNEL for the cpumask allocation
> instead of GFP_NOWAIT and then remove the failure path altogether? Mathieu?

Looking at:

#define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)

I notice that it does not include __GFP_NOFAIL. What prevents GFP_KERNEL from
failing, and where is this guarantee documented ?

Regarding __GFP_NOFAIL, its use seems to be discouraged in linux/gfp.h:

 * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures. The allocation could block
 * indefinitely but will never return with failure. Testing for
 * failure is pointless.
 * New users should be evaluated carefully (and the flag should be
 * used only when there is no reasonable failure policy) but it is
 * definitely preferable to use the flag rather than opencode endless
 * loop around allocator.
 * Using this flag for costly allocations is _highly_ discouraged.

So I am reluctant to use it.

But if we can agree on the right combination of flags that guarantees there
is no failure, I would be perfectly fine with using them to remove the fallback
code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
