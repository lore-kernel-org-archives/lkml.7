Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA15E218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfDWTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:12:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfDWTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:12:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE13EC02E60C;
        Tue, 23 Apr 2019 19:12:23 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-167.rdu2.redhat.com [10.10.123.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 836355D705;
        Tue, 23 Apr 2019 19:12:22 +0000 (UTC)
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
Date:   Tue, 23 Apr 2019 15:12:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 23 Apr 2019 19:12:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 12:27 PM, Linus Torvalds wrote:
> On Tue, Apr 23, 2019 at 7:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> I'm not aware of an architecture where disabling interrupts is faster
>> than disabling preemption.
> I don't thin kit ever is, but I'd worry a bit about the
> preempt_enable() just because it also checks if need_resched() is true
> when re-enabling preemption.
>
> So doing preempt_enable() as part of rwsem_read_trylock() might cause
> us to schedule in *exactly* the wrong place,

You are right on that. However, there is a variant called
preempt_enable_no_resched() that doesn't have this side effect. So I am
going to use that one instead.

> So if we play preemption games, I wonder if we should make them more
> explicit than hiding them in that helper function, because
> particularly for the slow path case, I think we'd be much better off
> just avoiding the busy-loop in the slow path, rather than first
> scheduling due to preempt_enable(), and then starting to look at the
> slow path onlly afterwards.
>
> IOW, I get the feeling that the preemption-off area might be better
> off being potentially much bigger, and covering the whole (or a large
> portion) of the semaphore operation, rather than just the
> rwsem_read_trylock() fastpath.
>
> Hmm?

That is true in general, but doing preempt_disable/enable across
function boundary is ugly and prone to further problems down the road.

Cheers,
Longman

>                    Linus


