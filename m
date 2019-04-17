Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7337C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CD620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfDQClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:41:05 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:53484 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfDQClE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:41:04 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id F29EDF06712163835CA3;
        Wed, 17 Apr 2019 10:40:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2ejda060299;
        Wed, 17 Apr 2019 10:40:45 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710410560-8909552 ;
          Wed, 17 Apr 2019 10:41:05 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] iommu/mediatek: fix leaked of_node references
Date:   Wed, 17 Apr 2019 10:41:19 +0800
Message-Id: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:41:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:40:37,
        Serialize complete at 2019-04-17 10:40:37
X-MAIL: mse01.zte.com.cn x3H2ejda060299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

581 static int mtk_iommu_probe(struct platform_device *pdev)
582 {
    ...
626         for (i = 0; i < larb_nr; i++) {
627                 struct device_node *larbnode;
    ...
631                 larbnode = of_parse_phandle(...);
632                 if (!larbnode)
633                         return -EINVAL;
634
635                 if (!of_device_is_available(larbnode))
636                         continue;             ---> leaked here
637
    ...
643                 if (!plarbdev)
644                         return -EPROBE_DEFER; ---> leaked here
    ...
647                 component_match_add_release(dev, &match, release_of,
648                                             compare_of, larbnode);
                                   ---> release_of will call of_node_put
649         }
    ...
650

Detected by coccinelle with the following warnings:
./drivers/iommu/mtk_iommu.c:644:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 631, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/mtk_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de3e022..b66d11b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -632,16 +632,20 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		if (!larbnode)
 			return -EINVAL;
 
-		if (!of_device_is_available(larbnode))
+		if (!of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
 			continue;
+		}
 
 		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
 		if (ret)/* The id is consecutive if there is no this property */
 			id = i;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev)
+		if (!plarbdev) {
+			of_node_put(larbnode);
 			return -EPROBE_DEFER;
+		}
 		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
-- 
2.9.5

