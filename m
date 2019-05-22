Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6108DC193F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F282184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfEVKfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:35:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfEVKff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AF12165C;
        Wed, 22 May 2019 03:35:35 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B3743F575;
        Wed, 22 May 2019 03:35:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 13/30] coresight: tmc-etr: Rearrange probing default buffer size
Date:   Wed, 22 May 2019 11:34:46 +0100
Message-Id: <1558521304-27469-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
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

