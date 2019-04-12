Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34934C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C962077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hkc2Kvlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDLRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:18:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLRSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:18:08 -0400
Received: from zn.tnic (p200300EC2F08840045FC5AE246A091A8.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:45fc:5ae2:46a0:91a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 407601EC0235;
        Fri, 12 Apr 2019 19:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555089486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=In3ltAuUtXl+fwuSuXledV6ICtKZnrlFPM8O+QwkLhA=;
        b=hkc2Kvlu1LwDNY3O+tXA37EuQgrzrt6Iel0CaCu0vNCDU3LZCm2GguShJteKniYeKebCxC
        6BYG/M4uoLU3itTwQhI4ARdlfrkW9Rp9KnyaBc5o4olz8Ss0WTzBsGSaytts1rzkdqMJl+
        c/LVb1mVlREtD5K385u81C3rsyJHK9o=
Date:   Fri, 12 Apr 2019 19:17:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
Message-ID: <20190412171759.GH19808@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-25-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403164156.19645-25-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:41:53PM +0200, Sebastian Andrzej Siewior wrote:
> The previous commits refactor the restoration of the FPU registers so
> that they can be loaded from in-kernel memory. This overhead can be
> avoided if the load can be performed without a pagefault.
> 
> Attempt to restore FPU registers by invoking
> copy_user_to_fpregs_zeroing(). If it fails try the slowpath which can handle
> pagefaults.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index a5b086ec426a5..f20e1d1fffa29 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -242,10 +242,10 @@ sanitize_restored_xstate(union fpregs_state *state,
>  /*
>   * Restore the extended state if present. Otherwise, restore the FP/SSE state.
>   */
> -static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> +static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
>  {
>  	if (use_xsave()) {
> -		if ((unsigned long)buf % 64 || fx_only) {
> +		if (fx_only) {
>  			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>  			return copy_user_to_fxregs(buf);
> @@ -327,7 +327,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		if (ret)
>  			goto err_out;
>  		envp = &env;
> +	} else {

I've added here:

+               /*
+                * Attempt to restore the FPU registers directly from user
+                * memory. For that to succeed, the user accesses cannot cause
+                * page faults. If they do, fall back to the slow path below,
+                * going through the kernel buffer.
+                */

so that it is clear what's happening.

This function is doing gazillion things again ;-\

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
