Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A733BC742DE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F63020874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4KvOcxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfGLXxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:07 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37797 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfGLXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:03 -0400
Received: by mail-vk1-f201.google.com with SMTP id v135so4686503vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6KQxYU78y2v6cVIr+3wIDDQm1ImfrHVwj1J7czRkJGA=;
        b=E4KvOcxBfAHuenaFpEVuMlIFWp6Kx3wPt2AEXJ0xVVn9yyJZRV0iHlL7kCLU6k7ebv
         E/MgMW2auhTELgBog2VqMNcNVODEcXt39p+XLm0GUQxFV0vJcLwyRSwrYh4cVWmYeqQ1
         RyCjbBpe7EpuGGhI3MxuLMLp38K281QRmqYtbs4bm8VYhFZaDyxyrO2xXBIStA0Le8Gc
         dMOowBz+6cqRa0pb3TwE+jPHVe2JVAhXgkBt9np7AbwygsnG8GUHWQq9lORbhGK29agw
         eqATMzIrLnc6EY7QwRUfSQW9EA5gXPLx+yhn6/HLjIYt+rpis7VkShll71S3PAO+iAoi
         85rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6KQxYU78y2v6cVIr+3wIDDQm1ImfrHVwj1J7czRkJGA=;
        b=NSrMZPnnK8ZTs21YE4F0QZS1WVYbSQrqvc+QlEd6X9G0t9t0v9KB0m9r68BjrB8Ozz
         jpVQG8Bafj8TeieBEpsgaOWd4KsCQRT5rbJ93/lvnaN2e2aPUoGIuXyUfmf05D3KxRR7
         5apmDiRnhF/KUBfQxBig4NX1bw12tm//8Bflrjl5SWMoiz2HDikOywDGH4FY6wl6ZoYk
         yitmksUkXnMG77THqN72XflmTkOyPhmJSFC+ixM62csEVobJBZ7jx0iUZYZwm2VTKUy3
         xiv9msnuFZ6yLW4AOC/HyQQvlEQw1KLp+FCRcZL2EivEwj30z+SI3HtsdF1y2qOXNPeI
         1arg==
X-Gm-Message-State: APjAAAXjOR0lTqopWiitJStFjEWTLMhQ3WvtyIq/ySFvGByWX1fiqIiF
        hiSnyrLmHSYH5fHjd8ISiqhSPr95dqyvT6k=
X-Google-Smtp-Source: APXvYqxxVbTMHcFm8hpV859w/jAt112XR252p/RbdcPwHnYgzhYDtZo4ER8e4w/eLMIwcnf6rS1HHeK+wHE+060=
X-Received: by 2002:ab0:70c8:: with SMTP id r8mr10188491ual.89.1562975582153;
 Fri, 12 Jul 2019 16:53:02 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:37 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 04/11] driver core: Add edit_links() callback for drivers
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core/bus adding dependencies by default makes sure that
suppliers don't sync the hardware state with software state before all the
consumers have their drivers loaded (if they are modules) and are probed.

However, when the bus incorrectly adds dependencies that it shouldn't have
added, the devices might never probe.

For example, if device-C is a consumer of device-S and they have phandles
to each other in DT, the following could happen:

1.  Device-S get added first.
2.  The bus add_links() callback will (incorrectly) try to link it as
    a consumer of device-C.
3.  Since device-C isn't present, device-S will be put in
    "waiting-for-supplier" list.
4.  Device-C gets added next.
5.  All devices in "waiting-for-supplier" list are retried for linking.
6.  Device-S gets linked as consumer to Device-C.
7.  The bus add_links() callback will (correctly) try to link it as
    a consumer of device-S.
8.  This isn't allowed because it would create a cyclic device links.

So neither devices will get probed since the supplier is dependent on a
consumer that'll never probe (because it can't get resources from the
supplier).

Without this patch, things stay in this broken state. However, with this
patch, the execution will continue like this:

9.  Device-C's driver is loaded.
10. Device-C's driver removes Device-S as a consumer of Device-C.
11. Device-C's driver adds Device-C as a consumer of Device-S.
12. Device-S probes.
13. Device-S sync_state() isn't called because Device-C hasn't probed yet.
14. Device-C probes.
15. Device-S's sync_state() callback is called.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 24 ++++++++++++++++++++++--
 drivers/base/dd.c      | 29 +++++++++++++++++++++++++++++
 include/linux/device.h | 18 ++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8b8b812d26f1..dce97b5f3536 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -423,6 +423,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
 	mutex_unlock(&wfs_lock);
 }
 
+/**
+ * device_link_remove_from_wfs - Unmark device as waiting for supplier
+ * @consumer: Consumer device
+ *
+ * Unmark the consumer device as waiting for suppliers to become available.
+ */
+void device_link_remove_from_wfs(struct device *consumer)
+{
+	mutex_lock(&wfs_lock);
+	list_del_init(&consumer->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
 /**
  * device_link_check_waiting_consumers - Try to unmark waiting consumers
  *
@@ -440,12 +453,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
 static void device_link_check_waiting_consumers(void)
 {
 	struct device *dev, *tmp;
+	int ret;
 
 	mutex_lock(&wfs_lock);
 	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
-				 links.needs_suppliers)
-		if (!dev->bus->add_links(dev))
+				 links.needs_suppliers) {
+		ret = 0;
+		if (dev->has_edit_links)
+			ret = driver_edit_links(dev);
+		else if (dev->bus->add_links)
+			ret = dev->bus->add_links(dev);
+		if (!ret)
 			list_del_init(&dev->links.needs_suppliers);
+	}
 	mutex_unlock(&wfs_lock);
 }
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0df9b4461766..842fc7b704f9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -659,6 +659,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
+	if (drv->edit_links) {
+		if (drv->edit_links(dev))
+			dev->has_edit_links = true;
+		else
+			device_link_remove_from_wfs(dev);
+	}
 	pm_runtime_get_suppliers(dev);
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
@@ -747,6 +753,29 @@ struct device_attach_data {
 	bool have_async;
 };
 
+static int __driver_edit_links(struct device_driver *drv, void *data)
+{
+	struct device *dev = data;
+
+	if (!drv->edit_links)
+		return 0;
+
+	if (driver_match_device(drv, dev) <= 0)
+		return 0;
+
+	return drv->edit_links(dev);
+}
+
+int driver_edit_links(struct device *dev)
+{
+	int ret;
+
+	device_lock(dev);
+	ret = bus_for_each_drv(dev->bus, NULL, dev, __driver_edit_links);
+	device_unlock(dev);
+	return ret;
+}
+
 static int __device_attach_driver(struct device_driver *drv, void *_data)
 {
 	struct device_attach_data *data = _data;
diff --git a/include/linux/device.h b/include/linux/device.h
index 4a0db34ae650..d3c9e70052d8 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -262,6 +262,20 @@ enum probe_type {
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
+ * @edit_links:	Called to allow a matched driver to edit the device links the
+ *		bus might have added incorrectly. This will be useful to handle
+ *		cases where the bus incorrectly adds functional dependencies
+ *		that aren't true or tries to create cyclic dependencies. But
+ *		doesn't correctly handle functional dependencies that are
+ *		missed by the bus as the supplier's sync_state might get to
+ *		execute before the driver for a missing consumer is loaded and
+ *		gets to edit the device links for the consumer.
+ *
+ *		This function might be called multiple times after a new device
+ *		is added.  The function is expected to create all the device
+ *		links for the new device and return 0 if it was completed
+ *		successfully or return an error if it needs to be reattempted
+ *		in the future.
  * @probe:	Called to query the existence of a specific device,
  *		whether this driver can work with it, and bind the driver
  *		to a specific device.
@@ -308,6 +322,7 @@ struct device_driver {
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
 
+	int (*edit_links)(struct device *dev);
 	int (*probe) (struct device *dev);
 	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
@@ -1082,6 +1097,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			state_synced:1;
+	bool			has_edit_links:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1331,6 +1347,7 @@ extern int  __must_check device_attach(struct device *dev);
 extern int __must_check driver_attach(struct device_driver *drv);
 extern void device_initial_probe(struct device *dev);
 extern int __must_check device_reprobe(struct device *dev);
+extern int driver_edit_links(struct device *dev);
 
 extern bool device_is_bound(struct device *dev);
 
@@ -1423,6 +1440,7 @@ void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 int device_links_supplier_sync_state(struct device *dev, void *data);
 void device_links_supplier_sync_state_enable(void);
+void device_link_remove_from_wfs(struct device *consumer);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.510.g264f2c817a-goog

