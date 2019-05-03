Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C930EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D22075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfECKVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:21:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECKVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2FA374;
        Fri,  3 May 2019 03:21:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351383F557;
        Fri,  3 May 2019 03:21:31 -0700 (PDT)
Date:   Fri, 3 May 2019 11:21:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: use the correct function type in
 SYSCALL_DEFINE0
Message-ID: <20190503102128.GD47811@lakrids.cambridge.arm.com>
References: <20190501200451.255615-1-samitolvanen@google.com>
 <20190501200451.255615-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501200451.255615-3-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 01:04:51PM -0700, Sami Tolvanen wrote:
> Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
> parameters, use the correct function type to avoid indirect call
> type mismatches with Control-Flow Integrity checking.

Generally, this makes sense, but I'm not sure that this is complete.

IIUC this introduces a new type mismatch with sys_ni_syscall() in some
cases. We probably need that to use SYSCALL_DEFINE0(), and maybe have a
ksys_ni_syscall() for in-kernel wrappers.

Thanks,
Mark.

> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> index a4477e515b798..507d0ee6bc690 100644
> --- a/arch/arm64/include/asm/syscall_wrapper.h
> +++ b/arch/arm64/include/asm/syscall_wrapper.h
> @@ -30,10 +30,10 @@
>  	}										\
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>  
> -#define COMPAT_SYSCALL_DEFINE0(sname)					\
> -	asmlinkage long __arm64_compat_sys_##sname(void);		\
> -	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);	\
> -	asmlinkage long __arm64_compat_sys_##sname(void)
> +#define COMPAT_SYSCALL_DEFINE0(sname)							\
> +	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused);	\
> +	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
> +	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL_COMPAT(name) \
>  	cond_syscall(__arm64_compat_sys_##name);
> @@ -62,11 +62,11 @@
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>  
>  #ifndef SYSCALL_DEFINE0
> -#define SYSCALL_DEFINE0(sname)					\
> -	SYSCALL_METADATA(_##sname, 0);				\
> -	asmlinkage long __arm64_sys_##sname(void);		\
> -	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);	\
> -	asmlinkage long __arm64_sys_##sname(void)
> +#define SYSCALL_DEFINE0(sname)							\
> +	SYSCALL_METADATA(_##sname, 0);						\
> +	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
> +	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
> +	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
>  #endif
>  
>  #ifndef COND_SYSCALL
> -- 
> 2.21.0.593.g511ec345e18-goog
> 
