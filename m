Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD05C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19152173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="EsDD65hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfHZFoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:44:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45853 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfHZFoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:44:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so11018808pfq.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Z1hdU2Yt4yMcOaxjcgx3DKsgaNU+yDVYevEsakRJRMA=;
        b=EsDD65hFHvF1GuYjro3Ps8YGBOVVKnFL8H3mwXLkIOd5wHhCoEb2J4LcwA7ICIZmaQ
         fwQ5BJ+H2v05avOW5Zh4tAKlpGpAfCjW8bKnGON6phpmMPPKi0ulg5IzXjgsMVyR+nH8
         dHrEsDAsMVcGy9mFbtvzkDVw6PdYEqvKPyWNpgQL8dcy5KZE0q+6kGdbLIUoYa8NJ/kZ
         CL0XpQ3VMxjEOW9BhJGvjhZzoNTAaOA46Ip69sEsoF0usCIwC7TEFLhaqFClH/DYINWL
         P9HnEtwqBhfoJv8riV23xjYXs3aODlJokIKb7/stHNv7tMZ2oPNMR4YgC5oft8Dp+wWd
         2L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z1hdU2Yt4yMcOaxjcgx3DKsgaNU+yDVYevEsakRJRMA=;
        b=SRpuIfmlU0UbLO5PmUCDnHBychK/rzbKLD1nUQS2SkDB+DDIO6BkYkMwneAWz3wpcp
         UAn9f1N3S6uX4ZG8D/fUHE1IhQVmf30VMxEOSxETrPtoaMoytsZ86RkxNFEUa7D2RrXT
         gYgzMfXLEpr3o0MZDgbRsw4CK81XtCVJOf5W3pd1gI3SYG+tKvsh4MfpTvQwW4OVBpCP
         feNok2YdtRVI90x8250Zro8yRcs7r6N1lGOgqMHLo7h7/1J8uNfPZGvN70bkAzkklDAj
         ottCWoZyfwU2ipHZ55LizzJyNll0rc121XnjEQwSi6xPGFsRpeGsDJH4JWtc/kJIFBkv
         Z9tA==
X-Gm-Message-State: APjAAAVtbV/VUEAA00eruVCmD0u8EIWhZJ9yKnWuejj34IQ1rGOUcbw7
        FdA9OWKkUmbfUJp0Z2DmK6q/XA==
X-Google-Smtp-Source: APXvYqx6egldOzC3ik1adhTGZ3XM2qk/7RBvK875E1okkIdsa/6okNXYC7t2RAyjNG+1Nr1UIshLCw==
X-Received: by 2002:a62:144f:: with SMTP id 76mr18366896pfu.62.1566798257497;
        Sun, 25 Aug 2019 22:44:17 -0700 (PDT)
Received: from localhost ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id i9sm17875663pgo.46.2019.08.25.22.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 22:44:16 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] powerpc/vdso32: inline __get_datapage()
In-Reply-To: <194fb7bc973ef2ce43016c97dd32f2b2dcbae4e7.1566491310.git.christophe.leroy@c-s.fr>
References: <cover.1566491310.git.christophe.leroy@c-s.fr> <194fb7bc973ef2ce43016c97dd32f2b2dcbae4e7.1566491310.git.christophe.leroy@c-s.fr>
Date:   Mon, 26 Aug 2019 11:14:14 +0530
Message-ID: <87h864iiq9.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> __get_datapage() is only a few instructions to retrieve the
> address of the page where the kernel stores data to the VDSO.
>
> By inlining this function into its users, a bl/blr pair and
> a mflr/mtlr pair is avoided, plus a few reg moves.
>
> The improvement is noticeable (about 55 nsec/call on an 8xx)
>
> vdsotest before the patch:
> gettimeofday:    vdso: 731 nsec/call
> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>
> vdsotest after the patch:
> gettimeofday:    vdso: 677 nsec/call
> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/vdso32/cacheflush.S   | 10 +++++-----
>  arch/powerpc/kernel/vdso32/datapage.S     | 29 ++++-------------------------
>  arch/powerpc/kernel/vdso32/datapage.h     | 11 +++++++++++
>  arch/powerpc/kernel/vdso32/gettimeofday.S | 13 ++++++-------
>  4 files changed, 26 insertions(+), 37 deletions(-)
>  create mode 100644 arch/powerpc/kernel/vdso32/datapage.h

The datapage.h file should ideally be moved under include/asm, then we can use
the same for powerpc64 too.

Santosh

>
> diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S b/arch/powerpc/kernel/vdso32/cacheflush.S
> index 7f882e7b9f43..e9453837e4ee 100644
> --- a/arch/powerpc/kernel/vdso32/cacheflush.S
> +++ b/arch/powerpc/kernel/vdso32/cacheflush.S
> @@ -10,6 +10,8 @@
>  #include <asm/vdso.h>
>  #include <asm/asm-offsets.h>
>  
> +#include "datapage.h"
> +
>  	.text
>  
>  /*
> @@ -24,14 +26,12 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
>    .cfi_startproc
>  	mflr	r12
>    .cfi_register lr,r12
> -	mr	r11,r3
> -	bl	__get_datapage@local
> +	get_datapage	r10, r0
>  	mtlr	r12
> -	mr	r10,r3
>  
>  	lwz	r7,CFG_DCACHE_BLOCKSZ(r10)
>  	addi	r5,r7,-1
> -	andc	r6,r11,r5		/* round low to line bdy */
> +	andc	r6,r3,r5		/* round low to line bdy */
>  	subf	r8,r6,r4		/* compute length */
>  	add	r8,r8,r5		/* ensure we get enough */
>  	lwz	r9,CFG_DCACHE_LOGBLOCKSZ(r10)
> @@ -48,7 +48,7 @@ V_FUNCTION_BEGIN(__kernel_sync_dicache)
>  
>  	lwz	r7,CFG_ICACHE_BLOCKSZ(r10)
>  	addi	r5,r7,-1
> -	andc	r6,r11,r5		/* round low to line bdy */
> +	andc	r6,r3,r5		/* round low to line bdy */
>  	subf	r8,r6,r4		/* compute length */
>  	add	r8,r8,r5
>  	lwz	r9,CFG_ICACHE_LOGBLOCKSZ(r10)
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
> index 6984125b9fc0..d480d2d4a3fe 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -11,34 +11,13 @@
>  #include <asm/unistd.h>
>  #include <asm/vdso.h>
>  
> +#include "datapage.h"
> +
>  	.text
>  	.global	__kernel_datapage_offset;
>  __kernel_datapage_offset:
>  	.long	0
>  
> -V_FUNCTION_BEGIN(__get_datapage)
> -  .cfi_startproc
> -	/* We don't want that exposed or overridable as we want other objects
> -	 * to be able to bl directly to here
> -	 */
> -	.protected __get_datapage
> -	.hidden __get_datapage
> -
> -	mflr	r0
> -  .cfi_register lr,r0
> -
> -	bcl	20,31,data_page_branch
> -data_page_branch:
> -	mflr	r3
> -	mtlr	r0
> -	addi	r3, r3, __kernel_datapage_offset-data_page_branch
> -	lwz	r0,0(r3)
> -  .cfi_restore lr
> -	add	r3,r0,r3
> -	blr
> -  .cfi_endproc
> -V_FUNCTION_END(__get_datapage)
> -
>  /*
>   * void *__kernel_get_syscall_map(unsigned int *syscall_count) ;
>   *
> @@ -53,7 +32,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
>  	mflr	r12
>    .cfi_register lr,r12
>  	mr	r4,r3
> -	bl	__get_datapage@local
> +	get_datapage	r3, r0
>  	mtlr	r12
>  	addi	r3,r3,CFG_SYSCALL_MAP32
>  	cmpli	cr0,r4,0
> @@ -74,7 +53,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
>    .cfi_startproc
>  	mflr	r12
>    .cfi_register lr,r12
> -	bl	__get_datapage@local
> +	get_datapage	r3, r0
>  	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
>  	lwz	r3,CFG_TB_TICKS_PER_SEC(r3)
>  	mtlr	r12
> diff --git a/arch/powerpc/kernel/vdso32/datapage.h b/arch/powerpc/kernel/vdso32/datapage.h
> new file mode 100644
> index 000000000000..74f4f57c2da8
> --- /dev/null
> +++ b/arch/powerpc/kernel/vdso32/datapage.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +.macro get_datapage ptr, tmp
> +	bcl	20,31,.+4
> +	mflr	\ptr
> +	addi	\ptr, \ptr, __kernel_datapage_offset - (.-4)
> +	lwz	\tmp, 0(\ptr)
> +	add	\ptr, \tmp, \ptr
> +.endm
> +
> +
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index 355b537d327a..3e55cba19f44 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -12,6 +12,8 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/unistd.h>
>  
> +#include "datapage.h"
> +
>  /* Offset for the low 32-bit part of a field of long type */
>  #ifdef CONFIG_PPC64
>  #define LOPART	4
> @@ -35,8 +37,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  
>  	mr	r10,r3			/* r10 saves tv */
>  	mr	r11,r4			/* r11 saves tz */
> -	bl	__get_datapage@local	/* get data page */
> -	mr	r9, r3			/* datapage ptr in r9 */
> +	get_datapage	r9, r0
>  	cmplwi	r10,0			/* check if tv is NULL */
>  	beq	3f
>  	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
> @@ -82,8 +83,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	mflr	r12			/* r12 saves lr */
>    .cfi_register lr,r12
>  	mr	r11,r4			/* r11 saves tp */
> -	bl	__get_datapage@local	/* get data page */
> -	mr	r9,r3			/* datapage ptr in r9 */
> +	get_datapage	r9, r0
>  	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
>  	ori	r7,r7,NSEC_PER_SEC@l
>  	beq	cr5, .Lcoarse_clocks
> @@ -208,7 +208,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>  
>  	mflr	r12
>    .cfi_register lr,r12
> -	bl	__get_datapage@local	/* get data page */
> +	get_datapage	r3, r0
>  	lwz	r5, CLOCK_HRTIMER_RES(r3)
>  	mtlr	r12
>  	li	r3,0
> @@ -242,8 +242,7 @@ V_FUNCTION_BEGIN(__kernel_time)
>    .cfi_register lr,r12
>  
>  	mr	r11,r3			/* r11 holds t */
> -	bl	__get_datapage@local
> -	mr	r9, r3			/* datapage ptr in r9 */
> +	get_datapage	r9, r0
>  
>  	lwz	r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
>  
> -- 
> 2.13.3
