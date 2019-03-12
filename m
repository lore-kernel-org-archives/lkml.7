Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C6214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kRhF3ypD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCLFhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:37:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28562 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfCLFhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:37:04 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2C5avSU001330;
        Tue, 12 Mar 2019 14:36:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2C5avSU001330
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552369018;
        bh=lhKJrFRsXpVQ3gIrx8behZH6ffnT+QME0xZWR+k1SZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kRhF3ypDLRvYFrsqaBxKXcy2GTP4CrUI98KUqoXLgE5YcDc7222ItNz1/J6OCDt9T
         xCP4O9KrEp76QNvz1i4eH/eJFOoDIbEZaOd4cAToE0bm9EntvtKq0R3BPofV4AyYfQ
         RVumlecIYdebxQiDH820zaORBBkPWp60oMu5qXQKrsKW2lcp90cVgIAFkcMknF5tTe
         gBHZYsp57dD/gVKRcaEcPVz8rCc/noIZAgYCJhHLG6Ogy8+0HFdQymigXeS28EFV+L
         gJlr/Dk4aRh+j5O+lEmYP9MrN+NRvdHKwHV+NvEieZ5+kLsW/XfNqEKyGhnSQ2rwJr
         gpRA+VT3C+l8g==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id w14so855012vso.6;
        Mon, 11 Mar 2019 22:36:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUC3K0wXSxGZ4uASore7QPmHITLJy+Tkwr/4q8Pnyf3hK2lOthO
        5gb2ilIQ+9kzCOktPdufdIS0UrQnOASKQrnfrOU=
X-Google-Smtp-Source: APXvYqxvddPTvSVgR3DYOIAQp0F2cEy1P5WNynfAfXnbTPpDR8fwPXhkLoa6T6kRT7nIcyCXPNEUR7Mqh0EMddwvOoM=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr19094259vsq.181.1552369017355;
 Mon, 11 Mar 2019 22:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com> <20190308085733.GA3903@icarus>
In-Reply-To: <20190308085733.GA3903@icarus>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 12 Mar 2019 14:36:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
Message-ID: <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 5:57 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Fri, Mar 08, 2019 at 09:31:00AM +0100, Linus Walleij wrote:
> > On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> > <vilhelm.gray@gmail.com> wrote:
> >
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
> > >
> > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >
> > Andrew: would you be OK with this being merged in v5.1?
> >
> > If we need to move the code to drivers/gpio that's OK (though
> > I think it's generally useful) but I need to know to proceed with
> > the William's nice optimization of these drivers.
> >
> > Yours,
> > Linus Walleij
>
> I was waiting on Andy to suggest some examples out of the GPIO realm,
> but he may be under a heavy workload right so I decided to do a quick
> search for one.
>
> In drivers/of/unittest.c, there is loop across a bitmap in the
> of_unittest_destroy_tracked_overlays function:
>
>         for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
>                 if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
>                         continue;
>
> This section of code is checking each bit individually, and skipping if
> that bit is not set. This looping can be optimized by using the
> for_each_set_clump8 macro


Probably no.


I see this comment before the loop.
/* remove in reverse order */


Also, the unittest code handles per-bit
whereas your helper does per-byte.





> to skip clumps of nonset bits (not to mention
> make the logic of the code much simpler and easier to follow by reducing
> the code to a single line):
>
>         for_each_set_clump8(id, clump, overlay_id_bits, MAX_UNITTEST_OVERLAYS-1)
>
> The for_each_set_clump8 macro is not specific to the GPIO subsystem; I
> just happen to use it in these GPIO drivers simply because I am most
> familar with this section of the kernel (it's where most of my
> contributions occur afterall).
>
> Consider this, if I am able to find a use for this macro outside of the
> GPIO subsystem within a matter minutes, then there must be some benefit
> in allowing the rest of the kernel to use the for_each_set_clump8 macro.
> So let's put it in bitops.h rather than restrict it to just the GPIO
> subsystem.


If we do not find useful cases in other subsystem,
this patch set looks over-engineering to me.






> William Breathitt Gray


--
Best Regards
Masahiro Yamada
