Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C985721881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfH0Ogz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728702AbfH0Ogj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:36:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0FE5ACC1;
        Tue, 27 Aug 2019 14:36:36 +0000 (UTC)
Date:   Tue, 27 Aug 2019 16:36:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dataring_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190827143635.4taqjj6wjz7gdlea@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
 <20190820135004.7vatbrzphfsgsnw2@pathway.suse.cz>
 <87r25aklsy.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r25aklsy.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2019-08-25 04:42:37, John Ogness wrote:
> On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
> >> +/**
> >> + * dataring_push() - Reserve a data block in the data array.
> >> + *
> >> + * @dr:   The data ringbuffer to reserve data in.
> >> + *
> >> + * @size: The size to reserve.
> >> + *
> >> + * @desc: A pointer to a descriptor to store the data block information.
> >> + *
> >> + * @id:   The ID of the descriptor to be associated.
> >> + *        The data block will not be set with @id, but rather initialized with
> >> + *        a value that is explicitly different than @id. This is to handle the
> >> + *        case when newly available garbage by chance matches the descriptor
> >> + *        ID.
> >> + *
> >> + * This function expects to move the head pointer forward. If this would
> >> + * result in overtaking the data array index of the tail, the tail data block
> >> + * will be invalidated.
> >> + *
> >> + * Return: A pointer to the reserved writer data, otherwise NULL.
> >> + *
> >> + * This will only fail if it was not possible to invalidate the tail data
> >> + * block.
> >> + */
> >> +char *dataring_push(struct dataring *dr, unsigned int size,
> >> +		    struct dr_desc *desc, unsigned long id)
> >> +{
> >> +	unsigned long begin_lpos;
> >> +	unsigned long next_lpos;
> >> +	struct dr_datablock *db;
> >> +	bool ret;
> >> +
> >> +	to_db_size(&size);
> >> +
> >> +	do {
> >> +		/* fA: */
> >> +		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
> >> +
> >> +		/*
> >> +		 * fB:
> >> +		 *
> >> +		 * The data ringbuffer tail may have been pushed (by this or
> >> +		 * any other task). The updated @tail_lpos must be visible to
> >> +		 * all observers before changes to @begin_lpos, @next_lpos, or
> >> +		 * @head_lpos by this task are visible in order to allow other
> >> +		 * tasks to recognize the invalidation of the data
> >> +		 * blocks.
> >
> > This sounds strange. The write barrier should be done only on CPU
> > that really modified tail_lpos. I.e. it should be in _dataring_pop()
> > after successful dr->tail_lpos modification.
> 
> The problem is that there are no data dependencies between the different
> variables. When a new datablock is being reserved, it is critical that
> all other observers see that the tail_lpos moved forward _before_ any
> other changes. _dataring_pop() uses an smp_rmb() to synchronize for
> tail_lpos movement.

It should be symmetric. It makes sense that _dataring_pop() uses an
smp_rmb(). Then there should be wmb() in dataring_push().

The wmb() should be done only by the CPU that actually did the write.
And it should be done after the write. This is why I suggested to
do it after cmpxchg(dr->head_lpos).

> This CPU is about to make some changes and may have
> seen an updated tail_lpos. An smp_wmb() is useless if this is not the
> CPU that performed that update. The full memory barrier ensures that all
> other observers will see what this CPU sees before any of its future
> changes are seen.

I do not understand it. Full memory barrier will not cause that all
CPUs will see the same.

My understanding of barriers is:

   + wmb() is needed after some value is modified and any following
     modifications must be done later.

   + rmb() is needed when a value has to be read before the other
     values are read.

These barriers need to be symmetric. The reader will see the values
in the right order only when both the writer and the reader use
the right barriers.

    + wmb() full barrier is needed around some critical section
      to make sure that all operations happened inside the section


Back to our situation:

    + rmb() should not be needed here because get_new_lpos() provided
      a valid lpos.

      It is possible that get_new_lpos() used rmb() to make sure
      that there was enough space. But such wmb() would be
      between reading dr->tail_lpos and dr->head_lpos. No
      other rmb() is needed once the check passed.

    + wmb() is not needed because we have not written anything yet

If there was a race with another CPU than cmpxchg(dr->head_lpos)
would fail and we will need to repeat everything again.

> >> +	/* fE: */
> >> +	} while (atomic_long_cmpxchg_relaxed(&dr->head_lpos, begin_lpos,
> >> +					     next_lpos) != begin_lpos);
> >> +
> >
> > We need a write barrier here to make sure that dr->head_lpos
> > is updated before we start updating other values, e.g.
> > db->id below.
> 
> My RFCv2 implemented it that way. The function was called data_reserve()
> and it moved the head using cmpxchg_release(). For RFCv3 I changed to a
> full memory barrier instead because using acquire/release here is a bit
> messy. There are 2 different places where the acquire needed to be:
> 
> - In _dataring_pop() a load_acquire() of head_lpos would need to be
>   _before_ loading of begin_lpos and next_lpos.
> 
> - In prb_iter_next_valid_entry() a load_acquire() of head_lpos would
>   need to be at the beginning within the dataring_datablock_isvalid()
>   check (mC).
> 
> If smp_mb() is too heavy to call for every printk(), then we can move to
> acquire/release. The comments of fB list exactly what is synchronized
> (and where).

smp_mb() is not a problem. printk() is a slow path.

My problem is that I want to make sure that the code works as
expected. For this, I want to understand the used barriers.
And the discussed full barrier in dataring_push() does not make
sense to me.

Best Regards,
Petr
