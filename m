Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BFE20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RacoZA+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfJIRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:11:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731451AbfJIRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:11:06 -0400
Received: from zn.tnic (p200300EC2F0C2000D4AB68DE84D2DF26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:d4ab:68de:84d2:df26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 508601EC064F;
        Wed,  9 Oct 2019 19:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570641061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1ZIFe3tHT56T+BPnZSTKieo9DYJoh83H/Kdmsd0WBps=;
        b=RacoZA+vk3VUI7vdwM0S3cF/CLHLKuetbAbgp6nKVQFt2LVBEcvWhU/iUkzq9TyOZ4rGmt
        GsRgm2p5zMrC4/zPHGOTf0Ci7n/LljuS/S7W739sS954PRCs25MTlcAjEsCftOvJLW+YJx
        J2tbOu+WczzmQFPcOlEjiI97Yc5FSoQ=
Date:   Wed, 9 Oct 2019 19:10:54 +0200
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
Subject: Re: [PATCH 4/6] x86/fpu/xstate: Introduce XSAVES supervisor states
Message-ID: <20191009171054.GH10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-5-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:20AM -0700, Yu-cheng Yu wrote:
> Enable XSAVES supervisor states by setting MSR_IA32_XSS bits according to
> CPUID enumeration results.  Also revise comments at various places.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Same issue as before.

> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index b7f2808dd3f4..a183c319d808 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -233,13 +233,14 @@ void fpu__init_cpu_xstate(void)
>  	 * states can be set here.
>  	 */
>  	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
> +
> +	/*
> +	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
>  }
>  
> -/*
> - * Note that in the future we will likely need a pair of
> - * functions here: one for user xstates and the other for
> - * system xstates.  For now, they are the same.
> - */
>  static int xfeature_enabled(enum xfeature xfeature)
>  {
>  	return !!(xfeatures_mask_all & (1UL << xfeature));
> @@ -623,9 +624,6 @@ static void do_extra_xstate_size_checks(void)
>   * the size of the *user* states.  If we use it to size a buffer
>   * that we use 'XSAVES' on, we could potentially overflow the
>   * buffer because 'XSAVES' saves system states too.
> - *
> - * Note that we do not currently set any bits on IA32_XSS so
> - * 'XCR0 | IA32_XSS == XCR0' for now.
>   */
>  static unsigned int __init get_xsaves_size(void)
>  {
> @@ -748,7 +746,11 @@ void __init fpu__init_system_xstate(void)
>  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
>  	xfeatures_mask_all = eax + ((u64)edx << 32);
>  
> -	/* Place supervisor features in xfeatures_mask_all here */
> +	/*
> +	 * Find supervisor xstates supported by the processor.
> +	 */
> +	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
> +	xfeatures_mask_all |= ecx + ((u64)edx << 32);
>  
>  	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
>  		/*
> @@ -788,9 +790,10 @@ void __init fpu__init_system_xstate(void)
>  	setup_xstate_comp();
>  	print_xstate_offset_size();
>  
> -	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx, context size is %d bytes, using '%s' format.\n",
> +	pr_info("x86/fpu: Enabled xstate features 0x%llx: user 0x%llx and supervisor %llx, context size is %d bytes, using '%s' format.\n",
>  		xfeatures_mask_all,
>  		xfeatures_mask_user(),
> +		xfeatures_mask_supervisor(),

So if you're dumping both user and supervisor, then you don't need to
dump _all anymore. Do it this way:

	pr_info("x86/fpu: Enabled xstate features: (U: 0x%llx, S: 0x%llx), context size: %d bytes, using '%s' format.\n",
  		xfeatures_mask_user(),
 		xfeatures_mask_supervisor(),

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
