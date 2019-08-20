Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEBA23777
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfHTIPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:15:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729150AbfHTIPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:15:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8DF7AEA1;
        Tue, 20 Aug 2019 08:15:19 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:15:18 +0200
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
Subject: numlist_pop(): Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190820081518.3r3cagzggtifsvhz@pathway.suse.cz>
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
> + * numlist_pop() - Remove the oldest node from the list.
> + *
> + * @nl: The numbered list from which to remove the tail node.
> + *
> + * The tail node can only be removed if two conditions are satisfied:
> + *
> + * * The node is not the only node on the list.
> + * * The node is not busy.
> + *
> + * If, during this function, another task removes the tail, this function
> + * will try again with the new tail.
> + *
> + * Return: The removed node or NULL if the tail node cannot be removed.
> + */
> +struct nl_node *numlist_pop(struct numlist *nl)
> +{
> +	unsigned long tail_id;
> +	unsigned long next_id;
> +	unsigned long r;
> +
> +	/* cA: #1 */
> +	tail_id = atomic_long_read(&nl->tail_id);
> +
> +	for (;;) {
> +		/* cB */
> +		while (!numlist_read(nl, tail_id, NULL, &next_id)) {
> +			/*
> +			 * @tail_id is invalid. Try again with an
> +			 * updated value.
> +			 */
> +
> +			cpu_relax();
> +
> +			/* cA: #2 */
> +			tail_id = atomic_long_read(&nl->tail_id);
> +		}

The above while-cycle basically does the same as the upper for-cycle.
It tries again with freshly loaded nl->tail_id. The following code
looks easier to follow:

	do {
		tail_id = atomic_long_read(&nl->tail_id);

		/*
		 * Read might fail when the tail node has been removed
		 * and reused in parallel.
		 */
		if (!numlist_read(nl, tail_id, NULL, &next_id))
			continue;

		/* Make sure the node is not the only node on the list. */
		if (next_id == tail_id)
			return NULL;

		/* cC: Make sure the node is not busy. */
		if (nl->busy(tail_id, nl->busy_arg))
			return NULL;

	while (atomic_long_cmpxchg_relaxed(&nl->tail_id, tail_id, next_id) !=
			tail_id);

	/* This should never fail. The node is ours. */
	return nl->node(tail_id, nl->node_arg);


> +		/* Make sure the node is not the only node on the list. */
> +		if (next_id == tail_id)
> +			return NULL;
> +
> +		/*
> +		 * cC:
> +		 *
> +		 * Make sure the node is not busy.
> +		 */
> +		if (nl->busy(tail_id, nl->busy_arg))
> +			return NULL;
> +
> +		r = atomic_long_cmpxchg_relaxed(&nl->tail_id,
> +						tail_id, next_id);
> +		if (r == tail_id)
> +			break;
> +
> +		/* cA: #3 */
> +		tail_id = r;
> +	}
> +
> +	return nl->node(tail_id, nl->node_arg);

If I get it correctly, the above nl->node() call should never fail.
The node has been removed from the list and nobody else could
touch it. It is pretty useful information and it might be worth
mention it in a comment.

Best Regards,
Petr

PS: I am scratching my head around the patchset. I'll try Peter's
approach and comment independent things is separate mails.
