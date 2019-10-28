Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73A4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D94208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfJ1I3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:29:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58883 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731943AbfJ1I3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:29:24 -0400
X-UUID: c2d9be443de44f30a353b6aae80677c9-20191028
X-UUID: c2d9be443de44f30a353b6aae80677c9-20191028
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1865292384; Mon, 28 Oct 2019 16:29:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:29:15 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:29:13 +0800
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
Subject: [PATCH 13/13] iommu/mediatek: Add multiple mtk_iommu_domain support for mt6779
Date:   Mon, 28 Oct 2019 16:28:20 +0800
Message-ID: <20191028082820.20221-14-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For mt6779, it needs to support three mtk_iommu_domains, every
mtk_iommu_domain's iova space is different.
Three mtk_iommu_domains is as below:
1. Normal mtk_iommu_domain exclude 0x4000_0000~0x47ff_ffff and
   0x7da0_0000~7fbf_ffff.
2. CCU mtk_iommu_domain include 0x4000_0000~0x47ff_ffff.
3. VPU mtk_iommu_domain 0x7da0_0000~0x7fbf_ffff.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 45 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c33ea55a1841..882fe01ff770 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -140,6 +140,30 @@ const struct mtk_domain_data single_dom = {
 	.max_iova = DMA_BIT_MASK(32)
 };
 
+/*
+ * related file: mt6779-larb-port.h
+ */
+const struct mtk_domain_data mt6779_multi_dom[] = {
+	/* normal domain */
+	{
+	 .min_iova = 0x0,
+	 .max_iova = DMA_BIT_MASK(32),
+	},
+	/* ccu domain */
+	{
+	 .min_iova = 0x40000000,
+	 .max_iova = 0x48000000 - 1,
+	 .port_mask = {MTK_M4U_ID(9, 21), MTK_M4U_ID(9, 22),
+		       MTK_M4U_ID(12, 0), MTK_M4U_ID(12, 1)}
+	},
+	/* vpu domain */
+	{
+	 .min_iova = 0x7da00000,
+	 .max_iova = 0x7fc00000 - 1,
+	 .port_mask = {MTK_M4U_ID(13, 0)}
+	}
+};
+
 static struct mtk_iommu_pgtable *share_pgtable;
 static const struct iommu_ops mtk_iommu_ops;
 
@@ -1055,6 +1079,21 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
+static const struct mtk_iommu_resv_iova_region mt6779_iommu_rsv_list[] = {
+	{
+		.dom_id = 0,
+		.iova_base = 0x40000000,	/* CCU */
+		.iova_size = 0x8000000,
+		.type = IOMMU_RESV_RESERVED,
+	},
+	{
+		.dom_id = 0,
+		.iova_base = 0x7da00000,	/* VPU/MDLA */
+		.iova_size = 0x2700000,
+		.type = IOMMU_RESV_RESERVED,
+	},
+};
+
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.has_4gb_mode = true,
@@ -1068,8 +1107,10 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat = M4U_MT6779,
-	.dom_cnt = 1,
-	.dom_data = &single_dom,
+	.resv_cnt     = ARRAY_SIZE(mt6779_iommu_rsv_list),
+	.resv_region  = mt6779_iommu_rsv_list,
+	.dom_cnt = ARRAY_SIZE(mt6779_multi_dom),
+	.dom_data = mt6779_multi_dom,
 	.larbid_remap[0] = {0, 1, 2, 3, 5, 7, 10, 9},
 	/* vp6a, vp6b, mdla/core2, mdla/edmc*/
 	.larbid_remap[1] = {2, 0, 3, 1},
-- 
2.18.0

