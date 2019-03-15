Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04515C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C496C21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCOIVL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:21:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34154 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfCOIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:21:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id e126so4672549vse.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nfllzvU4LySFmRQhIlKP42JxfvqsqpZKDJK6PX4JQIo=;
        b=ljs9JxTCIAJP294FqE8GewVs1h3+lzFY9DGbmV4QPEwsX/77giPCVJL2zKzo2dzfu4
         1+xWqfl2MvzhrLl7ip2bzJmw2/8erzL+aMu4ZDBZex88gsGQidaOhYYwc/nKqs4F/cUh
         Yoa2NiEuDICIAIjfvK6Bdp8jBr0S9gPZD4zMktcz2DL8J7KaMxoADVI72h+6n79YZmKR
         yk+0vDldbQLDySYqo0RDs/lmHceOe9mfpQvP6ANKs3O39uH9nVov+oDheaVKFW9Im5Go
         qQaLRvZOJQEd9ufiyfuqs/UzO5sTQ0vJNBMtD04jeHs9vyicPH3lNtNi4PoOEXNUc952
         Lqvg==
X-Gm-Message-State: APjAAAWVnIgZOUmMZR9dwXkEesNNRb5Oehlu+srAohij8VML3uWpIha+
        m7PGGiPGwhrX1ZJnHGlKALDx9A0XTruNFQyhwJw=
X-Google-Smtp-Source: APXvYqwu6lnlKH4Ja0FHWMZaaHRRbQLePDnhQoDyxiQQEFHWI7XEtnKEDM9kM3MO+D1oymJM4M/aqP2pmUi9c5i09Oc=
X-Received: by 2002:a67:8588:: with SMTP id h130mr1256899vsd.11.1552638069743;
 Fri, 15 Mar 2019 01:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
 <20190314091041.GU9224@smile.fi.intel.com> <201903150433.x2F4X9oT024601@sdf.org>
In-Reply-To: <201903150433.x2F4X9oT024601@sdf.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Mar 2019 09:20:58 +0100
Message-ID: <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
To:     George Spelvin <lkml@sdf.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Dave Chinner <dchinner@redhat.com>,
        Don Mullis <don.mullis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrey Abramov <st5pub@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Fri, Mar 15, 2019 at 5:33 AM George Spelvin <lkml@sdf.org> wrote:
> On Thu, 14 Mar 2019 at 11:10:41 +0200, Andy Shevchenko wrote:
> > On Tue, Mar 05, 2019 at 03:06:44AM +0000, George Spelvin wrote:
> >> +            for (bit = 1; count & bit; bit <<= 1) {
> >> +                    cur = merge(priv, (cmp_func)cmp, pending, cur);
> >> +                    pending = pending->prev;  /* Untouched by merge() */
> >>              }
> >
> > Wouldn't be it the same to
> >
> >       bit = ffz(count);
> >       while (bit--) {
> >               ...
> >       }
> > ?
> >
> > Though I dunno which one is generating better code.
>
> One question I should ask everyone: should "count" be 32 or 64 bits
> on 64-bit machines?  That would let x86 save a few REX bytes.  (815
> vs. 813 byte code, if anyone cares.)
>
> Allegedy ARM can save a few pJ by gating the high 32
> bits of the ALU.
>
> Most other 64-bit processors would prefer 64-bit operations as
> it saves masking operations.
>
> If we never sort a list with more than 2^32 entries, it
> makes no difference.
>
> If we use a 32-bit count and we *do* sort a list with more than
> 2^32 entries, then it still sorts, but the performance degrades to
> O((n/2^32)^2).
>
> Just how often do we expect the kernel to face lists that long?
> (Note that the old code was O((n/2^20)^2).)

Using size_t sounds most logical to me (argument of least surprise).

> In the code, I could do something like
>
> #ifdef CONFIG_X86_64
> /* Comment explaining why */
> typedef uint32_t count_t;
> #else
> typedef size_t count_t;
> #endif
>
> ...
>         count_t count = 0;

Using different types makes it more complex, e.g. to print the value
in debug code.
And adding more typedefs is frowned upon.

Just my 0.02€.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
