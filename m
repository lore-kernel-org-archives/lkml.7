Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67586C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2420A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HhLRfjxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKSsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:48:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35610 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDKSsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:48:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id s39so6159180edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4yA9kbM0Q0ne12+8XH1tmRl7xUq0Nxej0JIzN1JreU=;
        b=HhLRfjxa79ZXKH5Hm8L2aKT5z3CmMLkQ1hyD+3gm0L+cfNfIvDgelJWfxehXaiUn4Y
         EkF9gkxnlO93eoGKTba94wUgLy7OfxfoyXfgHFMfOz970JFQNSpbpCpNsCFn7HtN7O40
         NWkXG8RmRxSbsm4e2gqjxNMWlPfUCAyg83uwOmwu7FGFCSIAGA9guCvwNSkQH1KBpG/Y
         h//oHsGzUj3Tgh6XZHgK0LH3I0eOWxrK9QiLxUXmIle8X/wI8Y5iRWaBwfJqE998wg6r
         tuBMhiydbpGnMMzEk+6L4N4IAJS5KdIM+jixwDWZT83OzvHA08bZhe0vhFW2+SXVd2Ud
         G5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4yA9kbM0Q0ne12+8XH1tmRl7xUq0Nxej0JIzN1JreU=;
        b=N5xFojStelj81S1ZvbtlGKamT3lbDi7S4fn84xiB3JWn89Sj/tqzup40RLqNRE/k8M
         6/4E60qZAYIQcu9bOGpl5PvAa4qol+UfQtZ2O/US7CLjHYKLs/HnpR9EVdFkwuOSuxtM
         0Lmow2UL7fIJ1NRWcQr+kLDhw3nMB9L+jqLyy60CGDzVcutgQ0EfqAbXmZZ3t95DjboS
         Omqff1hU98wNGoydh84Lf/OKZ5P0X+l4FagYBIvC8SmnROX2LUrnk4/FX22zfQcFSu1D
         Kxv4cmihBklem3J10iG5BFyv4XGP4wmz4qlVUtBkSyPmU2ylp6+XX1ZR2r0dBAAW1coi
         //YQ==
X-Gm-Message-State: APjAAAWayXGQWa+yKu55TDd0xHDB35pTZKM12g1Pfqrk8BJUMw0q/7rS
        yg8RCca1UV/Ldwun93h+TACiFg==
X-Google-Smtp-Source: APXvYqzMIqAsWo8mz5RO//d9/Q380vAGnatUNo+w1xdSz2URAp829inx6rjeeNWbisHhqhaffsUlNg==
X-Received: by 2002:aa7:dd11:: with SMTP id i17mr7148462edv.220.1555008520271;
        Thu, 11 Apr 2019 11:48:40 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:48:39 -0700 (PDT)
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
Subject: [PATCH 1/9] iommu/dma-iommu: Add iommu_map_atomic
Date:   Thu, 11 Apr 2019 19:47:30 +0100
Message-Id: <20190411184741.27540-2-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu ops .map function (or the iommu_map function which calls it)
was always supposed to be sleepable (according to Joerg's comment in
this thread: https://lore.kernel.org/patchwork/patch/977520/ ) and so
should probably have had a "might_sleep()" since it was written. However
currently the dma-iommu api can call iommu_map in an atomic context,
which it shouldn't do. This doesn't cause any problems because any iommu
driver which uses the dma-iommu api uses gfp_atomic in it's iommu_ops
.map function. But doing this wastes the memory allocators atomic pools.

Add a new function iommu_map_atomic, use it in the dma-iommu api and add
“might_sleep()” to the iommu_map function.

After this change all drivers which use the dma-iommu api need to
implement the new iommu ops .map_atomic function. For the moment just
reuse the driver's iommus ops .map function for .map_atomic.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/arm-smmu-v3.c    |  1 +
 drivers/iommu/arm-smmu.c       |  1 +
 drivers/iommu/dma-iommu.c      |  6 ++---
 drivers/iommu/exynos-iommu.c   |  1 +
 drivers/iommu/iommu.c          | 46 +++++++++++++++++++++++++++++-----
 drivers/iommu/ipmmu-vmsa.c     |  1 +
 drivers/iommu/mtk_iommu.c      |  1 +
 drivers/iommu/qcom_iommu.c     |  1 +
 drivers/iommu/rockchip-iommu.c |  1 +
 include/linux/iommu.h          | 22 ++++++++++++++++
 10 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..c64ba333c05a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2055,6 +2055,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
+	.map_atomic		= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..836ec6d0bba5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1691,6 +1691,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
+	.map_atomic		= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe637a60..1a4bff3f8427 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -590,7 +590,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		sg_miter_stop(&miter);
 	}
 
-	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
+	if (iommu_map_sg_atomic(domain, iova, sgt.sgl, sgt.orig_nents, prot)
 			< size)
 		goto out_free_sg;
 
@@ -648,7 +648,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
-	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
+	if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
 		iommu_dma_free_iova(cookie, iova, size);
 		return DMA_MAPPING_ERROR;
 	}
@@ -809,7 +809,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	 * We'll leave any physical concatenation to the IOMMU driver's
 	 * implementation - it knows better than we do.
 	 */
-	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
+	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
 		goto out_free_iova;
 
 	return __finalise_sg(dev, sg, nents, iova);
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 05c6bc099d62..bf1281aa12bc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1332,6 +1332,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.attach_dev = exynos_iommu_attach_device,
 	.detach_dev = exynos_iommu_detach_device,
 	.map = exynos_iommu_map,
+	.map_atomic = exynos_iommu_map,
 	.unmap = exynos_iommu_unmap,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.device_group = generic_device_group,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..1eaf0aed0aff 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1582,8 +1582,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot, bool is_atomic)
 {
 	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
@@ -1620,8 +1620,12 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
+		if (is_atomic)
+			ret = ops->map_atomic(domain, iova, paddr, pgsize,
+					      prot);
+		else
+			ret = ops->map(domain, iova, paddr, pgsize, prot);
 
-		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1641,8 +1645,22 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	might_sleep();
+	return __iommu_map(domain, iova, paddr, size, prot, false);
+}
 EXPORT_SYMBOL_GPL(iommu_map);
 
+int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	return __iommu_map(domain, iova, paddr, size, prot, true);
+}
+EXPORT_SYMBOL_GPL(iommu_map_atomic);
+
 static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    bool sync)
@@ -1717,8 +1735,9 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-		    struct scatterlist *sg, unsigned int nents, int prot)
+size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		    struct scatterlist *sg, unsigned int nents, int prot,
+		    bool is_atomic)
 {
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
@@ -1729,7 +1748,9 @@ size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		phys_addr_t s_phys = sg_phys(sg);
 
 		if (len && s_phys != start + len) {
-			ret = iommu_map(domain, iova + mapped, start, len, prot);
+			ret = __iommu_map(domain, iova + mapped, start,
+					len, prot, is_atomic);
+
 			if (ret)
 				goto out_err;
 
@@ -1757,8 +1778,21 @@ size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 
 }
+
+size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+		    struct scatterlist *sg, unsigned int nents, int prot)
+{
+	return __iommu_map_sg(domain, iova, sg, nents, prot, false);
+}
 EXPORT_SYMBOL_GPL(iommu_map_sg);
 
+size_t iommu_map_sg_atomic(struct iommu_domain *domain, unsigned long iova,
+		    struct scatterlist *sg, unsigned int nents, int prot)
+{
+	return __iommu_map_sg(domain, iova, sg, nents, prot, true);
+}
+EXPORT_SYMBOL_GPL(iommu_map_sg_atomic);
+
 int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 			       phys_addr_t paddr, u64 size, int prot)
 {
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9a380c10655e..c2e0cdb9e784 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -931,6 +931,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.attach_dev = ipmmu_attach_device,
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
+	.map_atomic = ipmmu_map,
 	.unmap = ipmmu_unmap,
 	.flush_iotlb_all = ipmmu_iotlb_sync,
 	.iotlb_sync = ipmmu_iotlb_sync,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de3e02277b70..ed8f768f46b6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -497,6 +497,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.attach_dev	= mtk_iommu_attach_device,
 	.detach_dev	= mtk_iommu_detach_device,
 	.map		= mtk_iommu_map,
+	.map_atomic	= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
 	.flush_iotlb_all = mtk_iommu_iotlb_sync,
 	.iotlb_sync	= mtk_iommu_iotlb_sync,
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 8cdd3f059513..26100487642d 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -591,6 +591,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.attach_dev	= qcom_iommu_attach_dev,
 	.detach_dev	= qcom_iommu_detach_dev,
 	.map		= qcom_iommu_map,
+	.map_atomic	= qcom_iommu_map,
 	.unmap		= qcom_iommu_unmap,
 	.flush_iotlb_all = qcom_iommu_iotlb_sync,
 	.iotlb_sync	= qcom_iommu_iotlb_sync,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 77d4bd93fe4b..d24bc2413d49 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1124,6 +1124,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.attach_dev = rk_iommu_attach_device,
 	.detach_dev = rk_iommu_detach_device,
 	.map = rk_iommu_map,
+	.map_atomic = rk_iommu_map,
 	.unmap = rk_iommu_unmap,
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffbbc7e39cee..75559918d9bd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -166,6 +166,7 @@ struct iommu_resv_region {
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
+ * @map_atomic: same as map but can be called from an atomic context
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_range_add: Add a given iova range to the flush queue for this domain
@@ -199,6 +200,8 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
+	int (*map_atomic)(struct iommu_domain *domain, unsigned long iova,
+		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
@@ -295,12 +298,17 @@ extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
+extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
+		     phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 			       unsigned long iova, size_t size);
 extern size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			   struct scatterlist *sg,unsigned int nents, int prot);
+extern size_t iommu_map_sg_atomic(struct iommu_domain *domain,
+				  unsigned long iova, struct scatterlist *sg,
+				  unsigned int nents, int prot);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
@@ -469,6 +477,13 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_atomic(struct iommu_domain *domain,
+				   unsigned long iova, phys_addr_t paddr,
+				   size_t size, int prot)
+{
+	return -ENODEV;
+}
+
 static inline size_t iommu_unmap(struct iommu_domain *domain,
 				 unsigned long iova, size_t size)
 {
@@ -488,6 +503,13 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 	return 0;
 }
 
+static inline size_t iommu_map_sg_atomic(struct iommu_domain *domain,
+				  unsigned long iova, struct scatterlist *sg,
+				  unsigned int nents, int prot)
+{
+	return 0;
+}
+
 static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
 {
 }
-- 
2.17.1

