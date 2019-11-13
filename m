Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D12C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71946222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jg5JN1ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfKMLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:41:37 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17327 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfKMLlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:41:31 -0500
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id xADBfGnQ005654
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 20:41:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xADBfGnQ005654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573645277;
        bh=J6rJT8P5SnuQtYPsxB/K65h5d3rtBJCHsFkTNmOyQlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jg5JN1kyvIRVl+wnxWLogXC8ILKa+IPKGO3oktS6ZUotAb3IrHuk4Cd8D0jRpS+Z/
         nn4aw7dZ1b0YnJJ7AiKHjQ2t/Cu60ALE0Dh9E3WfRj2CTKfY0JUzC8ZchaQv0FppaG
         Fwy+yVGWbgh8TTCt820j9oWM9oW/tdMhKvpLE05p+HEk4CY8OYLGlPFutee/2rSxRW
         uBKiz4+K20hREfUyGRaxCJ8Ox9HxaPzJ3CDeJjbRXdUn34oD9JR64StlSm4xVn3BV0
         M49dIKUVvlEoFbtYI68+5VwbIlJ9NPgm31QO5fibO43FyIEoowXPOyocKhEDAk9wjx
         bZL9tMKtNoJnQ==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id r4so472371vkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 03:41:17 -0800 (PST)
X-Gm-Message-State: APjAAAWPAFWKZOJwhkBvZxfJv0Zw0Iszf8AOq/ffPAcQ+bjRIT2mRx9+
        2jwP40lcBI4mSugx8/tqmIBiSXE+8U0Ra3jkBkE=
X-Google-Smtp-Source: APXvYqxqblFCrOJg10zfx2WK5ReUHCOH5foJoWAQQv3PyYkLJdqhdmg4TbDz/1KDQB+Qui2LDB57vmmLTKCspKoZrlo=
X-Received: by 2002:a1f:4192:: with SMTP id o140mr1284724vka.26.1573645275987;
 Wed, 13 Nov 2019 03:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de> <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Nov 2019 20:40:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
Message-ID: <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Without the frame pointer enabled, return_address() is an inline
> > function and does not need to be exported, as shown by this warning:
> >
> > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> >
> > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your patch!
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm/kernel/return_address.c
> > +++ b/arch/arm/kernel/return_address.c
> > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> >                 return NULL;
> >  }
> >
>
> Checkpatch doesn't like the empty line above:
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
>
> > +EXPORT_SYMBOL_GPL(return_address);
> > +
> >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> >
> > -EXPORT_SYMBOL_GPL(return_address);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



What has happened to this patch?

I still see this warning.



-- 
Best Regards
Masahiro Yamada
