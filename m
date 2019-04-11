Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA74C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDECD20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZqsZwWNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDKStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39162 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDKStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so6141235edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yoJ8L21VfG+7EiXp/r/AWsB982DfY9O3RZBK5Kp8sB8=;
        b=ZqsZwWNrSw+xqySh9ZjBwb+L6eYpx0X4qksRNIOZU8mg1TOpLf9O0fXmV0r6aHL2fZ
         3MfvzFGrJstIHcy1Po8voTQFYh8EpRq1/E82o6IVwvbNi70AX9ZsnmIDFYU6mz9IgKtS
         dYq2HbKPb0HAXgobjaNdmeDR8NvJmumSeiwwulVBya5cl5NYPDrIwZ2Tv3gVZLFW7Ova
         tsj1dT55hh6+YaiULDGzVztJQZPedQIn3i7JLnjvyt1OWAKoMUr4a3U/hvmoA6UDpVts
         xZLLAyc0d3/bS++XMrG4Q+Bewl65uvasxMRMjuBIQJx//ij8nSqueitAqBQHl/yYVNfY
         09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yoJ8L21VfG+7EiXp/r/AWsB982DfY9O3RZBK5Kp8sB8=;
        b=ixuKf1ouzILh0bkzGxWLA8ubRf+b5K//wUbDLk4lK4Jxv5Z8dh+OeEjjLGc2zaU3S6
         EJETb9jY7hqG52nY2+SXdifZtWW8k7ffgc9IEK+np9kzFrEHVE3BwduKxXQqIRe9an4f
         6EeU6VlVSSEFVcJxTg1A0dju0w6VirMXzJkSKbI+C3La0tIlSIEWz9rKa2v1DCRiuAbu
         Uh05k5Qa/zRmkahHFw6JLrEAMauT4W1jMc9ThIINE4gAX+IeA1YWbrUi0+SwUJAyz0v+
         MrTf03BtqkvI4XUC8pnUdmtNIOaP8z1TZdSma+pZ4cadSzNH7x8L2DE1A923ohyeivcQ
         89iA==
X-Gm-Message-State: APjAAAUOc1j1+JWyBE3JW9Ru+3zqHHcFYAaABL1BNXP5WqQSKlfbQHut
        ws77wHKxCoU30PMVmsQ7+dkNrw==
X-Google-Smtp-Source: APXvYqzhcIOArLgPaFIotHVPB4LMHAtfaoxhteXVLtNCkA9H3EacRfD1/rKtcbt7o0ew6bGKIbXfPg==
X-Received: by 2002:a17:906:d1da:: with SMTP id bs26mr28530697ejb.149.1555008542329;
        Thu, 11 Apr 2019 11:49:02 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:49:01 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 4/9] iommu/dma-iommu: Add iommu_dma_map_page_coherent
Date:   Thu, 11 Apr 2019 19:47:33 +0100
Message-Id: <20190411184741.27540-5-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu_dma_map_page_coherent function to allow mapping pages through
the dma-iommu api using the dev->coherent_dma_mask mask instead of the
dev->dma_mask mask

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++++-----
 include/linux/dma-iommu.h |  3 +++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 613d181e78a9..0128370f8b88 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -663,7 +663,8 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot, struct iommu_domain *domain,
+		dma_addr_t dma_limit)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
@@ -674,7 +675,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size = iova_align(&cookie->iovad, size + iova_off);
 	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_limit, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -693,7 +694,19 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot)
 {
 	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
+}
+
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot)
+{
+	dma_addr_t dma_mask = dev->coherent_dma_mask;
+
+	if (!dma_mask)
+		dma_mask = dma_get_mask(dev);
+
+	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
+			iommu_get_dma_domain(dev), dma_mask);
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
@@ -883,7 +896,7 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 {
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
 }
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -910,7 +923,9 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain,
+			dma_get_mask(dev));
+
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index c527ded5c41c..185ff8500841 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -55,6 +55,9 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, int prot);
+dma_addr_t iommu_dma_map_page_coherent(struct device *dev,
+		struct page *page, unsigned long offset,
+		size_t size, int prot);
 int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, int prot);
 
-- 
2.17.1

