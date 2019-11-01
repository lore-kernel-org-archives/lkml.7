Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21027CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81CF2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A00p0LVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKAEBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:01:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44777 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfKAEBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:01:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so5594704pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0eLf5qXAn9yR1tTlhAmZ2Kyb0+x5CBMrOVTM9Du04Q8=;
        b=A00p0LVjeslqYiGa9TTMJecCqjqU7CuF+R+GJN9ZwqNA5P/P216qCVQztow4VmlEnX
         tXLnkW6Xadee2MXfzJDDN/6VDJN5Hvg7PpCaYjXDQRr3aQ7tgxO8Gz8ZM85B1pEViloJ
         seuhFXQr7ONKb9UEjQKAiqbFkyir6kSgsYGMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eLf5qXAn9yR1tTlhAmZ2Kyb0+x5CBMrOVTM9Du04Q8=;
        b=CHpxCpJZhUZa57wRAK8ySrnEoKHRgIK0vf33JP9WRcTFl9HPH2yXREM9O1vX2BHKra
         wHFEsdXDraBg/4K7pRicbeGBHgY/JO4iaJkChQujPDNeSrnPmGvx9Uo4iGVrzbiChgu9
         bs9KDQ6PGAyH2HTQaxoiZjUthLfmIFJd6JXdYrtCWwJfV4UpBiJ5nQQdtvKtyYlW1VCP
         I1n2JdzNlZKbhGaW4v5yOvUJls3Tco7okwlX84L5PxVGlxspiDgLsduccrzi8vVcZapB
         o3QD7BpPewTQr8jaZ8GEpIbJT+FEGkGNt1+PXtAGkH/mLTlHoMbceOqdtWucLQLbzek/
         ZkDw==
X-Gm-Message-State: APjAAAUGOqDYCu4x3R5/V1vXAMDDLs6LKWZ+RZ0lsbt/JgFJE2x5z+0k
        3QCxIGeDSojeW/nPISgIhFG2xQ==
X-Google-Smtp-Source: APXvYqwGmV0Y740oqbS4ugktxZHKaSCLqRcPnlrVthpsiltg8oKVKBEvzW9AoxDE8RXSX8ETUSyBWw==
X-Received: by 2002:a63:5422:: with SMTP id i34mr11142718pgb.142.1572580892713;
        Thu, 31 Oct 2019 21:01:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11sm4952818pgk.3.2019.10.31.21.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:01:31 -0700 (PDT)
Date:   Thu, 31 Oct 2019 21:01:30 -0700
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
Subject: Re: [PATCH v3 15/17] arm64: vdso: disable Shadow Call Stack
Message-ID: <201910312101.4F2048D9@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-16-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:35AM -0700, samitolvanen@google.com wrote:
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I think Nick already mentioned the missing commit log. With that:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index dd2514bb1511..a87a4f11724e 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
>  
>  VDSO_LDFLAGS := -Bsymbolic
>  
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
>  KBUILD_CFLAGS			+= $(DISABLE_LTO)
>  KASAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
