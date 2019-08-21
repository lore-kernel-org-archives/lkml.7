Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01753C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EFD2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfHUFnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:43:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:43:06 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i0JOe-0003aJ-D2; Wed, 21 Aug 2019 07:43:00 +0200
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
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new printk ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-2-john.ogness@linutronix.de>
        <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
Date:   Wed, 21 Aug 2019 07:42:57 +0200
Message-ID: <87h86bf50e.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
>> --- /dev/null
>> +++ b/kernel/printk/dataring.c
>> +/**
>> + * _datablock_valid() - Check if given positions yield a valid data block.
>> + *
>> + * @dr:         The associated data ringbuffer.
>> + *
>> + * @head_lpos:  The newest data logical position.
>> + *
>> + * @tail_lpos:  The oldest data logical position.
>> + *
>> + * @begin_lpos: The beginning logical position of the data block to check.
>> + *
>> + * @next_lpos:  The logical position of the next adjacent data block.
>> + *              This value is used to identify the end of the data block.
>> + *
>
> Please remove the empty lines between arguments description. They make
> the comments too scattered.

Your feedback is contradicting what PeterZ requested[0]. Particularly
when multiple lines are involved with a description, I find the spacing
helpful. I've grown to like the spacing, but I won't fight for it.

>> +	/*
>> +	 * dB:
>> +	 *
>> +	 * When a writer has completed accessing its data block, it sets the
>> +	 * @id thus making the data block available for invalidation. This
>> +	 * _acquire() ensures that this task sees all data ringbuffer and
>> +	 * descriptor values seen by the writer as @id was set. This is
>> +	 * necessary to ensure that the data block can be correctly identified
>> +	 * as valid (i.e. @begin_lpos, @next_lpos, @head_lpos are at least the
>> +	 * values seen by that writer, which yielded a valid data block at
>> +	 * that time). It is not enough to rely on the address dependency of
>> +	 * @desc to @id because @head_lpos is not depedent on @id. This pairs
>> +	 * with the _release() in dataring_datablock_setid().
>
> This human readable description is really useful.
>
>> +	 *
>> +	 * Memory barrier involvement:
>> +	 *
>> +	 * If dB reads from gA, then dC reads from fG.
>> +	 * If dB reads from gA, then dD reads from fH.
>> +	 * If dB reads from gA, then dE reads from fE.
>> +	 *
>> +	 * Note that if dB reads from gA, then dC cannot read from fC.
>> +	 * Note that if dB reads from gA, then dD cannot read from fD.
>> +	 *
>> +	 * Relies on:
>> +	 *
>> +	 * RELEASE from fG to gA
>> +	 *    matching
>> +	 * ADDRESS DEP. from dB to dC
>> +	 *
>> +	 * RELEASE from fH to gA
>> +	 *    matching
>> +	 * ADDRESS DEP. from dB to dD
>> +	 *
>> +	 * RELEASE from fE to gA
>> +	 *    matching
>> +	 * ACQUIRE from dB to dE
>> +	 */
>
> But I am not sure how much this is useful.

When I was first implementing RFCv3, the "human-readable" text version
was very useful for me. However, now it is the formal descriptions that
I find more useful. They provide the proof and a far more detailed
description.

> It would take ages to decrypt all these shortcuts (signs) and
> translate them into something human readable. Also it might get
> outdated easily.
>
> That said, I haven't found yet if there was a system in all
> the shortcuts. I mean if they can be descrypted easily
> out of head. Also I am not familiar with the notation
> of the dependencies.

I'll respond to this part in Sergey's followup post.

> If this is really needed then I am really scared of some barriers
> that guard too many things. This one is a good example.
>
>> +	desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg);

The variable's value (in this case db->id) is doing the guarding. The
barriers ensure that db->id is read first (and set last).

>> +
>> +	/* dD: */
>
> It would be great if all these shortcuts (signs) are followed with
> something human readable. Few words might be enough.

I'll respond to this part in Sergey's followup post.

>> +	next_lpos = READ_ONCE(desc->next_lpos);
>> +
>> +	if (!_datablock_valid(dr,
>> +			      /* dE: */
>> +			      atomic_long_read(&dr->head_lpos),
>> +			      tail_lpos, begin_lpos, next_lpos)) {
>> +		/* Another task has already invalidated the data block. */
>> +		goto out;
>> +	}
>> +
>> +
>> +++ b/kernel/printk/numlist.c
>> +bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
>> +		  unsigned long *next_id)
>> +
>> +	struct nl_node *n;
>> +
>> +	n = nl->node(id, nl->node_arg);
>> +	if (!n)
>> +		return false;
>> +
>> +	if (seq) {
>> +		/*
>> +		 * aA:
>> +		 *
>> +		 * Adresss dependency on @id.
>> +		 */
>
> This is too scattered. If we really need so many shortcuts (signs)
> then we should find a better style. The following looks perfectly
> fine to me:
>
> 		/* aA: Adresss dependency on @id. */

I'll respond to this part in Sergey's followup post.

>> +		*seq = READ_ONCE(n->seq);
>> +	}
>> +
>> +	if (next_id) {
>> +		/*
>> +		 * aB:
>> +		 *
>> +		 * Adresss dependency on @id.
>> +		 */
>> +		*next_id = READ_ONCE(n->next_id);
>> +	}
>> +

John Ogness

[0] https://lkml.kernel.org/r/20190618111215.GO3436@hirez.programming.kicks-ass.net
