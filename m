Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D887BCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD26208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g7eFmtja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKAD6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:58:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43678 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKAD6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:58:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id l24so5592732pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KTD68U7akKeCQJeQQO/3NWtyqqeAW/3/QV3ZglVyD2U=;
        b=g7eFmtjav3cj0iIv3dbseME7IVoTl6guKvHDgto9iv8aby8HSUCvIJ9sygsE5R3aF7
         sKXlGLL8uYrezZz9ZBeSn3ezAH1xjYETzfnrSaxHbKNbjiGxvuZvvDGELcQqBkpd+r4G
         E7p34oIlOhqLBiMnYarxTp8OFroVAyrGZ/Sfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KTD68U7akKeCQJeQQO/3NWtyqqeAW/3/QV3ZglVyD2U=;
        b=ULu4hLrab9wKD8G3n1T/38Dlp/r3dgsYlfYGVxlIADFFu73ef03RvLt/FlNHB1Dx7T
         J9oU26eccHiBJG8Gbf1jxuonfo9TGTQp3zOGoDp97Sq+6YJedG8wcJiI73Wo7rv/gmkw
         xD1HAozn/6nj7wn9F7/qoapbqnlZerkZIBkMeFMhn39xQXNeYC8kC9YLLTXqKtiy0UPW
         3n61TXWbT6Ljb9+Kef7/kdQGwTMqK7A45f1KZjZU8cJkKCSRvtDLGszUuZNor72k3bW/
         mbodQNwIVA0iOtwm4dY4XxMtdITTavdzC/zAaR7Aeop8w9dC21knsAmvG8k9Nig5uWaa
         AJ7A==
X-Gm-Message-State: APjAAAXRwY/5LPHUPt56Ey6Wv/3aHoqLE/31S9nGkZcgv5FLJNn9wQkX
        GE3Sq3BpyZ/pYDooEOVQG7PlUQ==
X-Google-Smtp-Source: APXvYqzUltQIjex4hQjkY+4c/lISYONuL0ugq2i91UuUeDXV/D7mzBYyTbSsX4Ym4f6zfYJqkCbq5g==
X-Received: by 2002:a17:90a:d149:: with SMTP id t9mr12088130pjw.108.1572580682690;
        Thu, 31 Oct 2019 20:58:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2sm4973514pfe.126.2019.10.31.20.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:58:01 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:58:00 -0700
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
Subject: Re: [PATCH v3 11/17] arm64: disable function graph tracing with SCS
Message-ID: <201910312056.E3315F0F@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-12-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:31AM -0700, samitolvanen@google.com wrote:
> With CONFIG_FUNCTION_GRAPH_TRACER, function return addresses are
> modified in ftrace_graph_caller and prepare_ftrace_return to redirect
> control flow to ftrace_return_to_handler. This is incompatible with
> SCS.

IIRC, the argument was to disable these on a per-arch basis instead of
doing it as a "depends on !SHADOW_CALL_STACK" in the top-level function
graph tracer Kconfig? (I'm just thinking ahead to doing this again for
other architectures, though, I guess, there is much more work than just
that for, say, x86.)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees


> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e7b57a8a5531..42867174920f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -148,7 +148,7 @@ config ARM64
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FUNCTION_ERROR_INJECTION
> -	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_GRAPH_TRACER if !SHADOW_CALL_STACK
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_IRQ_TIME_ACCOUNTING
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
