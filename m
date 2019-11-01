Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D36CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD22067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUr7ArDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfKADrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:47:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33309 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfKADrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:47:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so3760783plk.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5Q9VGAIWgqBExeYcYbdu3s9udgqDxFzlJQ7eRueT/Q=;
        b=OUr7ArDiqHbONLazU8MgPIGz23M1A8vMM7F8b9Md5DVHQ+EZhCFgoZlMZ+G5HTnpZ+
         wE2eqONi9hN3i5Bcrge6nsj37dKyheWOwYi04/RxLQQQWFlzKYDXXwSGgtrWINXpoHTa
         pu2AouoST0OW8JKhXcovsqIH4Xg7eOJ6N8a30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5Q9VGAIWgqBExeYcYbdu3s9udgqDxFzlJQ7eRueT/Q=;
        b=tPCXj4hLeOmSHlRxVsmVz7I3rB9MWEJFgT4yYR91Wp9t2ZZ0X9XCSy2dwQsLK4iqg0
         3Wu4mK8AlhBGrCspWGEhpJnLiSION6LDloQgbOl2bw/cfi2HbgAkbOeWCL84qQCT66Zc
         jnJYo29nrZ6yDhhljer3Yq8Jqbe1tJxwQwABANvXpR+LWFx6k+q/HL9ygyb4mXnwhmUU
         c8jc7Z1vRFGGoSUehI646zDS6EM3AW6q62Ymuejgab58GMeYxk0jnFHX/7EchRU1Y7Hf
         c2Lka+Jy4nfo0yf7pSSFO9WeEzv58N82AsOBfj051PFWQdD00klLrWuFfDc+4Mt6GykR
         kwNg==
X-Gm-Message-State: APjAAAUtNxHaluHmLd3BycPyqejOzwScXAPXTXlUHWssLa9SGdeSYScn
        JOMGTKUJB2lWmCStsMlpy4l5EQ==
X-Google-Smtp-Source: APXvYqzxXwp35RHwMjtICT5o/o5TX+pRdcY4/XDk99r6vm9qvXrxFtMjtkTLjrDyCFVkkuXacPUM+g==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr10476445plz.323.1572580026099;
        Thu, 31 Oct 2019 20:47:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm5943741pgo.13.2019.10.31.20.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:47:05 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:47:04 -0700
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
Subject: Re: [PATCH v3 04/17] arm64: kernel: avoid x18 __cpu_soft_restart
Message-ID: <201910312046.53A31D394@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-5-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:24AM -0700, samitolvanen@google.com wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> The code in __cpu_soft_restart() uses x18 as an arbitrary temp register,
> which will shortly be disallowed. So use x8 instead.
> 
> Link: https://patchwork.kernel.org/patch/9836877/
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This one is easy to validate! ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/cpu-reset.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index 6ea337d464c4..32c7bf858dd9 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -42,11 +42,11 @@ ENTRY(__cpu_soft_restart)
>  	mov	x0, #HVC_SOFT_RESTART
>  	hvc	#0				// no return
>  
> -1:	mov	x18, x1				// entry
> +1:	mov	x8, x1				// entry
>  	mov	x0, x2				// arg0
>  	mov	x1, x3				// arg1
>  	mov	x2, x4				// arg2
> -	br	x18
> +	br	x8
>  ENDPROC(__cpu_soft_restart)
>  
>  .popsection
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
