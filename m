Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EC920693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qgPkTK+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfC2Jju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:39:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10549 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2Jjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1553852388; x=1585388388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fXLVY5+2nhXhJKp1ggMduny1m+DljsbrpPUJj33lapM=;
  b=qgPkTK+tl1QAFQdzJztCMGMiSFZO08QXBz0q9YLwD4RqBx+VQjrTHIwo
   +geW9WWlUsNDB0NUzJlVDsbKHyfwHcvUl8FmUP+R7JN9wNkaAemG6nISW
   aIjA/pjy5KosYFxsoGge4VfkIfqOpBhGj1VCe/AxTD3lCopA9gQ6E1oq8
   g=;
X-IronPort-AV: E=Sophos;i="5.60,284,1549929600"; 
   d="scan'208";a="388115262"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2019 09:39:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2T9dfG1095115
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:39:43 GMT
Received: from EX13D18EUC001.ant.amazon.com (10.43.164.108) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Mar 2019 09:39:41 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D18EUC001.ant.amazon.com (10.43.164.108) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Mar 2019 09:39:40 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 29 Mar 2019 09:39:39 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id 3185D247D4; Fri, 29 Mar 2019 09:39:39 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] nvme: add sysfs controls for io and admin timeouts
Date:   Fri, 29 Mar 2019 09:39:21 +0000
Message-ID: <20190329093921.95710-2-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20190329093921.95710-1-mheyne@amazon.de>
References: <20190329093921.95710-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two sysfs files for reading and updating the admin and io timeouts
of individual NVMe devices. For this, two new nvme_ctrl_ops were added
to update the respective timeouts. This patch implements these ops for
the pci nvme driver. Therefore, only the timeouts for PCI NVMe devices
can be updated.

Original-patch-by: Milan Pandurov <milanpa@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 28 ++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0530bf7a677..f77201c508fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2768,6 +2768,74 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t io_timeout_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->io_timeout/HZ);
+}
+
+static ssize_t io_timeout_store(struct device *dev,
+	struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int timeout;
+	int ret;
+
+	ret = kstrtouint(buf, 10u, &timeout);
+	if (ret == -EINVAL) {
+		dev_warn(ctrl->dev, "Error parsing timeout value.\n");
+		return ret;
+	}
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX/HZ) {
+		dev_warn(ctrl->dev,
+			"Timeout value out of range (0 < timeout <= %u).\n",
+			UINT_MAX/HZ);
+		return -ERANGE;
+	}
+	ret = ctrl->ops->set_io_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(io_timeout);
+
+static ssize_t admin_timeout_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->admin_timeout/HZ);
+}
+
+static ssize_t admin_timeout_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int timeout;
+	int ret;
+
+	ret = kstrtouint(buf, 10u, &timeout);
+	if (ret == -EINVAL) {
+		dev_warn(ctrl->dev, "Error parsing timeout value.\n");
+		return ret;
+	}
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX/HZ) {
+		dev_warn(ctrl->dev,
+			"Timeout value out of range (0 < timeout <= %u).\n",
+			UINT_MAX/HZ);
+		return -ERANGE;
+	}
+	ret = ctrl->ops->set_admin_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(admin_timeout);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -3008,6 +3076,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_io_timeout.attr,
+	&dev_attr_admin_timeout.attr,
 	NULL
 };
 
@@ -3021,6 +3091,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
+	if (a == &dev_attr_io_timeout.attr && !ctrl->ops->set_io_timeout)
+		return 0;
+	if (a == &dev_attr_admin_timeout.attr && !ctrl->ops->set_admin_timeout)
+		return 0;
 
 	return a->mode;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1397650edfda..4dc13c5990bd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -367,6 +367,8 @@ struct nvme_ctrl_ops {
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
+	int (*set_io_timeout)(struct nvme_ctrl *ctrl, unsigned int timeout);
+	int (*set_admin_timeout)(struct nvme_ctrl *ctrl, unsigned int timeout);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 16d7a00fecf0..6932895c3519 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2647,6 +2647,32 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
 }
 
+static int nvme_pci_set_io_timeout(struct nvme_ctrl *ctrl, unsigned int timeout)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	struct nvme_ns *ns;
+
+	ctrl->io_timeout = timeout;
+	dev->tagset.timeout = timeout;
+	down_write(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		blk_queue_rq_timeout(ns->queue, timeout);
+	}
+	up_write(&ctrl->namespaces_rwsem);
+	return 0;
+}
+
+static int nvme_pci_set_admin_timeout(struct nvme_ctrl *ctrl,
+	unsigned int timeout)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	ctrl->admin_timeout = timeout;
+	dev->admin_tagset.timeout = timeout;
+	blk_queue_rq_timeout(ctrl->admin_q, timeout);
+	return 0;
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2655,6 +2681,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
+	.set_io_timeout		= nvme_pci_set_io_timeout,
+	.set_admin_timeout	= nvme_pci_set_admin_timeout,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


