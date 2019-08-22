Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF41C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036B92339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfHVLxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732223AbfHVLxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:53:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47EEFAE84;
        Thu, 22 Aug 2019 11:53:30 +0000 (UTC)
Date:   Thu, 22 Aug 2019 13:53:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190822115329.oy5mw3nycwue6dkw@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
 <20190820141429.hkrnynmr5ou4lem2@pathway.suse.cz>
 <87v9urdq05.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9urdq05.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-21 07:52:26, John Ogness wrote:
> On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
> >> > --- /dev/null
> >> > +++ b/kernel/printk/ringbuffer.c
> >> > +/**
> >> > + * assign_desc() - Assign a descriptor to the caller.
> >> > + *
> >> > + * @e: The entry structure to store the assigned descriptor to.
> >> > + *
> >> > + * Find an available descriptor to assign to the caller. First it is checked
> >> > + * if the tail descriptor from the committed list can be recycled. If not,
> >> > + * perhaps a never-used descriptor is available. Otherwise, data blocks will
> >> > + * be invalidated until the tail descriptor from the committed list can be
> >> > + * recycled.
> >> > + *
> >> > + * Assigned descriptors are invalid until data has been reserved for them.
> >> > + *
> >> > + * Return: true if a descriptor was assigned, otherwise false.
> >> > + *
> >> > + * This will only fail if it was not possible to invalidate data blocks in
> >> > + * order to recycle a descriptor. This can happen if a writer has reserved but
> >> > + * not yet committed data and that reserved data is currently the oldest data.
> >> > + */
> >> > +static bool assign_desc(struct prb_reserved_entry *e)
> >> > +{
> >> > +	struct printk_ringbuffer *rb = e->rb;
> >> > +	struct prb_desc *d;
> >> > +	struct nl_node *n;
> >> > +	unsigned long i;
> >> > +
> >> > +	for (;;) {
> >> > +		/*
> >> > +		 * jA:
> >> > +		 *
> >> > +		 * Try to recycle a descriptor on the committed list.
> >> > +		 */
> >> > +		n = numlist_pop(&rb->nl);
> >> > +		if (n) {
> >> > +			d = container_of(n, struct prb_desc, list);
> >> > +			break;
> >> > +		}
> >> > +
> >> > +		/* Fallback to static never-used descriptors. */
> >> > +		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
> >> > +			i = atomic_fetch_inc(&rb->desc_next_unused);
> >> > +			if (i < DESCS_COUNT(rb)) {
> >> > +				d = &rb->descs[i];
> >> > +				atomic_long_set(&d->id, i);
> >> > +				break;
> >> > +			}
> >> > +		}
> >> > +
> >> > +		/*
> >> > +		 * No descriptor available. Make one available for recycling
> >> > +		 * by invalidating data (which some descriptor will be
> >> > +		 * referencing).
> >> > +		 */
> >> > +		if (!dataring_pop(&rb->dr))
> >> > +			return false;
> >> > +	}
> >> > +
> >> > +	/*
> >> > +	 * jB:
> >> > +	 *
> >> > +	 * Modify the descriptor ID so that users of the descriptor see that
> >> > +	 * it has been recycled. A _release() is used so that prb_getdesc()
> >> > +	 * callers can see all data ringbuffer updates after issuing a
> >> > +	 * pairing smb_rmb(). See iA for details.
> >> > +	 *
> >> > +	 * Memory barrier involvement:
> >> > +	 *
> >> > +	 * If dB->iA reads from jB, then dI reads the same value as
> >> > +	 * jA->cD->hA.
> >> > +	 *
> >> > +	 * Relies on:
> >> > +	 *
> >> > +	 * RELEASE from jA->cD->hA to jB
> >> > +	 *    matching
> >> > +	 * RMB between dB->iA and dI
> >> > +	 */
> >> > +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
> >> > +				DESCS_COUNT(rb));
> >> 
> >> atomic_long_set_release() might be a bit confusing here.
> >> There is no related acquire.
> 
> As the comment states, this release is for prb_getdesc() users. The only
> prb_getdesc() user is _dataring_pop().
> (i.e. the descriptor's ID is not what _dataring_pop() was expecting),
> then the tail must have moved and _dataring_pop() needs to see
> that. Since there are no data dependencies between descriptor ID and
> tail_pos, an explicit memory barrier is used. More on this below.

OK, let me show how complicated and confusing this looks for me:

  + The two related barriers are in different source files
    and APIs:

       + assign_desc() in ringbuffer.c; ringbuffer API
       + _dataring_pop in dataring.c; dataring API

  + Both the related barriers are around "id" manipulation.
    But one is in dataring, other is in descriptors array.
    One is about an old released "id". One is about a newly
    assigned "id".

  + The release() barrier is called once for each assigned
    descriptor. The acquire() barrier is called more times
    or not at all depending on the amount of free space
    in dataring.

  + prb_getdesc() is mentioned in the comment but the barrier
    is in _dataring_pop()

  + prb_getdesc() is called via dr->getdesc() callback and thus
    not straightforward to check.

  + dr->getdesc() is called twice in _dataring_pop(); once
    with _acquire() and once without.

  + _acquire() is hidden in
    desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg)

  + The comment says that it is pairing with smb_rmb() but it
    the code uses _acquire().

  + The comment says that the barrier is issued "so that callers can
    see all data ringbuffer updates". It is not specific what
    updates are meant (earlier or later).

    It can be guessed by the the type of the barrier. But it does
    help with review (barrier matches what author wanted).


What would have helped me to understand this barrier might
be something like:

	/*
	 * Got descriptor and have exclusive write access.
	 * Use _release() barrier before first modification
	 * so that others could detect the new owner via
	 * previous numlist and dataring head/tail updates.
	 *
	 * The related barrier is in _dataring_pop() when
	 * acquiring db->id.
	 */

It explains what the barrier is synchronizing and where is
the counter part.

But it still does not explain if the counter part is correct.
I simply do not know. Barriers are usually symmetric but the
only symmetric thing here is the name of the variable ("id").

It might be correct after all. But it looks so non-standard
and far from obvious at least for me. I hope that we could
either make it more symmetric and better explain it.


> > Sigh, I have to admit that I am not familiar with the _acquire(),
> > _release(), and _relaxed() variants of the atomic operations.
> >
> > They probably make it easier to implement some locking API.
> > I am not sure how to use it here. This code implements a complex
> > interlock between several variables. I mean that several variables
> > lock each other in a cycle, like a state machine? In each case,
> > it is not a simple locking where we check state of a single
> > variable.
> 
> Keep in mind that dataring and numlist were written independent of the
> ringbuffer. They are structures with very specific purposes and their
> own set of variables (and memory barriers to order _those_
> variables). The high-level ringbuffer also has its own variables and
> memory barriers. Sometimes there is overlap, which is implemented in the
> callbacks (as is here), which is why the dataring callback getdesc() has
> the implementation requirement that a following smp_rmb() by the caller
> will guarantee seeing an updated dataring tail. But these overlaps are
> the exception, not the rule.

Sure. It is possible that this is the worst place. But there are definitely
more of them:

  + smp_rmb() in numlist_read() is related to smp_wmb() in prb_reserve()
  + "node" callback in struct nl_node must do smp_wmb()
  + full memory barrier is required before calling get_new_lpos()

I think that I understand the overall algorithm in principle. But it
is really hard to prove that all pieces play well together.

I would like to discuss the overall design in a separate thread.
I wanted to comment and understand some details first.

It is clear that you put a lot of effort into it. Also it is great
that you tried to formalize the barriers. But it is still very
complicated.


> I think trying to see "everything at once" with a top-down view is going
> to seem too complex and hurt your brain. I think it would be easier to
> verify the internal consistency of the individual dataring and numlist
> structures first. Once you have faith in the integrity of those
> structures, moving to the high-level ringbuffer is a much smaller
> step.

I try hard to understand the think from different angles. I started
with numlist.c and there was quite some dependency on the rest.
Then I started to check the overall algorithm and saw even more
points that synchronized against more locations or synchronized
against another structures.

I do not know. I am going to stare more into it. It is possible
that I will get on top of it in the end.

I'll also try to apply the patch adding my approach. I wonder
if it makes a difference.

Best Regards,
Petr
