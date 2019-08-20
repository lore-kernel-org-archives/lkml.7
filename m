Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05869C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5F42396B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfHTIWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:22:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728426AbfHTIWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:22:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0C06AEA1;
        Tue, 20 Aug 2019 08:22:53 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:22:53 +0200
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
Subject: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
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
> --- /dev/null
> +++ b/kernel/printk/ringbuffer.c
> +/**
> + * assign_desc() - Assign a descriptor to the caller.
> + *
> + * @e: The entry structure to store the assigned descriptor to.
> + *
> + * Find an available descriptor to assign to the caller. First it is checked
> + * if the tail descriptor from the committed list can be recycled. If not,
> + * perhaps a never-used descriptor is available. Otherwise, data blocks will
> + * be invalidated until the tail descriptor from the committed list can be
> + * recycled.
> + *
> + * Assigned descriptors are invalid until data has been reserved for them.
> + *
> + * Return: true if a descriptor was assigned, otherwise false.
> + *
> + * This will only fail if it was not possible to invalidate data blocks in
> + * order to recycle a descriptor. This can happen if a writer has reserved but
> + * not yet committed data and that reserved data is currently the oldest data.
> + */
> +static bool assign_desc(struct prb_reserved_entry *e)
> +{
> +	struct printk_ringbuffer *rb = e->rb;
> +	struct prb_desc *d;
> +	struct nl_node *n;
> +	unsigned long i;
> +
> +	for (;;) {
> +		/*
> +		 * jA:
> +		 *
> +		 * Try to recycle a descriptor on the committed list.
> +		 */
> +		n = numlist_pop(&rb->nl);
> +		if (n) {
> +			d = container_of(n, struct prb_desc, list);
> +			break;
> +		}
> +
> +		/* Fallback to static never-used descriptors. */
> +		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
> +			i = atomic_fetch_inc(&rb->desc_next_unused);
> +			if (i < DESCS_COUNT(rb)) {
> +				d = &rb->descs[i];
> +				atomic_long_set(&d->id, i);
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * No descriptor available. Make one available for recycling
> +		 * by invalidating data (which some descriptor will be
> +		 * referencing).
> +		 */
> +		if (!dataring_pop(&rb->dr))
> +			return false;
> +	}
> +
> +	/*
> +	 * jB:
> +	 *
> +	 * Modify the descriptor ID so that users of the descriptor see that
> +	 * it has been recycled. A _release() is used so that prb_getdesc()
> +	 * callers can see all data ringbuffer updates after issuing a
> +	 * pairing smb_rmb(). See iA for details.
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If dB->iA reads from jB, then dI reads the same value as
> +	 * jA->cD->hA.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from jA->cD->hA to jB
> +	 *    matching
> +	 * RMB between dB->iA and dI
> +	 */
> +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
> +				DESCS_COUNT(rb));

atomic_long_set_release() might be a bit confusing here.
There is no related acquire.

In fact, d->id manipulation has barriers from both sides:

  + smp_rmb() before so that all reads are finished before
    the id is updated (release)

  + smp_wmb() after so that the new ID is written before other
    related values are modified (acquire).

The smp_wmb() barrier is in prb_reserve(). I would move it here.

Best Regards,
Petr

> +
> +	e->desc = d;
> +	return true;
> +}
> +
> +/**
> + * prb_reserve() - Reserve data in the ringbuffer.
> + *
> + * @e:    The entry structure to setup.
> + *
> + * @rb:   The ringbuffer to reserve data in.
> + *
> + * @size: The size of the data to reserve.
> + *
> + * This is the public function available to writers to reserve data.
> + *
> + * Context: Any context. Disables local interrupts on success.
> + * Return: A pointer to the reserved data or an ERR_PTR if data could not be
> + *         reserved.
> + *
> + * If the provided size is legal, this will only fail if it was not possible
> + * to invalidate the oldest data block. This can happen if a writer has
> + * reserved but not yet committed data and that reserved data is currently
> + * the oldest data.
> + *
> + * The ERR_PTR values and their meaning:
> + *
> + * * -EINVAL: illegal @size value
> + * * -EBUSY:  failed to reserve a descriptor (@fail count incremented)
> + * * -ENOMEM: failed to reserve data (invalid descriptor committed)
> + */
> +char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> +		  unsigned int size)
> +{
> +	struct prb_desc *d;
> +	unsigned long id;
> +	char *buf;
> +
> +	if (!dataring_checksize(&rb->dr, size))
> +		return ERR_PTR(-EINVAL);
> +
> +	e->rb = rb;
> +
> +	/*
> +	 * Disable interrupts during the reserve/commit window in order to
> +	 * minimize the number of reserved but not yet committed data blocks
> +	 * in the data ringbuffer. Although such data blocks are not bad per
> +	 * se, they act as blockers for writers once the data ringbuffer has
> +	 * wrapped back to them.
> +	 */
> +	local_irq_save(e->irqflags);
> +
> +	/* kA: */
> +	if (!assign_desc(e)) {
> +		/* Failures to reserve descriptors are counted. */
> +		atomic_long_inc(&rb->fail);
> +		buf = ERR_PTR(-EBUSY);
> +		goto err_out;
> +	}
> +
> +	d = e->desc;
> +
> +	/*
> +	 * kB:
> +	 *
> +	 * The descriptor ID has been updated so that its users can see that
> +	 * it is now invalid. Issue an smp_wmb() so that upcoming changes to
> +	 * the descriptor will not be associated with the old descriptor ID.
> +	 * This pairs with the smp_rmb() of prb_desc_busy() (see hB for
> +	 * details) and the smp_rmb() within numlist_read() and the smp_rmb()
> +	 * of prb_iter_next_valid_entry() (see mD for details).
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If hA reads from kC, then hC reads from jB.
> +	 * If mC reads from kC, then mE reads from jB.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * WMB between jB and kC
> +	 *    matching
> +	 * RMB between hA and hC
> +	 *
> +	 * WMB between jB and kC
> +	 *    matching
> +	 * RMB between mC and mE
> +	 */
> +	smp_wmb();
> +
> +	id = atomic_long_read(&d->id);
> +
> +	/* kC: */
> +	buf = dataring_push(&rb->dr, size, &d->desc, id);
> +	if (!buf) {
> +		/* Put the invalid descriptor on the committed list. */
> +		numlist_push(&rb->nl, &d->list, id);
> +		buf = ERR_PTR(-ENOMEM);
> +		goto err_out;
> +	}
> +
> +	return buf;
> +err_out:
> +	local_irq_restore(e->irqflags);
> +	return buf;
> +}
> +EXPORT_SYMBOL(prb_reserve);
