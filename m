Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2215C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C662220B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JFf67WwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfEFSxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:53:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37239 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEFSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:53:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id w37so16322877edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ybQIpJHlWaFs/zU9bGDFvVwxe0GuybJKNVxIUx2IidQ=;
        b=JFf67WwYhFLm0sTPsKCR4MLJ0rPWCvtSCjSSI4/WRj/g9uerAOoO3YHngKXqV5XRDA
         BsbOZnljWpcXPUXX/jdN2xuHesc6zNY0itBP+Fnyyrju3F9JKQ0g/s7Ckwv7CC2oFl1z
         wI0b3z3GIBx6hJ/4s6XRLBTMGNolbKMrJ0Vb3tg01k29lvgmr+SxiJ/TBbe4Qq9DsrKF
         qQiEaIlqgSuvkr/cE/rrrDO7H+Q6t/rD5v/qYXgdM3iw1x5tIh+qOQo1qf2dmaa/9AK4
         IrFWN83fIgwTfxZdeZHp0uHV/tDIwiIQrAP0r7XVNfccsjI2qQbvZKc+B08HsaVF6EPb
         B2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ybQIpJHlWaFs/zU9bGDFvVwxe0GuybJKNVxIUx2IidQ=;
        b=H/sCrWg9HXXwL8HYHPnkBpopmuO45CpIYTGGMm24HqstKwnjEM2zpz3vQE8OLrsAyy
         pt8slzJHBUvX9hmHcJNANBBzu7ULirUZs8Hbv2rCjKnA6oyn2+GnfeBGf9p8ir/IgjLG
         Xjyd//7NSuiXQboh5iEUEhoQ/eZ5wHX+CPhMZo/FmwutP5nDEeuLr5i7Czn+rVmdpyVn
         kQnSecBW0NM1EONUC50yHywNUAT5t+9eA3METkMul5+1mp5Hcg8y+xYUM1OnbvUrvoeE
         a6sC8u+MZrNB4H5P8CkvBeVuOFZbpSWLkPU2smFyTIqGIvmQ/E6ASGWQPF/oZvBEN371
         blew==
X-Gm-Message-State: APjAAAUKQkdn5KRzDtbKDYIsHwAUOL4lNOb7UkYVdyFHwmLNOV1T/U+O
        SGe4CKkuCFS2kOhjEGErSLGDjg==
X-Google-Smtp-Source: APXvYqy6IgposVXar6I91KdFzVPePJ0WSHgH7cCqvKmX63+rZDsgMJaDXv+5YPJR8LEJQrNd+kLsNA==
X-Received: by 2002:a17:907:1059:: with SMTP id oy25mr8017394ejb.118.1557168781318;
        Mon, 06 May 2019 11:53:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:d9d9:922a:828d:a50e])
        by smtp.gmail.com with ESMTPSA id e35sm3361412eda.2.2019.05.06.11.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 11:53:00 -0700 (PDT)
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
Subject: [PATCH v3 2/4] iommu/dma-iommu: Handle deferred devices
Date:   Mon,  6 May 2019 19:52:04 +0100
Message-Id: <20190506185207.31069-3-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506185207.31069-1-tmurphy@arista.com>
References: <20190506185207.31069-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle devices which defer their attach to the iommu in the dma-iommu api

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a96c2c8f56b..b383498e2dc3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -322,6 +323,22 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
+static int handle_deferred_device(struct device *dev)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *ops;
+
+	if (!is_kdump_kernel())
+		return 0;
+
+	domain = iommu_get_domain_for_dev(dev);
+	ops = domain->ops;
+	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
+		return iommu_attach_device(domain, dev);
+
+	return 0;
+}
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -835,7 +852,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	bool coherent = dev_is_dma_coherent(dev);
 	dma_addr_t dma_handle;
 
-	dma_handle =__iommu_dma_map(dev, phys, size,
+	if (unlikely(handle_deferred_device(dev)))
+		return DMA_MAPPING_ERROR;
+
+	dma_handle = __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, coherent, attrs),
 			iommu_get_dma_domain(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
@@ -953,6 +973,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
+	if (unlikely(handle_deferred_device(dev)))
+		return 0;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
@@ -1056,6 +1079,9 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	if (unlikely(handle_deferred_device(dev)))
+		return NULL;
+
 	gfp |= __GFP_ZERO;
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
-- 
2.17.1

