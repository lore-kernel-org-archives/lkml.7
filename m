Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A7C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED617206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJHWiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:38:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40260 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:38:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so86907pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7hYj82odng1jMSAaDEYDJcbFa/mw5vWpBNUQtKyLYSs=;
        b=U57100v7ZQ3zr/TzbwV56ESUze8Mk5WWyIrEhL/wfgCP/I8x0Og7EDv7OLHq2T+3Yr
         Ysv+BS/XzrZBRZrZBD2rP5tKXGW1sgDdKhW7TioSzjVy3N6s4PL8K9t4dTarSwl3UkPE
         5M/QIeKlcA+2TiLLVnK3DBR10lYipyxGEMWvZDgNdjGCL8PflHQvGqFH2UmfY4gKRg+v
         SK/DEgCjYMkLmBNlIvCJzO0iK0KG/z4aNUzg2xV7OK5j6qWFylBws38KVe5eO6n9pvH8
         DvNBI8SZ6TmImiDwwIAuTWWflnKt2KO2rfes5gkEcls1yRFAghIlCzViPgEDH6VWWLq2
         iZBA==
X-Gm-Message-State: APjAAAXiuxHQuwoFf2JZOnvBZdsPcVqQ6YZZtMiguWOiM7ZKzFOfPiEK
        DFhGkr7lUGFaN335ZhTctpOIPw==
X-Google-Smtp-Source: APXvYqzZwXk6wfpZldLYfQzDSJO+0eZyrrg5uBIg5ME1ljqHCxjVhktp3ndtoYX03SNqOWTWpz8FSw==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr272972pfa.223.1570574295986;
        Tue, 08 Oct 2019 15:38:15 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j24sm141233pff.71.2019.10.08.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:38:15 -0700 (PDT)
Date:   Tue, 08 Oct 2019 15:38:15 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 15:26:32 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix memblock reservation for device tree blob
In-Reply-To: <CAAhSdy3iTBeQcG0D=J7nYYudnDsEw6GN5FJ4fPCftUwvgGwjwg@mail.gmail.com>
CC:     aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     aou@eecs.berkeley.edu, anup@brainfault.org
Message-ID: <mhng-464b0376-8728-4ca9-a090-e785ffb2df14@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 21:34:57 PDT (-0700), anup@brainfault.org wrote:
> On Sat, Sep 21, 2019 at 6:30 AM Albert Ou <aou@eecs.berkeley.edu> wrote:
>>
>> This fixes an error with how the FDT blob is reserved in memblock.
>> An incorrect physical address calculation exposed the FDT header to
>> unintended corruption, which typically manifested with of_fdt_raw_init()
>> faulting during late boot after fdt_totalsize() returned a wrong value.
>> Systems with smaller physical memory sizes more frequently trigger this
>> issue, as the kernel is more likely to allocate from the DMA32 zone
>> where bbl places the DTB after the kernel image.
>>
>> Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
>> changed the mapping of the DTB to reside in the fixmap area.
>> Consequently, early_init_fdt_reserve_self() cannot be used anymore in
>> setup_bootmem() since it relies on __pa() to derive a physical address,
>> which does not work with dtb_early_va that is no longer a valid kernel
>> logical address.
>>
>> The reserved[0x1] region shows the effect of the pointer underflow
>> resulting from the __pa(initial_boot_params) offset subtraction:
>>
>> [    0.000000] MEMBLOCK configuration:
>> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
>> [    0.000000]  memory.cnt  = 0x1
>> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
>> [    0.000000]  reserved.cnt  = 0x2
>> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
>> [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0
>>
>> With the fix applied:
>>
>> [    0.000000] MEMBLOCK configuration:
>> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
>> [    0.000000]  memory.cnt  = 0x1
>> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
>> [    0.000000]  reserved.cnt  = 0x2
>> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
>> [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0
>
> Thanks for catching this issue.
>
> Most of us did not notice this issue most likely because:
> 1. We generally have good enough RAM on QEMU and SiFive Unleashed
> 2. Most of people use OpenSBI FW_JUMP on QEMU and U-Boot  on
>     SiFive Unleashed to boot in Linux which places FDT quite far away
>     from Linux kernel end
>
> Linux ARM64 kernel also uses FIXMAP to access FDT and over there
> as well early_init_fdt_reserve_self() is not used.
>
>>
>> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
>> Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
>> ---
>>  arch/riscv/mm/init.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index f0ba713..52d007c 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/swap.h>
>>  #include <linux/sizes.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/libfdt.h>
>>
>>  #include <asm/fixmap.h>
>>  #include <asm/tlbflush.h>
>> @@ -82,6 +83,8 @@ static void __init setup_initrd(void)
>>  }
>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>
>> +static phys_addr_t __dtb_pa __initdata;
>
> May be dtb_early_pa will be more consistent name
> instead of __dtb_pa because it matches dtb_early_va
> used below.
>
>> +
>>  void __init setup_bootmem(void)
>>  {
>>         struct memblock_region *reg;
>> @@ -117,7 +120,12 @@ void __init setup_bootmem(void)
>>         setup_initrd();
>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>
>> -       early_init_fdt_reserve_self();
>> +       /*
>> +        * Avoid using early_init_fdt_reserve_self() since __pa() does
>> +        * not work for DTB pointers that are fixmap addresses
>> +        */
>> +       memblock_reserve(__dtb_pa, fdt_totalsize(dtb_early_va));
>> +
>>         early_init_fdt_scan_reserved_mem();
>>         memblock_allow_resize();
>>         memblock_dump_all();
>> @@ -333,6 +341,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>>         "not use absolute addressing."
>>  #endif
>>
>> +
>
> Please remove this newline addition.
>
>>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>  {
>>         uintptr_t va, end_va;
>> @@ -393,6 +402,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>
>>         /* Save pointer to DTB for early FDT parsing */
>>         dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
>> +       /* Save physical address for memblock reservation */
>> +       __dtb_pa = dtb_pa;
>>  }
>>
>>  static void __init setup_vm_final(void)
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> This deserves to be stable kernel fix as well.
> You should add:
> Cc: stable@vger.kernel.org
> in your commit description.
>
> Apart from minor nits above.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> I tried this patch for both RV64 and RV32 on QEMU with
> Yocto rootfs.
>
> Tested-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup

Albert: Do you plan on spinning a v2 of the patch set?
