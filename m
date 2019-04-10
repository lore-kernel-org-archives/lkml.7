Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6408EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316DF206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BJSAV+QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbfDJQg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:36:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34450 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731462AbfDJQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:36:28 -0400
Received: from zn.tnic (p200300EC2F0CAE00C097970AF3E0D9DA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:c097:970a:f3e0:d9da])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F192E1EC027B;
        Wed, 10 Apr 2019 18:36:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554914182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MD/2xC8A2MIVYqHIko+84S4GjLj9IZBv21a4KMpl5Ug=;
        b=BJSAV+QZJE1MPf7djpf1t9skQoLDiqi12zwEteG1qj6H9EUpE8EON2I8BbPif40Zx4rdN7
        HznCo1WXVB6MWQt5i0EL+bMXP8dQ2fbOsdRHkpj+vo7U89xH/bIusEsKNJGN0gc3oMy6Oq
        yOYsWCrhwpFxQaANpJ35r8aiVPt1AH8=
Date:   Wed, 10 Apr 2019 18:36:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 12/27] x86/pkru: Provide .*_pkru_ins() functions
Message-ID: <20190410163615.GB26580@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-13-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403164156.19645-13-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:41:41PM +0200, Sebastian Andrzej Siewior wrote:
> Dave Hansen has asked for __read_pkru() and __write_pkru() to be symmetrical.
> As part of the series __write_pkru() will read back the value and only write it
> if it is different.
> In order to make both functions symmetrical move the function containing only
> the opcode into a function with _isn() suffix. __write_pkru() will just invoke
> __write_pkru_isn() but in a flowup patch will also read back the value.
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/pgtable.h       |  2 +-
>  arch/x86/include/asm/special_insns.h | 12 +++++++++---
>  arch/x86/kvm/vmx/vmx.c               |  2 +-
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23f..64333e5222cd9 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -127,7 +127,7 @@ static inline int pte_dirty(pte_t pte)
>  static inline u32 read_pkru(void)
>  {
>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
> -		return __read_pkru();
> +		return __read_pkru_ins();
>  	return 0;
>  }
>  
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 43c029cdc3fe8..27328606ff687 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -92,7 +92,7 @@ static inline void native_write_cr8(unsigned long val)
>  #endif
>  
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> -static inline u32 __read_pkru(void)
> +static inline u32 __read_pkru_ins(void)
>  {
>  	u32 ecx = 0;
>  	u32 edx, pkru;
> @@ -107,7 +107,7 @@ static inline u32 __read_pkru(void)
>  	return pkru;
>  }
>  
> -static inline void __write_pkru(u32 pkru)
> +static inline void __write_pkru_ins(u32 pkru)
>  {
>  	u32 ecx = 0, edx = 0;
> 

Well, this is going in the wrong direction. The proper thing to do would
be to have:

rdpkru()
wrpkru()

which only do the inline asm with the respective opcodes. Just like
rdtsc(), clflush(), etc.

IOW, the functions which correspond to the instructions should be called
just like the respective instructions they implement in asm.

Then, all the helpers around them should have different names to denote
what they do. Like the current rdpkru() which does the assertion
checking should be renamed to something like read_pkey_user() or so.
Ditto for the current wrpkru().

Makes sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
