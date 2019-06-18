Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8364C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJaU4gT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfFRLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:48:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gQ2r+ow4Kr8y2JbBiwa/byiRtuo+eaSkrtwAEtgI0so=; b=HJaU4gT1BpdopCNXNUNpOsuuM
        B70JNqP5zQ67T3P4PXmLraT1ssVTYnZMFLLXDgEer9g9+fZgBLqYJjXreeQQQ1lpxhLwDMnATCGLj
        CwCqyuqV1c8FATRF4azyjtzr4AZuMeQwPKYI5T3pmEC4iKJnL75kKK95MCCpZnulWnRXLhfvF0Ezy
        OgBsqe25j706G7w30BjFNQmi7tUURU8QMmoJW4BOI8o/y5o2yRYhvJp6x4Jsphh4x3gZGi7vjhsiT
        Zypt5WMuvLs6tlN19ZfDBCPp2CST34uSeipf9MBMxT7YquViqLH+bMO0KlMpzeKaduwEFyD4nZWXV
        AeoyZ/WXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdCac-0006rk-Aq; Tue, 18 Jun 2019 11:47:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05F3220A3C471; Tue, 18 Jun 2019 13:47:48 +0200 (CEST)
Date:   Tue, 18 Jun 2019 13:47:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 06:29:48PM +0206, John Ogness wrote:
> +#define DATAARRAY_SIZE(rb) (1 << rb->data_array_size_bits)
> +#define DATAARRAY_SIZE_BITMASK(rb) (DATAARRAY_SIZE(rb) - 1)

*phew* no comments on those..

I think the kernel typically uses _MASK instead of _BITMASK for this
though.

> +/**
> + * DATA_INDEX() - Determine the data array index from logical position.
> + * @rb: The associated ringbuffer.
> + * @lpos: The logical position (data/data_next).
> + */
> +#define DATA_INDEX(rb, lpos) (lpos & DATAARRAY_SIZE_BITMASK(rb))
> +
> +/**
> + * DATA_WRAPS() - Determine how many times the data array has wrapped.
> + * @rb: The associated ringbuffer.
> + * @lpos: The logical position (data/data_next).
> + *
> + * The number of wraps is useful when determining if one logical position
> + * is overtaking the data array index another logical position.
> + */
> +#define DATA_WRAPS(rb, lpos) (lpos >> rb->data_array_size_bits)
> +
> +/**
> + * DATA_THIS_WRAP_START_LPOS() - Get the position at the start of the wrap.
> + * @rb: The associated ringbuffer.
> + * @lpos: The logical position (data/data_next).
> + *
> + * Given a logical position, return the logical position if backed up to the
> + * beginning (data array index 0) of the current wrap. This is used when a
> + * data block wraps and therefore needs to begin at the beginning of the data
> + * array (for the next wrap).
> + */
> +#define DATA_THIS_WRAP_START_LPOS(rb, lpos) \
> +	(DATA_WRAPS(rb, lpos) << rb->data_array_size_bits)

That's more easily written as: ((lpos) & ~MASK(rb))

> +
> +#define DATA_ALIGN sizeof(long)
> +#define DATA_ALIGN_SIZE(sz) \
> +	((sz + (DATA_ALIGN - 1)) & ~(DATA_ALIGN - 1))

We have ALIGN() for that

> +
> +#define DESCR_COUNT_BITMASK(rb) (rb->descr_max_count - 1)

I think the kernel typically uses 'DESC' as shorthand for Descriptor.
Idem on the MASK vs BITMASK thing.

> +
> +/**
> + * DESCR_INDEX() - Determine the descriptor array index from the id.
> + * @rb: The associated ringbuffer.
> + * @id: The descriptor id.
> + */
> +#define DESCR_INDEX(rb, id) (id & DESCR_COUNT_BITMASK(rb))
> +
> +#define TO_DATABLOCK(rb, lpos) \
> +	((struct prb_datablock *)&rb->data_array[DATA_INDEX(rb, lpos)])

If I were paranoid, I'd point out that this evaluates @rb twice, and
doesn't have the macro arguments in parens.

> +#define TO_DESCR(rb, id) \
> +	(&rb->descr_array[DESCR_INDEX(rb, id)])
> +
> +/**
> + * data_valid() - Check if a data block is valid.
> + * @rb: The ringbuffer containing the data.
> + * @oldest_data: The oldest data logical position.
> + * @newest_data: The newest data logical position.
> + * @data: The logical position for the data block to check.
> + * @data_next: The logical position for the data block next to this one.
> + *             This value is used to identify the end of the data block.
> + *
> + * A data block is considered valid if it satisfies the two conditions:
> + *
> + * * oldest_data <= data < data_next <= newest_data
> + * * oldest_data is at most exactly 1 wrap behind newest_data
> + *
> + * Return: true if the specified data block is valid.
> + */
> +static inline bool data_valid(struct printk_ringbuffer *rb,
> +			      unsigned long oldest_data,
> +			      unsigned long newest_data,
> +			      unsigned long data, unsigned long data_next)
> +
> +{
> +	return ((data - oldest_data) < DATAARRAY_SIZE(rb) &&
> +		data_next != data &&
> +		(data_next - data) < DATAARRAY_SIZE(rb) &&
> +		(newest_data - data_next) < DATAARRAY_SIZE(rb) &&
> +		(newest_data - oldest_data) <= DATAARRAY_SIZE(rb));

	unsigned long size = DATA_SIZE(rb);

	/* oldest_data <= data */
	if (data - oldest_data >= size);
		return false;

	/* data_next < data */
	if (data_next == data)
		return false

	/* data_next <= newest_data */
	if (newest_data - data_next >= size)
		return false;

	/* 1 wrap */
	if (newest_data - oldest_data >= size)
		return false;

	return true;

> +}
> +
> +/**
> + * add_descr_list() - Add a descriptor to the descriptor list.
> + * @e: An entry that has already reserved data.
> + *
> + * The provided entry contains a pointer to a descriptor that has already
> + * been reserved for this entry. However, the reserved descriptor is not
> + * yet on the list. Add this descriptor as the newest item.
> + *
> + * A descriptor is added in two steps. The first step is to make this
> + * descriptor the newest. The second step is to update the "next" field of
> + * the former newest item to point to this item.
> + */
> +static void add_descr_list(struct prb_reserved_entry *e)
> +{
> +	struct printk_ringbuffer *rb = e->rb;
> +	struct prb_list *l = &rb->descr_list;
> +	struct prb_descr *d = e->descr;
> +	struct prb_descr *newest_d;
> +	unsigned long newest_id;
> +
> +	/* set as newest */
> +	do {
> +		/* MB5: synchronize add descr */
> +		newest_id = smp_load_acquire(&l->newest);
> +		newest_d = TO_DESCR(rb, newest_id);
> +
> +		if (newest_id == EOL)
> +			WRITE_ONCE(d->seq, 1);
> +		else
> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> +		/*
> +		 * MB5: synchronize add descr
> +		 *
> +		 * In particular: next written before cmpxchg
> +		 */
> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);

What does this pair with? I find ->newest usage in:

  - later this function with an MB6 comment
  - remove_oldest_descr() with no comment
  - expire_oldest_data() with an MB2 comment
  - get_new_lpos() with no comment
  - data_reserve() with an MB2 comment
  - prb_iter_next_valid_entry() with no comment
    (and the smp_rmb()s have no clear comments either).

In short; I've no frigging clue and I might as well just delete all
these comments and reverse engineer :-(

> +
> +	if (unlikely(newest_id == EOL)) {
> +		/* no previous newest means we *are* the list, set oldest */
> +
> +		/*
> +		 * MB UNPAIRED

That's a bug, MB must always be paired.

> +		 *
> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
> +		 */
> +		WARN_ON_ONCE(cmpxchg_release(&l->oldest, EOL, e->id) != EOL);
> +	} else {
> +		/* link to previous chain */
> +
> +		/*
> +		 * MB6: synchronize link descr
> +		 *
> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.

But why... and who cares.

> +		 */
> +		WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
> +					     EOL, e->id) != EOL);
> +	}
> +}
