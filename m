Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D3C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80A520578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfEMHNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfEMHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E52D309266A;
        Mon, 13 May 2019 07:13:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C6A3844;
        Mon, 13 May 2019 07:13:11 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com
Subject: [PATCH 1/4] iommu: Pass a GFP flag parameter to iommu_alloc_resv_region()
Date:   Mon, 13 May 2019 09:12:59 +0200
Message-Id: <20190513071302.30718-2-eric.auger@redhat.com>
In-Reply-To: <20190513071302.30718-1-eric.auger@redhat.com>
References: <20190513071302.30718-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 13 May 2019 07:13:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We plan to call iommu_alloc_resv_region in a non preemptible section.
Pass a GFP flag to the function and update all the call sites.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/acpi/arm64/iort.c   | 3 ++-
 drivers/iommu/amd_iommu.c   | 7 ++++---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm-smmu.c    | 2 +-
 drivers/iommu/intel-iommu.c | 4 ++--
 drivers/iommu/iommu.c       | 7 ++++---
 include/linux/iommu.h       | 2 +-
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index adbf7cbedf80..20b56ae91513 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -868,7 +868,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 			struct iommu_resv_region *region;
 
 			region = iommu_alloc_resv_region(base + SZ_64K, SZ_64K,
-							 prot, IOMMU_RESV_MSI);
+							 prot, IOMMU_RESV_MSI,
+							 GFP_KERNEL);
 			if (region) {
 				list_add_tail(&region->list, head);
 				resv++;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..a9aab13a9487 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3186,7 +3186,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 			type = IOMMU_RESV_RESERVED;
 
 		region = iommu_alloc_resv_region(entry->address_start,
-						 length, prot, type);
+						 length, prot, type,
+						 GFP_KERNEL);
 		if (!region) {
 			dev_err(dev, "Out of memory allocating dm-regions\n");
 			return;
@@ -3196,14 +3197,14 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	region = iommu_alloc_resv_region(MSI_RANGE_START,
 					 MSI_RANGE_END - MSI_RANGE_START + 1,
-					 0, IOMMU_RESV_MSI);
+					 0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 	list_add_tail(&region->list, head);
 
 	region = iommu_alloc_resv_region(HT_RANGE_START,
 					 HT_RANGE_END - HT_RANGE_START + 1,
-					 0, IOMMU_RESV_RESERVED);
+					 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
 	if (!region)
 		return;
 	list_add_tail(&region->list, head);
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..5aae50c811b3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2031,7 +2031,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..3c28bc0555d4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1667,7 +1667,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
 	if (!region)
 		return;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28cb713d728c..2075abdb174d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4221,7 +4221,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 
 	length = rmrr->end_address - rmrr->base_address + 1;
 	rmrru->resv = iommu_alloc_resv_region(rmrr->base_address, length, prot,
-					      IOMMU_RESV_DIRECT);
+					      IOMMU_RESV_DIRECT, GFP_KERNEL);
 	if (!rmrru->resv)
 		goto free_rmrru;
 
@@ -5290,7 +5290,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
-				      0, IOMMU_RESV_MSI);
+				      0, IOMMU_RESV_MSI, GFP_KERNEL);
 	if (!reg)
 		return;
 	list_add_tail(&reg->list, head);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 109de67d5d72..b0598c202e11 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -260,7 +260,7 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 	}
 insert:
 	region = iommu_alloc_resv_region(new->start, new->length,
-					 new->prot, new->type);
+					 new->prot, new->type, GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
 
@@ -1898,11 +1898,12 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
-						  enum iommu_resv_type type)
+						  enum iommu_resv_type type,
+						  gfp_t flags)
 {
 	struct iommu_resv_region *region;
 
-	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	region = kzalloc(sizeof(*region), flags);
 	if (!region)
 		return NULL;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffbbc7e39cee..c9cc8be6840b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -310,7 +310,7 @@ extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
-			enum iommu_resv_type type);
+			enum iommu_resv_type type, gfp_t flags);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
 
-- 
2.20.1

