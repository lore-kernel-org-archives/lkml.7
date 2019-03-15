Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948D3218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCORr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:47:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34628 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfCORr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:47:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id c6so900853uan.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=na1eTKhA2rjuqGwUwBV9vCpYJ58yHfP9847Gxnpwh2M=;
        b=r2uw+W2KWh4RciFWh42qqyoMmDYQwluHibkIOWOFbhVMLbu9VUss49kG00rE6gPhvf
         6CpllVIzDO9YjU3c0vGwLuFZDoQk2kH2iDZWyS4CptfV+MvF59QZNpMaCnF18gk1yXcB
         zOJjWHSezbGeAzZK9dfZJfiRzMYqGw/FRMEzAr3EpUo8+2gKKB2RQWqzw4MvbvIpPbec
         dt6v1id5Ph6XyxzCZ8hWe9I9ny+PpkGzFPjqjMWr2pI8uSRad04C2va57DseUEOMwdBO
         uOfjmTEehNon3IanGe2nOO/FhDvANd+d6Ryx978lyGOmesNTWMYILEAD6rC2cLu5nuTX
         /q7w==
X-Gm-Message-State: APjAAAXXRJxjUqcWggItXtIAJ3T9nJIHXc4SjOQoXzcR2lwmSzPf8bz4
        9QOK8vQs6uJnAWlLtT7vVAxktjK59w+fmDqrgNw=
X-Google-Smtp-Source: APXvYqz+qPhSy9/ZKXRhPvzd0YWibEO/NhzFLTPrFrxDPAvr4odNHwXRGOm/G+v8QRoXaslWiI+XcJZ7kzYU+Pap16M=
X-Received: by 2002:ab0:1342:: with SMTP id h2mr344708uae.47.1552672076711;
 Fri, 15 Mar 2019 10:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552097842.git.lkml@sdf.org> <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>
 <20190314091041.GU9224@smile.fi.intel.com> <201903150433.x2F4X9oT024601@sdf.org>
 <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>
 <201903151023.x2FANDVY013031@sdf.org> <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
 <201903151659.x2FGxi3R012970@sdf.org>
In-Reply-To: <201903151659.x2FGxi3R012970@sdf.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Mar 2019 18:47:44 +0100
Message-ID: <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>
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

On Fri, Mar 15, 2019 at 5:59 PM George Spelvin <lkml@sdf.org> wrote:
> On Fri, 15 Mar 2019 at 13:57:05 +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 15, 2019 at 11:23 AM George Spelvin <lkml@sdf.org> wrote:
> >> On Fri, 15 Mar 2019 at 09:20:58 +0100, Geert Uytterhoeven wrote:
> >>> On Fri, Mar 15, 2019 at 5:33 AM George Spelvin <lkml@sdf.org> wrote:
> >>>> One question I should ask everyone: should "count" be 32 or 64 bits
> >>>> on 64-bit machines?  That would let x86 save a few REX bytes.  (815
> >>>> vs. 813 byte code, if anyone cares.)
> >>>>
> >>>> Allegedy ARM can save a few pJ by gating the high 32
> >>>> bits of the ALU.
> >>>>
> >>>> Most other 64-bit processors would prefer 64-bit operations as
> >>>> it saves masking operations.
> >
> > So just make it unsigned int, unconditionally.
>
> As I wrote originally (and quoted above), other 64-bit machines don't
> have 32-bit operations and prefer 64-bit operations because they don't
> require masking.  x86 (for historical compatibiity) and ARM (for power
> saving) are the ones that come to mind.
>
> I'm trying to present the case to spur discussion, but it realy is
> a *question* I'm asking about whether to do that, not a suggestion
> phrased as a question.

If it's just x86_64, use size_t everywhere, and let them suffer, for not
being real 64-bit ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
