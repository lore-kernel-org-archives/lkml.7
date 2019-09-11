Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDAC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005DE2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfIKPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:15:56 -0400
Received: from foss.arm.com ([217.140.110.172]:49366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfIKPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:15:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A9828;
        Wed, 11 Sep 2019 08:15:55 -0700 (PDT)
Received: from blommer (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763A23F67D;
        Wed, 11 Sep 2019 08:15:53 -0700 (PDT)
Date:   Wed, 11 Sep 2019 16:15:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix function types in COND_SYSCALL
Message-ID: <20190911151545.GD3360@blommer>
References: <20190910224044.100388-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910224044.100388-1-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 03:40:44PM -0700, Sami Tolvanen wrote:
> Define a weak function in COND_SYSCALL instead of a weak alias to
> sys_ni_syscall, which has an incompatible type. This fixes indirect
> call mismatches with Control-Flow Integrity (CFI) checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

This looks correct to me, builds fine, and I asume has been tested, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

In looking at this, I came to the conclusion that we can drop the ifdeffery
around our SYSCALL_DEFINE0(), COND_SYSCALL(), and SYS_NI(), which I evidently
cargo-culted from x86 (where the ifdeffery is actually necessary).

I can send a follow up for that.

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/syscall_wrapper.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> index 507d0ee6bc69..06d880b3526c 100644
> --- a/arch/arm64/include/asm/syscall_wrapper.h
> +++ b/arch/arm64/include/asm/syscall_wrapper.h
> @@ -8,6 +8,8 @@
>  #ifndef __ASM_SYSCALL_WRAPPER_H
>  #define __ASM_SYSCALL_WRAPPER_H
>  
> +struct pt_regs;
> +
>  #define SC_ARM64_REGS_TO_ARGS(x, ...)				\
>  	__MAP(x,__SC_ARGS					\
>  	      ,,regs->regs[0],,regs->regs[1],,regs->regs[2]	\
> @@ -35,8 +37,11 @@
>  	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
>  	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
>  
> -#define COND_SYSCALL_COMPAT(name) \
> -	cond_syscall(__arm64_compat_sys_##name);
> +#define COND_SYSCALL_COMPAT(name) 							\
> +	asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)	\
> +	{										\
> +		return sys_ni_syscall();						\
> +	}
>  
>  #define COMPAT_SYS_NI(name) \
>  	SYSCALL_ALIAS(__arm64_compat_sys_##name, sys_ni_posix_timers);
> @@ -70,7 +75,11 @@
>  #endif
>  
>  #ifndef COND_SYSCALL
> -#define COND_SYSCALL(name) cond_syscall(__arm64_sys_##name)
> +#define COND_SYSCALL(name)							\
> +	asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)	\
> +	{									\
> +		return sys_ni_syscall();					\
> +	}
>  #endif
>  
>  #ifndef SYS_NI
> -- 
> 2.23.0.162.g0b9fbb3734-goog
> 
