Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC7CC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD22206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jftEa6nU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfDYVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:11:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46758 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbfDYVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:11:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id o7so386498pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=roGj97wYSWSHB0+5VEsFkCFkqjjsXMUkRSvmPsovwsw=;
        b=jftEa6nUXu1Zi+JZ9W54SQIZqATa/5C2tQK2rCmQDT2PvzbvZ8h+nYF4dkzvfJKqpv
         NX3lAcogLz+EiFwib+PjIsld0zQVOEGU2n4eJ3la7cgw/LqMbDaJEKcNl23CF0LxykEi
         Vay3uqG1EAGMUB72KKLk89J7U7f6rEf2ISZUeKm/Tf33JKPTK+R6oiMgxviCPeoXYd8t
         Zkpb8ATK+6haFxbWElk6UG3yOR6H9+D2taBkPoggkMzLhqJcd/kmcqxnNKKvkerBCmH/
         QJA2V7fHhs/SA94m7En55Fhg9LmP2oDC2nntLcO8xl9HhJJdj2Pf4Q6Lrf+6709n20It
         eBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=roGj97wYSWSHB0+5VEsFkCFkqjjsXMUkRSvmPsovwsw=;
        b=r1L9R90iFBMQDgqHDaXdIuaD/JuEtJXI0lanywBRE0aa72M5nPLKPZwXYgwlAYZxkK
         zay9gTLu7mSDoxb1K9z8uPC8pbX+mKbrMYNLfGVtbGVNpS9pQ4JR1mm4CjQSYGPd4uqv
         SdyxX78Kh7ARsmzVon+eHzUuP208uVKR1ywhFhA1yLpD4j++xGrEZxYpOu/2I8Kudb8T
         Mhb1z31WWsF9lBT/bxL3CO0FvTsrv7IdWT1sIrmfzT9yMJfFkgQZe8NksKrXz24syWxz
         F/Q2ahWNl8Rnu2HMEpxxCfkvTNHL6G98XlgqQiUYyvbRI1vKHa3RffPMmIa964zOqqyJ
         5GHA==
X-Gm-Message-State: APjAAAV3EkIykLvaFxxiwoR1y8mWMCI19phB0e/xta4EaWoqCTNmKXyN
        OdUSORgtGY+seKwH1WOTpZzzkl3BIOo=
X-Google-Smtp-Source: APXvYqwvi5rAeBC3P9WCOL/QJp5wvQDZwxJdiloeHLUHjFEIxwAz0wbX3f6xs6+BBhyd8uOA5Cvizw==
X-Received: by 2002:a17:902:e285:: with SMTP id cf5mr5040257plb.77.1556226663261;
        Thu, 25 Apr 2019 14:11:03 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id 8sm38199508pfs.50.2019.04.25.14.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:11:02 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:11:02 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 14:08:42 PDT (-0700)
Subject:     Re: [PATCH 2/3] riscv: Add support for perf registers sampling
In-Reply-To: <69322515ac3fcba8af004039f44473cec5ecbdcc.1554961908.git.han_mao@c-sky.com>
CC:     linux-kernel@vger.kernel.org, han_mao@c-sky.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     han_mao@c-sky.com
Message-ID: <mhng-0787435f-0b2c-4ab4-ad73-0b68a815e613@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 00:53:49 PDT (-0700), han_mao@c-sky.com wrote:
> This patch implements the perf registers sampling and validation API
> for riscv arch. The valid registers and their register ID are defined in
> perf_regs.h. Perf tool can backtrace in userspace with unwind library
> and the registers/user stack dump support.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
>
> CC: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/Kconfig                      |  2 ++
>  arch/riscv/include/uapi/asm/perf_regs.h | 42 +++++++++++++++++++++++++++++++
>  arch/riscv/kernel/Makefile              |  1 +
>  arch/riscv/kernel/perf_regs.c           | 44 +++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+)
>  create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/riscv/kernel/perf_regs.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index eb56c82..effd157 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -33,6 +33,8 @@ config RISCV
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
>  	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_REGS
> +	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IRQ_DOMAIN
>  	select RISCV_ISA_A if SMP
> diff --git a/arch/riscv/include/uapi/asm/perf_regs.h b/arch/riscv/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..ce48987
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#ifndef _ASM_RISCV_PERF_REGS_H
> +#define _ASM_RISCV_PERF_REGS_H
> +
> +enum perf_event_riscv_regs {
> +	PERF_REG_RISCV_PC,
> +	PERF_REG_RISCV_RA,
> +	PERF_REG_RISCV_SP,
> +	PERF_REG_RISCV_GP,
> +	PERF_REG_RISCV_TP,
> +	PERF_REG_RISCV_T0,
> +	PERF_REG_RISCV_T1,
> +	PERF_REG_RISCV_T2,
> +	PERF_REG_RISCV_S0,
> +	PERF_REG_RISCV_S1,
> +	PERF_REG_RISCV_A0,
> +	PERF_REG_RISCV_A1,
> +	PERF_REG_RISCV_A2,
> +	PERF_REG_RISCV_A3,
> +	PERF_REG_RISCV_A4,
> +	PERF_REG_RISCV_A5,
> +	PERF_REG_RISCV_A6,
> +	PERF_REG_RISCV_A7,
> +	PERF_REG_RISCV_S2,
> +	PERF_REG_RISCV_S3,
> +	PERF_REG_RISCV_S4,
> +	PERF_REG_RISCV_S5,
> +	PERF_REG_RISCV_S6,
> +	PERF_REG_RISCV_S7,
> +	PERF_REG_RISCV_S8,
> +	PERF_REG_RISCV_S9,
> +	PERF_REG_RISCV_S10,
> +	PERF_REG_RISCV_S11,
> +	PERF_REG_RISCV_T3,
> +	PERF_REG_RISCV_T4,
> +	PERF_REG_RISCV_T5,
> +	PERF_REG_RISCV_T6,
> +	PERF_REG_RISCV_MAX,
> +};

Is it expected this eventually supports floating-point and vector registers?
If so, how do we make this extensible?

> +#endif /* _ASM_RISCV_PERF_REGS_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index dd2ba44..024badc 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -39,5 +39,6 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
> +obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
>
>  clean:
> diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
> new file mode 100644
> index 0000000..03d7ac3
> --- /dev/null
> +++ b/arch/riscv/kernel/perf_regs.c
> @@ -0,0 +1,44 @@
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
> +	if (WARN_ON_ONCE((u32)idx >= PERF_REG_RISCV_MAX))
> +		return 0;
> +
> +	return ((long *)regs)[idx];
> +}
> +
> +#define REG_RESERVED (~((1ULL << PERF_REG_RISCV_MAX) - 1))
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
> +#if __riscv_xlen == 64
> +	return PERF_SAMPLE_REGS_ABI_64;
> +#else
> +	return PERF_SAMPLE_REGS_ABI_32;
> +#endif
> +}
> +
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +			struct pt_regs *regs,
> +			struct pt_regs *regs_user_copy)
> +{
> +	regs_user->regs = task_pt_regs(current);
> +	regs_user->abi = perf_reg_abi(current);
> +}
