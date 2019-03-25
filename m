Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B600A2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZyjtIOVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfCYHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:55:46 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56128 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbfCYHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:55:46 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2P7tN2j014159;
        Mon, 25 Mar 2019 16:55:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2P7tN2j014159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553500524;
        bh=MNSR/rEIOcAArewi0EIYzwa6W/vsUcqG4KdVofhTqSQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZyjtIOVpxyBOn4a6GEYMaFwQC4gc8MCYc/7NgGdBpVa2FuzM12sLcCIlTGJy1MjVG
         yVehg7hPuPh/1x0qXuamzJ1Y4wpJ17F/dkiaeG4rEtT+ju726ZJNrToCekEjCqdAA9
         DA1eP1H08jc8sFzbUKRHHjZBOG8NwMNNH4SBy5MglHwghLHDHNIMkuwYTGJzqteZ+j
         xyuox9+hVSVVG7sViwPAS/HdEnDsye6OVQfv4MwXZscFM5Eqmjm5dXac2F1ra8FVRY
         F9Z/w5/abZ9TQRC3oKrSwGy6uQljW+Z416w1T429hpv0gyVgqArEPkMd55ng9LMoE+
         SeleNW2vuSs0g==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id x1so2675303uaj.4;
        Mon, 25 Mar 2019 00:55:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWf9ZqOA9seiszlEaA4AbQF4HBqoWf4KEqCT+uJEkxoCiJfn4RB
        xQpk0vnnaPZ2kAxG1bPYIsYdkNWjw3nmC7AEVQA=
X-Google-Smtp-Source: APXvYqyhekNOWsqEE0/Be7lm9WkHu4bw/ySyZW5oHyXthk2oN26mxaoB5RYhMA6O73DJhsq2BgV3+fx1ravROmYHO3M=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr13096065uap.121.1553500523266;
 Mon, 25 Mar 2019 00:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com> <CAK8P3a1P812avY8reSSguYB0jPzgjs+30dSJpKZCnWwzyLoSVQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1P812avY8reSSguYB0jPzgjs+30dSJpKZCnWwzyLoSVQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 25 Mar 2019 16:54:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
Message-ID: <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 4:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 25, 2019 at 7:11 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Wed, Mar 20, 2019 at 10:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > I've added your patch to my randconfig test setup and will let you
> > > > know if I see anything noticeable. I'm currently testing clang-arm32,
> > > > clang-arm64 and gcc-x86.
> > >
> > > This is the only additional bug that has come up so far:
> > >
> > > `.exit.text' referenced in section `.alt.smp.init' of
> > > drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> > > `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
> > >
> > > diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> > > index 201100226301..84b12e33104d 100644
> > > --- a/arch/arm/kernel/atags.h
> > > +++ b/arch/arm/kernel/atags.h
> > > @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
> > >  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
> > >         unsigned int machine_nr);
> > >  #else
> > > -static inline const struct machine_desc *
> > > +static __always_inline const struct machine_desc *
> > >  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
> > >  {
> > >         early_print("no ATAGS support: can't continue\n");
> > >
> >
> >
> > I do not know why to reproduce it,
> > but is "__init __noreturn" more sensible than
> > "__always_inline" here?
>
> It's in a header file, so it has to be 'inline'. We could make it
> static inline __init __noreturn,

Yes, I like 'static inline __init __noreturn'

> but I don't see an advantage over
> __always_inline there.

__always_inline takes away the compiler's freedom.

I'd like to leave it up to the compiler where possible.

The inlining decision may change
depending on -O2, -Os, -Og(which was rejected)
or whatever optimization strategy.


>
>         Arnd
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



-- 
Best Regards
Masahiro Yamada
