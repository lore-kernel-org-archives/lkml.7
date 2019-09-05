Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74012C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E921848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rmPfkBen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfIELlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:41:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfIELlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zpw5MllFX9fhxx6EO9p2LOeJ5F0J0z3R/HLMi2TPdSQ=; b=rmPfkBenL2yRFjJLj3fIwC543f
        4FhJO1UqDa9kCpwqoCVppareAUTL4jcoGK+oMBg0RlL9pGbQAgve5r2nHAJObkhzyksgmjioUFkWv
        nt1ZOR/f3dnCUxNvZ548FFv1Z21dGJl8E3MiwTIwWCnCdEdDoRaVlvVlxHiehbUOzxubBuR80StiR
        LfZEPPwSvRAQ7X7mC2yV9kKzLPmdMpToQfBRFkq62lLt846OgrexM6vKDtNOm1L9pHWe0fEwARe6S
        k8awuOk4p/wxKE0uXZuvsGEgniu6yEECAaSUdo4kpMvbZguyMQLRsYZh3PPBNSGa3o706CFPPVk/o
        Sun6apgQ==;
Received: from [2001:4bb8:18c:1755:a4b2:9562:6bf1:4bb9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5q8I-0004y1-Gq; Thu, 05 Sep 2019 11:40:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] xen: remove the exports for xen_{create,destroy}_contiguous_region
Date:   Thu,  5 Sep 2019 13:34:03 +0200
Message-Id: <20190905113408.3104-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905113408.3104-1-hch@lst.de>
References: <20190905113408.3104-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These routines are only used by swiotlb-xen, which cannot be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 arch/arm/xen/mm.c     | 2 --
 arch/x86/xen/mmu_pv.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 11d5ad26fcfe..9d73fa4a5991 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -154,13 +154,11 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	*dma_handle = pstart;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(xen_create_contiguous_region);
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
 	return;
 }
-EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
 int __init xen_mm_init(void)
 {
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 26e8b326966d..c8dbee62ec2a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2625,7 +2625,6 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	*dma_handle = virt_to_machine(vstart).maddr;
 	return success ? 0 : -ENOMEM;
 }
-EXPORT_SYMBOL_GPL(xen_create_contiguous_region);
 
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 {
@@ -2660,7 +2659,6 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 
 	spin_unlock_irqrestore(&xen_reservation_lock, flags);
 }
-EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
 static noinline void xen_flush_tlb_all(void)
 {
-- 
2.20.1

