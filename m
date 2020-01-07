Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E3821744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TNLezjsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgAGSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:40:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgAGSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:40:13 -0500
Received: from zn.tnic (p200300EC2F0FB4001C0F6E794847FFF7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:1c0f:6e79:4847:fff7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F21A1EC0419;
        Tue,  7 Jan 2020 19:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578422412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m8nzMYNUc+LnSFW6W6VJz0TrnXhyQeeRbXeTyBKJzL8=;
        b=TNLezjsFNVHLyReGBHm6KTCs9jJ+quUPOC0VK4LisFf+PJTbbMHi1d3g2FyJ9wWkIyA0dN
        /QxBzNsKGmqebkBxDwDyfUpm6d5RwLqGpVdU9KumrN3cxnd4fWe1Olo+Nzdj9z4A/kfOH6
        SeCW1MDKBB54OUuIx6MoxxmtdPOQg5s=
Date:   Tue, 7 Jan 2020 19:40:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Add support for fast short rep mov
Message-ID: <20200107184003.GK29542@zn.tnic>
References: <20191212225210.GA22094@zn.tnic>
 <20191216214254.26492-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191216214254.26492-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 01:42:54PM -0800, Tony Luck wrote:
> From the Intel Optimization Reference Manual:
> 
> 3.7.6.1 Fast Short REP MOVSB
> Beginning with processors based on Ice Lake Client microarchitecture,
> REP MOVSB performance of short operations is enhanced. The enhancement
> applies to string lengths between 1 and 128 bytes long.  Support for
> fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
> [EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
> in the REP STOS performance.
> 
> Add an X86_FEATURE_FSRM flag for this.
> 
> memmove() avoids REP MOVSB for short (< 32 byte) copies. Fix it
> to check FSRM and use REP MOVSB for short copies on systems that
> support it.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> 
> Time (cycles) for memmove() sizes 1..31 with neither source nor
> destination in cache.
> 
>   1800 +-+-------+--------+---------+---------+---------+--------+-------+-+
>        +         +        +         +         +         +        +         +
>   1600 +-+                                          'memmove-fsrm' *******-+
>        |   ######                                   'memmove-orig' ####### |
>   1400 +-+ #     #####################                                   +-+
>        |   #                          ############                         |
>   1200 +-+#                                       ##################     +-+
>        |  #                                                                |
>   1000 +-+#                                                              +-+
>        |  #                                                                |
>        | #                                                                 |
>    800 +-#                                                               +-+
>        | #                                                                 |
>    600 +-***********************                                         +-+
>        |                        *****************************              |
>    400 +-+                                                   *******     +-+
>        |                                                                   |
>    200 +-+                                                               +-+
>        +         +        +         +         +         +        +         +
>      0 +-+-------+--------+---------+---------+---------+--------+-------+-+
>        0         5        10        15        20        25       30        35

I don't mind this graph being part of the commit message - it shows
nicely the speedup even if with some microbenchmark. Or you're not
adding it just because it is a microbenchmark and not something more
representative?

>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/lib/memmove_64.S          | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index e9b62498fe75..98c60fa31ced 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -357,6 +357,7 @@
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
>  #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
>  #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
> +#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
>  #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
>  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
> diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> index 337830d7a59c..4a23086806e6 100644
> --- a/arch/x86/lib/memmove_64.S
> +++ b/arch/x86/lib/memmove_64.S
> @@ -29,10 +29,7 @@
>  SYM_FUNC_START_ALIAS(memmove)
>  SYM_FUNC_START(__memmove)
>  
> -	/* Handle more 32 bytes in loop */
>  	mov %rdi, %rax
> -	cmp $0x20, %rdx
> -	jb	1f
>  
>  	/* Decide forward/backward copy mode */
>  	cmp %rdi, %rsi
> @@ -43,6 +40,7 @@ SYM_FUNC_START(__memmove)
>  	jg 2f
>  
>  .Lmemmove_begin_forward:
> +	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM

So the enhancement is for string lengths up to two cachelines. Why
are you limiting this to 32 bytes?

I know, the function handles 32-bytes at a time but what I'd imagine
here is having the fastest variant upfront which does REP; MOVSB for all
lengths since FSRM means fast short strings and ERMS - and I'm strongly
assuming here FSRM *implies* ERMS - means fast "longer" strings, so to
speak, so FSRM would mean fast *all length* strings in the end, no?

Also, does the copy direction influence the FSRM's REP; MOVSB variant's
performance? If not, you can do something like this:

 SYM_FUNC_START_ALIAS(memmove)
 SYM_FUNC_START(__memmove)

	mov %rdi, %rax

	/* FSRM handles all possible string lengths and directions optimally. */
	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_FSRM

	cmp $0x20, %rdx
	jb 1f
	...

Or?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
