Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFEDC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B4A20693
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZSUQI0Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfINLhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 07:37:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfINLhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 07:37:24 -0400
Received: from zn.tnic (p200300EC2F1C9800880C871C53BB2BF4.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:9800:880c:871c:53bb:2bf4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47D9C1EC0C41;
        Sat, 14 Sep 2019 13:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568461043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tv24zxfnTKvRe/ObyZwgEVsO03GvmENkBhfRDgOLxag=;
        b=ZSUQI0Vf9xgqyw9IsnbHZ+lv2jV3q2fQ87yVSflBGarQDLhmW5agA1RWacPHZ2WgsZr+pg
        0XE8Ub6BXhatHKi3S2HllVnLMG8kuukG2obkTQvVeRfuaJ2WnmHfbHv3Bgm8+kW0N5LOiI
        GGnfT5N2ialosPNBaDd6iIFzLy+LdUQ=
Date:   Sat, 14 Sep 2019 13:37:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: Re: [PATCH] x86_64: new and improved memset()
Message-ID: <20190914113717.GA28054@zn.tnic>
References: <20190914103345.GA5856@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914103345.GA5856@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 01:33:45PM +0300, Alexey Dobriyan wrote:
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -15,7 +15,111 @@ extern void *memcpy(void *to, const void *from, size_t len);
>  extern void *__memcpy(void *to, const void *from, size_t len);
>  
>  #define __HAVE_ARCH_MEMSET
> +#if defined(_ARCH_X86_BOOT) || defined(CONFIG_FORTIFY_SOURCE)
>  void *memset(void *s, int c, size_t n);
> +#else
> +#include <asm/alternative.h>
> +#include <asm/cpufeatures.h>
> +
> +/* Internal, do not use. */
> +static __always_inline void memset0(void *s, size_t n)
> +{
> +	/* Internal, do not use. */
> +	void _memset0_mov(void);
> +	void _memset0_rep_stosq(void);
> +	void memset0_mov(void);
> +	void memset0_rep_stosq(void);
> +	void memset0_rep_stosb(void);
> +
> +	if (__builtin_constant_p(n) && n == 0) {
> +	} else if (__builtin_constant_p(n) && n == 1) {
> +		*(uint8_t *)s = 0;
> +	} else if (__builtin_constant_p(n) && n == 2) {
> +		*(uint16_t *)s = 0;
> +	} else if (__builtin_constant_p(n) && n == 4) {
> +		*(uint32_t *)s = 0;
> +	} else if (__builtin_constant_p(n) && n == 6) {
> +		*(uint32_t *)s = 0;
> +		*(uint16_t *)(s + 4) = 0;
> +	} else if (__builtin_constant_p(n) && n == 8) {
> +		*(uint64_t *)s = 0;
> +	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
> +		alternative_call_2(
> +			_memset0_mov,
> +			_memset0_rep_stosq, X86_FEATURE_REP_GOOD,
> +			memset0_rep_stosb, X86_FEATURE_ERMS,
> +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> +			"D" (s), "c" (n)
> +			: "rax", "cc", "memory"
> +		);
> +	} else {
> +		alternative_call_2(
> +			memset0_mov,
> +			memset0_rep_stosq, X86_FEATURE_REP_GOOD,
> +			memset0_rep_stosb, X86_FEATURE_ERMS,
> +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> +			"D" (s), "c" (n)
> +			: "rax", "rsi", "cc", "memory"
> +		);
> +	}
> +}
> +
> +/* Internal, do not use. */
> +static __always_inline void memsetx(void *s, int c, size_t n)
> +{
> +	/* Internal, do not use. */
> +	void _memsetx_mov(void);
> +	void _memsetx_rep_stosq(void);
> +	void memsetx_mov(void);
> +	void memsetx_rep_stosq(void);
> +	void memsetx_rep_stosb(void);
> +
> +	const uint64_t ccc = (uint8_t)c * 0x0101010101010101ULL;
> +
> +	if (__builtin_constant_p(n) && n == 0) {
> +	} else if (__builtin_constant_p(n) && n == 1) {
> +		*(uint8_t *)s = ccc;
> +	} else if (__builtin_constant_p(n) && n == 2) {
> +		*(uint16_t *)s = ccc;
> +	} else if (__builtin_constant_p(n) && n == 4) {
> +		*(uint32_t *)s = ccc;
> +	} else if (__builtin_constant_p(n) && n == 8) {
> +		*(uint64_t *)s = ccc;
> +	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
> +		alternative_call_2(
> +			_memsetx_mov,
> +			_memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
> +			memsetx_rep_stosb, X86_FEATURE_ERMS,
> +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> +			"D" (s), "c" (n), "a" (ccc)
> +			: "cc", "memory"
> +		);
> +	} else {
> +		alternative_call_2(
> +			memsetx_mov,
> +			memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
> +			memsetx_rep_stosb, X86_FEATURE_ERMS,
> +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> +			"D" (s), "c" (n), "a" (ccc)
> +			: "rsi", "cc", "memory"
> +		);
> +	}
> +}
> +
> +static __always_inline void *memset(void *s, int c, size_t n)
> +{
> +	if (__builtin_constant_p(c)) {
> +		if (c == 0) {
> +			memset0(s, n);
> +		} else {
> +			memsetx(s, c, n);
> +		}
> +		return s;
> +	} else {
> +		return __builtin_memset(s, c, n);
> +	}
> +}

I'm willing to take something like that only when such complexity is
justified by numbers. I.e., I'm much more inclined to capping it under
32 and 64 byte sizes and keeping it simple.

...

> +ENTRY(_memset0_mov)
> +	xor	eax, eax
> +.globl _memsetx_mov
> +_memsetx_mov:
> +	add	rcx, rdi
> +	cmp	rdi, rcx
> +	je	1f
> +2:
> +	mov	[rdi], rax
> +	add	rdi, 8
> +	cmp	rdi, rcx
> +	jne	2b
> +1:
> +	ret
> +ENDPROC(_memset0_mov)
> +ENDPROC(_memsetx_mov)
> +EXPORT_SYMBOL(_memset0_mov)
> +EXPORT_SYMBOL(_memsetx_mov)
> +
> +ENTRY(memset0_mov)
> +	xor	eax, eax
> +.globl memsetx_mov
> +memsetx_mov:
> +	lea	rsi, [rdi + rcx]
> +	cmp	rdi, rsi
> +	je	1f
> +2:
> +	mov	[rdi], al
> +	add	rdi, 1
> +	cmp	rdi, rsi
> +	jne	2b
> +1:
> +	ret

Say what now? Intel syntax? You must be joking...

> +ENDPROC(memset0_mov)
> +ENDPROC(memsetx_mov)
> +EXPORT_SYMBOL(memset0_mov)
> +EXPORT_SYMBOL(memsetx_mov)

Too many exported symbols. Again, I'll much more prefer a cleaner,
smaller solution than one where readability suffers greatly at the
expense of *maybe* getting a bit better performance.

> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -D__NO_FORTIFY \
>  				   $(call cc-option,-ffreestanding) \
>  				   $(call cc-option,-fno-stack-protector) \
> -				   -D__DISABLE_EXPORTS
> +				   -D__DISABLE_EXPORTS -D_ARCH_X86_BOOT

Yeah, something like that is inevitable, I've come to realize too. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
