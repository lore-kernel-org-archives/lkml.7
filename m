Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfHTNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbfHTNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:50:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07FFBAEE1;
        Tue, 20 Aug 2019 13:50:05 +0000 (UTC)
Date:   Tue, 20 Aug 2019 15:50:04 +0200
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
Subject: dataring_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
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
> +		/*
> +		 * fB:
> +		 *
> +		 * The data ringbuffer tail may have been pushed (by this or
> +		 * any other task). The updated @tail_lpos must be visible to
> +		 * all observers before changes to @begin_lpos, @next_lpos, or
> +		 * @head_lpos by this task are visible in order to allow other
> +		 * tasks to recognize the invalidation of the data
> +		 * blocks.

This sounds strange. The write barrier should be done only on CPU
that really modified tail_lpos. I.e. it should be in _dataring_pop()
after successful dr->tail_lpos modification.

> +		 * This pairs with the smp_rmb() in _dataring_pop() as well as
> +		 * any reader task using smp_rmb() to post-validate data that
> +		 * has been read from a data block.
> +
> +		 * Memory barrier involvement:
> +		 *
> +		 * If dE reads from fE, then dI reads from fA->eA.
> +		 * If dC reads from fG, then dI reads from fA->eA.
> +		 * If dD reads from fH, then dI reads from fA->eA.
> +		 * If mC reads from fH, then mF reads from fA->eA.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * FULL MB between fA->eA and fE
> +		 *    matching
> +		 * RMB between dE and dI
> +		 *
> +		 * FULL MB between fA->eA and fG
> +		 *    matching
> +		 * RMB between dC and dI
> +		 *
> +		 * FULL MB between fA->eA and fH
> +		 *    matching
> +		 * RMB between dD and dI
> +		 *
> +		 * FULL MB between fA->eA and fH
> +		 *    matching
> +		 * RMB between mC and mF
> +		 */
> +		smp_mb();

All these comments talk about sychronization against read barriers.
It means that we would need a write barrier here. But it does
not make much sense to do write barrier before actually
writing dr->head_lpos.

After all I think that we do not need any barrier here.
The write barrier for dr->tail_lpos should be in
_dataring_pop(). The read barrier is not needed because
we are not reading anything here.

Instead we should put a barrier after modyfying dr->head_lpos,
see below.

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

We need a write barrier here to make sure that dr->head_lpos
is updated before we start updating other values, e.g.
db->id below.

Best Regards,
Petr

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
>
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
