Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A92C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45BC20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDCSVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:21:54 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:40292 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:21:53 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id vuMq1z00G3XaVaC01uMqW0; Wed, 03 Apr 2019 20:21:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-00057q-Gp; Wed, 03 Apr 2019 20:21:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hBkWE-0004iL-FR; Wed, 03 Apr 2019 20:21:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date:   Wed,  3 Apr 2019 20:21:43 +0200
Message-Id: <20190403182148.18058-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403182148.18058-1-geert+renesas@glider.be>
References: <20190403182148.18058-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
/sys/class/iommus/, but their "devices" subdirectories are empty.
Likewise, devices tied to an IOMMU do not have an "iommu" backlink.

Make sure all links are created, on both arm32 and arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9a380c10655e182d..9f2b781e20a0eba6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 
 static int ipmmu_add_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
+	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_ipmmu(dev))
+	if (!mmu)
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
-		return ipmmu_init_arm_mapping(dev);
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
+		ret = ipmmu_init_arm_mapping(dev);
+		if (ret)
+			return ret;
+	} else {
+		group = iommu_group_get_for_dev(dev);
+		if (IS_ERR(group))
+			return PTR_ERR(group);
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+		iommu_group_put(group);
+	}
 
-	iommu_group_put(group);
+	iommu_device_link(&mmu->iommu, dev);
 	return 0;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+
+	iommu_device_unlink(&mmu->iommu, dev);
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 }
-- 
2.17.1

