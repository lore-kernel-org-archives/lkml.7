Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ABC46460
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861032083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KaTiRT+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEELn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 00:11:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19909 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:11:42 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x554BINJ019657;
        Wed, 5 Jun 2019 13:11:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x554BINJ019657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559707879;
        bh=QsPdivrwLdOGJOU/WFMS+cKg91hI/bfOVvEmq1t5e7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KaTiRT+70eGEthJy3jCbqL3AT3gCdATYa7dabpfZVDEeI7QNk+qBtEEOEY5/E8Z4d
         trUCJD+BuOXJmLtNo7afZFqUjWpkZ5DXs54yxGoDir/aS2zf8XSsH5faWlek+j0LAF
         f10aTyifAvJopefUk2mYI78Dg1bZiHevtzdxdzahAZx8U4uIDcttBWq6m9iaiPf8C7
         5d6Z/M1P+NlwH05UjgJWpqsk4bc86W6S7TgckQShizZ9XMtmmslycSrx3hANdbtIqK
         u2PPQXdxjKhpT88I5aDpOGRnaznaLO4yO3i+bSiMiLOgmK6wfR2cILvLZun7K4utJj
         MsAfqiwoLKkvA==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id a95so8607048uaa.13;
        Tue, 04 Jun 2019 21:11:18 -0700 (PDT)
X-Gm-Message-State: APjAAAV1Ugbdx3KJFlcIQGGbeRcZcx5imPZqbkovmK98zXFc/nzzIs36
        LBaGl+a7gIdcohHLuWTb7dAC00AIu0EZ37v6ZmM=
X-Google-Smtp-Source: APXvYqzz4qFiscI0xcqKkDE7UFFJBKkvkW6TWgtTPNQURXJ4y01rFQKCdNp2WsgYNUCG2fQMZ0dGQ2rX4eSLLDWZnh0=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr19527123uab.40.1559707877666;
 Tue, 04 Jun 2019 21:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190604111334.22182-1-yamada.masahiro@socionext.com>
 <8cf48e20064eabdfe150795365e6ca6f36032e9f.camel@perches.com>
 <CAK8P3a1oDfNF_T+NCoPsXkJAY2x4_uCWSwrDXHi7dDSaMqfnfA@mail.gmail.com>
 <CAK7LNAS0Ph2Z6x0-UPSkJUC31NvPi09BmFrve+YJcXMrop-BGA@mail.gmail.com>
 <20190604134213.GA26263@kroah.com> <CAK7LNARyqW3q6_46e-aYjmF8c0jUNDLdyB28zNaBEXqTV+5QSA@mail.gmail.com>
 <CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 5 Jun 2019 13:10:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNARU+uT0aUBh5niwEafL8+Ok7=sOZYukptpDH1w7Cii3hQ@mail.gmail.com>
Message-ID: <CAK7LNARU+uT0aUBh5niwEafL8+Ok7=sOZYukptpDH1w7Cii3hQ@mail.gmail.com>
Subject: Re: [PATCH] media: do not use C++ style comments in uapi headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 3:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > There are two ways to define fixed-width type.
> > > >
> > > > [1] #include <linux/types.h>, __u8, __u16, __u32, __u64
> > > >
> > > >       vs
> > > >
> > > > [2] #include <stdint.h>, uint8_t, uint16_t, uint32_t, uint64_t
> > > >
> > > >
> > > > Both are used in UAPI headers.
> > > > IIRC, <stdint.h> was standardized by C99.
> > > >
> > > > So, we have already relied on C99 in user-space too.
>
> A related problem is that using the stdint.h types requires
> including stdint.h first, but the C library requires that including
> one standard header does not include another one recursively.
>
> So if sys/socket.h includes linux/socket.h, that must not include
> stdint.h or any other header file that does so.


This means we cannot reliably use uint{8,16,32,64}_t in UAPI headers.


[1] If we include <stdint.h> from linux/foo.h

    If sys/foo.h includes <linux/foo.h> and <stdint.h>,
    it violates the C library requirement.


[2] If we do not include <stdint.h> from linux/foo.h

    If sys/foo.h includes <linux/foo.h>, but not <stdint.h>,
    we get 'unknown type name' errors.


-- 
Best Regards
Masahiro Yamada
