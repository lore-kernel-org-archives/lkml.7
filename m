Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C98C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A720C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TXXO0sUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfEFSxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:53:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46352 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfEFSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:53:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id f37so16292207edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hTYvyPXHYQkQCzQru2covdVf7EDKqdAg5C6++p9hp0=;
        b=TXXO0sUa5j2S+jQ2V/DuEJrsKRb3HDirT68HeTl/j87oqJltVn4/AzBIpIAnNJ/FTH
         BXD7hqCTZ8mP2/lkvt1YSXSIXRnKzl+SJT6TihX5StIqNa/rsvmRT+SjQwhDfAJ6UJET
         MZ/njB9sHEoNIOd472p2eie0qVRix++XVw2puekuSuQtcs+wwcmPBTEbt7Pxw00WiIiH
         oJTpiQqm5ABDoXPS9p4VISTAAHXo9UWBrxWMGYQV4yMOP0ulAbVr0v4NsXjkGngspKYl
         WpzS32AYszwzwhILjzd9G0P62O4tCUfchiMuwAKSQ28IXVLOhuSTSSGSUosTjNhFTnnK
         vs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hTYvyPXHYQkQCzQru2covdVf7EDKqdAg5C6++p9hp0=;
        b=ezClKO1xKIncxbFaQqu/NtpCggUpOmqZjtFL9V0Io57jVssC0If4HafObrV9Jy8rrh
         lHJ7n2JAqAKQBUIwgq636G1dBd8O/CzpJPWe3TdGEijtb63Yc/8xdCF43Av/AFIFiXsz
         aZHrwsDjOG91ieIpn+Ol4gIdVnV4L4sTlxdDoOsSX8qtFgYgl47DPUU/aqIZ6LCgNYjy
         TwW3pi7Lpe2YmyiG6drb7S4A0YOkOZ1xQoWGEzHC76/tfru4L/2gO/R7NDUn/O1hKUgQ
         CIwZfJ1BeUQ25S2MRg5rVOCOdGVQIS4LsW/5SmKy84XHC2QFAcfS7xzGhzlCbDZrBV6a
         ktAg==
X-Gm-Message-State: APjAAAVAyqT8QcHz+q7ge1Ee4sBcSFKaHa3jLk8SK3zd8za0Y5NDmtkA
        B7QytR3T0Otmi0WbhimrwQ9+gA==
X-Google-Smtp-Source: APXvYqx6gw3vWSp/t+3S0SAtNJ94zSpQdEJDOcQR4soMcEGxTBfWu3kSLkCmkGga0x9j1A01hmIVvQ==
X-Received: by 2002:a17:906:e241:: with SMTP id gq1mr20832987ejb.5.1557168784042;
        Mon, 06 May 2019 11:53:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:d9d9:922a:828d:a50e])
        by smtp.gmail.com with ESMTPSA id e35sm3361412eda.2.2019.05.06.11.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 11:53:03 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/4] iommu/dma-iommu: Use the dev->coherent_dma_mask
Date:   Mon,  6 May 2019 19:52:05 +0100
Message-Id: <20190506185207.31069-4-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506185207.31069-1-tmurphy@arista.com>
References: <20190506185207.31069-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dev->coherent_dma_mask when allocating in the dma-iommu ops api.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b383498e2dc3..2a968afdab10 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -442,7 +442,8 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, struct iommu_domain *domain)
+		size_t size, int prot, struct iommu_domain *domain,
+		dma_addr_t dma_mask)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	size_t iova_off = 0;
@@ -453,7 +454,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size = iova_align(&cookie->iovad, size + iova_off);
 	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -496,7 +497,7 @@ static void *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
 		return NULL;
 
 	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dev->coherent_dma_mask);
 	if (*dma_handle == DMA_MAPPING_ERROR) {
 		if (!dma_release_from_contiguous(dev, page, count))
 			__free_pages(page, page_order);
@@ -766,7 +767,7 @@ static void *iommu_dma_alloc_pool(struct device *dev, size_t size,
 
 	*dma_handle = __iommu_dma_map(dev, page_to_phys(page), size,
 			dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs),
-			iommu_get_domain_for_dev(dev));
+			iommu_get_domain_for_dev(dev), dev->coherent_dma_mask);
 	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_free_from_pool(vaddr, PAGE_ALIGN(size));
 		return NULL;
@@ -857,7 +858,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 
 	dma_handle = __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, coherent, attrs),
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -1067,7 +1068,7 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 {
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-			iommu_get_dma_domain(dev));
+			iommu_get_dma_domain(dev), dma_get_mask(dev));
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1246,7 +1247,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain,
+			dma_get_mask(dev));
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
-- 
2.17.1

