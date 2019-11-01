Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715CCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78D62067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJQVm+nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfKADqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:46:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36544 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfKADqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:46:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id j22so5593146pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ipB5k5z37+Fd8igQLbmVYrL5E9roHGbRK+wBmA4Y9yU=;
        b=IJQVm+nHblMlKtJOM196C6hcfBE3KUu5qTQKv0FOe/rkT2KShvxSF9ZK3miYtArp8S
         iCx9zhvAVMbHgtEQYP6IvQSYka4Me/BNhBXNxL6j6tLCRlIaOcOYAOppDrF9cr1jDZQa
         fRCejTSNEe4g/nH0rKI9uiV455M5B/EKg6M0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ipB5k5z37+Fd8igQLbmVYrL5E9roHGbRK+wBmA4Y9yU=;
        b=L6sh2NC4+ZyUSKCB95IAjU6CtaPqfdwqML46A6kMu0BJzifZfSOtEU3B7Y2jnbnWo/
         Iz8KuTN/lRrkooQvy8dEUIcnKA+tCaD+2RTrnb6HygOndJkTLzxoYzWtoFfp8EVpMgiS
         8zzD6bUQHM+1CO49pno3nVEoMTqcHSJ2nPvH6o44NgQzvG3dVQx4RmS0tKYxzItVxeCm
         y/jEOkqngsAXu8jlZtEhViACIUI+oJJhTBo/I4t8tJedmyvYOCP6xAr+zDBEIFf937W3
         wDUiZFNYb0R5bYBwDdj01v2rXe02GoVAjkETG464roe8eYJ4S/Iy44tm4bGUw8RLsSaq
         PcTQ==
X-Gm-Message-State: APjAAAUfDXDk4M6NWPJJKdIfkbpK2+dCr5K99WhBG+0HE4w8MvuK9esd
        pL4S/u56ihsATWLYokAXw7Y+fQ==
X-Google-Smtp-Source: APXvYqzPevvEfpBSK+c7IiF5pLcK+obnlKmRuGuDHbGO/WB/NYdDcoJIb57F0lxIPa76vBgqS1skUA==
X-Received: by 2002:a17:90a:2326:: with SMTP id f35mr12315696pje.134.1572579965327;
        Thu, 31 Oct 2019 20:46:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m12sm6209846pjk.13.2019.10.31.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:46:04 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:46:03 -0700
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
Subject: Re: [PATCH v3 16/17] arm64: disable SCS for hypervisor code
Message-ID: <201910312046.343E275D@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-17-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:36AM -0700, samitolvanen@google.com wrote:
> Filter out CC_FLAGS_SCS for code that runs at a different exception
> level.
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kvm/hyp/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index ea710f674cb6..17ea3da325e9 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
>  KASAN_SANITIZE	:= n
>  UBSAN_SANITIZE	:= n
>  KCOV_INSTRUMENT	:= n
> +
> +# remove the SCS flags from all objects in this directory
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
