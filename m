Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03276C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01DF2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="To7D/hMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfGJKoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:44:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41511 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfGJKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:44:07 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6AAhulH025671
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 19:43:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6AAhulH025671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562755437;
        bh=Ycj0dyamrlngknPhL2bExuJe6wzl8U1lzkiHAV69cic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=To7D/hMWUJ9IgtCP9MIO9lJA3JgygoIzD+wsYK1Q8ZZXAfwR9Kk6N8YSydk/e3Ony
         rPA40GkCVJLulLetS8DlfW77JLx3id0tIZ/N8v2TfO8rVOusM5p+ktQ42k1IPhdyYw
         IuK4otHCZpVOsRnZ+qBJRVCicJCoOKgccl5XWXrfneaLNXj/Qzt4/mIMj1d3PhjiC+
         p98Gxo5tZbCVvKxoMwe2mT44m0i48i/GDRCJ8fPS8GZBFexAhjHvqG1ij7oH5Kt+fN
         VSzsIQxonworOeyGG2v2OALrOfj407ogv9m64cxVEtAuzkgbn4frMwaj4d4Zd8MmAr
         UONU1+81zAp7Q==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id 8so658898uaz.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 03:43:56 -0700 (PDT)
X-Gm-Message-State: APjAAAVZkS8NLKHECPns96gf3Ad9QTkLVBnBIOP28Zsg5Dh21ISAOzQ5
        YdWE+iwZskCNSKXvELfF8qjyeL5QKrtwAY6FOC8=
X-Google-Smtp-Source: APXvYqwHEsdcYnCzgd67nXlol5ygPmUMo59QTZTYbMA0kTqb141HuIHVhJyLIYrjDKw0CAeYYkhkDhhWT5i7r4YelaA=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr7900708uag.40.1562755435802;
 Wed, 10 Jul 2019 03:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
 <20190710082335.uzusesefimzpjd3f@shell.armlinux.org.uk> <CAK7LNAQpiY4CBawEFhQHeTPSrbrRkNoYCtK4jBak+skyyMqESA@mail.gmail.com>
 <20190710100206.yls4piu36wciefbz@shell.armlinux.org.uk>
In-Reply-To: <20190710100206.yls4piu36wciefbz@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 19:43:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3NDem7_oTyPuDVC7QGY=HuyG-GBE9QQhUuuL_Q=CeNg@mail.gmail.com>
Message-ID: <CAK7LNAT3NDem7_oTyPuDVC7QGY=HuyG-GBE9QQhUuuL_Q=CeNg@mail.gmail.com>
Subject: Re: Question about ARM FASTFPE
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 7:02 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 10, 2019 at 06:54:06PM +0900, Masahiro Yamada wrote:
> > On Wed, Jul 10, 2019 at 5:23 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Jul 10, 2019 at 01:30:24PM +0900, Masahiro Yamada wrote:
> > > > Hi.
> > > >
> > > > I have a question about the following code
> > > > in arch/arm/Makefile:
> > > >
> > > >
> > > > # Do we have FASTFPE?
> > > > FASTFPE :=arch/arm/fastfpe
> > > > ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> > > > FASTFPE_OBJ :=$(FASTFPE)/
> > > > endif
> > > >
> > > >
> > > > Since arch/arm/fastfpe does not exist in the upstream tree,
> > > > I guess this is a hook to compile downstream source code.
> > > >
> > > > If a user puts arch/arm/fastfpe/ into their local source tree,
> > > > Kbuild is supposed to compile the files in it.
> > > >
> > > > Is this correct?
> > > >
> > > >
> > > > If so, I am afraid this would not work for O= building.
> > > >
> > > > $(wildcard ...) checks if this directory exists in the *objtree*,
> > > > while scripts/Makefile.build needs to include
> > > > arch/arm/fastfpe/Makefile from *srctree*.
> > > >
> > > > I think the correct code should be like follows:
> > > >
> > > > # Do we have FASTFPE?
> > > > FASTFPE :=arch/arm/fastfpe
> > > > ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
> > > > FASTFPE_OBJ :=$(FASTFPE)/
> > > > endif
> > > >
> > > >
> > > > Having said that, I am not sure this code is worth fixing.
> > > >
> > > > This code was added around v2.5.1.9,
> > >
> > > ... as a _result_ of a discussion and deciding not to upstream it,
> > > but to still allow its use.  Fastfpe is faster than nwfpe (so has
> > > a definite advantage for FP intensive applications) but we decided
> > > we didn't want two FP emulation codes in the kernel.  However, if
> > > someone wants to use it, it has to be built into the kernel, it
> > > can't be modular.
> >
> >
> > IMHO, the entry in Makefile and Kconfig should be removed
> > from upstream, then moved to a part of the fastfpe local patch.
>
> Nope.  It means that rather than it being merely a drop-in, it has
> to be maintained against changes to both these files.  Sorry, that's
> more work.


This is the motivation of upstreaming for everybody.

We never know the code that does not exist in upstream.
Downstream code must pay maintenance cost for ever.


-- 
Best Regards
Masahiro Yamada
