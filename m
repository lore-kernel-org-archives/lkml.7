Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7EC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF04F2465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfLTKod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:44:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:38738 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfLTKod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:44:33 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iiFlN-0005vW-TS; Fri, 20 Dec 2019 13:44:06 +0300
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kirill Tkhai <tkhai@yandex.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.510271353@goodmis.org>
 <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
 <20191220100033.GE2844@hirez.programming.kicks-ass.net>
 <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5846dfc3-a7a8-25af-aec7-3e326cf54efd@virtuozzo.com>
Date:   Fri, 20 Dec 2019 13:44:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2019 13:12, Rasmus Villemoes wrote:
> On 20/12/2019 11.00, Peter Zijlstra wrote:
>> On Fri, Dec 20, 2019 at 09:52:37AM +0100, Rasmus Villemoes wrote:
>>> On 19/12/2019 22.44, Steven Rostedt wrote:
>>>> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>>>>
>>>> In order to make a micro optimization in pick_next_task(), the order of the
>>>> sched class descriptor address must be in the same order as their priority
>>>> to each other. That is:
>>>>
>>>>  &idle_sched_class < &fair_sched_class < &rt_sched_class <
>>>>  &dl_sched_class < &stop_sched_class
>>>>
>>>> In order to guarantee this order of the sched class descriptors, add each
>>>> one into their own data section and force the order in the linker script.
>>>
>>> I think it would make the code simpler if one reverses these, see other
>>> reply.
>>
>> I started out agreeing, because of that mess around STOP_SCHED_CLASS and
>> that horrid BEFORE_CRUD thing.
>>
>> Then, when I fixed it all up, I saw what it did to Kyrill's patch (#4)
>> and that ends up looking like:
>>
>> -       if (likely((prev->sched_class == &idle_sched_class ||
>> -                   prev->sched_class == &fair_sched_class) &&
>> +       if (likely(prev->sched_class >= &fair_sched_class &&
>>
>> And that's just weird.
> 
> I kind of agree, but if one can come up with good enough macro names, I
> think all that comparison logic should be in helpers either way the
> array is laid out. Something like
> 
> #define sched_class_lower_eq [something] /* perhaps comment on the array
> order */
> sched_class_lower_eq(prev->sched_class, &fair_sched_class)

You started from making code simple argument. But in case of we make the code
simple in this single place, the rest of code, which are the many places, will
become wrapped over huge helpers, which make the readability worse IMO.

After we have implemented a reliable sections order in lds file, we may use
it for a long time without remembering the way they are organized. But in case
of we introduce huge helpers, we always will bump into them during analyzing
of difficult asynchronous code, and these helpers size will overflow internal
buffers in our heads just by their excess symbols.

My opinion is to better make some less beautiful thing in a single synchronous place,
than to distribute the redundancy over all the code (especially, when it is asynchronous).

>> Then I had a better look and now...
>>
>>>> +/*
>>>> + * The order of the sched class addresses are important, as they are
>>>> + * used to determine the order of the priority of each sched class in
>>>> + * relation to each other.
>>>> + */
>>>> +#define SCHED_DATA				\
>>>> +	*(__idle_sched_class)			\
>>>> +	*(__fair_sched_class)			\
>>>> +	*(__rt_sched_class)			\
>>>> +	*(__dl_sched_class)			\
>>>> +	STOP_SCHED_CLASS
>>
>> I'm confused, why does that STOP_SCHED_CLASS need magic here at all?
>> Doesn't the linker deal with empty sections already by making them 0
>> sized?
> 
> Yes, but dropping the STOP_SCHED_CLASS define doesn't prevent one from
> needing some ifdeffery to define highest_sched_class if they are laid
> out in (higher sched class <-> higher address) order.
> 
> Rasmus
> 

