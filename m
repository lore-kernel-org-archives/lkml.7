Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7013AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536142146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCTSuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45046 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfCTSuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0161A25;
        Wed, 20 Mar 2019 11:50:49 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F41563F59C;
        Wed, 20 Mar 2019 11:50:47 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 23/25] coresight: stm: ACPI support for parsing stimulus base
Date:   Wed, 20 Mar 2019 18:49:40 +0000
Message-Id: <1553107783-3340-24-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stimulus base for STM device must be listed as the second memory
resource, followed by the programming base address. Add support for
parsing the information for ACPI.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index d94ae22..995443a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -16,6 +16,7 @@
  * (C) 2015-2016 Chunyan Zhang <zhang.chunyan@linaro.org>
  */
 #include <asm/local.h>
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/bitmap.h>
 #include <linux/clk.h>
@@ -717,10 +718,52 @@ static inline int of_stm_get_stimulus_area(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_ACPI
+static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
+{
+	int rc;
+	bool found_base = false;
+	struct resource_entry *rent;
+	LIST_HEAD(res_list);
+
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (!adev)
+		return -ENODEV;
+	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
+	if (rc < 0)
+		return rc;
+
+	rc = -ENOENT;
+	list_for_each_entry(rent, &res_list, node) {
+		if (resource_type(rent->res) != IORESOURCE_MEM)
+			continue;
+		if (found_base) {
+			*res = *rent->res;
+			rc = 0;
+			break;
+		}
+
+		found_base = true;
+	}
+
+	acpi_dev_free_resource_list(&res_list);
+	return rc;
+}
+#else
+static inline int acpi_stm_get_stimulus_area(struct device *dev,
+					     struct resource *res)
+{
+	return -ENOENT;
+}
+#endif
+
 static int stm_get_stimulus_area(struct device *dev, struct resource *res)
 {
 	if (dev->of_node)
 		return of_stm_get_stimulus_area(dev, res);
+	else if (is_acpi_node(dev->fwnode))
+		return acpi_stm_get_stimulus_area(dev, res);
 	return -ENOENT;
 }
 
-- 
2.7.4

