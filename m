Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D5022CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfHUFwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:52:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHUFwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:52:37 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0JXo-0003lR-87; Wed, 21 Aug 2019 07:52:28 +0200
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
Subject: Re: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
        <20190820141429.hkrnynmr5ou4lem2@pathway.suse.cz>
Date:   Wed, 21 Aug 2019 07:52:26 +0200
Message-ID: <87v9urdq05.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> > --- /dev/null
>> > +++ b/kernel/printk/ringbuffer.c
>> > +/**
>> > + * assign_desc() - Assign a descriptor to the caller.
>> > + *
>> > + * @e: The entry structure to store the assigned descriptor to.
>> > + *
>> > + * Find an available descriptor to assign to the caller. First it is checked
>> > + * if the tail descriptor from the committed list can be recycled. If not,
>> > + * perhaps a never-used descriptor is available. Otherwise, data blocks will
>> > + * be invalidated until the tail descriptor from the committed list can be
>> > + * recycled.
>> > + *
>> > + * Assigned descriptors are invalid until data has been reserved for them.
>> > + *
>> > + * Return: true if a descriptor was assigned, otherwise false.
>> > + *
>> > + * This will only fail if it was not possible to invalidate data blocks in
>> > + * order to recycle a descriptor. This can happen if a writer has reserved but
>> > + * not yet committed data and that reserved data is currently the oldest data.
>> > + */
>> > +static bool assign_desc(struct prb_reserved_entry *e)
>> > +{
>> > +	struct printk_ringbuffer *rb = e->rb;
>> > +	struct prb_desc *d;
>> > +	struct nl_node *n;
>> > +	unsigned long i;
>> > +
>> > +	for (;;) {
>> > +		/*
>> > +		 * jA:
>> > +		 *
>> > +		 * Try to recycle a descriptor on the committed list.
>> > +		 */
>> > +		n = numlist_pop(&rb->nl);
>> > +		if (n) {
>> > +			d = container_of(n, struct prb_desc, list);
>> > +			break;
>> > +		}
>> > +
>> > +		/* Fallback to static never-used descriptors. */
>> > +		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
>> > +			i = atomic_fetch_inc(&rb->desc_next_unused);
>> > +			if (i < DESCS_COUNT(rb)) {
>> > +				d = &rb->descs[i];
>> > +				atomic_long_set(&d->id, i);
>> > +				break;
>> > +			}
>> > +		}
>> > +
>> > +		/*
>> > +		 * No descriptor available. Make one available for recycling
>> > +		 * by invalidating data (which some descriptor will be
>> > +		 * referencing).
>> > +		 */
>> > +		if (!dataring_pop(&rb->dr))
>> > +			return false;
>> > +	}
>> > +
>> > +	/*
>> > +	 * jB:
>> > +	 *
>> > +	 * Modify the descriptor ID so that users of the descriptor see that
>> > +	 * it has been recycled. A _release() is used so that prb_getdesc()
>> > +	 * callers can see all data ringbuffer updates after issuing a
>> > +	 * pairing smb_rmb(). See iA for details.
>> > +	 *
>> > +	 * Memory barrier involvement:
>> > +	 *
>> > +	 * If dB->iA reads from jB, then dI reads the same value as
>> > +	 * jA->cD->hA.
>> > +	 *
>> > +	 * Relies on:
>> > +	 *
>> > +	 * RELEASE from jA->cD->hA to jB
>> > +	 *    matching
>> > +	 * RMB between dB->iA and dI
>> > +	 */
>> > +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
>> > +				DESCS_COUNT(rb));
>> 
>> atomic_long_set_release() might be a bit confusing here.
>> There is no related acquire.

As the comment states, this release is for prb_getdesc() users. The only
prb_getdesc() user is _dataring_pop(). If getdesc() returns NULL
(i.e. the descriptor's ID is not what _dataring_pop() was expecting),
then the tail must have moved and _dataring_pop() needs to see
that. Since there are no data dependencies between descriptor ID and
tail_pos, an explicit memory barrier is used. More on this below.

>> In fact, d->id manipulation has barriers from both sides:
>> 
>>   + smp_rmb() before so that all reads are finished before
>>     the id is updated (release)
>
> Uh, this statement does not make sense. The read barrier is not
> needed here. Instead the readers need it.
>
> Well, we might need a write barrier before d->id manipulation.
> It should be in numlist_pop() after successfully updating nl->tail_id.
> It will allow readers to detect that the desriptor is being reused
> (not in valid tail_id..head_id range) before we start manipulating it.
>
>>   + smp_wmb() after so that the new ID is written before other
>>     related values are modified (acquire).
>> 
>> The smp_wmb() barrier is in prb_reserve(). I would move it here.
>
> This still makes sense. I would move the write barrier from
> prb_reserve() here.

The issue is that _dataring_pop() needs to see a moved dataring tail if
prb_getdesc() fails. Just because numlist_pop() succeeded, doesn't mean
that this was the task that changed the dataring tail. I.e. another CPU
could observe that this task changed the ID but _not_ yet see that
another task changed the dataring tail.

Issuing an smp_mb() before setting the the new ID would also suffice,
but that is a pretty big hammer for something that a set_release can
take care of.

> Sigh, I have to admit that I am not familiar with the _acquire(),
> _release(), and _relaxed() variants of the atomic operations.
>
> They probably make it easier to implement some locking API.
> I am not sure how to use it here. This code implements a complex
> interlock between several variables. I mean that several variables
> lock each other in a cycle, like a state machine? In each case,
> it is not a simple locking where we check state of a single
> variable.

Keep in mind that dataring and numlist were written independent of the
ringbuffer. They are structures with very specific purposes and their
own set of variables (and memory barriers to order _those_
variables). The high-level ringbuffer also has its own variables and
memory barriers. Sometimes there is overlap, which is implemented in the
callbacks (as is here), which is why the dataring callback getdesc() has
the implementation requirement that a following smp_rmb() by the caller
will guarantee seeing an updated dataring tail. But these overlaps are
the exception, not the rule.

I think trying to see "everything at once" with a top-down view is going
to seem too complex and hurt your brain. I think it would be easier to
verify the internal consistency of the individual dataring and numlist
structures first. Once you have faith in the integrity of those
structures, moving to the high-level ringbuffer is a much smaller step.

John Ogness
