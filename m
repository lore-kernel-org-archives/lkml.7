Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C68C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3B22184E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfEVKfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:35:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbfEVKfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8DA1341;
        Wed, 22 May 2019 03:35:29 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B96EA3F575;
        Wed, 22 May 2019 03:35:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 09/30] coresight: Use coresight device names for sinks in PMU attribute
Date:   Wed, 22 May 2019 11:34:42 +0100
Message-Id: <1558521304-27469-10-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Move to using the coresight device name instead of the parent
device name for SINK attribute for PMU.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 3c62944..5c1ca0d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -523,7 +523,7 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
 	unsigned long hash;
 	const char *name;
 	struct device *pmu_dev = etm_pmu.dev;
-	struct device *pdev = csdev->dev.parent;
+	struct device *dev = &csdev->dev;
 	struct dev_ext_attribute *ea;
 
 	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
@@ -536,15 +536,15 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
 	if (!etm_perf_up)
 		return -EPROBE_DEFER;
 
-	ea = devm_kzalloc(pdev, sizeof(*ea), GFP_KERNEL);
+	ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
 	if (!ea)
 		return -ENOMEM;
 
-	name = dev_name(pdev);
+	name = dev_name(dev);
 	/* See function coresight_get_sink_by_id() to know where this is used */
 	hash = hashlen_hash(hashlen_string(NULL, name));
 
-	ea->attr.attr.name = devm_kstrdup(pdev, name, GFP_KERNEL);
+	ea->attr.attr.name = devm_kstrdup(dev, name, GFP_KERNEL);
 	if (!ea->attr.attr.name)
 		return -ENOMEM;
 
-- 
2.7.4

