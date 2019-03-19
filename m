Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C220700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCSCRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:17:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfCSCRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:17:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32830FAC35E48175F806;
        Tue, 19 Mar 2019 10:17:04 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 10:16:58 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <idosch@mellanox.com>,
        <alexander.h.duyck@intel.com>, <tyhicks@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net-sysfs: call dev_hold if kobject_init_and_add success
Date:   Tue, 19 Mar 2019 10:16:53 +0800
Message-ID: <20190319021653.2584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

In netdev_queue_add_kobject and rx_queue_add_kobject,
if sysfs_create_group failed, kobject_put will call
netdev_queue_release to decrease dev refcont, however
dev_hold has not be called. So we will see this while
unregistering dev:

unregister_netdevice: waiting for bcsh0 to become free. Usage count = -1

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: d0d668371679 ("net: don't decrement kobj reference count on init failure")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/core/net-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4ff661f..8f8b7b6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -928,6 +928,8 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		return error;
 
+	dev_hold(queue->dev);
+
 	if (dev->sysfs_rx_queue_group) {
 		error = sysfs_create_group(kobj, dev->sysfs_rx_queue_group);
 		if (error) {
@@ -937,7 +939,6 @@ static int rx_queue_add_kobject(struct net_device *dev, int index)
 	}
 
 	kobject_uevent(kobj, KOBJ_ADD);
-	dev_hold(queue->dev);
 
 	return error;
 }
@@ -1464,6 +1465,8 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 	if (error)
 		return error;
 
+	dev_hold(queue->dev);
+
 #ifdef CONFIG_BQL
 	error = sysfs_create_group(kobj, &dql_group);
 	if (error) {
@@ -1473,7 +1476,6 @@ static int netdev_queue_add_kobject(struct net_device *dev, int index)
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);
-	dev_hold(queue->dev);
 
 	return 0;
 }
-- 
2.7.0


