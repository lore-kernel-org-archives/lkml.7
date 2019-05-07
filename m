Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C17C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8921479
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfEGKyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50202 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfEGKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40603374;
        Tue,  7 May 2019 03:54:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D0653F5AF;
        Tue,  7 May 2019 03:53:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 14/30] coresight: platform: Make memory allocation helper generic
Date:   Tue,  7 May 2019 11:52:41 +0100
Message-Id: <1557226378-10131-15-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the of_coresight_alloc_memory() => coresight_alloc_conns()
as it is independent of the underlying firmware type. This is in
preparation for the ACPI support.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 34 +++++++++++++-----------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 514cc2b..4c31299 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -17,6 +17,24 @@
 #include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
+/*
+ * coresight_alloc_conns: Allocate connections record for each output
+ * port from the device.
+ */
+static int coresight_alloc_conns(struct device *dev,
+				 struct coresight_platform_data *pdata)
+{
+	if (pdata->nr_outport) {
+		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
+					    sizeof(*pdata->conns),
+					    GFP_KERNEL);
+		if (!pdata->conns)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static int of_dev_node_match(struct device *dev, void *data)
 {
@@ -133,20 +151,6 @@ static void of_coresight_get_ports(const struct device_node *node,
 	}
 }
 
-static int of_coresight_alloc_memory(struct device *dev,
-			struct coresight_platform_data *pdata)
-{
-	if (pdata->nr_outport) {
-		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
-					    sizeof(*pdata->conns),
-					    GFP_KERNEL);
-		if (!pdata->conns)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 int of_coresight_get_cpu(const struct device_node *node)
 {
 	int cpu;
@@ -252,7 +256,7 @@ of_get_coresight_platform_data(struct device *dev,
 	if (!pdata->nr_outport)
 		return pdata;
 
-	ret = of_coresight_alloc_memory(dev, pdata);
+	ret = coresight_alloc_conns(dev, pdata);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.7.4

