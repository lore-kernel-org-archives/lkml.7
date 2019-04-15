Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E825C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D985D20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfDOQGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:45 -0400
Received: from foss.arm.com ([217.140.101.70]:38082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfDOQGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21E51AC1;
        Mon, 15 Apr 2019 09:06:42 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 785573F68F;
        Mon, 15 Apr 2019 09:06:41 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 33/36] coresight: acpi: Support for components
Date:   Mon, 15 Apr 2019 17:04:16 +0100
Message-Id: <1555344260-12375-34-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All AMBA devices are handled via ACPI AMBA scan notifier
infrastructure. The platform devices get the ACPI id
added to their driver.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/acpi/acpi_amba.c                           | 9 +++++++++
 drivers/hwtracing/coresight/coresight-replicator.c | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 7f77c07..eef5a69 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -24,6 +24,15 @@
 
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
+	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{"ARMHC501", 0}, /* ARM CoreSight ETR */
+	{"ARMHC502", 0}, /* ARM CoreSight STM */
+	{"ARMHC503", 0}, /* ARM CoreSight Debug */
+	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
+	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
+	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
+	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
+	{"ARMHC9FF", 0}, /* ARM CoreSight Funnel */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 2eb489c..a8f42df 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -5,6 +5,7 @@
  * Description: CoreSight Replicator driver
  */
 
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -290,11 +291,17 @@ static const struct of_device_id static_replicator_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id static_replicator_acpi_ids[] = {
+	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+};
+#endif
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
 	.driver         = {
 		.name   = "coresight-replicator",
-		.of_match_table = static_replicator_match,
+		.of_match_table = of_match_ptr(static_replicator_match),
+		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-- 
2.7.4

