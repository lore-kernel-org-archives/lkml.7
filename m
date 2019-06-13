Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014E2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404466AbfFMQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:59:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:1397 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729799AbfFMQ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:59:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 09:59:54 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2019 09:59:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE1EB141; Thu, 13 Jun 2019 19:59:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2, resend] device property: Add helpers to count items in an array
Date:   Thu, 13 Jun 2019 19:59:51 +0300
Message-Id: <20190613165951.64148-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usual pattern to allocate the necessary space for an array of properties is
to count them first by calling:

  count = device_property_read_uXX_array(dev, propname, NULL, 0);
  if (count < 0)
	return count;

Introduce helpers device_property_count_uXX() to count items by supplying hard
coded last two parameters to device_property_readXX_array().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/property.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 088d4db7e949..dbacf17fff2e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -148,6 +148,26 @@ static inline int device_property_read_u64(struct device *dev,
 	return device_property_read_u64_array(dev, propname, val, 1);
 }
 
+static inline int device_property_count_u8(struct device *dev, const char *propname)
+{
+	return device_property_read_u8_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u16(struct device *dev, const char *propname)
+{
+	return device_property_read_u16_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u32(struct device *dev, const char *propname)
+{
+	return device_property_read_u32_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u64(struct device *dev, const char *propname)
+{
+	return device_property_read_u64_array(dev, propname, NULL, 0);
+}
+
 static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
@@ -178,6 +198,30 @@ static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
 }
 
+static inline int fwnode_property_count_u8(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	return fwnode_property_read_u8_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u16(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u16_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u32(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u32_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
+}
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
-- 
2.20.1

