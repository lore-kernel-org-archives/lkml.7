Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F88C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCBD20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfH0O3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:29:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43924 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0O3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:29:02 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i2cSv-0008F8-6h; Tue, 27 Aug 2019 16:28:57 +0200
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
Date:   Tue, 27 Aug 2019 16:28:55 +0200
Message-ID: <87mufuvg0o.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27, Petr Mladek <pmladek@suse.com> wrote:
>> On 2019-08-23, Petr Mladek <pmladek@suse.com> wrote:
>>>> --- /dev/null
>>>> +++ b/kernel/printk/numlist.c
>>>> +void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
>>>> +{
> [...]
>>>> +
>>>> +	/* bB: #1 */
>>>> +	head_id = atomic_long_read(&nl->head_id);
>>>> +
>>>> +	for (;;) {
>>>> +		/* bC: */
>>>> +		while (!numlist_read(nl, head_id, &seq, NULL)) {
>>>> +			/*
>>>> +			 * @head_id is invalid. Try again with an
>>>> +			 * updated value.
>>>> +			 */
>>>> +
>>>> +			cpu_relax();
>>>
>>> I have got very confused by this. cpu_relax() suggests that this
>>> cycle is busy waiting until a particular node becomes valid.
>>> My first though was that it must cause deadlock in NMI when
>>> the interrupted code is supposed to make the node valid.
>>>
>>> But it is the other way. The head is always valid when it is
>>> added to the list. It might become invalid when another CPU
>>> moves the head and the old one gets reused.
>>>
>>> Anyway, I do not see any reason for cpu_relax() here.
>> 
>> You are correct. The cpu_relax() should not be there. But there is
>> still an issue that this could spin hard if the head was recycled and
>> this CPU does not yet see the new head value.
>
> I do not understand this. The head could get reused only after
> head_id was replaced with the following valid node.
> The next cycle is done with a new id that should be valid.
>
> Of course, the new ID might get reused as well. But then we just
> repeat the cycle. We have to be able to find a valid head after
> few cycles. The last valid ID could not get reused because nodes
> can be removed only if was not the last valid node.

Sorry, I was not very precise with my language. I will try again...

nl->head_id is read using a relaxed read. A second CPU may have added
new nodes and removed/recycled the node with the ID that the first CPU
read as the head.

As a result, the first CPU's numlist_read() will (correctly) fail. If
numlist_read() failed in the first node() callback within numlist_read()
(i.e. it sees that the node already has a new ID), there is no guarantee
that rereading the head ID will provide a new ID. At some point the
memory system would make the new head ID visible, but there could be
some heavy spinning until that happens.

Here is a litmus test showing the problem (using comments and verbose
variable names):

C numlist_push_loop

{
	int node1 = 1;
	int node2 = 2;
	int *numlist_head = &node1;
}

P0(int **numlist_head)
{
	int *head;
	int id;

	// read head ID
	head = READ_ONCE(*numlist_head);

	// read head node ID
	id = READ_ONCE(*head);

	// re-read head ID when node ID is unexpected
	head = READ_ONCE(*numlist_head);
}

P1(int **numlist_head, int *node1, int *node2)
{
	int *r0;

	// push node2
	r0 = cmpxchg_release(numlist_head, node1, node2);

	// pop node1, reassigning a new ID
	smp_store_release(node1, 3);
}

exists (0:head=node1 /\ 0:id=3)

$ herd7 -conf linux-kernel.cfg numlist_push_loop.litmus 
Test numlist_push_loop Allowed
States 5
0:head=node1; 0:id=1;
0:head=node1; 0:id=3;
0:head=node2; 0:id=1;
0:head=node2; 0:id=2;
0:head=node2; 0:id=3;
Ok
Witnesses
Positive: 1 Negative: 4
Condition exists (0:head=node1 /\ 0:id=3)
Observation numlist_push_loop Sometimes 1 4
Time numlist_push_loop 0.01
Hash=27b10efb171ab4cf390bd612a9e79bf0

The results show that P0 sees the head is node1 but also sees that
node1's ID has changed. (And if node1's ID changed, it means P1 had
previously replaced the head.) If P0 ran in a while-loop, at some point
it _would_ see that node2 is now the head. But that is wasteful spinning
and may possibly have negative influence on the memory system.

>> To handle that, and in preparation for my next version, I'm now using
>> a read_acquire() to load the ID in the node() callback (matching the
>> set_release() in assign_desc()). This ensures that if numlist_read()
>> fails, the new head will be visible.
>
> I do not understand this either. The above paragraph seems to
> describe a race. I do not see how it could cause an infinite loop.

It isn't an infinite loop. It is burning some/many CPU cycles.

By changing P0's ID read to:

    id = smp_load_acquire(head);

the results change to:

$ herd7 -conf linux-kernel.cfg numlist_push_loop.litmus 
Test numlist_push_loop Allowed
States 4
0:head=node1; 0:id=1;
0:head=node2; 0:id=1;
0:head=node2; 0:id=2;
0:head=node2; 0:id=3;
No
Witnesses
Positive: 0 Negative: 4
Condition exists (0:head=node1 /\ 0:id=3)
Observation numlist_push_loop Never 0 4
Time numlist_push_loop 0.01
Hash=3eb63ea3bec59f8941f61faddb5499da

Meaning that if a new ID is seen, a new head ID is also visible.

Loading the ID is what the node() callback does, and the ACQUIRE pairs
with the set_release() in assign_desc(). Both in ringbuffer.c.

John Ogness
