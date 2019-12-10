Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD6C2D0C7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462FF2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfLJOyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:23 -0500
Received: from foss.arm.com ([217.140.110.172]:47162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfLJOyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A394511B3;
        Tue, 10 Dec 2019 06:54:13 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00CA03F67D;
        Tue, 10 Dec 2019 06:54:12 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 10/15] firmware: arm_scmi: Drop logging individual scmi protocol version
Date:   Tue, 10 Dec 2019 14:53:40 +0000
Message-Id: <20191210145345.11616-11-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI firmware and individual protocol versions and other attributes are
now exposed as device attributes through sysfs entries. These debug logs
can be dropped as the same information is available through sysfs.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 3 ---
 drivers/firmware/arm_scmi/perf.c    | 3 ---
 drivers/firmware/arm_scmi/power.c   | 3 ---
 drivers/firmware/arm_scmi/reset.c   | 3 ---
 drivers/firmware/arm_scmi/sensors.c | 3 ---
 5 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index b68736ae7f88..ce8cbefb0aa6 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -326,9 +326,6 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)

 	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);

-	dev_dbg(handle->dev, "Clock Version %d.%d\n",
-		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-
 	cinfo = devm_kzalloc(handle->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 8a02dc453894..2ad3bc792692 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -720,9 +720,6 @@ static int scmi_perf_protocol_init(struct scmi_device *dev)

 	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);

-	dev_dbg(handle->dev, "Performance Version %d.%d\n",
-		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-
 	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 6267111e38e6..29d72fa7d085 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -195,9 +195,6 @@ static int scmi_power_protocol_init(struct scmi_device *dev)

 	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);

-	dev_dbg(handle->dev, "Power Version %d.%d\n",
-		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-
 	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 76f1cee85a06..a49155628ccf 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -205,9 +205,6 @@ static int scmi_reset_protocol_init(struct scmi_device *dev)

 	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);

-	dev_dbg(handle->dev, "Reset Version %d.%d\n",
-		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-
 	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index fb3bed4cb171..61e12f2fb587 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -286,9 +286,6 @@ static int scmi_sensors_protocol_init(struct scmi_device *dev)

 	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);

-	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
-		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
-
 	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
--
2.17.1

