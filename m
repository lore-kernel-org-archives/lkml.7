Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A619C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102CA2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfHXDUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:20:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29403 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbfHXDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:20:36 -0400
X-UUID: 5980f0ff7aee4924b961c52936f8e85d-20190824
X-UUID: 5980f0ff7aee4924b961c52936f8e85d-20190824
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1999369357; Sat, 24 Aug 2019 11:06:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 24 Aug 2019 11:06:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 24 Aug 2019 11:06:15 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v11 18/23] iommu/mediatek: Add mmu1 support
Date:   Sat, 24 Aug 2019 11:02:03 +0800
Message-ID: <1566615728-26388-19-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
References: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the M4U HW connect EMI with smi. the diagram is like below:
              EMI
               |
              M4U
               |
            smi-common
               |
       -----------------
       |    |    |     |    ...
    larb0 larb1  larb2 larb3

Actually there are 2 mmu cells in the M4U HW, like this diagram:

              EMI
           ---------
            |     |
           mmu0  mmu1     <- M4U
            |     |
           ---------
               |
            smi-common
               |
       -----------------
       |    |    |     |    ...
    larb0 larb1  larb2 larb3

This patch add support for mmu1. In order to get better performance,
we could adjust some larbs go to mmu1 while the others still go to
mmu0. This is controlled by a SMI COMMON register SMI_BUS_SEL(0x220).

mt2712, mt8173 and mt8183 M4U HW all have 2 mmu cells. the default
value of that register is 0 which means all the larbs go to mmu0
defaultly.

This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ee3a664..470de8b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -64,26 +64,32 @@
 #define F_INT_CLR_BIT				BIT(12)
 
 #define REG_MMU_INT_MAIN_CONTROL		0x124
-#define F_INT_TRANSLATION_FAULT			BIT(0)
-#define F_INT_MAIN_MULTI_HIT_FAULT		BIT(1)
-#define F_INT_INVALID_PA_FAULT			BIT(2)
-#define F_INT_ENTRY_REPLACEMENT_FAULT		BIT(3)
-#define F_INT_TLB_MISS_FAULT			BIT(4)
-#define F_INT_MISS_TRANSACTION_FIFO_FAULT	BIT(5)
-#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT	BIT(6)
+						/* mmu0 | mmu1 */
+#define F_INT_TRANSLATION_FAULT			(BIT(0) | BIT(7))
+#define F_INT_MAIN_MULTI_HIT_FAULT		(BIT(1) | BIT(8))
+#define F_INT_INVALID_PA_FAULT			(BIT(2) | BIT(9))
+#define F_INT_ENTRY_REPLACEMENT_FAULT		(BIT(3) | BIT(10))
+#define F_INT_TLB_MISS_FAULT			(BIT(4) | BIT(11))
+#define F_INT_MISS_TRANSACTION_FIFO_FAULT	(BIT(5) | BIT(12))
+#define F_INT_PRETETCH_TRANSATION_FIFO_FAULT	(BIT(6) | BIT(13))
 
 #define REG_MMU_CPE_DONE			0x12C
 
 #define REG_MMU_FAULT_ST1			0x134
+#define F_REG_MMU0_FAULT_MASK			GENMASK(6, 0)
+#define F_REG_MMU1_FAULT_MASK			GENMASK(13, 7)
 
-#define REG_MMU_FAULT_VA			0x13c
+#define REG_MMU0_FAULT_VA			0x13c
 #define F_MMU_FAULT_VA_WRITE_BIT		BIT(1)
 #define F_MMU_FAULT_VA_LAYER_BIT		BIT(0)
 
-#define REG_MMU_INVLD_PA			0x140
-#define REG_MMU_INT_ID				0x150
-#define F_MMU0_INT_ID_LARB_ID(a)		(((a) >> 7) & 0x7)
-#define F_MMU0_INT_ID_PORT_ID(a)		(((a) >> 2) & 0x1f)
+#define REG_MMU0_INVLD_PA			0x140
+#define REG_MMU1_FAULT_VA			0x144
+#define REG_MMU1_INVLD_PA			0x148
+#define REG_MMU0_INT_ID				0x150
+#define REG_MMU1_INT_ID				0x154
+#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
+#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
 #define MTK_PROTECT_PA_ALIGN			128
 
@@ -226,13 +232,19 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 
 	/* Read error info from registers */
 	int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
-	fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
+	if (int_state & F_REG_MMU0_FAULT_MASK) {
+		regval = readl_relaxed(data->base + REG_MMU0_INT_ID);
+		fault_iova = readl_relaxed(data->base + REG_MMU0_FAULT_VA);
+		fault_pa = readl_relaxed(data->base + REG_MMU0_INVLD_PA);
+	} else {
+		regval = readl_relaxed(data->base + REG_MMU1_INT_ID);
+		fault_iova = readl_relaxed(data->base + REG_MMU1_FAULT_VA);
+		fault_pa = readl_relaxed(data->base + REG_MMU1_INVLD_PA);
+	}
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
-	regval = readl_relaxed(data->base + REG_MMU_INT_ID);
-	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
-	fault_port = F_MMU0_INT_ID_PORT_ID(regval);
+	fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+	fault_port = F_MMU_INT_ID_PORT_ID(regval);
 
 	fault_larb = data->plat_data->larbid_remap[fault_larb];
 
-- 
1.9.1

