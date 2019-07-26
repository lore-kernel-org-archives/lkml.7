Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C451C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DDB22CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfGZOAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:00:14 -0400
Received: from foss.arm.com ([217.140.110.172]:44964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbfGZOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:00:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7656152D;
        Fri, 26 Jul 2019 07:00:08 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DE1D3F694;
        Fri, 26 Jul 2019 07:00:06 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Quentin Perret <Quentin.Perret@arm.com>
Subject: [PATCH 1/5] firmware: arm_scmi: Add discovery of SCMI v2.0 performance fastchannels
Date:   Fri, 26 Jul 2019 14:59:50 +0100
Message-Id: <20190726135954.11078-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135954.11078-1-sudeep.holla@arm.com>
References: <20190726135954.11078-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v2.0 adds support for "FastChannel", a lightweight unidirectional
channel that is dedicated to a single SCMI message type for controlling
a specific platform resource. They do not use a message header as they
are specialized for a single message.

Only PERFORMANCE_LIMITS_{SET,GET} and PERFORMANCE_LEVEL_{SET,GET}
commands are supported over fastchannels. As they are optional, they
need to be discovered by PERFORMANCE_DESCRIBE_FASTCHANNEL command.
Further {LIMIT,LEVEL}_SET commands can have optional doorbell support.

Add support for discovery of these fastchannels.

Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc: Chris Redpath <Chris.Redpath@arm.com>
Cc: Quentin Perret <Quentin.Perret@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 153 ++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3c8ae7cc35de..6cce3e82e81e 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -5,7 +5,9 @@
  * Copyright (C) 2018 ARM Ltd.
  */
 
+#include <linux/bits.h>
 #include <linux/of.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/sort.h>
@@ -21,6 +23,7 @@ enum scmi_performance_protocol_cmd {
 	PERF_LEVEL_GET = 0x8,
 	PERF_NOTIFY_LIMITS = 0x9,
 	PERF_NOTIFY_LEVEL = 0xa,
+	PERF_DESCRIBE_FASTCHANNEL = 0xb,
 };
 
 struct scmi_opp {
@@ -44,6 +47,7 @@ struct scmi_msg_resp_perf_domain_attributes {
 #define SUPPORTS_SET_PERF_LVL(x)	((x) & BIT(30))
 #define SUPPORTS_PERF_LIMIT_NOTIFY(x)	((x) & BIT(29))
 #define SUPPORTS_PERF_LEVEL_NOTIFY(x)	((x) & BIT(28))
+#define SUPPORTS_PERF_FASTCHANNELS(x)	((x) & BIT(27))
 	__le32 rate_limit_us;
 	__le32 sustained_freq_khz;
 	__le32 sustained_perf_level;
@@ -87,17 +91,56 @@ struct scmi_msg_resp_perf_describe_levels {
 	} opp[0];
 };
 
+struct scmi_perf_get_fc_info {
+	__le32 domain;
+	__le32 message_id;
+};
+
+struct scmi_msg_resp_perf_desc_fc {
+	__le32 attr;
+#define SUPPORTS_DOORBELL(x)		((x) & BIT(0))
+#define DOORBELL_REG_WIDTH(x)		FIELD_GET(GENMASK(2, 1), (x))
+	__le32 rate_limit;
+	__le32 chan_addr_low;
+	__le32 chan_addr_high;
+	__le32 chan_size;
+	__le32 db_addr_low;
+	__le32 db_addr_high;
+	__le32 db_set_lmask;
+	__le32 db_set_hmask;
+	__le32 db_preserve_lmask;
+	__le32 db_preserve_hmask;
+};
+
+struct scmi_fc_db_info {
+	int width;
+	u64 set;
+	u64 mask;
+	void __iomem *addr;
+};
+
+struct scmi_fc_info {
+	void __iomem *level_set_addr;
+	void __iomem *limit_set_addr;
+	void __iomem *level_get_addr;
+	void __iomem *limit_get_addr;
+	struct scmi_fc_db_info *level_set_db;
+	struct scmi_fc_db_info *limit_set_db;
+};
+
 struct perf_dom_info {
 	bool set_limits;
 	bool set_perf;
 	bool perf_limit_notify;
 	bool perf_level_notify;
+	bool perf_fastchannels;
 	u32 opp_count;
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
 	u32 mult_factor;
 	char name[SCMI_MAX_STR_SIZE];
 	struct scmi_opp opp[MAX_OPPS];
+	struct scmi_fc_info *fc_info;
 };
 
 struct scmi_perf_info {
@@ -162,6 +205,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
 		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
 		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
+		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
 		dom_info->sustained_freq_khz =
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
@@ -250,7 +294,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 }
 
 static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
-				u32 max_perf, u32 min_perf)
+				   u32 max_perf, u32 min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -273,7 +317,7 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 }
 
 static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
-				u32 *max_perf, u32 *min_perf)
+				   u32 *max_perf, u32 *min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -299,7 +343,7 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 }
 
 static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
-			       u32 level, bool poll)
+				  u32 level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -322,7 +366,7 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 }
 
 static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
-			       u32 *level, bool poll)
+				  u32 *level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -343,6 +387,104 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
+static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
+{
+	if ((msg == PERF_LEVEL_GET || msg == PERF_LEVEL_SET) && size == 4)
+		return true;
+	if ((msg == PERF_LIMITS_GET || msg == PERF_LIMITS_SET) && size == 8)
+		return true;
+	return false;
+}
+
+static void
+scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
+			 u32 message_id, void __iomem **p_addr,
+			 struct scmi_fc_db_info **p_db)
+{
+	int ret;
+	u32 flags;
+	u64 phys_addr;
+	u8 size;
+	void __iomem *addr;
+	struct scmi_xfer *t;
+	struct scmi_fc_db_info *db;
+	struct scmi_perf_get_fc_info *info;
+	struct scmi_msg_resp_perf_desc_fc *resp;
+
+	if (!p_addr)
+		return;
+
+	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_FASTCHANNEL,
+				 SCMI_PROTOCOL_PERF,
+				 sizeof(*info), sizeof(*resp), &t);
+	if (ret)
+		return;
+
+	info = t->tx.buf;
+	info->domain = cpu_to_le32(domain);
+	info->message_id = cpu_to_le32(message_id);
+
+	ret = scmi_do_xfer(handle, t);
+	if (ret)
+		goto err_xfer;
+
+	resp = t->rx.buf;
+	flags = le32_to_cpu(resp->attr);
+	size = le32_to_cpu(resp->chan_size);
+	if (!scmi_perf_fc_size_is_valid(message_id, size))
+		goto err_xfer;
+
+	phys_addr = le32_to_cpu(resp->chan_addr_low);
+	phys_addr |= (u64)le32_to_cpu(resp->chan_addr_high) << 32;
+	addr = devm_ioremap(handle->dev, phys_addr, size);
+	if (!addr)
+		goto err_xfer;
+	*p_addr = addr;
+
+	if (p_db && SUPPORTS_DOORBELL(flags)) {
+		db = devm_kzalloc(handle->dev, sizeof(*db), GFP_KERNEL);
+		if (!db)
+			goto err_xfer;
+
+		size = 1 << DOORBELL_REG_WIDTH(flags);
+		phys_addr = le32_to_cpu(resp->db_addr_low);
+		phys_addr |= (u64)le32_to_cpu(resp->db_addr_high) << 32;
+		addr = devm_ioremap(handle->dev, phys_addr, size);
+		if (!addr)
+			goto err_xfer;
+
+		db->addr = addr;
+		db->width = size;
+		db->set = le32_to_cpu(resp->db_set_lmask);
+		db->set |= (u64)le32_to_cpu(resp->db_set_hmask) << 32;
+		db->mask = le32_to_cpu(resp->db_preserve_lmask);
+		db->mask |= (u64)le32_to_cpu(resp->db_preserve_hmask) << 32;
+		*p_db = db;
+	}
+err_xfer:
+	scmi_xfer_put(handle, t);
+}
+
+static void scmi_perf_domain_init_fc(const struct scmi_handle *handle,
+				     u32 domain, struct scmi_fc_info **p_fc)
+{
+	struct scmi_fc_info *fc;
+
+	fc = devm_kzalloc(handle->dev, sizeof(*fc), GFP_KERNEL);
+	if (!fc)
+		return;
+
+	scmi_perf_domain_desc_fc(handle, domain, PERF_LEVEL_SET,
+				 &fc->level_set_addr, &fc->level_set_db);
+	scmi_perf_domain_desc_fc(handle, domain, PERF_LEVEL_GET,
+				 &fc->level_get_addr, NULL);
+	scmi_perf_domain_desc_fc(handle, domain, PERF_LIMITS_SET,
+				 &fc->limit_set_addr, &fc->limit_set_db);
+	scmi_perf_domain_desc_fc(handle, domain, PERF_LIMITS_GET,
+				 &fc->limit_get_addr, NULL);
+	*p_fc = fc;
+}
+
 /* Device specific ops */
 static int scmi_dev_domain_id(struct device *dev)
 {
@@ -494,6 +636,9 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 
 		scmi_perf_domain_attributes_get(handle, domain, dom);
 		scmi_perf_describe_levels_get(handle, domain, dom);
+
+		if (dom->perf_fastchannels)
+			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
 	}
 
 	handle->perf_ops = &perf_ops;
-- 
2.17.1

