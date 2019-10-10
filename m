Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23905C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD6E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyr9x20G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfJJUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:50:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36302 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:50:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so4660228pfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gTe8iNaxaDxo3Ior1zBkaqpJB3M8k9IqOsu5lEyzZ6c=;
        b=iyr9x20GP1WU8DN+/0xoZwBSMlPw9mrEynzZlnzafLl5NPpDb004gL2BV4OZC7paoq
         GyZ7dgkYsaZ1hlPMHou7/tr3rROSUsdi52RYluXDXLrwapl4nS+Eyx7bNpw4pSGVDzRU
         YMp5InHddbXjyo4Yde7NO5MQSBXLXHfSLN3U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gTe8iNaxaDxo3Ior1zBkaqpJB3M8k9IqOsu5lEyzZ6c=;
        b=tOUXum+uNQQPxXIJ91NHPvDF1mA1KtjECrQoB9CkQITsV2A1qVL8AR03e17H8jN9Q3
         Wu+caX3p4r9ZCYFmW7gaIJ8TAqCKbfrAbY/N6xBhhHeaTyuE2s+Pp6XjW1rpSp8tNyoX
         LgPtemQYCxW3IQPUDc9LRcyhZLUHSKiXmyj9arD35VALQG4VkY7hLEjO8n+dfA1E+04+
         Zo+PlT9NdCZake7GZHIWPeaoxvZFKH4NwFppXasCIqH8vr1c4aiCehBoZ1Hu8Kr69haH
         2dJGY4NZde/bZLfVZRkWOaJfFp1gGYCPq1fFCzk93X4405qNApzRHqnCHaDAEoL5It9X
         AQxg==
X-Gm-Message-State: APjAAAWRrzVosa4Ar4EC47pkVAUxehqz37ddDL6Xe1UGz//v6i/RYh78
        DigQ51rUgLTQVx/hAwu5OUKXSQ==
X-Google-Smtp-Source: APXvYqwfVW1rYKresV0WxEAKYTz7345kuA+YHn4SzfLAFmKTbOFrrWCKrVBFa8+o+/WUfP7VOKfEow==
X-Received: by 2002:a63:1417:: with SMTP id u23mr12704993pgl.279.1570740615870;
        Thu, 10 Oct 2019 13:50:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c62sm8370453pfa.92.2019.10.10.13.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:50:15 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:50:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 09/10] lib/refcount: Remove unused
 'refcount_error_report()' function
Message-ID: <201910101349.9400E7D0@keescook>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-10-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007154703.5574-10-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:47:02PM +0100, Will Deacon wrote:
> 'refcount_error_report()' has no callers. Remove it.

Seems like this could be collapsed into patch 8? Either way:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/kernel.h |  7 -------
>  kernel/panic.c         | 11 -----------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d83d403dac2e..09f759228e3f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -328,13 +328,6 @@ extern int oops_may_print(void);
>  void do_exit(long error_code) __noreturn;
>  void complete_and_exit(struct completion *, long) __noreturn;
>  
> -#ifdef CONFIG_ARCH_HAS_REFCOUNT
> -void refcount_error_report(struct pt_regs *regs, const char *err);
> -#else
> -static inline void refcount_error_report(struct pt_regs *regs, const char *err)
> -{ }
> -#endif
> -
>  /* Internal, do not use. */
>  int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
>  int __must_check _kstrtol(const char *s, unsigned int base, long *res);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 47e8ebccc22b..10d05fd4f9c3 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -670,17 +670,6 @@ EXPORT_SYMBOL(__stack_chk_fail);
>  
>  #endif
>  
> -#ifdef CONFIG_ARCH_HAS_REFCOUNT
> -void refcount_error_report(struct pt_regs *regs, const char *err)
> -{
> -	WARN_RATELIMIT(1, "refcount_t %s at %pB in %s[%d], uid/euid: %u/%u\n",
> -		err, (void *)instruction_pointer(regs),
> -		current->comm, task_pid_nr(current),
> -		from_kuid_munged(&init_user_ns, current_uid()),
> -		from_kuid_munged(&init_user_ns, current_euid()));
> -}
> -#endif
> -
>  core_param(panic, panic_timeout, int, 0644);
>  core_param(panic_print, panic_print, ulong, 0644);
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

-- 
Kees Cook
