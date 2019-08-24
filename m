Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F53C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222D221670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHXDnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:43:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47399 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfHXDnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:43:46 -0400
X-UUID: b524c2d1ea66414fbdd0593ba5b415af-20190824
X-UUID: b524c2d1ea66414fbdd0593ba5b415af-20190824
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 127861977; Sat, 24 Aug 2019 11:04:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 24 Aug 2019 11:04:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 24 Aug 2019 11:04:08 +0800
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
Subject: [PATCH v11 08/23] iommu/io-pgtable-arm-v7s: Rename the quirk from MTK_4GB to MTK_EXT
Date:   Sat, 24 Aug 2019 11:01:53 +0800
Message-ID: <1566615728-26388-9-git-send-email-yong.wu@mediatek.com>
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

In previous mt2712/mt8173, MediaTek extend the v7s to support 4GB dram.
But in the latest mt8183, We extend it to support the PA up to 34bit.
Then the "MTK_4GB" name is not so fit, This patch only change the quirk
name to "MTK_EXT".

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 6 +++---
 drivers/iommu/mtk_iommu.c          | 2 +-
 include/linux/io-pgtable.h         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index fa1b38f..77cc1eb 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -315,7 +315,7 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 	if (lvl == 1 && (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS))
 		pte |= ARM_V7S_ATTR_NS_SECTION;
 
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB)
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)
 		pte |= ARM_V7S_ATTR_MTK_4GB;
 
 	return pte;
@@ -737,12 +737,12 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
 			    IO_PGTABLE_QUIRK_NO_PERMS |
 			    IO_PGTABLE_QUIRK_TLBI_ON_MAP |
-			    IO_PGTABLE_QUIRK_ARM_MTK_4GB |
+			    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
 			    IO_PGTABLE_QUIRK_NON_STRICT))
 		return NULL;
 
 	/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_4GB &&
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT &&
 	    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
 			return NULL;
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 9ba2706..62edce7 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -296,7 +296,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom)
 	};
 
 	if (data->enable_4GB)
-		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_4GB;
+		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_EXT;
 
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index b5a450a..915fb73 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -65,7 +65,7 @@ struct io_pgtable_cfg {
 	 *	(unmapped) entries but the hardware might do so anyway, perform
 	 *	TLB maintenance when mapping as well as when unmapping.
 	 *
-	 * IO_PGTABLE_QUIRK_ARM_MTK_4GB: (ARM v7s format) Set bit 9 in all
+	 * IO_PGTABLE_QUIRK_ARM_MTK_EXT: (ARM v7s format) Set bit 9 in all
 	 *	PTEs, for Mediatek IOMMUs which treat it as a 33rd address bit
 	 *	when the SoC is in "4GB mode" and they can only access the high
 	 *	remap of DRAM (0x1_00000000 to 0x1_ffffffff).
@@ -77,7 +77,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
-	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
+	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
-- 
1.9.1

