Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D750CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18444222D0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfJ1I3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:29:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8023 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731824AbfJ1I3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:29:05 -0400
X-UUID: 5cf853185f3343b2900ae2ba9dbdf640-20191028
X-UUID: 5cf853185f3343b2900ae2ba9dbdf640-20191028
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 149267148; Mon, 28 Oct 2019 16:29:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:59 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:56 +0800
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
Subject: [PATCH 09/13] iommu/mediatek: Remove the usage of m4u_dom variable
Date:   Mon, 28 Oct 2019 16:28:16 +0800
Message-ID: <20191028082820.20221-10-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191028082820.20221-1-chao.hao@mediatek.com>
References: <20191028082820.20221-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E6DAAF6F1FB7DC544D8AF43EAB395DA4814A94CC3C392803A32AA6AF3A38C33B2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will remove the usage of the m4u_dom variable.

We have already redefined mtk_iommu_domain structure and it
includes iommu_domain, so m4u_dom variable will not be used.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8d68a1af8ed5..42fad1cf73f3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -113,6 +113,7 @@
  * Get the local arbiter ID and the portid within the larb arbiter
  * from mtk_m4u_id which is defined by MTK_M4U_ID.
  */
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
 #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
@@ -205,6 +206,22 @@ static u32 mtk_iommu_get_domain_id(struct device *dev)
 	return get_domain_id(data, portid);
 }
 
+static struct iommu_domain *_get_mtk_domain(struct mtk_iommu_data *data,
+					    u32 larbid, u32 portid)
+{
+	u32 domain_id;
+	u32 port_mask = MTK_M4U_ID(larbid, portid);
+	struct mtk_iommu_domain *dom;
+
+	domain_id = get_domain_id(data, port_mask);
+
+	list_for_each_entry(dom, &data->pgtable->m4u_dom_v2, list) {
+		if (dom->id == domain_id)
+			return &dom->domain;
+	}
+	return NULL;
+}
+
 static struct mtk_iommu_domain *get_mtk_domain(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev->iommu_fwspec->iommu_priv;
@@ -307,7 +324,7 @@ static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
 	struct mtk_iommu_data *data = dev_id;
-	struct mtk_iommu_domain *dom = data->m4u_dom;
+	struct iommu_domain *domain;
 	u32 int_state, regval, fault_iova, fault_pa;
 	unsigned int fault_larb, fault_port, sub_comm = 0;
 	bool layer, write;
@@ -342,7 +359,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 
 	fault_larb = data->plat_data->larbid_remap[data->m4u_id][fault_larb];
 
-	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
+	domain = _get_mtk_domain(data, fault_larb, fault_port);
+	if (report_iommu_fault(domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			data->dev,
@@ -512,16 +530,11 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
 static int mtk_iommu_attach_device(struct iommu_domain *domain,
 				   struct device *dev)
 {
-	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
 
 	if (!data)
 		return -ENODEV;
 
-	/* Update the pgtable base address register of the M4U HW */
-	if (!data->m4u_dom)
-		data->m4u_dom = dom;
-
 	mtk_iommu_config(data, dev, true);
 	return 0;
 }
-- 
2.18.0

