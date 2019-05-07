Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E406CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5FC2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfEGKx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:53:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50150 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfEGKxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:53:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1EF15AD;
        Tue,  7 May 2019 03:53:55 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C1EF3F5AF;
        Tue,  7 May 2019 03:53:54 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 10/30] coresight: Rename of_coresight to coresight-platform
Date:   Tue,  7 May 2019 11:52:37 +0100
Message-Id: <1557226378-10131-11-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the firmware handling file to a more generic
name, in preparation for adding ACPI support. Right now
we only support DT and we have all the platform handling
code in of_coresight.c. Let us rename the file to
coresight-platform.c in order to keep the platform handling
in a single place for DT and the upcoming ACPI support.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/Makefile                                 | 3 +--
 drivers/hwtracing/coresight/{of_coresight.c => coresight-platform.c} | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/hwtracing/coresight/{of_coresight.c => coresight-platform.c} (99%)

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 3b435aa..3c0ac42 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,8 +2,7 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o
-obj-$(CONFIG_OF) += of_coresight.o
+obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o coresight-platform.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o \
 					     coresight-tmc-etf.o \
 					     coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/coresight-platform.c
similarity index 99%
rename from drivers/hwtracing/coresight/of_coresight.c
rename to drivers/hwtracing/coresight/coresight-platform.c
index 7045930..514cc2b 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -17,7 +17,7 @@
 #include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
-
+#ifdef CONFIG_OF
 static int of_dev_node_match(struct device *dev, void *data)
 {
 	return dev->of_node == data;
@@ -295,3 +295,4 @@ of_get_coresight_platform_data(struct device *dev,
 	return pdata;
 }
 EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
+#endif
-- 
2.7.4

