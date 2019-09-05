Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EAC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7442087E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfIEBgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:36:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730319AbfIEBgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:36:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 667A8EDCB025FADB7E54;
        Thu,  5 Sep 2019 09:36:14 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 09:36:07 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <mhocko@kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH RFC] driver core: ensure a device has valid node id in device_add()
Date:   Thu, 5 Sep 2019 09:33:50 +0800
Message-ID: <1567647230-166903-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a device does not belong to any of the numa nodes
(dev->numa_node is NUMA_NO_NODE) when the FW does not provide
the node id and the device has not no parent device.

According to discussion in [1]:
Even if a device's numa node is not set by fw, the device
really does belong to a node.

This patch sets the device node to node 0 in device_add() if
the fw has not specified the node id and it either has no
parent device, or the parent device also does not have a valid
node id.

There may be explicit handling out there relying on NUMA_NO_NODE,
like in nvme_probe().

[1] https://lkml.org/lkml/2019/9/2/466

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/base/core.c  | 17 ++++++++++++++---
 include/linux/numa.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1669d41..466b8ff 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2107,9 +2107,20 @@ int device_add(struct device *dev)
 	if (kobj)
 		dev->kobj.parent = kobj;
 
-	/* use parent numa_node */
-	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
-		set_dev_node(dev, dev_to_node(parent));
+	/* use parent numa_node or default node 0 */
+	if (!numa_node_valid(dev_to_node(dev))) {
+		int nid = parent ? dev_to_node(parent) : NUMA_NO_NODE;
+
+		if (numa_node_valid(nid)) {
+			set_dev_node(dev, nid);
+		} else {
+			if (nr_node_ids > 1U)
+				pr_err("device: '%s': has invalid NUMA node(%d)\n",
+				       dev_name(dev), dev_to_node(dev));
+
+			set_dev_node(dev, 0);
+		}
+	}
 
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 110b0e5..eccc757 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,4 +13,6 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+#define numa_node_valid(node)	((unsigned int)(node) < nr_node_ids)
+
 #endif /* _LINUX_NUMA_H */
-- 
2.8.1

