Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6AFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2C2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFNRzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:55:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfFNRzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4175106F;
        Fri, 14 Jun 2019 10:55:19 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC49C3F718;
        Fri, 14 Jun 2019 10:55:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, "David S. Miller" <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH v2 18/28] drivers: Introduce bus_find_device_by_fwnode() helper
Date:   Fri, 14 Jun 2019 18:54:13 +0100
Message-Id: <1560534863-15115-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to bus_find_device() to search for a device
by the fwnode pointer, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/devcon.c                              |  8 +-------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  8 +-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  8 +-------
 include/linux/device.h                             | 12 ++++++++++++
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index ac026d5..5a888eaa 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -107,19 +107,13 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
-static int device_fwnode_match(struct device *dev, const void *fwnode)
-{
-	return dev_fwnode(dev) == fwnode;
-}
-
 static void *device_connection_fwnode_match(struct device_connection *con)
 {
 	struct bus_type *bus;
 	struct device *dev;
 
 	for (bus = generic_match_buses[0]; bus; bus++) {
-		dev = bus_find_device(bus, NULL, (void *)con->fwnode,
-				      device_fwnode_match);
+		dev = bus_find_device_by_fwnode(bus, con->fwnode);
 		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
 			return dev;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 3afd3e9..6779b7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4498,19 +4498,13 @@ static const struct acpi_device_id hns_roce_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, hns_roce_acpi_match);
 
-static int hns_roce_node_match(struct device *dev, const void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 static struct
 platform_device *hns_roce_find_pdev(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
 	/* get the 'device' corresponding to the matching 'fwnode' */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_roce_node_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
 	/* get the platform device */
 	return dev ? to_platform_device(dev) : NULL;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index bb6586d..ed3829a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -754,17 +754,11 @@ struct dsaf_misc_op *hns_misc_op_get(struct dsaf_device *dsaf_dev)
 	return (void *)misc_op;
 }
 
-static int hns_dsaf_dev_match(struct device *dev, const void *fwnode)
-{
-	return dev->fwnode == fwnode;
-}
-
 struct
 platform_device *hns_dsaf_find_platform_device(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      fwnode, hns_dsaf_dev_match);
+	dev = bus_find_device_by_fwnode(&platform_bus_type, fwnode);
 	return dev ? to_platform_device(dev) : NULL;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 35f51d6..576d84f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -201,6 +201,18 @@ bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
 	return bus_find_device(bus, NULL, np, device_match_of_node);
 }
 
+/**
+ * bus_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @bus: bus type
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwnode)
+{
+	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4

