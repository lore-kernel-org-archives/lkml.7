Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF56C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994C62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 03:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555300159;
	bh=64XmQf7nCf0y0YDJqs15vyxfpTggg8ygj+mwvoRyJmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gr7D0Oj7wgg1QsBpqWVpVCYSas9/9+8H6b6+St0sUN+X5D/wRatkS5ZpdtfPOQvXD
	 bL0XV+XWQbaPOkhulXfB7ZYWri12IUb1HbuNwXyT2LscqlLf3tWLfykBcTgbkUcimF
	 WuXQ5VJr8OmKd6zKzbgnD8UPdgZNURhMRw2ayhXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDODtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 23:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfDODtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 23:49:17 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A8B2075B;
        Mon, 15 Apr 2019 03:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555300156;
        bh=64XmQf7nCf0y0YDJqs15vyxfpTggg8ygj+mwvoRyJmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsNpcdoA1NBQtV0A+kpNGHhoUc6XdhxNRvcxB1A2mkw7FEf53ocxPGJOvCmH/qEKX
         ykeh6DK6B1GIKOfdp/2hiNgtrBRpXNBwtnlAZaFwPrNAGzU11U9fvAvqm76QOYkJWq
         XiTgfxcmftvDK1VNPXPUUCOjWscGb+SpBzedsg/M=
Date:   Mon, 15 Apr 2019 11:49:01 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] csky: Add support for perf registers sampling
Message-ID: <20190415034901.GA958@guoren-Inspiron-7460>
References: <cover.1554967684.git.han_mao@c-sky.com>
 <c1d58e5813ac45b30b29f3b67f9856fd32c8b42d.1554967684.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d58e5813ac45b30b29f3b67f9856fd32c8b42d.1554967684.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

On Thu, Apr 11, 2019 at 03:45:00PM +0800, Mao Han wrote:
> This patch implements the perf registers sampling and validation API
> for csky arch. The valid registers and their register ID are defined in
> perf_regs.h. Perf tool can backtrace in userspace with unwind library
> and the registers/user stack dump support.
> 
> CC: Guo Ren <guoren@kernel.org>
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> ---
>  arch/csky/Kconfig                      |  2 ++
>  arch/csky/include/uapi/asm/perf_regs.h | 51 ++++++++++++++++++++++++++++++++++
>  arch/csky/kernel/Makefile              |  1 +
>  arch/csky/kernel/perf_regs.c           | 40 ++++++++++++++++++++++++++
>  4 files changed, 94 insertions(+)
>  create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/csky/kernel/perf_regs.c
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index c4974cf..8e45c7a 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -38,6 +38,8 @@ config CSKY
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
>  	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_REGS
> +	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/csky/include/uapi/asm/perf_regs.h b/arch/csky/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..ee323d8
> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef _ASM_CSKY_PERF_REGS_H
> +#define _ASM_CSKY_PERF_REGS_H
> +
> +/* Index of struct pt_regs */
> +enum perf_event_csky_regs {
> +	PERF_REG_CSKY_TLS,
> +	PERF_REG_CSKY_LR,
> +	PERF_REG_CSKY_PC,
> +	PERF_REG_CSKY_SR,
> +	PERF_REG_CSKY_SP,
> +	PERF_REG_CSKY_ORIG_A0,
> +	PERF_REG_CSKY_A0,
> +	PERF_REG_CSKY_A1,
> +	PERF_REG_CSKY_A2,
> +	PERF_REG_CSKY_A3,
> +	PERF_REG_CSKY_REGS0,
> +	PERF_REG_CSKY_REGS1,
> +	PERF_REG_CSKY_REGS2,
> +	PERF_REG_CSKY_REGS3,
> +	PERF_REG_CSKY_REGS4,
> +	PERF_REG_CSKY_REGS5,
> +	PERF_REG_CSKY_REGS6,
> +	PERF_REG_CSKY_REGS7,
> +	PERF_REG_CSKY_REGS8,
> +	PERF_REG_CSKY_REGS9,
> +#if defined(__CSKYABIV2__)
> +	PERF_REG_CSKY_EXREGS0,
> +	PERF_REG_CSKY_EXREGS1,
> +	PERF_REG_CSKY_EXREGS2,
> +	PERF_REG_CSKY_EXREGS3,
> +	PERF_REG_CSKY_EXREGS4,
> +	PERF_REG_CSKY_EXREGS5,
> +	PERF_REG_CSKY_EXREGS6,
> +	PERF_REG_CSKY_EXREGS7,
> +	PERF_REG_CSKY_EXREGS8,
> +	PERF_REG_CSKY_EXREGS9,
> +	PERF_REG_CSKY_EXREGS10,
> +	PERF_REG_CSKY_EXREGS11,
> +	PERF_REG_CSKY_EXREGS12,
> +	PERF_REG_CSKY_EXREGS13,
> +	PERF_REG_CSKY_EXREGS14,
> +	PERF_REG_CSKY_HI,
> +	PERF_REG_CSKY_LO,
> +	PERF_REG_CSKY_DCSR,
> +#endif
> +	PERF_REG_CSKY_MAX,
> +};
> +#endif /* _ASM_CSKY_PERF_REGS_H */
> diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
> index 4c462f5..1624b04 100644
> --- a/arch/csky/kernel/Makefile
> +++ b/arch/csky/kernel/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
>  obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
>  obj-$(CONFIG_CSKY_PMU_V1)		+= perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)		+= perf_callchain.o
> +obj-$(CONFIG_HAVE_PERF_REGS)            += perf_regs.o
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
> new file mode 100644
> index 0000000..88f1875
> --- /dev/null
> +++ b/arch/csky/kernel/perf_regs.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/perf_event.h>
> +#include <linux/bug.h>
> +#include <asm/perf_regs.h>
> +#include <asm/ptrace.h>
> +
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_CSKY_MAX))
> +		return 0;
> +
> +	return ((long *)regs)[idx];
Please use:
	return (u64)((u32 *)regs + idx);
> +}
> +
> +#define REG_RESERVED (~((1ULL << PERF_REG_CSKY_MAX) - 1))
> +
> +int perf_reg_validate(u64 mask)
> +{
> +	if (!mask || mask & REG_RESERVED)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +u64 perf_reg_abi(struct task_struct *task)
> +{
> +	return PERF_SAMPLE_REGS_ABI_32;
> +}
> +
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +			struct pt_regs *regs,
> +			struct pt_regs *regs_user_copy)
> +{
> +	regs_user->regs = task_pt_regs(current);
> +	regs_user->abi = perf_reg_abi(current);
> +}

Best Regards
 Guo Ren
