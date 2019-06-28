Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE338C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1062063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETRqpouu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfF1Ppe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:45:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44394 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfF1Ppb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8sbXJo3NGp421DQVb46BxYU1070QNdUVYi/EVt3UImE=; b=ETRqpouu3hl8vOsQjno4OIQyA
        ZqCglbMFqPGkIVLFyT2JJRmnkCzhTC5mmwEyy7wwbACRl5YePfnafdJd3SImGiBaxF0sZ2F4aVrZ3
        ptMgh4SOQRy+5pLHmKBF+IEbida+TTHD2k70rxCAQLKVtWR6mhImqawRC1CPb3odlKh8kSW/CUnx3
        mhA6u8NprCQerCejrEfKLEnseKB64oyVZa98DQfS6fbGosbLzqldkZMI0vXK685dXGyAKWXb10N5J
        8YZXKEJE8oQ51s34xpr/CdM9tTZg8IL42tOIOBc4ddTrrVv+qdKrcSnQk7f4JLwwYrvifFmFSbnpH
        MnhFpe4Yg==;
Received: from [31.161.200.126] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgt3X-0001Na-4i; Fri, 28 Jun 2019 15:44:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 811A39802C5; Fri, 28 Jun 2019 17:44:35 +0200 (CEST)
Date:   Fri, 28 Jun 2019 17:44:35 +0200
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
Message-ID: <20190628154435.GZ7905@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
 <20190626224034.GK2490@worktop.programming.kicks-ass.net>
 <87mui2ujh2.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mui2ujh2.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:50:33AM +0200, John Ogness wrote:
> On 2019-06-27, Peter Zijlstra <peterz@infradead.org> wrote:

> >>>> +static void add_descr_list(struct prb_reserved_entry *e)
> >>>> +{
> >>>> +	struct printk_ringbuffer *rb = e->rb;
> >>>> +	struct prb_list *l = &rb->descr_list;
> >>>> +	struct prb_descr *d = e->descr;
> >>>> +	struct prb_descr *newest_d;
> >>>> +	unsigned long newest_id;
> >>>> +
> >>>> +	/* set as newest */
> >>>> +	do {
> >>>> +		/* MB5: synchronize add descr */
> >>>> +		newest_id = smp_load_acquire(&l->newest);
> >>>> +		newest_d = TO_DESCR(rb, newest_id);
> >>>> +
> >>>> +		if (newest_id == EOL)
> >>>> +			WRITE_ONCE(d->seq, 1);
> >>>> +		else
> >>>> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> >>>> +		/*
> >>>> +		 * MB5: synchronize add descr
> >>>> +		 *
> >>>> +		 * In particular: next written before cmpxchg
> >>>> +		 */
> >>>> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
> >>>
> >>> What does this pair with? I find ->newest usage in:
> >> 
> >> It is pairing with the smp_load_acquire() at the beginning of this
> >> loop (also labeled MB5) that is running simultaneously on another
> >> CPU. I am avoiding a possible situation that a new descriptor is
> >> added but the store of "next" from the previous descriptor is not yet
> >> visible and thus the cmpxchg following will fail, which is not
> >> allowed. (Note that "next" is set to EOL shortly before this function
> >> is called.)
> >> 
> >> The litmus test for this is:
> >> 
> >> P0(int *newest, int *d_next)
> >> {
> >>         // set descr->next to EOL (terminates list)
> >>         WRITE_ONCE(*d_next, 1);
> >> 
> >>         // set descr as newest
> >>         smp_store_release(*newest, 1);
> >> }
> >> 
> >> P1(int *newest, int *d_next)
> >> {
> >>         int local_newest;
> >>         int local_next;
> >> 
> >>         // get newest descriptor
> >>         local_newest = smp_load_acquire(*newest);
> >> 
> >>         // a new descriptor is set as the newest
> >>         // (not relevant here)
> >> 
> >>         // read descr->next of previous newest
> >>         // (must be EOL!)
> >>         local_next = READ_ONCE(*d_next);
> >> }
> >> 
> >> exists (1:local_newest=1 /\ 1:local_next=0)
> >
> > I'm having trouble connecting your P1's READ_ONCE() to the actual
> > code. You say that is in the same function, but I cannot find a LOAD
> > there that would care about the ACQUIRE.
> 
> P1's READ_ONCE() is the READ part of the cmpxchg a few lines below:
> 
>                 WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
>                                              EOL, e->id) != EOL);
> 
> Note that the cmpxchg is a _release because of MB6 (a different memory
> barrier pair). But only the READ part of that cmpxchg synchronizes with
> MB5.
> 
> Also note that cmpxchg is used only because of bug checking. If instead
> it becomes a blind store (such as you suggest below), then it changes to
> smp_store_release().
> 
> While investigating this (and the lack of a LOAD), I realized that the
> smp_load_acquire() is not needed because @seq is dependent on the load
> of @newest. 

That!

> I have implemented and tested these changes. I also added
> setting the list terminator to this function, since all callers would
> have to do it anyway. Also, I spent a lot of time trying to put in
> comments that I think are _understandable_ and _acceptable_.
> 
> @Peter: I expect they are way too long for you.
> 
> @Andrea: Is this starting to become something that you would like to
> see?
> 
> /**
>  * add_descr_list() - Add a descriptor to the descriptor list.
>  *
>  * @e: An entry that has already reserved data.
>  *
>  * The provided entry contains a pointer to a descriptor that has already
>  * been reserved for this entry. However, the reserved descriptor is not
>  * yet on the list. Add this descriptor as the newest item.
>  *
>  * A descriptor is added in two steps. The first step is to make this
>  * descriptor the newest. The second step is to update @next of the former
>  * newest descriptor to point to this one (or set @oldest to this one if
>  * this will be the first descriptor on the list).
>  */

I still think it might be useful to explicitly call out the data
structure more. Even if you cannot use a fully abtracted queue.

Also, newest/oldest just looks weird to me; I'm expecting head/tail.

> static void add_descr_list(struct prb_reserved_entry *e)
> {
> 	struct printk_ringbuffer *rb = e->rb;
> 	struct prb_list *l = &rb->descr_list;
> 	struct prb_descr *d = e->descr;
> 	struct prb_descr *newest_d;
> 	unsigned long newest_id;
> 
> 	WRITE_ONCE(d->next, EOL);
> 
> 	do {
> 		newest_id = READ_ONCE(l->newest);
> 		newest_d = TO_DESC(rb, newest_id);
> 
> 		if (newest_id == EOL) {
> 			WRITE_ONCE(d->seq, 1);
> 		} else {
> 			/*
> 			 * MB5-read: synchronize setting newest descr
> 			 *
> 			 * context-pair: 2 writers adding a descriptor via
> 			 * add_descr_list().
> 			 *
> 			 * @newest will load before @seq due to a data
> 			 * dependency, therefore, the stores of @seq
> 			 * and @next from the pairing MB5-write context
> 			 * will be visible.
> 			 *
> 			 * Although @next is not loaded by this context,
> 			 * this context must overwrite the stored @next
> 			 * value of the pairing MB5-write context.
> 			 */
> 			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> 		}
> 
> 		/*
> 		 * MB5-write: synchronize setting newest descr
> 		 *
> 		 * context-pair: 2 writers adding a descriptor via
> 		 * add_descr_list().
> 		 *
> 		 * Ensure that @next and @seq are stored before @d is
> 		 * visible via @newest. The pairing MB5-read context
> 		 * must load this @seq value and must overwrite this
> 		 * @next value.
> 		 */
> 	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
> 
> 	if (unlikely(newest_id == EOL)) {
> 		/*
> 		 * MB0-write: synchronize adding first descr
> 		 *
> 		 * context-pair: 1 writer adding the first descriptor via
> 		 * add_descr_list(), 1 reader getting the beginning of
> 		 * the list via iter_peek_next_id().
> 		 *
> 		 * This context recently assigned new values for @id,
> 		 * @next, @seq. Ensure these are stored before the first
> 		 * store to @oldest so that the new values are visible
> 		 * to the reader in the pairing MB0-read context.
> 		 *
> 		 * Note: Before this store, the value of @oldest is EOL.
> 		 */
> 		smp_store_release(&l->oldest, e->id);
> 	} else {
> 		/*
> 		 * MB6-write: synchronize linking new descr
> 		 *
> 		 * context-pair-1: 1 writer adding a descriptor via
> 		 * add_descr_list(), 1 writer removing a descriptor via
> 		 * remove_oldest_descr().
> 		 *
> 		 * If this is a recycled descriptor, this context
> 		 * recently stored a new @oldest value. Ensure that
> 		 * @oldest is stored before storing @next so that
> 		 * if the pairing MB6-read context sees a non-EOL
> 		 * @next value, it is ensured that it will also see
> 		 * an updated @oldest value.
> 		 *
> 		 * context-pair-2: 1 writer adding a descriptor via
> 		 * add_descr_list(), 1 reader iterating the list via
> 		 * prb_iter_next_valid_entry().
> 		 *
> 		 * This context recently assigned new values for @id,
> 		 * @next, @seq, @data, @data_next. Ensure these are
> 		 * stored before storing @next of the previously
> 		 * newest descriptor so that the new values are
> 		 * visible to the iterating reader in the pairing
> 		 * MB6-read context.
> 		 *
> 		 * Note: Before this store, the value of @next of the
> 		 * previously newest descriptor is EOL.
> 		 */
> 		smp_store_release(&newest_d->next, e->id);
> 	}
> }
> 
> The smp_rmb() calls in the reader functions are then commented and
> marked with the appropriate MB0-read and MB6-read labels.
> 
> > Afaict prb_list is a list head not a list node (calling it just _list
> > is confusing at best).
> 
> OK.
> 
> > You have a single linked list going from the tail to the head, while
> > adding to the head and removing from the tail. And that sounds like a
> > FIFO queue:
> 
> Yes, but with one important feature: the nodes in the FIFO queue are
> labeled with ordered sequence numbers. This is important for printk. I
> talk more about this below.

But nowhere did/do you say what the actual data structure is, with what
modification for which reason.

> > 	struct lqueue_head {
> > 		struct lqueue_node *head, *tail;
> > 	};
> >
> > 	struct lqueue_node {
> > 		struct lqueue_node *next;
> > 	};
> >
> > 	void lqueue_push(struct lqueue_head *h, struct lqueue_node *n)
> > 	{
> > 		struct lqueue_node *prev;
> >
> > 		n->next = NULL;
> 
> Is this safe? Do all compilers understand that @next must be stored
> before the xchg() of @head? I would have chosen WRITE_ONCE().

Yep, xchg() implies an smp_mb() before and after, smp_mb() in turn
implies a compiler barrier. Even if there is compiler induced brain
damage (store-tearing) all that must be done before the actual RmW.

Same with xchg_release(), the RELEASE is sufficient to have all previous
stores complete before the RmW.

> > 		/*
> > 		 * xchg() implies RELEASE; and thereby ensures @n is
> > 		 * complete before getting published.
> > 		 */
> > 		prev = xchg(&h->head, n);
> 
> Unfortunately it is not that simple because of sequence numbers. A node
> must be assigned a sequence number that is +1 of the previous node. This
> must be done before exchanging the head because immediately after the
> xchg() on the head, another CPU could then add on to us and expects our
> sequence number to already be set.
> 
> This is why I need cmpxchg() here.

So far that doens't make sense yet, +1 is implicit in the list order
surely. But yes, if you need the seq like that, then cmpxchg it is.

> > 		/*
> > 		 * xchg() implies ACQUIRE; and thereby ensures @tail is
> > 		 * written after @head, see lqueue_pop()'s smp_rmb().
> > 		 */
> > 		if (prev)
> > 			WRITE_ONCE(prev->next, n);
> 
> This needs to be a store_release() so that a reader cannot read @n but
> the store to @next is not yet visible. The memory barriers of the above
> xchg() do not apply here because readers never read @head.

Confused, all stores to @n are before the xchg() so the barrier from
xchg() also order those stores and this store.

> > 		else
> > 			WRITE_ONCE(h->tail, n);
> 
> Ditto, but for the tail node in particular.
> 
> > 	}
> >
> > 	struct lqueue_node *lqueue_pop(struct lqueue_head *h)
> > 	{
> > 		struct lqueue_node *head, *tail, *next;
> >
> > 		do {
> > 			tail = READ_ONCE(h->tail);
> > 			/* If the list is empty, nothing to remove. */
> > 			if (!tail)
> > 				return NULL;
> >
> > 			/*
> > 			 * If we see @tail, we must then also see @head.
> > 			 * Pairs with the xchg() in lqueue_push(),
> > 			 * ensure no false positive on the singleton
> > 			 * test below.
> > 			 */
> > 			smp_rmb();
> > 			head = READ_ONCE(h->head);
> >
> > 			/* If there is but one item; fail to remove. */
> > 			if (head == tail)
> > 				return NULL;
> >
> > 			next = smp_cond_load_relaxed(&tail->next, VAL);
> 
> What if a writer is adding a 2nd node to the queue and is interrupted by
> an NMI directly after the xchg() in lqueue_push()? Then we have:
> 
>     * head != tail
>     * tail->next == NULL
> 
> If that interrupting NMI calls lqueue_pop(), the NMI will spin
> forever. The following cmpxchg() is not allowed to happen as long as
> tail->next is NULL.

Indeed. I forgot that you actually use pop on the producer side.

(Note that the qspinlock has a queue not unlike this, but that again
doesn't have to bother with NMIs)

> This is why I synchronize on @next instead, using (tail && !tail->next)
> for the singleton test.

OK.

> > 		} while (cmpxchg(h->tail, tail, next) != tail);
> >
> > 		return tail;
> > 	}
> >
> > Now, you appear to be using desc_ids instead of pointers, but since
> > you're not using the actual wrap value; I don't see the benefit of
> > using those IDs over straight pointers.
> 
> The documentation mentions that descriptor ids are used to identify
> pointers to invalid descriptors. This is used by the readers, see
> iter_peek_next_id() and prb_iter_next_valid_entry().
> 
> IDs are used for:
> 
> - @next of descriptors on the list
> - @id, @id_next in the reader iterator
> - @id in the data blocks
> 
> If changed to pointers, iterators would need to additionally store @seq
> values to be able to identifiy if the entry they are pointing to is the
> entry they expect.
> 
> The only advantage I see with pointers is that the ringbuffer could be
> more useful generally, independent of whether the data is separate or
> within the nodes or if the nodes are statically or dynamically
> allocated. That is something worth having, even if it is not printk
> related.
> 
> Are you implicitly requesting me to split the prb_ringbuffer and instead
> base it on a new "lockless multi-writer multi-reader sequenced FIFO
> queue" data structure?

Not specifically; I was just trying to untangle the code and found a
queue. I still (sorry!) haven't gotten through the lot of it to see how
all the parts fit together.

> > That is, unless I've overlooked some subtle ABA issue, but then, your
> > code doesn't seem to mention that, and I think we're good because if
> > we re-use an entry, it can never get back in the same location, since
> > we never allow an empty list
> 
> I do not understand what you mean here. If a reader has a pointer to an
> entry, the entry behind that pointer can certainly change. But that
> isn't a problem. The reader will recognize that.

ABA is where a cmpxchg has a false positive due to values matching but
not the structure.

For example, in the above pop, if h->tail would (again) be @tail, but
@next would not be the correct value. Something like that could happen
if before the cmpxchg a concurrent pop takes the element off and then
sticks it back on, but with a different ->next.

Then our cmpxchg wil succeed and corrupt.

> > (might also be fixable, haven't tought too hard on this).
> 
> :-)
> 
> > That said, the above has cmpxchg() vs WRITE_ONCE() and is therefore
> > not safe on a number of our architectures. We can either not care
> > about performance and use xchg() for the ->tail store, or use
> > atomic_long_t and suffer ugly casting.
> 
> cmpxchg_release() vs WRITE_ONCE() is not safe?! Can you point me to
> documentation about this?

Documentation/atomic_t.txt has this, see the SEMANTICS section on
atomic-set.
