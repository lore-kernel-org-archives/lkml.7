Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680F20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dbBKeMcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKVLpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:45:00 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:48440 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVLpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:45:00 -0500
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xAMBis87011030
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 20:44:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xAMBis87011030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574423095;
        bh=uJJ3Xmgwdkx2Xjxq2W6003h6YYQ1CPfz5/CHnlDA0vg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dbBKeMcnt6lJ228UtYi4+fbKtnPeidr1ocFWemP1mP9s3NqcTrexvy9V2OMhALYmI
         bANpnfuSHqLbYE1ug4zFTrXTjG6Qe4zqUUA9oGjLC5ryr9WVuqS8LYn+IXswX5sLK0
         lWkOYkV/2xXcUTdllWeabbzDMClu7IMrx1pyKiZ/l2yvy7w0hqpaScb978Lb0IV1vy
         4zKI8WUhGf57brH6JG0wFy1948wC1Oxa6OTnYEfE/8Rw7JtK+LpjOdgP5NpNEiP2aH
         d9f1oKNqrJ2kGbopyLUMFR+kDQGWYXhiP1wvj+eKNnEn9ox77amt3GhZhvxwPI3F2K
         QuhcpKAGL9wMw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id u99so2050476uau.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 03:44:55 -0800 (PST)
X-Gm-Message-State: APjAAAXr3XzaHTu1sGOC5EaTEcSYDa5BNnWjRdG9utzEA8Y/55kdiaEQ
        SwwevDexIfuOoVmEw7rhYeg1UqeOcfAkRtCuC70=
X-Google-Smtp-Source: APXvYqxsBsb54qRP99zHPylPjqtR7QyCla1adFZbZDq9fV0YysKYWFLw5FHCOZBrKUjNIti6MHdCRYu42w0Qcqg/MBM=
X-Received: by 2002:ab0:3395:: with SMTP id y21mr9156200uap.25.1574423094022;
 Fri, 22 Nov 2019 03:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20191120145110.8397-1-jeyu@kernel.org> <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
 <20191121160919.GB22213@linux-8ccs>
In-Reply-To: <20191121160919.GB22213@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 22 Nov 2019 20:44:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=+VMTpK3nBy3J-M9idf8MBi4dB4WKexYatiV2pNHvMg@mail.gmail.com>
Message-ID: <CAK7LNAT=+VMTpK3nBy3J-M9idf8MBi4dB4WKexYatiV2pNHvMg@mail.gmail.com>
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 1:09 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Rasmus Villemoes [21/11/19 11:51 +0100]:
> >On 20/11/2019 15.51, Jessica Yu wrote:
> >>
> >> We can alleviate this situation by utilizing the SHF_MERGE and
> >> SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
> >> that the data in the section are null-terminated strings
> >
> >[pet peeve: nul, not null.]
>
> Ah, right you are!
>
> >> As of v5.4-rc5, the following statistics were gathered with x86
> >> defconfig with approximately 10.7k exported symbols.
> >>
> >> Size of __ksymtab_strings in vmlinux:
> >> -------------------------------------
> >> v5.4-rc5: 213834 bytes
> >> v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
> >> v5.4-rc5 with this patch: 205759 bytes
> >>
> >> So, we already see memory savings of ~8kB compared to vanilla -rc5 and
> >> savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
> >
> >Yippee :) Thanks for picking up the ball and sending this.
>
> And thanks for the idea in the first place :-)
>
> >>  /*
> >> - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
> >> - * since we immediately emit into those sections anyway.
> >> + * note on .section use: we specify @progbits vs %progbits since usage of
> >> + * "M" (SHF_MERGE) section flag requires it.
> >>   */
> >> +
> >> +#ifdef CONFIG_ARM
> >> +#define ARCH_PROGBITS %progbits
> >> +#else
> >> +#define ARCH_PROGBITS @progbits
> >> +#endif
> >
> >Did you figure out a way to determine if ARM is the only odd one? I was
> >just going by gas' documentation which mentions ARM as an example, but
> >doesn't really provide a way to know what each arch uses. I suppose 0day
> >will tell us shortly.
>
> I *think* so. At least, I was going off of
> drivers/base/firmware_loader/builtin/Makefile and
> scripts/recordmcount.pl, which were the only other places that I found
> that reference the %progbits vs @progbits oddity. They only use
> %progbits in the case of CONFIG_ARM and @progbits for other
> arches. I wasn't sure about arm64, but I looked at the assembly files
> gcc produced and it looked like @progbits was used there. Added some
> arm64 people to CC since they would know :-)
>
> >If we want to avoid arch-ifdefs in these headers (and that could become
> >unwieldy if ARM is not the only one) I think one could add a
> >asm-generic/progbits.h, add progbits.h to mandatory-y in
> >include/asm-generic/Kbuild, and then just provide a progbits.h on ARM
> >(and the other exceptions) - then I think the kbuild logic automatically
> >makes "#include <asm/progbits.h>" pick up the right one. And the header
> >could define ARCH_PROGBITS with or without the double quotes depending
> >on __ASSEMBLY__.
>
> I think this would work, and it feels like the more correct solution
> especially if arm isn't the only one with the odd progbits char. It
> might be overkill if it's just arm that's affected though. I leave it
> to Masahiro to see what he prefers.
>


BTW, is there any reason why
not use %progbits all the time?


include/linux/init.h hard-codes %progbits

   #define __INITDATA .section ".init.data","aw",%progbits
   #define __INITRODATA .section ".init.rodata","a",%progbits


So, my understanding is '%' works for all architectures,
but it is better to ask 0-day bot to test it.



-- 
Best Regards
Masahiro Yamada
