Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B444121873
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfDOQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:08:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfDOQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB3CF1A25;
        Mon, 15 Apr 2019 09:06:14 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31BFD3F68F;
        Mon, 15 Apr 2019 09:06:13 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 17/36] coresight: tmc-etr: Rearrange probing default buffer size
Date:   Mon, 15 Apr 2019 17:04:00 +0100
Message-Id: <1555344260-12375-18-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to refactor the platform specific handling,
make the default buffer size probing generic.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 819873a..c470b81 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -376,6 +376,15 @@ static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
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
@@ -419,16 +428,10 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->config_type = BMVAL(devid, 6, 7);
 	drvdata->memwidth = tmc_get_memwidth(devid);
 
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

