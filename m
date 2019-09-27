Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED727207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 23:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eecs-berkeley-edu.20150623.gappssmtp.com header.i=@eecs-berkeley-edu.20150623.gappssmtp.com header.b="JsqAIGyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfI0XOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 19:14:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36216 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0XOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 19:14:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14so4241695pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eecs-berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEwk+pfvJ/NxQE7TT/NJtc+kVH/rLevBvSCqqrAMyVE=;
        b=JsqAIGyLbB++dlViOxeZEZ0CAY7JyQFOukRDuHPKLwbtNbAmwGJmbnwkGGKpfgzpX3
         J6r72HB/CdzxXQwWgTJUH45KTh6KQ4Z0ZLfnScmVRC88cWhbBTjjKMqJXdAJ6vP+08Cs
         /nFClCIrJfjMG3amrzXy5LMk2MygAu4VFss1Ex/qplh++AaEyGXY7VV8S5UWgblnafdS
         3e5hvL33JMZfZfc2eiU1SrPcitjBEsMPIbRHj7Q2Nl9/t08IZI4OeFEReF0vGOm6LJGr
         S48kTQfoUcyt+1qAidVsY0xf51M4EF6nZ+toF4iZ8RtjUAyVGqfp5+GIIh3PBQAo2+CI
         GMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AEwk+pfvJ/NxQE7TT/NJtc+kVH/rLevBvSCqqrAMyVE=;
        b=ie0YH3LHz+nQctYt6fwe3UsYm16g/hcqBemEZVI1WrxYlYnsNVoHStUaPkUupbmZgh
         JvB1seqayIhsRSV84z5l0xtqF4PavCagJTwmQgSzgxNODuAT6aaeXjwS5AGrQjyTBGip
         5Un2JgEVt39gPlDkAjQ1H4hqTvNnMNeEAZB7NkkSZ1D5SYAhST7x9H7FWOUZEMi50AmW
         /Rt0Dv5RdwysijpLJ6el/5Y8FaWTfmX5yTkofIcoFbXJdZbmQKbgo3pOqOUbSdZOiSv6
         GSntR93ATP7h3Owav44YH+Spcw9Pnvjj0ByWsaj0NkmOJRit2+uj44t54yy9H9qMl/YC
         gmAA==
X-Gm-Message-State: APjAAAUvaS1+8wK2Cje2HXGQ7gvXQPx+x7GPSmV5Hd0isnftsSdprcgQ
        5r1xxlLpJWzjucie3gyx4V0o90Ub48U=
X-Google-Smtp-Source: APXvYqz9yLvhSzccmdirQ0d3XuCrrfRXNj0FSEkBIC3bBTSso3EbUy7y4kg8LSEtYklZzqQpMPfavg==
X-Received: by 2002:a17:90b:294:: with SMTP id az20mr13215491pjb.16.1569626059318;
        Fri, 27 Sep 2019 16:14:19 -0700 (PDT)
Received: from localhost (dhcp-35-38.EECS.Berkeley.EDU. [128.32.35.38])
        by smtp.gmail.com with ESMTPSA id o195sm5104208pfg.21.2019.09.27.16.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 16:14:18 -0700 (PDT)
From:   Albert Ou <aou@eecs.berkeley.edu>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Fix memblock reservation for device tree blob
Date:   Fri, 27 Sep 2019 16:14:18 -0700
Message-Id: <20190927231418.83100-1-aou@eecs.berkeley.edu>
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

Changes in v2:
* Changed variable identifier to dtb_early_pa per reviewer feedback.
* Removed whitespace change.

 arch/riscv/mm/init.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f0ba713..83f7d12 100644
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
 
+static phys_addr_t dtb_early_pa __initdata;
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
+	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
+
 	early_init_fdt_scan_reserved_mem();
 	memblock_allow_resize();
 	memblock_dump_all();
@@ -393,6 +401,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	/* Save pointer to DTB for early FDT parsing */
 	dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
+	/* Save physical address for memblock reservation */
+	dtb_early_pa = dtb_pa;
 }
 
 static void __init setup_vm_final(void)
-- 
2.7.4

