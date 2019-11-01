Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B3CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2973208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CCX57PXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfKAD4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:56:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45051 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKAD4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:56:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so3744239pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z+nYmbiX+N1St4EAeF06ZLBIc22exSOWn82chVWgQ58=;
        b=CCX57PXeSP8raTIa7stPdOtMkXfDOMY7T1F5hUmVdwgHt3jJlYyT6pDYvyD+nZPnjd
         RDynOfkryq8ctGOLHdv/HhV7WAh/aJmiBALoqt5gki6zK0lyCCvj+8TBwx4BlVd4ZsYn
         QlzmEfXTcWlJFOzLS3MwRZqKvvLzEB2qTfEAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+nYmbiX+N1St4EAeF06ZLBIc22exSOWn82chVWgQ58=;
        b=K1AjSF6yK56a555Q0cPLE1XLsiTOWwogQwpEjr5cl+ju/Dn6RrFpEIBEuw4zfZHUfa
         ctouiVh4jKQzlLLXwAO5nAhMTPE05wydKJaO2FufQolUAtcq+ai7UnPytCpxpgvVWB7G
         IVvQScb4jxJcGcAQWvgD5Z9hkYhckGzosRT4JfLZOdMkYhyR3NKbSXZKjf+tJBv+zjBb
         ohWQGg335nKO7iNxXepIbDrGffT4ZyIJOTcYoW3NL+NOW6JH4vnvhrkFSCsfDv1IU722
         tdxvPJIFDgZ9JAeIUc272yt1gfj8qTBgaNr2HO5HQadvcj5JoSJ9RoPDFs/4eoDDJxlx
         r9hw==
X-Gm-Message-State: APjAAAVCGRSf8VGhuElZH1fDq8EtflHrtfb3aCcemwfTKni/cZc7R0df
        kllcehyMrnK6LJFaLDYVTlwqRw==
X-Google-Smtp-Source: APXvYqzjbJ7PTCwR8dbLX9yGoruNQd+AcfmNqc/IOeBXJ7CEpc7/rFxnCKUJlN4CgjbHYqxLA44oZA==
X-Received: by 2002:a17:902:988d:: with SMTP id s13mr10329146plp.335.1572580573736;
        Thu, 31 Oct 2019 20:56:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm4476882pgi.19.2019.10.31.20.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:56:12 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:56:11 -0700
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
Subject: Re: [PATCH v3 09/17] arm64: kprobes: fix kprobes without
 CONFIG_KRETPROBES
Message-ID: <201910312055.BD31A966DB@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-10-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:29AM -0700, samitolvanen@google.com wrote:
> This allows CONFIG_KRETPROBES to be disabled without disabling
> kprobes entirely.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Is this worth folding this into the prior kprobes patch? Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm64/kernel/probes/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index c4452827419b..98230ae979ca 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -551,6 +551,7 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  	return (void *)orig_ret_address;
>  }
>  
> +#ifdef CONFIG_KRETPROBES
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs)
>  {
> @@ -564,6 +565,7 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	return 0;
>  }
> +#endif
>  
>  int __init arch_init_kprobes(void)
>  {
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
