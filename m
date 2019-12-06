Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0EC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8482064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6PAfNiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLFQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:57:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46539 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfLFQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:57:33 -0500
Received: by mail-qv1-f68.google.com with SMTP id t9so123818qvh.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aMaYQ6yXmhlltBmW/p8k1pc2abuhRB+m4YdSEAS0CnE=;
        b=p6PAfNiUak7ezH//qp3sezHJUuSE04xW8l/oktB2V6F+m4FvO5mpbkRQJFyMICskz2
         bQpKsFPmk0PQWscJXcwDDe/BxwwIEFt51ZmZteFVbxuLZ/Lc8ZUwocnABvAYq20DyZVe
         2htXekEf5XfSZC9XPFK3KYk4sJLHq76PPlMv3f3u3XPB4+AVH9MGxZvhxw0dqolVhaSi
         P0ON2snbBgYZz1HNhNdM0hWTXHGFW9OqIOA1+v/uwBM4/denoHF7TbbQtmpHUT4adViB
         LVJyxVgLq1vYpV3ivqfJjFcaJXUfuwO/CkxFo2e2A0IaEofz1UilSnuaEi3wvQ7mu1xo
         rJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aMaYQ6yXmhlltBmW/p8k1pc2abuhRB+m4YdSEAS0CnE=;
        b=tHEVa/odgrk7CLcmrLm+LH6tD6djxnFkD90phmP6a41fDw1I3A6G+30kz335JgR+rI
         fvTlWfHyRHxLBZQBmDwD54WhrQIoeQBzhq0ULVkl4vSRksQJSeG/ZjTV8Bsqc2ErXesb
         tMvOaJlG4SjCdEAgFJSourRjKve48bLQIbxje+9awygFr0XAllDgVjxNNbgJc1GPhyh9
         qZ6RrWCFQ5fORAFFmtddW+VjyAFq56jh8EgQ+Py2tVGh+Iub9h2J3bAWZsLq/4Bzh0j+
         mmp67zHshtEZES91eVJEEzdBuHFl6GrQXu/FZMVQHHq6D0/D27jCh8L/zovsriGMlZBo
         eV2A==
X-Gm-Message-State: APjAAAWJSld4DmfVdkK4xPgfzRRkixSvaPJoDqK2PrdUXOmnzStvOz89
        q2/Nglu23et92+LlRpHqgQ==
X-Google-Smtp-Source: APXvYqzDTlRIBtXmba9zNnBpyf7Smp+j9Jpczysqc86hgwsDCyW5TtIvmz46cinfhZcaZcpTfey1EQ==
X-Received: by 2002:a05:6214:4e:: with SMTP id c14mr7735020qvr.112.1575651451783;
        Fri, 06 Dec 2019 08:57:31 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y28sm6531373qtk.65.2019.12.06.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:57:31 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] x86/mm/KASLR: Adjust the padding size for the direct mapping.
Date:   Fri,  6 Dec 2019 11:57:07 -0500
Message-Id: <20191206165707.20806-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206165707.20806-1-msys.mizuma@gmail.com>
References: <20191206165707.20806-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

The system sometimes crashes while memory hot-adding on KASLR
enabled system. The crash happens because the regions pointed by
kaslr_regions[].base are overwritten by the hot-added memory.

It happens because of the padding size for kaslr_regions[].base isn't
enough for the system whose physical memory layout has huge space for
memory hotplug. kaslr_regions[].base points "actual installed
memory size + padding" or higher address. So, if the "actual + padding"
is lower address than the maximum memory address, which means the memory
address reachable by memory hot-add, kaslr_regions[].base is destroyed by
the overwritten.

  address
    ^
    |------- maximum memory address (Hotplug)
    |                                    ^
    |------- kaslr_regions[0].base       | Hotadd-able region
    |     ^                              |
    |     | padding                      |
    |     V                              V
    |------- actual memory address (Installed on boot)
    |

Fix it by getting the maximum memory address from SRAT and store
the value in boot_param, then set the padding size while KASLR
initializing if the default padding size isn't enough.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/mm/kaslr.c | 63 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc6182eecefa..b3f2f468d20f 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,15 +70,58 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+/*
+ * Even though a huge virtual address space is reserved for the direct
+ * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
+ * rare system can own enough physical memory to use it up, most are
+ * even less than 1TB. So with KASLR enabled, we adapt the size of
+ * direct mapping area to the size of actual physical memory plus the
+ * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+ * The left part will be taken out to join memory randomization.
+ *
+ * And in case CONFIG_MEMORY_HOTPLUG is enabled and boot_params.max_addr
+ * has a physical memory address, that means the system memory can be
+ * expanded by memory hot-add to boot_params.max_addr. Set the size
+ * of direct mapping area to boot_params.max_addr so that we can avoid
+ * overwriting the hot-added memory.
+ */
+static inline unsigned long calc_direct_mapping_size(void)
+{
+	unsigned long size_tb, memory_tb;
+
+	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
+		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+	if (boot_params.max_addr) {
+		unsigned long maximum_tb;
+
+		maximum_tb = DIV_ROUND_UP(boot_params.max_addr,
+				1UL << TB_SHIFT);
+
+		if (maximum_tb > memory_tb)
+			memory_tb = maximum_tb;
+	}
+#endif
+	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
+
+	/*
+	 * Adapt physical memory region size based on available memory
+	 */
+	if (memory_tb < size_tb)
+		size_tb = memory_tb;
+
+	return size_tb;
+}
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
-	size_t i;
-	unsigned long vaddr_start, vaddr;
-	unsigned long rand, memory_tb;
-	struct rnd_state rand_state;
+	unsigned long vaddr_start, vaddr, rand;
 	unsigned long remain_entropy;
 	unsigned long vmemmap_size;
+	struct rnd_state rand_state;
+	size_t i;
 
 	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
 	vaddr = vaddr_start;
@@ -95,20 +138,10 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
-	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
+	kaslr_regions[0].size_tb = calc_direct_mapping_size();
 	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
 
-	/*
-	 * Update Physical memory mapping to available and
-	 * add padding if needed (especially for memory hotplug support).
-	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
-	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
-
-	/* Adapt phyiscal memory region size based on available memory */
-	if (memory_tb < kaslr_regions[0].size_tb)
-		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
 	 * Calculate the vmemmap region size in TBs, aligned to a TB
-- 
2.20.1

