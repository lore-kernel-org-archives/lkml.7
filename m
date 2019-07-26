Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70253C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E0022C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="g70s3j2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGZAVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:21:12 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51692 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfGZAVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:21:12 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x6Q0KnEE020286
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 09:20:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6Q0KnEE020286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564100451;
        bh=pg98lHoe1l0H5EciMrlqYmJIblQK4FXsTmu48LMIVzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g70s3j2IpkJw1UaV6o5PyHdYwe+ki++xWzo3tFwM1T64zklLZr4AtCPBvM3lgXakF
         A5qA14QGSeZrxUPm3GJubMzMxMLTautcEYRFtizeOOahC9MVU4ghtzPZMX7IQUHNid
         BAe6/e+JJhblKzBHn9Z3XEH56ZkJV4j8ZdiSuMG+mwTswtQ5FYnDr6SFHm0eKnMUtn
         z09IU40BdZgPi2AFR/qNcbAQdBoUwUpGgs+FVsJ3M3GWMTwlZQarDxhUpl30pHTSbm
         SgGUOFqBA9cZU1Y4G19c06sNTrvhGSBISxmUz9jynVuPwj2Duuv6ZDjP59tf6kUC8D
         YWZhEbs95e60w==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id g11so20606849uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 17:20:50 -0700 (PDT)
X-Gm-Message-State: APjAAAVc1QahJ8zqKg9GXJ9VL26q8ykDdW3KTD8Ua1LuP6KK6rISdErd
        N1hRhLvpTTM8Kdcq4JZkOU3W/ZtY3DdzIAqMG0Y=
X-Google-Smtp-Source: APXvYqxxGW3wJ7fdEdMiG85EQFTRz8LdMcvss8y9liVsOISiZ6NZSnuP/Zf62Nk5ECrUZnU+Ba/fB7VdcD9zu0zJoiw=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr32323313ual.109.1564100449300;
 Thu, 25 Jul 2019 17:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190718163523.18842-1-yamada.masahiro@socionext.com> <20190725164614.GJ1330@shell.armlinux.org.uk>
In-Reply-To: <20190725164614.GJ1330@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 26 Jul 2019 09:20:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEOS5Sepr9YcfpDRA_ewrwP0s498tgn7A-BVbeZDkjqw@mail.gmail.com>
Message-ID: <CAK7LNASEOS5Sepr9YcfpDRA_ewrwP0s498tgn7A-BVbeZDkjqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: visit mach-* and plat-* directories when cleaning
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     patches@arm.linux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 1:46 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jul 19, 2019 at 01:35:23AM +0900, Masahiro Yamada wrote:
> > When you run "make clean" for arm, it never visits mach-* or plat-*
> > directories because machine-y and plat-y are just empty.
> >
> > When cleaning, all machine, plat directories are accumulated to
> > machine-, plat-, respectively. So, let's pass them to core- to
> > clean up those directories.
>
> You don't say what actual, real-life issue this patch is solving.
> Which files are left behind by a "make clean" ?
>
> From what I can see, this only matters if there are extra files that
> are generated (and have set extra-* or clean-*).  Everything else is
> cleaned up via the big find command in the top level makefile.
>
> Or is this a "it would be nice if..." patch?
>

This is a prerequisite for the following:

https://lore.kernel.org/patchwork/patch/1059150/
https://lore.kernel.org/patchwork/patch/1059149/

If this patch lands in upstream, I will resend them.


The motivation of the two is to avoid unneeded
re-compilation of kernel/kheaders_data.tar.xz

This is a race condition between
scripts/gen_kheaders.sh and arch/arm/mach-{at91,omap2}/Makefile


-- 
Best Regards
Masahiro Yamada
