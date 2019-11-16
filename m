Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1491B20715
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7NbbwTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKPK0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:26:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52724 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfKPK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:26:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so12107683wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQOJ/cj1whNHD2PQQ+cy8r6gS1Ajf7reG9pk/PNjJKU=;
        b=T7NbbwTRsL+uckxvvubU+WGD6h4acWBThyvsYDwpsZWju73LRgdyrP+DoEGASfitjb
         BUkAIVSGX13zrcw0n54xAVdR4qOSeQhfdUnvgDCjNCIddfTcpq6LGYQfPaOr0TUSpfYy
         4qMJXxX6zBUaDbM62OdikiLYjwKgP8zv5JZKcNKeBADMKpxdR9LUxYzO8js0jBcrqU9z
         ms9VTXvQWnGtgK27sJ3VNIsJCdgUS0hPHptsWvJj9kzNO9LrKeLXXlcDsjmAYTCtqDo4
         qiYZxuHmRabMisYkQsvAod3elJ/Z0W0vqzxbgr+KZ74sb1+ALz6EsZ5MtMnq6/gDLPLv
         Jvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQOJ/cj1whNHD2PQQ+cy8r6gS1Ajf7reG9pk/PNjJKU=;
        b=fNfBA4nGFH8WHcEZR5Zm/xYVeFQYjn0zbfYfZMHV7HdHEOJ8pUG6dyk8yuQFERHJ6b
         8DD76Zoch3kirrm9QK43FHa6Okig9ad8mZrUMxfZOQ8afrWDAn1puGbc3aD+AGid4N4G
         +uRaw+X+y2+8iBFGu9SKyrhSE7vYMuVkQKUptivKSs/AkXyIS9StnQVVUustYU+S2HI2
         3KZAT8nE2GI5mcCM4cS+fTYwOqn2kKp1E9kR2Iisa34tLRPvdGt+w3wmtmrYiev8ob0e
         UWvnYbGv3rn4XOgrMjdeTU5ozakSPRhg5rxoK4w8DDOzdcGT+1MFQ9s4xuxMhtMmuqcg
         xcWA==
X-Gm-Message-State: APjAAAXGBQj1o5hqV7uaUxYhwh19wTvv2mEi3J0qKlQ75XVvwLmjc/e7
        jPkHyn7c7zV2cFc4xFMZ7ijf/E2I9gEP1TJT+xgg5A==
X-Google-Smtp-Source: APXvYqwQ/r69m/fq+RiSGk79/JOcxSPCUMquQ97KeATiM8zYKYyDSb3lQiEzDdcvC/4juD6pxKR1lDQCEvHwUEavsWE=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr17993772wmb.136.1573899995028;
 Sat, 16 Nov 2019 02:26:35 -0800 (PST)
MIME-Version: 1.0
References: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com>
In-Reply-To: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 16 Nov 2019 10:26:27 +0000
Message-ID: <CAKv+Gu_r2Cb3d3OXaOdYy+4V9noL6exJoK6pHevUm2WfPzsr1g@mail.gmail.com>
Subject: Re: rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
To:     "kernelci.org bot" <bot@kernelci.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        mgalka@collabora.com, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Marc Zyngier <maz@kernel.org>,
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

(+ Arnd)

On Sat, 16 Nov 2019 at 05:54, kernelci.org bot <bot@kernelci.org> wrote:
>
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>
> rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
>
> Summary:
>   Start:      b6c3c42cfda0 ARM: 8938/1: kernel: initialize broadcast hrtimer based clock event device
>   Details:    https://kernelci.org/boot/id/5dcf3f0359b514dc84cf54c8
>   Plain log:  https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.txt
>   HTML log:   https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-pogoplug-series-3.html
>   Result:     ea70bf6e92c5 ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
>

OK, so this regression is caused by the fact that the 'armv7' cache
maintenance routines in the decompressor are also used for ARMv6 cores
if they implement the CPUID extension, which I failed to realise when
I sent this patch.

There are roughly three ways to deal with this:
1) add a mask/val match pair for ARM11MPcore and ARM1176 that hardwire
them to the ARMv6 routines, even though they implement the CPUID
extension. This would be very easy, but assumes that those two cores
are the only ones that are affected by this.
2) modify the v7 routines to check for the L1Hvd MMFR1 attribute (in
the flush routine) and for the CP15BEN SCTLR bit (in the on/off
routines), and jump to the respective v6 variants if the CPU turns out
not to support the v7 one.
3) revert the patch, and just enable the CP15 barriers (and issue a v7
barrier) in the v7 on() and flush() routines.

I am leaning towards the latter, since it is the most straightforward,
even though it mixes v7 and cp15 barriers in the same function, but
that was mostly a cosmetic concern anyway.



> Checks:
>   revert:     PASS
>   verify:     PASS
>
> Parameters:
>   Tree:       rmk
>   URL:        git://git.armlinux.org.uk/~rmk/linux-arm.git
>   Branch:     for-next
>   Target:     ox820-cloudengines-pogoplug-series-3
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     oxnas_v6_defconfig
>   Test suite: boot
>
> Breaking commit found:
>
> -------------------------------------------------------------------------------
> commit ea70bf6e92c5d8cf38c8a077e0eded091c275899
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Fri Nov 8 13:46:50 2019 +0100
>
>     ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
>
>     Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
>
>       "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the cache"
>
>     added some explicit handling of the CP15BEN bit in the SCTLR system
>     register, to ensure that CP15 barrier instructions are enabled, even
>     if we enter the decompressor via the EFI stub.
>
>     However, as it turns out, there are other ways in which we may end up
>     using CP15 barrier instructions without them being enabled. I.e., when
>     the decompressor startup code skips the cache_on() initially, we end
>     up calling cache_clean_flush() with the caches and MMU off, in which
>     case the CP15BEN bit in SCTLR may not be programmed either. And in
>     fact, cache_on() itself issues CP15 barrier instructions before actually
>     enabling them by programming the new SCTLR value (and issuing an ISB)
>
>     Since all these routines are specific to v7, let's clean this up by
>     using the ordinary v7 barrier instructions in the v7 specific cache
>     handling routines, so that we never rely on the CP15 ones. This also
>     avoids the issue where a barrier is required between programming SCTLR
>     and using the CP15 barrier instructions, which would result in two
>     different kinds of barriers being used in the same function.
>
>     Acked-by: Marc Zyngier <maz@kernel.org>
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 95238146b7f2..fe279816b298 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -656,6 +656,21 @@ params:            ldr     r0, =0x10000100         @ params_phys for RPC
>                 .align
>  #endif
>
> +               .macro  v7dsb
> + ARM(          .inst   0xf57ff04f              @ v7+ dsb       )
> + THUMB(                dsb                                             )
> +               .endm
> +
> +               .macro  v7dmb
> + ARM(          .inst   0xf57ff05f              @ v7+ dmb       )
> + THUMB(                dmb                                             )
> +               .endm
> +
> +               .macro  v7isb
> + ARM(          .inst   0xf57ff06f              @ v7+ isb       )
> + THUMB(                isb                                             )
> +               .endm
> +
>  /*
>   * Turn on the cache.  We need to setup some page tables so that we
>   * can have both the I and D caches on.
> @@ -827,7 +842,7 @@ __armv7_mmu_cache_on:
>                 movne   r6, #CB_BITS | 0x02     @ !XN
>                 blne    __setup_mmu
>                 mov     r0, #0
> -               mcr     p15, 0, r0, c7, c10, 4  @ drain write buffer
> +               v7dsb                           @ drain write buffer
>                 tst     r11, #0xf               @ VMSA
>                 mcrne   p15, 0, r0, c8, c7, 0   @ flush I,D TLBs
>  #endif
> @@ -849,11 +864,11 @@ __armv7_mmu_cache_on:
>                 mcrne   p15, 0, r1, c3, c0, 0   @ load domain access control
>                 mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
>  #endif
> -               mcr     p15, 0, r0, c7, c5, 4   @ ISB
> +               v7isb
>                 mcr     p15, 0, r0, c1, c0, 0   @ load control register
>                 mrc     p15, 0, r0, c1, c0, 0   @ and read it back
>                 mov     r0, #0
> -               mcr     p15, 0, r0, c7, c5, 4   @ ISB
> +               v7isb
>                 mov     pc, r12
>
>  __fa526_cache_on:
> @@ -1154,8 +1169,8 @@ __armv7_mmu_cache_off:
>                 mcr     p15, 0, r0, c8, c7, 0   @ invalidate whole TLB
>  #endif
>                 mcr     p15, 0, r0, c7, c5, 6   @ invalidate BTC
> -               mcr     p15, 0, r0, c7, c10, 4  @ DSB
> -               mcr     p15, 0, r0, c7, c5, 4   @ ISB
> +               v7dsb
> +               v7isb
>                 mov     pc, r12
>
>  /*
> @@ -1218,7 +1233,7 @@ __armv7_mmu_cache_flush:
>                 mcr     p15, 0, r10, c7, c14, 0 @ clean+invalidate D
>                 b       iflush
>  hierarchical:
> -               mcr     p15, 0, r10, c7, c10, 5 @ DMB
> +               v7dmb
>                 stmfd   sp!, {r0-r7, r9-r11}
>                 mrc     p15, 1, r0, c0, c0, 1   @ read clidr
>                 ands    r3, r0, #0x7000000      @ extract loc from clidr
> @@ -1232,7 +1247,7 @@ loop1:
>                 cmp     r1, #2                  @ see what cache we have at this level
>                 blt     skip                    @ skip if no cache, or just i-cache
>                 mcr     p15, 2, r10, c0, c0, 0  @ select current cache level in cssr
> -               mcr     p15, 0, r10, c7, c5, 4  @ isb to sych the new cssr&csidr
> +               v7isb                           @ isb to sych the new cssr&csidr
>                 mrc     p15, 1, r1, c0, c0, 0   @ read the new csidr
>                 and     r2, r1, #7              @ extract the length of the cache lines
>                 add     r2, r2, #4              @ add 4 (line length offset)
> @@ -1264,10 +1279,10 @@ finished:
>                 mov     r10, #0                 @ switch back to cache level 0
>                 mcr     p15, 2, r10, c0, c0, 0  @ select current cache level in cssr
>  iflush:
> -               mcr     p15, 0, r10, c7, c10, 4 @ DSB
> +               v7dsb
>                 mcr     p15, 0, r10, c7, c5, 0  @ invalidate I+BTB
> -               mcr     p15, 0, r10, c7, c10, 4 @ DSB
> -               mcr     p15, 0, r10, c7, c5, 4  @ ISB
> +               v7dsb
> +               v7isb
>                 mov     pc, lr
>
>  __armv5tej_mmu_cache_flush:
> -------------------------------------------------------------------------------
>
>
> Git bisection log:
>
> -------------------------------------------------------------------------------
> git bisect start
> # good: [cb73737ea1d27181f5c4bfb1288e97f3e8a4abc7] ARM: 8928/1: ARM_ERRATA_775420: Spelling s/date/data/
> git bisect good cb73737ea1d27181f5c4bfb1288e97f3e8a4abc7
> # bad: [b6c3c42cfda04b0119a0ac46c2a06006f38522d7] ARM: 8938/1: kernel: initialize broadcast hrtimer based clock event device
> git bisect bad b6c3c42cfda04b0119a0ac46c2a06006f38522d7
> # good: [052e76a31b4a64d7678e270d498e1bc36c342f88] ARM: 8931/1: Add clock_getres entry point
> git bisect good 052e76a31b4a64d7678e270d498e1bc36c342f88
> # good: [44700c1ea9afeb9c5093dba7794117fda7c5c955] ARM: 8934/1: Revert "efi: enable CP15 DMB instructions before cleaning the cache"
> git bisect good 44700c1ea9afeb9c5093dba7794117fda7c5c955
> # bad: [7f586a0a683ec37ac25bee24381e24c66dfe32b8] ARM: 8937/1: spectre-v2: remove Brahma-B53 from hardening
> git bisect bad 7f586a0a683ec37ac25bee24381e24c66dfe32b8
> # bad: [ea70bf6e92c5d8cf38c8a077e0eded091c275899] ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
> git bisect bad ea70bf6e92c5d8cf38c8a077e0eded091c275899
> # first bad commit: [ea70bf6e92c5d8cf38c8a077e0eded091c275899] ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
> -------------------------------------------------------------------------------
