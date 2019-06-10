Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DFC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4E206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2CZUihY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389823AbfFJUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:44:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45655 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:44:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so5946390pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gFNF363RDc/XdYA/qTwjgCIxHifrzxkDYNHAq+P6+0s=;
        b=e2CZUihYvTafnYYHa056o7+bSSzfL1Ff4bnwCZJQJRYmAZXuNLs4PAqpQu2Hc877TH
         oVAuevfcQD/nV5NtqR0pXt0JiPAQE1f+NvWQAA/cDZJNvE1WXgUMc4qET2B9/WPz4AZI
         JaHy3eRaR0YvxNOAZ1ua6HxHSX0pLNCycB4r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gFNF363RDc/XdYA/qTwjgCIxHifrzxkDYNHAq+P6+0s=;
        b=hJLuz0s/mGEgPboKnmltt4+P8EfUXzj11FQXAJBGSyffSF/K1wzv46fQZYxSWEdVZR
         1BGYeUQYtj5m90awlTIk9C/FcNm2fdvovdCyndFbtX+ijzOrt9c8xLdLOlsfUm83v+DY
         ptyGBDTF1sr2UjCtMusbtzn9I3U4V5wkqvObS/umCe1VqHWvy2SqoSxbuAcLERtZvt6K
         vSiulW4mPfK131jwIcIEuVnI2YX2qwkyytuWPSR/Nf53Sta24+USmYhOBaekvJUel+aY
         NyowNK1D/IWNKlne+uy0Ddce9ddEmDdj0rhyHavrBgLCMD7aHOP9FE4TF0FKJ3lCAk1K
         L3Kw==
X-Gm-Message-State: APjAAAV66PY4rKtkVT7a4R7+gXjtmvitEHK35bK1LvPyr60uotaQM4Cg
        Dmi/Cx/97eaaCKAce57fX/7T+w==
X-Google-Smtp-Source: APXvYqybNR2PIaiWpTHApIK7YBw6IPSSen1QXNs1Vc9JJjXcnCU9uxUQ/3zVX0wDRddk2VworcnaBw==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr23332542pjq.120.1560199496619;
        Mon, 10 Jun 2019 13:44:56 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a192sm876392pfa.84.2019.06.10.13.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 13:44:55 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:44:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/vsyscall: Change the default vsyscall mode to
 xonly
Message-ID: <201906101344.018BE4C5C1@keescook>
References: <cover.1560198181.git.luto@kernel.org>
 <25fd7036cefca16c68ecd990e05e05a8ad8fe8b2.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25fd7036cefca16c68ecd990e05e05a8ad8fe8b2.1560198181.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:25:31PM -0700, Andy Lutomirski wrote:
> The use case for full emulation over xonly is very esoteric.  Let's
> change the default to the safer xonly mode.

Perhaps describe the esoteric cases here (and maybe in the Kconfig help
text)? That should a user determine if they actually need it. (What
would the failure under xonly look like for someone needing emulate?)

-Kees

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 054033cc4b1b..e56f33e6b045 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2280,7 +2280,7 @@ config COMPAT_VDSO
>  choice
>  	prompt "vsyscall table for legacy applications"
>  	depends on X86_64
> -	default LEGACY_VSYSCALL_EMULATE
> +	default LEGACY_VSYSCALL_XONLY
>  	help
>  	  Legacy user code that does not know how to find the vDSO expects
>  	  to be able to issue three syscalls by calling fixed addresses in
> -- 
> 2.21.0
> 

-- 
Kees Cook
