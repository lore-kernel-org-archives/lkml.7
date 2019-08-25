Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4BC3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 02:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD582173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 02:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfHYCGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 22:06:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37826 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfHYCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 22:06:32 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i1hvF-00027J-8y; Sun, 25 Aug 2019 04:06:25 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
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
Subject: Re: assign_desc() barriers: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820082253.ybys4fsakxxdvahx@pathway.suse.cz>
        <20190820141429.hkrnynmr5ou4lem2@pathway.suse.cz>
        <87v9urdq05.fsf@linutronix.de>
        <20190822115329.oy5mw3nycwue6dkw@pathway.suse.cz>
Date:   Sun, 25 Aug 2019 04:06:21 +0200
In-Reply-To: <20190822115329.oy5mw3nycwue6dkw@pathway.suse.cz> (Petr Mladek's
        message of "Thu, 22 Aug 2019 13:53:29 +0200")
Message-ID: <87wof2knhe.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-22, Petr Mladek <pmladek@suse.com> wrote:
>>>>> --- /dev/null
>>>>> +++ b/kernel/printk/ringbuffer.c
>>>>> +/**
>>>>> + * assign_desc() - Assign a descriptor to the caller.
>>>>> + *
>>>>> + * @e: The entry structure to store the assigned descriptor to.
>>>>> + *
>>>>> + * Find an available descriptor to assign to the caller. First it is checked
>>>>> + * if the tail descriptor from the committed list can be recycled. If not,
>>>>> + * perhaps a never-used descriptor is available. Otherwise, data blocks will
>>>>> + * be invalidated until the tail descriptor from the committed list can be
>>>>> + * recycled.
>>>>> + *
>>>>> + * Assigned descriptors are invalid until data has been reserved for them.
>>>>> + *
>>>>> + * Return: true if a descriptor was assigned, otherwise false.
>>>>> + *
>>>>> + * This will only fail if it was not possible to invalidate data blocks in
>>>>> + * order to recycle a descriptor. This can happen if a writer has reserved but
>>>>> + * not yet committed data and that reserved data is currently the oldest data.
>>>>> + */
>>>>> +static bool assign_desc(struct prb_reserved_entry *e)
>>>>> +{
>>>>> +	struct printk_ringbuffer *rb = e->rb;
>>>>> +	struct prb_desc *d;
>>>>> +	struct nl_node *n;
>>>>> +	unsigned long i;
>>>>> +
>>>>> +	for (;;) {
>>>>> +		/*
>>>>> +		 * jA:
>>>>> +		 *
>>>>> +		 * Try to recycle a descriptor on the committed list.
>>>>> +		 */
>>>>> +		n = numlist_pop(&rb->nl);
>>>>> +		if (n) {
>>>>> +			d = container_of(n, struct prb_desc, list);
>>>>> +			break;
>>>>> +		}
>>>>> +
>>>>> +		/* Fallback to static never-used descriptors. */
>>>>> +		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
>>>>> +			i = atomic_fetch_inc(&rb->desc_next_unused);
>>>>> +			if (i < DESCS_COUNT(rb)) {
>>>>> +				d = &rb->descs[i];
>>>>> +				atomic_long_set(&d->id, i);
>>>>> +				break;
>>>>> +			}
>>>>> +		}
>>>>> +
>>>>> +		/*
>>>>> +		 * No descriptor available. Make one available for recycling
>>>>> +		 * by invalidating data (which some descriptor will be
>>>>> +		 * referencing).
>>>>> +		 */
>>>>> +		if (!dataring_pop(&rb->dr))
>>>>> +			return false;
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * jB:
>>>>> +	 *
>>>>> +	 * Modify the descriptor ID so that users of the descriptor see that
>>>>> +	 * it has been recycled. A _release() is used so that prb_getdesc()
>>>>> +	 * callers can see all data ringbuffer updates after issuing a
>>>>> +	 * pairing smb_rmb(). See iA for details.
>>>>> +	 *
>>>>> +	 * Memory barrier involvement:
>>>>> +	 *
>>>>> +	 * If dB->iA reads from jB, then dI reads the same value as
>>>>> +	 * jA->cD->hA.
>>>>> +	 *
>>>>> +	 * Relies on:
>>>>> +	 *
>>>>> +	 * RELEASE from jA->cD->hA to jB
>>>>> +	 *    matching
>>>>> +	 * RMB between dB->iA and dI
>>>>> +	 */
>>>>> +	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
>>>>> +				DESCS_COUNT(rb));
>>>> 
>>>> atomic_long_set_release() might be a bit confusing here.
>>>> There is no related acquire.
>> 
>> As the comment states, this release is for prb_getdesc() users. The
>> only prb_getdesc() user is _dataring_pop().  (i.e. the descriptor's
>> ID is not what _dataring_pop() was expecting), then the tail must
>> have moved and _dataring_pop() needs to see that. Since there are no
>> data dependencies between descriptor ID and tail_pos, an explicit
>> memory barrier is used. More on this below.

After reading through your post, I think you are pairing the wrong
barriers together. jB pairs with dH (i.e. the set_release() in
assign_desc() pairs with the smp_rmb() in _dataring_pop()).

(The comment for jB wrongly says dI instead of dH! Argh!)

> OK, let me show how complicated and confusing this looks for me:

I want to address all your points here. _Not_ because I want to justify
or defend my insanity, but because it may help to provide some clarity.

>   + The two related barriers are in different source files
>     and APIs:
>
>        + assign_desc() in ringbuffer.c; ringbuffer API
>        + _dataring_pop in dataring.c; dataring API

Agreed. This is a consequence of the ID management being within the
high-level ringbuffer code. I could have added an smp_rmb() to the NULL
case in prb_getdesc(). Then both barriers would be in the same
file. However, this would mean smp_rmb() is called many times
(particularly by readers) when it is not necessary.

>   + Both the related barriers are around "id" manipulation.
>     But one is in dataring, other is in descriptors array.
>     One is about an old released "id". One is about a newly
>     assigned "id".

dB is not the pairing barrier of jB. As dB's comment says, it pairs with
gA. (The load_acquire(id) in _dataring_pop() pairs with the
store_release(id) in dataring_datablock_setid().)

I should probably use a temporary variable so that the load_acquire(),
which needs a comment, can be separated from the dr->getdesc(), which
may or may not need a comment.

>   + The release() barrier is called once for each assigned
>     descriptor. The acquire() barrier is called more times
>     or not at all depending on the amount of free space
>     in dataring.

smp_rmb() is only called if dr->getdesc() fails. It matches exactly once
the latest set_release() for that descriptor.

>   + prb_getdesc() is mentioned in the comment but the barrier
>     is in _dataring_pop()

The comment also says, "See iA for details."

The comments for jB, iA, prb_getdesc(), and at the definition of struct
dataring all talk about how a matching smp_rmb() will be used. Yet
somehow you seem to think that the load_acquire() is the matching
barrier?

I agree that having a callback with memory barrier constraints is
complicated. I will look to see if I can simplify this. Or maybe instead
of saying "this matches the smp_rmb() in callers of prb_getdesc()" I
should say "this matches the smp_rmb() in _dataring_pop()".

>   + prb_getdesc() is called via dr->getdesc() callback and thus
>     not straightforward to check.

Agreed. Especially when memory barriers are involved. This needs to be
documented more clearly. What makes this particular case complicated is
that prb_getdesc() doesn't have any related memory barriers. The
synchronization is really just between assign_desc() and
_dataring_pop(). prb_getdesc() is only involved because it is the
"middle man" that translates the ID to the expected descriptor.

>   + dr->getdesc() is called twice in _dataring_pop(); once
>     with _acquire() and once without.

The _acquire() is not related to dr->getdesc(). This feedback should be
"db->id is loaded twice in _dataring_pop(); once with _acquire() and
once without."

The load with load_acquire() (dB) has comments that pretty throroughly
describe why the acquire is needed. The second load (dF) is just a check
if the ID hasn't unexpectedly changed. It doesn't need any memory
barriers. But if you grep for dF you will see that there is another
memory barrier pair that is used to ensure that this check is valid
(dC/fG).

>   + _acquire() is hidden in
>     desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg)

Agreed. Should be moved out.

>   + The comment says that it is pairing with smb_rmb() but it
>     the code uses _acquire().

The comment is correct. It is pairing with the smp_rmb() (later in the
function).

>   + The comment says that the barrier is issued "so that callers can
>     see all data ringbuffer updates". It is not specific what
>     updates are meant (earlier or later).

The comment says:

    A _release() is used so that prb_getdesc() callers can see all data
    ringbuffer updates after issuing a pairing smb_rmb().

>     It can be guessed by the the type of the barrier. But it does
>     help with review (barrier matches what author wanted).

Perhaps something like:

    A _release() is used so that the matching smp_rmb() in
    _dataring_pop() can see (at least) the data ringbuffer values at the
    time of the _release(). For _dataring_pop() it is critical that it
    does not see a tail_lpos value older than the one at the time of the
    _release().

> What would have helped me to understand this barrier might
> be something like:
>
> 	/*
> 	 * Got descriptor and have exclusive write access.
> 	 * Use _release() barrier before first modification
> 	 * so that others could detect the new owner via
> 	 * previous numlist and dataring head/tail updates.
> 	 *
> 	 * The related barrier is in _dataring_pop() when
> 	 * acquiring db->id.
> 	 */
>
> It explains what the barrier is synchronizing and where is
> the counter part.

Except that isn't the reason for the release. I hope the above
suggestion is acceptable?

> But it still does not explain if the counter part is correct.
> I simply do not know. Barriers are usually symmetric but the
> only symmetric thing here is the name of the variable ("id").
>
> It might be correct after all. But it looks so non-standard
> and far from obvious at least for me. I hope that we could
> either make it more symmetric and better explain it.

It is symmetric. But horribly documented? Or designed? It is not obvious
to me how I could refactor this to make it clean. The dataring knows
nothing about struct prb_desc and its ID (nor should it). The dataring
is not responsible for the descriptor IDs.

>>> Sigh, I have to admit that I am not familiar with the _acquire(),
>>> _release(), and _relaxed() variants of the atomic operations.
>>>
>>> They probably make it easier to implement some locking API.
>>> I am not sure how to use it here. This code implements a complex
>>> interlock between several variables. I mean that several variables
>>> lock each other in a cycle, like a state machine? In each case,
>>> it is not a simple locking where we check state of a single
>>> variable.
>> 
>> Keep in mind that dataring and numlist were written independent of the
>> ringbuffer. They are structures with very specific purposes and their
>> own set of variables (and memory barriers to order _those_
>> variables). The high-level ringbuffer also has its own variables and
>> memory barriers. Sometimes there is overlap, which is implemented in the
>> callbacks (as is here), which is why the dataring callback getdesc() has
>> the implementation requirement that a following smp_rmb() by the caller
>> will guarantee seeing an updated dataring tail. But these overlaps are
>> the exception, not the rule.
>
> Sure. It is possible that this is the worst place. But there are definitely
> more of them:
>
>   + smp_rmb() in numlist_read() is related to smp_wmb() in prb_reserve()

Correct.

>   + "node" callback in struct nl_node must do smp_wmb()

I don't know what you mean here. The only smp_wmb() is in prb_reserve().

>   + full memory barrier is required before calling get_new_lpos()

The full memory barrier is required _after_ calling get_new_lpos() if
the caller will later modify certain variables (listed in the function
comments). I think the comments at the full memory barrier (fB) explain
pretty well why that is needed. Since get_new_lpos() is a static helper
function, I'm not sure it is appropriate for what you are trying to list
here.

> I think that I understand the overall algorithm in principle. But it
> is really hard to prove that all pieces play well together.
>
> I would like to discuss the overall design in a separate thread.
> I wanted to comment and understand some details first.

I'll let you start that thread so you can decide the Cc list.

At Linux Plumbers in Lisbon I hope you can find some time so that we can
go through some of this together. I really appreciate your perspective.

> It is clear that you put a lot of effort into it.

The amount of effort does not matter. It definitely is not a reason to
accept code.

> Also it is great that you tried to formalize the barriers. But
> it is still very complicated.

I've been swimming in this code so long, I'm having a hard time
documenting the key points. I am sure over time we can improve
that. Right now I need to get it to the point where at least it is
reviewable.

John Ogness
