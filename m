Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FEBC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27D2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1nLB4pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLIInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:43:04 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35457 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfLIInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:43:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so5578107pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zYU0p49jaQaWhoON0mWxdDgAlDp+Z2USeQN6YJkq0LU=;
        b=f1nLB4pLihTj7QqOBhMeGoTXcSLn9LcpjRNX2SWnNb75lhCLZ2Z4xleFtyDtWBhC9C
         g95kB+/UOZB9KrpPnTxQF5XttcnBmlkoTVEkUHhH6TwQc0FP3/VmDbZPfU2ZFKul2NSy
         cW2ZAuB2+ipUqx61EFTiK46qUp2xhHvYXrGjtTgmuXluaS+16VZxNFbhF3h3Q3I5FqiC
         Wu8eTfMs1nquL0RXIYyHaXYTPSRFBYHqpIsoehnmuFrSaQonxBy6kAC8Wqhad/t3vahI
         ULyKn6Bcu9cEq9SGnAjVNzRhkXieXIKZuSN5dCJLtPcqBuw2GFlis1dTi18ITvDM9v1B
         FJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zYU0p49jaQaWhoON0mWxdDgAlDp+Z2USeQN6YJkq0LU=;
        b=ITqkvUoVGtEbomKjs9XqcXj9au+vqegWrM3bWOiQXfk/88l4+QFCPCzOWQODtiBLZj
         mUEkUYyqcQ+Pt6Pj8A84ngC/LUB5XTFxeBH0Rq1aCGJGjc4hulPktbtfVmLlxd+XleCZ
         sB37RaBrDE2nCxfdI0HTAVGRqliGsqUnFVouPipAVwnAn0zhfnsNEb97miangY67A4aX
         5dFXtJJ7xhg1w5x5dIK0eKiKdwfQvqzhQKGKLBD+DH3078nMOuSEi6qNO1C9aUcsoTwj
         DUEW+QT2xAUJOwT9Qnjk0UsBbQ2DAaotfo4HOOk+Hf/Pu4FMJHI9R+sFbFZ9Wz+p7EFY
         /SCQ==
X-Gm-Message-State: APjAAAUpnVh6vq3Yv94y7anW6xY+ecma6sj0ZjLhxF1LOu3soMrEUGQn
        QGwpsPH7L8viEvg98koEHKg=
X-Google-Smtp-Source: APXvYqx+eMXHnMMqNF1EO8VX5HOBZ84BJhclLpKNqp3e8sDPXnKAb4vxozfV7CYe/qrlvdnxy07yrQ==
X-Received: by 2002:a17:90a:ca12:: with SMTP id x18mr30682084pjt.66.1575880983333;
        Mon, 09 Dec 2019 00:43:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id x12sm25332109pfm.130.2019.12.09.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 00:43:02 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:43:00 +0900
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 2/3] printk-rb: new printk ringbuffer
 implementation (reader)
Message-ID: <20191209084300.GD88619@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/28 02:58), John Ogness wrote:
> +/* Given @blk_lpos, copy an expected @len of data into the provided buffer. */
> +static bool copy_data(struct prb_data_ring *data_ring,
> +		      struct prb_data_blk_lpos *blk_lpos, u16 len, char *buf,
> +		      unsigned int buf_size)
> +{
> +	unsigned long data_size;
> +	char *data;
> +
> +	/* Caller might not want the data. */
> +	if (!buf || !buf_size)
> +		return true;
> +
> +	data = get_data(data_ring, blk_lpos, &data_size);
> +	if (!data)
> +		return false;
> +
> +	/* Actual cannot be less than expected. */
> +	if (WARN_ON_ONCE(data_size < len))
> +		return false;
> +
> +	data_size = min_t(u16, buf_size, len);
> +
> +	if (!WARN_ON_ONCE(!data_size))
> +		memcpy(&buf[0], data, data_size);
> +	return true;
> +}
> +
> +/*
> + * Read the record @id and verify that it is committed and has the sequence
> + * number @seq.
> + *
> + * Error return values:
> + * -EINVAL: The record @seq does not exist.
> + * -ENOENT: The record @seq exists, but its data is not available. This is a
> + *          valid record, so readers should continue with the next seq.
> + */
> +static int desc_read_committed(struct prb_desc_ring *desc_ring, u32 id,
> +			       u64 seq, struct prb_desc *desc)
> +{
> +	enum desc_state d_state;
> +
> +	d_state = desc_read(desc_ring, id, desc);
> +	if (desc->info.seq != seq)
> +		return -EINVAL;
> +	else if (d_state == desc_reusable)
> +		return -ENOENT;
> +	else if (d_state != desc_committed)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Copy the ringbuffer data from the record with @seq to the provided
> + * @r buffer. On success, 0 is returned.
> + *
> + * See desc_read_committed() for error return values.
> + */
> +static int prb_read(struct printk_ringbuffer *rb, u64 seq,
> +		    struct printk_record *r)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	struct prb_desc *rdesc = to_desc(desc_ring, seq);
> +	atomic_t *state_var = &rdesc->state_var;
> +	struct prb_desc desc;
> +	int err;
> +	u32 id;
> +
> +	/* Get a reliable local copy of the descriptor and check validity. */
> +	id = DESC_ID(atomic_read(state_var));
> +	err = desc_read_committed(desc_ring, id, seq, &desc);
> +	if (err)
> +		return err;
> +
> +	/* If requested, copy meta data. */
> +	if (r->info)
> +		memcpy(r->info, &desc.info, sizeof(*(r->info)));

I wonder if those WARN_ON-s will trigger false positive sometimes.

A theoretical case.

What if reader gets preempted/interrupted in the middle of
desc_read_committed()->desc_read()->memcpy(). The context which interrupts
the reader recycles the descriptor and pushes new data. Suppose that
reader was interrupted right after it copied ->info.seq and ->info.text_len.
So the first desc_read_committed() will pass - we have matching ->seq
and committed state. copy_data(), however, most likely, will generate
WARNs. The final desc_read_committed() will notice that local copy
of desc was in non-consistent state and everything is fine, but we have
WARNs in the log buffer now.

	-ss
