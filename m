Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FB9233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfHUN5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:57:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13787 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729018AbfHUN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:57:31 -0400
X-UUID: 5a3e935a700448efb4b85f43047ad900-20190821
X-UUID: 5a3e935a700448efb4b85f43047ad900-20190821
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 533225588; Wed, 21 Aug 2019 21:57:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 21:57:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 21:57:20 +0800
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
Subject: [PATCH v10 21/23] iommu/mediatek: Fix VLD_PA_RNG register backup when suspend
Date:   Wed, 21 Aug 2019 21:53:24 +0800
Message-ID: <1566395606-7975-22-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
mode support for mt2712. this patch add it.

Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
for 4GB mode")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 drivers/iommu/mtk_iommu.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 470de8b..5d5341c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -742,6 +742,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
 	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
 	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
+	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
 	clk_disable_unprepare(data->bclk);
 	return 0;
 }
@@ -766,6 +767,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
+	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
 	if (m4u_dom)
 		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
 		       base + REG_MMU_PT_BASE_ADDR);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 6b1f833..56b579c 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -24,6 +24,7 @@ struct mtk_iommu_suspend_reg {
 	u32				int_control0;
 	u32				int_main_control;
 	u32				ivrp_paddr;
+	u32				vld_pa_rng;
 };
 
 enum mtk_iommu_plat {
-- 
1.9.1

