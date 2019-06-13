Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CJfAiZ+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbfFMQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:31:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730874AbfFMIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OeLHvABMR/TwR5YwkjiNrb3nSGoyZtNL+rTIgtUc4P0=; b=CJfAiZ+SswqFEtf6hSL7ttuQc
        o4qEscCyZxXtmKRMkWLZDzjKmCiMHk/NrH+9qyarVgx9twv4IRu4BRJpPwnCvn2NQuz//FdBPN5mS
        a3CLlgl4he317iXHiQW8TZgidVN3uEvNTfFrgbHkdBZ8dOLGuWp/6neQ1OOqXALkwVUAD/4gV36LQ
        /CPAgRw/bZTjsPjTqWRrsgwO+VP6YVPPp5DnfO34GYvIgT44sIQJp4n3uaxadU+mnIBxcmoa/ZPfN
        9GgiBHeaxYFagJzkpDs/5Z1mpeHoCK3/114eGqG8kNgkyYMZF3uXofJ+Oha/KdvG6P4z352l0y7xV
        1zfMOHnaA==;
Received: from mpp-cp1-natpool-1-013.ethz.ch ([82.130.71.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbL2U-0000jE-2t; Thu, 13 Jun 2019 08:24:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     aaro.koskinen@iki.fi, Larry.Finger@lwfinger.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
Date:   Thu, 13 Jun 2019 10:24:46 +0200
Message-Id: <20190613082446.18685-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the strict dma mask checking introduced with the switch to
the generic DMA direct code common wifi chips on 32-bit powerbooks
stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
to allow them to reliably allocate dma coherent memory.

Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/page.h         | 7 +++++++
 arch/powerpc/mm/mem.c                   | 3 ++-
 arch/powerpc/platforms/powermac/Kconfig | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b8286a2013b4..0d52f57fca04 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -319,6 +319,13 @@ struct vm_area_struct;
 #endif /* __ASSEMBLY__ */
 #include <asm/slice.h>
 
+/*
+ * Allow 30-bit DMA for very limited Broadcom wifi chips on many powerbooks.
+ */
+#ifdef CONFIG_PPC32
+#define ARCH_ZONE_DMA_BITS 30
+#else
 #define ARCH_ZONE_DMA_BITS 31
+#endif
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index cba29131bccc..2540d3b2588c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -248,7 +248,8 @@ void __init paging_init(void)
 	       (long int)((top_of_ram - total_ram) >> 20));
 
 #ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
+	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
+			((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index f834a19ed772..c02d8c503b29 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -7,6 +7,7 @@ config PPC_PMAC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
+	select ZONE_DMA if PPC32
 	default y
 
 config PPC_PMAC64
-- 
2.20.1

