Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BEFC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547182184E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfHJH7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:59:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58567 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfHJH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:59:30 -0400
X-UUID: 2ec595618b4e4f84a589d2603ba72c0f-20190810
X-UUID: 2ec595618b4e4f84a589d2603ba72c0f-20190810
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1834652786; Sat, 10 Aug 2019 15:59:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 10 Aug 2019 15:59:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 10 Aug 2019 15:59:20 +0800
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
Subject: [PATCH v9 03/21] memory: mtk-smi: Use a general config_port interface
Date:   Sat, 10 Aug 2019 15:58:03 +0800
Message-ID: <1565423901-17008-4-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config_port of mt2712 and mt8183 are the same. Use a general
config_port interface instead.

In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
are not the normal larb, their register space are different from the
normal one. thus, we can not call the general config_port. In mt8183,
IPU0/1 and CCU connect with smi-common directly, they also are not
the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
larbs which connect to smi-commmon directly.

This is also a preparing patch for adding mt8183 SMI support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/memory/mtk-smi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 42ab43a..14f70cf 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -45,6 +45,7 @@ struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
+	unsigned int			larb_direct_to_common_mask;
 };
 
 struct mtk_smi {
@@ -168,17 +169,13 @@ void mtk_smi_larb_put(struct device *larbdev)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port_mt2712(struct device *dev)
+static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 	u32 reg;
 	int i;
 
-	/*
-	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
-	 * Don't need to set it again.
-	 */
-	if (larb->larbid == 8 || larb->larbid == 9)
+	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
 		return;
 
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
@@ -253,7 +250,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
 	.need_larbid = true,
-	.config_port = mtk_smi_larb_config_port_mt2712,
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.larb_direct_to_common_mask = BIT(8) | BIT(9),      /* bdpsys */
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
1.9.1

