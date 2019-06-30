Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D26C5B57D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 02:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41D214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 02:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF3CDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 22:03:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfF3CDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 22:03:49 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hhPBo-0001Ie-Da; Sun, 30 Jun 2019 04:03:36 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
        <87k1df28x4.fsf@linutronix.de>
        <20190626224034.GK2490@worktop.programming.kicks-ass.net>
        <87mui2ujh2.fsf@linutronix.de> <20190629210528.GA3922@andrea>
Date:   Sun, 30 Jun 2019 04:03:34 +0200
In-Reply-To: <20190629210528.GA3922@andrea> (Andrea Parri's message of "Sat,
        29 Jun 2019 23:05:28 +0200")
Message-ID: <87imsnaky1.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-29, Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
>> /**
>>  * add_descr_list() - Add a descriptor to the descriptor list.
>>  *
>>  * @e: An entry that has already reserved data.
>>  *
>>  * The provided entry contains a pointer to a descriptor that has already
>>  * been reserved for this entry. However, the reserved descriptor is not
>>  * yet on the list. Add this descriptor as the newest item.
>>  *
>>  * A descriptor is added in two steps. The first step is to make this
>>  * descriptor the newest. The second step is to update @next of the former
>>  * newest descriptor to point to this one (or set @oldest to this one if
>>  * this will be the first descriptor on the list).
>>  */
>> static void add_descr_list(struct prb_reserved_entry *e)
>> {
>> 	struct printk_ringbuffer *rb = e->rb;
>> 	struct prb_list *l = &rb->descr_list;
>> 	struct prb_descr *d = e->descr;
>> 	struct prb_descr *newest_d;
>> 	unsigned long newest_id;
>> 
>> 	WRITE_ONCE(d->next, EOL);
>
> /* C */
>
>
>> 
>> 	do {
>> 		newest_id = READ_ONCE(l->newest);
>
> /* A */
>
>
>> 		newest_d = TO_DESC(rb, newest_id);
>> 
>> 		if (newest_id == EOL) {
>> 			WRITE_ONCE(d->seq, 1);
>> 		} else {
>> 			/*
>> 			 * MB5-read: synchronize setting newest descr
>> 			 *
>> 			 * context-pair: 2 writers adding a descriptor via
>> 			 * add_descr_list().
>> 			 *
>> 			 * @newest will load before @seq due to a data
>> 			 * dependency, therefore, the stores of @seq
>> 			 * and @next from the pairing MB5-write context
>> 			 * will be visible.
>> 			 *
>> 			 * Although @next is not loaded by this context,
>> 			 * this context must overwrite the stored @next
>> 			 * value of the pairing MB5-write context.
>> 			 */
>> 			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
>
> /* B: this READ_ONCE() */
>
> Hence you're claiming a data dependency from A to B. (FWIW, the LKMM
> would call "A ->dep B" an "address dependency.)
>
> This comment also claims that the "pairing MB5-write" orders "stores
> of @seq and @next" (which are to different memory locations w.r.t. A
> and B): I do not get why this access to @next (C above?, that's also
> "unordered" w.r.t. A) can be relevant; can you elaborate?

I will add some more labels to complete the picture. All these events
are within this function:

D: the WRITE_ONCE() to @seq

E: the STORE of a successful cmpxchg() for @newest (the MB5-write
cmpxchg())

F: the STORE of a new @next (the last smp_store_release() of this
function, note that the _release() is not relevant for this pair)

The significant events for 2 contexts that are accessing the same
addresses of a descriptor are:

P0(struct desc *d0)
{
        // adding a new descriptor d0

        WRITE_ONCE(d0->next, EOL);               // C
        WRITE_ONCE(d0->seq, X);                  // D
        cmpxchg_release(newest, Y, indexof(d0)); // E
}

P1(struct desc *d1)
{
        // adding a new descriptor d1 that comes after d0

        struct desc *d0;
        int r0, r1;

        r0 = READ_ONCE(newest);                 // A
        d0 = &array[r0];
        r1 = READ_ONCE(d0->seq);                // B
        WRITE_ONCE(d0->next, Z);                // F
}

d0 is the same address for P0 and P1. (The values of EOL, X, Y, Z are
unrelated and irrelevant.)

I am claiming that:

- B comes after D
- F comes after C

>> 		}
>> 
>> 		/*
>> 		 * MB5-write: synchronize setting newest descr
>> 		 *
>> 		 * context-pair: 2 writers adding a descriptor via
>> 		 * add_descr_list().
>> 		 *
>> 		 * Ensure that @next and @seq are stored before @d is
>> 		 * visible via @newest. The pairing MB5-read context
>> 		 * must load this @seq value and must overwrite this
>> 		 * @next value.
>> 		 */
>> 	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
>> 
>> 	if (unlikely(newest_id == EOL)) {
>> 		/*
>> 		 * MB0-write: synchronize adding first descr
>> 		 *
>> 		 * context-pair: 1 writer adding the first descriptor via
>> 		 * add_descr_list(), 1 reader getting the beginning of
>> 		 * the list via iter_peek_next_id().
>> 		 *
>> 		 * This context recently assigned new values for @id,
>> 		 * @next, @seq. Ensure these are stored before the first
>> 		 * store to @oldest so that the new values are visible
>> 		 * to the reader in the pairing MB0-read context.
>> 		 *
>> 		 * Note: Before this store, the value of @oldest is EOL.
>> 		 */
>
> My gmail-search foo is unable to locate MB0-read: what am I missing?
> Also, can you maybe annotate the memory accesses to @id, @next, @seq
> and @oldest (as I did above)? I find myself guessing their location.

Sorry. The MB0-read is a _new_ comment that would be added to the
smp_rmb() of the reader functions. I didn't repost everything because I
just wanted to get a feel if the comments for _this_ function are
improving. Really all I care about right now is properly documenting
MB5. It is a good example because MB5 is completely within this
function. If I can satisfactorily document MB5, then I can post a new
version with updated comments for everything.

>> 		smp_store_release(&l->oldest, e->id);
>> 	} else {
>> 		/*
>> 		 * MB6-write: synchronize linking new descr
>> 		 *
>> 		 * context-pair-1: 1 writer adding a descriptor via
>> 		 * add_descr_list(), 1 writer removing a descriptor via
>> 		 * remove_oldest_descr().
>> 		 *
>> 		 * If this is a recycled descriptor, this context
>> 		 * recently stored a new @oldest value. Ensure that
>> 		 * @oldest is stored before storing @next so that
>> 		 * if the pairing MB6-read context sees a non-EOL
>> 		 * @next value, it is ensured that it will also see
>> 		 * an updated @oldest value.
>> 		 *
>> 		 * context-pair-2: 1 writer adding a descriptor via
>> 		 * add_descr_list(), 1 reader iterating the list via
>> 		 * prb_iter_next_valid_entry().
>> 		 *
>> 		 * This context recently assigned new values for @id,
>> 		 * @next, @seq, @data, @data_next. Ensure these are
>> 		 * stored before storing @next of the previously
>> 		 * newest descriptor so that the new values are
>> 		 * visible to the iterating reader in the pairing
>> 		 * MB6-read context.
>> 		 *
>> 		 * Note: Before this store, the value of @next of the
>> 		 * previously newest descriptor is EOL.
>> 		 */
>
> Same as above but for MB6-read and the accesses to @id, @next, @seq,
> @data, @data_next.
>
> In conclusion, I have been unable to produce litmus tests by reading
> your comments (meaning I'm lost).

I feel like I'm stating all the information, but nobody understands it.
If you can help me to correctly document MB5, I can submit a new version
with all the memory barriers correctly documented.

John Ogness
