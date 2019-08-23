Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490E1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1976120850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfHWJVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:21:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfHWJVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61DD8B0E6;
        Fri, 23 Aug 2019 09:21:10 +0000 (UTC)
Date:   Fri, 23 Aug 2019 11:21:09 +0200
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
Subject: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823092109.doduc36avylm5cds@pathway.suse.cz>
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
> +/**
> + * numlist_push() - Add a node to the list and assign it a sequence number.
> + *
> + * @nl: The numbered list to push to.
> + *
> + * @n:  A node to push to the numbered list.
> + *      The node must not already be part of a list.
> + *
> + * @id: The ID of the node.
> + *
> + * A node is added in two steps: The first step is to make this node the
> + * head, which causes a following push to add to this node. The second step is
> + * to update @next_id of the former head node to point to this one, which
> + * makes this node visible to any task that sees the former head node.
> + */
> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
> +{
> +	unsigned long head_id;
> +	unsigned long seq;
> +	unsigned long r;
> +
> +	/*
> +	 * bA:
> +	 *
> +	 * Setup the node to be a list terminator: next_id == id.
> +	 */
> +	WRITE_ONCE(n->next_id, id);

Do we need WRITE_ONCE() here?
Both "n" and "id" are given as parameters and do not change.
The assigment must be done before "id" is set as nl->head_id.
The ordering is enforced by cmpxchg_release().

> +
> +	/* bB: #1 */
> +	head_id = atomic_long_read(&nl->head_id);
> +
> +	for (;;) {
> +		/* bC: */
> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
> +			/*
> +			 * @head_id is invalid. Try again with an
> +			 * updated value.
> +			 */
> +
> +			cpu_relax();

I have got very confused by this. cpu_relax() suggests that this
cycle is busy waiting until a particular node becomes valid.
My first though was that it must cause deadlock in NMI when
the interrupted code is supposed to make the node valid.

But it is the other way. The head is always valid when it is
added to the list. It might become invalid when another CPU
moves the head and the old one gets reused.

Anyway, I do not see any reason for cpu_relax() here.

Also the entire cycle would deserve a comment to avoid this mistake.
For example:

		/*
		 * bC: Read seq from current head. Repeat with new
		 * head when it has changed and the old one got reused.
		 */

> +
> +			/* bB: #2 */
> +			head_id = atomic_long_read(&nl->head_id);
> +		}
> +
> +		/*
> +		 * bD:
> +		 *
> +		 * Set @seq to +1 of @seq from the previous head.
> +		 *
> +		 * Memory barrier involvement:
> +		 *
> +		 * If bB reads from bE, then bC->aA reads from bD.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * RELEASE from bD to bE
> +		 *    matching
> +		 * ADDRESS DEP. from bB to bC->aA
> +		 */
> +		WRITE_ONCE(n->seq, seq + 1);

Do we really need WRITE_ONCE() here? 
It is the same problem as with setting n->next_id above.

> +
> +		/*
> +		 * bE:
> +		 *
> +		 * This store_release() guarantees that @seq and @next are
> +		 * stored before the node with @id is visible to any popping
> +		 * writers. It pairs with the address dependency between @id
> +		 * and @seq/@next provided by numlist_read(). See bD and bF
> +		 * for details.
> +		 */
> +		r = atomic_long_cmpxchg_release(&nl->head_id, head_id, id);
> +		if (r == head_id)
> +			break;
> +
> +		/* bB: #3 */
> +		head_id = r;
> +	}
> +
> +	n = nl->node(head_id, nl->node_arg);
> +
> +	/*
> +	 * The old head (which is still the list terminator), cannot be
> +	 * removed because the list will always have at least one node.
> +	 * Therefore @n must be non-NULL.
> +	 */

Please, move this comment above the nl->node() call. Both locations
makes sense. I just see it as an important note for the call and thus
is should be above. Also it will be better separated from the below
comments for the _release() barrier.

> +	/*
> +	 * bF: the STORE part for @next_id
> +	 *
> +	 * Set @next_id of the previous head to @id.
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If bB reads from bE, then bF overwrites bA.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from bA to bE
> +	 *    matching
> +	 * ADDRESS DEP. from bB to bF
> +	 */
> +	/*
> +	 * bG: the RELEASE part for @next_id
> +	 *
> +	 * This _release() guarantees that a reader will see the updates to
> +	 * this node's @seq/@next_id if the reader saw the @next_id of the
> +	 * previous node in the list. It pairs with the address dependency
> +	 * between @id and @seq/@next provided by numlist_read().
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If aB reads from bG, then aA' reads from bD, where aA' is in
> +	 * numlist_read() to read the node ID from bG.
> +	 * If aB reads from bG, then aB' reads from bA, where aB' is in
> +	 * numlist_read() to read the node ID from bG.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from bG to bD
> +	 *    matching
> +	 * ADDRESS DEP. from aB to aA'
> +	 *
> +	 * RELEASE from bG to bA
> +	 *    matching
> +	 * ADDRESS DEP. from aB to aB'
> +	 */
> +	smp_store_release(&n->next_id, id);

Sigh, I see this line one screen below the previous command thanks
to the extensive comments. Well, bF comment looks redundant.

> +}

Best Regards,
Petr
