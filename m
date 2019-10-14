Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C120C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A190205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfJNGjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:39:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5291 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbfJNGjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:39:19 -0400
X-UUID: 770286f22718455b9e1f755d555f5e0c-20191014
X-UUID: 770286f22718455b9e1f755d555f5e0c-20191014
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1071566511; Mon, 14 Oct 2019 14:39:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 14:39:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 14:39:10 +0800
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
        <chao.hao@mediatek.com>, <edison.hsieh@mediatek.com>
Subject: [PATCH v3 5/7] iommu/mediatek: Move the tlb_sync into tlb_flush
Date:   Mon, 14 Oct 2019 14:38:19 +0800
Message-ID: <1571035101-4213-6-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D6519AAB6225CC953BE3549E5B551BA25AFF0DAD153178E3B499A341494007622000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, the tlb_add_flush_nosync and tlb_sync always appear together.
we merge the two functions into one. No functional change.

mtk_iommu_tlb_add_flush_nosync
mtk_iommu_tlb_sync

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 36 ++++++++----------------------------
 drivers/iommu/mtk_iommu.h |  1 -
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 19f936c..dbbacc3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -173,10 +173,12 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 	}
 }
 
-static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
+static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule, void *cookie)
 {
 	struct mtk_iommu_data *data = cookie;
+	int ret;
+	u32 tmp;
 
 	for_each_m4u(data) {
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
@@ -187,21 +189,8 @@ static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
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
 
+		/* tlb sync */
 		ret = readl_poll_timeout_atomic(data->base + REG_MMU_CPE_DONE,
 						tmp, tmp != 0, 10, 100000);
 		if (ret) {
@@ -211,17 +200,9 @@ static void mtk_iommu_tlb_sync(void *cookie)
 		}
 		/* Clear the CPE status */
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
-		data->tlb_flush_active = false;
 	}
 }
 
-static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
-				     size_t granule, void *cookie)
-{
-	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
-	mtk_iommu_tlb_sync(cookie);
-}
-
 static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
 					    unsigned long iova, size_t granule,
 					    void *cookie)
@@ -236,8 +217,8 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
 
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
-	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
-	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
+	.tlb_flush_walk = mtk_iommu_tlb_flush_range_sync,
+	.tlb_flush_leaf = mtk_iommu_tlb_flush_range_sync,
 	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
 };
 
@@ -466,9 +447,8 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	if (!is_in_gather)
 		spin_lock_irqsave(&dom->pgtlock, flags);
 
-	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
-				       data);
-	mtk_iommu_tlb_sync(data);
+	mtk_iommu_tlb_flush_range_sync(gather->start, length,
+				       gather->pgsize, data);
 
 	if (!is_in_gather)
 		spin_unlock_irqrestore(&dom->pgtlock, flags);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index d29af1d..9056f73 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -57,7 +57,6 @@ struct mtk_iommu_data {
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
 	bool                            enable_4GB;
-	bool				tlb_flush_active;
 	bool				is_in_tlb_gather_add_page;
 
 	struct iommu_device		iommu;
-- 
1.9.1

