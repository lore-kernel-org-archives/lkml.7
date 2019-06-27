Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C48C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5792146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gIwVdMW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF0RaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:30:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36996 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfF0RaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:30:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so1659167plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqjgvA4tRI7gKXcYMCta47rMHZPYdqhreyw0ltkm5k4=;
        b=gIwVdMW2M0Xb8QXHac7LT85o8JUB3yXqnOVg8tPtqn6MlnaF7dsdIt9ho5MXcMFGcH
         vo1ZIAd2cmou7O23mzuhRtXvCTWVrEZ4GO3lvJs5z9K3wSenB4IgRxX9wSXiiXESbZ8I
         iQhVvuYzrb1LzX6+yTIs2/9up/lZ0BQGPLeas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqjgvA4tRI7gKXcYMCta47rMHZPYdqhreyw0ltkm5k4=;
        b=cVWICoskKvoFmVi3AAyBirkjMPk2by0Cpk4mZc1PF+NkDGqDfB4QxNk2qBMeJLCBC1
         +C/Dzc/6sI2OBVaIBJEGCfAtNoeSkbT/ctUQZuplr8bru7PCQDtc9BSQfdK0ooNsWeDO
         czAuMSM8Qfg9faBI2pgIETmKbriphUfgjeFmqn0VBvel2uW32S3Dd96lxsg8SX6a7sZI
         Mg7IppeC6y1R/jaVfNQ07EtAEt02T2ay9/iV7oICHnsLNXmmjtzQD5XKF3bls0YcSl4U
         DI9lDENPupLC0a0f6GdupFCuyAKpf2IoYN4TbHt3Vj7Aw88tgpPDZx2JaOGPMUcfTMEZ
         3RFw==
X-Gm-Message-State: APjAAAWpg8moCNbtggEN53sDng2aJDupe510NU0NjqyihK1rEU02UNCJ
        Q/62J0JGl7KU28pGy5zfVBM4Qq8JQVA=
X-Google-Smtp-Source: APXvYqwPcBbkreT9oXxP01E3l2iGaTwsfiGLYGLgb7tU8kShnT1MEu64YHMK+0/M//JyJa7+K31l3Q==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr5657298pls.341.1561656602817;
        Thu, 27 Jun 2019 10:30:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h14sm3638917pfq.22.2019.06.27.10.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:30:02 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:30:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 6/8] x86/vsyscall: Change the default vsyscall mode to
 xonly
Message-ID: <201906271029.584EC8319@keescook>
References: <cover.1561610354.git.luto@kernel.org>
 <30539f8072d2376b9c9efcc07e6ed0d6bf20e882.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30539f8072d2376b9c9efcc07e6ed0d6bf20e882.1561610354.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:45:07PM -0700, Andy Lutomirski wrote:
> The use case for full emulation over xonly is very esoteric.  Let's
> change the default to the safer xonly mode.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

I still think it'd be valuable to describe any known esoteric cases
here, but regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0182d2c67590..32028edc1b0e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2285,7 +2285,7 @@ config COMPAT_VDSO
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
