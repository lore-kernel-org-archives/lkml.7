Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2219CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788CB20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfJ1I2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:28:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387414AbfJ1I2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:28:43 -0400
X-UUID: d01eab759fb646d5973c98ec934ee649-20191028
X-UUID: d01eab759fb646d5973c98ec934ee649-20191028
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1505586292; Mon, 28 Oct 2019 16:28:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:33 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:32 +0800
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
Subject: [PATCH 03/13] iommu/mediatek: Add mtk_iommu_pgtable structure
Date:   Mon, 28 Oct 2019 16:28:10 +0800
Message-ID: <20191028082820.20221-4-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start with this patch, we will change the SW architecture
to support multiple domains. SW architecture will has a big change,
so we need to modify a little bit by more than one patch.
The new SW overall architecture is as below:

				iommu0   iommu1
				  |	    |
				  -----------
				       |
				mtk_iommu_pgtable
				       |
			------------------------------------------
			|		     |			 |
		mtk_iommu_domain1   mtk_iommu_domain2  mtk_iommu_domain3
			|                    |                   |
		   iommu_group1         iommu_group2        iommu_group3
			|                    |                   |
		   iommu_domain1        iommu_domain2	    iommu_domain3
			|                    |                   |
		  iova region1(normal) iova region2(CCU)   iova region3(VPU)

For current structure, no matter how many iommus there are,
they use the same page table to simplify the usage of module.
In order to make the software architecture more explicit, this
patch will create a global mtk_iommu_pgtable structure to describe
page table and all the iommus use it.
The diagram is as below:

	mtk_iommu_data1(MM)       mtk_iommu_data2(APU)
		|			   |
		|			   |
		------mtk_iommu_pgtable-----

We need to create global mtk_iommu_pgtable to include all the iova
regions firstly and special iova regions by divided based on it,
so the information of pgtable needs to be created in device_group.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 84 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index f2847e661137..fcbde6b0f58d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -123,6 +123,12 @@ struct mtk_iommu_domain {
 	struct iommu_domain		domain;
 };
 
+struct mtk_iommu_pgtable {
+	struct io_pgtable_cfg	cfg;
+	struct io_pgtable_ops	*iop;
+};
+
+static struct mtk_iommu_pgtable *share_pgtable;
 static const struct iommu_ops mtk_iommu_ops;
 
 /*
@@ -170,6 +176,11 @@ static struct mtk_iommu_data *mtk_iommu_get_m4u_data(void)
 	return NULL;
 }
 
+static struct mtk_iommu_pgtable *mtk_iommu_get_pgtable(void)
+{
+	return share_pgtable;
+}
+
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct mtk_iommu_domain, domain);
@@ -322,6 +333,13 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 
+	if (data->pgtable) {
+		dom->cfg = data->pgtable->cfg;
+		dom->iop = data->pgtable->iop;
+		dom->domain.pgsize_bitmap = data->pgtable->cfg.pgsize_bitmap;
+		return 0;
+	}
+
 	dom->cfg = (struct io_pgtable_cfg) {
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 			IO_PGTABLE_QUIRK_NO_PERMS |
@@ -345,6 +363,61 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 	return 0;
 }
 
+static struct mtk_iommu_pgtable *create_pgtable(struct mtk_iommu_data *data)
+{
+	struct mtk_iommu_pgtable *pgtable;
+
+	pgtable = kzalloc(sizeof(*pgtable), GFP_KERNEL);
+	if (!pgtable)
+		return ERR_PTR(-ENOMEM);
+
+	pgtable->cfg = (struct io_pgtable_cfg) {
+		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
+			IO_PGTABLE_QUIRK_NO_PERMS |
+			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
+			IO_PGTABLE_QUIRK_ARM_MTK_EXT,
+		.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
+		.ias = 32,
+		.oas = 34,
+		.tlb = &mtk_iommu_flush_ops,
+		.iommu_dev = data->dev,
+	};
+
+	pgtable->iop = alloc_io_pgtable_ops(ARM_V7S, &pgtable->cfg, data);
+	if (!pgtable->iop) {
+		dev_err(data->dev, "Failed to alloc io pgtable\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	dev_info(data->dev, "%s create pgtable done\n", __func__);
+
+	return pgtable;
+}
+
+static int mtk_iommu_attach_pgtable(struct mtk_iommu_data *data,
+				    struct device *dev)
+{
+	struct mtk_iommu_pgtable *pgtable = mtk_iommu_get_pgtable();
+
+	/* create share pgtable */
+	if (!pgtable) {
+		pgtable = create_pgtable(data);
+		if (IS_ERR(pgtable)) {
+			dev_err(data->dev, "Failed to create pgtable\n");
+			return -ENOMEM;
+		}
+
+		share_pgtable = pgtable;
+	}
+
+	/* binding to pgtable */
+	data->pgtable = pgtable;
+
+	dev_info(data->dev, "m4u%d attach_pgtable done!\n", data->m4u_id);
+
+	return 0;
+}
+
 static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
 {
 	struct mtk_iommu_domain *dom;
@@ -508,10 +581,21 @@ static void mtk_iommu_remove_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	struct mtk_iommu_pgtable *pgtable;
+	int ret = 0;
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
+	pgtable = data->pgtable;
+	if (!pgtable) {
+		ret = mtk_iommu_attach_pgtable(data, dev);
+		if (ret) {
+			dev_err(data->dev, "Failed to device_group\n");
+			return NULL;
+		}
+	}
+
 	/* All the client devices are in the same m4u iommu-group */
 	if (!data->m4u_group) {
 		data->m4u_group = iommu_group_alloc();
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 132dc765a40b..dd5f19f78b62 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -61,6 +61,7 @@ struct mtk_iommu_data {
 	struct clk			*bclk;
 	phys_addr_t			protect_base; /* protect memory base */
 	struct mtk_iommu_suspend_reg	reg;
+	struct mtk_iommu_pgtable	*pgtable;
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
 	bool                            enable_4GB;
-- 
2.18.0

