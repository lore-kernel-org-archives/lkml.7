Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50962087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfC0Qnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:43:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:62434 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfC0Qnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:43:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 09:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="158912696"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2019 09:43:42 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] device property: Add fwnode_is_compatible() and device_is_compatible() helpers
Date:   Wed, 27 Mar 2019 19:43:37 +0300
Message-Id: <20190327164339.31205-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are also some ACPI platforms where the
"compatible" property is used, introducing a generic helper
function fwnode_is_compatible() that can be used with
DT, ACPI and swnodes, and a wrapper function
device_is_compatible() with it.

The function calls of_device_is_comaptible() with OF nodes,
and with ACPI and swnodes it matches the given string
against the "compatible" string property array.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8b91ab380d14..af9f5aac5d02 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1006,3 +1006,38 @@ const void *device_get_match_data(struct device *dev)
 	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
+
+/**
+ * fwnode_is_compatible - Check does fwnode have the given compatible string
+ * @fwnode: fwnode with the "compatible" property
+ * @compat: The compatible string
+ *
+ * Match the compatible strings of @fwnode against @compat. Returns positive
+ * value on match, and 0 when no matching compatible string is found.
+ */
+int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat)
+{
+	int ret;
+
+	if (is_of_node(fwnode))
+		return of_device_is_compatible(to_of_node(fwnode), compat);
+
+	ret = fwnode_property_match_string(fwnode, "compatible", compat);
+
+	return ret < 0 ? 0 : 1;
+}
+EXPORT_SYMBOL_GPL(fwnode_is_compatible);
+
+/**
+ * device_is_compatible - Check does a device have the given compatible string
+ * @dev: Device with the "compatible" property
+ * @compat: The compatible string
+ *
+ * Match the compatible strings of @dev against @compat. Returns positive value
+ * on match, and 0 when no matching compatible string is found.
+ */
+int device_is_compatible(struct device *dev, const char *compat)
+{
+	return fwnode_is_compatible(dev_fwnode(dev), compat);
+}
+EXPORT_SYMBOL_GPL(device_is_compatible);
diff --git a/include/linux/property.h b/include/linux/property.h
index 65d3420dd5d1..d22788ec36cd 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -311,6 +311,9 @@ fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
+int fwnode_is_compatible(struct fwnode_handle *fwnode, const char *compat);
+int device_is_compatible(struct device *dev, const char *compat);
+
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-- 
2.20.1

