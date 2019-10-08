Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF86A2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570515931;
	bh=zJkpWuMGl8S4ztCFw3iWc1o2rm0Di7Ixo5O3uqc2NVA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uzYKABjkMpLzDz/rHauLWo+sRghiX28wmfh/8HPjYaSuCqy6tRix/xjBuTqAOhLqu
	 nSqc21ZUu9B+3pA5xecr+HxrioG9FrWegfM2qAC2MHEbOZDprc1QKl7vPzf28eQg4F
	 RNHwYBrsdVlfNXwsH/brQK0SCJDEYuHg1vvWBoug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfJHGZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbfJHGZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:25:31 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD87E2067B;
        Tue,  8 Oct 2019 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570515930;
        bh=zJkpWuMGl8S4ztCFw3iWc1o2rm0Di7Ixo5O3uqc2NVA=;
        h=From:To:Cc:Subject:Date:From;
        b=PxwmnAnT1t4e0ZE2ahxOoqYkeoUuNKh3vbfiLWqrt49cvptSfr3qHI1aieAWmXpxI
         qp7ghVKBq/6z6BmoOudk4zcvnaJiRk5uzizuULGJgmCm6AQcT4K13fq5nhx2eH9Eds
         w15F7bGfMuIWoA1LnKFxCRqD2RIe9o/qIDYqPlD0=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, arunks@codeaurora.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Add setup_initrd check code
Date:   Tue,  8 Oct 2019 14:25:13 +0800
Message-Id: <1570515913-26251-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

We should give some necessary check for initrd just like other
architectures and it seems that setup_initrd() could be a common
code for all architectures.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/setup.c |  3 ---
 arch/csky/mm/init.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 23ee604..a00f8a0 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -47,9 +47,6 @@ static void __init csky_memblock_init(void)
 	signed long size;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
-#ifdef CONFIG_BLK_DEV_INITRD
-	memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
-#endif
 
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index d4c2292..48f791d 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -35,6 +35,45 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	unsigned long size;
+
+	if (initrd_start >= initrd_end) {
+		pr_err("initrd not found or empty");
+		goto disable;
+	}
+
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	size = initrd_end - initrd_start;
+
+	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
+		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
+		       __pa(initrd_start), size);
+		goto disable;
+	}
+
+	memblock_reserve(__pa(initrd_start), size);
+
+	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
+		(void *)(initrd_start), size);
+
+	initrd_below_start_ok = 1;
+
+	return;
+
+disable:
+	initrd_start = initrd_end = 0;
+
+	pr_err(" - disabling initrd\n");
+}
+#endif
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -57,6 +96,11 @@ void __init mem_init(void)
 			free_highmem_page(page);
 	}
 #endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif
+
 	mem_init_print_info(NULL);
 }
 
-- 
2.7.4

