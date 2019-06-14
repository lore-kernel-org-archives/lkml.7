Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C124C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26A92184E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfFNRz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:27 -0400
Received: from foss.arm.com ([217.140.110.172]:39640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfFNRzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677D53EF;
        Fri, 14 Jun 2019 10:55:22 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64BB33F718;
        Fri, 14 Jun 2019 10:55:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Bjorn Helgaas <bhelgaas@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 20/28] drivers: Introduce bus_find_next_device() helper
Date:   Fri, 14 Jun 2019 18:54:15 +0100
Message-Id: <1560534863-15115-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper for bus_find_device() to find the next devices
on the given bus from the "start" device. Also convert the existing
users to make use of the new helper.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/pci/probe.c      |  7 +------
 drivers/scsi/scsi_proc.c |  9 ++-------
 include/linux/device.h   | 10 ++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f9ef7ad..3504695 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -64,11 +64,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
 	return &r->res;
 }
 
-static int find_anything(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 /*
  * Some device drivers need know if PCI is initiated.
  * Basically, we think PCI is not initiated when there
@@ -79,7 +74,7 @@ int no_pci_devices(void)
 	struct device *dev;
 	int no_devices;
 
-	dev = bus_find_device(&pci_bus_type, NULL, NULL, find_anything);
+	dev = bus_find_next_device(&pci_bus_type, NULL);
 	no_devices = (dev == NULL);
 	put_device(dev);
 	return no_devices;
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index c074631..5b31322 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -372,15 +372,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	return err;
 }
 
-static int always_match(struct device *dev, const void *data)
-{
-	return 1;
-}
-
 static inline struct device *next_scsi_device(struct device *start)
 {
-	struct device *next = bus_find_device(&scsi_bus_type, start, NULL,
-					      always_match);
+	struct device *next = bus_find_next_device(&scsi_bus_type, start);
+
 	put_device(start);
 	return next;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 3c244ac..1c137ab 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -225,6 +225,16 @@ static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
 	return bus_find_device(bus, NULL, &devt, device_match_devt);
 }
 
+/**
+ * bus_find_next_device - Find the next device after a given device in a
+ * given bus.
+ */
+static inline struct device *
+bus_find_next_device(struct bus_type *bus,struct device *cur)
+{
+	return bus_find_device(bus, cur, NULL, device_match_any);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

