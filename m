Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8397DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611C20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csGHgfyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLIJDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:03:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43528 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:03:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so6764553pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 01:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h04+/kyq65eedtQzdgewP9Eey1SBByTI6ESOC8A2z5w=;
        b=csGHgfyhplhdKydGgYEkaWlien9YKSWfKoZaDOGlwGTOGsrnVuzI64STLpfsAfpfZ+
         nyuPCsgiX5bMi8f8tb2/r0ZesQxRAJiQBhWiyJ6JwOKWq6x0Pbd9yYWuuH/jzObv2/o9
         3gkJdkolovWodQCUAPMj6h+mxm9Ot6MyMMh2Lv4duDL01GatJd7ItO3AKUCpryiRuGVF
         q+WEUJrTguu1sMVymPPrfRFAgDrSatP8T0Ef4JtuTFIXojCIFfY5LWgdY8gQeKhJAS9d
         SRTI50jAnp5LRk9SGAVhypvtzd/YIlC27Lkno6z1ensTkgyLFpJFbT9H+unnyhXexgW4
         PzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h04+/kyq65eedtQzdgewP9Eey1SBByTI6ESOC8A2z5w=;
        b=d61mB3ZZ0aeSSgJJsvJ2pKlz9FI+21fe0m2y+cfe4cIY4D0JeDMUvsEONh+jTHibbf
         Q+Iov49WET+MpsQGGxY62cNdF6ESI8318S0e0n31ArJshBPzVI+eaVfjpfFIe13+aDkI
         p4zxQiQV+tGKdEGX8IpI3fAkypXtmC0hRlufrYV6wEDArggAy67hXTd7TFzklRmzwVUm
         6jQoGdmmWgOIyczYOOUa/lajeuGq/G1TI/0bZMA9oqFKOukfDzxZXWT3ik8SwH2ZsSKG
         I477LHpAbobYFzQjLFK51FgeASoJ0uodRBGLV77o0nq+l1mF3ljsbR0t0nC4ZIS0ljpF
         KBBA==
X-Gm-Message-State: APjAAAWuafE7zfkDKRlKa67esHpF6wtpWVtiW0pXdRMXBn56tmXJfBpk
        ECIK9tBC+qJuLEm3lz2Tix0=
X-Google-Smtp-Source: APXvYqx0ZOiuMcVoWbPAmczuH0Yy23P9uwMh//zAmKlY8Kf73XuQCvuPrPC1oWkugHqiJG7IYqPJMA==
X-Received: by 2002:a63:1a22:: with SMTP id a34mr16682023pga.403.1575882204085;
        Mon, 09 Dec 2019 01:03:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id i4sm24552332pgc.51.2019.12.09.01.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 01:03:23 -0800 (PST)
Date:   Mon, 9 Dec 2019 18:03:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20191209090321.GF88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
 <20191209084300.GD88619@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209084300.GD88619@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/09 17:43), Sergey Senozhatsky wrote:
> > +static int desc_read_committed(struct prb_desc_ring *desc_ring, u32 id,
> > +			       u64 seq, struct prb_desc *desc)
> > +{
> > +	enum desc_state d_state;
> > +
> > +	d_state = desc_read(desc_ring, id, desc);
> > +	if (desc->info.seq != seq)
> > +		return -EINVAL;
> > +	else if (d_state == desc_reusable)
> > +		return -ENOENT;
> > +	else if (d_state != desc_committed)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Copy the ringbuffer data from the record with @seq to the provided
> > + * @r buffer. On success, 0 is returned.
> > + *
> > + * See desc_read_committed() for error return values.
> > + */
> > +static int prb_read(struct printk_ringbuffer *rb, u64 seq,
> > +		    struct printk_record *r)
> > +{
> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> > +	struct prb_desc *rdesc = to_desc(desc_ring, seq);
> > +	atomic_t *state_var = &rdesc->state_var;
> > +	struct prb_desc desc;
> > +	int err;
> > +	u32 id;
> > +
> > +	/* Get a reliable local copy of the descriptor and check validity. */
> > +	id = DESC_ID(atomic_read(state_var));
> > +	err = desc_read_committed(desc_ring, id, seq, &desc);
> > +	if (err)
> > +		return err;
> > +
> > +	/* If requested, copy meta data. */
> > +	if (r->info)
> > +		memcpy(r->info, &desc.info, sizeof(*(r->info)));
> 
> I wonder if those WARN_ON-s will trigger false positive sometimes.
> 
> A theoretical case.
> 
> What if reader gets preempted/interrupted in the middle of
> desc_read_committed()->desc_read()->memcpy(). The context which interrupts
> the reader recycles the descriptor and pushes new data. Suppose that
> reader was interrupted right after it copied ->info.seq and ->info.text_len.
> So the first desc_read_committed() will pass - we have matching ->seq
> and committed state. copy_data(), however, most likely, will generate
> WARNs. The final desc_read_committed() will notice that local copy
> of desc was in non-consistent state and everything is fine, but we have
> WARNs in the log buffer now.

Hmm. No, that won't happen. We should get desc_miss first, and then -EINVAL.

	-ss
