Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87825C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6743B20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbfGHPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:48:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391308AbfGHPrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941A7152B;
        Mon,  8 Jul 2019 08:47:52 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FD363F59C;
        Mon,  8 Jul 2019 08:47:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 09/11] firmware: arm_scmi: Add asynchronous sensor read if it supports
Date:   Mon,  8 Jul 2019 16:47:28 +0100
Message-Id: <20190708154730.16643-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SENSOR_DESCRIPTION_GET provides attributes to indicate if the sensor
supports asynchronous read. We can read that flag and use asynchronous
reads for any sensors with that attribute set.

Let's use the new scmi_do_xfer_with_response to support asynchronous
sensor reads.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 30 +++++++++++++++++++++--------
 include/linux/scmi_protocol.h       |  2 ++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 1b5757c77a35..b8f226a365de 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -136,9 +136,10 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		}
 
 		for (cnt = 0; cnt < num_returned; cnt++) {
-			u32 attrh;
+			u32 attrh, attrl;
 			struct scmi_sensor_info *s;
 
+			attrl = le32_to_cpu(buf->desc[cnt].attributes_low);
 			attrh = le32_to_cpu(buf->desc[cnt].attributes_high);
 			s = &si->sensors[desc_index + cnt];
 			s->id = le32_to_cpu(buf->desc[cnt].id);
@@ -147,6 +148,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 			/* Sign extend to a full s8 */
 			if (s->scale & SENSOR_SCALE_SIGN)
 				s->scale |= SENSOR_SCALE_EXTEND;
+			s->async = SUPPORTS_ASYNC_READ(attrl);
+			s->num_trip_points = NUM_TRIP_POINTS(attrl);
 			strlcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
 		}
 
@@ -214,8 +217,11 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 				   u32 sensor_id, u64 *value)
 {
 	int ret;
+	__le32 *pval;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
+	struct sensors_info *si = handle->sensor_priv;
+	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
 	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
 				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
@@ -223,16 +229,24 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;
 
+	pval = t->rx.buf;
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
-	sensor->flags = cpu_to_le32(0);
-
-	ret = scmi_do_xfer(handle, t);
-	if (!ret) {
-		__le32 *pval = t->rx.buf;
 
-		*value = le32_to_cpu(*pval);
-		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
+	if (s->async) {
+		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
+		ret = scmi_do_xfer_with_response(handle, t);
+		if (!ret) {
+			*value = le32_to_cpu(*pval + 1);
+			*value |= (u64)le32_to_cpu(*(pval + 2)) << 32;
+		}
+	} else {
+		sensor->flags = cpu_to_le32(0);
+		ret = scmi_do_xfer(handle, t);
+		if (!ret) {
+			*value = le32_to_cpu(*pval);
+			*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
+		}
 	}
 
 	scmi_xfer_put(handle, t);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 697e30fb9004..1be16d7730e2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -145,6 +145,8 @@ struct scmi_sensor_info {
 	u32 id;
 	u8 type;
 	s8 scale;
+	u8 num_trip_points;
+	bool async;
 	char name[SCMI_MAX_STR_SIZE];
 };
 
-- 
2.17.1

