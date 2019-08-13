Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E93C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061CE20578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCbDyLGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfHMMpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:45:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42977 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfHMMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:45:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so13983082lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nkts4LtZcrW5Ro8T3DBoeBEvb4PQKRLGam7T/wDj6kM=;
        b=gCbDyLGsxRGcOJh7GfxFmlUonqr4quHz2L3/lFXa/6EKL/UL4PUHHgFWHe3kWy/h7t
         04YCNKJAKS+vN9NjQGZAXfhbiwoF4UvmfSzTNiTJ2qAbcnmh7xcXGR3HJm7QcTwBaZ/0
         /043JVdGbc6lGReHJ/e0hMhOqQy5jmvU6MUjDywCZbhbgM++2H2bWCB0CX0ANx4/+q/c
         4FlFE6qHKpCawgEwsblXorra8nij65tLa/MZJEPvWDNKrtJKO99w7xp38U8A4MGJrryY
         k3jOTAKEj79ShwL2q0XBc/TDhUAU0T61QXGwYi78SSkUSAhkFkcXVZ2cXNiyWYjzIGaG
         SXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nkts4LtZcrW5Ro8T3DBoeBEvb4PQKRLGam7T/wDj6kM=;
        b=hwnUz8zaQ9cho42weBWcaFNCVfXP+rPak2MX08wHgjHqcOrsd+B/0kRs6AZsmu3n7r
         H22XMEVZKdk2Bk7HiLD+SJyVSBjWJkr721Pnxj5qkqEOw0JbUzL8S5guEbR2PPxz/rro
         onwx3ifaonD38X7X4RC5FQmff1sE4fU/q61YDxKJIo0Sx9g5TnOnaUMk+14FSderjYqg
         wF4wo/DIva8x3AGToI0rZ4PhdKWbGXGcRlfbqfj1s7Ad32fA61GNuSu9IBuNH47EtP1+
         MgjqFngcT4HfWsBI6Bi7WUlZZ2b05nbTIKc7pvSdc7oQvEzdZaJGAMb5zfgVfH1jSkEx
         yRvw==
X-Gm-Message-State: APjAAAV60tlAvKl26Ze0fioGXJ5bmq1tBR8BIZuzoVCR7/NE1iUiADPT
        WWTAj5/2h1qt88isCO2/jDuevR9me50Gb/+mZb4=
X-Google-Smtp-Source: APXvYqwUPoIpd5D/Mh0oYoT9QxNyIJpNCHvLYJc4MokA3okhFMb2ldK85TeqRu/cOjk3hH53eX2E4RpapaNp0bkDP4Q=
X-Received: by 2002:a19:e006:: with SMTP id x6mr22095212lfg.165.1565700305317;
 Tue, 13 Aug 2019 05:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <20190811020442.GA22736@archlinux-threadripper> <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
 <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
In-Reply-To: <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Aug 2019 14:44:53 +0200
Message-ID: <CANiq72m5=pqHaNi3P5VAMviaoX6yxT7OPg6sys1uMDki0g2bOw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 6:29 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Aug 10, 2019 at 8:06 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
> > > On a tangential note, how are you planning on doing the fallthrough
> > > comment to attribute conversion? The reason I ask is clang does not
> > > support the comment annotations, meaning that when Nathan Huckleberry's
> > > patch is applied to clang (which has been accepted [1]), we are going
> > > to get slammed by the warnings. I just ran an x86 defconfig build at
> > > 296d05cb0d3c with his patch applied and I see 27673 instances of this
> > > warning... (mostly coming from some header files so nothing crazy but it
> > > will be super noisy).
> > >
> > > If you have something to share like a script or patch, I'd be happy to
> > > test it locally.
> > >
> > > [1]: https://reviews.llvm.org/D64838
> >
> > Something like this patch:
> >
> > https://lore.kernel.org/patchwork/patch/1108577/
> >
> > Maybe use:
> >
> > #define fallthrough [[fallthrough]]
>
> Isn't [[fallthrough]] the C++ style attribute?  **eek** Seems to be a

It is going to be very likely also the C spelling too, i.e. C2x will
likely be released with attributes. [[fallthrough]] in particular is
still on discussion but it may be included too (thanks Aaron!).

> waste for Clang to implement __attribute__((fallthrough)) just as we
> switch the kernel to not use it.  Also, I'd recommend making the
> preprocessor define all caps to help folks recognize it's a
> preprocessor define.

Hm... I would go for either __fallthrough as the rest of attributes,
or simply fallthrough -- FALLTHROUGH seems wrong. If you want it that
way for visibility, then I would choose __fallthrough, since the
underscores are quite prominent and anyway IDEs typically highlight
macros in a different color than keywords (return etc.).

Cheers,
Miguel
