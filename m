Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B3DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF0A22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbfHTPMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:12:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730190AbfHTPMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84C18AFC3;
        Tue, 20 Aug 2019 15:12:40 +0000 (UTC)
Date:   Tue, 20 Aug 2019 17:12:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: datablock reuse races Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190820151239.yzdqz56yeldlknln@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807222634.1723-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-08-08 00:32:26, John Ogness wrote:
> +/**
> + * _dataring_pop() - Move tail forward, invalidating the oldest data block.
> + *
> + * @dr:        The data ringbuffer containing the data block.
> + *
> + * @tail_lpos: The logical position of the oldest data block.
> + *
> + * This function expects to move the pointer to the oldest data block forward,
> + * thus invalidating the oldest data block. Before attempting to move the
> + * tail, it is verified that the data block is valid. An invalid data block
> + * means that another task has already moved the tail pointer forward.
> + *
> + * Return: The new/current value (logical position) of the tail.
> + *
> + * From the return value the caller can identify if the tail was moved
> + * forward. However, the caller does not know if it was the task that
> + * performed the move.
> + *
> + * If, after seeing a moved tail, the caller will be modifying @begin_lpos or
> + * @next_lpos of a descriptor or will be modifying the head, a full memory
> + * barrier is required before doing so. This ensures that if any update to a
> + * descriptor's @begin_lpos or @next_lpos or the data ringbuffer's head is
> + * visible, that the previous update to the tail is also visible. This avoids
> + * the possibility of failure to notice when another task has moved the tail.
> + *
> + * If the tail has not moved forward it means the @id for the data block was
> + * not set yet. In this case the tail cannot move forward.
> + */
> +static unsigned long _dataring_pop(struct dataring *dr,
> +				   unsigned long tail_lpos)
> +{
> +	unsigned long new_tail_lpos;
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +	struct dr_datablock *db;
> +	struct dr_desc *desc;
> +
> +	/*
> +	 * dA:
> +	 *
> +	 * @db has an address dependency on @tail_pos. Therefore @tail_lpos
> +	 * must be loaded before dB, which accesses @db.
> +	 */
> +	db = to_datablock(dr, tail_lpos);
> +
> +	/*
> +	 * dB:
> +	 *
> +	 * When a writer has completed accessing its data block, it sets the
> +	 * @id thus making the data block available for invalidation. This
> +	 * _acquire() ensures that this task sees all data ringbuffer and
> +	 * descriptor values seen by the writer as @id was set. This is
> +	 * necessary to ensure that the data block can be correctly identified
> +	 * as valid (i.e. @begin_lpos, @next_lpos, @head_lpos are at least the
> +	 * values seen by that writer, which yielded a valid data block at
> +	 * that time). It is not enough to rely on the address dependency of
> +	 * @desc to @id because @head_lpos is not depedent on @id. This pairs
> +	 * with the _release() in dataring_datablock_setid().
> +	 *
> +	desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg);

I guess that we might read a garbage here before dataring_push()
writes an invalid ID after it shuffled dr->head_lpos.

I am not completely sure how we detect the garbage. prb_getdesc()
might reach a valid descriptor just by chance. My understanding
is below.

> +	if (!desc) {
> +		/*
> +		 * The data block @id is invalid. The data block is either in
> +		 * use by the writer (@id not yet set) or has already been
> +		 * invalidated by another task and the data array area or
> +		 * descriptor have already been recycled. The latter case
> +		 * (descriptor already recycled) relies on the implementation
> +		 * of getdesc(), which, when using an smp_rmb(), must allow
> +		 * this task to see @tail_lpos as it was visible to the task
> +		 * that changed the ID-to-descriptor mapping. See the
> +		 * implementation of getdesc() for details.
> +		 */
> +		goto out;
> +	}
> +
> +	/*
> +	 * dC:
> +	 *
> +	 * Even though the data block @id was determined to be valid, it is
> +	 * possible that it is a data block recently made available and @id
> +	 * has not yet been initialized. The @id needs to be re-validated (dF)
> +	 * after checking if the descriptor points to the data block. Use
> +	 * _acquire() to ensure that the re-loading of @id occurs after
> +	 * loading @begin_lpos. This pairs with the _release() in
> +	 * dataring_push(). See fG for details.
> +	 */
> +	begin_lpos = smp_load_acquire(&desc->begin_lpos);
> +
> +	if (begin_lpos != tail_lpos) {
> +		/*
> +		 * @desc is not describing the data block at @tail_lpos. Since
> +		 * a data block and its descriptor always become valid before
> +		 * @id is set (see dB for details) the data block at
> +		 * @tail_lpos has already been invalidated.
> +		 */
> +		goto out;

I believe that this check should be enough to detect the garbage
or non-initialized db->id.

All descriptors are reused regularly. It means that all descriptors
should contain only valid or recently used lpos values. In each case,
there should not be any risk of overflow.

The only exception might be never used descriptors. Do we detect them?

Did I miss anything, please?

> +	}
> +
> +	/* dD: */
> +	next_lpos = READ_ONCE(desc->next_lpos);
> +
> +	if (!_datablock_valid(dr,
> +			      /* dE: */
> +			      atomic_long_read(&dr->head_lpos),
> +			      tail_lpos, begin_lpos, next_lpos)) {
> +		/* Another task has already invalidated the data block. */
> +		goto out;
> +	}
> +
> +	/* dF: */
> +	if (dr->getdesc(READ_ONCE(db->id), dr->getdesc_arg) != desc) {
> +		/*
> +		 * The data block ID has changed. The rare case of an
> +		 * uninitialized @db->id matching the descriptor ID was hit.
> +		 * This is a special case and it applies to the failure of the
> +		 * previous @id check (dB).
> +		 */
> +		goto out;
> +	}

I guess that this is related to WRITE_ONCE(db->id, id - 1) in
dataring_push(). It does not harm. But I would like to be sure
that I understand it correctly.

So, is there any chance that this check fails? IMHO, the previous
checks should catch all invalid descriptors.

Instead we might need to add a check to detect a never used
descriptor. Or is it already detected?

Might id == 0, begin_lpos == 0, next_lpos == 0 be valid values
by chance?

What if a never used descriptor has been just assigned on another CPU
and being modified?


> +	/* dG: */
> +	new_tail_lpos = atomic_long_cmpxchg_relaxed(&dr->tail_lpos,
> +						    begin_lpos, next_lpos);
> +	if (new_tail_lpos == begin_lpos)
> +		return next_lpos;
> +	return new_tail_lpos;
> +out:
> +	/*
> +	 * dH:
> +	 *
> +	 * Ensure that the updated @tail_lpos is visible if the data block has
> +	 * been invalidated. This pairs with the smp_mb() in dataring_push()
> +	 * (see fB for details) as well as with the ID synchronization used in
> +	 * the getdesc() implementation, which must guarantee that an
> +	 * smp_rmb() is sufficient for seeing an updated @tail_lpos (see the
> +	 * implementation of getdesc() for details).
> +	 */
> +	smp_rmb();
> +
> +	/* dI: */
> +	return atomic_long_read(&dr->tail_lpos);
> +}
> +
> +/**
> + * dataring_push() - Reserve a data block in the data array.
> + *
> + * @dr:   The data ringbuffer to reserve data in.
> + *
> + * @size: The size to reserve.
> + *
> + * @desc: A pointer to a descriptor to store the data block information.
> + *
> + * @id:   The ID of the descriptor to be associated.
> + *        The data block will not be set with @id, but rather initialized with
> + *        a value that is explicitly different than @id. This is to handle the
> + *        case when newly available garbage by chance matches the descriptor
> + *        ID.
> + *
> + * This function expects to move the head pointer forward. If this would
> + * result in overtaking the data array index of the tail, the tail data block
> + * will be invalidated.
> + *
> + * Return: A pointer to the reserved writer data, otherwise NULL.
> + *
> + * This will only fail if it was not possible to invalidate the tail data
> + * block.
> + */
> +char *dataring_push(struct dataring *dr, unsigned int size,
> +		    struct dr_desc *desc, unsigned long id)
> +{
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +	struct dr_datablock *db;
> +	bool ret;
> +
> +	to_db_size(&size);
> +
> +	do {
> +		/* fA: */
> +		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
> +
> +		smp_mb();
> +
> +		if (!ret) {
> +			/*
> +			 * Force @desc permanently invalid to minimize risk
> +			 * of the descriptor later unexpectedly being
> +			 * determined as valid due to overflowing/wrapping of
> +			 * @head_lpos. An unaligned @begin_lpos can never
> +			 * point to a data block and having the same value
> +			 * for @begin_lpos and @next_lpos is also invalid.
> +			 */
> +
> +			/* fC: */
> +			WRITE_ONCE(desc->begin_lpos, 1);
> +
> +			/* fD: */
> +			WRITE_ONCE(desc->next_lpos, 1);
> +
> +			return NULL;
> +		}
> +	/* fE: */
> +	} while (atomic_long_cmpxchg_relaxed(&dr->head_lpos, begin_lpos,
> +					     next_lpos) != begin_lpos);
> +
> +	db = to_datablock(dr, begin_lpos);
> +
> +	/*
> +	 * fF:
> +	 *
> +	 * @db->id is a garbage value and could possibly match the @id. This
> +	 * would be a problem because the data block would be considered
> +	 * valid before the writer has finished with it (i.e. before the
> +	 * writer has set @id). Force some other ID value.
> +	 */
> +	WRITE_ONCE(db->id, id - 1);

This would deserve a more detailed comment. Where the garbage can be
seen and how it is detected. I guess that it is in _dataring_pop()
that is being discussed above. Is it really needed?

Best Regards,
Petr

> +	/*
> +	 * fG:
> +	 *
> +	 * Ensure that @db->id is initialized to a wrong ID value before
> +	 * setting @begin_lpos so that there is no risk of accidentally
> +	 * matching a data block to a descriptor before the writer is finished
> +	 * with it (i.e. before the writer has set the correct @id). This
> +	 * pairs with the _acquire() in _dataring_pop().
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If dC reads from fG, then dF reads from fF.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from fF to fG
> +	 *    matching
> +	 * ACQUIRE from dC to dF
> +	 */
> +	smp_store_release(&desc->begin_lpos, begin_lpos);
> +
> +	/* fH: */
> +	WRITE_ONCE(desc->next_lpos, next_lpos);
> +
> +	/* If this data block wraps, use @data from the content data block. */
> +	if (DATA_WRAPS(dr, begin_lpos) != DATA_WRAPS(dr, next_lpos))
> +		db = to_datablock(dr, 0);
> +
> +	return &db->data[0];
> +}
