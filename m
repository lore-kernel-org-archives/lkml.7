Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB24AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39CB2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6lZ0zY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393401AbfIFNop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:44:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35135 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393347AbfIFNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:44:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so3175459plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zjLShYw/rp5wFW14AXDqeXS8tgJuFuM/QRNEfp+KNP8=;
        b=I6lZ0zY3FfJcm3d77S3dP1l8ZXp++9pGPunrCtGIJZmhbgtB7GWzavcX6gFYCxbSW4
         K3vF37uqALsCJlsiy7zq+LhjUk3dkjtnPbiayW/ElKOLT+TZ2ckCj1y/aL2FynPF0V7A
         TMXlHwm0G+2/qZvVF//0HkmQnlZsPl+xm1QzjdPQsneoiu/FHMglPBNhLA7pwcwi5DHp
         cmvOK4C0/paEPt0KXGgZXsrgeNXpXN/c5lNQtr1ktre0A9wIutLIcK+P5aBefnQ+ov90
         IEeha/IdvQK3WYjICapWlPyFrL0dtyykQT9YjjhJC15sLACZbnqOb7S+rf40jhs3vkcw
         pDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zjLShYw/rp5wFW14AXDqeXS8tgJuFuM/QRNEfp+KNP8=;
        b=gTqaCvwEHjGkW2cL96qk043VpOont2CN0kzTV77jhd8JjQzEZVrNd+QD6bfGAjLXC4
         hfMRu4BSjXKF+BHtXxhlXA2aJtMJWpTHiLQa4/AMA074mw6jUVPZ5cAlnENHKDiVfoaY
         +q1F9IqqXDUadPskEtPFmpZ0wdI+zQ8VrlXvB/chgjJRwsNXkZ/47tsNy8+J/aUtthtf
         SN4eRvUp7hTd1dnUcWctLdOcRjfREqVvjdp/f62Hh38fOyyJgCrBQv6rDaVxformJf35
         gB0H24XTZleP9mZonJAsglOY+7JWv30uc2pnwmxJDvCttN6U8NzgR4TuWlw+vkFVe9jt
         8LCw==
X-Gm-Message-State: APjAAAUgcqxoYvaT485J0qlGFWCKTQarH5ArtuzstDWejSD/PvnE+xcz
        FU8ZeMYejhdNg5B6ak6EdB4=
X-Google-Smtp-Source: APXvYqxYOdGYGwgWG+18WPciwkNDWk+Rq2yLd2ZirpTsJeRH6bsX6PZVDWqXZbv10372eo45Qmdksg==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21mr9582782pls.80.1567777483198;
        Fri, 06 Sep 2019 06:44:43 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 19sm4689179pjc.25.2019.09.06.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 06:44:42 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 6 Sep 2019 22:44:39 +0900
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906134439.GA9590@tigerII.localdomain>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906100943.GB10876@jagdpanzerIV>
 <20190906104948.GX2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906104948.GX2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/06/19 12:49), Peter Zijlstra wrote:
> On Fri, Sep 06, 2019 at 07:09:43PM +0900, Sergey Senozhatsky wrote:
> 
> > ---
> > diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> > index 139c310049b1..9c73eb6259ce 100644
> > --- a/kernel/printk/printk_safe.c
> > +++ b/kernel/printk/printk_safe.c
> > @@ -103,7 +103,10 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
> >         if (atomic_cmpxchg(&s->len, len, len + add) != len)
> >                 goto again;
> >  
> > -       queue_flush_work(s);
> > +       if (early_console)
> > +               early_console->write(early_console, s->buffer + len, add);
> > +       else
> > +               queue_flush_work(s);
> >         return add;
> >  }
> 
> You've not been following along, that generates absolutely unreadable
> garbage.

This was more of a joke/reference to "Those NMI buffers are a trainwreck
and need to die a horrible death". Of course this needs a re-entrant cpu
lock to serialize access to atomic/early consoles. But here is one more
missing thing - we need atomic/early consoles on a separate, sort of
immutable, list. And probably forbid any modifications of such console
drivers, (PM, etc.) If we can do this then we don't need to take console_sem
while we iterate that list, which removes sched/timekeeping locks out
of the fast printk() path.

We, at the same time, don't have that many options on systems without
atomic/early consoles. Move printing to NMI (e.g. up to X pending logbug
lines per NMI)? Move printing to IPI (again, up to X pending logbuf lines
per IPI)? printk() softirqs?

	-ss
