Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA192CA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DE921897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDB1kg43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfKBBJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:09:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33330 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfKBBJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:09:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id y39so15445214qty.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W5sNrdhiY3O5YYJhRQb5TRq57Oo8Jq+55/eLniEqMBQ=;
        b=ZDB1kg43+dKwom7WAecgNxFKtGLfXNTd1CyYBRQGoOJ8+fsR/IYys5Tq7I6Gl/ogiF
         h3MYLbJ9WH+kRnocMoZKyZ2k6avOA6GhCyDsEEghlbMxhWAw/349LHDwqCFDVLEBt9Yn
         k3rITQ9DW7QR4/MbOqi1EWU0+BGvBI3Chj/9RoOKQvaODXlfJqy1OOEXticCSHTMDZuB
         +a263L35R1n+0gVuNIrgHjvyYh7qiSSKmD6LQZPDcsCWgK7lg64f62QwLIaQkv/ZaLHt
         AW9YViz54ayOnzvsDL0x/ECStP0ERzZF/xaPs4tpTxyKzXdjL/QP04mAQhIFnwwKlsns
         f7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W5sNrdhiY3O5YYJhRQb5TRq57Oo8Jq+55/eLniEqMBQ=;
        b=Ki9jrGcJbrEOEFW70dILPU5iK1LNfVaFiNscH/MHtuY2fv3iyD8R++IXxBjXE18YCW
         C1M1f+BMd6z0wKodGWJM5JSZ8NvTmkgBJhbVGbNmaJ9aJNMnUxd1PT0/dkCUqazqd/oX
         X2NuSR2zusCy+ffTCKfSwDeqLfrhLkDf5kvXeB0RRIMcqAojnnq+OE8TwMpEXBlfZe51
         Js0+p6D8Ej2mewzyrGWWsNcYZlg/vHZFtuSJAok380y+kCZKaqYnNDq6534w46nTdmkT
         y8kbcUrUQiLMYcXXpOMe2P5/Gp78Pvgmj2sOrKjmQGjw/oGVMOwUtB2OvkuaMqXNFXED
         GMEg==
X-Gm-Message-State: APjAAAXk6WheTt7yVlGl1+YwZv9vJCsM1PGTGnKr5TTWx6YQiDcvlL4h
        /lQoOP1ldbLZJL/UrYuPcw==
X-Google-Smtp-Source: APXvYqyyUymWycAQ8W2GjbxoA3l3Y+Z09L3lBVQj2A3XBqzwbO0x27zkWM4AeV6yafqKRwYENC7sxA==
X-Received: by 2002:ac8:219d:: with SMTP id 29mr2512741qty.280.1572656975901;
        Fri, 01 Nov 2019 18:09:35 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i66sm4234340qkb.105.2019.11.01.18.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 18:09:35 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] x86/mm/KASLR: Adjust the padding size for the direct  mapping.
Date:   Fri,  1 Nov 2019 21:09:11 -0400
Message-Id: <20191102010911.21460-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191102010911.21460-1-msys.mizuma@gmail.com>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
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
 arch/x86/mm/kaslr.c | 65 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc6182eec..a80eed563 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,15 +70,60 @@ static inline bool kaslr_memory_enabled(void)
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
+	unsigned long padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+	unsigned long size_tb, memory_tb;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unsigned long actual, maximum, base;
+
+	if (boot_params.max_addr) {
+		/*
+		 * The padding size should set to get for kaslr_regions[].base
+		 * bigger address than the maximum memory address the system can
+		 * have. kaslr_regions[].base points "actual size + padding" or
+		 * higher address. If "actual size + padding" points the lower
+		 * address than the maximum memory size, fix the padding size.
+		 */
+		actual = roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
+		maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
+		base = actual + (padding << TB_SHIFT);
+
+		if (maximum > base)
+			padding = (maximum - actual) >> TB_SHIFT;
+	}
+#endif
+	memory_tb =  DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
+			padding;
+
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
@@ -95,20 +140,10 @@ void __init kernel_randomize_memory(void)
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

