Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1920896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCQOM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:12:29 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:49034 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbfCQOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:12:28 -0400
X-IronPort-AV: E=Sophos;i="5.58,489,1544466600"; 
   d="scan'208";a="382997"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 17 Mar 2019 19:42:25 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9197"; a="7216260"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg02-blr.qualcomm.com with ESMTP; 17 Mar 2019 19:42:25 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id A394E3B22; Sun, 17 Mar 2019 19:42:23 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH v2] nvmem: core: Set no-read-write provider to avoid userspace read/write
Date:   Sun, 17 Mar 2019 19:42:20 +0530
Message-Id: <1552831940-7327-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current nvmem framework allows user space to read all register space
populated by nvmem binary file, In case we don't want to expose value
of registers to userspace and only want kernel space to read cell
value from nvmem_cell_read_u32.

To protect the same, Add no-read-write property to prevent read
from userspace.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
---
v2: Fix build error
v1: Fix no_read_write update condition

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b..f1c44fc 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -27,6 +27,7 @@ struct nvmem_device {
 	struct kref		refcnt;
 	size_t			size;
 	bool			read_only;
+	bool			no_read_write;
 	int			flags;
 	enum nvmem_type		type;
 	struct bin_attribute	eeprom;
@@ -120,6 +121,10 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 		dev = container_of(kobj, struct device, kobj);
 	nvmem = to_nvmem_device(dev);
 
+	/* if no-read-write, then stop from reading */
+	if (nvmem->no_read_write)
+		return -EPERM;
+
 	/* Stop the user from reading */
 	if (pos >= nvmem->size)
 		return 0;
@@ -154,6 +159,10 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 		dev = container_of(kobj, struct device, kobj);
 	nvmem = to_nvmem_device(dev);
 
+	/* if no-read-write, then stop from writing */
+	if (nvmem->no_read_write)
+		return -EPERM;
+
 	/* Stop the user from writing */
 	if (pos >= nvmem->size)
 		return -EFBIG;
@@ -651,6 +660,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
+	nvmem->no_read_write = device_property_present(config->dev,
+				"no-read-write");
+
 	if (config->root_only)
 		nvmem->dev.groups = nvmem->read_only ?
 			nvmem_ro_root_dev_groups :
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project.

