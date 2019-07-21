Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C03C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E322064A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="q5QL+RHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfGUMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 08:13:03 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23229 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfGUMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 08:13:02 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6LCCvWl011978;
        Sun, 21 Jul 2019 21:12:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6LCCvWl011978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563711178;
        bh=MIA0+vFVf3mUGGa03CY80enR4qM7bzkzR410L3fu3TE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q5QL+RHFEViaW/mMvaiRLzKjwSgbDFxpOxs/RfKREU7HS8r89mC2Bz7zMjVOaXyXn
         tcMALk0yb+puadsgO9+2y8TVFyRAZ4y0mLCm+cBkvl+tEprAF+7gkmzX8cgn+OYJeS
         I1sV136C7Hgcgdk00LjWZBn14Xab9lSJwKzufWhEcHDnSMGrjPKmc/uqG/kmhYCRn2
         Dqx/mXqAwm5ImwYiX1+4i1CnHusTEZf3G3ZNGaVd588g98vmsQtltf0TjPbzdezDYY
         4Z8PoTYL21ClgrHmq3rlcy3Q8zuOy8BZK6I88MDOCTGWAha5Y0Q+Ir4P3N1cLKJpK0
         DzewVIvkwKM3A==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id o2so14278655uae.10;
        Sun, 21 Jul 2019 05:12:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUR7Jmw0z83SSha3vK7PnS7NpS6cqB76g0Fw24RVjSKF/VrpH2G
        efmLBtClXZx1B4EEaVYkH7appSuaYyRltuC93jc=
X-Google-Smtp-Source: APXvYqxuBnjaSyRpGv3ZxRVy/hU0ZW6/IruER15xQdcM9a/uJ7XwnfPu3iofGBzVr2dqeJUH5StCwXqmj4pJ02ZB0yo=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr25208724uad.121.1563711177169;
 Sun, 21 Jul 2019 05:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
 <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com> <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com>
In-Reply-To: <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 21 Jul 2019 21:12:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com>
Message-ID: <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 6:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jul 21, 2019 at 5:45 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Sat, Jul 20, 2019 at 10:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > > > So, what shall we do?
> > > >
> > > > Drop the board-file support? Or, keep it
> > > > in case somebody is still using their board-files
> > > > in downstream?
> >>
> > > For this file, all boards got converted to DT, and the old setup
> > > code removed in commit ebc278f15759 ("ARM: mvebu: remove static
> > > LED setup for netxbig boards"), four years ago, so it's a fairly
> > > easy decision to make it DT only.
> >
> > I see another case, which is difficult
> > to make a decision.
> >
> > For example, drivers/spi/spi-tle62x0.c
> >
> > This driver supports only board-file, but the board-file
> > is not found in upstream.
> >
> > Unless I am terribly missing something,
> > there is no one who passes tle62x0_pdata
> > to this driver.
> >
> > $ git grep tle62x0_pdata
> > drivers/spi/spi-tle62x0.c:      struct tle62x0_pdata *pdata;
> > include/linux/spi/tle62x0.h:struct tle62x0_pdata {
> >
> > But, removing board-file support
> > makes this driver completely useless...
>
> Adding Ben Dooks to Cc.
>
> I suspect this driver is completely obsolete and should be removed.
>
> For some reason, it's not an SPI controller driver like all the other
> files in that directory, but implements low-level access to the state
> of a particular SPI device.
>
> However, there should not really be a low-level driver for it that
> just exports the pins to user space. It should either be a gpiolib
> driver to let other drivers talk to the pins, or a high-level driver that
> exposes the intended functionality (watchdog, regulator, ...)
> to those respective subsystems.
>
>        Arnd


Another example that I have no idea
how it works:

drivers/net/hamradio/yam.c

yam_ioctl() reads data from user-space,
but the data structures for ioctl are
defined in include/linux/yam.h

This header is not exported to user-space
since it is outside of the uapi directory.

I dug the git history, but it has never
exported to user-space in the past.

I do not know how user-space programs can
pass-in data to the kernel.

If we want to fix this, we could move it
to include/uapi/linux/yam.h

But, if nobody has reported any problem about this,
it might be a good proof that nobody is using this driver.

Maybe, can we simply drop odd drivers??


-- 
Best Regards
Masahiro Yamada
