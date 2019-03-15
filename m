Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D16C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4F52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfCOM5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:57:19 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45457 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfCOM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:57:19 -0400
Received: by mail-vs1-f68.google.com with SMTP id n14so5281082vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 05:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43tQbEGYrIJFVibyxu6PA/YE37QDIgWNBoQFuJt5nIg=;
        b=M8wm+Y7GHthei+CA/8EF+FufJOAf2v+QD37niYJ9PS6FthTLbun+o+tEqOjTw1l1hw
         1viUjCr1Kd2ZyBE6Iuv+i+KtlN5ZQR6rNWL6lgIdDXiPFogle5BChEoqIuUjz0KXLr+s
         UUqUl7v3leAD2JIk6ktGHJb1RNz4BEU0b1wbKP5+3mfh4V8qAjk4Lbsf+KqDVU0bs3+4
         SWNkGY7nr+/RsrlF5Mdj9PA6Tpu5JR6B1yFcV9yf+TkHH23E9uhOWm4m3RqQ4M1EvX+J
         Fzrna+6RY0JU1q71mtjT1yaLTarX7kuo46+iH1tb64EVsZHnE9IaLGYmgWRZ0EXD2POV
         zVVw==
X-Gm-Message-State: APjAAAX1yM3UT8p0IhxyYqMo35VYhCQuNHrvs2CosjGDRzT7rmcBkwNa
        sttBssLyL3+vWFQZysxdyH9JTEX0GCif2M6cTU8=
X-Google-Smtp-Source: APXvYqwN4WZ8lYoz23MaD18Jz4dqmaLg1dR/Cw3bDg8fcLcU0AIS/Fd+iUV9R7JFOgQf006XaCCpPV4Ksj6ELZdCGnc=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr1866109vsp.166.1552654637592;
 Fri, 15 Mar 2019 05:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
 <20190314091041.GU9224@smile.fi.intel.com> <201903150433.x2F4X9oT024601@sdf.org>
 <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com> <201903151023.x2FANDVY013031@sdf.org>
In-Reply-To: <201903151023.x2FANDVY013031@sdf.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Mar 2019 13:57:05 +0100
Message-ID: <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
To:     George Spelvin <lkml@sdf.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrey Abramov <st5pub@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Fri, Mar 15, 2019 at 11:23 AM George Spelvin <lkml@sdf.org> wrote:
> On Fri, 15 Mar 2019 at 09:20:58 +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 15, 2019 at 5:33 AM George Spelvin <lkml@sdf.org> wrote:
> >> On Thu, 14 Mar 2019 at 11:10:41 +0200, Andy Shevchenko wrote:
> >>> On Tue, Mar 05, 2019 at 03:06:44AM +0000, George Spelvin wrote:
> >>>> +            for (bit = 1; count & bit; bit <<= 1) {
> >>>> +                    cur = merge(priv, (cmp_func)cmp, pending, cur);
> >>>> +                    pending = pending->prev;  /* Untouched by merge() */
> >>>>              }
> >>>
> >>> Wouldn't be it the same to
> >>>
> >>>       bit = ffz(count);
> >>>       while (bit--) {
> >>>               ...
> >>>       }
> >>> ?
> >>>
> >>> Though I dunno which one is generating better code.
> >>
> >> One question I should ask everyone: should "count" be 32 or 64 bits
> >> on 64-bit machines?  That would let x86 save a few REX bytes.  (815
> >> vs. 813 byte code, if anyone cares.)
> >>
> >> Allegedy ARM can save a few pJ by gating the high 32
> >> bits of the ALU.
> >>
> >> Most other 64-bit processors would prefer 64-bit operations as
> >> it saves masking operations.
> >>
> >> If we never sort a list with more than 2^32 entries, it
> >> makes no difference.
> >>
> >> If we use a 32-bit count and we *do* sort a list with more than
> >> 2^32 entries, then it still sorts, but the performance degrades to
> >> O((n/2^32)^2).
> >>
> >> Just how often do we expect the kernel to face lists that long?
> >> (Note that the old code was O((n/2^20)^2).)
> >
> > Using size_t sounds most logical to me (argument of least surprise).
>
> Yes, it is the obvious solution, which is why that's my default choice.
>
> But a bit of thought shows that a list long enough to break a
> 32-bit implementation is beyond ridiculous.
>
> The list must be at least 3 * 2^32 elements long to make the sort
> merge non-optimally.  That's 1.5 * 2^37 bytes (192 GiB) of list_head
> structures alone; at least double that for any practical application.
> And 32 * 3 * 2^32 + (2 + 3) * 2^32 = 101 * 2^32 = 1.57 * 2^38
> compares.
>
> That seems like a lot but that's not the botteneck.  Each compare
> reads from a new list element, and pretty soon, they'll miss all
> caches and go to main memory.
>
> Since the memory locations are random, for any small subset of the
> list, you'll get only one element per cache line.  A 32 MiB L3
> cache is 2^19 cache lines (assuming 64B lines).  So merge levels
> 20 through 33 will go to main memory.
>
> That's (12 * 3 + 5) * 2^32 = 1.28 * 2^37 cache misses.  At 60 ns each (typical
> local DRAM access time on i7 & Xeon according to Intel), that's a
> hard minimum of 10565 seconds = 2h 56m 05s in one list_sort call.
>
> This is definitely the scale of problem where a mutithreaded sort is
> called for.
>
> It's *so* impossible that maybe it's worth trading that capability
> for a couple of bytes in the inner loop.
>
> >> In the code, I could do something like
> >>
> >> #ifdef CONFIG_X86_64
> >> /* Comment explaining why */
> >> typedef uint32_t count_t;
> >> #else
> >> typedef size_t count_t;
> >> #endif

So just make it unsigned int, unconditionally.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
