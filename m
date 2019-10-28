Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44236CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfJ1I24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:28:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9018 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387463AbfJ1I2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:28:54 -0400
X-UUID: 153a3fca8bda4ab09ef65568847d2e1b-20191028
X-UUID: 153a3fca8bda4ab09ef65568847d2e1b-20191028
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 377244033; Mon, 28 Oct 2019 16:28:50 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:47 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:45 +0800
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
Subject: [PATCH 06/13] iommu/mediatek: Change get the way of m4u_group
Date:   Mon, 28 Oct 2019 16:28:13 +0800
Message-ID: <20191028082820.20221-7-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Redefine mtk_iommu_domain structure, it will include iommu_group
and iommu_domain. Different mtk_iommu_domains can be distinguished by
ID. When we realize multiple mtk_iommu_domains, every mtk_iommu_domain
can describe one iova region.
2. In theory, every device has one iommu_group, so this patch will
get iommu_group by checking device. All the devices belong to the same
m4u_group currently, so they also use the same mtk_iommu_domain(id=0).

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f264fa8c16a0..27995b2b29a6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -117,12 +117,16 @@
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 struct mtk_iommu_domain {
+	u32				id;
 	struct iommu_domain		domain;
+	struct iommu_group		*group;
+	struct list_head		list;
 };
 
 struct mtk_iommu_pgtable {
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	*iop;
+	struct list_head	m4u_dom_v2;
 };
 
 static struct mtk_iommu_pgtable *share_pgtable;
@@ -173,6 +177,41 @@ static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
 	return NULL;
 }
 
+static u32 get_domain_id(void)
+{
+	/* only support one mtk_iommu_domain currently */
+	return 0;
+}
+
+static u32 mtk_iommu_get_domain_id(void)
+{
+	return get_domain_id();
+}
+
+static struct mtk_iommu_domain *get_mtk_domain(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
+	struct mtk_iommu_domain *dom;
+	u32 domain_id = mtk_iommu_get_domain_id();
+
+	list_for_each_entry(dom, &data->pgtable->m4u_dom_v2, list) {
+		if (dom->id == domain_id)
+			return dom;
+	}
+	return NULL;
+}
+
+static struct iommu_group *mtk_iommu_get_group(struct device *dev)
+{
+	struct mtk_iommu_domain *dom;
+
+	dom = get_mtk_domain(dev);
+	if (dom)
+		return dom->group;
+
+	return NULL;
+}
+
 static struct mtk_iommu_pgtable *mtk_iommu_get_pgtable(void)
 {
 	return share_pgtable;
@@ -334,6 +373,8 @@ static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
 	if (!pgtable)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&pgtable->m4u_dom_v2);
+
 	pgtable->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -388,6 +429,7 @@ static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	struct mtk_iommu_domain *dom;
 
 	if (type != IOMMU_DOMAIN_DMA)
@@ -405,12 +447,15 @@ static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 	if (iommu_get_dma_cookie(&dom->domain))
 		goto  free_dom;
 
+	dom->group = data->m4u_group;
+	dom->id = mtk_iommu_get_domain_id();
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = pgtable->cfg.pgsize_bitmap;
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = DMA_BIT_MASK(32);
 	dom->domain.geometry.force_aperture = true;
+	list_add_tail(&dom->list, &pgtable->m4u_dom_v2);
 
 	return &dom->domain;
 
@@ -566,6 +611,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	}
 
 	/* All the client devices are in the same m4u iommu-group */
+	data->m4u_group = mtk_iommu_get_group(dev);
 	if (!data->m4u_group) {
 		data->m4u_group = iommu_group_alloc();
 		if (IS_ERR(data->m4u_group))
-- 
2.18.0

