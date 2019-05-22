Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAB0C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A5D217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfEVKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:36:26 -0400
Received: from foss.arm.com ([217.140.101.70]:47158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbfEVKfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9DB169E;
        Wed, 22 May 2019 03:35:48 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CF943F575;
        Wed, 22 May 2019 03:35:47 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 23/30] coresight: Add support for releasing platform specific data
Date:   Wed, 22 May 2019 11:34:56 +0100
Message-Id: <1558521304-27469-24-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to clean up the platform specific data provided
by the firmware. This will be later used for dropping the necessary
references when we switch to the fwnode handles for tracking
connections.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
 drivers/hwtracing/coresight/coresight-priv.h     | 4 ++++
 drivers/hwtracing/coresight/coresight.c          | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index f500de6..53d6eed 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
+#include "coresight-priv.h"
 /*
  * coresight_alloc_conns: Allocate connections record for each output
  * port from the device.
@@ -311,7 +312,7 @@ struct coresight_platform_data *
 coresight_get_platform_data(struct device *dev)
 {
 	int ret = -ENOENT;
-	struct coresight_platform_data *pdata;
+	struct coresight_platform_data *pdata = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
 	if (IS_ERR_OR_NULL(fwnode))
@@ -329,6 +330,9 @@ coresight_get_platform_data(struct device *dev)
 	if (!ret)
 		return pdata;
 error:
+	if (!IS_ERR_OR_NULL(pdata))
+		/* Cleanup the connection information */
+		coresight_release_platform_data(pdata);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_get_platform_data);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index e0684d0..c216421 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -200,4 +200,8 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 	return 0;
 }
 
+static inline void
+coresight_release_platform_data(struct coresight_platform_data *pdata)
+{}
+
 #endif
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 96e1515..526141c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1250,6 +1250,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 err_free_csdev:
 	kfree(csdev);
 err_out:
+	/* Cleanup the connection information */
+	coresight_release_platform_data(desc->pdata);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_register);
@@ -1259,6 +1261,7 @@ void coresight_unregister(struct coresight_device *csdev)
 	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
+	coresight_release_platform_data(csdev->pdata);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.7.4

