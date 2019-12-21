Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D32C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15721655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK5ubXSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLUOWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:22:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53080 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfLUOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:22:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so11677619wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tAExSifujBqvj9jopiXqxarAHCCzEVY7vXvNLNSXQ5I=;
        b=aK5ubXSh0mGJIF0c/hJ4q4+R15cKMuXITa/XGA4SlvsJsMbCxQDDcNB4fIkNj2yoXn
         bB1mBa9IZ3aAfTCQFnLid6Y8Twr+gi/L4yEhK4T2a0MEdMTcaaQXT0HReE1N1y7onJKV
         OcFzTJl2GcoaX09ScfZw6rQObUiyr57kUT93ajqoQCweGf267m8BxsuJy9MB2yJjkAno
         svn3ih1ZJP4xDTvrB10ocJDH/iY3KtLGFUg4w7PmtSUyb/h/S/XELuHF9tX1dBj1B6Gn
         /e7mC8kApnp2Ijbs5/jTDP0ZBkhncjeDJVdCqCiaaJhNX52A+y72p6XJvhEfvXYJsq3k
         Fl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tAExSifujBqvj9jopiXqxarAHCCzEVY7vXvNLNSXQ5I=;
        b=QF8NaXOVyfuBaZ+RxDLiqaqR8i+5Ma3zWegYLviGX5jJdtcazZ8m2SYWl0RN8y1jGT
         XB3EyJdfRTWF4WlKKUOMTFKDd5pashsDMRy90lC67TJR+THVV1g5GezvWtQlKt7Q6EU4
         gfO6D21tqPZ6+QqeJtsJGiRsKT8bSL5uouXAU1dNX+A/Gr3bH60AT5IXvW4k+A35wz1s
         Lht81UD2dRw3gvngsIqto7LwYPhw070RsgNmqHaz/+RC3Eq0YiBwh75kAZQF9PNcB7tf
         mpNJiu8o7RiUasSk3IKT5UHxAwkX28sFnrepvlbnBEvGX0dEu723kNcd0CVdjWmYkb1I
         +4Pw==
X-Gm-Message-State: APjAAAVWYD1ncT0GQVpCB6z1aLVnjaEO1dUnUgvxLuBqArVm5R1JCMR1
        aimM0x0CGva354kGRuMREIM=
X-Google-Smtp-Source: APXvYqx0fkrceGwLFdcxtfkaBwk9Er1huMVEuf/3WZPs6M60RN0IBs69HBrkYa4PIzqHy8wfAWYH3w==
X-Received: by 2002:a7b:c407:: with SMTP id k7mr22916761wmi.46.1576938161638;
        Sat, 21 Dec 2019 06:22:41 -0800 (PST)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id i5sm13531276wml.31.2019.12.21.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 06:22:40 -0800 (PST)
Date:   Sat, 21 Dec 2019 15:22:35 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
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
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191221142235.GA7824@andrea>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Sorry for the delay.

I don't have an overall understanding of the patch(-set) yet, so I limit
to a couple of general questions about the memory barriers introduced by
the path.  Please see inline comments.


> +	*desc_out = READ_ONCE(*desc);
> +
> +	/* Load data before re-checking state. */
> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */

I looked for a matching WRITE_ONCE() or some other type of marked write,
but I could not find it.  What is the rationale?  Or what did I miss?


> +	do {
> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> +
> +		if (!data_push_tail(rb, data_ring,
> +				    next_lpos - DATA_SIZE(data_ring))) {
> +			/* Failed to allocate, specify a data-less block. */
> +			blk_lpos->begin = INVALID_LPOS;
> +			blk_lpos->next = INVALID_LPOS;
> +			return NULL;
> +		}
> +	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
> +					  next_lpos));
> +
> +	/*
> +	 * No barrier is needed here. The data validity is defined by
> +	 * the state of the associated descriptor. They are marked as
> +	 * invalid at the moment. And only the winner of the above
> +	 * cmpxchg() could write here.
> +	 */

The (successful) CMPXCHG provides a full barrier.  This comment suggests
that that could be somehow relaxed?  Or the comment could be improved?

(The patch introduces a number of CMPXCHG: similar questions would apply
to those other instances...)

Thanks,
  Andrea

P. S.  Please use my @gmail.com address for future communications.
