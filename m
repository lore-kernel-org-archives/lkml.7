Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C246C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C0720693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfDPKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:39:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfDPKj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD2E15A2;
        Tue, 16 Apr 2019 03:39:58 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D60613F68F;
        Tue, 16 Apr 2019 03:39:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rafael@kernel.org, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org
Subject: [RESEND][PATCH v2 27/36] drivers: Add a generic helper to match device by fwnode handle
Date:   Tue, 16 Apr 2019 11:39:24 +0100
Message-Id: <1555411164-26399-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-28-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the device_fwnode_match() a generic helper to match device
by fwnode handle for use with bus_find_device(). This will be
also used by coresight.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

Resending with linux-acpi in Cc, as requested by Rafael.

 drivers/base/devcon.c    | 5 -----
 drivers/base/property.c  | 6 ++++++
 include/linux/property.h | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae..f4a9e30 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -107,11 +107,6 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
-static int device_fwnode_match(struct device *dev, void *fwnode)
-{
-	return dev_fwnode(dev) == fwnode;
-}
-
 static void *device_connection_fwnode_match(struct device_connection *con)
 {
 	struct bus_type *bus;
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8b91ab3..d10d923 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -25,6 +25,12 @@ struct fwnode_handle *dev_fwnode(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
+int device_fwnode_match(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+EXPORT_SYMBOL_GPL(device_fwnode_match);
+
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
diff --git a/include/linux/property.h b/include/linux/property.h
index 65d3420..c8fd3d42 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -34,6 +34,7 @@ enum dev_dma_attr {
 };
 
 struct fwnode_handle *dev_fwnode(struct device *dev);
+int device_fwnode_match(struct device *dev, void *fwnode);
 
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
-- 
2.7.4

