Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A81F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rPkUMbQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfH0Hl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:41:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0Hl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:41:57 -0400
Received: from zn.tnic (p200300EC2F0CD000E4ECF72BFDD79A39.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:e4ec:f72b:fdd7:9a39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A79FA1EC0965;
        Tue, 27 Aug 2019 09:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566891716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dN3/6T+oqmbsAtYpZk7VoPcw4MaQnheSvuDSv7A3qwk=;
        b=rPkUMbQXaF07DLPrFOCFyImqaoAEBZl3I/XjvU7Y3eSNfVl8wCHg/r+yK/7LShg7ALxYFO
        wevnZfKkD/dfbEfyN5Pu/0+N76xN6bTouz1QOYsYL5RbjPf3aDGDSMDz1MKl6E8pjlLP2O
        7GJIMGMakryG5s+MuBms9xJv5RhX3f8=
Date:   Tue, 27 Aug 2019 09:41:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH] x86/cpufeature: drop *_MASK_CEHCK
Message-ID: <20190827074151.GA29752@zn.tnic>
References: <20190827070550.15988-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827070550.15988-1-caoj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:05:50PM +0800, Cao jin wrote:
> They are wrappers of BUILD_BUG_ON_ZERO(NCAPINTS != n), which is already
> present in corresponding *_MASK_BIT_SET. And fill the missing period in
> head comments by the way.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/cpufeature.h        | 2 --
>  arch/x86/include/asm/disabled-features.h | 1 -
>  arch/x86/include/asm/required-features.h | 3 +--
>  3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index 58acda503817..232ffb88039c 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -81,7 +81,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 16, feature_bit) ||	\
>  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 17, feature_bit) ||	\
>  	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
> -	   REQUIRED_MASK_CHECK					  ||	\
>  	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
>  
>  #define DISABLED_MASK_BIT_SET(feature_bit)				\
> @@ -104,7 +103,6 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
>  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 16, feature_bit) ||	\
>  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 17, feature_bit) ||	\
>  	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
> -	   DISABLED_MASK_CHECK					  ||	\
>  	   BUILD_BUG_ON_ZERO(NCAPINTS != 19))
>  
>  #define cpu_has(c, bit)							\

If you do a little bit of git archeology:

$ git annotate arch/x86/include/asm/cpufeature.h

after a while, you'll see that this was added in:

1e61f78baf89 ("x86/cpufeature: Make sure DISABLED/REQUIRED macros are updated")

and then you could Cc Dave and ask what he was thinking then?

Leaving in the rest for reference.

> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index a5ea841cc6d2..8a2eafa86739 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -84,6 +84,5 @@
>  #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP)
>  #define DISABLED_MASK17	0
>  #define DISABLED_MASK18	0
> -#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
>  
>  #endif /* _ASM_X86_DISABLED_FEATURES_H */
> diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
> index 6847d85400a8..cb98b66d3e81 100644
> --- a/arch/x86/include/asm/required-features.h
> +++ b/arch/x86/include/asm/required-features.h
> @@ -1,7 +1,7 @@
>  #ifndef _ASM_X86_REQUIRED_FEATURES_H
>  #define _ASM_X86_REQUIRED_FEATURES_H
>  
> -/* Define minimum CPUID feature set for kernel These bits are checked
> +/* Define minimum CPUID feature set for kernel. These bits are checked
>     really early to actually display a visible error message before the
>     kernel dies.  Make sure to assign features to the proper mask!
>  
> @@ -101,6 +101,5 @@
>  #define REQUIRED_MASK16	0
>  #define REQUIRED_MASK17	0
>  #define REQUIRED_MASK18	0
> -#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
>  
>  #endif /* _ASM_X86_REQUIRED_FEATURES_H */
> -- 
> 2.17.0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
