Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B84C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC1E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfFXIdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:33:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35244 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfFXIdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:33:35 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hfKPd-0002FC-Ug; Mon, 24 Jun 2019 10:33:18 +0200
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
Date:   Mon, 24 Jun 2019 10:33:15 +0200
Message-ID: <87d0j31iyc.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 2019-06-21, Petr Mladek <pmladek@suse.com> wrote:
> I am still scratching head around this. Anyway, I wanted to
> write something. I am sorry that the answer is really long.
> I do not know how to write it more effectively.

No need to apologize (to me) for long answers.

> 1. Linked list of descriptors
> -----------------------------
>
> The list of descriptors makes the code more complicated
> and I do not see much gain. It is possible that I just missed
> something.
>
> If I get it correctly then the list could only grow by adding
> never used members. The already added members are newer removed
> neither shuffled.
>
> If the above is true then we could achieve similar result
> when using the array as a circular buffer. It would be
> the same like when all members are linked from the beginning.

So you are suggesting using a multi-reader multi-writer lockless
ringbuffer to implement a multi-reader multi-writer lockless
ringbuffer. ;-)

The descriptor ringbuffer has fixed-size items, which simplifies the
task. But I expect you will run into a chicken-egg scenario.

> It would allow to remove:
>
>     + desc->id because it will be the same as desc->seq
>     + desc->next because the address of the next member
> 		can be easily counted

Yes, you will remove these and then replace them with new variables to
track array-element state.

> 2. Consistency, barriers, and code structure
> --------------------------------------------
>
> I haven't got the whole picture about the code logic so far.
> Maybe I haven't tried hard enough. I actually spent quite
> some time with playing with some alternatives.
>
> In each case, the code is very complicated (of course, the problem
> is complicated):
>
>     + 6 steps (barriers) are needed to synchronize writers.
>       This means a lot of variants of possible races.

Agreed. The writer documentation explains those 6 steps, which are 6
atomic operations. I am not sure if you would be able to reduce the 6
steps by using a descriptor ringbuffer. Instead of cmpxchg'ing list
pointers you will be cmpxchg'ing state variables.

Using litmus tests and lots of testing on SMP arm64, I have been able
hit and address these races (i.e. removing one of the barriers causes
the test module to fail on SMP arm64). But if we can simplify the
design, that would certainly help to deal with races.

>     + The six barriers are somehow related to 6 variables.
>       But there are several other variables that are being
>       modified. It is needed to check that they can be
>       safely modified/read on the given locations.

Here are the writer-relevant memory barriers and their associated
variables:

MB1: data_list.oldest
MB2: data_list.newest
MB3: data_block.id
MB4: descr.data_next
MB5: descr_list.newest
MB6: descr.next

The only other variables that I see as relevant are:

descr.id: This variable is used often and is quite important (the basis
for linked lists and descriptor validation). I will go through all its
uses again. My memory barrier comments should definitely include this
variable in their explanations.

descr.data: This is set when the descriptor is not part of the list and
is indirectly synchronized by MB3 (written before store_release of
data_block.id and loaded as data dependent on the load_acquire of
data_block.id).

descr.seq: This is set when the descriptor is not part of the list and
is indirectly synchronized by MB5 (written before store_release of
descr_list.newest and loaded as data dependent on the load_acquire of
descr_list.newest).

descr_list.oldest: As I explained[0] to Peter, this variable is
indirectly synchronized by MB6 when there is only 1 descriptor on the
list (which is not the normal case). Otherwise it has no
synchronization. This could lead to a writer unnecessarily trying
multiple times to remove the oldest descriptor because of failed
cmpxchg() calls. But that isn't really an issue. (And now revisiting
remove_oldest_descr() I see I can pull the READ_ONCE(l->oldest) out of
the loop and use the cmpxchg() return value for the next iteration.)

Are there any other variables that you are referring to?

> OK, the structures have a livecycle:
>
>     + descriptor:
> 	+ free
> 	+ taken
>
>     + data block:
> 	+ reserved
> 	+ committed
> 	+ correctly read
> 	+ freed

IMO, it is:

  + descriptor:
    + free
    + taken
    + valid (i.e. data/data_next have been set by the writer)

  + data block:
    + reserved
    + committed
    + invalid/garbage

> And there are few basic questions about each state:
>
>     + where and how the state is set
>     + where and how it is invalidated
>     + where and how the state is checked in other code
>     + how is it achieved that the state is the same
>       as long as needed
>
> Some of the answers are easier to find than the others.
> So far I found one suspicious thing in expire_oldest_data().
>
> To be honest, I am not sure how to describe this effectively.
> It might help to better describe the barriers (what they
> synchronize (a after b) and where is the counterpart,
> and why it is needed from some top level point of view).
>
> Of course, the best solution is an easy to follow code.
> This brings me to the next section.
>
> 3. Ideas
> --------
>
> I started reading your code and I though that it must have
> been possible to write it a more straightforward way. I tried
> it and reached many dead ends so far ;-) But it helped me to
> better understand your code.
>
> I have not given up yet and would like to give it some
> more time. Unfortunately, I will not have much time
> the next week.
>
> Anyway, I am trying to:
>
> 	+ use the array of descriptors as a ring buffer
> 	  (no list, no id, only the sequence number)
>
> 	+ distinguish the state of the data by some
> 	  flags in struct prb_desc to avoid complicated
> 	  and tricky checks
>
> It seems that the ring buffer of descriptors really makes
> things easier.
>
> Regarding the flags. I have something like:
>
> struct prb_desc
> {
> 	unsigned long seq;
> 	bool committed;
> 	bool freed;
> }
>
> The basic idea with the flags is that they are valid only
> when the seq number in the structure is valid. The newly
> reserved struct prb_desc is written the following way:
>
> static void prb_init_desc(struct prb_desc *desc)
> {
> 	desc->committed = false;
> 	desc->freed = false;
>
> 	/*
> 	 * Flags must be cleared before we tell others that they
> 	 * are for this sequence number.
> 	 */
> 	smp_wmb();
>
> 	desc->seq = seq;
> }
>
> Then we could have checks like:
>
> /*
>  * Used by readers to check if the data are valid.
>  * It has to be called twice (before and after)
>  * to make sure that the read data are valid.
>  */
> static bool prb_data_valid(struct printk_ringbuffer *rb,
> 			   unsigned long seq)
> {
> 	static prb_desc *desc = TO_DESC(rb, seq);
>
> 	if (READ_ONCE(desc->seq) != seq)
> 		false;
>
> 	/* Do not read outdated flags, see prb_init_desc()
> 	smp_rmb();
>
> 	return READ_ONCE(desc->committed) && !READ_ONCE(desc->freed);
> }
>
> I am not sure if these extra flags are really needed and useful.
> This is why I play with it myself. I do not want to ask you to
> spend a lot of time with my crazy ideas.

But thank you for sharing them. I always welcome new ideas.

> Anyway, the above approach looked promising until I tried to
> to free data from the data array. The problem is how to prove
> that the sequence number read from the data array is not
> a garbage. BTW: I think that your expire_oldest_data() is
> buggy from this point of view, see below.

You do point out an issue for 32-bit systems. Below I include an
explanation and patch.

> I think that it might be much more safe when we mask the two
> highest bits of seq number and use them for the flags.
> Then we could track the state of the given sequence number
> a very safe and straightforward way.

When I first started to design/code this, I implemented something quite
similar: using a single variable to represent state and id. This works
nicely for cmpxchg operations (lockless synchronization) and reader
validation. The problem I ran into was a chicken-egg problem (which I
suspect you will also run into).

I solved this problem by changing the design to use a linked list for
the descriptors. At first I had kept state information for each
descriptor. But later I realized that state information was not
necessary because the linked list itself was providing implicit state
information.

I do not claim that using linked lists for the descriptors is absolutely
necessary. But it was the only way that I could figure out how to make
everything work. Now that I have something that works (and the
experience of getting it there), maybe I could make it work without a
linked list. I will let the idea simmer on my brain in the background
and I am following your experimentation/ideas with great curiosity.

> Finally, here are some comments about the original patch:
>
> On Fri 2019-06-07 18:29:48, John Ogness wrote:
>> See documentation for details.
>
> Please, mention here some basics. It might be enough to copy the
> following sections from the documentation:
>
> Overview
> Features
> Behavior

Ugh. Do we really want all that in a commit message?

> Note that the documentation is written via .rst file. You need to
> build html or pdf to get all the pieces together.

Yes, but isn't that how all the kernel docs are supposed to be for the
future?

>> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
>> new file mode 100644
>> index 000000000000..569980a61c0a
>> --- /dev/null
>> +++ b/include/linux/printk_ringbuffer.h
>> @@ -0,0 +1,238 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_PRINTK_RINGBUFFER_H
>> +#define _LINUX_PRINTK_RINGBUFFER_H
>> +
>> +#include <linux/atomic.h>
>> +
>> +/**
>> + * struct prb_list - An abstract linked list of items.
>> + * @oldest: The oldest item on the list.
>> + * @newest: The newest item on the list.
>
> I admit that I got confused by this. I wonder if there is another
> location in kernel where lists are handled this way.
>
> I have always seen in kernel only lists handled via the struct
> list_head trick. Where the same structure is bundled in all
> linked members.
>
> I can't find a good name. I would personally remove the structure
> and add the members into the relates structures directly.

The only reason I made it a struct is so that I could just write
l->oldest instead of rb->descr_list_oldest. But it is an otherwise
useless struct that I can remove.

> Also I would personally use "first" and "last" because they are
> shorter and easier to visually distinguish. I know that "oldest"
> and "newest" are more clear but...

I don't like "oldest" and "newest" either, but it is immediately
clear. How about:

rb->data_lpos_oldest (formerly rb->data_list.oldest)
rb->data_lpos_newest (formerly rb->data_list.newest)
rb->desc_id_oldest (formerly rb->descr_list.oldest)
rb->desc_id_newest (formerly rb->descr_list.newest)

If using the strings "oldest" and "newest" are too ugly for people, I
have no problems using first/last or head/tail, even if IMHO they add
unnecessary confusion.

>> +/**
>> + * struct prb_descr - A descriptor representing an entry in the ringbuffer.
>
> I agree with Peter that "desc" is a better shortcut.

OK.

>> + * @seq: The sequence number of the entry.
>> + * @id: The descriptor id.
>> + *      The location of the descriptor within the descriptor array can be 
>> + *      determined from this value.
>> + * @data: The logical position of the data for this entry.
>> + *        The location of the beginning of the data within the data array
>> + *        can be determined from this value.
>
> I was quite confused by this name. Please, use "lpos". It will make
> clear that it is the logical position. Also it will be clear
> that desc->data is the same as lpos used on other location
> in the code.

Agreed.

>> + * @data_next: The logical position of the data next to this entry.
>> + *             This is used to determine the length of the data as well as
>> + *             identify where the next data begins.
>
> next_lpos

How about lpos_next?

>> + * @next: The id of the next (newer) descriptor in the linked list.
>> + *        A value of EOL means it is the last descriptor in the list.
>> + *
>> + * Descriptors are used to identify where the data for each entry is and
>> + * also provide an ordering for readers. Entry ordering is based on the
>> + * descriptor linked list (not the ordering of data in the data array).
>> + */
>> +struct prb_descr {
>> +	/* private */
>> +	u64 seq;
>> +	unsigned long id;
>> +	unsigned long data;
>> +	unsigned long data_next;
>> +	unsigned long next;
>> +};
>> +
>> +/**
>> + * struct printk_ringbuffer - The ringbuffer structure.
>> + * @data_array_size_bits: The size of the data array as a power-of-2.
>
> I would use "data_size_bits"

OK.

>> + * @data_array: A pointer to the data array.
>
> and "data"

OK.

>> + * @data_list: A list of entry data.
>> + *             Since the data list is not traversed, this list is only used to
>> + *             mark the contiguous section of the data array that is in use.
>> + * @descr_max_count: The maximum amount of descriptors allowed.
>> + * @descr_array: A pointer to the descriptor array.
>
> descs?

OK.

>> +/**
>> + * prb_for_each_entry() - Iterate through all the entries of a ringbuffer.
>> + * @i: A pointer to an iterator.
>> + * @l: An integer used to identify when the last entry is traversed.
>> + *
>> + * This macro expects the iterator to be initialized. It also does not reset
>> + * the iterator. So if the iterator has already been used for some traversal,
>> + * this macro will continue where the iterator left off.
>> + */
>> +#define prb_for_each_entry(i, l) \
>> +	for (; (l = prb_iter_next_valid_entry(i)) != 0;)
>
> This is very unusual semantic. Please, define two iterators:
>
>      prb_for_each_entry() - iterate over all entries
>      prb_for_each_entry_continue() - iterate from the gived entry

OK.

>> +/**
>> + * expire_oldest_data() - Invalidate the oldest data block.
>> + * @rb: The ringbuffer containing the data block.
>> + * @oldest_lpos: The logical position of the oldest data block.
>> + *
>> + * This function expects to "push" the pointer to the oldest data block
>> + * forward, thus invalidating the oldest data block. However, before pushing,
>> + * it is verified if the data block is valid. (For example, if the data block
>> + * was reserved but not yet committed, it is not permitted to invalidate the
>> + * "in use by a writer" data.)
>> + *
>> + * If the data is valid, it will be associated with a descriptor, which will
>> + * then provide the necessary information to validate the data.
>> + *
>> + * Return: true if the oldest data was invalidated (regardless if this
>> + *         task was the one that did it or not), otherwise false.
>> + */
>> +static bool expire_oldest_data(struct printk_ringbuffer *rb,
>> +			       unsigned long oldest_lpos)
>> +{
>> +	unsigned long newest_lpos;
>> +	struct prb_datablock *b;
>> +	unsigned long data_next;
>> +	struct prb_descr *d;
>> +	unsigned long data;
>> +
>> +	/* MB2: synchronize data reservation */
>> +	newest_lpos = smp_load_acquire(&rb->data_list.newest);
>> +
>> +	b = TO_DATABLOCK(rb, oldest_lpos);
>> +
>> +	/* MB3: synchronize descr setup */
>> +	d = TO_DESCR(rb, smp_load_acquire(&b->id));
>> +
>> +	data = READ_ONCE(d->data);
>> +
>> +	/* sanity check to check to see if b->id was correct */
>> +	if (oldest_lpos != data)
>> +		goto out;
>
> Is this cross check really enough?

This is only a cheap sanity check to filter out most garbage. However,
it still is not a guarantee that b is valid. At this point d could be
some random descriptor that by chance is pointing to the loaded oldest
value.

> How is it ensured that the data are committed?

The following data_valid() call checks this. If it is valid, it is
committed.

> How is it ensured that the descriptor is not an outdated one?
>
> IMHO, there might be a garbage in the data array. It might be chance
> point to an outdated descriptor that by chance pointed to this
> data range in the past. I agree that it is very unlikely. But
> we could not afford such a risk.

An outdated descriptor that has a data value (lpos) matching the oldest
(lpos) would mean that the lpos has completely wrapped (4GB of data on a
32-bit system) without the descriptor having been recycled. It should be
possible to force such a situation on a 32-bit system, so this issue
does need to be addressed. Thanks.

>> +	/* MB4: synchronize commit */
>> +	data_next = smp_load_acquire(&d->data_next);
>> +
>> +	if (!data_valid(rb, oldest_lpos, newest_lpos, data, data_next))
>> +		goto out;
>> +
>> +	/* MB1: synchronize data invalidation */
>> +	cmpxchg_release(&rb->data_list.oldest, data, data_next);
>> +
>> +	/* Some task (maybe this one) successfully expired the oldest data. */
>> +	return true;
>> +out:
>> +	return (oldest_lpos != READ_ONCE(rb->data_list.oldest));
>> +}

Currently the descriptor's data/data_next values are left "as is" until
they are used again. This creates the risk (really only on 32-bit
systems) that in the case of a complete unsigned long wrap around while
never reusing that descriptor, random (or specially crafted) data during
a writer race to expire the oldest data could be read that point to that
unused descriptor where its data (lpos) is the same as oldest (lpos) but
data_next is not valid. This would corrupt the data array.

To avoid this, explicitly make the descriptor invalid (independent of
any future oldest/newest values) after expiring the data.

diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
index d0b2b6a549b0..43735d9429b2 100644
--- a/lib/printk_ringbuffer.c
+++ b/lib/printk_ringbuffer.c
@@ -451,7 +451,16 @@ static bool expire_oldest_data(struct printk_ringbuffer *rb,
 		goto out;
 
 	/* MB1: synchronize data invalidation */
-	cmpxchg_release(&rb->data_list.oldest, data, data_next);
+	if (cmpxchg_release(&rb->data_list.oldest, data, data_next) == data) {
+		/*
+		 * Set data_next to match data so the descriptor is invalid.
+		 * This avoids the possibility of mistaking it as valid in
+		 * case of a full lpos value wrap around.
+		 *
+		 * If this fails, the descriptor has already been recycled.
+		 */
+		cmpxchg(&d->data_next, data_next, data);
+	}
 
 	/* Some task (maybe this one) successfully expired the oldest data. */
 	return true;

John Ogness

[0] https://lkml.kernel.org/r/87k1df28x4.fsf@linutronix.de
