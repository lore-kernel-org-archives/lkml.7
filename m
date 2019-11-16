Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30804C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EA62072D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1e8cTfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKPPfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:35:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52820 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfKPPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:35:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so12619197wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4M4UvCgtPgoFyUVLRuHwdJhHWp0OA8X9iVXKzPAkVw=;
        b=H1e8cTfsATzwnwWPQbmTRjVNZS2yEoelFwA+SwidadZ+kA1OigsRQX0lDzsmCljGdX
         B+xoWhxkm95RxjXu1Uuvhoa5OGe0oeL26SE+7Ay3fq5i3rEBLYxdqLsXV+wHsyUal75X
         /B1ZS1biYF65BDRVzRQv3fnKRRgsKdT1DDKBr6HRHjYFhnUTwCqavvDHCTDc+Uvzn9zX
         9F+2ZCqsSEobR104rTKEeVUAgxTPlWQxkuKPq2AdWl8zSwsm3aV/6m9PbAV+tvopuA9s
         oNxh7wytS7Uw8NoxtxFtI+YtqVhYgAO2HzGlLmWMz6jfS6T+EtlNxpkfVrnzKqvpkpaR
         39SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4M4UvCgtPgoFyUVLRuHwdJhHWp0OA8X9iVXKzPAkVw=;
        b=UCGkSEcYm61Fv/n18MelgjnAXihMp10uVB4qs3wn8QqAX7RtceahaSIH54kMNzk/Uc
         H00garvB5rc0VP+XHVv/rsqZH7G03PlQnqwgu0CJUEabzspemeABgWh3sDBfT3ajbLqT
         UoMypopDuaPuv51aK3dcNrDadF0VCNxv8QCMbG1Gys2yJlWXKa+atclM0Gyvab0suJUI
         FIuU7Aq1edOSp40Oa/S9EZP+22DPPfQUuGfnWGbpfN+1WCn5wx8qFwgwko00c1qU2hH1
         6vMeF4l9A7DWbktbOs0+cU0Hq/Nn6UcOmaXwiZn4uU7NrqCtdc8M4GOXXjYhcCrxQEzR
         s2iQ==
X-Gm-Message-State: APjAAAVwHlnyPrD/7nUoiEIW6VUw01m2c3x+uwkjLxGPxqDRKo7CxtT5
        +u4g9AMSrvD+oeGSQ0Hj0ejD4t/CF4TDnJfO/du+0w==
X-Google-Smtp-Source: APXvYqzIZShtHSPYsTQ9A6Izde7YjeC2euGb9hisHE54uKMqkNk5g9525UgRZuaDKHRv6GBTVsYG6B2A81jhZn1e2cU=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr19453365wma.119.1573918534193;
 Sat, 16 Nov 2019 07:35:34 -0800 (PST)
MIME-Version: 1.0
References: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com> <CAKv+Gu_r2Cb3d3OXaOdYy+4V9noL6exJoK6pHevUm2WfPzsr1g@mail.gmail.com>
 <20191116123244.7be79023@why>
In-Reply-To: <20191116123244.7be79023@why>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 16 Nov 2019 16:35:21 +0100
Message-ID: <CAKv+Gu_ucSgTTJLZ19QezhO4bJLYFZJBQc5a7s3KEUQkEGyaqA@mail.gmail.com>
Subject: Re: rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
To:     Marc Zyngier <maz@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2019 at 13:32, Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 16 Nov 2019 10:26:27 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > (+ Arnd)
> >
> > On Sat, 16 Nov 2019 at 05:54, kernelci.org bot <bot@kernelci.org> wrote:
> > >
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > > * This automated bisection report was sent to you on the basis  *
> > > * that you may be involved with the breaking commit it has      *
> > > * found.  No manual investigation has been done to verify it,   *
> > > * and the root cause of the problem may be somewhere else.      *
> > > *                                                               *
> > > * If you do send a fix, please include this trailer:            *
> > > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > > *                                                               *
> > > * Hope this helps!                                              *
> > > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > >
> > > rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
> > >
> > > Summary:
> > >   Start:      b6c3c42cfda0 ARM: 8938/1: kernel: initialize broadcast hrtimer based clock event device
> > >   Details:    https://kernelci.org/boot/id/5dcf3f0359b514dc84cf54c8
> > >   Plain log:  https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.txt
> > >   HTML log:   https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.html
> > >   Result:     ea70bf6e92c5 ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
> > >
> >
> > OK, so this regression is caused by the fact that the 'armv7' cache
> > maintenance routines in the decompressor are also used for ARMv6 cores
> > if they implement the CPUID extension, which I failed to realise when
> > I sent this patch.
>
> Nobody expects the 11MPcore... :-(.
>

Yeah :-)

> > There are roughly three ways to deal with this:
> > 1) add a mask/val match pair for ARM11MPcore and ARM1176 that hardwire
> > them to the ARMv6 routines, even though they implement the CPUID
> > extension. This would be very easy, but assumes that those two cores
> > are the only ones that are affected by this.
> > 2) modify the v7 routines to check for the L1Hvd MMFR1 attribute (in
> > the flush routine) and for the CP15BEN SCTLR bit (in the on/off
> > routines), and jump to the respective v6 variants if the CPU turns out
> > not to support the v7 one.
> > 3) revert the patch, and just enable the CP15 barriers (and issue a v7
> > barrier) in the v7 on() and flush() routines.
> >
> > I am leaning towards the latter, since it is the most straightforward,
> > even though it mixes v7 and cp15 barriers in the same function, but
> > that was mostly a cosmetic concern anyway.
>
> A potential alternative is to check for the presence of architected
> barriers in a macro (see the hack below). I've given it a go as a 32bit
> guest on an A72 box, both as ARM and Thumb, and nothing caught fire. Of
> course, it remains to be seen whether it works on a v6 machine (I don't
> think I have any left in my zoo -- please don't send me any), and more
> importantly whether we want to carry this kind of horror...
>

Thanks.

But as I said, it might be better just to enable the CP15 barriers.
They haven't been removed from the architecture yet, so they are
always supported - we just have to enable them.



>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index ec14687aea3c..144de4b08547 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -656,19 +656,40 @@ params:           ldr     r0, =0x10000100         @ params_phys for RPC
>                 .align
>  #endif
>
> -               .macro  v7dsb
> +               @ Check for architected barrier instructions
> +               @ Branch to the tgt label if v7 barriers are
> +               @ not available. Corrupts the tmp register
> +               @ as well as the flags.
> +               .macro  no_v7_barrier, tmp, tgt
> +               mrc     p15, 0, \tmp, c0, c2, 4 @ ID_ISAR4
> +               tst     \tmp, #0xf << 16
> +               beq     \tgt
> +               .endm
> +
> +               @ The following macros will use zreg as a temp
> +               @ register, and will zero it after use.
> +               .macro  __dsb, zreg
> +               no_v7_barrier   \zreg, .L__dsb\@
>   ARM(          .inst   0xf57ff04f              @ v7+ dsb       )
>   THUMB(                dsb                                             )
> +               mov     \zreg, #0
> +.L__dsb\@:     mcreq   p15, 0, \zreg, c7, c10, 4 @ dsb
>                 .endm
>
> -               .macro  v7dmb
> +               .macro  __dmb, zreg
> +               no_v7_barrier   \zreg, .L__dmb\@
>   ARM(          .inst   0xf57ff05f              @ v7+ dmb       )
>   THUMB(                dmb                                             )
> +               mov     \zreg, #0
> +.L__dmb\@:     mcreq   p15, 0, \zreg, c7, c10, 5 @ dmb
>                 .endm
>
> -               .macro  v7isb
> +               .macro  __isb, zreg
> +               no_v7_barrier   \zreg, .L__isb\@
>   ARM(          .inst   0xf57ff06f              @ v7+ isb       )
>   THUMB(                isb                                             )
> +               mov     \zreg, #0
> +.L__isb\@:     mcreq   p15, 0, \zreg, c7, c5, 4 @ isb
>                 .endm
>
>  /*
> @@ -841,8 +862,7 @@ __armv7_mmu_cache_on:
>                 tst     r11, #0xf               @ VMSA
>                 movne   r6, #CB_BITS | 0x02     @ !XN
>                 blne    __setup_mmu
> -               mov     r0, #0
> -               v7dsb                           @ drain write buffer
> +               __dsb   r0                      @ drain write buffer
>                 tst     r11, #0xf               @ VMSA
>                 mcrne   p15, 0, r0, c8, c7, 0   @ flush I,D TLBs
>  #endif
> @@ -864,11 +884,10 @@ __armv7_mmu_cache_on:
>                 mcrne   p15, 0, r1, c3, c0, 0   @ load domain access control
>                 mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>  #endif
> -               v7isb
> +               __isb   lr
>                 mcr     p15, 0, r0, c1, c0, 0   @ load control register
>                 mrc     p15, 0, r0, c1, c0, 0   @ and read it back
> -               mov     r0, #0
> -               v7isb
> +               __isb   r0
>                 mov     pc, r12
>
>  __fa526_cache_on:
> @@ -1169,8 +1188,8 @@ __armv7_mmu_cache_off:
>                 mcr     p15, 0, r0, c8, c7, 0   @ invalidate whole TLB
>  #endif
>                 mcr     p15, 0, r0, c7, c5, 6   @ invalidate BTC
> -               v7dsb
> -               v7isb
> +               __dsb   r0
> +               __isb   r0
>                 mov     pc, r12
>
>  /*
> @@ -1233,7 +1252,7 @@ __armv7_mmu_cache_flush:
>                 mcr     p15, 0, r10, c7, c14, 0 @ clean+invalidate D
>                 b       iflush
>  hierarchical:
> -               v7dmb
> +               __dmb   r10
>                 stmfd   sp!, {r0-r7, r9-r11}
>                 mrc     p15, 1, r0, c0, c0, 1   @ read clidr
>                 ands    r3, r0, #0x7000000      @ extract loc from clidr
> @@ -1247,7 +1266,7 @@ loop1:
>                 cmp     r1, #2                  @ see what cache we have at this level
>                 blt     skip                    @ skip if no cache, or just i-cache
>                 mcr     p15, 2, r10, c0, c0, 0  @ select current cache level in cssr
> -               v7isb                           @ isb to sych the new cssr&csidr
> +               __isb   r1                      @ isb to sych the new cssr&csidr
>                 mrc     p15, 1, r1, c0, c0, 0   @ read the new csidr
>                 and     r2, r1, #7              @ extract the length of the cache lines
>                 add     r2, r2, #4              @ add 4 (line length offset)
> @@ -1279,10 +1298,10 @@ finished:
>                 mov     r10, #0                 @ switch back to cache level 0
>                 mcr     p15, 2, r10, c0, c0, 0  @ select current cache level in cssr
>  iflush:
> -               v7dsb
> +               __dsb   r10
>                 mcr     p15, 0, r10, c7, c5, 0  @ invalidate I+BTB
> -               v7dsb
> -               v7isb
> +               __dsb   r10
> +               __isb   r10
>                 mov     pc, lr
>
>  __armv5tej_mmu_cache_flush:
>
> --
> Jazz is not dead. It just smells funny...
