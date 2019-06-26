Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81FFC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A91820659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFZJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:09:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:09:41 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hg3vk-0001T2-29; Wed, 26 Jun 2019 11:09:28 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <87d0j31iyc.fsf@linutronix.de>
        <20190624140948.l7ekcmz5ser3zfr2@pathway.suse.cz>
        <87blylhjy8.fsf@linutronix.de>
        <20190626082935.ocbqqaol5jzcuxwl@pathway.suse.cz>
Date:   Wed, 26 Jun 2019 11:09:26 +0200
In-Reply-To: <20190626082935.ocbqqaol5jzcuxwl@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 26 Jun 2019 10:29:35 +0200")
Message-ID: <87pnn0yapl.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26, Petr Mladek <pmladek@suse.com> wrote:
>> To address your question: For the linked list implementation, if you
>> are looking at it from the linked list perspective, the number of
>> descriptors on the list is constantly fluctuating (increasing and
>> decreasing) and the ordering of the descriptors is constantly
>> changing. They are ordered according to the writer commit order (not
>> the writer reserve order) and the only descriptors on the list are
>> the ones that are not within a reserve/commit window.
>
> This and few other comments below are really valuable explanation.
> I misunderstood how the list worked.

I will add a documentation section about why a linked list was used.

>>>>> If the above is true then we could achieve similar result
>>>>> when using the array as a circular buffer. It would be
>>>>> the same like when all members are linked from the beginning.
>>>> 
>>>> So you are suggesting using a multi-reader multi-writer lockless
>>>> ringbuffer to implement a multi-reader multi-writer lockless
>>>> ringbuffer. ;-)
>>>> 
>>>> The descriptor ringbuffer has fixed-size items, which simplifies
>>>> the task. But I expect you will run into a chicken-egg scenario.
>>>
>>> AFAIK, the main obstacle with the fully lockless solution was
>>> that the entries did not have a fixed size.
>> 
>> No. The variable size of the records was the reason I used
>> descriptors. That has nothing to do with how I chose to connect those
>> descriptors.
>
> I think that we are talking about the same. If I remember correctly,
> the main problem is that cmpxchg() is not reliable when the same
> address might be used by the metadata and data.

The cmpxchg() issue you mention is why I needed descriptors. But even if
I were to implement a fixed-record-size ringbuffer where the cmpxchg()
issue does not exist, I _still_ would have used a linked list to connect
the records.

It is misleading to think the linked list is because of variable size
records.

John Ogness
