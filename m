Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3605BC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6B72184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfFNRzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:24 -0400
Received: from foss.arm.com ([217.140.110.172]:39624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfFNRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3124DCFC;
        Fri, 14 Jun 2019 10:55:21 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1358C3F718;
        Fri, 14 Jun 2019 10:55:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, linux-usb@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 19/28] drivers: Introduce bus_find_device_by_devt() helper
Date:   Fri, 14 Jun 2019 18:54:14 +0100
Message-Id: <1560534863-15115-20-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to bus_find_device() to search for a device
by the device type, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/intel_th/core.c | 10 +---------
 drivers/usb/core/devio.c          |  8 +-------
 include/linux/device.h            | 12 ++++++++++++
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 5592289..d5c1821 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -789,12 +789,6 @@ static int intel_th_populate(struct intel_th *th)
 	return 0;
 }
 
-static int match_devt(struct device *dev, const void *data)
-{
-	dev_t devt = (dev_t)(unsigned long)(void *)data;
-	return dev->devt == devt;
-}
-
 static int intel_th_output_open(struct inode *inode, struct file *file)
 {
 	const struct file_operations *fops;
@@ -802,9 +796,7 @@ static int intel_th_output_open(struct inode *inode, struct file *file)
 	struct device *dev;
 	int err;
 
-	dev = bus_find_device(&intel_th_bus, NULL,
-			      (void *)(unsigned long)inode->i_rdev,
-			      match_devt);
+	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
 	if (!dev || !dev->driver)
 		return -ENODEV;
 
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 7bd7de7..4e83623 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -947,17 +947,11 @@ static int parse_usbdevfs_streams(struct usb_dev_state *ps,
 	return ret;
 }
 
-static int match_devt(struct device *dev, const void *data)
-{
-	return dev->devt == (dev_t)(unsigned long)(void *)data;
-}
-
 static struct usb_device *usbdev_lookup_by_devt(dev_t devt)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&usb_bus_type, NULL,
-			      (void *) (unsigned long) devt, match_devt);
+	dev = bus_find_device_by_devt(&usb_bus_type, devt);
 	if (!dev)
 		return NULL;
 	return to_usb_device(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 576d84f..3c244ac 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -213,6 +213,18 @@ bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwno
 	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
 }
 
+/**
+ * bus_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @bus: bus type
+ * @devt: device type of the device to match.
+ */
+static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
+						     dev_t devt)
+{
+	return bus_find_device(bus, NULL, &devt, device_match_devt);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

