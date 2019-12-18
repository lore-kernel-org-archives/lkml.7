Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2018CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D724684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLRLSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:18:18 -0500
Received: from foss.arm.com ([217.140.110.172]:42374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfLRLRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02AEC113E;
        Wed, 18 Dec 2019 03:17:53 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53BBC3F6CF;
        Wed, 18 Dec 2019 03:17:52 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 06/11] firmware: arm_scmi: Stash version in protocol init functions
Date:   Wed, 18 Dec 2019 11:17:37 +0000
Message-Id: <20191218111742.29731-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218111742.29731-1-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid querying the individual protocol versions multiple
time with more that one device created for each protocol, we can simple
store the copy in the protocol specific private data and use them whenever
required.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c   | 2 ++
 drivers/firmware/arm_scmi/perf.c    | 2 ++
 drivers/firmware/arm_scmi/power.c   | 2 ++
 drivers/firmware/arm_scmi/reset.c   | 2 ++
 drivers/firmware/arm_scmi/sensors.c | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 32526a793f3a..4c2227662b26 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -65,6 +65,7 @@ struct scmi_clock_set_rate {
 };
 
 struct clock_info {
+	u32 version;
 	int num_clocks;
 	int max_async_req;
 	atomic_t cur_async_req;
@@ -340,6 +341,7 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 			scmi_clock_describe_rates_get(handle, clkid, clk);
 	}
 
+	cinfo->version = version;
 	handle->clk_ops = &clk_ops;
 	handle->clk_priv = cinfo;
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 601af4edad5e..ec81e6f7e7a4 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -145,6 +145,7 @@ struct perf_dom_info {
 };
 
 struct scmi_perf_info {
+	u32 version;
 	int num_domains;
 	bool power_scale_mw;
 	u64 stats_addr;
@@ -736,6 +737,7 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
 	}
 
+	pinfo->version = version;
 	handle->perf_ops = &perf_ops;
 	handle->perf_priv = pinfo;
 
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 5abef7079c0a..214886ce84f1 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -50,6 +50,7 @@ struct power_dom_info {
 };
 
 struct scmi_power_info {
+	u32 version;
 	int num_domains;
 	u64 stats_addr;
 	u32 stats_size;
@@ -207,6 +208,7 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 		scmi_power_domain_attributes_get(handle, domain, dom);
 	}
 
+	pinfo->version = version;
 	handle->power_ops = &power_ops;
 	handle->power_priv = pinfo;
 
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index ab42c21c5517..de73054554f3 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -48,6 +48,7 @@ struct reset_dom_info {
 };
 
 struct scmi_reset_info {
+	u32 version;
 	int num_domains;
 	struct reset_dom_info *dom_info;
 };
@@ -217,6 +218,7 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 		scmi_reset_domain_attributes_get(handle, domain, dom);
 	}
 
+	pinfo->version = version;
 	handle->reset_ops = &reset_ops;
 	handle->reset_priv = pinfo;
 
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index a400ea805fc2..eba61b9c1f53 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -68,6 +68,7 @@ struct scmi_msg_sensor_reading_get {
 };
 
 struct sensors_info {
+	u32 version;
 	int num_sensors;
 	int max_requests;
 	u64 reg_addr;
@@ -294,6 +295,7 @@ static int scmi_sensors_protocol_init(struct scmi_handle *handle)
 
 	scmi_sensor_description_get(handle, sinfo);
 
+	sinfo->version = version;
 	handle->sensor_ops = &sensor_ops;
 	handle->sensor_priv = sinfo;
 
-- 
2.17.1

