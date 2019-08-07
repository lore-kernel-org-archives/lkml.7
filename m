Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DDDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4EE21BE3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfHGNA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:00:56 -0400
Received: from foss.arm.com ([217.140.110.172]:48036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbfHGNA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:00:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93DFC28;
        Wed,  7 Aug 2019 06:00:55 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E033A3F575;
        Wed,  7 Aug 2019 06:00:54 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32 accessors
Date:   Wed,  7 Aug 2019 14:00:38 +0100
Message-Id: <20190807130038.26878-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of type-casting the {tx,rx}.buf all over the place while
accessing them to read/write __le32 from/to the firmware, let's use
the nice existing {get,put}_unaligned_le32 accessors to hide all the
type cast ugliness.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/base.c    |  2 +-
 drivers/firmware/arm_scmi/clock.c   | 10 ++++------
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/perf.c    |  8 ++++----
 drivers/firmware/arm_scmi/power.c   |  6 +++---
 drivers/firmware/arm_scmi/reset.c   |  2 +-
 drivers/firmware/arm_scmi/sensors.c | 12 +++++-------
 7 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 204390297f4b..f804e8af6521 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -204,7 +204,7 @@ static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(id);
+	put_unaligned_le32(id, t->tx.buf);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 4a32ae1822a3..199a668ea885 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -107,7 +107,7 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
+	put_unaligned_le32(clk_id, t->tx.buf);
 	attr = t->rx.buf;
 
 	ret = scmi_do_xfer(handle, t);
@@ -204,14 +204,12 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
+	put_unaligned_le32(clk_id, t->tx.buf);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret) {
-		__le32 *pval = t->rx.buf;
-
-		*value = le32_to_cpu(*pval);
-		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
+		*value = get_unaligned_le32(t->rx.buf);
+		*value |= (u64)get_unaligned_le32(t->rx.buf + 1) << 32;
 	}
 
 	scmi_xfer_put(handle, t);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 43884e4ceac5..5237c2ff79fe 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -15,6 +15,8 @@
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
+#include <asm/unaligned.h>
+
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
 #define PROTOCOL_REV_MAJOR_MASK	GENMASK(31, 16)
 #define PROTOCOL_REV_MAJOR(x)	(u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x)))
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index fb7f6cab2c11..9b338e66a24e 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -195,7 +195,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
 	ret = scmi_do_xfer(handle, t);
@@ -380,7 +380,7 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret) {
@@ -459,11 +459,11 @@ static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
 		return ret;
 
 	t->hdr.poll_completion = poll;
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		*level = le32_to_cpu(*(__le32 *)t->rx.buf);
+		*level = get_unaligned_le32(t->rx.buf);
 
 	scmi_xfer_put(handle, t);
 	return ret;
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 62f3401a1f01..5abef7079c0a 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -96,7 +96,7 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
 	ret = scmi_do_xfer(handle, t);
@@ -147,11 +147,11 @@ scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 
 	ret = scmi_do_xfer(handle, t);
 	if (!ret)
-		*state = le32_to_cpu(*(__le32 *)t->rx.buf);
+		*state = get_unaligned_le32(t->rx.buf);
 
 	scmi_xfer_put(handle, t);
 	return ret;
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 11cb8b5ccf34..c1d67a2af12f 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -88,7 +88,7 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 	if (ret)
 		return ret;
 
-	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
 	ret = scmi_do_xfer(handle, t);
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 7570308a16a0..5b330619a025 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -120,7 +120,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 
 	do {
 		/* Set the number of sensors to be skipped/already read */
-		*(__le32 *)t->tx.buf = cpu_to_le32(desc_index);
+		put_unaligned_le32(desc_index, t->tx.buf);
 
 		ret = scmi_do_xfer(handle, t);
 		if (ret)
@@ -217,7 +217,6 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 				   u32 sensor_id, u64 *value)
 {
 	int ret;
-	__le32 *pval;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
 	struct sensors_info *si = handle->sensor_priv;
@@ -229,7 +228,6 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 	if (ret)
 		return ret;
 
-	pval = t->rx.buf;
 	sensor = t->tx.buf;
 	sensor->id = cpu_to_le32(sensor_id);
 
@@ -237,15 +235,15 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
 		ret = scmi_do_xfer_with_response(handle, t);
 		if (!ret) {
-			*value = le32_to_cpu(*(pval + 1));
-			*value |= (u64)le32_to_cpu(*(pval + 2)) << 32;
+			*value = get_unaligned_le32(t->rx.buf + 1);
+			*value |= (u64)get_unaligned_le32(t->rx.buf + 2) << 32;
 		}
 	} else {
 		sensor->flags = cpu_to_le32(0);
 		ret = scmi_do_xfer(handle, t);
 		if (!ret) {
-			*value = le32_to_cpu(*pval);
-			*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
+			*value = get_unaligned_le32(t->rx.buf);
+			*value |= (u64)get_unaligned_le32(t->rx.buf + 1) << 32;
 		}
 	}
 
-- 
2.17.1

