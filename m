Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7724C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0FE208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fphZv3Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH1Qoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:44:34 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:29386 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:44:33 -0400
X-Greylist: delayed 122884 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 12:44:32 EDT
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7SGiTPF015371;
        Thu, 29 Aug 2019 01:44:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7SGiTPF015371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567010670;
        bh=e1hH8CBw3pTYY3HHzh3H8POLx73d67OzfAZZG2jnVkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fphZv3IiMtuovqUjlnhdmushuHpkmH7AEwh4QA9h3lPHf8yP6K5/NEEjoUtOMQGiQ
         sNE8g4gkK9OCYIeVTzhXv/aMzEeYk6165vAC6Q3N8gR/R8uZMxUpgW1ksJFU9HXZmn
         0jyylpTJS32QbeaWhdLWOp2NS9F3OcvG694tqCz7c4SB9sRIXkU74Fc5FVyHs3gzps
         siZVhZ9GBGzBgK9mKO7HGwdKK4q8qNcM3XB31kFB3E6WNrv0NTIFL+74t3X3TM5l+8
         bL6cjLvCi3eLBuC2N8xYVvkUN+YlTaf68qUW0J96HIgLlSc1T8re+Q3q5WL0akQha2
         Ox7pACGvE3tRg==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id q16so435542vsm.2;
        Wed, 28 Aug 2019 09:44:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXguinGtI0Af7bAHhy211VSFEGRFCHFJ2DbcqF6Htmgg/G2c2sh
        pmmVXkKl+P4TAGoT6bRvRtTlvb2PujmPBOzFEaI=
X-Google-Smtp-Source: APXvYqzSBjxbOQ79LtktP5SLi0bZ7ZwT63m8MldDi3aE51M3q/PPrjo1Is6aX8D4g8xsNBY3kQ2m291dBDxhQtwOHBw=
X-Received: by 2002:a67:8a83:: with SMTP id m125mr2945317vsd.181.1567010668683;
 Wed, 28 Aug 2019 09:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190819055421.13482-1-yamada.masahiro@socionext.com> <CAMuHMdVpn01Tcjm1Z3Jp--kiNYf4R5=AyH-huc26RwP19w9OZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVpn01Tcjm1Z3Jp--kiNYf4R5=AyH-huc26RwP19w9OZQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 29 Aug 2019 01:43:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNARB_LO=DWKQ-vcKSNkTih_3XhjqD-f8-VmSKmGZD=iHRQ@mail.gmail.com>
Message-ID: <CAK7LNARB_LO=DWKQ-vcKSNkTih_3XhjqD-f8-VmSKmGZD=iHRQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add CONFIG_ASM_MODVERSIONS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 6:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Aug 19, 2019 at 7:55 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > Add CONFIG_ASM_MODVERSIONS to remove one if-conditional nesting
> > from Makefile.build
> >
> > This also avoid $(wildcard ...) evaluation for every descending,
> > but I did not see measurable performance improvement.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
>
> >  arch/m68k/Kconfig      | 1 +
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --

Applied to linux-kbuild.


> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Best Regards
Masahiro Yamada
