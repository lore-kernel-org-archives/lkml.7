Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9894C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29C62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfLJOyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfLJOyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2668D113E;
        Tue, 10 Dec 2019 06:54:10 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 776E63F67D;
        Tue, 10 Dec 2019 06:54:09 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 06/15] firmware: arm_scmi: Update scmi_prot_init_fn_t to use device instead of handle
Date:   Tue, 10 Dec 2019 14:53:36 +0000
Message-Id: <20191210145345.11616-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi bus now supports multiple device per protocol. So, in order to
initialise each device and it's attributes, it's better to pass scmi_device
pointer to the protocol initialise function rather than scmi_handle.
scmi_handle can be still fetched from the scmi_device pointer.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c     | 6 +++---
 drivers/firmware/arm_scmi/clock.c   | 3 ++-
 drivers/firmware/arm_scmi/perf.c    | 3 ++-
 drivers/firmware/arm_scmi/power.c   | 3 ++-
 drivers/firmware/arm_scmi/reset.c   | 3 ++-
 drivers/firmware/arm_scmi/sensors.c | 3 ++-
 include/linux/scmi_protocol.h       | 2 +-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 3714e6307b05..f619da2634a6 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -51,13 +51,13 @@ static int scmi_dev_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }

-static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
+static int scmi_protocol_init(int protocol_id, struct scmi_device *dev)
 {
 	scmi_prot_init_fn_t fn = idr_find(&scmi_protocols, protocol_id);

 	if (unlikely(!fn))
 		return -EINVAL;
-	return fn(handle);
+	return fn(dev);
 }

 static int scmi_dev_probe(struct device *dev)
@@ -74,7 +74,7 @@ static int scmi_dev_probe(struct device *dev)
 	if (!scmi_dev->handle)
 		return -EPROBE_DEFER;

-	ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev->handle);
+	ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev);
 	if (ret)
 		return ret;

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 922b22aaaf84..6c24eb8a4e68 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -310,11 +310,12 @@ static struct scmi_clk_ops clk_ops = {
 	.disable = scmi_clock_disable,
 };

-static int scmi_clock_protocol_init(struct scmi_handle *handle)
+static int scmi_clock_protocol_init(struct scmi_device *dev)
 {
 	u32 version;
 	int clkid, ret;
 	struct clock_info *cinfo;
+	struct scmi_handle *handle = dev->handle;

 	if (handle->clk_ops && handle->clk_priv)
 		return 0; /* initialised already for the first device */
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 55c2a4c21ccb..4f02bfba98ba 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -704,11 +704,12 @@ static struct scmi_perf_ops perf_ops = {
 	.est_power_get = scmi_dvfs_est_power_get,
 };

-static int scmi_perf_protocol_init(struct scmi_handle *handle)
+static int scmi_perf_protocol_init(struct scmi_device *dev)
 {
 	int domain;
 	u32 version;
 	struct scmi_perf_info *pinfo;
+	struct scmi_handle *handle = dev->handle;

 	if (handle->perf_ops && handle->perf_priv)
 		return 0; /* initialised already for the first device */
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 9a7593238b8f..5a8faa369d82 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -179,11 +179,12 @@ static struct scmi_power_ops power_ops = {
 	.state_get = scmi_power_state_get,
 };

-static int scmi_power_protocol_init(struct scmi_handle *handle)
+static int scmi_power_protocol_init(struct scmi_device *dev)
 {
 	int domain;
 	u32 version;
 	struct scmi_power_info *pinfo;
+	struct scmi_handle *handle = dev->handle;

 	if (handle->power_ops && handle->power_priv)
 		return 0; /* initialised already for the first device */
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 809dc8faee1e..438d74a2c80a 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -189,11 +189,12 @@ static struct scmi_reset_ops reset_ops = {
 	.deassert = scmi_reset_domain_deassert,
 };

-static int scmi_reset_protocol_init(struct scmi_handle *handle)
+static int scmi_reset_protocol_init(struct scmi_device *dev)
 {
 	int domain;
 	u32 version;
 	struct scmi_reset_info *pinfo;
+	struct scmi_handle *handle = dev->handle;

 	if (handle->reset_ops && handle->reset_priv)
 		return 0; /* initialised already for the first device */
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b7f92c37c8a4..afa51bedfa5d 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -271,10 +271,11 @@ static struct scmi_sensor_ops sensor_ops = {
 	.reading_get = scmi_sensor_reading_get,
 };

-static int scmi_sensors_protocol_init(struct scmi_handle *handle)
+static int scmi_sensors_protocol_init(struct scmi_device *dev)
 {
 	u32 version;
 	struct sensors_info *sinfo;
+	struct scmi_handle *handle = dev->handle;

 	if (handle->sensor_ops && handle->sensor_priv)
 		return 0; /* initialised already for the first device */
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 5c873a59b387..b676825e6eb0 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -316,6 +316,6 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 #define module_scmi_driver(__scmi_driver)	\
 	module_driver(__scmi_driver, scmi_register, scmi_unregister)

-typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
+typedef int (*scmi_prot_init_fn_t)(struct scmi_device *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
 void scmi_protocol_unregister(int protocol_id);
--
2.17.1

