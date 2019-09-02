Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66470C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7672168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFwPojdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfIBNEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:04:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfIBNEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zpw5MllFX9fhxx6EO9p2LOeJ5F0J0z3R/HLMi2TPdSQ=; b=EFwPojdcTFtbmMxJO5jtupsmx1
        0tkTmctlO9fhUz5pZDZcKWWaI/hsFfRBeODr7tpq2Gvpi3l2cF8wkkTTOE7SpqXyvwM+/3ZdPSJhk
        V7+1WpI9EgCTq837af7201iLXeuE7wvQNZJ2B66q4aSjrGgsTDB5O29MuMoavMru0ooGjSP/SpGI+
        nnfV7Xv5NVo4xIR0g5R3u9Df9GfGws/LVk4JdSzEi2+ilgFKy0ghvDyMhWndfjsjiJKalerzMcKaD
        8xCOwxM7l0dEzaweHZA5RtKiGT0A/B01FL2NCMwfPiWBdRSTvv1AgDp03eEDbZtQlmitPXIy/pQs7
        UQ2B6nXA==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4m01-0001Ua-Mj; Mon, 02 Sep 2019 13:04:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] xen: remove the exports for xen_{create,destroy}_contiguous_region
Date:   Mon,  2 Sep 2019 15:03:32 +0200
Message-Id: <20190902130339.23163-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902130339.23163-1-hch@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
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

