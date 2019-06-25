Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0674C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2016214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO3l1E7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfFYIzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:55:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34678 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbfFYIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:55:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so8477636plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IzEucIG54RmCyKHNUFpI/gXT16OQrPA9k18KegFQh4=;
        b=EO3l1E7x1mMuMayS9FO0D6d2bRbRNDKZRvMX/rPQnRqccWt+GtKsk3FuusXMkc3URA
         DnB9oA01u1WluZXmCdTzBipssgWFyA2lSgLLE3XGF5I0dSHZXfg43pMyji9y5isEnZQ4
         XWY8X7dxUtQmMXDm11+Scn/qfwHiVRks4+slosnPWPquEaIzqZzAQZ2oFZ4/lmhQtAnI
         GAylyAGOgBdlwCl+jN0n3L2soEiQwl9frqHlNoxi014VoG2qF8bJB+r66slh0NEAVMeF
         7KOkZu0IVqDLtELToKKjkB0Rw7CO8q2r/FGT/cG94Go603d+F4seCJMcugx2Rh9GiHcl
         1upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IzEucIG54RmCyKHNUFpI/gXT16OQrPA9k18KegFQh4=;
        b=lo9lloF5a0fWOHOHXhi8KU8rKVmfMISdHCR9ZGfLEEczVATbkugNQJWd81wAAGNwZO
         DCCLx47xglefboRvjDw4bSSvhhAWB/gtvzKgB//FSY0PwG62zl7ZmCIjpX7aP0V2EJ0Q
         Y+VF5uWEyGCrqKrvCZisvLgDM3J1a+VRcNOJzd++tRNuA2rDODp81JcFk3ZNBso4/e6X
         o59WrVGnemwjjXLFm7A9emMqNOiS8vpMDRkml52tYIPAXpxapNziWej4GAcWpEV1nAMi
         7GrxkXMWG2G/tuqKBG3bU8hxN5sD5IbnfzgCNR+6hO0uWpubti08TDHbSs9BESjIo7Xv
         OexA==
X-Gm-Message-State: APjAAAWAOpN0FI0DCzCg7qHEiovkcoYRJqR3qSBknVA+DQOQHbyFk2LV
        9HHbq9FYr8kkXsoNyU+6TDw=
X-Google-Smtp-Source: APXvYqwCyQGa5cQvhhE258d2uOknwV0ovFPxPJQB0IR6EXa3DE+qIKDGPik6Rks2qO4/9qV3l3NLcg==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr146290242plw.13.1561452952337;
        Tue, 25 Jun 2019 01:55:52 -0700 (PDT)
Received: from localhost ([175.223.22.38])
        by smtp.gmail.com with ESMTPSA id j13sm13725770pfh.13.2019.06.25.01.55.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:55:51 -0700 (PDT)
Date:   Tue, 25 Jun 2019 17:55:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625085548.GA532@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/07/19 18:29), John Ogness wrote:
[..]
> +static void add_descr_list(struct prb_reserved_entry *e)
> +{
> +	struct printk_ringbuffer *rb = e->rb;
> +	struct prb_list *l = &rb->descr_list;
> +	struct prb_descr *d = e->descr;
> +	struct prb_descr *newest_d;
> +	unsigned long newest_id;
> +
> +	/* set as newest */
> +	do {
> +		/* MB5: synchronize add descr */
> +		newest_id = smp_load_acquire(&l->newest);
> +		newest_d = TO_DESCR(rb, newest_id);
> +
> +		if (newest_id == EOL)
> +			WRITE_ONCE(d->seq, 1);
> +		else
> +			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
> +		/*
> +		 * MB5: synchronize add descr
> +		 *
> +		 * In particular: next written before cmpxchg
> +		 */
> +	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
> +
> +	if (unlikely(newest_id == EOL)) {
> +		/* no previous newest means we *are* the list, set oldest */
> +
> +		/*
> +		 * MB UNPAIRED
> +		 *
> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
> +		 */
> +		WARN_ON_ONCE(cmpxchg_release(&l->oldest, EOL, e->id) != EOL);
> +	} else {
> +		/* link to previous chain */
> +
> +		/*
> +		 * MB6: synchronize link descr
> +		 *
> +		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
> +		 */
> +		WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
> +					     EOL, e->id) != EOL);
> +	}
> +}

[..]

> +char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> +		  unsigned int size)
> +{
> +	struct prb_datablock *b;
> +	struct prb_descr *d;
> +	char *buf;
> +
> +	if (size == 0)
> +		return NULL;
> +
> +	size += sizeof(struct prb_datablock);
> +	size = DATA_ALIGN_SIZE(size);
> +	if (size > DATAARRAY_SIZE(rb))
> +		return NULL;
> +
> +	e->rb = rb;
> +
> +	local_irq_save(e->irqflags);
> +
> +	if (!assign_descr(e))
> +		goto err_out;
> +
> +	d = e->descr;
> +	WRITE_ONCE(d->id, e->id);
> +
> +	if (!data_reserve(e, size)) {
> +		/* put invalid descriptor on list, can still be traversed */
> +		WRITE_ONCE(d->next, EOL);
> +		add_descr_list(e);
> +		goto err_out;
> +	}

I'm wondering if prb can always report about its problems. Including the
cases when things "go rather bad".

Suppose we have

	printk()
	 prb_reserve()
	  !data_reserve()
	    add_descr_list()
	     WARN_ON_ONCE()
	      printk()
	       prb_reserve()
	        !assign_descr(e)   << lost WARN_ON's "printk" or "printks"?

In general, assuming that there might be more error printk-s either
called directly directly from prb->printk on indirectly, from
prb->ABC->printk.

Also note,
Lost printk-s are not going to be accounted as 'lost' automatically.
It seems that for printk() there is no way to find out that it has
recursed from printk->prb_commit but hasn't succeeded in storing
recursive messages. I'd say that prb_reserve() err_out should probably
&rb->lost++.

	-ss
