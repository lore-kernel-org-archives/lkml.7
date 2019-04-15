Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0AC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FD220880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfDOQFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:05:55 -0400
Received: from foss.arm.com ([217.140.101.70]:37704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfDOQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B692A78;
        Mon, 15 Apr 2019 09:05:53 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECA6A3F68F;
        Mon, 15 Apr 2019 09:05:51 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 05/36] coresight: tmc: Cleanup power management
Date:   Mon, 15 Apr 2019 17:03:48 +0100
Message-Id: <1555344260-12375-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the power only if we were successful in probing the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 647b6aa..c6a5462 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -432,8 +432,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
-	pm_runtime_put(&adev->dev);
-
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
@@ -476,6 +474,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	ret = misc_register(&drvdata->miscdev);
 	if (ret)
 		coresight_unregister(drvdata->csdev);
+	else
+		pm_runtime_put(&adev->dev);
 out:
 	return ret;
 }
-- 
2.7.4

