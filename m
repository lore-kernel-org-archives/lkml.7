Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FC8206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394511AbfIFOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:38:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731943AbfIFOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:38:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0F2ECCB4E4E46042EED;
        Fri,  6 Sep 2019 22:38:02 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:37:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <khuong@os.amperecomputing.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf: xgene: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 6 Sep 2019 22:37:35 +0800
Message-ID: <20190906143735.28272-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/perf/xgene_pmu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 7e328d6..46ee680 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1282,25 +1282,21 @@ static int acpi_pmu_probe_active_mcb_mcu_l3c(struct xgene_pmu *xgene_pmu,
 					     struct platform_device *pdev)
 {
 	void __iomem *csw_csr, *mcba_csr, *mcbb_csr;
-	struct resource *res;
 	unsigned int reg;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	csw_csr = devm_ioremap_resource(&pdev->dev, res);
+	csw_csr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(csw_csr)) {
 		dev_err(&pdev->dev, "ioremap failed for CSW CSR resource\n");
 		return PTR_ERR(csw_csr);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	mcba_csr = devm_ioremap_resource(&pdev->dev, res);
+	mcba_csr = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(mcba_csr)) {
 		dev_err(&pdev->dev, "ioremap failed for MCBA CSR resource\n");
 		return PTR_ERR(mcba_csr);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	mcbb_csr = devm_ioremap_resource(&pdev->dev, res);
+	mcbb_csr = devm_platform_ioremap_resource(pdev, 3);
 	if (IS_ERR(mcbb_csr)) {
 		dev_err(&pdev->dev, "ioremap failed for MCBB CSR resource\n");
 		return PTR_ERR(mcbb_csr);
@@ -1332,13 +1328,11 @@ static int acpi_pmu_v3_probe_active_mcb_mcu_l3c(struct xgene_pmu *xgene_pmu,
 						struct platform_device *pdev)
 {
 	void __iomem *csw_csr;
-	struct resource *res;
 	unsigned int reg;
 	u32 mcb0routing;
 	u32 mcb1routing;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	csw_csr = devm_ioremap_resource(&pdev->dev, res);
+	csw_csr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(csw_csr)) {
 		dev_err(&pdev->dev, "ioremap failed for CSW CSR resource\n");
 		return PTR_ERR(csw_csr);
-- 
2.7.4


