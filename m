Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648FECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43E2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfJINTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:19:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729883AbfJINTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:19:21 -0400
X-UUID: a269641f58794e79bfcb15b0c40c9df1-20191009
X-UUID: a269641f58794e79bfcb15b0c40c9df1-20191009
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1148414917; Wed, 09 Oct 2019 21:19:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 21:19:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 21:19:12 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>
Subject: [PATCH v2 2/4] iommu/mediatek: Move the tlb_sync into tlb_flush
Date:   Wed, 9 Oct 2019 21:19:01 +0800
Message-ID: <1570627143-29441-2-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
References: <1570627143-29441-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
TLB sync") help move the tlb_sync of unmap from v7s into the iommu
framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
lacked the dom->pgtlock, then it will cause the variable
"tlb_flush_active" may be changed unexpectedly, we could see this warning
log randomly:

mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
full flush

To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".

In addition, when checking this issue, we find that __arm_v7s_unmap call
io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
this also is potential unsafe for us. There is no tlb flush queue in the
MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
If v7s don't always gurarantee the sequence, Thus, In this patch I move
the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
and we don't care if it is leaf, rearrange the callback functions. Also,
the tlb flush/sync was already finished in v7s, then iotlb_sync is
unnecessary.

Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 63 +++++++++++++----------------------------------
 drivers/iommu/mtk_iommu.h |  1 -
 2 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 76b9388..24a13a6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -173,11 +173,12 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 	}
 }
 
-static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
-					   size_t granule, bool leaf,
-					   void *cookie)
+static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
+				    size_t granule, void *cookie)
 {
 	struct mtk_iommu_data *data = cookie;
+	int ret;
+	u32 tmp;
 
 	for_each_m4u(data) {
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
@@ -188,21 +189,12 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
 			       data->base + REG_MMU_INVLD_END_A);
 		writel_relaxed(F_MMU_INV_RANGE,
 			       data->base + REG_MMU_INVALIDATE);
-		data->tlb_flush_active = true;
-	}
-}
-
-static void mtk_iommu_tlb_sync(void *cookie)
-{
-	struct mtk_iommu_data *data = cookie;
-	int ret;
-	u32 tmp;
-
-	for_each_m4u(data) {
-		/* Avoid timing out if there's nothing to wait for */
-		if (!data->tlb_flush_active)
-			return;
 
+		/*
+		 * There is no tlb flush queue in the HW, the HW always expect
+		 * tlb_flush and tlb_sync in pair strictly. Here tlb_sync always
+		 * follows tlb_flush to avoid break the sequence.
+		 */
 		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
 						tmp, tmp != 0, 10, 100000);
 		if (ret) {
@@ -212,36 +204,21 @@ static void mtk_iommu_tlb_sync(void *cookie)
 		}
 		/* Clear the CPE status */
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
-		data->tlb_flush_active = false;
 	}
 }
 
-static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
-				     size_t granule, void *cookie)
-{
-	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
-	mtk_iommu_tlb_sync(cookie);
-}
-
-static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
-				     size_t granule, void *cookie)
+static void mtk_iommu_tlb_flush_page(struct iommu_iotlb_gather *gather,
+				     unsigned long iova, size_t granule,
+				     void *cookie)
 {
-	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
-	mtk_iommu_tlb_sync(cookie);
-}
-
-static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t granule,
-					    void *cookie)
-{
-	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
+	mtk_iommu_tlb_add_flush(iova, granule, granule, cookie);
 }
 
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
-	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
-	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
-	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
+	.tlb_flush_walk = mtk_iommu_tlb_add_flush,
+	.tlb_flush_leaf = mtk_iommu_tlb_add_flush,
+	.tlb_add_page = mtk_iommu_tlb_flush_page,
 };
 
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
@@ -450,12 +427,6 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	mtk_iommu_tlb_flush_all(mtk_iommu_get_m4u_data());
 }
 
-static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
-{
-	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
-}
-
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
@@ -558,7 +529,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
 	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
-	.iotlb_sync	= mtk_iommu_iotlb_sync,
+	/* No iotlb_sync here since the tlb_sync always follows the tlb_flush */
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
 	.remove_device	= mtk_iommu_remove_device,
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index fc0f16e..24712f5 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -57,7 +57,6 @@ struct mtk_iommu_data {
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
 	bool                            enable_4GB;
-	bool				tlb_flush_active;
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
-- 
1.9.1

