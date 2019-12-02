Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9403AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E32071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfLBQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:37:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:37:44 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ibohU-00030f-Dp; Mon, 02 Dec 2019 17:37:28 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
        <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
Date:   Mon, 02 Dec 2019 17:37:26 +0100
In-Reply-To: <20191202155955.meawljmduiciw5t2@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 2 Dec 2019 16:59:55 +0100")
Message-ID: <87sgm2fzuh.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
>> > +/* Reserve a new descriptor, invalidating the oldest if necessary. */
>> > +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
>> > +{
>> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
>> > +	struct prb_desc *desc;
>> > +	u32 id_prev_wrap;
>> > +	u32 head_id;
>> > +	u32 id;
>> > +
>> > +	head_id = atomic_read(&desc_ring->head_id);
>> > +
>> > +	do {
>> > +		desc = to_desc(desc_ring, head_id);
>> > +
>> > +		id = DESC_ID(head_id + 1);
>> > +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
>> > +
>> > +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
>> > +			if (!desc_push_tail(rb, id_prev_wrap))
>> > +				return false;
>> > +		}
>> > +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
>> 
>> Hmm, in theory, ABA problem might cause that we successfully
>> move desc_ring->head_id when tail has not been pushed yet.
>> 
>> As a result we would never call desc_push_tail() until
>> it overflows again.
>> 
>> I am not sure if we need to take care of it. The code is called with
>> interrupts disabled. IMHO, only NMI could cause ABA problem
>> in reality. But the game (debugging) is lost anyway when NMI ovewrites
>> the buffer several times.
>
> BTW: If I am counting correctly. The ABA problem would happen when
> exactly 2^30 (1G) messages is written in the mean time.

All the ringbuffer code assumes that the use of index numbers handles
the ABA problem (i.e. there must not be 1 billion printk's within an
NMI). If we want to support 1 billion+ printk's within an NMI, then
perhaps the index number should be increased. For 64-bit systems it
would be no problem to go to 62 bits. For 32-bit systems, I don't know
how well the 64-bit atomic operations are supported.

>> Also it should not be a complete failure. We still could bail out when
>> the previous state was not reusable. We are on the safe side
>> when it was reusable.
>> 
>> Also we could probably detect when desc_ring->tail_id is not
>> updated any longer and do something about it.
>> 
>> > +
>> > +	desc = to_desc(desc_ring, id);
>> > +
>> > +	/* Set the descriptor's ID and also set its state to reserved. */
>> > +	atomic_set(&desc->state_var, id | 0);
>> 
>> We should check here that the original state id from the previous
>> wrap in reusable state (or 0 for bootstrap). On error, we know that
>> there was the ABA problem and would need to do something about it.
>
> I believe that it should be enough to add this check and
> bail out in case of error.

I need to go through the code again in detail and see how many locations
are affected by ABA. All the code was written with the assumption that
this type of ABA will not happen.

As you've stated, we could add minimal handling so that the ringbuffer
at least does not break or get stuck.

BTW: The same assumption is made for logical positions. There are 4
times as many of these (on 32-bit systems) but logical positions advance
much faster. I will review these as well.

John Ogness
