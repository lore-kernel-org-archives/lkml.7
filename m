Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D386EC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7142067D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfIIGG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:06:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfIIGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:06:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 186672B77F3E256462AD;
        Mon,  9 Sep 2019 14:06:49 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 9 Sep 2019 14:06:40 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>, <mhocko@kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] driver core: ensure a device has valid node id in device_add()
Date:   Mon, 9 Sep 2019 14:04:23 +0800
Message-ID: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
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
(dev->numa_node is NUMA_NO_NODE) when the node id is neither
specified by fw nor by virtual device layer and the device has
no parent device.

According to discussion in [1]:
Even if a device's numa node is not specified, the device really
does belong to a node.

This patch sets the device node to node 0 in device_add() if the
device's node id is not specified and it either has no parent
device, or the parent device also does not have a valid node id.

[1] https://lkml.org/lkml/2019/9/2/466

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
Changelog RFC -> v1:
1. Drop log error message and use a "if" instead of "? :".
2. Drop the RFC tag.
---
 drivers/base/core.c  | 10 +++++++---
 include/linux/numa.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1669d41..f79ad20 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2107,9 +2107,13 @@ int device_add(struct device *dev)
 	if (kobj)
 		dev->kobj.parent = kobj;
 
-	/* use parent numa_node */
-	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
-		set_dev_node(dev, dev_to_node(parent));
+	/* use parent numa_node or default node 0 */
+	if (!numa_node_valid(dev_to_node(dev))) {
+		if (parent && numa_node_valid(dev_to_node(parent)))
+			set_dev_node(dev, dev_to_node(parent));
+		else
+			set_dev_node(dev, 0);
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

