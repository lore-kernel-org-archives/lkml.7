Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A78ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E991F21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="je0XGUyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfJIP66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:58:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfJIP66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:58:58 -0400
Received: from zn.tnic (p200300EC2F0C2000D4AB68DE84D2DF26.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:d4ab:68de:84d2:df26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6830D1EC0A91;
        Wed,  9 Oct 2019 17:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570636737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M1+S/Xh+Q6G7TXesXpZe+1vhubyhCP1yliSUbUZuVWQ=;
        b=je0XGUyLA6NCnstAuKvK/RNYlrR/v4zFiRlRB9TK2BS/xneHsQ5lo+GgS9xoqCBTKIBTbO
        t7Gzu4I7EQXifgfrJai8PYesVL/J1+P9frmJlPsJPBQ2/H6WJrxZsXhJwOL6OSWxJr8TMP
        jKXSaa24+PW++TwlwPP2MPnvNVsrycA=
Date:   Wed, 9 Oct 2019 17:58:47 +0200
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
Subject: Re: [PATCH 1/6] x86/fpu/xstate: Fix small issues before adding
 supervisor xstates
Message-ID: <20191009155847.GE10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
 <20190925151022.21688-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925151022.21688-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 08:10:17AM -0700, Yu-cheng Yu wrote:
> In response to earlier comments, fix small issues before introducing XSAVES
> supervisor states:
> - Add spaces around '*'.
> - Fix comments of xfeature_is_supervisor().
> - Replace ((u64)1 << 63) with XCOMP_BV_COMPACTED_FORMAT.
> 
> No functional changes from this patch.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index e5cb67d67c03..b793fc2156b9 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -60,7 +60,7 @@ u64 xfeatures_mask __read_mostly;
>  
>  static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
>  static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
> -static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
> +static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask) * 8];
>  
>  /*
>   * The XSAVE area of kernel can be in standard or compacted format;
> @@ -110,12 +110,8 @@ EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
>  static int xfeature_is_supervisor(int xfeature_nr)
>  {
>  	/*
> -	 * We currently do not support supervisor states, but if
> -	 * we did, we could find out like this.
> -	 *
> -	 * SDM says: If state component 'i' is a user state component,
> -	 * ECX[0] return 0; if state component i is a supervisor
> -	 * state component, ECX[0] returns 1.
> +	 * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
> +	 * returns ECX[0] set to (1) for a supervisor state.

"... and cleared (0) for a user state."

I believe it is is clearer this way.

>  	 */
>  	u32 eax, ebx, ecx, edx;
>  

Since you're touching this function: make it return bool as it is used
in boolean context only and have it return simply:

	return ecx & 1;

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
