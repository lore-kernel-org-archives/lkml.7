Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E64CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6675B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfCAFiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:38:12 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42688 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728007AbfCAFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:38:09 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Mar 2019 07:38:04 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x215brYX016903;
        Fri, 1 Mar 2019 07:38:01 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com
Cc:     parav@mellanox.com
Subject: [RFC net-next 2/8] subdev: Introduce pm callbacks
Date:   Thu, 28 Feb 2019 23:37:46 -0600
Message-Id: <1551418672-12822-3-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551418672-12822-1-git-send-email-parav@mellanox.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep power management callbacks in place to optionally notify drivers
who register them.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/subdev/subdev_main.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/subdev/subdev_main.c b/drivers/subdev/subdev_main.c
index 4aabcaa..e213331 100644
--- a/drivers/subdev/subdev_main.c
+++ b/drivers/subdev/subdev_main.c
@@ -23,10 +23,69 @@ static int subdev_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
+static int subdev_pm_prepare(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->prepare)
+		return dev->driver->pm->prepare(dev);
+	return 0;
+}
+
+static void subdev_pm_complete(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->complete)
+		dev->driver->pm->complete(dev);
+}
+
+static int subdev_pm_suspend(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->suspend)
+		return dev->driver->pm->suspend(dev);
+	return 0;
+}
+
+static int subdev_pm_suspend_late(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->suspend_late)
+		return dev->driver->pm->suspend_late(dev);
+	return 0;
+}
+
+static int subdev_pm_resume(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->resume)
+		return dev->driver->pm->resume(dev);
+	return 0;
+}
+
+static int subdev_pm_freeze(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->freeze)
+		return dev->driver->pm->freeze(dev);
+	return 0;
+}
+
+static int subdev_pm_freeze_late(struct device *dev)
+{
+	if (dev->driver->pm && dev->driver->pm->freeze_late)
+		return dev->driver->pm->freeze_late(dev);
+	return 0;
+}
+
+static const struct dev_pm_ops subdev_dev_pm_ops = {
+	.prepare = subdev_pm_prepare,
+	.complete = subdev_pm_complete,
+	.suspend = subdev_pm_suspend,
+	.suspend_late = subdev_pm_suspend_late,
+	.resume = subdev_pm_resume,
+	.freeze = subdev_pm_freeze,
+	.freeze_late = subdev_pm_freeze_late,
+};
+
 static struct bus_type subdev_bus_type = {
 	.dev_name = "subdev",
 	.name = "subdev",
 	.match = subdev_bus_match,
+	.pm = &subdev_dev_pm_ops,
 };
 
 int __subdev_register_driver(struct subdev_driver *drv, struct module *owner,
-- 
1.8.3.1

