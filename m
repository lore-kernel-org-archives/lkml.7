Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B3C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1752190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEk+K/M4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfGYBtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:49:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfGYBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:49:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so22125044pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 18:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jiFDcwQiGaN6vJB6KlbsTelIXNEPU4EhhSM8eaDwe28=;
        b=NEk+K/M4XoXRNkaimXAp55fFnW3FG5JYc3y4ElmVcnygNevbCkm7g12T2gZIawjH2m
         ervX0znf3v+LokRvX8HvRYRZl/+E9WIpAoEOw7CYj2MriWSfdJygVGODxCuUvmiXdEXX
         RxDDWIzRbhS1RMdFp9h7dgJ5HPvZOYNZiOC0FrRLge9QjYDB9mZb32tTG9bnJ4J1Cwlf
         9zFbjngKQdACK2PH8tc2nnDIp0V5gB6EXixQ18pjnff+elGrh5duFnjWXbo2SlVAz9e/
         jSE3gdzud8A+T/nJBAC8R4eyxE9JDvqa7P4h1FWmp3l493GQEiQ/xOG7MRT1m9wLsv3d
         Rb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jiFDcwQiGaN6vJB6KlbsTelIXNEPU4EhhSM8eaDwe28=;
        b=KZ25MRmEIDs4EuDYR4X0fLE6WnZ4RZsC44U3lU/1eHVDVAsIBE8rNH0pcMPwenhc7O
         FpvDM28omWQhiI9IHXOUm9AErwhF88DovkKVIJeK4K/DmA4oAI3YaLd20AShwLMsAEEi
         an5MtDkUnzjqjLu/VvqoVsM8UsNyq9GDBq4LhTC5Nru1Od/DKU2I3d2i+XUaE4N1inDN
         aeiDFKQaQSHsBGyqc0n0s4NJeUZePSn4VeSTLoV1hpmpgJ7p73WRXmpSLUvkg3yU14cN
         sh64bNMGSFeJyweUHgi6teNdpqChJZTdICgTDeKW5S5iTcFtaGB9P7ffadiy0u6NL3SM
         kTgQ==
X-Gm-Message-State: APjAAAWbbDqT3lHXC2RVwScf5MqAirIVT7McLL3YjPN795l37TBahL2X
        BNZ/g3456EVKFwQhiScfr5X6iA==
X-Google-Smtp-Source: APXvYqw8jGLemfwZZMgQ9iTqUNH6yOhQwK3TZ3iENKJ2ax2lB0hZ9iGxiJLocXHtOSry7RDr1MmsXw==
X-Received: by 2002:a65:5144:: with SMTP id g4mr31637451pgq.202.1564019344033;
        Wed, 24 Jul 2019 18:49:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([240e:e0:f090:3aa1:9c84:f7b8:9214:6096])
        by smtp.gmail.com with ESMTPSA id e124sm75939006pfh.181.2019.07.24.18.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 18:49:03 -0700 (PDT)
Date:   Thu, 25 Jul 2019 09:48:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Justin He <Justin.He@arm.com>
Subject: Re: [PATCH 2/2] arm: Add support for function error injection
Message-ID: <20190725014416.GC6764@leoy-ThinkPad-X240s>
References: <20190716111301.1855-1-leo.yan@linaro.org>
 <20190716111301.1855-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716111301.1855-3-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, Jul 16, 2019 at 07:13:01PM +0800, Leo Yan wrote:
> This patch implement regs_set_return_value() and
> override_function_with_return() to support function error injection
> for arm.
> 
> In the exception flow, we can update pt_regs::ARM_pc with
> pt_regs::ARM_lr so that can override the probed function return.

Gentle ping.

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  arch/arm/Kconfig                       |  1 +
>  arch/arm/include/asm/error-injection.h | 13 +++++++++++++
>  arch/arm/include/asm/ptrace.h          |  5 +++++
>  arch/arm/lib/Makefile                  |  2 ++
>  arch/arm/lib/error-inject.c            | 19 +++++++++++++++++++
>  5 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/include/asm/error-injection.h
>  create mode 100644 arch/arm/lib/error-inject.c
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8869742a85df..f7932a5e29ea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -74,6 +74,7 @@ config ARM
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> +	select HAVE_FUNCTION_ERROR_INJECTION if !THUMB2_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/arm/include/asm/error-injection.h b/arch/arm/include/asm/error-injection.h
> new file mode 100644
> index 000000000000..da057e8ed224
> --- /dev/null
> +++ b/arch/arm/include/asm/error-injection.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ASM_ERROR_INJECTION_H_
> +#define __ASM_ERROR_INJECTION_H_
> +
> +#include <linux/compiler.h>
> +#include <linux/linkage.h>
> +#include <asm/ptrace.h>
> +#include <asm-generic/error-injection.h>
> +
> +void override_function_with_return(struct pt_regs *regs);
> +
> +#endif /* __ASM_ERROR_INJECTION_H_ */
> diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> index 91d6b7856be4..3b41f37b361a 100644
> --- a/arch/arm/include/asm/ptrace.h
> +++ b/arch/arm/include/asm/ptrace.h
> @@ -89,6 +89,11 @@ static inline long regs_return_value(struct pt_regs *regs)
>  	return regs->ARM_r0;
>  }
>  
> +static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> +{
> +	regs->ARM_r0 = rc;
> +}
> +
>  #define instruction_pointer(regs)	(regs)->ARM_pc
>  
>  #ifdef CONFIG_THUMB2_KERNEL
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 0bff0176db2c..d3d7430ecd76 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -43,3 +43,5 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>  endif
> +
> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> diff --git a/arch/arm/lib/error-inject.c b/arch/arm/lib/error-inject.c
> new file mode 100644
> index 000000000000..96319d017114
> --- /dev/null
> +++ b/arch/arm/lib/error-inject.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/error-injection.h>
> +#include <linux/kprobes.h>
> +
> +void override_function_with_return(struct pt_regs *regs)
> +{
> +	/*
> +	 * 'regs' represents the state on entry of a predefined function in
> +	 * the kernel/module and which is captured on a kprobe.
> +	 *
> +	 * 'regs->ARM_lr' contains the the link register for the probed
> +	 * function and assign it to 'regs->ARM_pc', so when kprobe returns
> +	 * back from exception it will override the end of probed function
> +	 * and drirectly return to the predefined function's caller.
> +	 */
> +	regs->ARM_pc = regs->ARM_lr;
> +}
> +NOKPROBE_SYMBOL(override_function_with_return);
> -- 
> 2.17.1
> 
