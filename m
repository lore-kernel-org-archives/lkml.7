Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94D8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEFC217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kri2Ds8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfHaNFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 09:05:37 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56629 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfHaNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:05:37 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7VD5TqB020331
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 22:05:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7VD5TqB020331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567256730;
        bh=0xiVhnfMMmWO7lCRxWhVZrU4jkaKCy6a+KRY9o5Jbu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kri2Ds8ogcpZ2aBA93wUjYRsVQbbjbOWH2D6G/dOSdnKir2gS5V1TM/6yieK7qgKE
         eVm0WFRanEcgOzQHud1R5JxHI/O6q1SNZe+IF7JhqcaWhqnM4LGq/UgH5CYVZv1h+r
         MAkSGmVUQ/7JIt96MMoy4+U2cozp/24KxQvpcN/ccAcRXh9zC2MykC65Mfp5x6Kdwr
         lc/bNeFNZxD+9mcf1HlekuYs9IXiFv+OET/PAMjbuU+4NClcpK9oGr9dRE68K0xgS5
         WLkX9ap+KaS6hfWWQUGSrY0zCscNmDUMfjxMCass6xSgmQzB1X+q7KywlplZm1ZlF3
         DYtxlHRFlESIA==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id b2so3175849uak.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 06:05:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWDUVp2lJhnu/Vchoe0SNwd7OhR1MYUfPztjqpqbzVRIyk4x0BM
        li6Co6E8MHeC7g2+S/qmudCVT3SVzBorjx/w3BI=
X-Google-Smtp-Source: APXvYqzR9pk5p/4jleHhBZpmxoBL+K0heyBbkkV3l4/DuJMvaVfcKNJWdK4dQsrXO2z6et1E1AIQjB5xOdX55JpYFX4=
X-Received: by 2002:ab0:32d8:: with SMTP id f24mr10368580uao.121.1567256729042;
 Sat, 31 Aug 2019 06:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
 <20190826113526.GA23425@infradead.org> <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
 <20190830155322.GA30046@infradead.org>
In-Reply-To: <20190830155322.GA30046@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 31 Aug 2019 22:04:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2JuZkdJGxO=f2hUxmQca5d7430NC-2hiqZwkJphJ9sA@mail.gmail.com>
Message-ID: <CAK7LNAR2JuZkdJGxO=f2hUxmQca5d7430NC-2hiqZwkJphJ9sA@mail.gmail.com>
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:53 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Aug 27, 2019 at 02:14:59PM +0900, Masahiro Yamada wrote:
> > There is a small documentation about "Makefile" vs "Kbuild"
> > in Documentation/kbuild/modules.rst section 3.2
>
> I know that part.
>
> >
> > It is talking about external modules, but the benefit applies
> > to arch/$(SRCARCH)/Kbuild as well.
>
> I fail to fully understand this part, though.

Kbuild support two file names, "Makefile" and "Kbuild"
for describing obj-y, obj-m, etc.

If both exist in the same directory, "Kbuild" takes precedence.

This is useful where we want to use "Makefile"
for other purposes.

For external modules, we use "Makefile" as a start point,
so we often want to  describe obj-m in "Kbuild" instead of "Makefile".


Similarly, arch/$(SRCARCH)/Makefile is very special
in that it is included from the top-level Makefile,
and specify arch-specific compiler flags etc.

We can use arch/$(SRCARCH)/Kbuild
to specify obj-y, obj-m.
The top-level Makefile does not need to know
the directory structure under arch/$(SRCARCH)/.

This is logical separation.


>
> > arch/$(SRCARCH)/Makefile is included by the top Makefile
> > to specify arch-specific compiler flags, etc.
> >
> > On the other hand, arch/$(SRCARCH)/Kbuild, if exists, is included
> > when Kbuild actually descends into arch/$(SRCARCH)/.
> >
> > This allows you to hierarchize the sub-directories to visit
> > instead of specifying everything in flat in arch/$(SRCARCH)/Makefile.
>
> Yes, but what is the plan in the long run?  arch/$(ARCH)/Makefile
> is still a weird hodge-podge of overriding global variables and misc
> Makefile targets, it now just has a tiny little work.

There are lots of arch-specific build settings.
We definitely need a place to describe them,
hence arch/$(SRCARCH)/Makefile.


>  Is there any
> actual benefit from using Kbuild for the build process?

For example, arch/x86/Kbuild is quite useful
since there are many directories in arch/x86.

riscv does not have many directories for now since it is a new architecture,
but it will be useful when it will have more directories.


>  Can we
> eventually move the setting of variables in the Makefile into another
> special purpose file?  Is the support for actually compiling kernel
> source files from the arch/$(ARCH) Makefile eventually going away?

No, I do not think so.

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
Masahiro Yamada
