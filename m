Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1E124680
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLRLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:17:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLRLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349A030E;
        Wed, 18 Dec 2019 03:17:51 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85D8B3F6CF;
        Wed, 18 Dec 2019 03:17:50 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 04/11] firmware: arm_scmi: Add versions and identifier attributes using dev_groups
Date:   Wed, 18 Dec 2019 11:17:35 +0000
Message-Id: <20191218111742.29731-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218111742.29731-1-sudeep.holla@arm.com>
References: <20191218111742.29731-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files. Using the same, let's add
the scmi firmware and protocol version attributes as well as vendor and
sub-vendor identifiers to sysfs.

It helps to identify the firmware details from the sysfs entries similar
to ARM SCPI implementation.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0bbdc7c9eb0f..26b2c438bd59 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -979,6 +979,52 @@ static int scmi_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static ssize_t protocol_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u.%u\n", info->version.major_ver,
+		       info->version.minor_ver);
+}
+static DEVICE_ATTR_RO(protocol_version);
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%x\n", info->version.impl_ver);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t vendor_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", info->version.vendor_id);
+}
+static DEVICE_ATTR_RO(vendor_id);
+
+static ssize_t sub_vendor_id_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", info->version.sub_vendor_id);
+}
+static DEVICE_ATTR_RO(sub_vendor_id);
+
+static struct attribute *versions_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_protocol_version.attr,
+	&dev_attr_vendor_id.attr,
+	&dev_attr_sub_vendor_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(versions);
+
 static const struct scmi_desc scmi_generic_desc = {
 	.max_rx_timeout_ms = 30,	/* We may increase this if required */
 	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
@@ -997,6 +1043,7 @@ static struct platform_driver scmi_driver = {
 	.driver = {
 		   .name = "arm-scmi",
 		   .of_match_table = scmi_of_match,
+		   .dev_groups = versions_groups,
 		   },
 	.probe = scmi_probe,
 	.remove = scmi_remove,
-- 
2.17.1

