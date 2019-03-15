Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56688C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFBB21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfCOJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:32:16 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:15474 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727242AbfCOJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:32:16 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 05:32:15 EDT
X-IronPort-AV: E=Sophos;i="5.58,481,1544466600"; 
   d="scan'208";a="381264"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2019 14:55:57 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9195"; a="7162626"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Mar 2019 14:55:56 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id 71F453A08; Fri, 15 Mar 2019 14:55:55 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH] nvmem: core: Set no-read-write provider to avoid userspace read/write
Date:   Fri, 15 Mar 2019 14:55:37 +0530
Message-Id: <1552641937-19444-1-git-send-email-gkohli@codeaurora.org>
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

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b..edd0e9f 100644
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
@@ -120,6 +121,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 		dev = container_of(kobj, struct device, kobj);
 	nvmem = to_nvmem_device(dev);
 
+	/* if no-read-write, then stop from reading */
+	if (nvmem->no_read_write)
+		return -EPERM;
 	/* Stop the user from reading */
 	if (pos >= nvmem->size)
 		return 0;
@@ -154,6 +158,10 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 		dev = container_of(kobj, struct device, kobj);
 	nvmem = to_nvmem_device(dev);
 
+	/* if no-read-write, then stop from writing */
+	if (nvmem->no_read_write)
+		return -EPERM;
+
 	/* Stop the user from writing */
 	if (pos >= nvmem->size)
 		return -EFBIG;
@@ -651,6 +659,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
+	nvmem->no_read_write = of_property_read_bool(np, "no-read-write") |
+			   config->read_only;
 	if (config->root_only)
 		nvmem->dev.groups = nvmem->read_only ?
 			nvmem_ro_root_dev_groups :
-- 
1.9.1

