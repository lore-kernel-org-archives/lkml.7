Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87B7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6852467E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfLRLS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:18:27 -0500
Received: from foss.arm.com ([217.140.110.172]:42356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLRLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50A6E11B3;
        Wed, 18 Dec 2019 03:17:50 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1DF33F6CF;
        Wed, 18 Dec 2019 03:17:49 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 03/11] firmware: arm_scmi: Add names to scmi devices created
Date:   Wed, 18 Dec 2019 11:17:34 +0000
Message-Id: <20191218111742.29731-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218111742.29731-1-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that scmi bus provides option to create named scmi device, let us
create the default devices with names. This will help to add names for
matching to respective drivers and eventually to add multiple devices
and drivers per protocol.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 36 +++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 2952fcd8dd8a..0bbdc7c9eb0f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -829,6 +829,40 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 	scmi_set_handle(sdev);
 }
 
+#define MAX_SCMI_DEV_PER_PROTOCOL	2
+struct scmi_prot_devnames {
+	int protocol_id;
+	char *names[MAX_SCMI_DEV_PER_PROTOCOL];
+};
+
+static struct scmi_prot_devnames devnames[] = {
+	{ SCMI_PROTOCOL_POWER,  { "genpd" },},
+	{ SCMI_PROTOCOL_PERF,   { "cpufreq" },},
+	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
+	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
+	{ SCMI_PROTOCOL_RESET,  { "reset" },},
+};
+
+static inline void
+scmi_create_protocol_devices(struct device_node *np, struct scmi_info *info,
+			     int prot_id)
+{
+	int loop, cnt;
+
+	for (loop = 0; loop < ARRAY_SIZE(devnames); loop++) {
+		if (devnames[loop].protocol_id != prot_id)
+			continue;
+
+		for (cnt = 0; cnt < ARRAY_SIZE(devnames[loop].names); cnt++) {
+			const char *name = devnames[loop].names[cnt];
+
+			if (name)
+				scmi_create_protocol_device(np, info, prot_id,
+							    name);
+		}
+	}
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -897,7 +931,7 @@ static int scmi_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		scmi_create_protocol_device(child, info, prot_id, NULL);
+		scmi_create_protocol_devices(child, info, prot_id);
 	}
 
 	return 0;
-- 
2.17.1

