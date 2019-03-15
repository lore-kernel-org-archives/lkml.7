Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B010218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfCOKXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:23:32 -0400
Received: from mx.sdf.org ([205.166.94.20]:64830 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfCOKXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:23:32 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2FANFZM017594
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 15 Mar 2019 10:23:15 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2FANDVY013031;
        Fri, 15 Mar 2019 10:23:13 GMT
Date:   Fri, 15 Mar 2019 10:23:13 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903151023.x2FANDVY013031@sdf.org>
To:     geert@linux-m68k.org, lkml@sdf.org
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, st5pub@yandex.ru
In-Reply-To: <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>,
    <20190314091041.GU9224@smile.fi.intel.com>,
    <201903150433.x2F4X9oT024601@sdf.org>,
    <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 at 09:20:58 +0100, Geert Uytterhoeven wrote:
> On Fri, Mar 15, 2019 at 5:33 AM George Spelvin <lkml@sdf.org> wrote:
>> On Thu, 14 Mar 2019 at 11:10:41 +0200, Andy Shevchenko wrote:
>>> On Tue, Mar 05, 2019 at 03:06:44AM +0000, George Spelvin wrote:
>>>> +            for (bit = 1; count & bit; bit <<= 1) {
>>>> +                    cur = merge(priv, (cmp_func)cmp, pending, cur);
>>>> +                    pending = pending->prev;  /* Untouched by merge() */
>>>>              }
>>>
>>> Wouldn't be it the same to
>>>
>>>       bit = ffz(count);
>>>       while (bit--) {
>>>               ...
>>>       }
>>> ?
>>>
>>> Though I dunno which one is generating better code.
>>
>> One question I should ask everyone: should "count" be 32 or 64 bits
>> on 64-bit machines?  That would let x86 save a few REX bytes.  (815
>> vs. 813 byte code, if anyone cares.)
>>
>> Allegedy ARM can save a few pJ by gating the high 32
>> bits of the ALU.
>>
>> Most other 64-bit processors would prefer 64-bit operations as
>> it saves masking operations.
>>
>> If we never sort a list with more than 2^32 entries, it
>> makes no difference.
>>
>> If we use a 32-bit count and we *do* sort a list with more than
>> 2^32 entries, then it still sorts, but the performance degrades to
>> O((n/2^32)^2).
>>
>> Just how often do we expect the kernel to face lists that long?
>> (Note that the old code was O((n/2^20)^2).)
>
> Using size_t sounds most logical to me (argument of least surprise).

Yes, it is the obvious solution, which is why that's my default choice.

But a bit of thought shows that a list long enough to break a
32-bit implementation is beyond ridiculous.

The list must be at least 3 * 2^32 elements long to make the sort
merge non-optimally.  That's 1.5 * 2^37 bytes (192 GiB) of list_head
structures alone; at least double that for any practical application.
And 32 * 3 * 2^32 + (2 + 3) * 2^32 = 101 * 2^32 = 1.57 * 2^38
compares.

That seems like a lot but that's not the botteneck.  Each compare
reads from a new list element, and pretty soon, they'll miss all
caches and go to main memory.

Since the memory locations are random, for any small subset of the
list, you'll get only one element per cache line.  A 32 MiB L3
cache is 2^19 cache lines (assuming 64B lines).  So merge levels
20 through 33 will go to main memory.

That's (12 * 3 + 5) * 2^32 = 1.28 * 2^37 cache misses.  At 60 ns each (typical
local DRAM access time on i7 & Xeon according to Intel), that's a
hard minimum of 10565 seconds = 2h 56m 05s in one list_sort call.

This is definitely the scale of problem where a mutithreaded sort is
called for.

It's *so* impossible that maybe it's worth trading that capability
for a couple of bytes in the inner loop.

>> In the code, I could do something like
>>
>> #ifdef CONFIG_X86_64
>> /* Comment explaining why */
>> typedef uint32_t count_t;
>> #else
>> typedef size_t count_t;
>> #endif
>>
>> ...
>>         count_t count = 0;
>
> Using different types makes it more complex, e.g. to print the value
> in debug code.
> And adding more typedefs is frowned upon.

It's a *local* typedef, purely for the purpose of moving #ifdef clutter
out of the function declaration.  I agree that *global* typedefs are
discouraged.

As for debugging, that's a red herring; it's easy to cast to (size_t).

> Just my 0.02€.

Thank you for considering the issue!

>> I prefer the shorter _ints and _longs names, but this is just
>> not a hill I want to die on.
>
> Argument of least surprise: don't call something a duck if it's not
> guaranteed to behave like a duck.
>
> If I read "long", this triggers a warning flag in my head: be careful,
> this is 32-bit on 32-bit platforms, and 64-bit on 64-bit platforms.

Good point.  And "_longlong" or "_llong" is a bit ugly, too.
