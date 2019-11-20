Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017FCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8771A2243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yrPlmMLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfKTJCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:02:53 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49060 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfKTJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:02:53 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xAK92nZm005778
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 18:02:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xAK92nZm005778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574240570;
        bh=m7KBfeLVUaVldoeCBn57xyKRXioAEHJWAKA15h/kKOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yrPlmMLjrm/420zfmfGBS/I0SF/s2iL/7hwEfaEhsOs+k8UHF2vDwkAoNgAVpZxy7
         YEynptZPHZuFMMjbYHVD7PQYxaicQ09vQ7jKxTKMR7WjTMx4xUoh8UAc/vzW7DDM11
         r3vKSYZvXjmigjkK2Nq9FQEfvLP2bxo/CIsMdx+q73pYa727Ckh2cBGsfmluZnVjk4
         cd00+k1Q6NuMXioEzpsV5x2NBuwUZC90uqjNtsrVB94x2CJVRe0WlWlr2Jw4lOX+vD
         NEYfzpQvVMWLTjBLsZ6qOEOhnhKpJrR/wJrP6HovZn/ZXzjvMzlT3ARKBKj9jHoPcJ
         UhFPpHNSeV6Tg==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id l5so5833566vkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 01:02:50 -0800 (PST)
X-Gm-Message-State: APjAAAXB7uQtr6sUdXLBd9aVfYLe8h5wkNMi50RZyZWNSS782sdaEk2I
        lxUZ6ZbwRubNkGYb4tlixtBMy5am2E9+JCkcVB0=
X-Google-Smtp-Source: APXvYqzHf4xseGQAK2EkTNNwcmQcZHl3J1GGFg4Z1/Q9olKn7GOSfLFb/CAj4UlR2ei54LDLujGeeSWN3AoM04Sd0IY=
X-Received: by 2002:a1f:7387:: with SMTP id o129mr807276vkc.73.1574240569015;
 Wed, 20 Nov 2019 01:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de> <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk> <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
 <20191113170058.GP25745@shell.armlinux.org.uk>
In-Reply-To: <20191113170058.GP25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Nov 2019 18:02:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
Message-ID: <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,



On Thu, Nov 14, 2019 at 2:01 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> > Hi Russell,
> >
> > On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > > function and does not need to be exported, as shown by this warning:
> > > > > >
> > > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > >
> > > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > > >
> > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >
> > > > > > --- a/arch/arm/kernel/return_address.c
> > > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > > >                 return NULL;
> > > > > >  }
> > > > > >
> > > > >
> > > > > Checkpatch doesn't like the empty line above:
> > > > >
> > > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > > >
> > > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > > +
> > > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > > >
> > > > > > -EXPORT_SYMBOL_GPL(return_address);
> >
> > > > What has happened to this patch?
> > > >
> > > > I still see this warning.
> > >
> > > Simple - it got merged, it caused build regressions, it got dropped.
> > > A new version is pending me doing another round of patch merging.
> >
> > I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?
>
> I don't keep track of who did what, sorry.


Arnd,

I believe this patch is the correct fix.
Could you please put it into Russell's patch tracker?
(patches@arm.linux.org.uk)





> >
> > [*] Commit 0b0617e5a610fe12 ("ARM: 8918/1: only build return_address() if
> >     needed"), which I discovered in next-20191031 when checking if Arnd's
> >     patch was applied....
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up


-- 
Best Regards
Masahiro Yamada
