Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152D420674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLDMyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:54:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:36264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfLDMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:54:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29F11B202;
        Wed,  4 Dec 2019 12:54:52 +0000 (UTC)
Date:   Wed, 4 Dec 2019 13:54:50 +0100
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
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer
 implementation (reader)
Message-ID: <20191204125450.ob5b7xi3gevor4qz@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
 <20191203120622.zux33do54rmjafns@pathway.suse.cz>
 <87pnh5bjz4.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnh5bjz4.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-12-03 14:46:07, John Ogness wrote:
> On 2019-12-03, Petr Mladek <pmladek@suse.com> wrote:
> >> Add the reader implementation for the new ringbuffer.
> >> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >> ---
> >>  kernel/printk/printk_ringbuffer.c | 234 ++++++++++++++++++++++++++++++
> >>  kernel/printk/printk_ringbuffer.h |  12 +-
> >>  2 files changed, 245 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> index 09c32e52fd40..f85762713583 100644
> >> --- a/kernel/printk/printk_ringbuffer.c
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> @@ -674,3 +674,237 @@ void prb_commit(struct prb_reserved_entry *e)
> >>  	local_irq_restore(e->irqflags);
> >>  }
> >>  EXPORT_SYMBOL(prb_commit);
> >> +
> >> +/*
> >> + * Given @blk_lpos, return a pointer to the raw data from the data block
> >> + * and calculate the size of the data part. A NULL pointer is returned
> >> + * if @blk_lpos specifies values that could never be legal.
> >> + *
> >> + * This function (used by readers) performs strict validation on the lpos
> >> + * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
> >> + * triggered if an internal error is detected.
> >> + */
> >> +static char *get_data(struct prb_data_ring *data_ring,
> >> +		      struct prb_data_blk_lpos *blk_lpos,
> >> +		      unsigned long *data_size)
> >> +{
> >> +	struct prb_data_block *db;
> >> +
> >> +	if (blk_lpos->begin == INVALID_LPOS &&
> >> +	    blk_lpos->next == INVALID_LPOS) {
> >> +		/* descriptor without a data block */
> >> +		return NULL;
> >> +	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
> >> +		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> >> +		/* regular data block */
> >> +		if (WARN_ON_ONCE(blk_lpos->next <= blk_lpos->begin))
> >> +			return NULL;
> >> +		db = to_block(data_ring, blk_lpos->begin);
> >> +		*data_size = blk_lpos->next - blk_lpos->begin;
> >> +
> >> +	} else if ((DATA_WRAPS(data_ring, blk_lpos->begin) + 1 ==
> >> +		    DATA_WRAPS(data_ring, blk_lpos->next)) ||
> >> +		   ((DATA_WRAPS(data_ring, blk_lpos->begin) ==
> >> +		     DATA_WRAPS(data_ring, -1UL)) &&
> >> +		    (DATA_WRAPS(data_ring, blk_lpos->next) == 0))) {
> >
> > I am a bit confused. I would expect that (-1UL + 1) = 0. So the second
> > condition after || looks just like a special variant of the first
> > valid condition.
> >
> > Or do I miss anything? Is there a problems with type casting?
> 
> Sorry, this code deserves a comment.
> 
> Here we are only comparing the number of wraps. For a wrapping data
> block, @begin will be 1 wrap less than @next. The first part of the
> check is checking the typical case, making sure that:
> 
>    1 + WRAPS(@begin) == WRAPS(@next)
> 
> There is also the case when the lpos overflows. In that case the number
> of wraps starts over at zero (without having overflowed). (Note: The
> lpos overflows, _not_ the number of wraps. This is why the first check
> is not enough.) In this case, the number of wraps of the highest
> possible lpos value (-1UL) should be the same as the number of wraps of
> @begin. And the number of wraps of @next should be 0. The simplified
> pseudo-code check is:
> 
>    WRAPS(@begin) == WRAPS(-1UL)
>       &&
>    WRAPS(@next) == 0

Got it. I knew that it must have been something like this but I did
not see it.

I wonder if the following might be easier to understand even for
people like me ;-)

	} else if (DATA_WRAPS(data_ring, blk_lpos->begin + DATA_SIZE(data_ring)) ==
		    DATA_WRAPS(data_ring, blk_lpos->next)) {

Best Regards,
Petr
