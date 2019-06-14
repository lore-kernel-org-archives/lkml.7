Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B29C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0621873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfFNRzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbfFNRz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1686F11B3;
        Fri, 14 Jun 2019 10:55:25 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC39D3F718;
        Fri, 14 Jun 2019 10:55:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v2 22/28] drivers: Introduce driver_find_device_by_name() helper
Date:   Fri, 14 Jun 2019 18:54:17 +0100
Message-Id: <1560534863-15115-23-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to driver_find_device() to search for a device
by name, similar to the other iterators, reusing the generic
match function. Also convert the existing users to make use of
the new helper.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/s390/cio/ccwgroup.c | 10 +---------
 drivers/s390/cio/device.c   | 17 +----------------
 include/linux/device.h      | 12 ++++++++++++
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index ea176157..d843e36 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -608,13 +608,6 @@ void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
 }
 EXPORT_SYMBOL(ccwgroup_driver_unregister);
 
-static int __ccwgroupdev_check_busid(struct device *dev, const void *id)
-{
-	char *bus_id = id;
-
-	return (strcmp(bus_id, dev_name(dev)) == 0);
-}
-
 /**
  * get_ccwgroupdev_by_busid() - obtain device from a bus id
  * @gdrv: driver the device is owned by
@@ -631,8 +624,7 @@ struct ccwgroup_device *get_ccwgroupdev_by_busid(struct ccwgroup_driver *gdrv,
 {
 	struct device *dev;
 
-	dev = driver_find_device(&gdrv->driver, NULL, bus_id,
-				 __ccwgroupdev_check_busid);
+	dev = driver_find_device_by_name(&gdrv->driver, bus_id);
 
 	return dev ? to_ccwgroupdev(dev) : NULL;
 }
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index f27536b..df29d7e 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1649,20 +1649,6 @@ int ccw_device_force_console(struct ccw_device *cdev)
 EXPORT_SYMBOL_GPL(ccw_device_force_console);
 #endif
 
-/*
- * get ccw_device matching the busid, but only if owned by cdrv
- */
-static int
-__ccwdev_check_busid(struct device *dev, const void *id)
-{
-	char *bus_id;
-
-	bus_id = id;
-
-	return (strcmp(bus_id, dev_name(dev)) == 0);
-}
-
-
 /**
  * get_ccwdev_by_busid() - obtain device from a bus id
  * @cdrv: driver the device is owned by
@@ -1679,8 +1665,7 @@ struct ccw_device *get_ccwdev_by_busid(struct ccw_driver *cdrv,
 {
 	struct device *dev;
 
-	dev = driver_find_device(&cdrv->driver, NULL, (void *)bus_id,
-				 __ccwdev_check_busid);
+	dev = driver_find_device_by_name(&cdrv->driver, bus_id);
 
 	return dev ? to_ccwdev(dev) : NULL;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 6768e2b..0d3958e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -425,6 +425,18 @@ struct device *driver_find_device(struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data));
 
+/**
+ * driver_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @driver: the driver we're iterating
+ * @name: name of the device to match
+ */
+static inline struct device *driver_find_device_by_name(struct device_driver *drv,
+							const char *name)
+{
+	return driver_find_device(drv, NULL, name, device_match_name);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

