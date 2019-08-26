Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028E4217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHZWgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:36:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfHZWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:36:34 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2Nb2-0006c8-Uo; Tue, 27 Aug 2019 00:36:21 +0200
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
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190823092109.doduc36avylm5cds@pathway.suse.cz>
Date:   Tue, 27 Aug 2019 00:36:18 +0200
In-Reply-To: <20190823092109.doduc36avylm5cds@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 23 Aug 2019 11:21:09 +0200")
Message-ID: <878srfo8pp.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

AndreaP responded with some explanation (and great links!) on the topic
of READ_ONCE. But I feel like your comments about the WRITE_ONCE were
not addressed. I address that (and your other comments) below...

On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/numlist.c
>> +/**
>> + * numlist_push() - Add a node to the list and assign it a sequence number.
>> + *
>> + * @nl: The numbered list to push to.
>> + *
>> + * @n:  A node to push to the numbered list.
>> + *      The node must not already be part of a list.
>> + *
>> + * @id: The ID of the node.
>> + *
>> + * A node is added in two steps: The first step is to make this node the
>> + * head, which causes a following push to add to this node. The second step is
>> + * to update @next_id of the former head node to point to this one, which
>> + * makes this node visible to any task that sees the former head node.
>> + */
>> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
>> +{
>> +	unsigned long head_id;
>> +	unsigned long seq;
>> +	unsigned long r;
>> +
>> +	/*
>> +	 * bA:
>> +	 *
>> +	 * Setup the node to be a list terminator: next_id == id.
>> +	 */
>> +	WRITE_ONCE(n->next_id, id);
>
> Do we need WRITE_ONCE() here?
> Both "n" and "id" are given as parameters and do not change.
> The assigment must be done before "id" is set as nl->head_id.
> The ordering is enforced by cmpxchg_release().

The cmpxchg_release() ensures that if the node is visible to writers,
then the finalized assignment is also visible. And the store_release()
ensures that if the previous node is visible to any readers, then the
finalized assignment is also visible. In the reader case, if any readers
happen to be sitting on the node, numlist_read() will fail because the
ID was updated when the node was popped. So for all these cases any
compiler optimizations leading to that assigment (tearing, speculation,
etc) should be irrelevant. Therefore, IMO the WRITE_ONCE() is not
needed.

Since all of this is lockless, I used WRITE_ONCE() whenever touching
shared variables. I must admit the decision may be motivated primarily
by fear of compiler optimizations. Although "documenting lockless shared
variable access" did play a role as well.

I will replace the WRITE_ONCE with an assignment.

>> +
>> +	/* bB: #1 */
>> +	head_id = atomic_long_read(&nl->head_id);
>> +
>> +	for (;;) {
>> +		/* bC: */
>> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
>> +			/*
>> +			 * @head_id is invalid. Try again with an
>> +			 * updated value.
>> +			 */
>> +
>> +			cpu_relax();
>
> I have got very confused by this. cpu_relax() suggests that this
> cycle is busy waiting until a particular node becomes valid.
> My first though was that it must cause deadlock in NMI when
> the interrupted code is supposed to make the node valid.
>
> But it is the other way. The head is always valid when it is
> added to the list. It might become invalid when another CPU
> moves the head and the old one gets reused.
>
> Anyway, I do not see any reason for cpu_relax() here.

You are correct. The cpu_relax() should not be there. But there is still
an issue that this could spin hard if the head was recycled and this CPU
does not yet see the new head value.

To handle that, and in preparation for my next version, I'm now using a
read_acquire() to load the ID in the node() callback (matching the
set_release() in assign_desc()). This ensures that if numlist_read()
fails, the new head will be visible.

> Also the entire cycle would deserve a comment to avoid this mistake.
> For example:
>
> 		/*
> 		 * bC: Read seq from current head. Repeat with new
> 		 * head when it has changed and the old one got reused.
> 		 */

Agreed.

>> +
>> +			/* bB: #2 */
>> +			head_id = atomic_long_read(&nl->head_id);
>> +		}
>> +
>> +		/*
>> +		 * bD:
>> +		 *
>> +		 * Set @seq to +1 of @seq from the previous head.
>> +		 *
>> +		 * Memory barrier involvement:
>> +		 *
>> +		 * If bB reads from bE, then bC->aA reads from bD.
>> +		 *
>> +		 * Relies on:
>> +		 *
>> +		 * RELEASE from bD to bE
>> +		 *    matching
>> +		 * ADDRESS DEP. from bB to bC->aA
>> +		 */
>> +		WRITE_ONCE(n->seq, seq + 1);
>
> Do we really need WRITE_ONCE() here? 
> It is the same problem as with setting n->next_id above.

For the same reasons as the other WRITE_ONCE, I will replace the
WRITE_ONCE with an assignment.

>> +
>> +		/*
>> +		 * bE:
>> +		 *
>> +		 * This store_release() guarantees that @seq and @next are
>> +		 * stored before the node with @id is visible to any popping
>> +		 * writers. It pairs with the address dependency between @id
>> +		 * and @seq/@next provided by numlist_read(). See bD and bF
>> +		 * for details.
>> +		 */
>> +		r = atomic_long_cmpxchg_release(&nl->head_id, head_id, id);
>> +		if (r == head_id)
>> +			break;
>> +
>> +		/* bB: #3 */
>> +		head_id = r;
>> +	}
>> +
>> +	n = nl->node(head_id, nl->node_arg);
>> +
>> +	/*
>> +	 * The old head (which is still the list terminator), cannot be
>> +	 * removed because the list will always have at least one node.
>> +	 * Therefore @n must be non-NULL.
>> +	 */
>
> Please, move this comment above the nl->node() call. Both locations
> makes sense. I just see it as an important note for the call and thus
> is should be above. Also it will be better separated from the below
> comments for the _release() barrier.

OK.

>> +	/*
>> +	 * bF: the STORE part for @next_id
>> +	 *
>> +	 * Set @next_id of the previous head to @id.
>> +	 *
>> +	 * Memory barrier involvement:
>> +	 *
>> +	 * If bB reads from bE, then bF overwrites bA.
>> +	 *
>> +	 * Relies on:
>> +	 *
>> +	 * RELEASE from bA to bE
>> +	 *    matching
>> +	 * ADDRESS DEP. from bB to bF
>> +	 */
>> +	/*
>> +	 * bG: the RELEASE part for @next_id
>> +	 *
>> +	 * This _release() guarantees that a reader will see the updates to
>> +	 * this node's @seq/@next_id if the reader saw the @next_id of the
>> +	 * previous node in the list. It pairs with the address dependency
>> +	 * between @id and @seq/@next provided by numlist_read().
>> +	 *
>> +	 * Memory barrier involvement:
>> +	 *
>> +	 * If aB reads from bG, then aA' reads from bD, where aA' is in
>> +	 * numlist_read() to read the node ID from bG.
>> +	 * If aB reads from bG, then aB' reads from bA, where aB' is in
>> +	 * numlist_read() to read the node ID from bG.
>> +	 *
>> +	 * Relies on:
>> +	 *
>> +	 * RELEASE from bG to bD
>> +	 *    matching
>> +	 * ADDRESS DEP. from aB to aA'
>> +	 *
>> +	 * RELEASE from bG to bA
>> +	 *    matching
>> +	 * ADDRESS DEP. from aB to aB'
>> +	 */
>> +	smp_store_release(&n->next_id, id);
>
> Sigh, I see this line one screen below the previous command thanks
> to the extensive comments. Well, bF comment looks redundant.

Yes, it is a lot, but bF and bG are commenting on different things. bF
is the explanation that the _writer_ will overwrite the previous node's
terminating value with the ID of the new node. bG is the explanation
that if the _reader_ reads a non-terminating @next_id value, then the
initialization of @seq and @next_id for that next node will be visible.

Both of these points are key to the numlist implementation because they
guarantee the complete and correct linking of the list for all nodes
pushed.

John Ogness
