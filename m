Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD98E21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AiadhddG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfJIQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:59:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJIQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:59:31 -0400
Received: from zn.tnic (p200300EC2F0C2000D4AB68DE84D2DF26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:d4ab:68de:84d2:df26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F19361EC064F;
        Wed,  9 Oct 2019 18:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570640370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GbsquaH127LdAurBBI9mFs5nAaT/NPuZBLsMQqJGVuA=;
        b=AiadhddG/BIeyEcDSDnSaZr1Hn0Yh6RFYNRFC42HXx4N+jbUObiFwIZ+/2y9hwazVwktTD
        0TSTeieO82TPl1vBmd//OOYHLFS8S57gAqDvpo7mAVz4BHzGjeM6IFS4Foy0bPp6fyOV+9
        lTj9gH7z1IK49wylb7Pxovmdl74G0s8=
Date:   Wed, 9 Oct 2019 18:59:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] x86/fpu/xstate: Separate user and supervisor
 xfeatures mask
Message-ID: <20191009165921.GG10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:19AM -0700, Yu-cheng Yu wrote:
> Before the introduction of XSAVES supervisor states, 'xfeatures_mask' is
> used at various places to determine XSAVE buffer components and XCR0 bits.
> It contains only user xstates.  To support supervisor xstates, it is
> necessary to separate user and supervisor xstates:
> 
> - First, change 'xfeatures_mask' to 'xfeatures_mask_all', which represents
>   the full set of bits that should ever be set in a kernel XSAVE buffer.
> - Introduce xfeature_mask_supervisor() and xfeatures_mask_user() to

xfeatures_mask_supervisor()
	^

's' is missing.

>   extract relevant xfeatures from xfeatures_mask_all.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Similar problem here. Fenghua's SOB means what exactly?

You're probably trying to say that he co-developed it but then it needs
to state that this way:

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |  2 +-
>  arch/x86/include/asm/fpu/xstate.h   |  8 ++-
>  arch/x86/kernel/fpu/signal.c        | 15 ++++--
>  arch/x86/kernel/fpu/xstate.c        | 78 +++++++++++++++++------------
>  4 files changed, 65 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 4c95c365058a..f56ad1248b5d 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -92,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
>  	 * XRSTORS requires these bits set in xcomp_bv, or it will
>  	 * trigger #GP:
>  	 */
> -	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask;
> +	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
>  }
>  
>  static inline void fpstate_init_fxstate(struct fxregs_state *fx)
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index 014c386deaa3..5954bd97da16 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -51,7 +51,13 @@
>  #define REX_PREFIX
>  #endif
>  
> -extern u64 xfeatures_mask;
> +extern u64 xfeatures_mask_all;
> +
> +static inline u64 xfeatures_mask_user(void)
> +{
> +	return xfeatures_mask_all & SUPPORTED_XFEATURES_MASK_USER;
> +}

Please group this function along with xfeature_is_user(),
xfeature_is_supervisor() and xfeature_mask_supervisor() in the xstate.h
header as they're very similar in what they do.

> +
>  extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
>  
>  extern void __init update_regset_xstate_info(unsigned int size,

...

> @@ -731,16 +742,22 @@ void __init fpu__init_system_xstate(void)
>  		return;
>  	}
>  
> +	/*
> +	 * Find user xstates supported by the processor.
> +	 */
>  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> -	xfeatures_mask = eax + ((u64)edx << 32);
> +	xfeatures_mask_all = eax + ((u64)edx << 32);
> +
> +	/* Place supervisor features in xfeatures_mask_all here */
>  

Remove that newline.

> -	if ((xfeatures_mask & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
> +	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
>  		/*
>  		 * This indicates that something really unexpected happened
>  		 * with the enumeration.  Disable XSAVE and try to continue
>  		 * booting without it.  This is too early to BUG().
>  		 */
> -		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask);
> +		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n",
> +		       xfeatures_mask_all);
>  		goto out_disable;
>  	}
>  
> @@ -749,10 +766,10 @@ void __init fpu__init_system_xstate(void)
>  	 */
>  	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
>  		if (!boot_cpu_has(xsave_cpuid_features[i]))
> -			xfeatures_mask &= ~BIT(i);
> +			xfeatures_mask_all &= ~BIT_ULL(i);
>  	}
>  
> -	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
> +	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
>  
>  	/* Enable xstate instructions to be able to continue with initialization: */
>  	fpu__init_cpu_xstate();
> @@ -764,16 +781,16 @@ void __init fpu__init_system_xstate(void)
>  	 * Update info used for ptrace frames; use standard-format size and no
>  	 * supervisor xstates:
>  	 */
> -	update_regset_xstate_info(fpu_user_xstate_size,
> -				  xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER);
> +	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
>  
>  	fpu__init_prepare_fx_sw_frame();
>  	setup_init_fpu_buf();
>  	setup_xstate_comp();
>  	print_xstate_offset_size();
>  
> -	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
> -		xfeatures_mask,
> +	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx, context size is %d bytes, using '%s' format.\n",
> +		xfeatures_mask_all,
> +		xfeatures_mask_user(),

Why do we need to dump the user features separately?

>  		fpu_kernel_xstate_size,
>  		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
>  	return;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
