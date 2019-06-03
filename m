Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01300239D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfFCPwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbfFCPwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C7715AB;
        Mon,  3 Jun 2019 08:52:13 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3FD63F246;
        Mon,  3 Jun 2019 08:52:11 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [RFC PATCH 48/57] drivers: s390: cio: Use driver_find_by_name() helper
Date:   Mon,  3 Jun 2019 16:50:14 +0100
Message-Id: <1559577023-558-49-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new driver_find_by_name() helper.

Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/s390/cio/ccwgroup.c | 10 +---------
 drivers/s390/cio/device.c   | 17 +----------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index c554f16..b1e24fb 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -606,13 +606,6 @@ void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
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
@@ -629,8 +622,7 @@ struct ccwgroup_device *get_ccwgroupdev_by_busid(struct ccwgroup_driver *gdrv,
 {
 	struct device *dev;
 
-	dev = driver_find_device(&gdrv->driver, NULL, bus_id,
-				 __ccwgroupdev_check_busid);
+	dev = driver_find_device_by_name(&gdrv->driver, NULL, bus_id);
 
 	return dev ? to_ccwgroupdev(dev) : NULL;
 }
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index a5c2765..262e81c 100644
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
+	dev = driver_find_device_by_name(&cdrv->driver, NULL, bus_id);
 
 	return dev ? to_ccwdev(dev) : NULL;
 }
-- 
2.7.4

