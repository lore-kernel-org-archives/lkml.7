Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF1C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A7F21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mNnrhg1j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfJIQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:18:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:18:09 -0400
Received: from zn.tnic (p200300EC2F0C2000D4AB68DE84D2DF26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:d4ab:68de:84d2:df26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C96521EC0A91;
        Wed,  9 Oct 2019 18:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570637887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bvwkXAXhg+KG+yEXnbCW6bYT14rWgG9307Z/GR1yYlU=;
        b=mNnrhg1jbqttD53dG+1plrFMoW0qLAmK3iEaey5ML2fn3zPIwVT712pbTKsgdOxbxeBNe8
        YGRPY/hiOax73PxGAGYaO2gT6mzU22phyU9bwRgWZGBivpYL46kfPYCes2WRNX7ZzN4l+C
        sBKENldjQ6wnpMW7bXB/rWz1zOvopQU=
Date:   Wed, 9 Oct 2019 18:17:59 +0200
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
Subject: Re: [PATCH 2/6] x86/fpu/xstate: Define new macros for supervisor and
 user xstates
Message-ID: <20191009161759.GF10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-3-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:18AM -0700, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> XCNTXT_MASK is 'all supported xfeatures' before introducing supervisor
> xstates.  It is hereby renamed to SUPPORTED_XFEATURES_MASK_USER to make it
	    ^^^^^^^^^^^^^^^^^^^^

To quote straight from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

IOW, s/It is hereby renamed/Rename it/ - much simpler. Check all your
commit messages too pls.

> clear that these are user xstates.
> 
> XFEATURE_MASK_SUPERVISOR is replaced with the following:
> - SUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently nothing.  ENQCMD and
>   Control-flow Enforcement Technology (CET) will be introduced in separate
>   series.
> - UNSUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently only Processor Trace.
> - ALL_XFEATURES_MASK_SUPERVISOR: the combination of above.
> 
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

Your SOB needs to come after Fenghua's since you're sending the patch:

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

This way, the SOB chain shows the path the patch has taken and who has
handled it along the way.

Check your other SOB chains too because they have the same/similar
issue.

> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h | 36 ++++++++++++++++++++-----------
>  arch/x86/kernel/fpu/init.c        |  3 ++-
>  arch/x86/kernel/fpu/xstate.c      | 26 +++++++++++-----------
>  3 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index c6136d79f8c0..014c386deaa3 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -21,19 +21,29 @@
>  #define XSAVE_YMM_SIZE	    256
>  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
>  
> -/* Supervisor features */
> -#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> -
> -/* All currently supported features */
> -#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
> -				 XFEATURE_MASK_SSE | \
> -				 XFEATURE_MASK_YMM | \
> -				 XFEATURE_MASK_OPMASK | \
> -				 XFEATURE_MASK_ZMM_Hi256 | \
> -				 XFEATURE_MASK_Hi16_ZMM	 | \
> -				 XFEATURE_MASK_PKRU | \
> -				 XFEATURE_MASK_BNDREGS | \
> -				 XFEATURE_MASK_BNDCSR)
> +/* All currently supported user features */
> +#define SUPPORTED_XFEATURES_MASK_USER (XFEATURE_MASK_FP | \
> +				       XFEATURE_MASK_SSE | \
> +				       XFEATURE_MASK_YMM | \
> +				       XFEATURE_MASK_OPMASK | \
> +				       XFEATURE_MASK_ZMM_Hi256 | \
> +				       XFEATURE_MASK_Hi16_ZMM	 | \
> +				       XFEATURE_MASK_PKRU | \
> +				       XFEATURE_MASK_BNDREGS | \
> +				       XFEATURE_MASK_BNDCSR)
> +
> +/* All currently supported supervisor features */
> +#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (0)
> +
> +/*
> + * Unsupported supervisor features. When a supervisor feature in this mask is
> + * supported in the future, move it to the supported supervisor feature mask.
> + */
> +#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> +
> +/* All supervisor states including supported and unsupported states. */
> +#define ALL_XFEATURES_MASK_SUPERVISOR (SUPPORTED_XFEATURES_MASK_SUPERVISOR | \
> +				       UNSUPPORTED_XFEATURES_MASK_SUPERVISOR)

Those are kinda too long for my taste but they're at least descriptive... :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
