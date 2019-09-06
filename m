Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C777C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8BC206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394492AbfIFOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:37:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48418 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731943AbfIFOhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:37:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B1A9020FA3D796D7425A;
        Fri,  6 Sep 2019 22:37:16 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:37:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <zhangshaokun@hisilicon.com>, <will.deacon@arm.com>,
        <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf: hisi: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 6 Sep 2019 22:36:44 +0800
Message-ID: <20190906143644.23036-1-yuehaibing@huawei.com>
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
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 5 +----
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 4 +---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 4 +---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index e42d446..453f1c6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -243,8 +243,6 @@ MODULE_DEVICE_TABLE(acpi, hisi_ddrc_pmu_acpi_match);
 static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
 				   struct hisi_pmu *ddrc_pmu)
 {
-	struct resource *res;
-
 	/*
 	 * Use the SCCL_ID and DDRC channel ID to identify the
 	 * DDRC PMU, while SCCL_ID is in MPIDR[aff2].
@@ -263,8 +261,7 @@ static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
 	/* DDRC PMUs only share the same SCCL */
 	ddrc_pmu->ccl_id = -1;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddrc_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	ddrc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddrc_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for ddrc_pmu resource\n");
 		return PTR_ERR(ddrc_pmu->base);
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index f280638..6a1dd72 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -234,7 +234,6 @@ static int hisi_hha_pmu_init_data(struct platform_device *pdev,
 				  struct hisi_pmu *hha_pmu)
 {
 	unsigned long long id;
-	struct resource *res;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
@@ -256,8 +255,7 @@ static int hisi_hha_pmu_init_data(struct platform_device *pdev,
 	/* HHA PMUs only share the same SCCL */
 	hha_pmu->ccl_id = -1;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hha_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	hha_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hha_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for hha_pmu resource\n");
 		return PTR_ERR(hha_pmu->base);
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 078b8dc..1151e99 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -233,7 +233,6 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 				  struct hisi_pmu *l3c_pmu)
 {
 	unsigned long long id;
-	struct resource *res;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev),
@@ -259,8 +258,7 @@ static int hisi_l3c_pmu_init_data(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	l3c_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	l3c_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(l3c_pmu->base)) {
 		dev_err(&pdev->dev, "ioremap failed for l3c_pmu resource\n");
 		return PTR_ERR(l3c_pmu->base);
-- 
2.7.4


