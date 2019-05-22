Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E390DC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E64217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfEVKft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:35:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbfEVKfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7071684;
        Wed, 22 May 2019 03:35:44 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC1B3F575;
        Wed, 22 May 2019 03:35:43 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 20/30] coresight: Cleanup coresight_remove_conns
Date:   Wed, 22 May 2019 11:34:53 +0100
Message-Id: <1558521304-27469-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device is unregistered, we remove all connection
references to it, by searching the connection records of
all devices in the coresight bus, via coresight_remove_conns.
We could avoid searching if this device doesn't have an input
port (e.g, a source). Also document the purpose of the function.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 04b5d3c..068bd2f 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1096,10 +1096,21 @@ static int coresight_remove_match(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * coresight_remove_conns - Remove references to this given devices
+ * from the connections of other devices.
+ */
 static void coresight_remove_conns(struct coresight_device *csdev)
 {
-	bus_for_each_dev(&coresight_bustype, NULL,
-			 csdev, coresight_remove_match);
+	/*
+	 * Another device will point to this device only if there is
+	 * an output port connected to this one. i.e, if the device
+	 * doesn't have at least one input port, there is no point
+	 * in searching all the devices.
+	 */
+	if (csdev->nr_inport)
+		bus_for_each_dev(&coresight_bustype, NULL,
+				 csdev, coresight_remove_match);
 }
 
 /**
-- 
2.7.4

