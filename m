Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0F2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfEGKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfEGKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4361169E;
        Tue,  7 May 2019 03:53:59 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 913713F5AF;
        Tue,  7 May 2019 03:53:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 13/30] coresight: tmc-etr: Rearrange probing default buffer size
Date:   Tue,  7 May 2019 11:52:40 +0100
Message-Id: <1557226378-10131-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to refactor the platform specific handling,
make the default buffer size probing generic.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 3b39f43..9c5e615 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -378,6 +378,15 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
 	return rc;
 }
 
+static u32 tmc_etr_get_default_buffer_size(struct device *dev)
+{
+	u32 size;
+
+	if (fwnode_property_read_u32(dev->fwnode, "arm,buffer-size", &size))
+		size = SZ_1M;
+	return size;
+}
+
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
@@ -423,16 +432,10 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	/* This device is not associated with a session */
 	drvdata->pid = -1;
 
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		if (np)
-			ret = of_property_read_u32(np,
-						   "arm,buffer-size",
-						   &drvdata->size);
-		if (ret)
-			drvdata->size = SZ_1M;
-	} else {
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
+		drvdata->size = tmc_etr_get_default_buffer_size(dev);
+	else
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
-	}
 
 	desc.pdata = pdata;
 	desc.dev = dev;
-- 
2.7.4

