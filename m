Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D8BC3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3DB2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 02:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7h/tF9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgACCSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 21:18:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44019 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgACCSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 21:18:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so41101777wre.10;
        Thu, 02 Jan 2020 18:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKsmWzAH+jn+cRdYPOdgZtYy7Med4iVwewv4VWyJI5w=;
        b=J7h/tF9ifcNqJRnrcXzGxKZjcT7rZ6smwbrCFS5GkKIbkI9y/RW7+2Gj8yeYgDmsYn
         UeVVV84ydGet9mAxnC4/lZvISemWjjWfhItXIrk3bwKswwVmklj7hPfvEJTqk+dQkQFi
         T1L148Q9mtj5haw1eYsy+1r/XbnpszHY+8ZCCc7pp85EmbjYN0uiHXzYRFsaphqYM4mq
         ANO6iprp62UxudT7P5pf0uywv6s9iopbosQbYxTj+H13iBhwbnTybVmYA4spsbDsiiqP
         2jQMUjC7adA/3O2EsFbpLYxhwfnddM+eISM0pVhF/dOW7/CKqqLchDYYTyKD1RQ2GDRO
         p2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKsmWzAH+jn+cRdYPOdgZtYy7Med4iVwewv4VWyJI5w=;
        b=nMuHElz4Sj+X2kYwbl0fGdb9MlPOIXW4mq2MLyHi/DhVPmsE2mwp902CefrOQ+/XZS
         /7xo+eRBDTY9iGkODe4ADdBnJGARC+N+LbKmXnaRm1ezRgzdgw12VPxJAzSlBwORSgxN
         /xZkhFZb2GeA7fFtNXfWYSKQhJrPdFgS+wvVTD1OE+OMn/PVqg0ATbvGKhmP0jsmcQtw
         gmP1ZzXOInM+qXO+D87sm1tXoAe1EynjUpf7yw3q57PvK2HRj5I6qJBfw4tFTNwsuhrj
         YZHkxoJJKOplfGC5MG6ZbT9mhuONr5zUqACMMA3e8vob4VFJnyl5oHs3YZ5PPi6R5lZz
         9EJw==
X-Gm-Message-State: APjAAAX0WWiROCvffvgh+H7J04mrbQKzCzB+wMsid4aT8KcGnYn3LZsG
        uTClmJ7VZRgwm7UfmfkZgAY=
X-Google-Smtp-Source: APXvYqxvjITd4l0EaMHcb7d8+MSL7EBbhkgcXDoaVVqE2wfkKE/9hGi4qvO/sqj79nCDt6daXRjHEQ==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr84307952wrh.272.1578017901673;
        Thu, 02 Jan 2020 18:18:21 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40c7:f800:91a6:5c40:d57a:b014])
        by smtp.gmail.com with ESMTPSA id x1sm57441063wru.50.2020.01.02.18.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 18:18:20 -0800 (PST)
Date:   Fri, 3 Jan 2020 03:18:19 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20200103021819.jq6h53h3ktlatyj7@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
 <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 05:35:34PM -0800, Linus Torvalds wrote:
> On Mon, Dec 30, 2019 at 3:38 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > One of the simplest situation with these conditional locks is:
> >
> >         if (test)
> >                 lock();
> >
> >         do_stuff();
> >
> >         if (test)
> >                 unlock();
> >
> > No program can check that the second test gives the same result than
> > the first one, it's undecidable. I mean, it's undecidable even on
> > if single threaded and without interrupts. The best you can do is
> > to simulate the whole thing (and be sure your simulation will halt).
> 
> No, no.
> 
> It's undecidable in the general case, but it's usually actually
> trivially decidable in most real-world kernel cases.
> 
> Because "test" tends to be an argument to the function (or one bit of
> an argument), and after it has been turned into SSA form, it's
> literally using the same exact register for the conditional thanks to
> CSE and simplification.
> 
> Perhaps not every time, but I bet it would be most times.

Yes, sure. I was, in fact, speaking for for all the cases where
'test' is more complex than an argument or local var. When I looked
at these false warnings about context imbalance, maybe 18 months ago,
my vague impression was that in most cases the test contained a pointer
dereference or worse. But I didn't look much.

> So I guess sparse could in theory notice that certain basic blocks are
> conditional on the same thing, so if one is done, then the other is
> always done (assuming there is conditional branch out in between, of
> course).
> 
> IOW, the context tracking *could* do check son a bigger state than
> just one basic block. It doesn't, and it would probably be painful to
> do, but it's certainly not impossible.
> 
> So to make a trivial example for sparse:
> 
>     extern int testfn(int);
>     extern int do_something(void);
> 
>     int testfn(int flag)
>     {
>         if (flag & 1)
>                 __context__(1);
>         do_something();
>         if (flag & 1)
>                 __context__(-1);
>     }
> 
> this causes a warning:
> 
>     c.c:4:5: warning: context imbalance in 'testfn' - different lock
> contexts for basic block
> 
> because "do_something()" is called with different lock contexts. And
> that's definitely a real issue. But if we were to want to extend the
> "make sure we enter/exit with the same lock context", we _could_ do
> it, because look at the linearization:
> 
>     testfn:
>     .L0:
>         <entry-point>
>         and.32      %r2 <- %arg1, $1
>         cbr         %r2, .L1, .L2
>     .L1:
>         context     1
>         br          .L2
>     .L2:
>         call.32     %r4 <- do_something
>         cbr         %r2, .L3, .L5
>     .L3:
>         context     -1
>         br          .L5
>     .L5:
>         ret.32      UNDEF
> 
> becasue the conditional branch always uses "%r2" as the conditional.
> Notice? Not at all undecideable, and it would not be *impossible* to
> say that "we can see that all context changes are conditional on %r2
> not being true".
> 
> So sparse has already done all the real work to know that the two "if
> (test)" conditionals test the exact same thing. We _know_ that the
> second test has the same result as the first test, we're using the
> same SSA register for both of them!

Absolutely. I'm more than willing to look at this but I just fear
that in most cases the conditional is more complex. I'll make
some investigations.

-- Luc
