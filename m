Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBCAC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1052420828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJOyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:09 -0500
Received: from foss.arm.com ([217.140.110.172]:47126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfLJOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E4F811B3;
        Tue, 10 Dec 2019 06:54:07 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF7023F67D;
        Tue, 10 Dec 2019 06:54:06 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 03/15] firmware: arm_scmi: Skip protocol initialisation for additional devices
Date:   Tue, 10 Dec 2019 14:53:33 +0000
Message-Id: <20191210145345.11616-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi bus now supports adding multiple devices per protocol,
and since scmi_protocol_init is called for each scmi device created,
we must avoid allocating protocol private data and initialising the
protocol itself if it is already initialised.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 3 +++
 drivers/firmware/arm_scmi/perf.c    | 3 +++
 drivers/firmware/arm_scmi/power.c   | 3 +++
 drivers/firmware/arm_scmi/reset.c   | 3 +++
 drivers/firmware/arm_scmi/sensors.c | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 32526a793f3a..922b22aaaf84 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -316,6 +316,9 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 	int clkid, ret;
 	struct clock_info *cinfo;

+	if (handle->clk_ops && handle->clk_priv)
+		return 0; /* initialised already for the first device */
+
 	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);

 	dev_dbg(handle->dev, "Clock Version %d.%d\n",
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 601af4edad5e..55c2a4c21ccb 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -710,6 +710,9 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 	u32 version;
 	struct scmi_perf_info *pinfo;

+	if (handle->perf_ops && handle->perf_priv)
+		return 0; /* initialised already for the first device */
+
 	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);

 	dev_dbg(handle->dev, "Performance Version %d.%d\n",
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 5abef7079c0a..9a7593238b8f 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -185,6 +185,9 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 	u32 version;
 	struct scmi_power_info *pinfo;

+	if (handle->power_ops && handle->power_priv)
+		return 0; /* initialised already for the first device */
+
 	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);

 	dev_dbg(handle->dev, "Power Version %d.%d\n",
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index ab42c21c5517..809dc8faee1e 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -195,6 +195,9 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 	u32 version;
 	struct scmi_reset_info *pinfo;

+	if (handle->reset_ops && handle->reset_priv)
+		return 0; /* initialised already for the first device */
+
 	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);

 	dev_dbg(handle->dev, "Reset Version %d.%d\n",
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index a400ea805fc2..b7f92c37c8a4 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -276,6 +276,9 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 	u32 version;
 	struct sensors_info *sinfo;

+	if (handle->sensor_ops && handle->sensor_priv)
+		return 0; /* initialised already for the first device */
+
 	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);

 	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
--
2.17.1

