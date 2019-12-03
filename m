Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1973DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E865C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLCIya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:54:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:51456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCIya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:54:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFB78AE64;
        Tue,  3 Dec 2019 08:54:27 +0000 (UTC)
Date:   Tue, 3 Dec 2019 09:54:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191203085426.x6n2z4iu3xpcmfr4@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
 <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
 <87sgm2fzuh.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgm2fzuh.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-12-02 17:37:26, John Ogness wrote:
> On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
> >> > +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> >> > +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
> >> > +{
> >> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> > +	struct prb_desc *desc;
> >> > +	u32 id_prev_wrap;
> >> > +	u32 head_id;
> >> > +	u32 id;
> >> > +
> >> > +	head_id = atomic_read(&desc_ring->head_id);
> >> > +
> >> > +	do {
> >> > +		desc = to_desc(desc_ring, head_id);
> >> > +
> >> > +		id = DESC_ID(head_id + 1);
> >> > +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
> >> > +
> >> > +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
> >> > +			if (!desc_push_tail(rb, id_prev_wrap))
> >> > +				return false;
> >> > +		}
> >> > +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
> >> 
> >> Hmm, in theory, ABA problem might cause that we successfully
> >> move desc_ring->head_id when tail has not been pushed yet.
> >> 
> >> As a result we would never call desc_push_tail() until
> >> it overflows again.
> >> 
> >> I am not sure if we need to take care of it. The code is called with
> >> interrupts disabled. IMHO, only NMI could cause ABA problem
> >> in reality. But the game (debugging) is lost anyway when NMI ovewrites
> >> the buffer several times.
> >
> > BTW: If I am counting correctly. The ABA problem would happen when
> > exactly 2^30 (1G) messages is written in the mean time.
> 
> All the ringbuffer code assumes that the use of index numbers handles
> the ABA problem (i.e. there must not be 1 billion printk's within an
> NMI). If we want to support 1 billion+ printk's within an NMI, then
> perhaps the index number should be increased. For 64-bit systems it
> would be no problem to go to 62 bits. For 32-bit systems, I don't know
> how well the 64-bit atomic operations are supported.

I am not super happy but I really think that it does not make sense
to complicate the code too much because of this theoretical race.

1 billion printks in NMI is crazy. Also the race is a problem only
when we hit exactly the 2^30 message. If we hit 2^30 + 1 and more
than everything is fine again.

In the worst case, printk() will stop working. I think that there
are other situations that are much more likely when printk() will
not work (people will not see the messages).


> >> Also it should not be a complete failure. We still could bail out when
> >> the previous state was not reusable. We are on the safe side
> >> when it was reusable.
> >> 
> >> Also we could probably detect when desc_ring->tail_id is not
> >> updated any longer and do something about it.
> >> 
> >> > +
> >> > +	desc = to_desc(desc_ring, id);
> >> > +
> >> > +	/* Set the descriptor's ID and also set its state to reserved. */
> >> > +	atomic_set(&desc->state_var, id | 0);
> >> 
> >> We should check here that the original state id from the previous
> >> wrap in reusable state (or 0 for bootstrap). On error, we know that
> >> there was the ABA problem and would need to do something about it.
> >
> > I believe that it should be enough to add this check and
> > bail out in case of error.
> 
> I need to go through the code again in detail and see how many locations
> are affected by ABA. All the code was written with the assumption that
> this type of ABA will not happen.
>
> As you've stated, we could add minimal handling so that the ringbuffer
> at least does not break or get stuck.
> 
> BTW: The same assumption is made for logical positions. There are 4
> times as many of these (on 32-bit systems) but logical positions advance
> much faster. I will review these as well.

The logical positions are assigned only when a descriptor is reserved.
Such a descriptor could not be reused until committed and marked
reusable. It limits the logical position movement to:

   max_record_size * number_of_descriptors

Printk records are limited to 1k. So we could safely support
up to 1 million fully sized lines printed when NMI interrupted
printk() on one CPU.

The most important thing is that it must not crash the system.
It would be nice if we are able to detect this situation and
do something about it. But IMHO, it is perfectly fine when
printk() would stop working in this corner case.

The only problem is that it might be hard to debug. But it
should be possible with crashdump. And I think that we will
first hit some other bugs that we do not see at the moment ;-)

Best Regards,
Petr
