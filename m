Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34681C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15D42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="MEixlOLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDCMfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:35:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9305 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1554294949; x=1585830949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JRqXds9ZAZm0HBSHKnSoHAwcXr7kzVx6HWdB7I8dzJE=;
  b=MEixlOLQfjTeH+Ib6UcO492ESNoI8RaY/iTmGMyy8Q0OM7uhr52OgtZI
   XXowfDC48W17wDo1598PJstoU9qWdWn2sSK9rDfbVFq0avPi2ldK+HL5G
   H4cnerIcmq/kkXWWQHIEeHgPL6MOhdmxpUk/BDhCvZ1fITsHEI062vUIw
   w=;
X-IronPort-AV: E=Sophos;i="5.60,304,1549929600"; 
   d="scan'208";a="669117285"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 12:35:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x33CZgx9028922
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Apr 2019 12:35:45 GMT
Received: from EX13D18EUA002.ant.amazon.com (10.43.165.184) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D18EUA002.ant.amazon.com (10.43.165.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:44 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Apr 2019 12:35:43 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id EE04A29784; Wed,  3 Apr 2019 12:35:42 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] nvme: add sysfs controls for io and admin timeouts
Date:   Wed, 3 Apr 2019 12:35:06 +0000
Message-ID: <20190403123506.122904-3-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20190403123506.122904-1-mheyne@amazon.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two sysfs files for reading and updating the admin and io timeouts
of individual NVMe controllers.

The controller must be in the LIVE or ADMIN_ONLY state for this to work
so that setting timeouts doesn't race with the creation or deletion of
tagset, admin_tagset, admin_q and connect_q of nvme_ctrl.

Original-patch-by: Milan Pandurov <milanpa@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
v2: 
 - rework setting timeouts to work with all relevant nvme drivers
 - add check for state LIVE to not race with controller creation/deletion

 drivers/nvme/host/core.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0530bf7a677..51f359d78f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2768,6 +2768,116 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static int nvme_set_io_timeout(struct nvme_ctrl *ctrl, unsigned int timeout)
+{
+	struct nvme_ns *ns;
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE) {
+		ctrl->io_timeout = timeout;
+		if (ctrl->tagset)
+			ctrl->tagset->timeout = timeout;
+		if (ctrl->connect_q)
+			blk_queue_rq_timeout(ctrl->connect_q, timeout);
+
+		down_write(&ctrl->namespaces_rwsem);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			blk_queue_rq_timeout(ns->queue, timeout);
+		}
+		up_write(&ctrl->namespaces_rwsem);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
+}
+
+static int nvme_set_admin_timeout(struct nvme_ctrl *ctrl, unsigned int timeout)
+{
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_ADMIN_ONLY) {
+		ctrl->admin_timeout = timeout;
+		ctrl->admin_tagset->timeout = timeout;
+		blk_queue_rq_timeout(ctrl->admin_q, timeout);
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return ret;
+}
+
+static ssize_t io_timeout_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->io_timeout / HZ);
+}
+
+static ssize_t io_timeout_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
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
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX / HZ) {
+		dev_warn(ctrl->dev,
+			 "Timeout value out of range (0 < timeout <= %u).\n",
+			 UINT_MAX / HZ);
+		return -ERANGE;
+	}
+	ret = nvme_set_io_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(io_timeout);
+
+static ssize_t admin_timeout_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", ctrl->admin_timeout / HZ);
+}
+
+static ssize_t admin_timeout_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
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
+	if (ret == -ERANGE || timeout == 0 || timeout > UINT_MAX / HZ) {
+		dev_warn(ctrl->dev,
+			 "Timeout value out of range (0 < timeout <= %u).\n",
+			 UINT_MAX / HZ);
+		return -ERANGE;
+	}
+	ret = nvme_set_admin_timeout(ctrl, timeout * HZ);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+static DEVICE_ATTR_RW(admin_timeout);
+
 static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
@@ -3008,6 +3118,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_io_timeout.attr,
+	&dev_attr_admin_timeout.attr,
 	NULL
 };
 
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


