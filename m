Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DDAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8721479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="kAYPj6K2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfIHQ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:57:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45968 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfIHQ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:57:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id x3so5432934plr.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2k166qQLdaC2SRzvjISKU2JzkbWYFtRfKLEqNuRRq4w=;
        b=kAYPj6K2IJuyTOY+kT86j3hQitRbWXFgFsW9w6/gO7/hMZYRqd/bloOMw2F/lpChzP
         YvS1FpjnQ7WTZUiBKhuwWrRNnhQ8+5lFNUeTrpOLhVw7L7emTGKP65A5/4d4DshhF6au
         m7xSmJ25Y+qDsyVQuM0RXIEYAk3+m7heaUfNvVtMeW0heVmK7Lo4sAzjl9mxtDc+TQCx
         vMDToxbJN+l9TDZ1Z1i+XMUNrwx8bsvSr4YD91AaITgGE5SbvpPUfFGTuXqiMs9QBiet
         ZsEuPlUVzvy2zeiU5k/aHd48vhmQxNpo54Qn4oZdmEWb65EcV5U8BMpf1Rai2YzioDg6
         wXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k166qQLdaC2SRzvjISKU2JzkbWYFtRfKLEqNuRRq4w=;
        b=GsQAax7zz0xzwN9oW0RsbvosFIJP+9ejbNtbnOeWB9rkzYxb9dii3YeQKtTwlMjc0w
         ybfIedLp0iggjC8W62MdjGeIrebQO7KzIQvCWfJ4m/igY+worI0mpqysWrbN6SaX62B9
         KRjyk3w8Gx0x9DARfb+EJcaLpD7zTqpLf6nBpIKJxK+y9n7/PXqcGOp0Ha1mOOrimAhf
         D0vgiIvMPcfHAOwtJ42+OfjyQXkCBNap9xMUdRH9yWzsDDlK717uhddfXGBmxf9/10Ti
         uShamcx3ASe6p9to/P59qpCu9382dIxjTzjWDyTIcKs3GwLWR6kz2q0ntelsPkPJzZX1
         JBkw==
X-Gm-Message-State: APjAAAWb3IzIJS6SYdmL//rAFGRyRaZRlm0s+0Z5PAdT9xUg28wL6ayj
        ADqCRgmkSc/1FusrnX9lNGpA5Q==
X-Google-Smtp-Source: APXvYqyyDdzrixHMRhxuF70UStjT1CSPQlQ1OcGvtHHzm4UnowYHpa/hlXLtO0d2Ac6mRvc2hcMUcQ==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr6220783ply.278.1567961825902;
        Sun, 08 Sep 2019 09:57:05 -0700 (PDT)
Received: from localhost.localdomain ([24.244.23.109])
        by smtp.googlemail.com with ESMTPSA id f188sm13834631pfa.170.2019.09.08.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 09:57:05 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V6 3/5] iommu/dma-iommu: Handle deferred devices
Date:   Sun,  8 Sep 2019 09:56:39 -0700
Message-Id: <20190908165642.22253-4-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908165642.22253-1-murphyt7@tcd.ie>
References: <20190908165642.22253-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle devices which defer their attach to the iommu in the dma-iommu api

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2712fbc68b28..bd09b6b31c4e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -351,6 +352,21 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
+static int iommu_dma_deferred_attach(struct device *dev,
+		struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = domain->ops;
+
+	if (!is_kdump_kernel())
+		return 0;
+
+	if (unlikely(ops->is_attach_deferred &&
+			ops->is_attach_deferred(domain, dev)))
+		return iommu_attach_device(domain, dev);
+
+	return 0;
+}
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -463,6 +479,9 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	size_t iova_off = iova_offset(iovad, phys);
 	dma_addr_t iova;
 
+	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+		return DMA_MAPPING_ERROR;
+
 	size = iova_align(iovad, size + iova_off);
 
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
@@ -581,6 +600,9 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 
 	*dma_handle = DMA_MAPPING_ERROR;
 
+	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+		return NULL;
+
 	min_size = alloc_sizes & -alloc_sizes;
 	if (min_size < PAGE_SIZE) {
 		min_size = PAGE_SIZE;
@@ -713,7 +735,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle =__iommu_dma_map(dev, phys, size, prot);
+	dma_handle = __iommu_dma_map(dev, phys, size, prot);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -823,6 +845,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
+	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
+		return 0;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
-- 
2.20.1

