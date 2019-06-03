Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D227930
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfFCPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:21 -0400
Received: from foss.arm.com ([217.140.101.70]:54082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbfFCPwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3ACF15AB;
        Mon,  3 Jun 2019 08:52:18 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 877233F246;
        Mon,  3 Jun 2019 08:52:17 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH 52/57] drivers: tegra: Use driver_find_device_by_of_node() helper
Date:   Mon,  3 Jun 2019 16:50:18 +0100
Message-Id: <1559577023-558-53-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using the new helper driver_find_device_by_of_node().

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/amba/tegra-ahb.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 42175a6..5ce0f66 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -143,22 +143,13 @@ static inline void gizmo_writel(struct tegra_ahb *ahb, u32 value, u32 offset)
 }
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
-static int tegra_ahb_match_by_smmu(struct device *dev, const void *data)
-{
-	struct tegra_ahb *ahb = dev_get_drvdata(dev);
-	const struct device_node *dn = data;
-
-	return (ahb->dev->of_node == dn) ? 1 : 0;
-}
-
 int tegra_ahb_enable_smmu(struct device_node *dn)
 {
 	struct device *dev;
 	u32 val;
 	struct tegra_ahb *ahb;
 
-	dev = driver_find_device(&tegra_ahb_driver.driver, NULL, dn,
-				 tegra_ahb_match_by_smmu);
+	dev = driver_find_device_by_of_node(&tegra_ahb_driver.driver, NULL, dn);
 	if (!dev)
 		return -EPROBE_DEFER;
 	ahb = dev_get_drvdata(dev);
-- 
2.7.4

