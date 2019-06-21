Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CBC21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFUOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:05:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfFUOFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:05:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83E2FAE12;
        Fri, 21 Jun 2019 14:05:18 +0000 (UTC)
Date:   Fri, 21 Jun 2019 16:05:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I am still scratching head around this. Anyway, I wanted to
write something. I am sorry that the answer is really long.
I do not know how to write it more effectively.

First, the documentation helped a lot. Also I found several
ideas that were important to make it working a lockless way.
Especially:

  + separate buffer with descriptors of data entries
  + descriptor can be reused only when the related data
    have already been discarded

There are few comments about the naming and code at the end of
the mail. But I primary want to write about the design, namely:

    + Linked list of descriptors
    + Code structure, consistency, barriers
    + Ideas


1. Linked list of descriptors
-----------------------------

The list of descriptors makes the code more complicated
and I do not see much gain. It is possible that I just missed
something.

If I get it correctly then the list could only grow by adding
never used members. The already added members are newer removed
neither shuffled.

If the above is true then we could achieve similar result
when using the array as a circular buffer. It would be
the same like when all members are linked from the beginning.

It would allow to remove:

    + desc->id because it will be the same as desc->seq
    + desc->next because the address of the next member
		can be easily counted


2. Consistency, barriers, and code structure
--------------------------------------------

I haven't got the whole picture about the code logic so far.
Maybe I haven't tried hard enough. I actually spent quite
some time with playing with some alternatives.

In each case, the code is very complicated (of course, the problem
is complicated):

    + 6 steps (barriers) are needed to synchronize writers.
      This means a lot of variants of possible races.

    + The six barriers are somehow related to 6 variables.
      But there are several other variables that are being
      modified. It is needed to check that they can be
      safely modified/read on the given locations.


OK, the structures have a livecycle:

    + descriptor:
	+ free
	+ taken

    + data block:
	+ reserved
	+ committed
	+ correctly read
	+ freed

And there are few basic questions about each state:

    + where and how the state is set
    + where and how it is invalidated
    + where and how the state is checked in other code
    + how is it achieved that the state is the same
      as long as needed

Some of the answers are easier to find than the others.
So far I found one suspicious thing in expire_oldest_data().

To be honest, I am not sure how to describe this effectively.
It might help to better describe the barriers (what they
synchronize (a after b) and where is the counterpart,
and why it is needed from some top level point of view).

Of course, the best solution is an easy to follow code.
This brings me to the next section.

3. Ideas
--------

I started reading your code and I though that it must have
been possible to write it a more straightforward way. I tried
it and reached many dead ends so far ;-) But it helped me to
better understand your code.

I have not given up yet and would like to give it some
more time. Unfortunately, I will not have much time
the next week.

Anyway, I am trying to:

	+ use the array of descriptors as a ring buffer
	  (no list, no id, only the sequence number)

	+ distinguish the state of the data by some
	  flags in struct prb_desc to avoid complicated
	  and tricky checks

It seems that the ring buffer of descriptors really makes
things easier.

Regarding the flags. I have something like:

struct prb_desc
{
	unsigned long seq;
	bool committed;
	bool freed;
}

The basic idea with the flags is that they are valid only
when the seq number in the structure is valid. The newly
reserved struct prb_desc is written the following way:

static void prb_init_desc(struct prb_desc *desc)
{
	desc->committed = false;
	desc->freed = false;

	/*
	 * Flags must be cleared before we tell others that they
	 * are for this sequence number.
	 */
	smp_wmb();

	desc->seq = seq;
}

Then we could have checks like:

/*
 * Used by readers to check if the data are valid.
 * It has to be called twice (before and after)
 * to make sure that the read data are valid.
 */
static bool prb_data_valid(struct printk_ringbuffer *rb,
			   unsigned long seq)
{
	static prb_desc *desc = TO_DESC(rb, seq);

	if (READ_ONCE(desc->seq) != seq)
		false;

	/* Do not read outdated flags, see prb_init_desc()
	smp_rmb();

	return READ_ONCE(desc->committed) && !READ_ONCE(desc->freed);
}

I am not sure if these extra flags are really needed and useful.
This is why I play with it myself. I do not want to ask you to
spend a lot of time with my crazy ideas.

Anyway, the above approach looked promising until I tried to
to free data from the data array. The problem is how to prove
that the sequence number read from the data array is not
a garbage. BTW: I think that your expire_oldest_data() is
buggy from this point of view, see below.

I think that it might be much more safe when we mask the two
highest bits of seq number and use them for the flags.
Then we could track the state of the given sequence number
a very safe and straightforward way.



Finally, here are some comments about the original patch:

On Fri 2019-06-07 18:29:48, John Ogness wrote:
> See documentation for details.

Please, mention here some basics. It might be enough to copy the
following sections from the documentation:

Overview
Features
Behavior

Note that the documentation is written via .rst file. You need to
build html or pdf to get all the pieces together.


> diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
> new file mode 100644
> index 000000000000..569980a61c0a
> --- /dev/null
> +++ b/include/linux/printk_ringbuffer.h
> @@ -0,0 +1,238 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PRINTK_RINGBUFFER_H
> +#define _LINUX_PRINTK_RINGBUFFER_H
> +
> +#include <linux/atomic.h>
> +
> +/**
> + * struct prb_list - An abstract linked list of items.
> + * @oldest: The oldest item on the list.
> + * @newest: The newest item on the list.

I admit that I got confused by this. I wonder if there is another
location in kernel where lists are handled this way.

I have always seen in kernel only lists handled via the struct
list_head trick. Where the same structure is bundled in all
linked members.

I can't find a good name. I would personally remove the structure
and add the members into the relates structures directly.

Also I would personally use "first" and "last" because they are
shorter and easier to visually distinguish. I know that "oldest"
and "newest" are more clear but...


> +/**
> + * struct prb_descr - A descriptor representing an entry in the ringbuffer.

I agree with Peter that "desc" is a better shortcut.

> + * @seq: The sequence number of the entry.
> + * @id: The descriptor id.
> + *      The location of the descriptor within the descriptor array can be 
> + *      determined from this value.
> + * @data: The logical position of the data for this entry.
> + *        The location of the beginning of the data within the data array
> + *        can be determined from this value.

I was quite confused by this name. Please, use "lpos". It will make
clear that it is the logical position. Also it will be clear
that desc->data is the same as lpos used on other location
in the code.


> + * @data_next: The logical position of the data next to this entry.
> + *             This is used to determine the length of the data as well as
> + *             identify where the next data begins.

next_lpos

> + * @next: The id of the next (newer) descriptor in the linked list.
> + *        A value of EOL means it is the last descriptor in the list.
> + *
> + * Descriptors are used to identify where the data for each entry is and
> + * also provide an ordering for readers. Entry ordering is based on the
> + * descriptor linked list (not the ordering of data in the data array).
> + */
> +struct prb_descr {
> +	/* private */
> +	u64 seq;
> +	unsigned long id;
> +	unsigned long data;
> +	unsigned long data_next;
> +	unsigned long next;
> +};
> +
> +/**
> + * struct printk_ringbuffer - The ringbuffer structure.
> + * @data_array_size_bits: The size of the data array as a power-of-2.

I would use "data_size_bits"

> + * @data_array: A pointer to the data array.

and "data"

> + * @data_list: A list of entry data.
> + *             Since the data list is not traversed, this list is only used to
> + *             mark the contiguous section of the data array that is in use.
> + * @descr_max_count: The maximum amount of descriptors allowed.
> + * @descr_array: A pointer to the descriptor array.

descs?

> +/**
> + * prb_for_each_entry() - Iterate through all the entries of a ringbuffer.
> + * @i: A pointer to an iterator.
> + * @l: An integer used to identify when the last entry is traversed.
> + *
> + * This macro expects the iterator to be initialized. It also does not reset
> + * the iterator. So if the iterator has already been used for some traversal,
> + * this macro will continue where the iterator left off.
> + */
> +#define prb_for_each_entry(i, l) \
> +	for (; (l = prb_iter_next_valid_entry(i)) != 0;)

This is very unusual semantic. Please, define two iterators:

     prb_for_each_entry() - iterate over all entries
     prb_for_each_entry_continue() - iterate from the gived entry

> +/**
> + * expire_oldest_data() - Invalidate the oldest data block.
> + * @rb: The ringbuffer containing the data block.
> + * @oldest_lpos: The logical position of the oldest data block.
> + *
> + * This function expects to "push" the pointer to the oldest data block
> + * forward, thus invalidating the oldest data block. However, before pushing,
> + * it is verified if the data block is valid. (For example, if the data block
> + * was reserved but not yet committed, it is not permitted to invalidate the
> + * "in use by a writer" data.)
> + *
> + * If the data is valid, it will be associated with a descriptor, which will
> + * then provide the necessary information to validate the data.
> + *
> + * Return: true if the oldest data was invalidated (regardless if this
> + *         task was the one that did it or not), otherwise false.
> + */
> +static bool expire_oldest_data(struct printk_ringbuffer *rb,
> +			       unsigned long oldest_lpos)
> +{
> +	unsigned long newest_lpos;
> +	struct prb_datablock *b;
> +	unsigned long data_next;
> +	struct prb_descr *d;
> +	unsigned long data;
> +
> +	/* MB2: synchronize data reservation */
> +	newest_lpos = smp_load_acquire(&rb->data_list.newest);
> +
> +	b = TO_DATABLOCK(rb, oldest_lpos);
> +
> +	/* MB3: synchronize descr setup */
> +	d = TO_DESCR(rb, smp_load_acquire(&b->id));
> +
> +	data = READ_ONCE(d->data);
> +
> +	/* sanity check to check to see if b->id was correct */
> +	if (oldest_lpos != data)
> +		goto out;

Is this cross check really enough?
How is it ensured that the data are committed?
How is it ensured that the descriptor is not an outdated one?

IMHO, there might be a garbage in the data array. It might be chance
point to an outdated descriptor that by chance pointed to this
data range in the past. I agree that it is very unlikely. But
we could not afford such a risk.

> +	/* MB4: synchronize commit */
> +	data_next = smp_load_acquire(&d->data_next);
> +
> +	if (!data_valid(rb, oldest_lpos, newest_lpos, data, data_next))
> +		goto out;
> +
> +	/* MB1: synchronize data invalidation */
> +	cmpxchg_release(&rb->data_list.oldest, data, data_next);
> +
> +	/* Some task (maybe this one) successfully expired the oldest data. */
> +	return true;
> +out:
> +	return (oldest_lpos != READ_ONCE(rb->data_list.oldest));
> +}

Best Regards,
Petr
