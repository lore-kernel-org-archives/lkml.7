Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C41C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFNRzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:32 -0400
Received: from foss.arm.com ([217.140.110.172]:39710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbfFNRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BDD03EF;
        Fri, 14 Jun 2019 10:55:29 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88F823F718;
        Fri, 14 Jun 2019 10:55:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Subject: [PATCH v2 26/28] drivers: Introduce driver_find_next_device() helper
Date:   Fri, 14 Jun 2019 18:54:21 +0100
Message-Id: <1560534863-15115-27-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper for driver_find_device() to find the next device
for a given driver from the "start" device. Also convert the existing
users to make use of the new helper.

Cc: Elie Morisse <syniurge@gmail.com>
Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 8 +-------
 drivers/s390/cio/ccwgroup.c          | 8 +-------
 include/linux/device.h               | 6 ++++++
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index c7fe3b4..5e4800d 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -457,18 +457,12 @@ static struct pci_driver amd_mp2_pci_driver = {
 };
 module_pci_driver(amd_mp2_pci_driver);
 
-static int amd_mp2_device_match(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 struct amd_mp2_dev *amd_mp2_find_device(void)
 {
 	struct device *dev;
 	struct pci_dev *pci_dev;
 
-	dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
-				 amd_mp2_device_match);
+	dev = driver_find_next_device(&amd_mp2_pci_driver.driver, NULL);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index d843e36..0005ec9 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -581,11 +581,6 @@ int ccwgroup_driver_register(struct ccwgroup_driver *cdriver)
 }
 EXPORT_SYMBOL(ccwgroup_driver_register);
 
-static int __ccwgroup_match_all(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 /**
  * ccwgroup_driver_unregister() - deregister a ccw group driver
  * @cdriver: driver to be deregistered
@@ -597,8 +592,7 @@ void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
 	struct device *dev;
 
 	/* We don't want ccwgroup devices to live longer than their driver. */
-	while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
-					 __ccwgroup_match_all))) {
+	while ((dev = driver_find_next_device(&cdriver->driver, NULL))) {
 		struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
 
 		ccwgroup_ungroup(gdev);
diff --git a/include/linux/device.h b/include/linux/device.h
index f7f6a43..77f817d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -475,6 +475,12 @@ static inline struct device *driver_find_device_by_devt(struct device_driver *dr
 	return driver_find_device(drv, NULL, &devt, device_match_devt);
 }
 
+static inline struct device *driver_find_next_device(struct device_driver *drv,
+						     struct device *start)
+{
+	return driver_find_device(drv, start, NULL, device_match_any);
+}
+
 void driver_deferred_probe_add(struct device *dev);
 int driver_deferred_probe_check_state(struct device *dev);
 
-- 
2.7.4

