Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59807C2D0C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69A2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfLJOyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:54:21 -0500
Received: from foss.arm.com ([217.140.110.172]:47158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLJOyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15AA328;
        Tue, 10 Dec 2019 06:54:12 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E95E3F67D;
        Tue, 10 Dec 2019 06:54:12 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 09/15] firmware: arm_scmi: Add scmi protocol version and id device attributes
Date:   Tue, 10 Dec 2019 14:53:39 +0000
Message-Id: <20191210145345.11616-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel bus driver management layer provides way to add set of
default attributes of the devices on the bus. Using the same, let's add
the scmi per protocol version and id attributes to the sysfs.

It helps to identify the individual protocol details from the sysfs
entries similar to the SCMI protocol and firmware version.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f619da2634a6..ed0ed02f7158 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -92,11 +92,38 @@ static int scmi_dev_remove(struct device *dev)
 	return 0;
 }

+static ssize_t protocol_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scmi_device *scmi_dev = to_scmi_dev(dev);
+
+	return sprintf(buf, "%u.%u\n", PROTOCOL_REV_MAJOR(scmi_dev->version),
+		       PROTOCOL_REV_MINOR(scmi_dev->version));
+}
+static DEVICE_ATTR_RO(protocol_version);
+
+static ssize_t protocol_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct scmi_device *scmi_dev = to_scmi_dev(dev);
+
+	return sprintf(buf, "%u\n", scmi_dev->protocol_id);
+}
+static DEVICE_ATTR_RO(protocol_id);
+
+static struct attribute *versions_attrs[] = {
+	&dev_attr_protocol_version.attr,
+	&dev_attr_protocol_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(versions);
+
 static struct bus_type scmi_bus_type = {
 	.name =	"scmi_protocol",
 	.match = scmi_dev_match,
 	.probe = scmi_dev_probe,
 	.remove = scmi_dev_remove,
+	.dev_groups = versions_groups,
 };

 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
--
2.17.1

