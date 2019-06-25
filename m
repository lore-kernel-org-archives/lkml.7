Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9178C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ED0208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfFYJTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:19:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFYJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:19:37 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hfhbT-0001K7-LU; Tue, 25 Jun 2019 11:19:03 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190625085548.GA532@jagdpanzerIV>
Date:   Tue, 25 Jun 2019 11:19:02 +0200
In-Reply-To: <20190625085548.GA532@jagdpanzerIV> (Sergey Senozhatsky's message
        of "Tue, 25 Jun 2019 17:55:48 +0900")
Message-ID: <87blymhvjt.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> [..]
>> +static void add_descr_list(struct prb_reserved_entry *e)
>> +{
>> +	struct printk_ringbuffer *rb = e->rb;
>> +	struct prb_list *l = &rb->descr_list;
>> +	struct prb_descr *d = e->descr;
>> +	struct prb_descr *newest_d;
>> +	unsigned long newest_id;
>> +
>> +	/* set as newest */
>> +	do {
>> +		/* MB5: synchronize add descr */
>> +		newest_id = smp_load_acquire(&l->newest);
>> +		newest_d = TO_DESCR(rb, newest_id);
>> +
>> +		if (newest_id == EOL)
>> +			WRITE_ONCE(d->seq, 1);
>> +		else
>> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
>> +		/*
>> +		 * MB5: synchronize add descr
>> +		 *
>> +		 * In particular: next written before cmpxchg
>> +		 */
>> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
>> +
>> +	if (unlikely(newest_id == EOL)) {
>> +		/* no previous newest means we *are* the list, set oldest */
>> +
>> +		/*
>> +		 * MB UNPAIRED
>> +		 *
>> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
>> +		 */
>> +		WARN_ON_ONCE(cmpxchg_release(&l->oldest, EOL, e->id) != EOL);

This WARN_ON_ONCE...

>> +	} else {
>> +		/* link to previous chain */
>> +
>> +		/*
>> +		 * MB6: synchronize link descr
>> +		 *
>> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
>> +		 */
>> +		WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
>> +					     EOL, e->id) != EOL);

... and this WARN_ON_ONCE should both really be BUG_ON. These situations
will not happen. Actually, they should both be xchg_release(). But until
everyone is happy with the memory barriers, I wanted to leave this bug
checking in place.

>> +	}
>> +}
>
> [..]
>
>> +char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>> +		  unsigned int size)
>> +{
>> +	struct prb_datablock *b;
>> +	struct prb_descr *d;
>> +	char *buf;
>> +
>> +	if (size == 0)
>> +		return NULL;
>> +
>> +	size += sizeof(struct prb_datablock);
>> +	size = DATA_ALIGN_SIZE(size);
>> +	if (size > DATAARRAY_SIZE(rb))
>> +		return NULL;
>> +
>> +	e->rb = rb;
>> +
>> +	local_irq_save(e->irqflags);
>> +
>> +	if (!assign_descr(e))
>> +		goto err_out;
>> +
>> +	d = e->descr;
>> +	WRITE_ONCE(d->id, e->id);
>> +
>> +	if (!data_reserve(e, size)) {
>> +		/* put invalid descriptor on list, can still be traversed */
>> +		WRITE_ONCE(d->next, EOL);
>> +		add_descr_list(e);
>> +		goto err_out;
>> +	}
>
> I'm wondering if prb can always report about its problems. Including the
> cases when things "go rather bad".
>
> Suppose we have
>
> 	printk()
> 	 prb_reserve()
> 	  !data_reserve()
> 	    add_descr_list()
> 	     WARN_ON_ONCE()
> 	      printk()
> 	       prb_reserve()
> 	        !assign_descr(e)   << lost WARN_ON's "printk" or "printks"?
>
> In general, assuming that there might be more error printk-s either
> called directly directly from prb->printk on indirectly, from
> prb->ABC->printk.
>
> Also note,
> Lost printk-s are not going to be accounted as 'lost' automatically.
> It seems that for printk() there is no way to find out that it has
> recursed from printk->prb_commit but hasn't succeeded in storing
> recursive messages. I'd say that prb_reserve() err_out should probably
> &rb->lost++.

This is a good point. I have no problems with that. In that case, it
should probably be called "fail" instead of "lost".

John Ogness
