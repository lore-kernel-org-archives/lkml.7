Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21095C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F151D21655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443293AbfIYSoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:44:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40260 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443246AbfIYSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:44:04 -0400
Received: from muedsl-82-207-238-254.citykom.de ([82.207.238.254] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iDCGZ-0005Fa-At; Wed, 25 Sep 2019 20:43:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] iommu/rockchip: don't use platform_get_irq to implicitly count irqs
Date:   Wed, 25 Sep 2019 20:43:46 +0200
Message-Id: <20190925184346.14121-1-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till now the Rockchip iommu driver walked through the irq list via
platform_get_irq() until it encountered an ENXIO error. With the
recent change to add a central error message, this always results
in such an error for each iommu on probe and shutdown.

To not confuse people, switch to platform_count_irqs() to get the
actual number of interrupts before walking through them.

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iommu/rockchip-iommu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 26290f310f90..4dcbf68dfda4 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -100,6 +100,7 @@ struct rk_iommu {
 	struct device *dev;
 	void __iomem **bases;
 	int num_mmu;
+	int num_irq;
 	struct clk_bulk_data *clocks;
 	int num_clocks;
 	bool reset_disabled;
@@ -1136,7 +1137,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	struct rk_iommu *iommu;
 	struct resource *res;
 	int num_res = pdev->num_resources;
-	int err, i, irq;
+	int err, i;
 
 	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -1163,6 +1164,10 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
+	iommu->num_irq = platform_irq_count(pdev);
+	if (iommu->num_irq < 0)
+		return iommu->num_irq;
+
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
@@ -1219,8 +1224,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+	for (i = 0; i < iommu->num_irq; i++) {
+		int irq = platform_get_irq(pdev, i);
+
 		if (irq < 0)
 			return irq;
 
@@ -1245,10 +1251,13 @@ static int rk_iommu_probe(struct platform_device *pdev)
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
 	struct rk_iommu *iommu = platform_get_drvdata(pdev);
-	int i = 0, irq;
+	int i;
+
+	for (i = 0; i < iommu->num_irq; i++) {
+		int irq = platform_get_irq(pdev, i);
 
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
 		devm_free_irq(iommu->dev, irq, iommu);
+	}
 
 	pm_runtime_force_suspend(&pdev->dev);
 }
-- 
2.23.0

