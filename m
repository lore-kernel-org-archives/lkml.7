Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E108DC5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6904D215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nN3Sckje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF2VFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 17:05:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35766 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF2VFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 17:05:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so12128032wml.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iN92IKMvwkdFEazMSO6/5X9qK28W6OAQGW6MjAvEsP8=;
        b=nN3SckjeaZE9MsDQZBsu28ZmSpNMI40j+TqqCxw8fwD2jdBKDl3Oohchqv9XXXBtkP
         0kTHdUFKQNWWAJ0eKzOixLG/c4j6pKcvs5FVDucCfpKpMvmVM6hDqlyD1lFb2lT42y1S
         BV1pUvamJvAejSafb+xypHSqCzsl3Np+++Eh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iN92IKMvwkdFEazMSO6/5X9qK28W6OAQGW6MjAvEsP8=;
        b=etjTlA2VSy101RZA2NjLhl990ff7SvsJbLRO3tdteppFCyAOdWNAKuD5xSyfo2gMmx
         1J6YhNUTmNwv+qeGW1ANWFSKced5Mak1aIFP5t4Rq2HDHP5WzOvEXXZSUSnT74Uh7yon
         vAAh49/2jn8nHs07ckkh62pFmheL1cSMws13AhJinJHoX7oVRHLckzFqcLvr14PtC4aA
         d6T5yu+Inh3QFm34RDDrPWpmLN0FqG+JdBNvpbXxsON5xFmXfpyGgb9Rpz/CK2Rc8TG4
         iVV03JLHR5IBo6MVq0mw1Tp7I5oFPSqVc1sY81B7ZOELHpVwy+/xP+Kd21dWADcqcmII
         nu3Q==
X-Gm-Message-State: APjAAAVX5xmyIbL1Blh5Ls8h6Wll25zsP+uKEDkkmr8tZ06W4lKL9SeR
        JIl/vA/+/r6sJ37idIzem+GBOQ==
X-Google-Smtp-Source: APXvYqwPGx54hj/y4XB7241zi9Rb7ekQO5/NOnYPq/uOwmlhIxaZgdxrJgGxlX8Dmd4Bn9rlZqG5Ng==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr11895657wma.100.1561842333981;
        Sat, 29 Jun 2019 14:05:33 -0700 (PDT)
Received: from andrea (ip-94-112-62-100.net.upcbroadband.cz. [94.112.62.100])
        by smtp.gmail.com with ESMTPSA id a3sm4754007wmb.35.2019.06.29.14.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 14:05:33 -0700 (PDT)
Date:   Sat, 29 Jun 2019 23:05:28 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190629210528.GA3922@andrea>
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
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> static void add_descr_list(struct prb_reserved_entry *e)
> {
> 	struct printk_ringbuffer *rb = e->rb;
> 	struct prb_list *l = &rb->descr_list;
> 	struct prb_descr *d = e->descr;
> 	struct prb_descr *newest_d;
> 	unsigned long newest_id;
> 
> 	WRITE_ONCE(d->next, EOL);

/* C */


> 
> 	do {
> 		newest_id = READ_ONCE(l->newest);

/* A */


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

/* B: this READ_ONCE() */

Hence you're claiming a data dependency from A to B. (FWIW, the LKMM
would call "A ->dep B" an "address dependency.)

This comment also claims that the "pairing MB5-write" orders "stores
of @seq and @next" (which are to different memory locations w.r.t. A
and B): I do not get why this access to @next (C above?, that's also
"unordered" w.r.t. A) can be relevant; can you elaborate?


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

My gmail-search foo is unable to locate MB0-read: what am I missing?
Also, can you maybe annotate the memory accesses to @id, @next, @seq
and @oldest (as I did above)? I find myself guessing their location.


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

Same as above but for MB6-read and the accesses to @id, @next, @seq,
@data, @data_next.

In conclusion, I have been unable to produce litmus tests by reading
your comments (meaning I'm lost).

Thanks,
  Andrea


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
> 
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
> 
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
> 
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
> 
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
> 
> This is why I synchronize on @next instead, using (tail && !tail->next)
> for the singleton test.
> 
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
> 
> > That is, unless I've overlooked some subtle ABA issue, but then, your
> > code doesn't seem to mention that, and I think we're good because if
> > we re-use an entry, it can never get back in the same location, since
> > we never allow an empty list
> 
> I do not understand what you mean here. If a reader has a pointer to an
> entry, the entry behind that pointer can certainly change. But that
> isn't a problem. The reader will recognize that.
> 
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
> 
> > But the above is, IMO, a more useful and readable abstraction. Let me
> > continue in another email (probably tomorrow).
> 
> Thank you for taking the time for this.
> 
> John Ogness
