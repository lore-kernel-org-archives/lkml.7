Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ACC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D262087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfHUFl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:41:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53711 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUFl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:41:28 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0JMx-0003X7-RM; Wed, 21 Aug 2019 07:41:15 +0200
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
Subject: Re: numlist_pop(): Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820081518.3r3cagzggtifsvhz@pathway.suse.cz>
Date:   Wed, 21 Aug 2019 07:41:13 +0200
Message-ID: <87pnkzf53a.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/numlist.c
>> +/**
>> + * numlist_pop() - Remove the oldest node from the list.
>> + *
>> + * @nl: The numbered list from which to remove the tail node.
>> + *
>> + * The tail node can only be removed if two conditions are satisfied:
>> + *
>> + * * The node is not the only node on the list.
>> + * * The node is not busy.
>> + *
>> + * If, during this function, another task removes the tail, this function
>> + * will try again with the new tail.
>> + *
>> + * Return: The removed node or NULL if the tail node cannot be removed.
>> + */
>> +struct nl_node *numlist_pop(struct numlist *nl)
>> +{
>> +	unsigned long tail_id;
>> +	unsigned long next_id;
>> +	unsigned long r;
>> +
>> +	/* cA: #1 */
>> +	tail_id = atomic_long_read(&nl->tail_id);
>> +
>> +	for (;;) {
>> +		/* cB */
>> +		while (!numlist_read(nl, tail_id, NULL, &next_id)) {
>> +			/*
>> +			 * @tail_id is invalid. Try again with an
>> +			 * updated value.
>> +			 */
>> +
>> +			cpu_relax();
>> +
>> +			/* cA: #2 */
>> +			tail_id = atomic_long_read(&nl->tail_id);
>> +		}
>
> The above while-cycle basically does the same as the upper for-cycle.
> It tries again with freshly loaded nl->tail_id. The following code
> looks easier to follow:
>
> 	do {
> 		tail_id = atomic_long_read(&nl->tail_id);
>
> 		/*
> 		 * Read might fail when the tail node has been removed
> 		 * and reused in parallel.
> 		 */
> 		if (!numlist_read(nl, tail_id, NULL, &next_id))
> 			continue;
>
> 		/* Make sure the node is not the only node on the list. */
> 		if (next_id == tail_id)
> 			return NULL;
>
> 		/* cC: Make sure the node is not busy. */
> 		if (nl->busy(tail_id, nl->busy_arg))
> 			return NULL;
>
> 	while (atomic_long_cmpxchg_relaxed(&nl->tail_id, tail_id, next_id) !=
> 			tail_id);
>
> 	/* This should never fail. The node is ours. */
> 	return nl->node(tail_id, nl->node_arg);

You will see that pattern in several cmpxchg() loops. The reason I chose
to do it that way was so that I could make use of the return value of
the failed cmpcxhg(). This avoids an unnecessary LOAD and establishes a
data dependency between the failed cmpxchg() and the following
numlist_read(). I suppose none of that matters since we only care about
the case where cmpxchg() is successful.

I agree that your variation is easier to read.

>> +		/* Make sure the node is not the only node on the list. */
>> +		if (next_id == tail_id)
>> +			return NULL;
>> +
>> +		/*
>> +		 * cC:
>> +		 *
>> +		 * Make sure the node is not busy.
>> +		 */
>> +		if (nl->busy(tail_id, nl->busy_arg))
>> +			return NULL;
>> +
>> +		r = atomic_long_cmpxchg_relaxed(&nl->tail_id,
>> +						tail_id, next_id);
>> +		if (r == tail_id)
>> +			break;
>> +
>> +		/* cA: #3 */
>> +		tail_id = r;
>> +	}
>> +
>> +	return nl->node(tail_id, nl->node_arg);
>
> If I get it correctly, the above nl->node() call should never fail.
> The node has been removed from the list and nobody else could
> touch it. It is pretty useful information and it might be worth
> mention it in a comment.

You are correct and I will add a comment.

> PS: I am scratching my head around the patchset. I'll try Peter's
> approach and comment independent things is separate mails.

I think it is an excellent approach. Especially when discussing the
memory barriers.

John Ogness
