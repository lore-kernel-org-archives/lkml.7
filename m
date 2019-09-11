Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED5ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE721479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JG6jeoYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfIKIfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:35:31 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47998 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfIKIfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:35:31 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x8B8ZPmY004596
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 17:35:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x8B8ZPmY004596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568190926;
        bh=UbX3WXF/x+Rp6FshhKSMSv77yFQt2MJQYXIacczcOm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JG6jeoYkIoyz9hVMNylQov1lsadJ2Ymk3kcG9THkhfzDB8Qn8Od+1+s0ZZOcLUDVM
         1lB4XH1BOtZ/bgRDoPLV4+8XoCf+UMs0FreaCRdlnowCCLxHEMjx3nvcRB9HYWcIxF
         6n7GTRrARLGqFJneU1JbnQOG5+irb8BZOd50v9WAGuI4vt42irBbO3KLyfsT50YQhd
         PLLUp3iraO/oHZ0ZYjUCIthcBTkySj+/r4VE+J0nYpGDkm9GPtVkIsP0Ec3HUF6DSh
         V07P9LxtPMOQ5WcjjlLzkDLhJ3DRNPS1HFbW4DJwbhjuJdvVOVj1mpyC7nCnNJfxlw
         3XMVokxUZswJQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id i17so6503669ual.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 01:35:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWLr2+UdsbNATU+8iIcDgsGwevVjwoPKswyTL0V9HXyKVZmbtLx
        X+v5wbS/WEdURG5DQie3GX+PR3vlTwKm5fam45w=
X-Google-Smtp-Source: APXvYqw2os4SpkKt9TYxK/NIhy5fZfjI/sZqp463uL6bUWD5LsVyITxvYtnxTtE218CqYv1VBusgmxJzlWgdcXn4jzs=
X-Received: by 2002:a9f:3f8a:: with SMTP id k10mr16907716uaj.121.1568190924800;
 Wed, 11 Sep 2019 01:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190905054647.1235-1-james.tai@realtek.com> <CAK8P3a13=VBZnj6E=s7mZk0o7Q3XkMHgcsL12s-3psuOWsfOtQ@mail.gmail.com>
 <43B123F21A8CFE44A9641C099E4196FFCF8DA1D0@RTITMBSVM04.realtek.com.tw> <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
In-Reply-To: <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 11 Sep 2019 17:34:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATpbAMGU1u6T_1tX57mHbCR-57q+kDwXMOHAJ2R5kvfrg@mail.gmail.com>
Message-ID: <CAK7LNATpbAMGU1u6T_1tX57mHbCR-57q+kDwXMOHAJ2R5kvfrg@mail.gmail.com>
Subject: Re: [PATCH] ARM: Add support for Realtek SOC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?SmFtZXMgVGFpW+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
        "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thierry Reding <treding@nvidia.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 5:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 11, 2019 at 9:46 AM James Tai[=E6=88=B4=E5=BF=97=E5=B3=B0] <j=
ames.tai@realtek.com> wrote:
> > > Subject: Re: [PATCH] ARM: Add support for Realtek SOC
>
> > > > @@ -148,6 +148,7 @@ endif
> > > >  textofs-$(CONFIG_ARCH_MSM8X60) :=3D 0x00208000
> > > >  textofs-$(CONFIG_ARCH_MSM8960) :=3D 0x00208000
> > > >  textofs-$(CONFIG_ARCH_MESON) :=3D 0x00208000
> > > > +textofs-$(CONFIG_ARCH_REALTEK) :=3D 0x00208000
> > > >  textofs-$(CONFIG_ARCH_AXXIA) :=3D 0x00308000
> > >
> > > Can you explain why this is needed for your platform?
> > >
> > We need to reserve memory (0x00000000 ~ 0x001B0000) for rom and boot co=
de.
>
> Ok.


I do not like this much.

This platform is ARCH_MULTI_V7.

ARM_PATCH_PHYS_VIRT allows you to place the kernel image
anywhere in memory as long as the base is aligned at 16MB.

The minimum 'textofs-y :=3D 0x0008000' + extra 16MB offset
will create a space (0x00000000 ~ 0x01008000).

This is more than needed, but it is not a big deal
to waste some megabytes of memory.


--=20
Best Regards
Masahiro Yamada
