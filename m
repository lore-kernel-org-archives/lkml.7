Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785D3CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467B72080F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZuWTF4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKBRbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:31:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfKBRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:31:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id j12so3771482plt.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5U6Kj8zEV9KobA96rVptQNqSLtfG2r+Wn7yLIJ/SjM=;
        b=nZuWTF4BuB9R9IrgYRoEbpBnjy2uh+hDRXXBWx+J+/nKCK3Q9SqQb4rGc0o2JbS78Z
         IGasXP4JcJlcZqvBr8jr42AoqszXdT6ZkfobJEO3q8eAMYsdFqaxFxfcOX/QrjMVv/qW
         Gdq8mBjWvMInhMP1k9d4nI6SG1KYp3FJBWObE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5U6Kj8zEV9KobA96rVptQNqSLtfG2r+Wn7yLIJ/SjM=;
        b=LOJp3z7i8UDC+FjJ9DraxVU6a2MRxDnAOQQlTB0HWe4Az/9yh0fwQMoxJcMIWBTVvP
         jJ/DddhfceTwHoT6loBgkYLE5vQyste0lgjZFpnWBP9l4/MMow0zblbBqaO5gEPUbH3u
         IiQwl7tkv3NB1snyWlgPKE43zpXQLAvrM4OHSQH0f8/SdT8pV1Lp0qV8jy1UwHgOPd6W
         ITe0+tfh7t2aKvK6NEglzYeY4NvBo7eFe3WyA9/UJsfrgpL0/IMgvAbcpxPeIrQB90c5
         4/0TKjKgrqfM3DXzwOAUVmtSfCZnA4TQ6bQFXO+GVJkJbGAWI0xfBMzlVRdpU1l2HXH6
         kqEg==
X-Gm-Message-State: APjAAAUtfyyIhAjJaN/6hQizVbq2M/FFZKpxsDL6tXvZg57sZSgiIJfz
        FQAyofaxtlpjVukdOzzTaHTlvQ==
X-Google-Smtp-Source: APXvYqwc02Tws2pGBZl8WuCjpMDz1HN7KL0ueLxBeqsIsd4eXR/cQCznRRNO20Nh24wWyn2g8VRU7w==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr18474527plt.162.1572715878210;
        Sat, 02 Nov 2019 10:31:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13sm9636034pga.70.2019.11.02.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 10:31:16 -0700 (PDT)
Date:   Sat, 2 Nov 2019 10:31:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] scs: add support for stack usage debugging
Message-ID: <201911021030.88433384D9@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101221150.116536-8-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:11:40PM -0700, Sami Tolvanen wrote:
> Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
> also prints out the highest shadow stack usage per process.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks for helping me find this Kconfig. :) :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

-- 
Kees Cook
