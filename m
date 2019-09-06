Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D692C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF48420842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405535AbfIFOkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:40:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51466 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727481AbfIFOkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:40:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 086BA58B86854A1F6124;
        Fri,  6 Sep 2019 22:40:31 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 22:40:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf/arm-cci: use devm_platform_ioremap_resource() to simplify code
Date:   Fri, 6 Sep 2019 22:40:14 +0800
Message-ID: <20190906144014.27924-1-yuehaibing@huawei.com>
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
 drivers/perf/arm-cci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 8f8606b..1b8e337 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1642,7 +1642,6 @@ static struct cci_pmu *cci_pmu_alloc(struct device *dev)
 
 static int cci_pmu_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct cci_pmu *cci_pmu;
 	int i, ret, irq;
 
@@ -1650,8 +1649,7 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	if (IS_ERR(cci_pmu))
 		return PTR_ERR(cci_pmu);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cci_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	cci_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cci_pmu->base))
 		return -ENOMEM;
 
-- 
2.7.4


