Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32D2C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC9D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrdhRaNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfFZHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:45:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46519 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:45:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so946497pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dM7vYsgBxvjACyk/KNCx14abdUKYm6wDW0lC29USMFM=;
        b=KrdhRaNhf8ZuMC8OlOHOMqqWLX82y7oRuCkfl46uD0d3n3q5ihh/SuvxMSUSmOfvQr
         yT2SFctPttYAjOmKSAcfQP4kEVCzX5EZuhVBG0NF34bTjd9I7YIGEJda8eZWu9Dd+cO3
         wtuAdXKTE1ZuIx/p5Jubqs/Kaz6p1YzPAvY9EQ76yjyD6KFZ0vHMFNwEEbq9O9r9Fy6N
         7uJMSZRfp4uasBgvNoVnZixRPa+8gVaAtAmaTFoGJiMiuC/hcA1c6fsx5/ueg07jDrb3
         QjSqhT5dDfLFA5S3U0WJ1vPneLjFcUBwgkbLZF24/cMBnCOdc01WfU5ZTtVxMV9+pCi0
         h9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dM7vYsgBxvjACyk/KNCx14abdUKYm6wDW0lC29USMFM=;
        b=kf50j0uPQAI22RDLAEy5ut6V8FZrMwzhIoJxYLxa04EOdaQIDlUJ4eWXL/Lai1Eioc
         zHNHtzHp7C7LdDtLV1P4tIydvevxKIrLgyAs693skeQukaEd8wkfx8zUYiwkaMeLkQ71
         hFnX2Tox4SeRzBZuaTx4QBll0RRzkMxD1LeJpU6XWKWiCCHtAaagv5RC+9y+wqHxlOT9
         4YNibNw1LpfXi7smCip4lZ9JCqDwdU1wOK+0hK0an6851j9yLSPfdIucdlSkRGfqdjqp
         p9HtOj4o5UtnFm/Zllarw3pIrMrJEuq59xznAJIqzIzQ+tvUZR78E6kXoeHcDRx6EbpN
         7isg==
X-Gm-Message-State: APjAAAX3RF+2vf5BgWtOZYqv0Kr6hTl+DZmomXOc1XeFZEj/XncF/nQU
        6iTSVt0bttJ/1tshIjJsGHHn+xuM
X-Google-Smtp-Source: APXvYqyHW2G9UrtlBnshTqvpRpAXgSp6l9F8zmcXXr1vsdFz1iiRWc3N8v5xFDdq7LOac9lbFFs7lw==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr3790429plt.152.1561535151300;
        Wed, 26 Jun 2019 00:45:51 -0700 (PDT)
Received: from localhost ([175.223.45.10])
        by smtp.gmail.com with ESMTPSA id b11sm15686581pfd.18.2019.06.26.00.45.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 00:45:49 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:45:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190626074546.GA31547@jagdpanzerIV>
References: <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
 <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
 <20190625100322.GD532@jagdpanzerIV>
 <87woh9hnxg.fsf@linutronix.de>
 <20190626020837.GA25178@jagdpanzerIV>
 <87mui43jgk.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mui43jgk.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/26/19 09:16), John Ogness wrote:
> On 2019-06-26, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > [..]
> >> In my v1 rfc series, I avoided this issue by having a separate dedicated
> >> ringbuffer (rb_sprintf) that was used to allocate a temporary max-size
> >> (2KB) buffer for sprinting to. Then _that_ was used for the real
> >> ringbuffer input (strlen, prb_reserve, memcpy, prb_commit). That would
> >> still be the approach of my choice.
> >
> > In other words per-CPU buffering, AKA printk_safe ;)
> 
> Actually, no. I made use of a printk_ringbuffer (which is global). It
> was used for temporary memory allocation for sprintf, but the result was
> immediately written into the printk buffer from the same context. In
> contrast, printk_safe triggers a different context to handle the
> insertion.

I agree that's not relevant to your patch. But let me explain what I
meant. printk_safe has many faces. The NMI part of printk_safe has
the PRINTK_NMI_DIRECT_CONTEXT_MASK bufferring bypass - when we know
that we are in NMI and printk logbuf is unlocked then we can do the
normal logbuf_store() from NMI, avoiding irq flush because the data
is already in the main log buffer. We also can do the same buffering
bypass for non-NMI part of printk_safe, but just sometimes.
PRINTK_SAFE_CONTEXT_MASK most of the times indicates that logbuf is
locked, but not always - e.g. we call console_drivers under
PRINTK_SAFE_CONTEXT_MASK.

But like I said, not relevant to your patch. The relevant part is the
possibility of race conditions.

> It is still my intention to eliminate the buffering component of
> printk_safe.

That's understandable.

> After we get a lockless ringbuffer that we are happy with, my next
> series to integrate the buffer into printk will again use the sprint_rb
> solution to avoid the issue discussed in this thread.

Yes, I agree that either sprint_rb or just 2 LOG_LINE_MAX per-CPU
buffers looks safer. This basically means that printk cannot use
printk_ringbuffer as is and needs some sort of extra layer next to
(or atop of) printk_ringbuffer, but we have the same thing in printk
right now, basically. static char textbuf[LOG_LINE_MAX] -> logbuf.

	-ss
