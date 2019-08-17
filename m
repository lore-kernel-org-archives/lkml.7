Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66824C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 20:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB502075E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 20:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfHQUEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 16:04:15 -0400
Received: from foss.arm.com ([217.140.110.172]:42904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfHQUEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 16:04:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0107337;
        Sat, 17 Aug 2019 13:04:13 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 503EE3F706;
        Sat, 17 Aug 2019 13:04:12 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     paulmck <paulmck@linux.ibm.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
 <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
 <1065930957.23914.1566054178444.JavaMail.zimbra@efficios.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <600fd72f-11a0-ff1a-c87a-b26349f6f54a@arm.com>
Date:   Sat, 17 Aug 2019 21:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1065930957.23914.1566054178444.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies to Steve for continuing this thread when all he wanted was moving
an operation inside a mutex...

On 17/08/2019 16:02, Mathieu Desnoyers wrote:
[...]
> However, if the state of "x" can be any pointer value, or a reference
> count value, then not using "WRITE_ONCE()" to store a constant leaves
> the compiler free to perform that store in more than one memory access.
> Based on [1], section "Store tearing", there are situations where this
> happens on x86 in the wild today when storing 64-bit constants: the
> compiler is then free to decide to use two 32-bit immediate store
> instructions.
> 

That's also how I understand things, and it's also one of the points raised
in the compiler barrier section of memory-barriers.txt

Taking this store tearing, or the invented stores - e.g. the branch
optimization pointed out by Linus:

>    if (a)
>       global_var = 1
>    else
>       global_var = 0
> 
> then the compiler had better not turn that into
> 
>      global_var = 0
>      if (a)
>          global_var = 1

AFAICT nothing prevents this from happening inside a critical section (where
the locking primitives provide the right barriers, but that's it). That's
all fine when data is never accessed locklessly, but in the case of locked
writes vs lockless reads, couldn't there be "leaks" of these transient
states? In those cases we would want WRITE_ONCE() for the writes.

So going back to:

> But the reverse is not really true. All a READ_ONCE() says is "I want
> either the old or the new value", and it can get that _without_ being
> paired with a WRITE_ONCE().

AFAIU it's not always the case, since a lone READ_ONCE() could get transient
values.

I'll be honest, it's not 100% clear to me when those optimizations can
actually be done (maybe the branch thingy but the others are dubious), and
it's even less clear when compilers *actually* do it - only that they have
been reported to do it (so it's not made up).

> Thanks,
> 
> Mathieu
> 
> [1] https://lwn.net/Articles/793253/
> 
