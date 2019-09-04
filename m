Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E262C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F7321883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GhnvM7V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfIDPTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:19:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:54320 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:19:02 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C60772589A0;
        Wed,  4 Sep 2019 11:19:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id uj_5BON3Ci9H; Wed,  4 Sep 2019 11:19:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4F05B258999;
        Wed,  4 Sep 2019 11:19:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4F05B258999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1567610340;
        bh=jMsk0oEwo//eANqSbcDnyJCuo13omFBjx4L1wP3Qi+o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GhnvM7V8l0497YQaTk8M2FpHvWM26eE9L8aWgvE42rv0ZggXvLysJnbuEA9aYZ2zY
         NmkRYXS1i2IX5RXEXA9GrLjIdFj4ENFKDM8JdN8EKGrLWut6xUBf6ImYXzUnG7aD1o
         PvGJuZfFMOlqqxB7TX7UAa6y0XRxl0lx1JfjLA6a1RjUIuRHKT14057B/VOIFNdcF6
         XGOsFKN1BipFfpYQKORMeMMgIJCHkJeWYHBs6Vq4YsyMbeJTyHzb+WQz0xanPmoztk
         By/Q/c8icS6Jl+XGsQEJpnBkIfTR0UEtz8SJWY1knEGp53B4J0RW63erl36mimn9tY
         XNL/I2eo4Rm+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id S-pnmq3E6yCJ; Wed,  4 Sep 2019 11:19:00 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2ECF2258989;
        Wed,  4 Sep 2019 11:19:00 -0400 (EDT)
Date:   Wed, 4 Sep 2019 11:19:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Lameter <cl@linux.com>, Kirill Tkhai <tkhai@yandex.ru>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1604807537.1565.1567610340030.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com> <20190903202434.GX2349@hirez.programming.kicks-ass.net> <CAHk-=whfYb5RnJGqDV3W3093XGwOwePV-SxixaWcWM6hmidArg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3829 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3829)
Thread-Topic: sched/membarrier: p->mm->membarrier_state racy load
Thread-Index: +sG4r4buUE0PNk9oDBxRqsMv8RT9sg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Sep 3, 2019, at 4:36 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Sep 3, 2019 at 1:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Why can't we frob this state into a line/word we already have to
>> unconditionally touch, like the thread_info::flags word for example.
> 
> I agree, but we don't have any easily used flags left, I think.
> 
> But yes, it would be better to not have membarrier always dirty
> another cacheline in the scheduler. So instead of
> 
>        atomic_set(&t->membarrier_state,
>                   atomic_read(&t->mm->membarrier_state));
> 
> it migth be better to do something like
> 
>        if (mm->membarrier_state)
>                atomic_or(&t->membarrier_state, mm->membarrier_state);
> 
> or something along those lines - I think we've already brought in the
> 'mm' struct into the cache anyway, and we'd not do the write (and
> dirty the destination cacheline) for the common case of no membarrier
> usage.
> 
> But yes, it would be better still if we can re-use some already dirty
> cache state.

Considering the alternative proposed by PeterZ, which is to iterate over
all processes/threads from an unprivileged process, I would be tempted
to put some more thoughts into the mm->membarrier_state cache-line. Do
we expect it to be typically hot ? Is there anything we can do to move
this field into a typically hot mm cacheline ?

I agree with your approach aiming to typically just load that field
(no store in the common case).

> 
> I wonder if the easiest model might be to just use a percpu variable
> instead for the membarrier stuff? It's not like it has to be in
> 'struct task_struct' at all, I think. We only care about the current
> runqueues, and those are percpu anyway.

One issue here is that membarrier iterates over all runqueues without
grabbing any runqueue lock. If we copy that state from mm to rq on
sched switch prepare, we would need to ensure we have the proper
memory barriers between:

prior user-space memory accesses  /  setting the runqueue membarrier state

and

setting the runqueue membarrier state / following user-space memory accesses

Copying the membarrier state into the task struct leverages the fact that
we have documented and guaranteed those barriers around the rq->curr update
in the scheduler.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
