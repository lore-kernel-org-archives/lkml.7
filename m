Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29120C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eecs-berkeley-edu.20150623.gappssmtp.com header.i=@eecs-berkeley-edu.20150623.gappssmtp.com header.b="TWPxe23o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394112AbfIUBAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:00:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36072 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394077AbfIUBAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:00:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so5689383pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eecs-berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akrFEhXOEhjjNsFA2n/lMwPsnj11zAdFvp8IXUT8xe4=;
        b=TWPxe23oSrRfaWMw7X3pg1d8S7BsqmV/cTrGYIVKKy5TYTrmNuWtFFzhialiNBvIt8
         wO9LR4ked246/nnwkOvzHi4lcErObALKlZLBKByeG/4O02vWKT6nRi0/zuMA2Q/ZDzPA
         SefiLs0FA6an72vmJWbPKrFUP+oi8MAfrWC3WywJyoQqjExxzAE5ojSsQwpD3HylDKDJ
         WZsDeG5ZILOxFHJ0tyIcd/k2G9Qd1gOAG03dDmhvqGrN1R8QSuWvoUFtFnBLW6L8A9QH
         r1RSK2ihA5p2Bli+BHXBN8c3J/YrBaUJ2aC2CwNYtUh8eGJyESJ7SWMoVLjeAToRLFs4
         2aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akrFEhXOEhjjNsFA2n/lMwPsnj11zAdFvp8IXUT8xe4=;
        b=VKmi3yzIe7hCugN9eKaucxYBL+nNQuRhM7ArAqvwKxgG7Njr/zOZt30mGTBCojB76T
         PR0efTEJpolKSx/l4azABPTQ0/gj95XjRDBLDK1blDfaYYxBXc5IGeEVquVMIWAwRdqG
         /pOKrFKGiPT8Dea7QFuLbD1gYXU+pdlacXs3SE5G9ZifZdLU4BMH+8E9WKccD6hgpjBh
         zeHSoeWc6oyJIH+XMjB2OH8y2oVTR5LRbaMct+oUUoErMjruBlGwxPqQAIvoVwrJxH2K
         yBYeoLGN790FnQFlALCub6WVQDb95a+eh3Ctuxeb5cH4yfZpoF7nCaAQXxmNVS71vxTp
         c46g==
X-Gm-Message-State: APjAAAW7/qv/px4/R3Yl3/3P3wx0YiPt1mVL+ATNRFpPcC2fIE72av9N
        /69IjVAGYVH/cHi4Hcvns4NjOA==
X-Google-Smtp-Source: APXvYqxLMyNOzhaBhc+PHHGAxEu0KCiTcVlM8Gl9/Vmd7F5Uzgp3WIFFxFjlE0pDcnrU877C5qJXbA==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr20586708pfr.138.1569027604422;
        Fri, 20 Sep 2019 18:00:04 -0700 (PDT)
Received: from localhost (dhcp-35-38.EECS.Berkeley.EDU. [128.32.35.38])
        by smtp.gmail.com with ESMTPSA id d10sm3549344pfh.8.2019.09.20.18.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 18:00:03 -0700 (PDT)
From:   Albert Ou <aou@eecs.berkeley.edu>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix memblock reservation for device tree blob
Date:   Fri, 20 Sep 2019 18:00:02 -0700
Message-Id: <20190921010002.61006-1-aou@eecs.berkeley.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an error with how the FDT blob is reserved in memblock.
An incorrect physical address calculation exposed the FDT header to
unintended corruption, which typically manifested with of_fdt_raw_init()
faulting during late boot after fdt_totalsize() returned a wrong value.
Systems with smaller physical memory sizes more frequently trigger this
issue, as the kernel is more likely to allocate from the DMA32 zone
where bbl places the DTB after the kernel image.

Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
changed the mapping of the DTB to reside in the fixmap area.
Consequently, early_init_fdt_reserve_self() cannot be used anymore in
setup_bootmem() since it relies on __pa() to derive a physical address,
which does not work with dtb_early_va that is no longer a valid kernel
logical address.

The reserved[0x1] region shows the effect of the pointer underflow
resulting from the __pa(initial_boot_params) offset subtraction:

[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x2
[    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0

With the fix applied:

[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x2
[    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0

Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/riscv/mm/init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f0ba713..52d007c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -11,6 +11,7 @@
 #include <linux/swap.h>
 #include <linux/sizes.h>
 #include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
@@ -82,6 +83,8 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
+static phys_addr_t __dtb_pa __initdata;
+
 void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
@@ -117,7 +120,12 @@ void __init setup_bootmem(void)
 	setup_initrd();
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	early_init_fdt_reserve_self();
+	/*
+	 * Avoid using early_init_fdt_reserve_self() since __pa() does
+	 * not work for DTB pointers that are fixmap addresses
+	 */
+	memblock_reserve(__dtb_pa, fdt_totalsize(dtb_early_va));
+
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
 	memblock_dump_all();
@@ -333,6 +341,7 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 	"not use absolute addressing."
 #endif
 
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	uintptr_t va, end_va;
@@ -393,6 +402,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	/* Save pointer to DTB for early FDT parsing */
 	dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
+	/* Save physical address for memblock reservation */
+	__dtb_pa = dtb_pa;
 }
 
 static void __init setup_vm_final(void)
-- 
2.7.4

