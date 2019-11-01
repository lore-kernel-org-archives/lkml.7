Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C483DCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00A208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGvNnz+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfKADz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:55:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:55:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so5597765pgn.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YiqPN73/qfLoGFPAaCK046WeDsIyHq2v7vxAoPf2Hxg=;
        b=DGvNnz+GeHeNfKZ6f7YLJzc3HABEEC30I8/B/IBZTbAoWTqYDEBA+PWjh7ne14xEji
         PE2FdEWksdLdMt2PKYPe0QSMEXkBcV49KFClWQ42/xFPVspDKk4kFzSNVn/0QiVKU0Hk
         Z4vIKb88INGDp/qLR22O2YTnuCwiKgJmJAvqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiqPN73/qfLoGFPAaCK046WeDsIyHq2v7vxAoPf2Hxg=;
        b=dmAYFekJ00hpP0CURAAUz5Do6e3iGdYT9Dk3BMoZMdX1nw0oWP98vbLqyMI5qXIbtw
         /Bzegmvrmdc3rzpE0U/4STSefCVtkh50NdZ7QDhb+NbKl2ZtEBe3TTXYNy0wVvWHo39U
         KJpq2Ii+G88YyyZ0BkXzLuxFABfT2i7AzHYI3Oxok8fvSpd9XphdUVYsAxnO+kpw7k4g
         4xXA9p51J3coriU4PLcG34kM0LZsDutKiJv5xsTPoh9Hut9szPlD2hjW285te9bZWSVE
         Gd+wz9pnJePzJhpOAqpdx9kz7Yn5/PKbqPYOYPXnxo4JfgT8OSo/SsIqnkvLZfNP9xEy
         o8Cw==
X-Gm-Message-State: APjAAAUnIA8CID4P21XztOCFizN2zFkve2g9A7/1qv/Mfpdv0E5R7Yw8
        6By+ZQlo7PsAQsytBXVRq/HTpw==
X-Google-Smtp-Source: APXvYqxD7MNY1jVYOjRfhYGo3ogwiiuExle/jPXGM0/pINsljnFcAcPtUzMI8R27pVSvoSzQhhOLJg==
X-Received: by 2002:a17:90a:f310:: with SMTP id ca16mr5852511pjb.20.1572580527358;
        Thu, 31 Oct 2019 20:55:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm4704403pfo.91.2019.10.31.20.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:55:26 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:55:25 -0700
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
Subject: Re: [PATCH v3 08/17] kprobes: fix compilation without
 CONFIG_KRETPROBES
Message-ID: <201910312055.B551A6CB4@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-9-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:28AM -0700, samitolvanen@google.com wrote:
> kprobe_on_func_entry and arch_kprobe_on_func_entry need to be available
> even if CONFIG_KRETPROBES is not selected.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

FWIW:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 53534aa258a6..b5e20a4669b8 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1829,6 +1829,25 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  	return (unsigned long)entry;
>  }
>  
> +bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return !offset;
> +}
> +
> +bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> +{
> +	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> +
> +	if (IS_ERR(kp_addr))
> +		return false;
> +
> +	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> +						!arch_kprobe_on_func_entry(offset))
> +		return false;
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_KRETPROBES
>  /*
>   * This kprobe pre_handler is registered with every kretprobe. When probe
> @@ -1885,25 +1904,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> -bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> -{
> -	return !offset;
> -}
> -
> -bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> -{
> -	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> -
> -	if (IS_ERR(kp_addr))
> -		return false;
> -
> -	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> -						!arch_kprobe_on_func_entry(offset))
> -		return false;
> -
> -	return true;
> -}
> -
>  int register_kretprobe(struct kretprobe *rp)
>  {
>  	int ret = 0;
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
