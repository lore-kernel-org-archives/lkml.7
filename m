Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 04:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CB620C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 04:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="yqJ3L9P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfIUEfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 00:35:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53006 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfIUEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 00:35:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id x2so4433876wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pGKiDGF7pcSXfE/kXL5zm3CUq0K5jLTeFExSKLR0vc0=;
        b=yqJ3L9P0c2mDdv0+ntW2WM0jo5HFKquFuU36IwxqO8xkVoiET+QUZ9DAmfBIPONPxZ
         Zy7dSSNhnzJeRAuplQwrb7c5am6JBUou1wSYba8U6qoeMZEgqaduhJpGxLUAOcDtHsHS
         by7/5mjC1/ioJHGEPU2PplfjqD9t1TawkOZeLxG8oFL0EGdNh1OD4FDoboE4542o16bx
         DBw6St20spsXZ1Eiw2m3nWIi/NTDLsNAUe0e+qn0XQxImOHhLhVsFxaVhK8A6i/Lft6F
         +osnK/bjjn8LSs4xb6Jxu3XxBPXob9XLMZPc0kc2Oz8oJtJwxmMAVqYu0+UgqSXp5UWj
         h/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pGKiDGF7pcSXfE/kXL5zm3CUq0K5jLTeFExSKLR0vc0=;
        b=AKWD/UVGQap08EjeNGB518UUR94PZvR8oHz+E/oP30Mkazch5KlHG9HSDSYP14q/Le
         ra9UhL44SUWYifXwMI+nysu59f3AHHU4G1IZIEM5CgJ/bNyjsm3GwDTOF4d1TarQhL4s
         c0rsxDlkW+tuD/pcHjSkGvr0oF00ylF1KY4pwsvBoVqidFIy6OA1Y651xvaB2bnMiV2c
         aFkRLaQHy7Uw6VY/MGz5iRkzoiYIsYXA0Kjn4jEfx8G1WJLeJRGqB1f3YLbPUIHyO8Nl
         MfCren7E/H4PDT4PyJ+lZahtQF48nGlrUwSXA0DLekOzaAktGB46Aspz3vzPEISgN1/L
         RwEQ==
X-Gm-Message-State: APjAAAWFfc1vvXEos87wFUWLfZwZ78ZW+VKryamJvHG75NUwxoMDAvNh
        Tfv1mSK80/Tn7yHa2s/UnSDNV7tD8R2O4Ix09ic/Aw==
X-Google-Smtp-Source: APXvYqwZD5IWYiY39/ejS1DIfSMyd7f1VHWu0q0kwqBJZrxWeQyC+5jzlEApT/9Nt2UxRbi8CQZihLGKPqlM4A+5p/M=
X-Received: by 2002:a1c:80ca:: with SMTP id b193mr5263971wmd.171.1569040509087;
 Fri, 20 Sep 2019 21:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190921010002.61006-1-aou@eecs.berkeley.edu>
In-Reply-To: <20190921010002.61006-1-aou@eecs.berkeley.edu>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 21 Sep 2019 10:04:57 +0530
Message-ID: <CAAhSdy3iTBeQcG0D=J7nYYudnDsEw6GN5FJ4fPCftUwvgGwjwg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix memblock reservation for device tree blob
To:     Albert Ou <aou@eecs.berkeley.edu>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 6:30 AM Albert Ou <aou@eecs.berkeley.edu> wrote:
>
> This fixes an error with how the FDT blob is reserved in memblock.
> An incorrect physical address calculation exposed the FDT header to
> unintended corruption, which typically manifested with of_fdt_raw_init()
> faulting during late boot after fdt_totalsize() returned a wrong value.
> Systems with smaller physical memory sizes more frequently trigger this
> issue, as the kernel is more likely to allocate from the DMA32 zone
> where bbl places the DTB after the kernel image.
>
> Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> changed the mapping of the DTB to reside in the fixmap area.
> Consequently, early_init_fdt_reserve_self() cannot be used anymore in
> setup_bootmem() since it relies on __pa() to derive a physical address,
> which does not work with dtb_early_va that is no longer a valid kernel
> logical address.
>
> The reserved[0x1] region shows the effect of the pointer underflow
> resulting from the __pa(initial_boot_params) offset subtraction:
>
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0
>
> With the fix applied:
>
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0

Thanks for catching this issue.

Most of us did not notice this issue most likely because:
1. We generally have good enough RAM on QEMU and SiFive Unleashed
2. Most of people use OpenSBI FW_JUMP on QEMU and U-Boot  on
    SiFive Unleashed to boot in Linux which places FDT quite far away
    from Linux kernel end

Linux ARM64 kernel also uses FIXMAP to access FDT and over there
as well early_init_fdt_reserve_self() is not used.

>
> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/mm/init.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f0ba713..52d007c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -11,6 +11,7 @@
>  #include <linux/swap.h>
>  #include <linux/sizes.h>
>  #include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> @@ -82,6 +83,8 @@ static void __init setup_initrd(void)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> +static phys_addr_t __dtb_pa __initdata;

May be dtb_early_pa will be more consistent name
instead of __dtb_pa because it matches dtb_early_va
used below.

> +
>  void __init setup_bootmem(void)
>  {
>         struct memblock_region *reg;
> @@ -117,7 +120,12 @@ void __init setup_bootmem(void)
>         setup_initrd();
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> -       early_init_fdt_reserve_self();
> +       /*
> +        * Avoid using early_init_fdt_reserve_self() since __pa() does
> +        * not work for DTB pointers that are fixmap addresses
> +        */
> +       memblock_reserve(__dtb_pa, fdt_totalsize(dtb_early_va));
> +
>         early_init_fdt_scan_reserved_mem();
>         memblock_allow_resize();
>         memblock_dump_all();
> @@ -333,6 +341,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>         "not use absolute addressing."
>  #endif
>
> +

Please remove this newline addition.

>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
>         uintptr_t va, end_va;
> @@ -393,6 +402,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>         /* Save pointer to DTB for early FDT parsing */
>         dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
> +       /* Save physical address for memblock reservation */
> +       __dtb_pa = dtb_pa;
>  }
>
>  static void __init setup_vm_final(void)
> --
> 2.7.4
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

This deserves to be stable kernel fix as well.
You should add:
Cc: stable@vger.kernel.org
in your commit description.

Apart from minor nits above.

Reviewed-by: Anup Patel <anup@brainfault.org>

I tried this patch for both RV64 and RV32 on QEMU with
Yocto rootfs.

Tested-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
