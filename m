Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203D6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A022075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="no/sVD3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732784AbfC0IGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:06:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732713AbfC0IF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=21v8HHnL8SES9qMLaNZ2m6p02TWcE1ddQOCXEsHqBY8=; b=no/sVD3cnA3TR78Cv/mMjsoR1L
        1rcJrPs2PVvSntLUZp0rxPYJ7c7EqQZ4IFrflFErYvNLtNo7H2VF496mRbRvCoU/xN5lGOralf1Vz
        d7fgaufXR0rDQRqjkJbJOUX2E7uYGYL4ZGi5lJ45Y1uJzJiJTO3HQpLKjcyMMS7K3wfb2XzceWIgj
        K+V4J6RhPWWG+AA4A/zbnjGwz8LUWZjt6JoQQwSu2NVRMooPYMpPctG1t8f42ocTfG7+XASJCuYl0
        EXinFuSm1Q0QpZGelBv67EwmEH9GOr3Z7ZfeYJQhO2O4QGysv/aAH8Y5mfVv9fewyUGKFFohpi7Pl
        NGYIScJw==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93ZJ-0006yD-Pz; Wed, 27 Mar 2019 08:05:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] dma-iommu: don't remap contiguous allocations for coherent devices
Date:   Wed, 27 Mar 2019 09:04:42 +0100
Message-Id: <20190327080448.5500-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to remap for pte attributes, or for a virtually
contiguous address, so just don't do it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 445d1c163cae..dd28452ab3c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1048,10 +1048,10 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
-		if (!addr)
-			return NULL;
-		page = virt_to_page(addr);
+		if (coherent || !addr)
+			return addr;
 
+		page = virt_to_page(addr);
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
 				__builtin_return_address(0));
 		if (!addr) {
@@ -1059,8 +1059,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 			return NULL;
 		}
 
-		if (!coherent)
-			arch_dma_prep_coherent(page, iosize);
+		arch_dma_prep_coherent(page, iosize);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1

