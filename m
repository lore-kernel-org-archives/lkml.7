Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A32C2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81482077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLJOyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:17 -0500
Received: from foss.arm.com ([217.140.110.172]:47154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfLJOyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF42C13D5;
        Tue, 10 Dec 2019 06:54:11 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C6303F67D;
        Tue, 10 Dec 2019 06:54:11 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 08/15] firmware: arm_scmi: Add and initialise protocol version to scmi_device structure
Date:   Tue, 10 Dec 2019 14:53:38 +0000
Message-Id: <20191210145345.11616-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to keep track of scmi protocol version in the scmi device
structure along with the protocol id. These can be used to expose the
information to the userspace via bus dev_groups attributes as well.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 6 +++++-
 drivers/firmware/arm_scmi/perf.c    | 6 +++++-
 drivers/firmware/arm_scmi/power.c   | 6 +++++-
 drivers/firmware/arm_scmi/reset.c   | 6 +++++-
 drivers/firmware/arm_scmi/sensors.c | 6 +++++-
 include/linux/scmi_protocol.h       | 1 +
 6 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index b567ec03f711..b68736ae7f88 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -318,8 +318,11 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)
 	struct clock_info *cinfo;
 	struct scmi_handle *handle = dev->handle;

-	if (handle->clk_ops && handle->clk_priv)
+	if (handle->clk_ops && handle->clk_priv) {
+		cinfo = handle->clk_priv;
+		dev->version = cinfo->version;
 		return 0; /* initialised already for the first device */
+	}

 	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);

@@ -345,6 +348,7 @@ static int scmi_clock_protocol_init(struct scmi_device *dev)
 			scmi_clock_describe_rates_get(handle, clkid, clk);
 	}

+	dev->version = version;
 	cinfo->version = version;
 	handle->clk_ops = &clk_ops;
 	handle->clk_priv = cinfo;
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index b1de6197f61c..8a02dc453894 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -712,8 +712,11 @@ static int scmi_perf_protocol_init(struct scmi_device *dev)
 	struct scmi_perf_info *pinfo;
 	struct scmi_handle *handle = dev->handle;

-	if (handle->perf_ops && handle->perf_priv)
+	if (handle->perf_ops && handle->perf_priv) {
+		pinfo = handle->perf_priv;
+		dev->version = pinfo->version;
 		return 0; /* initialised already for the first device */
+	}

 	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);

@@ -741,6 +744,7 @@ static int scmi_perf_protocol_init(struct scmi_device *dev)
 			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
 	}

+	dev->version = version;
 	pinfo->version = version;
 	handle->perf_ops = &perf_ops;
 	handle->perf_priv = pinfo;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index d11c6cd6bbab..6267111e38e6 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -187,8 +187,11 @@ static int scmi_power_protocol_init(struct scmi_device *dev)
 	struct scmi_power_info *pinfo;
 	struct scmi_handle *handle = dev->handle;

-	if (handle->power_ops && handle->power_priv)
+	if (handle->power_ops && handle->power_priv) {
+		pinfo = handle->power_priv;
+		dev->version = pinfo->version;
 		return 0; /* initialised already for the first device */
+	}

 	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);

@@ -212,6 +215,7 @@ static int scmi_power_protocol_init(struct scmi_device *dev)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}

+	dev->version = version;
 	pinfo->version = version;
 	handle->power_ops = &power_ops;
 	handle->power_priv = pinfo;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index dce103781b3f..76f1cee85a06 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -197,8 +197,11 @@ static int scmi_reset_protocol_init(struct scmi_device *dev)
 	struct scmi_reset_info *pinfo;
 	struct scmi_handle *handle = dev->handle;

-	if (handle->reset_ops && handle->reset_priv)
+	if (handle->reset_ops && handle->reset_priv) {
+		pinfo = handle->reset_priv;
+		dev->version = pinfo->version;
 		return 0; /* initialised already for the first device */
+	}

 	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);

@@ -222,6 +225,7 @@ static int scmi_reset_protocol_init(struct scmi_device *dev)
 		scmi_reset_domain_attributes_get(handle, domain, dom);
 	}

+	dev->version = version;
 	pinfo->version = version;
 	handle->reset_ops = &reset_ops;
 	handle->reset_priv = pinfo;
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index aac0243e2880..fb3bed4cb171 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -278,8 +278,11 @@ static int scmi_sensors_protocol_init(struct scmi_device *dev)
 	struct sensors_info *sinfo;
 	struct scmi_handle *handle = dev->handle;

-	if (handle->sensor_ops && handle->sensor_priv)
+	if (handle->sensor_ops && handle->sensor_priv) {
+		sinfo = handle->sensor_priv;
+		dev->version = sinfo->version;
 		return 0; /* initialised already for the first device */
+	}

 	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);

@@ -299,6 +302,7 @@ static int scmi_sensors_protocol_init(struct scmi_device *dev)

 	scmi_sensor_description_get(handle, sinfo);

+	dev->version = version;
 	sinfo->version = version;
 	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b676825e6eb0..a863bc0cdf28 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -256,6 +256,7 @@ enum scmi_std_protocol {

 struct scmi_device {
 	u32 id;
+	u32 version;
 	u8 protocol_id;
 	const char *name;
 	struct device dev;
--
2.17.1

