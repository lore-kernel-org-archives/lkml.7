Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66505C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B93F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 22:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFTWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:23:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53612 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 18:23:59 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1he5Sl-0004so-Oz; Fri, 21 Jun 2019 00:23:23 +0200
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
Date:   Fri, 21 Jun 2019 00:23:19 +0200
Message-ID: <87k1df28x4.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This is a long response, but we are getting into some fine details about
the memory barriers (as well as battling my communication skill level).

On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
>> +#define DATAARRAY_SIZE(rb) (1 << rb->data_array_size_bits)
>> +#define DATAARRAY_SIZE_BITMASK(rb) (DATAARRAY_SIZE(rb) - 1)
>
> *phew* no comments on those..
>
> I think the kernel typically uses _MASK instead of _BITMASK for this
> though.

Yes, you are right.

>> +/**
>> + * DATA_INDEX() - Determine the data array index from logical position.
>> + * @rb: The associated ringbuffer.
>> + * @lpos: The logical position (data/data_next).
>> + */
>> +#define DATA_INDEX(rb, lpos) (lpos & DATAARRAY_SIZE_BITMASK(rb))
>> +
>> +/**
>> + * DATA_WRAPS() - Determine how many times the data array has wrapped.
>> + * @rb: The associated ringbuffer.
>> + * @lpos: The logical position (data/data_next).
>> + *
>> + * The number of wraps is useful when determining if one logical position
>> + * is overtaking the data array index another logical position.
>> + */
>> +#define DATA_WRAPS(rb, lpos) (lpos >> rb->data_array_size_bits)
>> +
>> +/**
>> + * DATA_THIS_WRAP_START_LPOS() - Get the position at the start of the wrap.
>> + * @rb: The associated ringbuffer.
>> + * @lpos: The logical position (data/data_next).
>> + *
>> + * Given a logical position, return the logical position if backed up to the
>> + * beginning (data array index 0) of the current wrap. This is used when a
>> + * data block wraps and therefore needs to begin at the beginning of the data
>> + * array (for the next wrap).
>> + */
>> +#define DATA_THIS_WRAP_START_LPOS(rb, lpos) \
>> +	(DATA_WRAPS(rb, lpos) << rb->data_array_size_bits)
>
> That's more easily written as: ((lpos) & ~MASK(rb))

Agreed.

>> +
>> +#define DATA_ALIGN sizeof(long)
>> +#define DATA_ALIGN_SIZE(sz) \
>> +	((sz + (DATA_ALIGN - 1)) & ~(DATA_ALIGN - 1))
>
> We have ALIGN() for that

OK.

>> +
>> +#define DESCR_COUNT_BITMASK(rb) (rb->descr_max_count - 1)
>
> I think the kernel typically uses 'DESC' as shorthand for Descriptor.
> Idem on the MASK vs BITMASK thing.

Yes, you are correct.

>> +
>> +/**
>> + * DESCR_INDEX() - Determine the descriptor array index from the id.
>> + * @rb: The associated ringbuffer.
>> + * @id: The descriptor id.
>> + */
>> +#define DESCR_INDEX(rb, id) (id & DESCR_COUNT_BITMASK(rb))
>> +
>> +#define TO_DATABLOCK(rb, lpos) \
>> +	((struct prb_datablock *)&rb->data_array[DATA_INDEX(rb, lpos)])
>
> If I were paranoid, I'd point out that this evaluates @rb twice, and
> doesn't have the macro arguments in parens.

There are several other macros that also should have some parens for the
arguments. Thanks for pointing that out.

As for the double evaluation, I'm not sure what should be done
instead. It is a convenience macro. I could split it into 2 macros and
have the caller always call the 2 macros. Is that desirable?

>> +#define TO_DESCR(rb, id) \
>> +	(&rb->descr_array[DESCR_INDEX(rb, id)])
>> +
>> +/**
>> + * data_valid() - Check if a data block is valid.
>> + * @rb: The ringbuffer containing the data.
>> + * @oldest_data: The oldest data logical position.
>> + * @newest_data: The newest data logical position.
>> + * @data: The logical position for the data block to check.
>> + * @data_next: The logical position for the data block next to this one.
>> + *             This value is used to identify the end of the data block.
>> + *
>> + * A data block is considered valid if it satisfies the two conditions:
>> + *
>> + * * oldest_data <= data < data_next <= newest_data
>> + * * oldest_data is at most exactly 1 wrap behind newest_data
>> + *
>> + * Return: true if the specified data block is valid.
>> + */
>> +static inline bool data_valid(struct printk_ringbuffer *rb,
>> +			      unsigned long oldest_data,
>> +			      unsigned long newest_data,
>> +			      unsigned long data, unsigned long data_next)
>> +
>> +{
>> +	return ((data - oldest_data) < DATAARRAY_SIZE(rb) &&
>> +		data_next != data &&
>> +		(data_next - data) < DATAARRAY_SIZE(rb) &&
>> +		(newest_data - data_next) < DATAARRAY_SIZE(rb) &&
>> +		(newest_data - oldest_data) <= DATAARRAY_SIZE(rb));
>
> 	unsigned long size = DATA_SIZE(rb);
>
> 	/* oldest_data <= data */
> 	if (data - oldest_data >= size);
> 		return false;
>
> 	/* data_next < data */
> 	if (data_next == data)
> 		return false
>
> 	/* data_next <= newest_data */
> 	if (newest_data - data_next >= size)
> 		return false;
>
> 	/* 1 wrap */
> 	if (newest_data - oldest_data >= size)
> 		return false;
>
> 	return true;

Ha! That was my original implementation, but I changed it because I
figured there would be feedback telling me to put everything into a
single expression for compiler optimization. I am happy to use your
suggestion instead.

>> +}
>> +
>> +/**
>> + * add_descr_list() - Add a descriptor to the descriptor list.
>> + * @e: An entry that has already reserved data.
>> + *
>> + * The provided entry contains a pointer to a descriptor that has already
>> + * been reserved for this entry. However, the reserved descriptor is not
>> + * yet on the list. Add this descriptor as the newest item.
>> + *
>> + * A descriptor is added in two steps. The first step is to make this
>> + * descriptor the newest. The second step is to update the "next" field of
>> + * the former newest item to point to this item.
>> + */
>> +static void add_descr_list(struct prb_reserved_entry *e)
>> +{
>> +	struct printk_ringbuffer *rb = e->rb;
>> +	struct prb_list *l = &rb->descr_list;
>> +	struct prb_descr *d = e->descr;
>> +	struct prb_descr *newest_d;
>> +	unsigned long newest_id;
>> +
>> +	/* set as newest */
>> +	do {
>> +		/* MB5: synchronize add descr */
>> +		newest_id = smp_load_acquire(&l->newest);
>> +		newest_d = TO_DESCR(rb, newest_id);
>> +
>> +		if (newest_id == EOL)
>> +			WRITE_ONCE(d->seq, 1);
>> +		else
>> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
>> +		/*
>> +		 * MB5: synchronize add descr
>> +		 *
>> +		 * In particular: next written before cmpxchg
>> +		 */
>> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
>
> What does this pair with? I find ->newest usage in:

It is pairing with the smp_load_acquire() at the beginning of this loop
(also labeled MB5) that is running simultaneously on another CPU. I am
avoiding a possible situation that a new descriptor is added but the
store of "next" from the previous descriptor is not yet visible and thus
the cmpxchg following will fail, which is not allowed. (Note that "next"
is set to EOL shortly before this function is called.)

The litmus test for this is:

P0(int *newest, int *d_next)
{
        // set descr->next to EOL (terminates list)
        WRITE_ONCE(*d_next, 1);

        // set descr as newest
        smp_store_release(*newest, 1);
}

P1(int *newest, int *d_next)
{
        int local_newest;
        int local_next;

        // get newest descriptor
        local_newest = smp_load_acquire(*newest);

        // a new descriptor is set as the newest
        // (not relevant here)

        // read descr->next of previous newest
        // (must be EOL!)
        local_next = READ_ONCE(*d_next);
}

exists (1:local_newest=1 /\ 1:local_next=0)

>   - later this function with an MB6 comment
>   - remove_oldest_descr() with no comment
>   - expire_oldest_data() with an MB2 comment
>   - get_new_lpos() with no comment
>   - data_reserve() with an MB2 comment
>   - prb_iter_next_valid_entry() with no comment
>     (and the smp_rmb()s have no clear comments either).
>
> In short; I've no frigging clue and I might as well just delete all
> these comments and reverse engineer :-(

OK. I understand that I haved failed horribly at commenting the
barriers. Perhaps I should submit a v3 with only new memory barrier
comments so that you can better understand and (hopefully) Andrea would
also be able to take a look?

>> +
>> +	if (unlikely(newest_id == EOL)) {
>> +		/* no previous newest means we *are* the list, set oldest */
>> +
>> +		/*
>> +		 * MB UNPAIRED
>
> That's a bug, MB must always be paired.

Well, it "pairs" with the smp_rmb() of the readers, but I didn't think
that counts as a pair. That's why I wrote unpaired. The litmus test is:

P0(int *x, int *y)
{
        WRITE_ONCE(*x, 1);
        smp_store_release(y, 1);
}

P1(int *x, int *y)
{
        int rx;
        int ry;

        ry = READ_ONCE(*y);
        smp_rmb();
        rx = READ_ONCE(*x);
}

exists (1:rx=0 /\ 1:ry=1)

The readers rely on the store_releases "pairing" with the smp_rmb() so
that the readers see things in a sane order.

For this particular case, I could change the
READ_ONCE(rb->descr_list.oldest) in iter_peek_next_id() and
prb_iter_next_valid_entry() to smp_load_acquires and then there would be
an official (and correct) pairing. But since the smp_rmb's are needed
anyway (for other fields), it really isn't necessary.

>> +		 *
>> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
>> +		 */
>> +		WARN_ON_ONCE(cmpxchg_release(&l->oldest, EOL, e->id) != EOL);
>> +	} else {
>> +		/* link to previous chain */
>> +
>> +		/*
>> +		 * MB6: synchronize link descr
>> +		 *
>> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
>
> But why... and who cares.

The comments on the matching MB6 and in the MB6 documentation are more
precise about this. But I guess they aren't clear enough either. :-/

It is important to understand that once the ringbuffer is full (which is
quite common for the printk buffer) then old data starts to be expired
and descriptors recycled. This is really where memory barriers become
critical.

In this situation, it becomes normal that a writer adding a new record
must first expire/recycle and old record. The writer moving the oldest
descriptor pointer forward is also the one that is re-initializing the
oldest descriptor and re-adding it to end of the reader-visible list.

As described in the documentation, a descriptor can not be removed from
the list if it is the only one on the list. This is verified by checking
if it's "next" is EOL and it is the "oldest". However, because
descriptors are recycled (and thus the next set to EOL) and oldest can
be moving (by writers on other CPUs), the check for this case must be
taken into careful consideration, which is where MB6 comes in.

If a writer changes "next" then that writer previously changed
"oldest". And when another writer checks "next" it needs to be
guaranteed that it also sees the updated "oldest".

The litmus test for this is:

P0(int *oldest, int *prev_newest_next)
{
        // remove the oldest descriptor
        WRITE_ONCE(*oldest, 1);

        // set the previous newest next to this descriptor
        smp_store_release(*prev_newest_next, 1);
}

P1(int *oldest, int *prev_newest_next)
{
        int local_oldest;
        int local_next;

        // get next of oldest descriptor
        // (assuming prev_newest_next is now the oldest)
        local_next = smp_load_acquire(*prev_newest_next);

        // read the oldest
        local_oldest = READ_ONCE(*oldest);
}

exists (1:local_next=1 /\ 1:local_oldest=0)

>> +		 */
>> +		WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
>> +					     EOL, e->id) != EOL);
>> +	}
>> +}

So this email has a lot of explanations. My first question is: do my
explanations make any sense to you? If yes, then I need to figure out
how to massively condense them to something that is appropriate for a
memory barrier comment. If no... I guess I need to find someone to
translate my madness into something that is understandable to the rest
of the world.

John Ogness

P.S. Is it correct that git HEAD herd7 does not support cmpxchg? For my
litmus tests I use stores and loads instead, which works and is correct,
but makes it more difficult for someone to match the test to the actual
code.
