Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E4ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C4420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfJ1I3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:29:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8023 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387486AbfJ1I3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:29:02 -0400
X-UUID: 5a0ee7c9e38041448279a910561e5df7-20191028
X-UUID: 5a0ee7c9e38041448279a910561e5df7-20191028
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1820559169; Mon, 28 Oct 2019 16:28:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:56 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:53 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Guangming Cao <guangming.cao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 08/13] iommu/mediatek: Add mtk_domain_data structure
Date:   Mon, 28 Oct 2019 16:28:15 +0800
Message-ID: <20191028082820.20221-9-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mtk_domain_data structure to describe how many iova regions
there are and the relevant the start and end address of each
iova region. The number of iova region is equal to the number
of mtk_iommu_domain. So we will use mtk_domain_data to initialize
the start and end iova of mtk_iommu_domain.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
 drivers/iommu/mtk_iommu.h | 17 +++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0eacbc473374..8d68a1af8ed5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -128,6 +128,12 @@ struct mtk_iommu_pgtable {
 	struct io_pgtable_ops	*iop;
 	struct device		*init_dev;
 	struct list_head	m4u_dom_v2;
+	const struct mtk_domain_data	*dom_region;
+};
+
+const struct mtk_domain_data single_dom = {
+	.min_iova = 0x0,
+	.max_iova = DMA_BIT_MASK(32)
 };
 
 static struct mtk_iommu_pgtable *share_pgtable;
@@ -406,6 +412,7 @@ static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
 		return ERR_PTR(-EINVAL);
 	}
+	pgtable->dom_region = data->plat_data->dom_data;
 
 	dev_info(data->dev, "%s create pgtable done\n", __func__);
 
@@ -476,8 +483,10 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
-	dom->domain.geometry.aperture_start = 0;
-	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	dom->domain.geometry.aperture_start =
+				pgtable->dom_region->min_iova;
+	dom->domain.geometry.aperture_end =
+				pgtable->dom_region->max_iova;
 	dom->domain.geometry.force_aperture = true;
 	list_add_tail(&dom->list, &pgtable->m4u_dom_v2);
 
@@ -958,6 +967,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.has_bclk     = true,
 	.has_vld_pa_rng   = true,
 	.dom_cnt = 1,
+	.dom_data = &single_dom,
 	.larbid_remap[0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
@@ -965,6 +975,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat = M4U_MT6779,
 	.dom_cnt = 1,
+	.dom_data = &single_dom,
 	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
 	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
 	.larbid_remap[1] = {2, 0, 3, 1},
@@ -981,6 +992,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.has_bclk     = true,
 	.reset_axi    = true,
 	.dom_cnt = 1,
+	.dom_data = &single_dom,
 	.larbid_remap[0] = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
@@ -989,6 +1001,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.reset_axi    = true,
 	.dom_cnt = 1,
+	.dom_data = &single_dom,
 	.larbid_remap[0] = {0, 4, 5, 6, 7, 2, 3, 1},
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 6801f8496fcc..d8aef0d57b1a 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -36,6 +36,22 @@ enum mtk_iommu_plat {
 	M4U_MT8183,
 };
 
+/*
+ * reserved IOVA Domain for IOMMU users of HW limitation.
+ */
+
+/*
+ * struct mtk_domain_data:	domain configuration
+ * @min_iova:	Start address of iova
+ * @max_iova:	End address of iova
+ * Note: one user can only belong to one domain
+ */
+
+struct mtk_domain_data {
+	dma_addr_t	min_iova;
+	dma_addr_t	max_iova;
+};
+
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	bool                has_4gb_mode;
@@ -51,6 +67,7 @@ struct mtk_iommu_plat_data {
 	u32                 m4u1_mask;
 	u32		    dom_cnt;
 	unsigned char       larbid_remap[2][MTK_LARB_NR_MAX];
+	const struct mtk_domain_data	*dom_data;
 };
 
 struct mtk_iommu_domain;
-- 
2.18.0

