Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADEAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB7022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfH1KYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:24:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfH1KYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:24:51 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2v8A-0000ti-3p; Wed, 28 Aug 2019 12:24:46 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190823092109.doduc36avylm5cds@pathway.suse.cz>
        <20190823092109.doduc36avylm5cds@pathway.suse.cz>
        <878srfo8pp.fsf@linutronix.de>
        <20190827074057.2qybpmvfueub3ztl@pathway.suse.cz>
        <87mufuvg0o.fsf@linutronix.de>
        <20190827150725.scfaegg74mzqiqxw@pathway.suse.cz>
Date:   Wed, 28 Aug 2019 12:24:44 +0200
In-Reply-To: <20190827150725.scfaegg74mzqiqxw@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 27 Aug 2019 17:07:25 +0200")
Message-ID: <871rx5lh8z.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
>>>>>> --- /dev/null
>>>>>> +++ b/kernel/printk/numlist.c
>>>>>> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
>>>>>> +{
>> > [...]
>>>>>> +
>>>>>> +	/* bB: #1 */
>>>>>> +	head_id = atomic_long_read(&nl->head_id);
>>>>>> +
>>>>>> +	for (;;) {
>>>>>> +		/* bC: */
>>>>>> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
>>>>>> +			/*
>>>>>> +			 * @head_id is invalid. Try again with an
>>>>>> +			 * updated value.
>>>>>> +			 */
>>>> 
>>>> But there is still an issue that this could spin hard if the head
>>>> was recycled and this CPU does not yet see the new head value.
>>>
>>> I do not understand this. The head could get reused only after
>>> head_id was replaced with the following valid node.
>>> The next cycle is done with a new id that should be valid.
>>>
>>> Of course, the new ID might get reused as well. But then we just
>>> repeat the cycle. We have to be able to find a valid head after
>>> few cycles. The last valid ID could not get reused because nodes
>>> can be removed only if was not the last valid node.
>> 
>> nl->head_id is read using a relaxed read.
>
> I wonder if the "relaxed read" causes the confusion. Could it read
> the old id even when numlist_read() for this id failed?

Yes. It is possible that the new head ID is not yet visible. That is
what the litmus test shows.

> If this is true then it should not be relaxed read.

That is essentially what the new change facilitates. By using an ACQUIRE
to load the descriptor ID, this CPU sees what the CPU that changed the
descriptor ID saw. And that CPU must have seen a different head ID
because a successful numlist_pop() means the popped node's @next_id was
verified that it isn't a terminator, and seeing @next_id means the new
head ID from the CPU that set @next_id is also visible.

Now this still isn't a guarantee that the head ID hasn't changed since
then. So the CPU still may loop. But the CPU is guaranteed to make
forward progress with each new head ID it sees.

>> A second CPU may have added new nodes and removed/recycled
>> the node with the ID that the first CPU read as the head.
>
> This sounds like ABA problem. My understanding is that we
> use ID to prevent these problems and could ignore them.

Yes, it is an ABA problem. And yes, because of IDs, it is prevented via
detection and numlist_read() failing. The ABA problem is not ignored, it
is handled.

[snipped vague litmus test]

> I think that the Litmus test does not describe the code.

OK, at the end is a new litmus test with extensive annotation so that
you see exactly how it is modelling the code. I have also increased the
concurrency, splitting the push/pop to 2 different CPUs. And to be fair,
I left in general memory barriers (smp_rmb/smp_wmb) that, although
unrelated, do exist in the code paths as well.

All annotation/code are based on RFCv4.

> If it does then we need to fix the algorithm or barriers.

Indeed, I've fixed the barriers for the next version.

> My undestanding is that only valid nodes are added to the list.

Correct.

> If a node read via head_id is not valid then head_id already
> points to another valid node. Am I wrong, please?

You are correct.

John Ogness


C numlist_push_loop

(*
 * Result: Never
 *
 * Check numlist_push() loop to re-read the head,
 * if it is possible that a new head ID is not visible.
 *)

{
	int node1 = 1;
	int node1_next = 1;
	int node2 = 2;
	int *numlist_head = &node1;
	int *numlist_tail = &node1;
}

/*
 * This CPU wants to push a new node (not shown) to the numlist but another
 * CPU pushed a node after this CPU had read the head ID, and yet another
 * CPU pops/recycles the node that this CPU first saw as the head.
 */
P0(int **numlist_head)
{
	int *head;
	int id;

	/*
	 * Read the head ID.
	 *
	 * numlist_push() numlist.c:215
	 *
	 * head_id = atomic_long_read(&nl->head_id);
	 */
	head = READ_ONCE(*numlist_head);

	/*
	 * Read/validate the descriptor ID.
	 *
	 * NOTE: To guarantee seeing a new head ID, this should be:
	 *       id = smp_load_acquire(head);
	 *
	 * numlist_push() numlist.c:219
	 *   numlist_read() numlist.c:116
	 *     prb_desc_node() ringbuffer.c:220-223
	 *
	 * struct prb_desc *d = to_desc(arg, id);
	 * if (id != atomic_long_read(&d->id))
	 *         return NULL;
	 */
	id = READ_ONCE(*head);

	/*
	 * Re-read the head ID when validation failed.
	 *
	 * numlist_push() numlist.c:228
	 *
	 * head_id = atomic_long_read(&nl->head_id);
	 */
	head = READ_ONCE(*numlist_head);
}

/* This CPU pushes a new node (node2) to the numlist. */
P1(int **numlist_head, int *node1, int *node2, int *node1_next)
{
	int *r0;

	/*
	 * Set a new head.
	 *
	 * numlist_push() numlist.c:257
	 *
	 * r = atomic_long_cmpxchg_release(&nl->head_id, head_id, id);
	 */
	r0 = cmpxchg_release(numlist_head, node1, node2);

	/*
	 * Set the next of the previous head (node1) to node2's ID.
	 *
	 * numlist_push() numlist.c:313
	 *
	 * smp_store_release(&n->next_id, id);
	 */
	smp_store_release(node1_next, 2);
}

/* This CPU will pop/recycle a node (node) from the numlist. */
P2(int **numlist_head, int **numlist_tail, int *node1, int *node2,
   int *node1_next)
{
	int tail_id;
	int *r0;

	/*
	 * Read the tail ID. (Not used, but it touches the shared variables.)
	 *
	 * prb_reserve() ringbuffer.c:441
	 *   assign_desc() ringbuffer.c:337
	 *     numlist_pop() numlist.c:338
	 *
	 * tail_id = atomic_long_read(&nl->tail_id);
	 */
	tail_id = READ_ONCE(*numlist_tail);

	/*
	 * Read the next value of the tail node.
	 *
	 * prb_reserve() ringbuffer.c:441
	 *   assign_desc() ringbuffer.c:337
	 *     numlist_pop() numlist.c:342
	 *       numlist_read() numlist.c:116,135,147
	 *
	 * n = nl->node(id, nl->node_arg);
	 * *next_id = READ_ONCE(n->next_id);
	 * smp_rmb();
	 */
	r0 = READ_ONCE(*node1_next);
	smp_rmb();

	/*
	 * Verify that the node (node1) is not a terminator.
	 *
	 * prb_reserve() ringbuffer.c:441
	 *   assign_desc() ringbuffer.c:337
	 *     numlist_pop() numlist.c:355-356
	 *
	 * if (next_id == tail_id)
	 *         return NULL;
	 */
	if (r0 != 1) {
		/*
		 * Remove the node (node1) from the list.
		 *
		 * prb_reserve() ringbuffer.c:441
		 *   assign_desc() ringbuffer.c:337
		 *     numlist_pop() numlist.c:366-367
		 *
		 * r = atomic_long_cmpxchg_relaxed(&nl->tail_id,
		 *                                 tail_id, next_id);
		 */
		r0 = cmpxchg_release(numlist_tail, node1, node2);

		/*
		 * Assign the popped node (node1) a new ID.
		 *
		 * prb_reserve() ringbuffer.c:441
		 *   assign_desc() ringbuffer.c:386-387
		 *
		 * atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
		 *                         DESCS_COUNT(rb));
		 */
		smp_store_release(node1, 3);

		/*
		 * Prepare to make changes to node data.
		 *
		 * prb_reserve() ringbuffer.c:475
		 *
		 * smp_wmb();
		 */
		smp_wmb();
	}
}

exists (0:head=node1 /\ 0:id=3)
