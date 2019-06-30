Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D345C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B871620673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 14:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NV3Cy4QB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF3OJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 10:09:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3OJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 10:09:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id c27so3249476wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AogWi8TSNWmIW7j+f7NO9gOCrgpejE2nA84vzwlUQ3E=;
        b=NV3Cy4QBC5Gm0xolyqjaCpPWmwXnN2raUikdyOl+67o1JF7zMX8kHokueZhABFegY7
         LRqexbyJcaG8cFNkBOHs+ozUrrkzgSJW4bw0Rhx3+2DWWO1GBq6kR9TXuWBNPmhJiybW
         2bWS9+LBRUdJatyGl7XgEBjlOyWP6hFEnIesc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AogWi8TSNWmIW7j+f7NO9gOCrgpejE2nA84vzwlUQ3E=;
        b=tamJqxAp9eAo+z/96YmD2gGa1QDm+B/3kcL7nvRnxwooMEM0dmPX8Ly1J1Kko8PkE/
         6oPXIL9xheLPcN/J6D/X0yjpSFcIiJK3rEJE+pZeTMx+IlydzhTxQHUZOPzbLqkq8bF3
         mwMXdXDxmVQ00GTOalzP41u4+ZBq/+f8cWRMkywhLWJYDpU2PDPRLsXZSla/GAx/ZDF7
         43DSHo9CgURTV9eEuxzTr2lr0nMsF+jZkCyHB5J3A0iDBa3RHkUAPdIZZ6k2xNw4WvUT
         qUBuuJk5WWC1mMTCJ2n56CE41u6rXl4RzCOD/RXJAyGJ+k5YmuzZvnTkaGhkGMSSDBbI
         2KdQ==
X-Gm-Message-State: APjAAAVH1X/cvZaExJmvCindyJr0riN8hPaEcf6VrN36Zk/VzFmehIyR
        icK6Bww1KQG8pqjZWIK5XzjtKA==
X-Google-Smtp-Source: APXvYqwYTwEcEt+dmBUxEoIpXhYZIabGivuXllOg7ofvpH2WrwR6s8B0vU/jgb/kIPQO8BOe7/9QJw==
X-Received: by 2002:adf:c614:: with SMTP id n20mr16064403wrg.17.1561903742685;
        Sun, 30 Jun 2019 07:09:02 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id g8sm14923503wme.20.2019.06.30.07.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 07:09:01 -0700 (PDT)
Date:   Sun, 30 Jun 2019 16:08:55 +0200
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
Message-ID: <20190630140855.GA6005@andrea>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
 <20190626224034.GK2490@worktop.programming.kicks-ass.net>
 <87mui2ujh2.fsf@linutronix.de>
 <20190629210528.GA3922@andrea>
 <87imsnaky1.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imsnaky1.fsf@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 04:03:34AM +0200, John Ogness wrote:
> On 2019-06-29, Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> >> /**
> >>  * add_descr_list() - Add a descriptor to the descriptor list.
> >>  *
> >>  * @e: An entry that has already reserved data.
> >>  *
> >>  * The provided entry contains a pointer to a descriptor that has already
> >>  * been reserved for this entry. However, the reserved descriptor is not
> >>  * yet on the list. Add this descriptor as the newest item.
> >>  *
> >>  * A descriptor is added in two steps. The first step is to make this
> >>  * descriptor the newest. The second step is to update @next of the former
> >>  * newest descriptor to point to this one (or set @oldest to this one if
> >>  * this will be the first descriptor on the list).
> >>  */
> >> static void add_descr_list(struct prb_reserved_entry *e)
> >> {
> >> 	struct printk_ringbuffer *rb = e->rb;
> >> 	struct prb_list *l = &rb->descr_list;
> >> 	struct prb_descr *d = e->descr;
> >> 	struct prb_descr *newest_d;
> >> 	unsigned long newest_id;
> >> 
> >> 	WRITE_ONCE(d->next, EOL);
> >
> > /* C */
> >
> >
> >> 
> >> 	do {
> >> 		newest_id = READ_ONCE(l->newest);
> >
> > /* A */
> >
> >
> >> 		newest_d = TO_DESC(rb, newest_id);
> >> 
> >> 		if (newest_id == EOL) {
> >> 			WRITE_ONCE(d->seq, 1);
> >> 		} else {
> >> 			/*
> >> 			 * MB5-read: synchronize setting newest descr
> >> 			 *
> >> 			 * context-pair: 2 writers adding a descriptor via
> >> 			 * add_descr_list().
> >> 			 *
> >> 			 * @newest will load before @seq due to a data
> >> 			 * dependency, therefore, the stores of @seq
> >> 			 * and @next from the pairing MB5-write context
> >> 			 * will be visible.
> >> 			 *
> >> 			 * Although @next is not loaded by this context,
> >> 			 * this context must overwrite the stored @next
> >> 			 * value of the pairing MB5-write context.
> >> 			 */
> >> 			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> >
> > /* B: this READ_ONCE() */
> >
> > Hence you're claiming a data dependency from A to B. (FWIW, the LKMM
> > would call "A ->dep B" an "address dependency.)
> >
> > This comment also claims that the "pairing MB5-write" orders "stores
> > of @seq and @next" (which are to different memory locations w.r.t. A
> > and B): I do not get why this access to @next (C above?, that's also
> > "unordered" w.r.t. A) can be relevant; can you elaborate?
> 
> I will add some more labels to complete the picture. All these events
> are within this function:
> 
> D: the WRITE_ONCE() to @seq
> 
> E: the STORE of a successful cmpxchg() for @newest (the MB5-write
> cmpxchg())
> 
> F: the STORE of a new @next (the last smp_store_release() of this
> function, note that the _release() is not relevant for this pair)
> 
> The significant events for 2 contexts that are accessing the same
> addresses of a descriptor are:
> 
> P0(struct desc *d0)
> {
>         // adding a new descriptor d0
> 
>         WRITE_ONCE(d0->next, EOL);               // C
>         WRITE_ONCE(d0->seq, X);                  // D
>         cmpxchg_release(newest, Y, indexof(d0)); // E
> }
> 
> P1(struct desc *d1)
> {
>         // adding a new descriptor d1 that comes after d0
> 
>         struct desc *d0;
>         int r0, r1;
> 
>         r0 = READ_ONCE(newest);                 // A
>         d0 = &array[r0];
>         r1 = READ_ONCE(d0->seq);                // B
>         WRITE_ONCE(d0->next, Z);                // F
> }
> 
> d0 is the same address for P0 and P1. (The values of EOL, X, Y, Z are
> unrelated and irrelevant.)
> 
> I am claiming that:
> 
> - B comes after D
> - F comes after C

I think these are both assuming that A is reading the value stored by E
(shortly, "A reads from E")?  If so, then the two claims become/are:

  - If A reads from E, then B comes after D

  - If A reads from E, then F comes after C

I think you could avoid the (ambiguous) "comes after" and say something
like:

  (1) If A reads from E, then B reads from D (or from another store
      to ->seq, not reported in the snippet, which overwrites D)

  (2) If A reads from E, then F overwrites C

This, IIUC, for the informal descriptions of the (intended) guarantees.
Back to the pairings in question: AFAICT,

  (a) For (1), we rely on the pairing:

        RELEASE from D to E  (matching)  ADDRESS DEP. from A to B

  (b) For (2), we rely on the pairing:

        RELEASE from C to E  (matching)  ADDRESS DEP. from A to F

Does this make sense?


> 
> >> 		}
> >> 
> >> 		/*
> >> 		 * MB5-write: synchronize setting newest descr
> >> 		 *
> >> 		 * context-pair: 2 writers adding a descriptor via
> >> 		 * add_descr_list().
> >> 		 *
> >> 		 * Ensure that @next and @seq are stored before @d is
> >> 		 * visible via @newest. The pairing MB5-read context
> >> 		 * must load this @seq value and must overwrite this
> >> 		 * @next value.
> >> 		 */
> >> 	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
> >> 
> >> 	if (unlikely(newest_id == EOL)) {
> >> 		/*
> >> 		 * MB0-write: synchronize adding first descr
> >> 		 *
> >> 		 * context-pair: 1 writer adding the first descriptor via
> >> 		 * add_descr_list(), 1 reader getting the beginning of
> >> 		 * the list via iter_peek_next_id().
> >> 		 *
> >> 		 * This context recently assigned new values for @id,
> >> 		 * @next, @seq. Ensure these are stored before the first
> >> 		 * store to @oldest so that the new values are visible
> >> 		 * to the reader in the pairing MB0-read context.
> >> 		 *
> >> 		 * Note: Before this store, the value of @oldest is EOL.
> >> 		 */
> >
> > My gmail-search foo is unable to locate MB0-read: what am I missing?
> > Also, can you maybe annotate the memory accesses to @id, @next, @seq
> > and @oldest (as I did above)? I find myself guessing their location.
> 
> Sorry. The MB0-read is a _new_ comment that would be added to the
> smp_rmb() of the reader functions. I didn't repost everything because I
> just wanted to get a feel if the comments for _this_ function are
> improving. Really all I care about right now is properly documenting
> MB5. It is a good example because MB5 is completely within this
> function. If I can satisfactorily document MB5, then I can post a new
> version with updated comments for everything.

Oh, I see, thanks for this clarification.


> 
> >> 		smp_store_release(&l->oldest, e->id);
> >> 	} else {
> >> 		/*
> >> 		 * MB6-write: synchronize linking new descr
> >> 		 *
> >> 		 * context-pair-1: 1 writer adding a descriptor via
> >> 		 * add_descr_list(), 1 writer removing a descriptor via
> >> 		 * remove_oldest_descr().
> >> 		 *
> >> 		 * If this is a recycled descriptor, this context
> >> 		 * recently stored a new @oldest value. Ensure that
> >> 		 * @oldest is stored before storing @next so that
> >> 		 * if the pairing MB6-read context sees a non-EOL
> >> 		 * @next value, it is ensured that it will also see
> >> 		 * an updated @oldest value.
> >> 		 *
> >> 		 * context-pair-2: 1 writer adding a descriptor via
> >> 		 * add_descr_list(), 1 reader iterating the list via
> >> 		 * prb_iter_next_valid_entry().
> >> 		 *
> >> 		 * This context recently assigned new values for @id,
> >> 		 * @next, @seq, @data, @data_next. Ensure these are
> >> 		 * stored before storing @next of the previously
> >> 		 * newest descriptor so that the new values are
> >> 		 * visible to the iterating reader in the pairing
> >> 		 * MB6-read context.
> >> 		 *
> >> 		 * Note: Before this store, the value of @next of the
> >> 		 * previously newest descriptor is EOL.
> >> 		 */
> >
> > Same as above but for MB6-read and the accesses to @id, @next, @seq,
> > @data, @data_next.
> >
> > In conclusion, I have been unable to produce litmus tests by reading
> > your comments (meaning I'm lost).
> 
> I feel like I'm stating all the information, but nobody understands it.
> If you can help me to correctly document MB5, I can submit a new version
> with all the memory barriers correctly documented.

IMO (and assuming that what I wrote above makes some sense), (a-b) and
(1-2) above, together with the associated annotations of the code/ops,
provide all the desired and necessary information to document MB5.

For readability purposes, it could be nice to also keep the snippet you
provided above (but let me stress, again, that such a snippet should be
integrated with additional information as suggested above).

As to "where to insert the memory barrier documentation", I really have
no suggestion ATM.  I guess someone would split it (say, before A and E)
while others could prefer to keep it within a same inline comment.

Thanks for this information (and for your patience!),

  Andrea
