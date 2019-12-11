Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8222B20637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="j3MRlnLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfLKRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:37:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfLKRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:37:14 -0500
Received: from zn.tnic (p200300EC2F094900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17A371EC0591;
        Wed, 11 Dec 2019 18:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576085833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/fQSVH4e2kOh1ufr5QULeFyUccGwjWVFvNcXOqos5bc=;
        b=j3MRlnLTHkMRuZ7QpudWgF6/T2UqokFtYoPNG1Yr0vcl1cqrwaFFEOLLDsNTjKXHlPyDjl
        /jMUop/434oLwmjhI+9f8A5KEov4WxhHidW2RpmlC1NnHXoHJ+iN8wMXGjCRkXFIIgHyfG
        Y80o5U8gGTn+LK4dKb3lkvYKayZF+7E=
Date:   Wed, 11 Dec 2019 18:37:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 4/4] x86/kasan: Print original address on #GP
Message-ID: <20191211173711.GF14821@zn.tnic>
References: <20191209143120.60100-1-jannh@google.com>
 <20191209143120.60100-4-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209143120.60100-4-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:31:20PM +0100, Jann Horn wrote:
>  arch/x86/kernel/traps.c     | 12 ++++++++++-
>  arch/x86/mm/kasan_init_64.c | 21 -------------------
>  include/linux/kasan.h       |  6 ++++++
>  mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 22 deletions(-)

I need a KASAN person ACK here, I'd guess.

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c8b4ae6aed5b..7813592b4fb3 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -37,6 +37,7 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> +#include <linux/kasan.h>
>  #include <asm/stacktrace.h>
>  #include <asm/processor.h>
>  #include <asm/debugreg.h>
> @@ -589,6 +590,8 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  	if (!user_mode(regs)) {
>  		enum kernel_gp_hint hint = GP_NO_HINT;
>  		unsigned long gp_addr;
> +		unsigned long flags;
> +		int sig;
>  
>  		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
>  			return;
> @@ -621,7 +624,14 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  				 "maybe for address",
>  				 gp_addr);
>  
> -		die(desc, regs, error_code);
> +		flags = oops_begin();
> +		sig = SIGSEGV;
> +		__die_header(desc, regs, error_code);
> +		if (hint == GP_NON_CANONICAL)
> +			kasan_non_canonical_hook(gp_addr);
> +		if (__die_body(desc, regs, error_code))
> +			sig = 0;
> +		oops_end(flags, regs, sig);

Instead of opencoding it like this, can we add a

	die_addr(desc, regs, error_code, gp_addr);

to arch/x86/kernel/dumpstack.c and call it from here:

	if (hint != GP_NON_CANONICAL)
		gp_addr = 0;

	die_addr(desc, regs, error_code, gp_addr);

This way you won't need to pass down to die_addr() the hint too - you
code into gp_addr whether it was non-canonical or not.

The

+       if (addr < KASAN_SHADOW_OFFSET)
+               return;

check in kasan_non_canonical_hook() would then catch it when addr == 0.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
