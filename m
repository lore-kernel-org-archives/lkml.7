Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F05CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4312083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J3B2kmOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfKAD4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:56:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45216 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKAD4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:56:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id y24so3745784plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8r2XeG5yFjL/afEHA1efUXOPQ4O3tMgoY9LidcT6tD0=;
        b=J3B2kmOf3zKgvU8NNZfjzZBmIFxRSy0lZFZruLxNULA4qZjQB6y6wIjGU/654UxcSq
         DGZf/NBIx2XtK2v+AA+MLyDxAbIORjfYicFLhlVGCrHycRnDK8l+uJgiV67UYT7zvD9+
         bcjozvh2Lkb/12B+x5PYqqYyeNoY18Xk3hg5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8r2XeG5yFjL/afEHA1efUXOPQ4O3tMgoY9LidcT6tD0=;
        b=VMSzBAqci9IM62PUFLfUpkrBhE1iK2KLT/i2Wj0/MmwGHklKCOAMiV7wUUANhuOP6r
         UadMxNxVMFPJihHvrsx+oESYC3Lry/Kzg31oeEtvUFKLTQ9y8YgwmJ3nGTbqVQjUEE28
         JKTX3hfOlBQYWmWnoDLxvRsAt4E0T+jntHiOMGnDUp6dyHejyDMvWSPCuRyE586W/6ow
         rgmCET6wFC2ugwUbLflvXujBtgpQLbPgxE45dqGoTvlkfw/O1u4cL+QlgQS+1ohwU4m+
         RAGu39e3TrW4+tVqq8RWXgRqMQf2Lg8GiFPYeyu9sr0IsyO2rR4vkC+Y66QnJu3h3EnO
         dY8A==
X-Gm-Message-State: APjAAAXltP4yUMKfku5SOW4XI1yWa9gEkJt8zeeojsNBQw+KC+qRHYuZ
        Q06GJ7wbaeD1CvprjBgjPiwftA==
X-Google-Smtp-Source: APXvYqy05XZ8Z7dJgqZ7/iJDGYhT5+3LQCw2SnVzAAPcmNQfe80zEq+KFf6BAA6Nkk5/7y2Fze7yKA==
X-Received: by 2002:a17:902:d88c:: with SMTP id b12mr10325171plz.254.1572580593477;
        Thu, 31 Oct 2019 20:56:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm7481695pjs.9.2019.10.31.20.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:56:32 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:56:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/17] arm64: disable kretprobes with SCS
Message-ID: <201910312056.328195A@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-11-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:30AM -0700, samitolvanen@google.com wrote:
> With CONFIG_KRETPROBES, function return addresses are modified to
> redirect control flow to kretprobe_trampoline. This is incompatible
> with SCS.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3f047afb982c..e7b57a8a5531 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -165,7 +165,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> -	select HAVE_KRETPROBES
> +	select HAVE_KRETPROBES if !SHADOW_CALL_STACK
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
>  	select IRQ_DOMAIN
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
