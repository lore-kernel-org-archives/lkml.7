Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81E20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ3k97Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKOOuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:50:22 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34128 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfKOOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:50:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so11075798qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQCIqL5y28pGcNIFaNUGqzaYgtdMvLUzkvVu9y+m5BE=;
        b=DQ3k97TyXzeDy11z4/P/HF3S0AFe8inV8wtl2V5PDTv105+4INXCmpMK68riz+KwOF
         47fQGSq+essXFPCkg0p0SBpf+I8u9N6aOgX76JzDmi0Qft+nTDwxth9c4sSXuqmBo6/8
         LaM2Gmz+9CbsQzzDXCBPvSwfuNe1NoCOpitBQ+ztK2P/VOoVkiwlIDR2DnAwNpTepPk5
         mQxuerdyCimRZGhjch0eD9+Q64MjRhJ88qMqJ8jxNqseaKIcnoByHw15XhHCu+F6fye6
         DwFy2z5n4YrfaorRn4W7PQhN0yxSeiPzscmUItpoo1WidyyapC1eDl9FHCnFqhVbxC4F
         bb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YQCIqL5y28pGcNIFaNUGqzaYgtdMvLUzkvVu9y+m5BE=;
        b=XF/L0tETimFinqbonMSSM6/96bWML4C+Fwmu7sugDOFDmu7ol0a++v/WWc6VYMFoig
         AzRKHpaAm8DdJiVn+VbV/jPJ1EnpiVszDkvsv7OC1rV6Clin4HkPiFnKDO1+e2h6RhgK
         yslXpCl8gB6CA59bm1/LyXGZ9SvEoT/tRnF4NB6coJaKBeOJL5+JTEe7QLiWdCgHrVR3
         CdUjJxIbPmpLhhANlNiW9q5sW97X9j5hY8wvlzemTqYrTIl9RzWkSy76fk3Q4ohhW0lf
         TVQmZlpHGNMcLQnL4ShnLiK6CVyYovatiU3NYgTJ3+V2y4zg1McxRvU7cmWz/xFSmxsy
         Z0Og==
X-Gm-Message-State: APjAAAVS0FaYAP0bKw7NHagITc94XF3nu7l3xZEsDLxclDOAEVEb5Y+P
        A5zklGWNHgQxzLnwPu9GVA==
X-Google-Smtp-Source: APXvYqxVjhQYrmKp7KrC8+DiBT0Vbq5P6YPJjnx5ZlfTRIYCn/K/vEnfbqXS4tKkFcixz6X8V8HOsg==
X-Received: by 2002:ac8:76d6:: with SMTP id q22mr4400229qtr.8.1573829418742;
        Fri, 15 Nov 2019 06:50:18 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l124sm4329317qkf.122.2019.11.15.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:50:18 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] x86/mm/KASLR: Adjust the padding size for the direct mapping.
Date:   Fri, 15 Nov 2019 09:49:17 -0500
Message-Id: <20191115144917.28469-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115144917.28469-1-msys.mizuma@gmail.com>
References: <20191115144917.28469-1-msys.mizuma@gmail.com>
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

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/mm/kaslr.c | 57 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc6182eecefa..1f0aa9e68226 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,15 +70,52 @@ static inline bool kaslr_memory_enabled(void)
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
@@ -95,20 +132,10 @@ void __init kernel_randomize_memory(void)
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

