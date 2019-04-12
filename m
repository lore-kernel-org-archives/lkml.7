Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EC22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDLNln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:41:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:9855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfDLNlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:41:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 06:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163824256"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 06:41:37 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 05/13] driver core: Add helper device_find_child_by_name()
Date:   Fri, 12 Apr 2019 16:41:14 +0300
Message-Id: <20190412134122.82903-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the child device is often matched with a name.
This introduces a helper that does it automatically.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/core.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4aeaa0c92bda..5819ba4c9d4c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2469,6 +2469,37 @@ struct device *device_find_child(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_find_child);
 
+/**
+ * device_find_child_by_name - device iterator for locating a child device.
+ * @parent: parent struct device
+ * @name: name of the child device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to a device that has the name @name.
+ *
+ * The callback should return NULL if the child is not found and a reference to
+ * the child device if it is found.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+struct device *device_find_child_by_name(struct device *parent,
+					 const char *name)
+{
+	struct klist_iter i;
+	struct device *child;
+
+	if (!parent)
+		return NULL;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while ((child = next_device(&i)))
+		if (!strcmp(dev_name(child), name) && get_device(child))
+			break;
+	klist_iter_exit(&i);
+	return child;
+}
+EXPORT_SYMBOL_GPL(device_find_child_by_name);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index 4457e560bc2b..fadb84dd07f9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1250,6 +1250,8 @@ extern int device_for_each_child_reverse(struct device *dev, void *data,
 		     int (*fn)(struct device *dev, void *data));
 extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
+extern struct device *device_find_child_by_name(struct device *parent,
+						const char *name);
 extern int device_rename(struct device *dev, const char *new_name);
 extern int device_move(struct device *dev, struct device *new_parent,
 		       enum dpm_order dpm_order);
-- 
2.20.1

