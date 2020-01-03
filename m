Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF56C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21132084D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578015356;
	bh=/2uOzCe1VdO7c+iySmBJxc7Fdvz9JPHMyOBDMtU8adA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cnZhGRMkvycj2/vbdUCMVK+kuXsaDF5LY6d5r5SdraA5Tm8+WkVReXDzFLpuCg3cG
	 bJNjKpT0uHS9Hewr7RSotGB751MJac7/BBnzWNPV5ZeUt8uP+ULLWDOQQVHI7iYUQi
	 HG4u9sRCBAylYX1QzupKOIaAx9x18Z6TSOl0kapU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgACBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:35:55 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37442 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgACBfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:35:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so31038684ljg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35QK6jthzemu1MKfbbKBkPZnLXfewVEr2JR1TDwvfRg=;
        b=P4HVy1dnZY1g/SmNj+L1cp8Gqmk85eFl7JXdAo0PnsDl+1mkfClQLuxReD1j1KU3Su
         tTOHteMcRCGrSCzWj/ftYmWShmuYjj8Fm2x2iL+fAGpwG3zWZKGl5S7HX/K8wvqrU4/t
         R+IXcRs9U5rNlL7gJVM3Xhddt9ZD1Eb9dG6N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35QK6jthzemu1MKfbbKBkPZnLXfewVEr2JR1TDwvfRg=;
        b=cpgmo5zWAMEr+RGXxufQD9GrAgQNVhfiVssLSsOxhyKbEGwa7+MHXUwtp/Qh8kJqFl
         PqWbXZJ0rxiCitGdR1I3dhEija/SBSCMTwtuXYaOkY5ts9WCenvUVxetVeFXTs1OfcSc
         s7TJDR/cYH96IYrHf3GHEzfZAztW2E7hZMErql/n7+akXwSh8BCo606HOik9V+kH17d0
         7D4UcG64Tegvsnq4RtY251/ebOvwKIJKJbbjZAKqtI4R0KZGg8Zfd6RtYL8pPSFJsRsq
         qMNkhF70iJoS1fm7WeCEV1/jW+28ObF70XBRMz/XOmG/avIrMQ0rMX1Rj/B0IUpCsYs9
         cXKw==
X-Gm-Message-State: APjAAAW8HtkdYgCwYHrvTEFl5m1e1VJtEmZbKlw07uLb8kEKGDgdVUgv
        g3RvHlupZuBT0x6FEHcCwIn+2LE8MT8=
X-Google-Smtp-Source: APXvYqzw1a1KuUhiWdRmWhP1wNbHL6bs3ZlGIXU/uN3vixCQmMk46YvMBQ772Pv2lnAkD47Q9la8WA==
X-Received: by 2002:a2e:93d5:: with SMTP id p21mr52458476ljh.50.1578015352163;
        Thu, 02 Jan 2020 17:35:52 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j19sm28318049lfb.90.2020.01.02.17.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 17:35:51 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id f15so30954356lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:35:50 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr49465252lfo.134.1578015350526;
 Thu, 02 Jan 2020 17:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20191226152922.2034-1-ebiggers@kernel.org> <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook> <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook> <20191230233814.2fgmsgtnhruhklnu@ltop.local>
In-Reply-To: <20191230233814.2fgmsgtnhruhklnu@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jan 2020 17:35:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
Message-ID: <CAHk-=wgkoUeLGEdUF2nsibsK8YFrOOXMd9j5Y1ND4R+1a-6n8w@mail.gmail.com>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock functions
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 3:38 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> One of the simplest situation with these conditional locks is:
>
>         if (test)
>                 lock();
>
>         do_stuff();
>
>         if (test)
>                 unlock();
>
> No program can check that the second test gives the same result than
> the first one, it's undecidable. I mean, it's undecidable even on
> if single threaded and without interrupts. The best you can do is
> to simulate the whole thing (and be sure your simulation will halt).

No, no.

It's undecidable in the general case, but it's usually actually
trivially decidable in most real-world kernel cases.

Because "test" tends to be an argument to the function (or one bit of
an argument), and after it has been turned into SSA form, it's
literally using the same exact register for the conditional thanks to
CSE and simplification.

Perhaps not every time, but I bet it would be most times.

So I guess sparse could in theory notice that certain basic blocks are
conditional on the same thing, so if one is done, then the other is
always done (assuming there is conditional branch out in between, of
course).

IOW, the context tracking *could* do check son a bigger state than
just one basic block. It doesn't, and it would probably be painful to
do, but it's certainly not impossible.

So to make a trivial example for sparse:

    extern int testfn(int);
    extern int do_something(void);

    int testfn(int flag)
    {
        if (flag & 1)
                __context__(1);
        do_something();
        if (flag & 1)
                __context__(-1);
    }

this causes a warning:

    c.c:4:5: warning: context imbalance in 'testfn' - different lock
contexts for basic block

because "do_something()" is called with different lock contexts. And
that's definitely a real issue. But if we were to want to extend the
"make sure we enter/exit with the same lock context", we _could_ do
it, because look at the linearization:

    testfn:
    .L0:
        <entry-point>
        and.32      %r2 <- %arg1, $1
        cbr         %r2, .L1, .L2
    .L1:
        context     1
        br          .L2
    .L2:
        call.32     %r4 <- do_something
        cbr         %r2, .L3, .L5
    .L3:
        context     -1
        br          .L5
    .L5:
        ret.32      UNDEF

becasue the conditional branch always uses "%r2" as the conditional.
Notice? Not at all undecideable, and it would not be *impossible* to
say that "we can see that all context changes are conditional on %r2
not being true".

So sparse has already done all the real work to know that the two "if
(test)" conditionals test the exact same thing. We _know_ that the
second test has the same result as the first test, we're using the
same SSA register for both of them!

              Linus
