Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EE620872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfJOUbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfJOUbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8990C302C08E;
        Tue, 15 Oct 2019 20:31:06 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-27.rdu2.redhat.com [10.10.123.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7985860127;
        Tue, 15 Oct 2019 20:31:05 +0000 (UTC)
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
To:     Manfred Spraul <manfred@colorfullife.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
 <20191014130321.GG2328@hirez.programming.kicks-ass.net>
 <ef45c2ca-942a-df83-22cf-690eaf761fb7@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c46f8cfa-056a-059c-a193-376a0d710699@redhat.com>
Date:   Tue, 15 Oct 2019 16:31:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ef45c2ca-942a-df83-22cf-690eaf761fb7@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 15 Oct 2019 20:31:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 1:49 PM, Manfred Spraul wrote:
> Hello Peter,
>
> On 10/14/19 3:03 PM, Peter Zijlstra wrote:
>> On Sat, Oct 12, 2019 at 07:49:58AM +0200, Manfred Spraul wrote:
>>> The documentation in memory-barriers.txt claims that
>>> smp_mb__{before,after}_atomic() are for atomic ops that do not return a
>>> value.
>>>
>>> This is misleading and doesn't match the example in atomic_t.txt,
>>> and e.g. smp_mb__before_atomic() may and is used together with
>>> cmpxchg_relaxed() in the wake_q code.
>>>
>>> The purpose of e.g. smp_mb__before_atomic() is to "upgrade" a following
>>> RMW atomic operation to a full memory barrier.
>>> The return code of the atomic operation has no impact, so all of the
>>> following examples are valid:
>> The value return of atomic ops is relevant in so far that
>> (traditionally) all value returning atomic ops already implied full
>> barriers. That of course changed when we added
>> _release/_acquire/_relaxed variants.
> I've updated the Change description accordingly
>>> 1)
>>>     smp_mb__before_atomic();
>>>     atomic_add();
>>>
>>> 2)
>>>     smp_mb__before_atomic();
>>>     atomic_xchg_relaxed();
>>>
>>> 3)
>>>     smp_mb__before_atomic();
>>>     atomic_fetch_add_relaxed();
>>>
>>> Invalid would be:
>>>     smp_mb__before_atomic();
>>>     atomic_set();
>>>
>>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> ---
>>>   Documentation/memory-barriers.txt | 11 ++++++-----
>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/memory-barriers.txt
>>> b/Documentation/memory-barriers.txt
>>> index 1adbb8a371c7..52076b057400 100644
>>> --- a/Documentation/memory-barriers.txt
>>> +++ b/Documentation/memory-barriers.txt
>>> @@ -1873,12 +1873,13 @@ There are some more advanced barrier functions:
>>>    (*) smp_mb__before_atomic();
>>>    (*) smp_mb__after_atomic();
>>>   -     These are for use with atomic (such as add, subtract,
>>> increment and
>>> -     decrement) functions that don't return a value, especially
>>> when used for
>>> -     reference counting.  These functions do not imply memory
>>> barriers.
>>> +     These are for use with atomic RMW functions (such as add,
>>> subtract,
>>> +     increment, decrement, failed conditional operations, ...) that do
>>> +     not imply memory barriers, but where the code needs a memory
>>> barrier,
>>> +     for example when used for reference counting.
>>>   -     These are also used for atomic bitop functions that do not
>>> return a
>>> -     value (such as set_bit and clear_bit).
>>> +     These are also used for atomic RMW bitop functions that do
>>> imply a full
>> s/do/do not/ ?
> Sorry, yes, of course

I was wondering the same thing. With the revised patch,

Acked-by: Waiman Long <longman@redhat.com>

>>> +     memory barrier (such as set_bit and clear_bit).
>
>

