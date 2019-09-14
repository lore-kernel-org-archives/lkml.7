Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50818C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992D2081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx0GkzaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfINPPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:15:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfINPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:15:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so3945045wmc.1;
        Sat, 14 Sep 2019 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=56i1dw2IFKA0m3KPsvbGrN2MqjawgjK7hsJiomQRjLM=;
        b=fx0GkzaHcNap9wpsvnxtNoDahrmyg2WBo52Hoz4gLBOtCpmYJPZ8S4T5xDS20HhWM1
         /Rz7MCid3PJcK+LoxpVkJHfUvVtb2bDEPE+L4KGnn8iTvfIDAyyLXtyu1QESbYaY4J0p
         CaCFYyEYTTa7x93D2rSoJTYKndgHLSYrpUqUg9MZVrInt9Fazdj7lB0Zm3PNKOUosiwK
         5KWJ2FNNJIPDJLOJu6mz5nu6pJ7em1GLa/czEXdnvhvhJZhsiInuh/ITUuU9G9fEiyVu
         XipiXOH/Melgy0IERkxEFg/8tvx7fGyDoigAjLaGcqoc9unqtgsq0oYNm/Wh0YGy+Ccj
         maXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=56i1dw2IFKA0m3KPsvbGrN2MqjawgjK7hsJiomQRjLM=;
        b=GLazlxXWM0IzH0e3dYVPlCQw5RgBpTZt+7tsMykkZRyL9SdhR7GpfvGmbKEvdeVxxR
         YnCV7PA2gaJ5aPbzaEaoHwA02SEozBDsQHSAqQwzKYRypTjOl6OAqdVL/vFDFQgeEoHs
         d9USOq/B3PbbGDTi6aluGubDvwQ7vIvhOAuzTwz0vGjxHxWYY4IfEFxYGYl4oTMan/cd
         RaEyxv97Le17NHryCd8wtZOnbxeuh/LxDCAoARzU9IRfafY4aYbXGLH7iAD2L9HAniWO
         vVEH0niCIIUYNQiKgFBTUHX2NnaK9Re/mXS8fn/qLQGXC+62XHBdj/xN6WfHH3DHNdG5
         +2Aw==
X-Gm-Message-State: APjAAAWD/ltMdq1twbnxq7lUmQ/UtFdo9drP3JFgK5aGd3OiALj05R0f
        +QvnbkNv4OT1uKXy4NTyVt1TBG4=
X-Google-Smtp-Source: APXvYqx1jiUIyK23899gSvBmkVHz0rLfScMJMI4nT5rwSElM54Ih25cmJ+yk5G0mFsUDuE+OgwNeDw==
X-Received: by 2002:a1c:5451:: with SMTP id p17mr7607716wmi.103.1568474140756;
        Sat, 14 Sep 2019 08:15:40 -0700 (PDT)
Received: from avx2 ([46.53.250.254])
        by smtp.gmail.com with ESMTPSA id i9sm7229634wmf.14.2019.09.14.08.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 08:15:39 -0700 (PDT)
Date:   Sat, 14 Sep 2019 18:15:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@vger.kernel.org,
        linux@rasmusvillemoes.dk, torvalds@linux-foundation.org
Subject: Re: [PATCH] x86_64: new and improved memset()
Message-ID: <20190914151537.GA12068@avx2>
References: <20190914103345.GA5856@avx2>
 <20190914113717.GA28054@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190914113717.GA28054@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 01:37:17PM +0200, Borislav Petkov wrote:
> On Sat, Sep 14, 2019 at 01:33:45PM +0300, Alexey Dobriyan wrote:
> > --- a/arch/x86/include/asm/string_64.h
> > +++ b/arch/x86/include/asm/string_64.h
> > @@ -15,7 +15,111 @@ extern void *memcpy(void *to, const void *from, size_t len);
> >  extern void *__memcpy(void *to, const void *from, size_t len);
> >  
> >  #define __HAVE_ARCH_MEMSET
> > +#if defined(_ARCH_X86_BOOT) || defined(CONFIG_FORTIFY_SOURCE)
> >  void *memset(void *s, int c, size_t n);
> > +#else
> > +#include <asm/alternative.h>
> > +#include <asm/cpufeatures.h>
> > +
> > +/* Internal, do not use. */
> > +static __always_inline void memset0(void *s, size_t n)
> > +{
> > +	/* Internal, do not use. */
> > +	void _memset0_mov(void);
> > +	void _memset0_rep_stosq(void);
> > +	void memset0_mov(void);
> > +	void memset0_rep_stosq(void);
> > +	void memset0_rep_stosb(void);
> > +
> > +	if (__builtin_constant_p(n) && n == 0) {
> > +	} else if (__builtin_constant_p(n) && n == 1) {
> > +		*(uint8_t *)s = 0;
> > +	} else if (__builtin_constant_p(n) && n == 2) {
> > +		*(uint16_t *)s = 0;
> > +	} else if (__builtin_constant_p(n) && n == 4) {
> > +		*(uint32_t *)s = 0;
> > +	} else if (__builtin_constant_p(n) && n == 6) {
> > +		*(uint32_t *)s = 0;
> > +		*(uint16_t *)(s + 4) = 0;
> > +	} else if (__builtin_constant_p(n) && n == 8) {
> > +		*(uint64_t *)s = 0;
> > +	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
> > +		alternative_call_2(
> > +			_memset0_mov,
> > +			_memset0_rep_stosq, X86_FEATURE_REP_GOOD,
> > +			memset0_rep_stosb, X86_FEATURE_ERMS,
> > +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> > +			"D" (s), "c" (n)
> > +			: "rax", "cc", "memory"
> > +		);
> > +	} else {
> > +		alternative_call_2(
> > +			memset0_mov,
> > +			memset0_rep_stosq, X86_FEATURE_REP_GOOD,
> > +			memset0_rep_stosb, X86_FEATURE_ERMS,
> > +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> > +			"D" (s), "c" (n)
> > +			: "rax", "rsi", "cc", "memory"
> > +		);
> > +	}
> > +}
> > +
> > +/* Internal, do not use. */
> > +static __always_inline void memsetx(void *s, int c, size_t n)
> > +{
> > +	/* Internal, do not use. */
> > +	void _memsetx_mov(void);
> > +	void _memsetx_rep_stosq(void);
> > +	void memsetx_mov(void);
> > +	void memsetx_rep_stosq(void);
> > +	void memsetx_rep_stosb(void);
> > +
> > +	const uint64_t ccc = (uint8_t)c * 0x0101010101010101ULL;
> > +
> > +	if (__builtin_constant_p(n) && n == 0) {
> > +	} else if (__builtin_constant_p(n) && n == 1) {
> > +		*(uint8_t *)s = ccc;
> > +	} else if (__builtin_constant_p(n) && n == 2) {
> > +		*(uint16_t *)s = ccc;
> > +	} else if (__builtin_constant_p(n) && n == 4) {
> > +		*(uint32_t *)s = ccc;
> > +	} else if (__builtin_constant_p(n) && n == 8) {
> > +		*(uint64_t *)s = ccc;
> > +	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
> > +		alternative_call_2(
> > +			_memsetx_mov,
> > +			_memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
> > +			memsetx_rep_stosb, X86_FEATURE_ERMS,
> > +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> > +			"D" (s), "c" (n), "a" (ccc)
> > +			: "cc", "memory"
> > +		);
> > +	} else {
> > +		alternative_call_2(
> > +			memsetx_mov,
> > +			memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
> > +			memsetx_rep_stosb, X86_FEATURE_ERMS,
> > +			ASM_OUTPUT2("=D" (s), "=c" (n)),
> > +			"D" (s), "c" (n), "a" (ccc)
> > +			: "rsi", "cc", "memory"
> > +		);
> > +	}
> > +}
> > +
> > +static __always_inline void *memset(void *s, int c, size_t n)
> > +{
> > +	if (__builtin_constant_p(c)) {
> > +		if (c == 0) {
> > +			memset0(s, n);
> > +		} else {
> > +			memsetx(s, c, n);
> > +		}
> > +		return s;
> > +	} else {
> > +		return __builtin_memset(s, c, n);
> > +	}
> > +}
> 
> I'm willing to take something like that only when such complexity is
> justified by numbers. I.e., I'm much more inclined to capping it under
> 32 and 64 byte sizes and keeping it simple.

OK. Those small lengths were indeed annoying.

> > +ENTRY(_memset0_mov)
> > +	xor	eax, eax
> > +.globl _memsetx_mov
> > +_memsetx_mov:
> > +	add	rcx, rdi
> > +	cmp	rdi, rcx
> > +	je	1f
> > +2:
> > +	mov	[rdi], rax
> > +	add	rdi, 8
> > +	cmp	rdi, rcx
> > +	jne	2b
> > +1:
> > +	ret
> > +ENDPROC(_memset0_mov)
> > +ENDPROC(_memsetx_mov)
> > +EXPORT_SYMBOL(_memset0_mov)
> > +EXPORT_SYMBOL(_memsetx_mov)
> > +
> > +ENTRY(memset0_mov)
> > +	xor	eax, eax
> > +.globl memsetx_mov
> > +memsetx_mov:
> > +	lea	rsi, [rdi + rcx]
> > +	cmp	rdi, rsi
> > +	je	1f
> > +2:
> > +	mov	[rdi], al
> > +	add	rdi, 1
> > +	cmp	rdi, rsi
> > +	jne	2b
> > +1:
> > +	ret
> 
> Say what now? Intel syntax? You must be joking...

It is the best thing in the x86 assembler universe.

> > +ENDPROC(memset0_mov)
> > +ENDPROC(memsetx_mov)
> > +EXPORT_SYMBOL(memset0_mov)
> > +EXPORT_SYMBOL(memsetx_mov)
> 
> Too many exported symbols.

Those are technical exports. memset() remains the only developer-visible
interface.

> Again, I'll much more prefer a cleaner,
> smaller solution than one where readability suffers greatly at the
> expense of *maybe* getting a bit better performance.

Readability is red herring, I for one find AT&T syntax unreadable.
