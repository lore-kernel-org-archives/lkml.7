Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935A82067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZeX5/P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfGaU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:59:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39024 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfGaU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:59:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so48415485lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cT2pwWCno8U0E9z595FUeml+E2FjE1G6WM/y1TMSDeY=;
        b=gZeX5/P8VVl76PaeOu/zqWAJHYlar5uwTH6ZSuTtMeOHfMoggs2cR9PtHqjwO/0LcS
         KR8sEFP1yrtuL1bNbZEyWkQVaKovN98Trdj5riPrkVTnneRjkanxjOcEgyC42OrB39Wg
         3PZFNp/sQIAi6mwbnWj1HGYiXX9wxNjew6V3VI2ikkUhyGLXBtXa5TaxOQUcLbEPsOq1
         W09VJ9OMxn9lZrxDrCr9WJHFPEgLpbLDCD1UGVNLXq1cKssVIHk6vfWfpj+mTSFaGEcO
         9vqsYpG/re4449zo0g/Jr9waZwwOWFcCsrNkCAiYg5GML0UgOfN5MZ7yzX8S9Wl9jexJ
         pGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cT2pwWCno8U0E9z595FUeml+E2FjE1G6WM/y1TMSDeY=;
        b=qqUt5cqx43U2st7yAHNxlSwV6CuwMWCBePX0WfmOCtFpwV8QSF4XCUyt2fEo18FYcW
         dwWYjfysGDfu4hU8B/K/ppiWQVD9qdGO4/faswLqpOOgIIhzNTBl6mQq17ag0sqri0cC
         xe1O3x1chMAQMku2Yy+LHdAr/sWLBiWz0m1SxNlRcsEesl0ETdHxkg1WM2giC8CKAtNp
         dJuveNRg9JB8OaNeqXBEJ+flwZjyPptOPFXqlY693DfG8etSTxhz7P+pHrCwiuQjT1iw
         UMC5zuNCEQj/mczEmJcG0VfKToBf6NRmTxwQwRE0pJbc4QAH0ZpIFvPNto+zzSxpr3lC
         zXAw==
X-Gm-Message-State: APjAAAXjAXlLW0yirxxTSZbdMliov7lM2aUSmkcSSwm6pwuqgYASTQpG
        Mi4XJgdTMBiu8fSqWsvbIqPRwiiKDuj3kvLH35PnxdQK
X-Google-Smtp-Source: APXvYqz4jC/AaXCiF0F+j6GjeNnZYwk7zRg9/r/Ml/j5d8O3uBU8ic7CjPFoZqtog5Gy3uWN5GY0Y5xRGyAJM+Mnnq8=
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr26180782lfo.133.1564606752711;
 Wed, 31 Jul 2019 13:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook>
In-Reply-To: <201907311301.EC1D84F@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 Jul 2019 22:59:01 +0200
Message-ID: <CANiq72kMpP_PSBb0e5wMVNiuYvwSWdR+x_H_tPrEnQ_j1y7X+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:02 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 31, 2019 at 08:48:32PM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor.com wrote:
> > > >> > +/*
> > > >> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
> > > >> > + * must end with any of these keywords:
> > > >> > + *   break;
> > > >> > + *   fallthrough;
> > > >> > + *   goto <label>;
> > > >> > + *   return [expression];
> > > >> > + *
> > > >> > + *  gcc: >https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
> > > >> > + */
> > > >> > +#if __has_attribute(__fallthrough__)
> > > >> > +# define fallthrough                   __attribute__((__fallthrough__))
> > > >> > +#else
> > > >> > +# define fallthrough                    do {} while (0)  /* fallthrough */
> > > >> > +#endif
> > > >> > +
> >
> > > If the comments are stripped, how would the compiler see them to be
> > > able to issue a warning? I would guess that it is retained or replaced
> > > with some other magic token.
> >
> > Everything that has the warning (GCC-7+/CLANG-9) has that attribute.
>
> I'd like to make sure we don't regress Coverity most of all. If the
> recent updates to the Coverity scanner include support for the attribute
> now, then I'm all for it. :)

We had this discussion a while ago (October) and the consensus was
that we would like to wait for a while until all tools were ready to
use the attribute and everyone's would be happy:

  https://lore.kernel.org/lkml/20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com/

Is everyone happy this time around? :-)

Cheers,
Miguel
