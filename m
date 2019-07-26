Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648DBC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4950F22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfGZNw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:52:26 -0400
Received: from foss.arm.com ([217.140.110.172]:44518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfGZNv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39CD4152D;
        Fri, 26 Jul 2019 06:51:57 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB0033F694;
        Fri, 26 Jul 2019 06:51:55 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2 07/10] firmware: arm_scmi: Drop async flag in sensor_ops->reading_get
Date:   Fri, 26 Jul 2019 14:51:35 +0100
Message-Id: <20190726135138.9858-8-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SENSOR_DESCRIPTION_GET provides attributes to indicate if the sensor
supports asynchronous read. Ideally we should be able to read that flag
and use asynchronous reads for any sensors with that attribute set.

In order to add that support, let's drop the async flag passed to
sensor_ops->reading_get and dynamically switch between sync and async
flags based on the attributes as provided by the firmware.

Cc: linux-hwmon@vger.kernel.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 4 ++--
 drivers/hwmon/scmi-hwmon.c          | 2 +-
 include/linux/scmi_protocol.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 17dbabd8a94a..1b5757c77a35 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -211,7 +211,7 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 }
 
 static int scmi_sensor_reading_get(const struct scmi_handle *handle,
-				   u32 sensor_id, bool async, u64 *value)
+				   u32 sensor_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -225,7 +225,7 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
-	sensor->flags = cpu_to_le32(async ? SENSOR_READ_ASYNC : 0);
+	sensor->flags = cpu_to_le32(0);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret) {
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 0c93fc5ca762..8a7732c0bef3 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -72,7 +72,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	const struct scmi_handle *h = scmi_sensors->handle;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1383d47e6435..2ace5af210ad 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -182,7 +182,7 @@ struct scmi_sensor_ops {
 	int (*trip_point_config)(const struct scmi_handle *handle,
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
 	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
-			   bool async, u64 *value);
+			   u64 *value);
 };
 
 /**
-- 
2.17.1

