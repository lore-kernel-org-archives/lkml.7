Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B18C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D32342E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHXoLyNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH3VsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:48:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45960 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfH3VsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:48:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id r15so3594564qtn.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w/5foUOWsGiIALhc9FkX1i52x/QwOcQXv5vExOoBOQ=;
        b=uHXoLyNPT7g+1xR6937SaYsBmR7HeBZDJ89JU2W4k2H/qnX8OkvNHYZgN9lq8JNRIb
         MoNfjR4nzlVMgyCqp2ClBfhU16UUhKZKFNQEW1yGnpA++xAWBZrBiwtX1w2HNfcM+rgM
         xKu6O4AP2AV0rzPzWOJfTwzYVBcVdiJ4UfpXeGw3RqjBFegxYjql8Swlr4fRUG486CcI
         wRq/v59BYWvutChVlIr1wjptEOAQkAp6da6UVV3ne7yw2FfLwMkCifDL4Rx6mApBaK68
         df/oDRTW7F2ALlUq55UiIDKMSfF6Cjr91mst4WkKcgDHgl+sHp1VaxAwrMmmyJYDpmBA
         Rgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w/5foUOWsGiIALhc9FkX1i52x/QwOcQXv5vExOoBOQ=;
        b=bFHUQOTYiTqPY2uJhTqiiJP5szzj00fKU/wVlWBIRT9xZF+kEPIPAckfmCH4GhpKw+
         l387KgTqx3+vB5abyD7rN0Fd31Nz8zXqXPsr3OLwq3BRbUEYoUaLD3PdBKG+aLYVqUQn
         Vr8/QCrQ3Mgfg5HnIQW1fkE1Z7/oPpS4KZ+6eaAkWpQaqFIUVPjn8av4mTQA6Y5Hy1aa
         dtNnzFRGEWX+mozYpBgTTNYLyNBd4EKgC4u0Lo+bdoSe+FUAHPMrEJL5W3/u2MO8qbKE
         BD7Y5DnaZBotSty24IR/je8dVzJ62Jhcz0rk187QTNnHzWmaldliqN3Tn7vfi6vM5OEO
         7fjw==
X-Gm-Message-State: APjAAAWocVzoJJgL2P9PqwMWMxyaaVygWnoFOgBIgP6EdqRTFdx8dUth
        xYca24hGAcbCSgWM6MlzNw==
X-Google-Smtp-Source: APXvYqxpjkeboMJNaq6exwkGx/ymWx+cjmBRwLwt2mSOwfZHSXQmJ+7yikFJJ9x5Y1PCxpJZOHA2iQ==
X-Received: by 2002:a0c:fec4:: with SMTP id z4mr11930335qvs.101.1567201684588;
        Fri, 30 Aug 2019 14:48:04 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a4sm4857834qtb.17.2019.08.30.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 14:48:04 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] x86/mm/KASLR: Cleanup calculation for direct mapping size
Date:   Fri, 30 Aug 2019 17:47:06 -0400
Message-Id: <20190830214707.1201-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830214707.1201-1-msys.mizuma@gmail.com>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Cleanup calculation for direct mapping size.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/mm/kaslr.c | 50 +++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index dc6182eec..8e5f3642e 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -70,15 +70,45 @@ static inline bool kaslr_memory_enabled(void)
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
+	/*
+	 * Update Physical memory mapping to available and
+	 * add padding if needed (especially for memory hotplug support).
+	 */
+	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
+		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
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
@@ -95,20 +125,10 @@ void __init kernel_randomize_memory(void)
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
2.18.1

