Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06FC3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2C22DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfHTIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728545AbfHTIz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAEA6ABC4;
        Tue, 20 Aug 2019 08:55:54 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:55:54 +0200
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
Subject: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
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
> +++ b/kernel/printk/dataring.c
> +/**
> + * _datablock_valid() - Check if given positions yield a valid data block.
> + *
> + * @dr:         The associated data ringbuffer.
> + *
> + * @head_lpos:  The newest data logical position.
> + *
> + * @tail_lpos:  The oldest data logical position.
> + *
> + * @begin_lpos: The beginning logical position of the data block to check.
> + *
> + * @next_lpos:  The logical position of the next adjacent data block.
> + *              This value is used to identify the end of the data block.
> + *

Please remove the empty lines between arguments description. They make
the comments too scattered.

> + * A data block is considered valid if it satisfies the two conditions:
> + *
> + * * tail_lpos <= begin_lpos < next_lpos <= head_lpos
> + * * tail_lpos is at most exactly 1 wrap behind head_lpos
> + *
> + * Return: true if the specified data block is valid.
> + */

To be sure, the empty lines between paragraphs are useful.
The following is still well readable:

/**
 * _datablock_valid() - Check if given positions yield a valid data block.
 * @dr:         The associated data ringbuffer.
 * @head_lpos:  The newest data logical position.
 * @tail_lpos:  The oldest data logical position.
 * @begin_lpos: The beginning logical position of the data block to check.
 * @next_lpos:  The logical position of the next adjacent data block.
 *              This value is used to identify the end of the data block.

 * A data block is considered valid if it satisfies the two conditions:
 *
 * * tail_lpos <= begin_lpos < next_lpos <= head_lpos
 * * tail_lpos is at most exactly 1 wrap behind head_lpos
 *
 * Return: true if the specified data block is valid.
 */

> +static unsigned long _dataring_pop(struct dataring *dr,
> +				   unsigned long tail_lpos)
> +{
> +	unsigned long new_tail_lpos;
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +	struct dr_datablock *db;
> +	struct dr_desc *desc;
> +
> +	/*
> +	 * dA:
> +	 *
> +	 * @db has an address dependency on @tail_pos. Therefore @tail_lpos
> +	 * must be loaded before dB, which accesses @db.
> +	 */
> +	db = to_datablock(dr, tail_lpos);
> +
> +	/*
> +	 * dB:
> +	 *
> +	 * When a writer has completed accessing its data block, it sets the
> +	 * @id thus making the data block available for invalidation. This
> +	 * _acquire() ensures that this task sees all data ringbuffer and
> +	 * descriptor values seen by the writer as @id was set. This is
> +	 * necessary to ensure that the data block can be correctly identified
> +	 * as valid (i.e. @begin_lpos, @next_lpos, @head_lpos are at least the
> +	 * values seen by that writer, which yielded a valid data block at
> +	 * that time). It is not enough to rely on the address dependency of
> +	 * @desc to @id because @head_lpos is not depedent on @id. This pairs
> +	 * with the _release() in dataring_datablock_setid().

This human readable description is really useful.

> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If dB reads from gA, then dC reads from fG.
> +	 * If dB reads from gA, then dD reads from fH.
> +	 * If dB reads from gA, then dE reads from fE.
> +	 *
> +	 * Note that if dB reads from gA, then dC cannot read from fC.
> +	 * Note that if dB reads from gA, then dD cannot read from fD.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * RELEASE from fG to gA
> +	 *    matching
> +	 * ADDRESS DEP. from dB to dC
> +	 *
> +	 * RELEASE from fH to gA
> +	 *    matching
> +	 * ADDRESS DEP. from dB to dD
> +	 *
> +	 * RELEASE from fE to gA
> +	 *    matching
> +	 * ACQUIRE from dB to dE
> +	 */

But I am not sure how much this is useful. It would take ages to decrypt
all these shortcuts (signs) and translate them into something
human readable. Also it might get outdated easily.

That said, I haven't found yet if there was a system in all
the shortcuts. I mean if they can be descrypted easily
out of head. Also I am not familiar with the notation
of the dependencies.

If this is really needed then I am really scared of some barriers
that guard too many things. This one is a good example.

> +	desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg);
> +
> +	/* dD: */

It would be great if all these shortcuts (signs) are followed with
something human readable. Few words might be enough.

> +	next_lpos = READ_ONCE(desc->next_lpos);
> +
> +	if (!_datablock_valid(dr,
> +			      /* dE: */
> +			      atomic_long_read(&dr->head_lpos),
> +			      tail_lpos, begin_lpos, next_lpos)) {
> +		/* Another task has already invalidated the data block. */
> +		goto out;
> +	}
> +
> +
> +++ b/kernel/printk/numlist.c
> +bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
> +		  unsigned long *next_id)
> +{
> +	struct nl_node *n;
> +
> +	n = nl->node(id, nl->node_arg);
> +	if (!n)
> +		return false;
> +
> +	if (seq) {
> +		/*
> +		 * aA:
> +		 *
> +		 * Adresss dependency on @id.
> +		 */

This is too scattered. If we really need so many shortcuts (signs)
then we should find a better style. The following looks perfectly
fine to me:

		/* aA: Adresss dependency on @id. */
> +		*seq = READ_ONCE(n->seq);
> +	}
> +
> +	if (next_id) {
> +		/*
> +		 * aB:
> +		 *
> +		 * Adresss dependency on @id.
> +		 */
> +		*next_id = READ_ONCE(n->next_id);
> +	}
> +

Best Regards,
Petr
