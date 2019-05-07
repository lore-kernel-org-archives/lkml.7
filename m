Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A70FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D222087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEGKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50242 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfEGKyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB9B1682;
        Tue,  7 May 2019 03:54:07 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AE423F5AF;
        Tue,  7 May 2019 03:54:05 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 18/30] coresight: Remove cpu field from platform data
Date:   Tue,  7 May 2019 11:52:45 +0100
Message-Id: <1557226378-10131-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU field is only used by ETMs and there is a separate API
for fetching the same. So, let us use that instead of using
the common platform probing helper. Also, remove it from the
platform_data.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x.c    | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x.c    | 2 +-
 drivers/hwtracing/coresight/coresight-platform.c | 1 -
 include/linux/coresight.h                        | 2 --
 4 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fa2164f..722fab96 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -819,7 +819,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 			return ret;
 	}
 
-	drvdata->cpu = pdata ? pdata->cpu : 0;
+	drvdata->cpu = coresight_get_cpu(dev);
 
 	cpus_read_lock();
 	etmdrvdata[drvdata->cpu] = drvdata;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4355b2e..03576f3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1105,7 +1105,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->cpu = pdata ? pdata->cpu : 0;
+	drvdata->cpu = coresight_get_cpu(dev);
 
 	cpus_read_lock();
 	etmdrvdata[drvdata->cpu] = drvdata;
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index ba8c146..541e500 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -325,7 +325,6 @@ coresight_get_platform_data(struct device *dev)
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
-	pdata->cpu = coresight_get_cpu(dev);
 
 	if (is_of_node(fwnode))
 		ret = of_get_coresight_platform_data(dev, pdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 98a4440..bf241db 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -91,14 +91,12 @@ union coresight_dev_subtype {
 
 /**
  * struct coresight_platform_data - data harvested from the DT specification
- * @cpu:	the CPU a source belongs to. Only applicable for ETM/PTMs.
  * @name:	name of the component as shown under sysfs.
  * @nr_inport:	number of input ports for this component.
  * @nr_outport:	number of output ports for this component.
  * @conns:	Array of nr_outport connections from this component
  */
 struct coresight_platform_data {
-	int cpu;
 	const char *name;
 	int nr_inport;
 	int nr_outport;
-- 
2.7.4

