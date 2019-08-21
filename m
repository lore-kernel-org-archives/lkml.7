Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B870C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAB222CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfHUEh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:37:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:53888 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfHUEh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:37:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7L4bSwZ013162;
        Tue, 20 Aug 2019 23:37:29 -0500
Message-ID: <6662919bd80773aaf339e85b14af1ea1ddbfd841.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/vdso32: inline __get_datapage()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 21 Aug 2019 14:37:28 +1000
In-Reply-To: <65f1ed51b9cff219b9380c81d88353570cafdfd3.1565966871.git.christophe.leroy@c-s.fr>
References: <65f1ed51b9cff219b9380c81d88353570cafdfd3.1565966871.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-16 at 14:48 +0000, Christophe Leroy wrote:
> __get_datapage() is only a few instructions to retrieve the
> address of the page where the kernel stores data to the VDSO.
> 
> By inlining this function into its users, a bl/blr pair and
> a mflr/mtlr pair is avoided, plus a few reg moves.
> 
> The improvement is noticeable (about 55 nsec/call on an 8xx)

Interesting... would be worth doing the same on vdso64 no ?

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
>  arch/powerpc/kernel/vdso32/datapage.S     | 29 ++++-----------------
> --------
>  arch/powerpc/kernel/vdso32/datapage.h     | 12 ++++++++++++
>  arch/powerpc/kernel/vdso32/gettimeofday.S | 11 +++++------
>  4 files changed, 26 insertions(+), 36 deletions(-)
>  create mode 100644 arch/powerpc/kernel/vdso32/datapage.h
> 
> diff --git a/arch/powerpc/kernel/vdso32/cacheflush.S
> b/arch/powerpc/kernel/vdso32/cacheflush.S
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
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S
> b/arch/powerpc/kernel/vdso32/datapage.S
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
> -	/* We don't want that exposed or overridable as we want other
> objects
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
> diff --git a/arch/powerpc/kernel/vdso32/datapage.h
> b/arch/powerpc/kernel/vdso32/datapage.h
> new file mode 100644
> index 000000000000..ad96256be090
> --- /dev/null
> +++ b/arch/powerpc/kernel/vdso32/datapage.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +.macro get_datapage ptr, tmp
> +	bcl	20,31,888f
> +888:
> +	mflr	\ptr
> +	addi	\ptr, \ptr, __kernel_datapage_offset - 888b
> +	lwz	\tmp, 0(\ptr)
> +	add	\ptr, \tmp, \ptr
> +.endm
> +
> +
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S
> b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index e10098cde89c..91a58f01dcd5 100644
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
>  	beq	cr5,70f
> @@ -235,8 +235,7 @@ V_FUNCTION_BEGIN(__kernel_time)
>    .cfi_register lr,r12
>  
>  	mr	r11,r3			/* r11 holds t */
> -	bl	__get_datapage@local
> -	mr	r9, r3			/* datapage ptr in r9 */
> +	get_datapage	r9, r0
>  
>  	lwz	r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
>  

