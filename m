Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55ADC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C512467E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLRLS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:18:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826A731B;
        Wed, 18 Dec 2019 03:17:48 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3A443F6CF;
        Wed, 18 Dec 2019 03:17:47 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 01/11] firmware: arm_scmi: Add support for multiple device per protocol
Date:   Wed, 18 Dec 2019 11:17:32 +0000
Message-Id: <20191218111742.29731-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218111742.29731-1-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only one scmi device is created for each protocol enumerated.
However, there is requirement to make use of some procotols by multiple
kernel subsystems/frameworks. One such example is SCMI PERFORMANCE
protocol which can be used by both cpufreq and devfreq drivers.
Similarly, SENSOR protocol may be used by hwmon and iio subsystems,
and POWER protocol may be used by genpd and regulator drivers.

In order to achieve that, let us extend the scmi bus to match based
not only protocol id but also the scmi device name if one is available.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 20 +++++++++++++++++---
 drivers/firmware/arm_scmi/driver.c |  6 +++---
 include/linux/scmi_protocol.h      |  5 ++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 7a30952b463d..3714e6307b05 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -28,8 +28,12 @@ scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 		return NULL;
 
 	for (; id->protocol_id; id++)
-		if (id->protocol_id == scmi_dev->protocol_id)
-			return id;
+		if (id->protocol_id == scmi_dev->protocol_id) {
+			if (!id->name)
+				return id;
+			else if (!strcmp(id->name, scmi_dev->name))
+				return id;
+		}
 
 	return NULL;
 }
@@ -125,7 +129,8 @@ static void scmi_device_release(struct device *dev)
 }
 
 struct scmi_device *
-scmi_device_create(struct device_node *np, struct device *parent, int protocol)
+scmi_device_create(struct device_node *np, struct device *parent, int protocol,
+		   const char *name)
 {
 	int id, retval;
 	struct scmi_device *scmi_dev;
@@ -134,8 +139,15 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 	if (!scmi_dev)
 		return NULL;
 
+	scmi_dev->name = kstrdup_const(name ?: "unknown", GFP_KERNEL);
+	if (!scmi_dev->name) {
+		kfree(scmi_dev);
+		return NULL;
+	}
+
 	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
 	if (id < 0) {
+		kfree_const(scmi_dev->name);
 		kfree(scmi_dev);
 		return NULL;
 	}
@@ -154,6 +166,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 
 	return scmi_dev;
 put_dev:
+	kfree_const(scmi_dev->name);
 	put_device(&scmi_dev->dev);
 	ida_simple_remove(&scmi_bus_id, id);
 	return NULL;
@@ -161,6 +174,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
+	kfree_const(scmi_dev->name);
 	scmi_handle_put(scmi_dev->handle);
 	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
 	device_unregister(&scmi_dev->dev);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3eb0382491ce..dee7ce3bd815 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -803,11 +803,11 @@ scmi_mbox_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
 
 static inline void
 scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
-			    int prot_id)
+			    int prot_id, const char *name)
 {
 	struct scmi_device *sdev;
 
-	sdev = scmi_device_create(np, info->dev, prot_id);
+	sdev = scmi_device_create(np, info->dev, prot_id, name);
 	if (!sdev) {
 		dev_err(info->dev, "failed to create %d protocol device\n",
 			prot_id);
@@ -892,7 +892,7 @@ static int scmi_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		scmi_create_protocol_device(child, info, prot_id);
+		scmi_create_protocol_device(child, info, prot_id, NULL);
 	}
 
 	return 0;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 881fea47c83d..5c873a59b387 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -257,6 +257,7 @@ enum scmi_std_protocol {
 struct scmi_device {
 	u32 id;
 	u8 protocol_id;
+	const char *name;
 	struct device dev;
 	struct scmi_handle *handle;
 };
@@ -264,11 +265,13 @@ struct scmi_device {
 #define to_scmi_dev(d) container_of(d, struct scmi_device, dev)
 
 struct scmi_device *
-scmi_device_create(struct device_node *np, struct device *parent, int protocol);
+scmi_device_create(struct device_node *np, struct device *parent, int protocol,
+		   const char *name);
 void scmi_device_destroy(struct scmi_device *scmi_dev);
 
 struct scmi_device_id {
 	u8 protocol_id;
+	const char *name;
 };
 
 struct scmi_driver {
-- 
2.17.1

