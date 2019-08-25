Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC55C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274B722CE9
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 02:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfHYCnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 22:43:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37850 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbfHYCnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 22:43:05 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i1iUI-0002JB-W8; Sun, 25 Aug 2019 04:42:39 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: dataring_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
Date:   Sun, 25 Aug 2019 04:42:37 +0200
In-Reply-To: <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 20 Aug 2019 15:50:04 +0200")
Message-ID: <87r25aklsy.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> +/**
>> + * dataring_push() - Reserve a data block in the data array.
>> + *
>> + * @dr:   The data ringbuffer to reserve data in.
>> + *
>> + * @size: The size to reserve.
>> + *
>> + * @desc: A pointer to a descriptor to store the data block information.
>> + *
>> + * @id:   The ID of the descriptor to be associated.
>> + *        The data block will not be set with @id, but rather initialized with
>> + *        a value that is explicitly different than @id. This is to handle the
>> + *        case when newly available garbage by chance matches the descriptor
>> + *        ID.
>> + *
>> + * This function expects to move the head pointer forward. If this would
>> + * result in overtaking the data array index of the tail, the tail data block
>> + * will be invalidated.
>> + *
>> + * Return: A pointer to the reserved writer data, otherwise NULL.
>> + *
>> + * This will only fail if it was not possible to invalidate the tail data
>> + * block.
>> + */
>> +char *dataring_push(struct dataring *dr, unsigned int size,
>> +		    struct dr_desc *desc, unsigned long id)
>> +{
>> +	unsigned long begin_lpos;
>> +	unsigned long next_lpos;
>> +	struct dr_datablock *db;
>> +	bool ret;
>> +
>> +	to_db_size(&size);
>> +
>> +	do {
>> +		/* fA: */
>> +		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
>> +
>> +		/*
>> +		 * fB:
>> +		 *
>> +		 * The data ringbuffer tail may have been pushed (by this or
>> +		 * any other task). The updated @tail_lpos must be visible to
>> +		 * all observers before changes to @begin_lpos, @next_lpos, or
>> +		 * @head_lpos by this task are visible in order to allow other
>> +		 * tasks to recognize the invalidation of the data
>> +		 * blocks.
>
> This sounds strange. The write barrier should be done only on CPU
> that really modified tail_lpos. I.e. it should be in _dataring_pop()
> after successful dr->tail_lpos modification.

The problem is that there are no data dependencies between the different
variables. When a new datablock is being reserved, it is critical that
all other observers see that the tail_lpos moved forward _before_ any
other changes. _dataring_pop() uses an smp_rmb() to synchronize for
tail_lpos movement. This CPU is about to make some changes and may have
seen an updated tail_lpos. An smp_wmb() is useless if this is not the
CPU that performed that update. The full memory barrier ensures that all
other observers will see what this CPU sees before any of its future
changes are seen.

You suggest an alternative implementation below. I will address that
there.

>> +		 * This pairs with the smp_rmb() in _dataring_pop() as well as
>> +		 * any reader task using smp_rmb() to post-validate data that
>> +		 * has been read from a data block.
>> +
>> +		 * Memory barrier involvement:
>> +		 *
>> +		 * If dE reads from fE, then dI reads from fA->eA.
>> +		 * If dC reads from fG, then dI reads from fA->eA.
>> +		 * If dD reads from fH, then dI reads from fA->eA.
>> +		 * If mC reads from fH, then mF reads from fA->eA.
>> +		 *
>> +		 * Relies on:
>> +		 *
>> +		 * FULL MB between fA->eA and fE
>> +		 *    matching
>> +		 * RMB between dE and dI
>> +		 *
>> +		 * FULL MB between fA->eA and fG
>> +		 *    matching
>> +		 * RMB between dC and dI
>> +		 *
>> +		 * FULL MB between fA->eA and fH
>> +		 *    matching
>> +		 * RMB between dD and dI
>> +		 *
>> +		 * FULL MB between fA->eA and fH
>> +		 *    matching
>> +		 * RMB between mC and mF
>> +		 */
>> +		smp_mb();
>
> All these comments talk about sychronization against read barriers.
> It means that we would need a write barrier here. But it does
> not make much sense to do write barrier before actually
> writing dr->head_lpos.

I think my comments above address this.

> After all I think that we do not need any barrier here.
> The write barrier for dr->tail_lpos should be in
> _dataring_pop(). The read barrier is not needed because
> we are not reading anything here.
>
> Instead we should put a barrier after modyfying dr->head_lpos,
> see below.

Comments below.

>> +		if (!ret) {
>> +			/*
>> +			 * Force @desc permanently invalid to minimize risk
>> +			 * of the descriptor later unexpectedly being
>> +			 * determined as valid due to overflowing/wrapping of
>> +			 * @head_lpos. An unaligned @begin_lpos can never
>> +			 * point to a data block and having the same value
>> +			 * for @begin_lpos and @next_lpos is also invalid.
>> +			 */
>> +
>> +			/* fC: */
>> +			WRITE_ONCE(desc->begin_lpos, 1);
>> +
>> +			/* fD: */
>> +			WRITE_ONCE(desc->next_lpos, 1);
>> +
>> +			return NULL;
>> +		}
>> +	/* fE: */
>> +	} while (atomic_long_cmpxchg_relaxed(&dr->head_lpos, begin_lpos,
>> +					     next_lpos) != begin_lpos);
>> +
>
> We need a write barrier here to make sure that dr->head_lpos
> is updated before we start updating other values, e.g.
> db->id below.

My RFCv2 implemented it that way. The function was called data_reserve()
and it moved the head using cmpxchg_release(). For RFCv3 I changed to a
full memory barrier instead because using acquire/release here is a bit
messy. There are 2 different places where the acquire needed to be:

- In _dataring_pop() a load_acquire() of head_lpos would need to be
  _before_ loading of begin_lpos and next_lpos.

- In prb_iter_next_valid_entry() a load_acquire() of head_lpos would
  need to be at the beginning within the dataring_datablock_isvalid()
  check (mC).

If smp_mb() is too heavy to call for every printk(), then we can move to
acquire/release. The comments of fB list exactly what is synchronized
(and where).

John Ogness
