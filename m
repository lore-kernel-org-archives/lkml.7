Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O6yRr7s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZWl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:41:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfFZWlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0fyCz6BoVMUF953ZsY4aaLX746Qn19gzpDaSd18S768=; b=O6yRr7s++12EXNsWgSVD2+UbK
        dHxXaA35j5X+O8CZIl4FFoMVPyKHlztcGTbrJVJh+JmSzSlZrl0Nct9ge9lZTVRwUcwPreOthLyKK
        dg/b+3RdIDwHxdcs3OT8gRLaG4bYFjxa8eOdbcqkLxHDBkYs0BQYP3tTWDBCy7DHjTc8xELiJTEiv
        TCvb+JgWtTqmFDWhZIUjL21+tSsLLCidFpsDOKXdPF0gQZRbDt1vXLW4JPHYLvltvMwjuEXhvyyaR
        ZtRSn0/yIIqM7vbjvxT23B53UP8a+yYrASEr/quCh+B7+a/N8AAv/eV2zAV18VLi7r22xg//zEmdm
        F5yQvcjPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgGbF-0002vB-Vo; Wed, 26 Jun 2019 22:41:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BF6098198F; Thu, 27 Jun 2019 00:40:35 +0200 (CEST)
Date:   Thu, 27 Jun 2019 00:40:34 +0200
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
Message-ID: <20190626224034.GK2490@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1df28x4.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:23:19AM +0200, John Ogness wrote:
> Hi Peter,
> 
> This is a long response, but we are getting into some fine details about
> the memory barriers (as well as battling my communication skill level).

So I'm going to reply piecewise to  this... so not such long emails, but
more of them.

> On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
> >> +static void add_descr_list(struct prb_reserved_entry *e)
> >> +{
> >> +	struct printk_ringbuffer *rb = e->rb;
> >> +	struct prb_list *l = &rb->descr_list;
> >> +	struct prb_descr *d = e->descr;
> >> +	struct prb_descr *newest_d;
> >> +	unsigned long newest_id;
> >> +
> >> +	/* set as newest */
> >> +	do {
> >> +		/* MB5: synchronize add descr */
> >> +		newest_id = smp_load_acquire(&l->newest);
> >> +		newest_d = TO_DESCR(rb, newest_id);
> >> +
> >> +		if (newest_id == EOL)
> >> +			WRITE_ONCE(d->seq, 1);
> >> +		else
> >> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> >> +		/*
> >> +		 * MB5: synchronize add descr
> >> +		 *
> >> +		 * In particular: next written before cmpxchg
> >> +		 */
> >> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
> >
> > What does this pair with? I find ->newest usage in:
> 
> It is pairing with the smp_load_acquire() at the beginning of this loop
> (also labeled MB5) that is running simultaneously on another CPU. I am
> avoiding a possible situation that a new descriptor is added but the
> store of "next" from the previous descriptor is not yet visible and thus
> the cmpxchg following will fail, which is not allowed. (Note that "next"
> is set to EOL shortly before this function is called.)
> 
> The litmus test for this is:
> 
> P0(int *newest, int *d_next)
> {
>         // set descr->next to EOL (terminates list)
>         WRITE_ONCE(*d_next, 1);
> 
>         // set descr as newest
>         smp_store_release(*newest, 1);
> }
> 
> P1(int *newest, int *d_next)
> {
>         int local_newest;
>         int local_next;
> 
>         // get newest descriptor
>         local_newest = smp_load_acquire(*newest);
> 
>         // a new descriptor is set as the newest
>         // (not relevant here)
> 
>         // read descr->next of previous newest
>         // (must be EOL!)
>         local_next = READ_ONCE(*d_next);
> }
> 
> exists (1:local_newest=1 /\ 1:local_next=0)

I'm having trouble connecting your P1's READ_ONCE() to the actual code.

You say that is in the same function, but I cannot find a LOAD there
that would care about the ACQUIRE.

Afaict prb_list is a list head not a list node (calling it just _list is
confusing at best).

You have a single linked list going from the tail to the head, while
adding to the head and removing from the tail. And that sounds like a
FIFO queue:

	struct lqueue_head {
		struct lqueue_node *head, *tail;
	};

	struct lqueue_node {
		struct lqueue_node *next;
	};

	void lqueue_push(struct lqueue_head *h, struct lqueue_node *n)
	{
		struct lqueue_node *prev;

		n->next = NULL;
		/*
		 * xchg() implies RELEASE; and thereby ensures @n is
		 * complete before getting published.
		 */
		prev = xchg(&h->head, n);
		/*
		 * xchg() implies ACQUIRE; and thereby ensures @tail is
		 * written after @head, see lqueue_pop()'s smp_rmb().
		 */
		if (prev)
			WRITE_ONCE(prev->next, n);
		else
			WRITE_ONCE(h->tail, n);
	}

	struct lqueue_node *lqueue_pop(struct lqueue_head *h)
	{
		struct lqueue_node *head, *tail, *next;

		do {
			tail = READ_ONCE(h->tail);
			/* If the list is empty, nothing to remove. */
			if (!tail)
				return NULL;

			/*
			 * If we see @tail, we must then also see @head.
			 * Pairs with the xchg() in lqueue_push(),
			 * ensure no false positive on the singleton
			 * test below.
			 */
			smp_rmb();
			head = READ_ONCE(h->head);

			/* If there is but one item; fail to remove. */
			if (head == tail)
				return NULL;

			next = smp_cond_load_relaxed(&tail->next, VAL);

		} while (cmpxchg(h->tail, tail, next) != tail);

		return tail;
	}

Now, you appear to be using desc_ids instead of pointers, but since
you're not using the actual wrap value; I don't see the benefit of using
those IDs over straight pointers.

That is, unless I've overlooked some subtle ABA issue, but then, your
code doesn't seem to mention that, and I think we're good because if we
re-use an entry, it can never get back in the same location, since we
never allow an empty list (might also be fixable, haven't tought too
hard on this).

That said, the above has cmpxchg() vs WRITE_ONCE() and is therefore not
safe on a number of our architectures. We can either not care about
performance and use xchg() for the ->tail store, or use atomic_long_t
and suffer ugly casting.

But the above is, IMO, a more useful and readable abstraction. Let me
continue in another email (probably tomorrow).
