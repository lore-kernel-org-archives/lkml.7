Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6881ACA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF402083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gAic49MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfKAEAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:00:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43929 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfKAEAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:00:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so5596752pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqG2K0fvYUAA4E302d2Wr4MEutud0mjKuHdZBEE6NhQ=;
        b=gAic49MAeOc0RHQwT7q95mZfaWy/E6IhEpBpV5hJ3STSid/jPRu+sGJtzjSfKCXuEf
         cHqE/dxdIBbercFZyX9sSIjRyybd8IPXMMKNRCD5XgWMmq1WJvMLtGj8wgTBt16jV32H
         m8Pv3sMDvWULeXDkmLgUa3AZ6LDQXwbzmCxlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqG2K0fvYUAA4E302d2Wr4MEutud0mjKuHdZBEE6NhQ=;
        b=B+LzgnxB7uLtAFKsVPvIWVyKYhQ6IBN+wiAxWrI422aRDL++Jd0JUssECBkcy6FObf
         T1Qm4CmbHjoW0DWKKAC2tyeBhTjlroypYmPj091+aKwJXx7xJh8bnQoCawfZAtM5zNAt
         E372Y+4KnBrChJlZ01BUMmyTRmHcjCl2QWMpdHUlNp6MmFt7jOVCd3BmieleivB5Beex
         YAsLXUiDiu8K7HZ8Hwa25jNJrpQL0Sd3B95kuui9oMjT7k4Sj8kcq1cISoaf6p5OM4Qz
         ygxwFWsqoBclfQTl+Q9dmG+GUO3NMvrAKUpof9c7gCTX7iILvXE/FleuH8R98DjRjHR4
         dt/w==
X-Gm-Message-State: APjAAAVIAcsA3KOf2GucHxbBBHAUlDhXcx2jBAQ0kajhl9QCA5Yg7kUE
        sQ05/jxkC+BmCProMw2EETLJ+g==
X-Google-Smtp-Source: APXvYqwjxz9PkVBJaSe/Y1M2wUY5vJE9zTstT50unKznJW5kGeoF7F85nWGFPaym5lZ0YmXY+dykwQ==
X-Received: by 2002:aa7:90da:: with SMTP id k26mr1506175pfk.162.1572580833083;
        Thu, 31 Oct 2019 21:00:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15sm6603181pjq.19.2019.10.31.21.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:00:32 -0700 (PDT)
Date:   Thu, 31 Oct 2019 21:00:31 -0700
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
Subject: Re: [PATCH v3 14/17] arm64: efi: restore x18 if it was corrupted
Message-ID: <201910312100.E35C214206@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-15-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:34AM -0700, samitolvanen@google.com wrote:
> If we detect a corrupted x18 and SCS is enabled, restore the register
> before jumping back to instrumented code. This is safe, because the
> wrapper is called with preemption disabled and a separate shadow stack
> is used for interrupt handling.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kernel/efi-rt-wrapper.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
> index 3fc71106cb2b..945744f16086 100644
> --- a/arch/arm64/kernel/efi-rt-wrapper.S
> +++ b/arch/arm64/kernel/efi-rt-wrapper.S
> @@ -34,5 +34,10 @@ ENTRY(__efi_rt_asm_wrapper)
>  	ldp	x29, x30, [sp], #32
>  	b.ne	0f
>  	ret
> -0:	b	efi_handle_corrupted_x18	// tail call
> +0:
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	/* Restore x18 before returning to instrumented code. */
> +	mov	x18, x2
> +#endif
> +	b	efi_handle_corrupted_x18	// tail call
>  ENDPROC(__efi_rt_asm_wrapper)
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
