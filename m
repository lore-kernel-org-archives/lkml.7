Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF3C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E584F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BoXPzb3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfGLXwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:52:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:42733 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfGLXwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:52:53 -0400
Received: by mail-pg1-f202.google.com with SMTP id d3so6612914pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ngX8L3Cj7Wd1YvNdQtA7f+1N5F8m77uDAX7EJPdfGcE=;
        b=BoXPzb3UPjVTe4SG9dCpnDVuUrF5w1B1xSu2kTLBUad4T0blJzv1rK15pdyDP6wRGs
         ApLILAgH5B01j793p8CGuNfvIai2Ex+Zjzo3C7oKjtASxzYgXmX13TnBxpArNhCxYPCx
         eYw76MHjNL0k37b6DJUwufiNVbTQflZZmXlgIc+kcVyA3JikivioZZjC8U2COpPaxrQX
         uEmfiMiFbI8OysQhX1npHTob0eV3NoGACs/1R18UACoa5fsrjFjrlFVkQ+DBX5v5QPJp
         7P9s+YocbDi4XmKD5C4IKBvor+eZm/8EjwiX6X+QkeyZ00bpRjI8C28azRs4/2WecLYy
         uexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ngX8L3Cj7Wd1YvNdQtA7f+1N5F8m77uDAX7EJPdfGcE=;
        b=uoAv5eQVg7CTsU2o2S/Oh1CI86uPxpOhNY7Z0Q0sYB+iWtvhmA4pa24JXwRE/2liQm
         4kCnvhzlSYP+sO30c0SABYbThZ9TMPtAdQNxmrbbsBAWcjv0DvtaPVUC2mK6S80ZkFGC
         1jYl230gXq1wt5olPehUwMAdL5YBYLArmn9h46ml1oxsZDwBv75stNYvxWqR8Eyg7uSF
         M0gbYTsa+dSBev/vEtIAL5xMN+W9qXIBf1uyZxGdc/qLsbOfPR6ozD0czHURNqJ01JV4
         69+EzQn3UgRI0UeCIliGCM2UnKPDTJr5vRa2sUGl1AR04zF2tRn26n6dVAslgANfS//C
         cFlQ==
X-Gm-Message-State: APjAAAVReIptk34BnzyweH6ko5KssHpu/0j6DYd75pKr1sHWiguCkpYe
        Br3Gb4NoWDZxlMzJohYLepDrbJHEfAxjRro=
X-Google-Smtp-Source: APXvYqzjN3wbkYaC6ye2TTo1p7zXvtbDpFEfwdQWRBfff0+jS8YIzjnjqFkKHhagykNJqNRMKUJ41lQcvGyH25U=
X-Received: by 2002:a65:6406:: with SMTP id a6mr975645pgv.393.1562975572451;
 Fri, 12 Jul 2019 16:52:52 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:34 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 01/11] driver core: Add support for linking devices during
 device addition
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

When devices are added, the bus might want to create device links to track
functional dependencies between supplier and consumer devices. This
tracking of supplier-consumer relationship allows optimizing device probe
order and tracking whether all consumers of a supplier are active. The
add_links bus callback is added to support this.

However, when consumer devices are added, they might not have a supplier
device to link to despite needing mandatory resources/functionality from
one or more suppliers. A waiting_for_suppliers list is created to track
such consumers and retry linking them when new devices get added.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 83 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  8 ++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..0705926d362f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
 /* Device links support. */
+static LIST_HEAD(wait_for_suppliers);
+static DEFINE_MUTEX(wfs_lock);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -401,6 +403,51 @@ struct device_link *device_link_add(struct device *consumer,
 }
 EXPORT_SYMBOL_GPL(device_link_add);
 
+/**
+ * device_link_wait_for_supplier - Mark device as waiting for supplier
+ * @consumer: Consumer device
+ *
+ * Marks the consumer device as waiting for suppliers to become available. The
+ * consumer device will never be probed until it's unmarked as waiting for
+ * suppliers. The caller is responsible for adding the link to the supplier
+ * once the supplier device is present.
+ *
+ * This function is NOT meant to be called from the probe function of the
+ * consumer but rather from code that creates/adds the consumer device.
+ */
+static void device_link_wait_for_supplier(struct device *consumer)
+{
+	mutex_lock(&wfs_lock);
+	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
+/**
+ * device_link_check_waiting_consumers - Try to unmark waiting consumers
+ *
+ * Loops through all consumers waiting on suppliers and tries to add all their
+ * supplier links. If that succeeds, the consumer device is unmarked as waiting
+ * for suppliers. Otherwise, they are left marked as waiting on suppliers,
+ *
+ * The add_links bus callback is expected to return 0 if it has found and added
+ * all the supplier links for the consumer device. It should return an error if
+ * it isn't able to do so.
+ *
+ * The caller of device_link_wait_for_supplier() is expected to call this once
+ * it's aware of potential suppliers becoming available.
+ */
+static void device_link_check_waiting_consumers(void)
+{
+	struct device *dev, *tmp;
+
+	mutex_lock(&wfs_lock);
+	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
+				 links.needs_suppliers)
+		if (!dev->bus->add_links(dev))
+			list_del_init(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
 static void device_link_free(struct device_link *link)
 {
 	while (refcount_dec_not_one(&link->rpm_active))
@@ -535,6 +582,19 @@ int device_links_check_suppliers(struct device *dev)
 	struct device_link *link;
 	int ret = 0;
 
+	/*
+	 * If a device is waiting for one or more suppliers (in
+	 * wait_for_suppliers list), it is not ready to probe yet. So just
+	 * return -EPROBE_DEFER without having to check the links with existing
+	 * suppliers.
+	 */
+	mutex_lock(&wfs_lock);
+	if (!list_empty(&dev->links.needs_suppliers)) {
+		mutex_unlock(&wfs_lock);
+		return -EPROBE_DEFER;
+	}
+	mutex_unlock(&wfs_lock);
+
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
@@ -812,6 +872,10 @@ static void device_links_purge(struct device *dev)
 {
 	struct device_link *link, *ln;
 
+	mutex_lock(&wfs_lock);
+	list_del(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+
 	/*
 	 * Delete all of the remaining links from this device to any other
 	 * devices (either consumers or suppliers).
@@ -1673,6 +1737,7 @@ void device_initialize(struct device *dev)
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
+	INIT_LIST_HEAD(&dev->links.needs_suppliers);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
@@ -2108,6 +2173,24 @@ int device_add(struct device *dev)
 					     BUS_NOTIFY_ADD_DEVICE, dev);
 
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
+
+	/*
+	 * Check if any of the other devices (consumers) have been waiting for
+	 * this device (supplier) to be added so that they can create a device
+	 * link to it.
+	 *
+	 * This needs to happen after device_pm_add() because device_link_add()
+	 * requires the supplier be registered before it's called.
+	 *
+	 * But this also needs to happe before bus_probe_device() to make sure
+	 * waiting consumers can link to it before the driver is bound to the
+	 * device and the driver sync_state callback is called for this device.
+	 */
+	device_link_check_waiting_consumers();
+
+	if (dev->bus && dev->bus->add_links && dev->bus->add_links(dev))
+		device_link_wait_for_supplier(dev);
+
 	bus_probe_device(dev);
 	if (parent)
 		klist_add_tail(&dev->p->knode_parent,
diff --git a/include/linux/device.h b/include/linux/device.h
index 848fc71c6ba6..7f8ae7e5fc6b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -77,6 +77,11 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		-EPROBE_DEFER it will queue the device for deferred probing.
  * @uevent:	Called when a device is added, removed, or a few other things
  *		that generate uevents to add the environment variables.
+ * @add_links:	Called, perhaps multiple times, when a new device is added to
+ *		this bus. The function is expected to create all the device
+ *		links for the new device and return 0 if it was completed
+ *		successfully or return an error if it needs to be reattempted
+ *		in the future.
  * @probe:	Called when a new device or driver add to this bus, and callback
  *		the specific driver's probe to initial the matched device.
  * @remove:	Called when a device removed from this bus.
@@ -121,6 +126,7 @@ struct bus_type {
 
 	int (*match)(struct device *dev, struct device_driver *drv);
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
+	int (*add_links)(struct device *dev);
 	int (*probe)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
@@ -888,11 +894,13 @@ enum dl_dev_state {
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
+ * @needs_suppliers: Hook to global list of devices waiting for suppliers.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
+	struct list_head needs_suppliers;
 	enum dl_dev_state status;
 };
 
-- 
2.22.0.510.g264f2c817a-goog

