Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D252083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfCYF0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:26:40 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:29535 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726242AbfCYF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:26:40 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x2P5PPRR037015;
        Mon, 25 Mar 2019 13:25:25 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 25 Mar 2019
 13:25:49 +0800
Date:   Mon, 25 Mar 2019 13:25:50 +0800
From:   Alan Kao <alankao@andestech.com>
To:     Anup Patel <Anup.Patel@wdc.com>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] RISC-V: Always compile mm/init.c with cmodel=medany
Message-ID: <20190325052550.GA30996@andestech.com>
References: <20190325033648.16171-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190325033648.16171-1-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x2P5PPRR037015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

Sorry for being late to the party.  I think one more thing should
move together with setup_vm():

On Mon, Mar 25, 2019 at 03:37:38AM +0000, Anup Patel wrote:
> The Linux RISC-V 32bit kernel is broken after we moved setup_vm() from
> kernel/setup.c to mm/init.c because Linux RISC-V 32bit kernel by default
> uses cmodel=medlow which results in a non-position-independent setup_vm().
> 
> This patch fixes Linux RISC-V 32bit kernel booting by:
> 1. Forcing cmodel=medany for mm/init.c
> 2. Moving remaing MM-related stuff va_pa_offset, pfn_base and
>    empty_zero_page from kernel/setup.c to mm/init.c
> 
> Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> v2: Removed CFLAGS_setup.o from kernel/Makefile and replaced SoBs
> ---
>  arch/riscv/kernel/Makefile | 2 --
>  arch/riscv/kernel/setup.c  | 8 --------
>  arch/riscv/mm/Makefile     | 2 ++
>  arch/riscv/mm/init.c       | 9 +++++++++
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f13f7f276639..8b9780b6bd7f 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile

earlier in this file, there are four lines about ftrace,

  5 ifdef CONFIG_FTRACE
  6 CFLAGS_REMOVE_ftrace.o = -pg
  7 CFLAGS_REMOVE_setup.o = -pg
  8 endif

removing "-pg" flag from setup.o was necessary for ftrace to work, since
setup_vm() cannot process the trampoline of ftrace properly.

As setup_vm() is being moved to mm/init.c, you may either mark it with a
"notrace" attribute with its declaration, or adding corresponding CFLAGS_REMOVE*
to mm/Makefile.

> @@ -29,8 +29,6 @@ obj-y	+= vdso.o
>  obj-y	+= cacheinfo.o
>  obj-y	+= vdso/
>  
> -CFLAGS_setup.o := -mcmodel=medany
> -
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_SMP)		+= smpboot.o
>  obj-$(CONFIG_SMP)		+= smp.o
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ecb654f6a79e..540a331d1376 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -48,14 +48,6 @@ struct screen_info screen_info = {
>  };
>  #endif
>  
> -unsigned long va_pa_offset;
> -EXPORT_SYMBOL(va_pa_offset);
> -unsigned long pfn_base;
> -EXPORT_SYMBOL(pfn_base);
> -
> -unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
> -EXPORT_SYMBOL(empty_zero_page);
> -
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index eb22ab49b3e0..7307609d405b 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -3,3 +3,5 @@ obj-y += fault.o
>  obj-y += extable.o
>  obj-y += ioremap.o
>  obj-y += cacheflush.o
> +
> +CFLAGS_init.o := -mcmodel=medany
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b379a75ac6a6..7a7c454378cb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -25,6 +25,10 @@
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
>  
> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
> +							__page_aligned_bss;
> +EXPORT_SYMBOL(empty_zero_page);
> +
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -143,6 +147,11 @@ void __init setup_bootmem(void)
>  	}
>  }
>  
> +unsigned long va_pa_offset;
> +EXPORT_SYMBOL(va_pa_offset);
> +unsigned long pfn_base;
> +EXPORT_SYMBOL(pfn_base);
> +
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Alan
