Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC56CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F220656
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfHWRSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:18:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388289AbfHWRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:18:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B29DCAC93;
        Fri, 23 Aug 2019 17:18:03 +0000 (UTC)
Date:   Fri, 23 Aug 2019 19:18:02 +0200
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
Subject: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
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
> +++ b/kernel/printk/numlist.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/sched.h>
> +#include "numlist.h"

struct numlist is really special variant of a list. Let me to
do a short summary:

   + FIFO queue interface

   + nodes sequentially numbered

   + nodes referenced by ID instead pointers to avoid ABA problems
     + requires custom node() callback to get pointer for given ID

   + lockless access:
     + pushed nodes must not longer get modified by push() caller
     + pop() caller gets exclusive write access, except that they
       must modify ID first and do smp_wmb() later

   + pop() does not work:
     + tail node is "busy"
	+ needs a custom callback that defines when a node is busy
     + tail is the last node
	+ needed for lockless sequential numbering

I will start with one inevitable question ;-) Is it realistic to find
another user for this API, please?

I am not sure that all the indirections, caused by the generic API,
are worth the gain.


Well, the separate API makes sense anyway. I have some ideas that
might make it cleaner.

The barriers are because of validating the ID. Now we have:

	struct nl_node {
		unsigned long	seq;
		unsigned long	next_id;
	};

that is used in:

	struct prb_desc {
		/* private */
		atomic_long_t		id;
		struct dr_desc		desc;
		struct nl_node		list;
	};

What will happen when we move id from struct prb_desc into struct nl_node?

	struct nl_node {
		unsigned long	seq;
		atomic_long_t	id;
		unsigned long	next_id;
	};

	struct prb_desc {
		struct dr_desc		desc;
		struct nl_node		list;
	};


Then the "node" callback might just return the structure. It makes
perfect sense. struct nl_node is always static for a given id.

For the printk ringbuffer it would look like:

struct nl_node *prb_nl_get_node(unsigned long id, void *nl_user)
{
	struct printk_ringbuffer *rb = (struct printk_ringbuffer *)nl_user;
	struct prb_desc *d = to_desc(rb, id);

	return &d->list;
}

I would also hide the callback behind a generic wrapper:

struct nl_node *numlist_get_node(struct numlist *nl, unsigned long id)
{
	return nl->get_node(id, nl->user_data);
}


Then we could have nicely symetric and self contained barriers
in numlist_read():

bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
		  unsigned long *next_id)
{
	struct nl_node *n;
	unsigned long cur_id;

	n = numlist_get_node(nl, id);
	if (!n)
		return false;

	/*
	 * Make sure that seq and next_id values will be read
	 * for the expected id.
	 */
	cur_id = atomic_long_read_acquire(&n->id);
	if (cur_id != id)
		return false;

	if (seq) {
		*seq = n->seq;

	if (next_id)
		*next_id = n->next_id;
	}

	/*
	 * Make sure that seq and next_id values were read for
	 * the expected ID.
	 */
	cur_id = atomic_long_read_release(&n->id);

	return cur_id == id;
}

numlist_push() might be the same, except the I would
remove several WRITE_ONCE as discussed in another mail:

void numlist_push(struct numlist *nl, struct nl_node *n)
{
	unsigned long head_id;
	unsigned long seq;
	unsigned long r;

	/* Setup the node to be a list terminator: next_id == id. */
	n->next_id = n->id;

	do {
		do {
			head_id = atomic_long_read(&nl->head_id);
		} while (!numlist_read(nl, head_id, &seq, NULL));

		n->seq = seq + 1;

		/*
		 * This store_release() guarantees that @seq and @next are
		 * stored before the node with @id is visible to any popping
		 * writers.
		 * 
		 * It pairs with the acquire() when tail_id gets updated
		 * in headlist_pop();
		 */
	} while (atomic_long_cmpxchg_release(&nl->head_id, head_id, id) !=
			head_id);

	n = nl->get_node(nl, head_id);

	/*
	 * This barrier makes sure that nl->head_id already points to
	 * the newly pushed node.
	 *
	 * It pairs with acquire when new id is written in numlist_pop().
	 * It allows to pop() and reuse this node. It can not longer
	 * be the last one.
	 */
	smp_store_release(&n->next_id, id);
}

Then I would add a symetric callback that would generate ID for
a newly popped struct. It will allow to set new ID in the numlist
API and have the barriers symetric. Something like:

unsined long prb_new_node_id(unsigned long old_id, , void *nl_user)
{
	struct printk_ringbuffer *rb = (struct printk_ringbuffer *)nl_user;

	return id + DESCS_COUNT(rb);
}

Then we could hide it in

unsigned long numlist_get_new_id(struct numlist *nl, unsigned long id)
{
	return nl->get_new_id(id, nl->user_data);
}

and do

struct nl_node *numlist_pop(struct numlist *nl)
{
	struct nl_node *n;
	unsigned long tail_id;
	unsigned long next_id;
	unsigned long r;

	tail_id = atomic_long_read(&nl->tail_id);

	do {
		do {
			tail_id = atomic_long_read(&nl->tail_id);
		} while (!numlist_read(nl, tail_id, NULL, &next_id));

		/* Make sure the node is not the only node on the list. */
		if (next_id == tail_id)
			return NULL;

		/* Make sure the node is not busy. */
		if (nl->busy(tail_id, nl->busy_arg))
			return NULL;

		/*
		 * Make sure that nl->tail_id is update before
		 * we start modyfying the popped node.
		 *
		 * It pairs with release() when head_id is
		 * pushed in numlist_push().
		 */
	} while (atomic_long_cmpxchg_acquire(&nl->tail_id,
					tail_id, next_id) !=
		  tail_id);

	/* Got exclusive write access to the node. */
	n = numlist_get_node(nl, tail_id);

	tail_id = numlist_get_new_id(tail_id, nl);
	/*
	 * Make sure that we set new ID before we allow
	 * more changes in user structure handled by this node.
	 *
	 * It pairs with release() barrier when the node is
	 * pushed into the numlist again, gets linked to
	 * the previous node and can't be modified anymore.
	 * See numlist_push().
	 */
	atomic_long_set_acquire(&d->id, atomic_long_read(&d->id) +
				DESCS_COUNT(rb));

	return n;
}

I hope that it makes some sense. I feel exhausted. It is Friday
evening here. I just wanted to send it because it looked like the most
constructive idea that I had this week. And I wanted to send something
more positive ;-)

Best Regards,
Petr
