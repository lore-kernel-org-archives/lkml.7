Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F622DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfHTOOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:14:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729975AbfHTOOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:14:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 044FBAC50;
        Tue, 20 Aug 2019 14:14:30 +0000 (UTC)
Date:   Tue, 20 Aug 2019 16:14:29 +0200
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
Subject: Re: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190820141429.hkrnynmr5ou4lem2@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-08-20 10:22:53, Petr Mladek wrote:
> On Thu 2019-08-08 00:32:26, John Ogness wrote:
> > --- /dev/null
> > +++ b/kernel/printk/ringbuffer.c
> > +/**
> > + * assign_desc() - Assign a descriptor to the caller.
> > + *
> > + * @e: The entry structure to store the assigned descriptor to.
> > + *
> > + * Find an available descriptor to assign to the caller. First it is checked
> > + * if the tail descriptor from the committed list can be recycled. If not,
> > + * perhaps a never-used descriptor is available. Otherwise, data blocks will
> > + * be invalidated until the tail descriptor from the committed list can be
> > + * recycled.
> > + *
> > + * Assigned descriptors are invalid until data has been reserved for them.
> > + *
> > + * Return: true if a descriptor was assigned, otherwise false.
> > + *
> > + * This will only fail if it was not possible to invalidate data blocks in
> > + * order to recycle a descriptor. This can happen if a writer has reserved but
> > + * not yet committed data and that reserved data is currently the oldest data.
> > + */
> > +static bool assign_desc(struct prb_reserved_entry *e)
> > +{
> > +	struct printk_ringbuffer *rb = e->rb;
> > +	struct prb_desc *d;
> > +	struct nl_node *n;
> > +	unsigned long i;
> > +
> > +	for (;;) {
> > +		/*
> > +		 * jA:
> > +		 *
> > +		 * Try to recycle a descriptor on the committed list.
> > +		 */
> > +		n = numlist_pop(&rb->nl);
> > +		if (n) {
> > +			d = container_of(n, struct prb_desc, list);
> > +			break;
> > +		}
> > +
> > +		/* Fallback to static never-used descriptors. */
> > +		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
> > +			i = atomic_fetch_inc(&rb->desc_next_unused);
> > +			if (i < DESCS_COUNT(rb)) {
> > +				d = &rb->descs[i];
> > +				atomic_long_set(&d->id, i);
> > +				break;
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * No descriptor available. Make one available for recycling
> > +		 * by invalidating data (which some descriptor will be
> > +		 * referencing).
> > +		 */
> > +		if (!dataring_pop(&rb->dr))
> > +			return false;
> > +	}
> > +
> > +	/*
> > +	 * jB:
> > +	 *
> > +	 * Modify the descriptor ID so that users of the descriptor see that
> > +	 * it has been recycled. A _release() is used so that prb_getdesc()
> > +	 * callers can see all data ringbuffer updates after issuing a
> > +	 * pairing smb_rmb(). See iA for details.
> > +	 *
> > +	 * Memory barrier involvement:
> > +	 *
> > +	 * If dB->iA reads from jB, then dI reads the same value as
> > +	 * jA->cD->hA.
> > +	 *
> > +	 * Relies on:
> > +	 *
> > +	 * RELEASE from jA->cD->hA to jB
> > +	 *    matching
> > +	 * RMB between dB->iA and dI
> > +	 */
> > +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
> > +				DESCS_COUNT(rb));
> 
> atomic_long_set_release() might be a bit confusing here.
> There is no related acquire.
> 
> In fact, d->id manipulation has barriers from both sides:
> 
>   + smp_rmb() before so that all reads are finished before
>     the id is updated (release)

Uh, this statement does not make sense. The read barrier is not
needed here. Instead the readers need it.

Well, we might need a write barrier before d->id manipulation.
It should be in numlist_pop() after successfully updating nl->tail_id.
It will allow readers to detect that the desriptor is being reused
(not in valid tail_id..head_id range) before we start manipulating it.


>   + smp_wmb() after so that the new ID is written before other
>     related values are modified (acquire).
> 
> The smp_wmb() barrier is in prb_reserve(). I would move it here.

This still makes sense. I would move the write barrier from
prb_reserve() here.


Sigh, I have to admit that I am not familiar with the _acquire(),
_release(), and _relaxed() variants of the atomic operations.

They probably make it easier to implement some locking API.
I am not sure how to use it here. This code implements a complex
interlock between several variables. I mean that several variables
lock each other in a cycle, like a state machine? In each case,
it is not a simple locking where we check state of a single
variable.

Best Regards,
Petr
