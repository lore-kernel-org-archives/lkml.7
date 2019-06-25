Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D81208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfFYN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:29:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFYN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:29:48 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hflVx-0008L6-14; Tue, 25 Jun 2019 15:29:37 +0200
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
Date:   Tue, 25 Jun 2019 15:29:35 +0200
Message-ID: <87blylhjy8.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-24, Petr Mladek <pmladek@suse.com> wrote:
>>> 1. Linked list of descriptors
>>> -----------------------------
>>>
>>> The list of descriptors makes the code more complicated
>>> and I do not see much gain. It is possible that I just missed
>>> something.
>>>
>>> If I get it correctly then the list could only grow by adding
>>> never used members. The already added members are newer removed
>>> neither shuffled.
>
> Is the above paragraph correct, please?

Sorry for not addressing this remark. I am trying to be careful and not
steer you to a certain implementation. I failed to achieve what you are
attempting. You are already doing things slightly different, so my
experiences regarding this may falsely discourage you from figuring out
how to do it.

To address your question: For the linked list implementation, if you are
looking at it from the linked list perspective, the number of
descriptors on the list is constantly fluctuating (increasing and
decreasing) and the ordering of the descriptors is constantly
changing. They are ordered according to the writer commit order (not the
writer reserve order) and the only descriptors on the list are the ones
that are not within a reserve/commit window.

>>> If the above is true then we could achieve similar result
>>> when using the array as a circular buffer. It would be
>>> the same like when all members are linked from the beginning.
>> 
>> So you are suggesting using a multi-reader multi-writer lockless
>> ringbuffer to implement a multi-reader multi-writer lockless
>> ringbuffer. ;-)
>> 
>> The descriptor ringbuffer has fixed-size items, which simplifies the
>> task. But I expect you will run into a chicken-egg scenario.
>
> AFAIK, the main obstacle with the fully lockless solution was
> that the entries did not have a fixed size.

No. The variable size of the records was the reason I used
descriptors. That has nothing to do with how I chose to connect those
descriptors.

> If I understand it correctly, the list works exactly as a
> ring buffer once all available descriptors are used.

There are a lot of details hiding in the words "exactly as a ring
buffer". We are talking about a (truly) lockless ringbuffer that
supports concurrent writers. (IMO my v1 rfc ringbuffer was not truly
lockless because of the prb_lock.) AFAIK there is no such ringbuffer
implementation in existence, otherwise I would have used that instead of
writing my own.

>>> It would allow to remove:
>>>
>>>     + desc->id because it will be the same as desc->seq
>>>     + desc->next because the address of the next member
>>> 		can be easily counted
>> 
>> Yes, you will remove these and then replace them with new variables
>> to track array-element state.
>
> Yes, it should easier to understand that, for example, a descriptor
> is free by a flag named "free" than by some magic check of links.
>
> It is not must to have. But the code is complicated. Anything
> that might make it easier to understand is much appreciated.

I think it is not as simple as you think it is and I expect you will end
up with a solution that is more complex (although I could be
wrong). IMHO the linked list solution is quite elegant. Perhaps the real
problem is my coding style, poor naming, and horrible comments.

>>> I think that it might be much more safe when we mask the two
>>> highest bits of seq number and use them for the flags.
>>> Then we could track the state of the given sequence number
>>> a very safe and straightforward way.
>> 
>> When I first started to design/code this, I implemented something
>> quite similar: using a single variable to represent state and
>> id. This works nicely for cmpxchg operations (lockless
>> synchronization) and reader validation. The problem I ran into was a
>> chicken-egg problem (which I suspect you will also run into).
>
> Do you remember more details about the chicken-egg problem, please?

You really already answered your own question when you stated:

    "we could achieve similar result when using the array
     as a circular buffer"

That circular buffer must have the same features as the circular buffer
we are trying to implement. My choice to use a linked list was not due
to variable sized records, but rather that is the only way I could
figure out how to implement a lockless multi-writer multi-reader
ringbuffer.

Again, that doesn't mean it isn't possible. But _I_ could not get it to
work. I had all kinds of state tracking and crazy cmpxchg loops and
wacky races. Switching to linked lists made everything so much simpler
and straight forward. (Many thanks my colleague Benedikt Spranger for
coming up with the idea!)

> I believe that there might be one. Any hint just could save
> me quite some time.
>
> I have hit two big dead ends so far:
>
>   1. I was not able to free data when there was no free descriptor
>      and free descriptor when the data have already been freed.
>      I was not able to make both operations race-free.

This is why I reserve the descriptor before reserving the data, so that
this situation can never occur.

Note that invalid descriptors in the linked list do not act as
terminators for readers. The readers simply traverse over the invalid
descriptors until they hit an EOL.

>      I got inspiration from remove_oldest_descr() and solved this
>      by failing to get descriptor when there was no free one.
>
>      But it is possible that I just did not try hard enough.
>      I see that your code is actually able to free the data
>      and descriptor from assign_descriptor().
>
>
>   2. I was not able to free the oldest data. I did not know
>      how to make sure that the seq read from the data buffer
>      was valid.
>
>      My plan was to solve this by changing seq and state flags
>      in the descriptor atomically. Then I would just check
>      whether the seq was in valid bounds (I would ignore
>      overflow) and that the flag "committed" was set. Then
>      I would just set the flag "freed". The descriptor
>      itself would be freed from prb_get_desc().
>
>      But I might actually use similar approach like you
>      are using in expire_oldest_data(). We could assume
>      that as long as the desc->seq is within valid
>      bounds (rb->first_seq <= seq <= rb->last_seq)
>      then it is the right descriptor.

desc->seq is not some random data. If it is >= rb->first_seq (and points
back to the same data block!), it is what you are looking for.

>> I solved this problem by changing the design to use a linked list for
>> the descriptors. At first I had kept state information for each
>> descriptor. But later I realized that state information was not
>> necessary because the linked list itself was providing implicit state
>> information.
>
> And this is my problem. I do not see how the list itself provides
> the state information. Especially I do not see how it distinguishes
> reserved and commited state, for example, from expire_oldest_data()
> point of view.

_All_ descriptors on the linked list are not within the reserve/commit
window and no writers have pointers to them. (The only exception is the
newest descriptor, whose next will be modified by a writer that is
adding a new descriptor. That is the reason that if there is only 1
descriptor on the list, it must not be removed. A writer might be
modifying its next.)

When a writer wants to reserve data (i.e. enter the reserve/commit
window), the first thing it must do is pull a descriptor off the
list. With the descriptor off the list, the writer is free to do
whatever it needs to do to prepare the data and the descriptor. And when
it is done committing (i.e. exiting the reserve/commit window), the last
thing it does is add the ready descriptor to the list.

>>> Finally, here are some comments about the original patch:
>>>
>>> On Fri 2019-06-07 18:29:48, John Ogness wrote:
>>>> See documentation for details.
>>>
>>> Please, mention here some basics. It might be enough to copy the
>>> following sections from the documentation:
>>>
>>> Overview
>>> Features
>>> Behavior
>>
>> Ugh. Do we really want all that in a commit message?
>
> 2-3 pages of text for such a complicated commit is perfectly fine.
> You could not build html/pdf variant easily when reading "git log -p".

OK.

>>> Note that the documentation is written via .rst file. You need to
>>> build html or pdf to get all the pieces together.
>> 
>> Yes, but isn't that how all the kernel docs are supposed to be for the
>> future?
>
> I could not talk for others. I have personally built the html version
> for the first time just few weeks ago. And it was only because
> I reviewed conversion of livepatch related documentation into rst.

I also built it for the first time so that I could document this series.

> I normally search for information using "cscope in emacs", "git
> blame", "git log -p", "git grep", and "google in web browser".
> I much prefer to find the information in the code sources or
> in the related commit message.

There is an obvious push to get the kernel docs unified under RST, even
if it is not how I usually do things either. However, now that I've done
the work, looking back it seems to be a good idea in order to automate
documentation.

>> If using the strings "oldest" and "newest" are too ugly for people, I
>> have no problems using first/last or head/tail, even if IMHO they add
>> unnecessary confusion.
>
> I do not have strong opinion. I am slightly biased because I am used
> to "first"/"next" from the current code.

But are you used to starting with last and traversing next to first? The
descriptors and data blocks are linked from oldest to newest. IMHO that
is why it tends to be confusing.

In circular buffer speak, writers write to the head and readers read
from the tail. As a writer this feels natural, but for a reader that
reads the tail and follows next pointers to the head, it feels
backwards.

I explicitly wanted to get away from any preconceptions. By specifying
we have data linked from oldest to newest, I find it feels more natural,
regardless if I am a writer writing new records to the newest or a
reader reading all records from oldest to newest.

John Ogness
