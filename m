Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E26CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E78B206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394520AbfIFOjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:39:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389288AbfIFOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:39:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD6AEA71A989DDBF8958;
        Fri,  6 Sep 2019 22:39:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:38:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf/smmuv3: gpio: creg-snps: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 6 Sep 2019 22:38:44 +0800
Message-ID: <20190906143844.27956-1-yuehaibing@huawei.com>
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
 drivers/perf/arm_smmuv3_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index abcf54f..773128f 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -727,7 +727,7 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
-	struct resource *res_0, *res_1;
+	struct resource *res_0;
 	u32 cfgr, reg_size;
 	u64 ceid_64[2];
 	int irq, err;
@@ -764,8 +764,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		smmu_pmu->reloc_base = devm_ioremap_resource(dev, res_1);
+		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(smmu_pmu->reloc_base))
 			return PTR_ERR(smmu_pmu->reloc_base);
 	} else {
-- 
2.7.4


