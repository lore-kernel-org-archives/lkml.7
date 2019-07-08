Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35850C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35EF216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h27gA7EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfGHW5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:57:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42339 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfGHW4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:56:41 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so11361728pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j4A0VBbQxqWAJn4h2BC6mIE2ciny+oMQFxJSAqNPL6M=;
        b=h27gA7EKskfzTTlxeBy8PE7FhV6J/4t3NBi40kgUWK4GfKsnTQmoViQDuwIsmU6KGq
         qtR62KQiYHbl4s1QBUOwigfgWGW90GFmf81DB4OKsHIqwAhVpe7UcE4tYcCIBA2Gc0Pw
         6IfDYqskO3XWX7VrAnvYOlyOMosuq9kKROAZ041tibPhkeB13WwiRSKa5DRjfuyqxGyW
         MFlaEqJMIL+LcAHGyXP4tS/SD3qZSGRd/x+Nwbm9xgUdx5iiWL2I93lEAQjcoUKmx03V
         XzQTECy389G565/sgO+MOf0SsSYKc3MFFS9PW55KPbs6BlPtV/OPFVc3JOmDB5pEkiO7
         11gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j4A0VBbQxqWAJn4h2BC6mIE2ciny+oMQFxJSAqNPL6M=;
        b=LSY9OYOZwhz6BvR1KVDXlzQdw3InHRwTGUV/Y1r7uJ7qZeupdqkAJcUp8VHJrrnSh+
         ZCB1FngeToZGd9n/zncZY/wK0IOuq1bJY4lDvmimCldaSxT+CifD9+Zkurlgyh3wfwM0
         /yfGz0eQVmwyWegH6jfhxoVMGjWR1uE04AMbv4EENCLoGGNAUa9tl9uKanM4D1ZL19TC
         TJIXuvB7xkxZ5Ndy2fpCW3d0zZrNRbM4LsjXA1AIObQZnbE9q0DPjUh7LtMn0+tY2CZB
         RPsBYCHEacclnKtDiqy/eRQ6r4GCQvpeMjpb4bAZdIV05rxuS3sAn0GtpCFNvtTVl2JA
         4otw==
X-Gm-Message-State: APjAAAV/0vCy7VGmGCGilpwxNpZBjgjsDrp7abFEiNs5Bu4rq92frI47
        8msSVnN7IBrAcS+kWmky9K5VJYx6eQ4s+KU=
X-Google-Smtp-Source: APXvYqxqFnc5E/vpyn4uX2Vp/BcMarOdUb89OmJ50OjTBzb7X71AQ8/mTDrfsfv2wGQy8D1VG+saRokM9u929RI=
X-Received: by 2002:a63:784c:: with SMTP id t73mr12153951pgc.268.1562626600731;
 Mon, 08 Jul 2019 15:56:40 -0700 (PDT)
Date:   Mon,  8 Jul 2019 15:56:20 -0700
In-Reply-To: <20190708225624.119973-1-saravanak@google.com>
Message-Id: <20190708225624.119973-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190708225624.119973-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 4/8] driver core: Add edit_links() callback for drivers
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
2.22.0.410.gd8fdbe21b5-goog

