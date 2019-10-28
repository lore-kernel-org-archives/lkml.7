Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6380D214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfJ1I3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:29:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58101 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387486AbfJ1I26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:28:58 -0400
X-UUID: 938b3f7e5b3a48a5a1edeade2758442a-20191028
X-UUID: 938b3f7e5b3a48a5a1edeade2758442a-20191028
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1234775578; Mon, 28 Oct 2019 16:28:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:50 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:49 +0800
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
Subject: [PATCH 07/13] iommu/mediatek: Add smi_larb info about device
Date:   Mon, 28 Oct 2019 16:28:14 +0800
Message-ID: <20191028082820.20221-8-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the devices which used iommu are connected to SMI_larb port,
so when different devices driver execute initialization, iommu
can check larb_id and port_id to distinguish them and make
them match to iommu_group accordingly. We also add dom_cnt variable
to describe the number of mtk_iommu_domain.

Larb_id and port_id define can refer to "mtxxxx-larb-port.h(ex:
mt6779-larb-port.h)" file

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 50 ++++++++++++++++++++++++++++++++-------
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 27995b2b29a6..0eacbc473374 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -126,6 +126,7 @@ struct mtk_iommu_domain {
 struct mtk_iommu_pgtable {
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	*iop;
+	struct device		*init_dev;
 	struct list_head	m4u_dom_v2;
 };
 
@@ -177,22 +178,35 @@ static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
 	return NULL;
 }
 
-static u32 get_domain_id(void)
+static u32 get_domain_id(struct mtk_iommu_data *data, u32 portid)
 {
-	/* only support one mtk_iommu_domain currently */
-	return 0;
+	u32 dom_id = 0;
+	int i;
+
+	/* only support one mtk_iommu_domain currently(dom_cnt = 1) */
+	for (i = 0; i < data->plat_data->dom_cnt; i++)
+		return i;
+
+	return dom_id;
 }
 
-static u32 mtk_iommu_get_domain_id(void)
+static u32 mtk_iommu_get_domain_id(struct device *dev)
 {
-	return get_domain_id();
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	u32 portid = fwspec->ids[0];
+
+	return get_domain_id(data, portid);
 }
 
 static struct mtk_iommu_domain *get_mtk_domain(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
 	struct mtk_iommu_domain *dom;
-	u32 domain_id = mtk_iommu_get_domain_id();
+	u32 domain_id = mtk_iommu_get_domain_id(dev);
+
+	if (domain_id >= data->plat_data->dom_cnt)
+		return NULL;
 
 	list_for_each_entry(dom, &data->pgtable->m4u_dom_v2, list) {
 		if (dom->id == domain_id)
@@ -431,11 +445,18 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	struct mtk_iommu_domain *dom;
+	struct device *dev;
 
 	if (type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
-	if (!pgtable) {
+	if (pgtable) {
+		dev = pgtable->init_dev;
+		if (!data->m4u_group) {
+			pr_err("%s, find m4u_group failed\n", __func__);
+			return NULL;
+		}
+	} else {
 		pr_err("%s, pgtable is not ready\n", __func__);
 		return NULL;
 	}
@@ -447,8 +468,11 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
+	dom->id = mtk_iommu_get_domain_id(dev);
+	if (dom->id >= data->plat_data->dom_cnt)
+		goto  put_dma_cookie;
+
 	dom->group = data->m4u_group;
-	dom->id = mtk_iommu_get_domain_id();
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
@@ -459,6 +483,8 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 
 	return &dom->domain;
 
+put_dma_cookie:
+	iommu_put_dma_cookie(&dom->domain);
 free_dom:
 	kfree(dom);
 	return NULL;
@@ -619,6 +645,10 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	} else {
 		iommu_group_ref_get(data->m4u_group);
 	}
+
+	/* save the latest init device */
+	pgtable->init_dev = dev;
+
 	return data->m4u_group;
 }
 
@@ -927,12 +957,14 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.has_4gb_mode = true,
 	.has_bclk     = true,
 	.has_vld_pa_rng   = true,
+	.dom_cnt = 1,
 	.larbid_remap[0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
 
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat = M4U_MT6779,
+	.dom_cnt = 1,
 	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
 	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
 	.larbid_remap[1] = {2, 0, 3, 1},
@@ -948,6 +980,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.has_4gb_mode = true,
 	.has_bclk     = true,
 	.reset_axi    = true,
+	.dom_cnt = 1,
 	.larbid_remap[0] = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
@@ -955,6 +988,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
 	.reset_axi    = true,
+	.dom_cnt = 1,
 	.larbid_remap[0] = {0, 4, 5, 6, 7, 2, 3, 1},
 	.inv_sel_reg = REG_MMU_INV_SEL,
 };
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index dd5f19f78b62..6801f8496fcc 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -49,6 +49,7 @@ struct mtk_iommu_plat_data {
 	bool                has_misc_ctrl[2];
 	u32                 inv_sel_reg;
 	u32                 m4u1_mask;
+	u32		    dom_cnt;
 	unsigned char       larbid_remap[2][MTK_LARB_NR_MAX];
 };
 
-- 
2.18.0

