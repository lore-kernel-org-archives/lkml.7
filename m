Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E5C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDBB205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NOEhhW3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfH0Kuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:50:40 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20714 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0Kuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:50:39 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x7RAoStd002072
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 19:50:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x7RAoStd002072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566903029;
        bh=0YvOYKO6swHD2FTAL2lMqubhlo95n2MjqRKh3Qr6Ado=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NOEhhW3U2kBrS91iwret1nBrbuKco5aTFc7aKvYGBS29jk6kAPTwD3G1sfo9wkwop
         dLoTkKQh/wrjFilSoLiYOE3UfsccoPBee9HjZyyK04+EyVLisU6hwh2LaBzNYUKDIE
         nDM80mqtwsmXNs/n2R0MeXAnugJTkDT0CZqek2liDItttmHU4J6uWcmFob+gfjB8dg
         eduTA8ZF47JMwtYXKEVLSU5KO3MPlnfqqzmwAPRoTe2GIjP7C+fbTLvWPTQd1Dwnfv
         v90mp1oWPqH5fAhks3kPhF0kYefEg6WCrkGxTW9dSxfZcCbsUdxCTCwROPpAlQXMeK
         ls/S7gssYu56Q==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id b204so4680145vka.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:50:28 -0700 (PDT)
X-Gm-Message-State: APjAAAW2/B2ZYOGW5SpiKjNo8PdsdVJNfv+2BZxxRIFh7nGyFu1mKhzv
        Sz5wb+G2duVlNAL9i3Xnpk5GaCdepRshElAmHIc=
X-Google-Smtp-Source: APXvYqz3h6sI+d4ZBuJSJlMB3YCxZ0K6x67pattqRT/HuAHrEYknqOfhOIJwLXnfzPTldQEs+j++MhyOFT6UBja0gVw=
X-Received: by 2002:a1f:5dc2:: with SMTP id r185mr9917905vkb.64.1566903027779;
 Tue, 27 Aug 2019 03:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
 <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com> <1566899033.o5acyopsar.astroid@bobo.none>
In-Reply-To: <1566899033.o5acyopsar.astroid@bobo.none>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Aug 2019 19:49:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
Message-ID: <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Nick Desaulniers's on August 27, 2019 8:57 am:
> > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> I'm looking into a linkage failure for one of our device kernels, and
> >> it seems that genksyms isn't producing a hash value correctly for
> >> aggregate definitions that contain __attribute__s like
> >> __attribute__((packed)).
> >>
> >> Example:
> >> $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
> >> Defn for struct foo == <struct foo { int bar ; } >
> >> Hash table occupancy 1/4096 = 0.000244141
> >> $ echo 'struct __attribute__((packed)) foo { int bar; };' |
> >> ./scripts/genksyms/genksyms -d
> >> Hash table occupancy 0/4096 = 0
> >>
> >> I assume the __attribute__ part isn't being parsed correctly (looks
> >> like genksyms is a lex/yacc based C parser).
> >>
> >> The issue we have in our out of tree driver (*sadface*) is basically a
> >> EXPORT_SYMBOL'd function whose signature contains a packed struct.
> >>
> >> Theoretically, there should be nothing wrong with exporting a function
> >> that requires packed structs, and this is just a bug in the lex/yacc
> >> based parser, right?  I assume that not having CONFIG_MODVERSIONS
> >> coverage of packed structs in particular could lead to potentially
> >> not-fun bugs?  Or is using packed structs in exported function symbols
> >> with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
> >> missed?
> >
> > Ah, looks like I'm late to the party:
> > https://lwn.net/Articles/707520/
>
> Yeah, would be nice to do something about this.

modversions is ugly, so it would be great if we could dump it.

> IIRC (without re-reading it all), in theory distros would be okay
> without modversions if they could just provide their own explicit
> versioning. They take care about ABIs, so they can version things
> carefully if they had to change.

We have not provided any alternative solution for this, haven't we?

In your patch (https://lwn.net/Articles/707729/),
you proposed CONFIG_MODULE_ABI_EXPLICIT.
If it is good enough for distros, we merge it first,
give them time to migrate over to it, then finally remove modversions??


> I think we left that on hold because some of the bigger distros were
> heading into releases and we didn't care to cause pain. I wonder if
> we could try again.

I agree.


>
> What's your requirement for versioning?

I added Ben Hutchings to CC.

>
> Thanks,
> Nick



-- 
Best Regards
Masahiro Yamada
