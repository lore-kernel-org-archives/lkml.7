Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89024C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AB12184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCTFx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:53:27 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:24848 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbfCTFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:53:26 -0400
X-IronPort-AV: E=Sophos;i="5.60,247,1549909800"; 
   d="scan'208";a="454358"
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Mar 2019 11:23:23 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9200"; a="7284346"
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg02-blr.qualcomm.com with ESMTP; 20 Mar 2019 11:23:23 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id 933EB3B35; Wed, 20 Mar 2019 11:23:22 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Shiraz Hashim <shashim@codeaurora.org>,
        Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH v0] nvmem: core: Export nvmem cell info to userspace
Date:   Wed, 20 Mar 2019 11:23:21 +0530
Message-Id: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiraz Hashim <shashim@codeaurora.org>

Existing nvmem framework export full register space
as nvmem binary, but not exporting child node of nvmem
which is nvmem cell. Kernel can read the specific cell
by using nvmem_cell_read but userspace don't have such
provision.

Add framework to export nvmem cell as well, So
userspace can use it directly.

Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b..e4b6160 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -47,6 +47,7 @@ struct nvmem_cell {
 	int			nbits;
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
+	struct bin_attribute	attr;
 	struct list_head	node;
 };
 
@@ -99,6 +100,27 @@ static ssize_t type_show(struct device *dev,
 	return sprintf(buf, "%s\n", nvmem_type_str[nvmem->type]);
 }
 
+static ssize_t bin_attr_nvmem_cell_read(struct file *filp, struct kobject *kobj,
+				    struct bin_attribute *attr,
+				    char *buf, loff_t pos, size_t count)
+{
+	struct nvmem_cell *cell;
+	size_t len;
+	u8 *data;
+
+	if (attr->private)
+		cell = attr->private;
+	else
+		return -EINVAL;
+
+	data = nvmem_cell_read(cell, &len);
+
+	len = (len > count) ? count : len;
+	memcpy(buf, data, len);
+
+	return len;
+}
+
 static DEVICE_ATTR_RO(type);
 
 static struct attribute *nvmem_attrs[] = {
@@ -324,6 +346,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
 	mutex_lock(&nvmem_mutex);
+	device_remove_bin_file(&cell->nvmem->dev, &cell->attr);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
 	of_node_put(cell->np);
@@ -341,8 +364,24 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
 {
+	int rval;
+	struct bin_attribute *nvmem_cell_attr = &cell->attr;
+
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
+
+	/* add attr for this cell */
+	nvmem_cell_attr->attr.name = cell->name;
+	nvmem_cell_attr->attr.mode = 0400;
+	nvmem_cell_attr->private = cell;
+	nvmem_cell_attr->size = cell->bytes;
+	nvmem_cell_attr->read = bin_attr_nvmem_cell_read;
+	rval = device_create_bin_file(&cell->nvmem->dev, nvmem_cell_attr);
+	if (rval) {
+		dev_err(&cell->nvmem->dev,
+			"Failed to create cell binary file %d\n", rval);
+	}
+
 	mutex_unlock(&nvmem_mutex);
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
 }
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project.

