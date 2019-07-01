Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45882208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfGAKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:39:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40131 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfGAKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:39:46 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hhtij-0002uW-7P; Mon, 01 Jul 2019 12:39:37 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
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
        <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
        <87k1df28x4.fsf@linutronix.de>
        <20190626224034.GK2490@worktop.programming.kicks-ass.net>
        <87mui2ujh2.fsf@linutronix.de>
        <20190628154435.GZ7905@worktop.programming.kicks-ass.net>
Date:   Mon, 01 Jul 2019 12:39:35 +0200
In-Reply-To: <20190628154435.GZ7905@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 28 Jun 2019 17:44:35 +0200")
Message-ID: <877e92f388.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-28, Peter Zijlstra <peterz@infradead.org> wrote:
>> I have implemented and tested these changes. I also added setting the
>> list terminator to this function, since all callers would have to do
>> it anyway. Also, I spent a lot of time trying to put in comments that
>> I think are _understandable_ and _acceptable_.
>> 
>> @Peter: I expect they are way too long for you.
>> 
>> @Andrea: Is this starting to become something that you would like to
>> see?
>> 
>> /**
>>  * add_descr_list() - Add a descriptor to the descriptor list.
>>  *
>>  * @e: An entry that has already reserved data.
>>  *
>>  * The provided entry contains a pointer to a descriptor that has already
>>  * been reserved for this entry. However, the reserved descriptor is not
>>  * yet on the list. Add this descriptor as the newest item.
>>  *
>>  * A descriptor is added in two steps. The first step is to make this
>>  * descriptor the newest. The second step is to update @next of the former
>>  * newest descriptor to point to this one (or set @oldest to this one if
>>  * this will be the first descriptor on the list).
>>  */
>
> I still think it might be useful to explicitly call out the data
> structure more. Even if you cannot use a fully abtracted queue.

Agreed. It needs to be clear that the queue management is separate from
the data management.

> Also, newest/oldest just looks weird to me; I'm expecting head/tail.

I will rename it to head/tail.

>>> You have a single linked list going from the tail to the head, while
>>> adding to the head and removing from the tail. And that sounds like
>>> a FIFO queue:
>> 
>> Yes, but with one important feature: the nodes in the FIFO queue are
>> labeled with ordered sequence numbers. This is important for
>> printk. I talk more about this below.
>
> But nowhere did/do you say what the actual data structure is, with what
> modification for which reason.

When you dive into the reader code you will see that the sequence
numbers are necessary for readers to recognize that they have missed
records. This means that the sequence numbers must be ordered, and
AFAICT that is only possible if the queue management code is assigning
it.

>>> 		/*
>>> 		 * xchg() implies ACQUIRE; and thereby ensures @tail is
>>> 		 * written after @head, see lqueue_pop()'s smp_rmb().
>>> 		 */
>>> 		if (prev)
>>> 			WRITE_ONCE(prev->next, n);
>> 
>> This needs to be a store_release() so that a reader cannot read @n
>> but the store to @next is not yet visible. The memory barriers of the
>> above xchg() do not apply here because readers never read @head.
>
> Confused, all stores to @n are before the xchg() so the barrier from
> xchg() also order those stores and this store.

Sorry. Yes, you are correct. I was confusing your suggested
implementation with mine. I'm starting to overthink things and confuse
myself about memory barriers. I need to be more careful.

> (Note that the qspinlock has a queue not unlike this, but that again
> doesn't have to bother with NMIs)

Thank you for pointing this out! I will look to qspinlock for some
naming guidelines.

>>> Now, you appear to be using desc_ids instead of pointers, but since
>>> you're not using the actual wrap value; I don't see the benefit of
>>> using those IDs over straight pointers. That is, unless I've
>>> overlooked some subtle ABA issue, but then, your code doesn't seem
>>> to mention that, and I think we're good because if we re-use an
>>> entry, it can never get back in the same location, since we never
>>> allow an empty list
>> 
>> I do not understand what you mean here. If a reader has a pointer to
>> an entry, the entry behind that pointer can certainly change. But
>> that isn't a problem. The reader will recognize that.
>
> ABA is where a cmpxchg has a false positive due to values matching but
> not the structure.

Thanks for the clarification. And it reminds me why I chose to use
desc_ids. If we are using pointers instead of desc_ids, assuming we have
a queue with currently only 1 node, the following should cause the ABA
problem. CPU0 is perfoming an lqueue_push() to add a 2nd node to the
queue.

  CPU0                                  CPU1
  ----                                  ----
  head = READ_ONCE(h->head);
  seq = READ_ONCE(head->seq);
  WRITE_ONCE(n->seq, seq + 1);
  WRITE_ONCE(n->next, NULL);
                                        lqueue_push();
                                        lqueue_pop();
                                        lqueue_push();
  cmpxchg_release(&h->head, head, n);
  WRITE_ONCE(head->next, n);

The queue itself will still be intact, but the sequence numbers are now
wrong. For this to happen using desc_ids, the above set of calls from
CPU1 would need to occur "LONG_MAX/desc_max_count" times in that
window. Basically I am using tagged state references with probably >40
bits for the tag (on 64-bit systems).

The effect for readers is that they will see a sequence number that is
less or equal to the previous seen sequence number. Worthy of a warn
message.

My code needs to mention all this.

>>> That said, the above has cmpxchg() vs WRITE_ONCE() and is therefore
>>> not safe on a number of our architectures. We can either not care
>>> about performance and use xchg() for the ->tail store, or use
>>> atomic_long_t and suffer ugly casting.
>> 
>> cmpxchg_release() vs WRITE_ONCE() is not safe?! Can you point me to
>> documentation about this?
>
> Documentation/atomic_t.txt has this, see the SEMANTICS section on
> atomic-set.

Thanks. I overlooked that subtle detail. Can I assume NMIs do not exist
on architectures that need to implement locking for cmpxchg()? Or did I
just hit a major obstacle?

I would prefer to replace the affected WRITE_ONCE() with xchg_relaxed()
(like qspinlock is doing). Or are there some other subtle advantages of
atomic_long_t?

John Ogness
