Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8610C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8700216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfGHPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:52020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390268AbfGHPoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:44:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FCFB1509;
        Mon,  8 Jul 2019 08:44:09 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5CE6A3F59C;
        Mon,  8 Jul 2019 08:44:08 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 2/6] firmware: arm_scmi: Align few names in sensors protocol with SCMI specification
Date:   Mon,  8 Jul 2019 16:43:54 +0100
Message-Id: <20190708154358.16227-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154358.16227-1-sudeep.holla@arm.com>
References: <20190708154358.16227-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like more code developed during the draft versions of the
specification slipped through and they don't match the final
released version. This seem to have happened only with sensor
protocol.

Renaming few command and function names here to match exactly with
the released version of SCMI specification for ease of maintenance.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 28 +++++++++++++++-------------
 include/linux/scmi_protocol.h       | 12 ++++++------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 0e94ab56f679..17dbabd8a94a 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -9,8 +9,8 @@
 
 enum scmi_sensor_protocol_cmd {
 	SENSOR_DESCRIPTION_GET = 0x3,
-	SENSOR_CONFIG_SET = 0x4,
-	SENSOR_TRIP_POINT_SET = 0x5,
+	SENSOR_TRIP_POINT_NOTIFY = 0x4,
+	SENSOR_TRIP_POINT_CONFIG = 0x5,
 	SENSOR_READING_GET = 0x6,
 };
 
@@ -42,9 +42,10 @@ struct scmi_msg_resp_sensor_description {
 	} desc[0];
 };
 
-struct scmi_msg_set_sensor_config {
+struct scmi_msg_sensor_trip_point_notify {
 	__le32 id;
 	__le32 event_control;
+#define SENSOR_TP_NOTIFY_ALL	BIT(0)
 };
 
 struct scmi_msg_set_sensor_trip_point {
@@ -160,15 +161,15 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	return ret;
 }
 
-static int
-scmi_sensor_configuration_set(const struct scmi_handle *handle, u32 sensor_id)
+static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
+					 u32 sensor_id, bool enable)
 {
 	int ret;
-	u32 evt_cntl = BIT(0);
+	u32 evt_cntl = enable ? SENSOR_TP_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
-	struct scmi_msg_set_sensor_config *cfg;
+	struct scmi_msg_sensor_trip_point_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_CONFIG_SET,
+	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_NOTIFY,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
@@ -183,15 +184,16 @@ scmi_sensor_configuration_set(const struct scmi_handle *handle, u32 sensor_id)
 	return ret;
 }
 
-static int scmi_sensor_trip_point_set(const struct scmi_handle *handle,
-				      u32 sensor_id, u8 trip_id, u64 trip_value)
+static int
+scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
+			      u8 trip_id, u64 trip_value)
 {
 	int ret;
 	u32 evt_cntl = SENSOR_TP_BOTH;
 	struct scmi_xfer *t;
 	struct scmi_msg_set_sensor_trip_point *trip;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_SET,
+	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_CONFIG,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
 	if (ret)
 		return ret;
@@ -255,8 +257,8 @@ static int scmi_sensor_count_get(const struct scmi_handle *handle)
 static struct scmi_sensor_ops sensor_ops = {
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
-	.configuration_set = scmi_sensor_configuration_set,
-	.trip_point_set = scmi_sensor_trip_point_set,
+	.trip_point_notify = scmi_sensor_trip_point_notify,
+	.trip_point_config = scmi_sensor_trip_point_config,
 	.reading_get = scmi_sensor_reading_get,
 };
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 9ff2e9357e9a..ea6b72018752 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -167,9 +167,9 @@ enum scmi_sensor_class {
  *
  * @count_get: get the count of sensors provided by SCMI
  * @info_get: get the information of the specified sensor
- * @configuration_set: control notifications on cross-over events for
+ * @trip_point_notify: control notifications on cross-over events for
  *	the trip-points
- * @trip_point_set: selects and configures a trip-point of interest
+ * @trip_point_config: selects and configures a trip-point of interest
  * @reading_get: gets the current value of the sensor
  */
 struct scmi_sensor_ops {
@@ -177,10 +177,10 @@ struct scmi_sensor_ops {
 
 	const struct scmi_sensor_info *(*info_get)
 		(const struct scmi_handle *handle, u32 sensor_id);
-	int (*configuration_set)(const struct scmi_handle *handle,
-				 u32 sensor_id);
-	int (*trip_point_set)(const struct scmi_handle *handle, u32 sensor_id,
-			      u8 trip_id, u64 trip_value);
+	int (*trip_point_notify)(const struct scmi_handle *handle,
+				 u32 sensor_id, bool enable);
+	int (*trip_point_config)(const struct scmi_handle *handle,
+				 u32 sensor_id, u8 trip_id, u64 trip_value);
 	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
 			   bool async, u64 *value);
 };
-- 
2.17.1

