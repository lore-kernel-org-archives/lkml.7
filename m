Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41075C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B6820850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LB8fzaJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKSsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:48:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44012 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDKSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:48:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so6122968edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jV061f41NQwb8JTG8oXH2FoN+EzpljlUI1gqzDD5mU=;
        b=LB8fzaJxGq1UE+kpvHkDhu+B7IYs10PuyLyxZ03R2k40h38528mg8DNtw5CvvGGUEC
         4dNobAdGceLj4W3cf/sfNIbHYYnxPug8x3dHbMQMr2kBWb4l2K/d40OgBWHu7LGBSrMM
         s+LiuJL7CxNF9g9cw4QCmZ7DPjTrADiA+PibC+2h5HaxTFrd/3KF3OxCtBPyIfkaGijI
         w27pVFIysfKxbHH1Oa9xGIwlfToSd/gcWJ+6qScvI3KsfWoRcLhGTSa83G90H5wmgs26
         LzzyBPinYyZ0Vrq04CSUH9OmCRpgSwAiWliiYd80JUgr4JUSA6+IIwLoCw9dkVOlrsoq
         r3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6jV061f41NQwb8JTG8oXH2FoN+EzpljlUI1gqzDD5mU=;
        b=YkSpT7fZin3+lawLxcfVh9AsZodvgOKgyXwU+xF0ThCJN4qN+6HX2sJvr1wQh3pucH
         +6JTjg4UJRP7x2O57xnmBl0P3tI8JKuoA0zeI//+qYR0WFdtJWwufswOud5qIxuvV5GD
         j+xz6u1KhmLZivz8It9dmu5MgPJgg3ZHLcSn6dixwJ3k1t0vNl81h0MNjQDtk7+LIA1v
         +RbtJ3wLvWAKwO4LikDJYEbYiGiMElT5RJUIy85yv9bp5FVS6QWlq/fJ4V+mageyb0WA
         yRdw1x79+/o8Zb3GBI2HpmWN0oRbL9ovXFzdELX4LKsLTILTycpB3zGTPojrS3X37lPH
         DUYA==
X-Gm-Message-State: APjAAAXAF0Jg6oKQZ3+RFANzN1ElOKutmvr3wOQZat7N/DVbDObl7OeM
        hT+9td247dncnDagk4AeHJ2foQ==
X-Google-Smtp-Source: APXvYqxuoTpmggkOjj92suBw5a7aMbe3r0ArbtvwTV09yEmPy8J3qtmyATEWD+DKwUJEiX7Kcbu32A==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr27817212eju.37.1555008532896;
        Thu, 11 Apr 2019 11:48:52 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:48:52 -0700 (PDT)
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
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/9] iommu/dma-iommu: Add function to flush any cached not present IOTLB entries
Date:   Thu, 11 Apr 2019 19:47:31 +0100
Message-Id: <20190411184741.27540-3-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the AMD and Intel drivers can cache not present IOTLB entries. To
convert these drivers to the dma-iommu api we need a generic way to
flush the NP cache. IOMMU drivers which have a NP cache can implement
the .flush_np_cache function in the iommu ops struct. I will implement
.flush_np_cache for both the Intel and AMD drivers in later patches.

The Intel np-cache is described here:
https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf#G7.66452

And the AMD np-cache is described here:
https://developer.amd.com/wordpress/media/2012/10/34434-IOMMU-Rev_1.26_2-11-09.pdf#page=63

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 10 ++++++++++
 include/linux/iommu.h     |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1a4bff3f8427..cc5da30d6e58 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -594,6 +594,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 			< size)
 		goto out_free_sg;
 
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, size);
+
 	*handle = iova;
 	sg_free_table(&sgt);
 	return pages;
@@ -652,6 +655,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		iommu_dma_free_iova(cookie, iova, size);
 		return DMA_MAPPING_ERROR;
 	}
+
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, size);
+
 	return iova + iova_off;
 }
 
@@ -812,6 +819,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
+	if (domain->ops->flush_np_cache)
+		domain->ops->flush_np_cache(domain, iova, iova_len);
+
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 75559918d9bd..47ff8d731d6a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,7 @@ struct iommu_resv_region {
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
  * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
+ * @flush_np_cache: Flush the non present entry cache
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
  * @remove_device: remove device from iommu grouping
@@ -209,6 +210,8 @@ struct iommu_ops {
 				unsigned long iova, size_t size);
 	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
+	void (*flush_np_cache)(struct iommu_domain *domain,
+				unsigned long iova, size_t size);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
-- 
2.17.1

