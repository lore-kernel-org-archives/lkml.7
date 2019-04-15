Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6121873
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfDOQFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:05:52 -0400
Received: from foss.arm.com ([217.140.101.70]:37670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfDOQFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:05:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2DDDA78;
        Mon, 15 Apr 2019 09:05:49 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 602993F68F;
        Mon, 15 Apr 2019 09:05:48 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 03/36] coresight: tpiu: Cleanup power management
Date:   Mon, 15 Apr 2019 17:03:46 +0100
Message-Id: <1555344260-12375-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the power only when we have successfully probed. Otherwise
leave it to the amba probe to do the rest.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1..4977467 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -153,7 +153,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	/* Disable tpiu to support older devices */
 	tpiu_disable_hw(drvdata);
 
-	pm_runtime_put(&adev->dev);
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PORT;
@@ -162,7 +161,12 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	if (!IS_ERR(drvdata->csdev)) {
+		pm_runtime_put(&adev->dev);
+		return 0;
+	}
+
+	return PTR_ERR(drvdata->csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4

