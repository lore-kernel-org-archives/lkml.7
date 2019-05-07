Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CC6206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfEGRZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:25:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEGRZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:25:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4F4A78;
        Tue,  7 May 2019 10:25:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 778373F5AF;
        Tue,  7 May 2019 10:25:19 -0700 (PDT)
Date:   Tue, 7 May 2019 18:25:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: use the correct function type for
 __arm64_sys_ni_syscall
Message-ID: <20190507172512.GA35803@lakrids.cambridge.arm.com>
References: <20190503191225.6684-1-samitolvanen@google.com>
 <20190503191225.6684-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503191225.6684-4-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 12:12:25PM -0700, Sami Tolvanen wrote:
> Calling sys_ni_syscall through a syscall_fn_t pointer trips indirect
> call Control-Flow Integrity checking due to a function type
> mismatch. Use SYSCALL_DEFINE0 for __arm64_sys_ni_syscall instead and
> remove the now unnecessary casts.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/sys.c   | 14 +++++++++-----
>  arch/arm64/kernel/sys32.c | 12 ++++++++----
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index b44065fb16160..4f8e8a7237a85 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -47,22 +47,26 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>  	return ksys_personality(personality);
>  }
>  
> +asmlinkage long sys_ni_syscall(void);
> +
> +SYSCALL_DEFINE0(ni_syscall)
> +{
> +	return sys_ni_syscall();
> +}

I strongly think that we cant to fix up the common definition in
kernel/sys_ni.c rather than having a point-hack in arm64. Other
architectures (e.g. x86, s390) will want the same for CFI, and I'd like
to ensure that our approached don't diverge.

I took a quick look, and it looks like it's messy but possible to fix
up the core.

I also suspect that using SYSCALL_DEFINE0() as it currently stands isn't
a great idea, since it'll allow fault injection for unimplemented
syscalls, which sounds dubious to me.

Thanks,
Mark.

> +
>  /*
>   * Wrappers to pass the pt_regs argument.
>   */
>  #define sys_personality		sys_arm64_personality
>  
> -asmlinkage long sys_ni_syscall(const struct pt_regs *);
> -#define __arm64_sys_ni_syscall	sys_ni_syscall
> -
>  #undef __SYSCALL
>  #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
>  #include <asm/unistd.h>
>  
>  #undef __SYSCALL
> -#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
> +#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
>  
>  const syscall_fn_t sys_call_table[__NR_syscalls] = {
> -	[0 ... __NR_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
> +	[0 ... __NR_syscalls - 1] = __arm64_sys_ni_syscall,
>  #include <asm/unistd.h>
>  };
> diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
> index 0f8bcb7de7008..f8f6c26cfd326 100644
> --- a/arch/arm64/kernel/sys32.c
> +++ b/arch/arm64/kernel/sys32.c
> @@ -133,17 +133,21 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
>  	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
>  }
>  
> -asmlinkage long sys_ni_syscall(const struct pt_regs *);
> -#define __arm64_sys_ni_syscall	sys_ni_syscall
> +asmlinkage long sys_ni_syscall(void);
> +
> +COMPAT_SYSCALL_DEFINE0(ni_syscall)
> +{
> +	return sys_ni_syscall();
> +}
>  
>  #undef __SYSCALL
>  #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
>  #include <asm/unistd32.h>
>  
>  #undef __SYSCALL
> -#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
> +#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
>  
>  const syscall_fn_t compat_sys_call_table[__NR_compat_syscalls] = {
> -	[0 ... __NR_compat_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
> +	[0 ... __NR_compat_syscalls - 1] = __arm64_sys_ni_syscall,
>  #include <asm/unistd32.h>
>  };
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
