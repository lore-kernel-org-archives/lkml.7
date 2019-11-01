Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F4CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9F21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdpHWq36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfKADzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:55:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39770 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:55:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id x28so2865956pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zSoUcnGkSf7yfDdI4UPFWole6s3LI6NqVWKcqfKw3S8=;
        b=gdpHWq36NRa5kgf+gRe/MKxYGjAw3bBoglJCiCxqDG/Z5bLWefay/odv1qRX70dC6u
         xEQoc/cnbPdiJcOxSIkOgyhVuljqbWzwmQF4cqReWLlUHB1iREij3Bw5hMnU19ZGaFou
         2x2RfVCm1NB8MMDbP9OX8d28IFnaJuv0SjjDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zSoUcnGkSf7yfDdI4UPFWole6s3LI6NqVWKcqfKw3S8=;
        b=DF26ucLGwWshAGDLr7eq+d2zfCALBYoTlKMKnDd3e3k/f4QRREqG/KYJ94YEZZXvrZ
         Qil5tuMWjX5qfNNa9euEjkd7OSMDKVLIhySWTLVlsW//54QO0uqfHirCTyY0SS8HzF5T
         VmU/SLZrll4HOwQpFF+z9z2jAn/XasejdGrt58aqF/JqVEW4MD3ylCgP7g9e7Yvstwxh
         NmanW/ahbGGvW+xhmBHDoUHMwEJ5x0kSUAoM16ljqZiOjCU43QqkO2MaVLAdVU6dzEv8
         sBQ9+hxU64V3iwNY8JSPz5DOfseyOvTFgkin0fQbIJLiIp310dTaWC/3XuAZZxCBszaI
         gnuQ==
X-Gm-Message-State: APjAAAU8CT4Ta99aJNuAp5KlEToS264unsaE58nASZ/GrRSz9bOLohtt
        +pKhYa/l+Swruuji0XhhCTxycLtPB5w=
X-Google-Smtp-Source: APXvYqx5k7aF99T5w9h4PpSwUM81mxoH0R6qDLQkK0BR3TP2j37wYiYVIHIkontT/DEGLXmTTHNH0A==
X-Received: by 2002:a17:90a:bb0b:: with SMTP id u11mr12349099pjr.94.1572580505585;
        Thu, 31 Oct 2019 20:55:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f25sm7693672pfk.10.2019.10.31.20.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:55:04 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:55:03 -0700
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
Subject: Re: [PATCH v3 07/17] scs: add support for stack usage debugging
Message-ID: <201910312054.3064999E@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031164637.48901-8-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:46:27AM -0700, samitolvanen@google.com wrote:
> Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.

Did I miss it, or is there no Kconfig section for this? I just realized
I can't find it. I was going to say "this commit log should explain
why/when this option is used", but then figured it might be explained in
the Kconfig ... but I couldn't find it. ;)

-Kees

> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 7780fc4e29ac..67c43af627d1 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -167,6 +167,44 @@ int scs_prepare(struct task_struct *tsk, int node)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_DEBUG_STACK_USAGE
> +static inline unsigned long scs_used(struct task_struct *tsk)
> +{
> +	unsigned long *p = __scs_base(tsk);
> +	unsigned long *end = scs_magic(tsk);
> +	uintptr_t s = (uintptr_t)p;
> +
> +	while (p < end && *p)
> +		p++;
> +
> +	return (uintptr_t)p - s;
> +}
> +
> +static void scs_check_usage(struct task_struct *tsk)
> +{
> +	static DEFINE_SPINLOCK(lock);
> +	static unsigned long highest;
> +	unsigned long used = scs_used(tsk);
> +
> +	if (used <= highest)
> +		return;
> +
> +	spin_lock(&lock);
> +
> +	if (used > highest) {
> +		pr_info("%s: highest shadow stack usage %lu bytes\n",
> +			__func__, used);
> +		highest = used;
> +	}
> +
> +	spin_unlock(&lock);
> +}
> +#else
> +static inline void scs_check_usage(struct task_struct *tsk)
> +{
> +}
> +#endif
> +
>  bool scs_corrupted(struct task_struct *tsk)
>  {
>  	return *scs_magic(tsk) != SCS_END_MAGIC;
> @@ -181,6 +219,7 @@ void scs_release(struct task_struct *tsk)
>  		return;
>  
>  	WARN_ON(scs_corrupted(tsk));
> +	scs_check_usage(tsk);
>  
>  	scs_account(tsk, -1);
>  	task_set_scs(tsk, NULL);
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 

-- 
Kees Cook
