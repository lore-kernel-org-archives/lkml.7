Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8173AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39268204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RTf2wd6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCAVN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:13:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38779 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCAVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:13:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so12008613pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4bFW9m9Wp9F/3YhzwZFQMAcq94j9d6Z9jR0lWAsiS3Y=;
        b=RTf2wd6cWhJOG4atIOS5lQyY80Fejk54DrX8iZdVMdGl1XJ3qdI8sD8svONZi6OYsQ
         gpwcsLuMT9JruBO3rdJ6bK4KeDl4VtCJyjFlOjJdsG58ENSzTuLm1WTegfBoHcsFLDSQ
         Og6xj66eRix+Fv3E+qUf7IRkg324P0Jjlg9ArmTktHKWln9p7TaRRrDwETHQ4Q6AAGfJ
         6F8/5rI+OkAc5yxtTA2EytJacH/IYhu6ZFgzr60NRHUVXzMA1VuI7C7NcYGtm3TrYJb0
         2i7s8mJWHvYPEL0OtkL2I+3E2hDM0b9OCnhE4eFK8AKa3dA/0ScDwOGc0du/gKuohXQl
         z0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4bFW9m9Wp9F/3YhzwZFQMAcq94j9d6Z9jR0lWAsiS3Y=;
        b=SCpE1K5Q+uBYd2y08Wt9zLI9AtGqSVT6SvAJoffiUEScm7r+340p/P/Sg8o71IsRwJ
         4kB1fcHU/4OxPdmDD77fX38DA8pyxdan/hBMrXoZnQGXQuLiNSQHQv87qvdBKtz42IEK
         ZzXCn40++JtfYXkUJnWknsdxnCE5BlGk/Bchhy9UoIWteSKAXAl0BpEh+g89S93quGjN
         Rfa6mm0ZFLjMc87QofzX+toEeUspoCQ2yvxpmV0IM+cIFt1ivScpk8qgMMTEfna377Fy
         nHGXV8mR2LeFPdID/BKtV3IzbVSAQiAnk9alRWP6GGexZxjojwxyhjb2Rf5tSN8QWfFz
         2njA==
X-Gm-Message-State: APjAAAWRJMFUD+pjnBvkkJ0hYr2+hHnjImhsbHWGsixdLvOpIwoH0AWh
        q7gleyc/Wr5SdtJy16tzjm5f74C4rjE=
X-Google-Smtp-Source: APXvYqzuwjTEIP9lx1RVEBI9SqScZnJOLyX4PoqU0XutIvetPlRCWzhrZE+dxgA2M0XU3xoG6sSEHg==
X-Received: by 2002:a63:d25:: with SMTP id c37mr6408378pgl.230.1551474807376;
        Fri, 01 Mar 2019 13:13:27 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d6sm12603998pfg.47.2019.03.01.13.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:13:26 -0800 (PST)
Date:   Fri, 01 Mar 2019 13:13:26 -0800 (PST)
X-Google-Original-Date: Fri, 01 Mar 2019 13:13:10 PST (-0800)
Subject:     Re: [PATCH 13/20] riscv/mmiowb: Hook up mmwiob() implementation to asm-generic code
In-Reply-To: <20190301140348.25175-14-will.deacon@arm.com>
CC:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, paulmck@linux.ibm.com,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        Arnd Bergmann <arnd@arndb.de>, peterz@infradead.org,
        andrea.parri@amarulasolutions.com,
        Daniel Lustig <dlustig@nvidia.com>, dhowells@redhat.com,
        stern@rowland.harvard.edu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, paul.burton@mips.com, mingo@kernel.org,
        ysato@users.sourceforge.jp, dalias@libc.org, tony.luck@intel.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Will Deacon <will.deacon@arm.com>
Message-ID: <mhng-df36e49b-33cc-4a0b-980a-d6e2bff34d21@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Mar 2019 06:03:41 PST (-0800), Will Deacon wrote:
> In a bid to kill off explicit mmiowb() usage in driver code, hook up
> the asm-generic mmiowb() tracking code for riscv, so that an mmiowb()
> is automatically issued from spin_unlock() if an I/O write was performed
> in the critical section.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 -
>  arch/riscv/include/asm/io.h     | 15 ++-------------
>  arch/riscv/include/asm/mmiowb.h | 14 ++++++++++++++
>  4 files changed, 17 insertions(+), 14 deletions(-)
>  create mode 100644 arch/riscv/include/asm/mmiowb.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3cc9687..08f4415203c5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -49,6 +49,7 @@ config RISCV
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_MMIOWB
>
>  config MMU
>  	def_bool y
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 221cd2ec78a4..cccd12cf27d4 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -21,7 +21,6 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += mmiowb.h
>  generic-y += mutex.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 1d9c1376dc64..744fd92e77bc 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -20,6 +20,7 @@
>  #define _ASM_RISCV_IO_H
>
>  #include <linux/types.h>
> +#include <asm/mmiowb.h>
>
>  extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
>
> @@ -100,18 +101,6 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #endif
>
>  /*
> - * FIXME: I'm flip-flopping on whether or not we should keep this or enforce
> - * the ordering with I/O on spinlocks like PowerPC does.  The worry is that
> - * drivers won't get this correct, but I also don't want to introduce a fence
> - * into the lock code that otherwise only uses AMOs (and is essentially defined
> - * by the ISA to be correct).   For now I'm leaving this here: "o,w" is
> - * sufficient to ensure that all writes to the device have completed before the
> - * write to the spinlock is allowed to commit.  I surmised this from reading
> - * "ACQUIRES VS I/O ACCESSES" in memory-barriers.txt.
> - */
> -#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
> -
> -/*
>   * Unordered I/O memory access primitives.  These are even more relaxed than
>   * the relaxed versions, as they don't even order accesses between successive
>   * operations to the I/O regions.
> @@ -165,7 +154,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #define __io_br()	do {} while (0)
>  #define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory");
>  #define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory");
> -#define __io_aw()	do {} while (0)
> +#define __io_aw()	mmiowb_set_pending()
>
>  #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
>  #define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
> diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
> new file mode 100644
> index 000000000000..5d7e3a2b4e3b
> --- /dev/null
> +++ b/arch/riscv/include/asm/mmiowb.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_RISCV_MMIOWB_H
> +#define _ASM_RISCV_MMIOWB_H
> +
> +/*
> + * "o,w" is sufficient to ensure that all writes to the device have completed
> + * before the write to the spinlock is allowed to commit.
> + */
> +#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
> +
> +#include <asm-generic/mmiowb.h>
> +
> +#endif	/* ASM_RISCV_MMIOWB_H */

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks for doing this, that comment was one of the more headache-incuding 
FIXMEs in our port.  I think it's better to keep __io_aw next to the others: 
even if it's the same as the generic implementation, it's easier to reason 
about this way.
