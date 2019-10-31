Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB56CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AC0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvFpZAsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfJaUDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 16:03:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38890 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:03:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so5151353pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wAwSqScQ+vUrp/ryQqbWQb0d71qTBbv+M5ScuaTLVuA=;
        b=UvFpZAsm+36z2+sVeR2oDCHtBR3Blvo8Iq+db4k7K4CtUyKAQYn5qxSLqzoHJ6/z6L
         VqALkp6XxC5EiLQ9WnBzOvBG2PcTfxaQby/DZOWC3d9nemjKCQ4r8pqb3dZaZkOYKb5t
         zUbXEXIJDZCk71l+sW/rcZw3/5hUabjvHS8Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wAwSqScQ+vUrp/ryQqbWQb0d71qTBbv+M5ScuaTLVuA=;
        b=SfvSbH8ixMLhO+t+u4yKQD74MYyT9CDqhcqi37r1KRmtKFohJoVlwr7My4kL0XqYSz
         lSXZVMESLcjNCangwzlS+2UUak8LQlxXO2/dpddxZvXa67TRIe+13DEBhmJYW0GkfGZq
         kTHh52Q/vZAuvtGMnUH1pLrVcO0YYxTMClPbnKF1Pso6EFRwLxl4xdWlGQMoyX6cknDU
         o4Il0AOgpn2GJKAsuCU/kl2dJ3UxMZwz4SdQpjB85ZMRNzeKJ8K9vp4JCBfPPkADxxtS
         3foLjbjLfSxEtenZg2hxUxQZAhlFGIEPFDOrBbcuZGVQKkljc4x4tpXorvv156XbFke/
         kKFA==
X-Gm-Message-State: APjAAAUsMuTfGRWgk6v9f+ZA75wsaarKqydvNVDLHCaRBNcHoiTq9FOH
        ZCR8CYJIf9NTd/w5C0gGOwxxfg==
X-Google-Smtp-Source: APXvYqy1QFcdBaNSK/vZaJl7cUaoBDnBBJPRlMAXTpmkfOsy4mLwiwytHZEScxC/mQYNhuxZsgvUow==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr8899385pgo.257.1572552184348;
        Thu, 31 Oct 2019 13:03:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm4230452pgm.1.2019.10.31.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 13:03:03 -0700 (PDT)
Date:   Thu, 31 Oct 2019 13:03:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RESEND PATCH] arm64: fix alternatives with LLVM's integrated
 assembler
Message-ID: <201910311303.2FBAA3E3@keescook>
References: <20191031194652.118427-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031194652.118427-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:46:52PM -0700, Sami Tolvanen wrote:
> LLVM's integrated assembler fails with the following error when
> building KVM:
> 
>   <inline asm>:12:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:21:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:24:2: error: unrecognized instruction mnemonic
>           NOT_AN_INSTRUCTION
>           ^
>   LLVM ERROR: Error parsing inline asm
> 
> These errors come from ALTERNATIVE_CB and __ALTERNATIVE_CFG,
> which test for the existence of the callback parameter in inline
> assembly using the following expression:
> 
>   " .if " __stringify(cb) " == 0\n"
> 
> This works with GNU as, but isn't supported by LLVM. This change
> splits __ALTERNATIVE_CFG and ALTINSTR_ENTRY into separate macros
> to fix the LLVM build.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/472
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/include/asm/alternative.h | 32 ++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index b9f8d787eea9..324e7d5ab37e 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -35,13 +35,16 @@ void apply_alternatives_module(void *start, size_t length);
>  static inline void apply_alternatives_module(void *start, size_t length) { }
>  #endif
>  
> -#define ALTINSTR_ENTRY(feature,cb)					      \
> +#define ALTINSTR_ENTRY(feature)					              \
>  	" .word 661b - .\n"				/* label           */ \
> -	" .if " __stringify(cb) " == 0\n"				      \
>  	" .word 663f - .\n"				/* new instruction */ \
> -	" .else\n"							      \
> +	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
> +	" .byte 662b-661b\n"				/* source len      */ \
> +	" .byte 664f-663f\n"				/* replacement len */
> +
> +#define ALTINSTR_ENTRY_CB(feature, cb)					      \
> +	" .word 661b - .\n"				/* label           */ \
>  	" .word " __stringify(cb) "- .\n"		/* callback */	      \
> -	" .endif\n"							      \
>  	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
>  	" .byte 662b-661b\n"				/* source len      */ \
>  	" .byte 664f-663f\n"				/* replacement len */
> @@ -62,15 +65,14 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>   *
>   * Alternatives with callbacks do not generate replacement instructions.
>   */
> -#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled, cb)	\
> +#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
>  	".if "__stringify(cfg_enabled)" == 1\n"				\
>  	"661:\n\t"							\
>  	oldinstr "\n"							\
>  	"662:\n"							\
>  	".pushsection .altinstructions,\"a\"\n"				\
> -	ALTINSTR_ENTRY(feature,cb)					\
> +	ALTINSTR_ENTRY(feature)						\
>  	".popsection\n"							\
> -	" .if " __stringify(cb) " == 0\n"				\
>  	".pushsection .altinstr_replacement, \"a\"\n"			\
>  	"663:\n\t"							\
>  	newinstr "\n"							\
> @@ -78,17 +80,25 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>  	".popsection\n\t"						\
>  	".org	. - (664b-663b) + (662b-661b)\n\t"			\
>  	".org	. - (662b-661b) + (664b-663b)\n"			\
> -	".else\n\t"							\
> +	".endif\n"
> +
> +#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
> +	".if "__stringify(cfg_enabled)" == 1\n"				\
> +	"661:\n\t"							\
> +	oldinstr "\n"							\
> +	"662:\n"							\
> +	".pushsection .altinstructions,\"a\"\n"				\
> +	ALTINSTR_ENTRY_CB(feature, cb)					\
> +	".popsection\n"							\
>  	"663:\n\t"							\
>  	"664:\n\t"							\
> -	".endif\n"							\
>  	".endif\n"
>  
>  #define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
> -	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> +	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
>  
>  #define ALTERNATIVE_CB(oldinstr, cb) \
> -	__ALTERNATIVE_CFG(oldinstr, "NOT_AN_INSTRUCTION", ARM64_CB_PATCH, 1, cb)
> +	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
>  #else
>  
>  #include <asm/assembler.h>
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
