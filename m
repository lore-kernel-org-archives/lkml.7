Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F7DC76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798CE21872
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 06:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXVZYj0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfGTGRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 02:17:09 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49024 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfGTGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 02:17:08 -0400
Received: by mail-pg1-f201.google.com with SMTP id k20so19942649pgg.15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1NioAjxwWXD5zMrpbbHH23+rQV4attUg32vvvEUu6tM=;
        b=gXVZYj0vT1RDlR4qZZmzEhnHP964Z+ILyT/aIQCsKOVVTU2X2yzWuJ4VAxYf6+AzvX
         eiAx7QLTl1LuXCbRS563JWgYn9yynRjdNkmF3TrkNoZxydzlFmVqgkh5Z8aKd+7rnIf1
         1mgMi5rpWy9BxMhF9306A8wbfNe/RC6/a8h6GXKZJNqzJ56JUt1Jwdd0mNWdhXk2+Ae+
         ZUnZwaVCf8ahhzcemRdrf4laxE5t4SOZpIFuKzbZDa+yX4BzmNPhDRMv4NSZh7MVFWHh
         waLej4O7jN54ivs5eWcpCXAZcV123V1LM4BUW9KTRcqg93Fxz7/qsqZ1SGA4nVgO1HF/
         03DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1NioAjxwWXD5zMrpbbHH23+rQV4attUg32vvvEUu6tM=;
        b=unlvNmJQ/Vk+4N2DrtJE0V2EpOhfK0Ac4qcZvd4G7UXj6OCE+1FfJxdiaOOHt7eEh8
         4IWDNVIrw81URYV8qpo9jxP7S7oODrpScUeFIdoyYx20MRH5w2svhuse/4/rlPzFX2WN
         fgPFftf//Urbku/N2SnUug0UIPD9ac1Zl/EHHHuHjgURwOi7JmOTjWbF+DfUCYw6DIAj
         0GY3+OkWKJpwUuA+aj6SWzatsZhQeQois5BZEnhsfDT1k8k90ssjdpolyGicSnc/06Hg
         PwdVVdcspIr5m8TSHo76u1Rw9D2TLW0ZRINVEruzG1ayqmv43PM9dP/zU4vBLpuya4Bg
         E5Sw==
X-Gm-Message-State: APjAAAUTGv8Sct20FY0/J9BOitI0XNwytbsYRrd6+/cDMJqFalVCx7X6
        dOMkC83c6sJ2Tk3LE4gNac861M+SJaHYtgw=
X-Google-Smtp-Source: APXvYqyr1beoQZ+l6CgfKlVwdueeO2681TcxOfJxifFwmUlgg+h7Lr0Y6gec4Nb7ulR1L9XQF3tVyEqrWuzJ2eI=
X-Received: by 2002:a65:5348:: with SMTP id w8mr57702659pgr.176.1563603427496;
 Fri, 19 Jul 2019 23:17:07 -0700 (PDT)
Date:   Fri, 19 Jul 2019 23:16:43 -0700
In-Reply-To: <20190720061647.234852-1-saravanak@google.com>
Message-Id: <20190720061647.234852-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190720061647.234852-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v6 4/7] driver core: Add sync_state driver/bus callback
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

This sync_state driver/bus callback is called once all the consumers
of a supplier have probed successfully.

This allows the supplier device's driver/bus to sync the supplier
device's state to the software state with the guarantee that all the
consumers are actively managing the resources provided by the supplier
device.

To maintain backwards compatibility and ease transition from existing
frameworks and resource cleanup schemes, late_initcall_sync is the
earliest when the sync_state callback might be called.

There is no upper bound on the time by which the sync_state callback
has to be called. This is because if a consumer device never probes,
the supplier has to maintain its resources in the state left by the
bootloader. For example, if the bootloader leaves the display
backlight at a fixed voltage and the backlight driver is never probed,
you don't want the backlight to ever be turned off after boot up.

Also, when multiple devices are added after kernel init, some
suppliers could be added before their consumer devices get added. In
these instances, the supplier devices could get their sync_state
callback called right after they probe because the consumers devices
haven't had a chance to create device links to the suppliers.

To handle this correctly, this change also provides APIs to
pause/resume sync state callbacks so that when multiple devices are
added, their sync_state callback evaluation can be postponed to happen
after all of them are added.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 21 ++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6eb14093e905..b03e679faea4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,6 +46,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
+static LIST_HEAD(deferred_sync);
+static unsigned int supplier_sync_state_disabled;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -634,6 +636,62 @@ int device_links_check_suppliers(struct device *dev)
 	return ret;
 }
 
+static void __device_links_supplier_sync_state(struct device *dev)
+{
+	struct device_link *link;
+
+	if (dev->state_synced)
+		return;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+		if (link->status != DL_STATE_ACTIVE)
+			return;
+	}
+
+	if (dev->bus->sync_state)
+		dev->bus->sync_state(dev);
+	else if (dev->driver && dev->driver->sync_state)
+		dev->driver->sync_state(dev);
+
+	dev->state_synced = true;
+}
+
+void device_links_supplier_sync_state_pause(void)
+{
+	device_links_write_lock();
+	supplier_sync_state_disabled++;
+	device_links_write_unlock();
+}
+
+void device_links_supplier_sync_state_resume(void)
+{
+	struct device *dev, *tmp;
+
+	device_links_write_lock();
+	if (!supplier_sync_state_disabled) {
+		WARN(true, "Unmatched sync_state pause/resume!");
+		goto out;
+	}
+	supplier_sync_state_disabled--;
+	if (supplier_sync_state_disabled)
+		goto out;
+
+	list_for_each_entry_safe(dev, tmp, &deferred_sync, links.defer_sync) {
+		__device_links_supplier_sync_state(dev);
+		list_del_init(&dev->links.defer_sync);
+	}
+out:
+	device_links_write_unlock();
+}
+
+static void __device_links_supplier_defer_sync(struct device *sup)
+{
+	if (list_empty(&sup->links.defer_sync))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
+}
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
@@ -678,6 +736,11 @@ void device_links_driver_bound(struct device *dev)
 
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
+
+		if (supplier_sync_state_disabled)
+			__device_links_supplier_defer_sync(link->supplier);
+		else
+			__device_links_supplier_sync_state(link->supplier);
 	}
 
 	dev->links.status = DL_DEV_DRIVER_BOUND;
@@ -787,6 +850,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -1758,6 +1822,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
+	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index a2d509a36ebe..489d9f4e3104 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -84,6 +84,13 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  *		in the future.
  * @probe:	Called when a new device or driver add to this bus, and callback
  *		the specific driver's probe to initial the matched device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
  *
@@ -128,6 +135,7 @@ struct bus_type {
 	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
 	int (*add_links)(struct device *dev);
 	int (*probe)(struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
 
@@ -271,6 +279,13 @@ enum probe_type {
  * @probe:	Called to query the existence of a specific device,
  *		whether this driver can work with it, and bind the driver
  *		to a specific device.
+ * @sync_state:	Called to sync device state to software state after all the
+ *		state tracking consumers linked to this device (present at
+ *		the time of late_initcall) have successfully bound to a
+ *		driver. If the device has no consumers, this function will
+ *		be called at late_initcall_sync level. If the device has
+ *		consumers that are never bound to a driver, this function
+ *		will never get called until they do.
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
@@ -309,6 +324,7 @@ struct device_driver {
 
 	int (*edit_links)(struct device *dev);
 	int (*probe) (struct device *dev);
+	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
@@ -910,12 +926,14 @@ enum dl_dev_state {
  * @suppliers: List of links to supplier devices.
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
+ * @defer_sync: Hook to global list of devices that have deferred sync_state.
  * @status: Driver status information.
  */
 struct dev_links_info {
 	struct list_head suppliers;
 	struct list_head consumers;
 	struct list_head needs_suppliers;
+	struct list_head defer_sync;
 	enum dl_dev_state status;
 };
 
@@ -1081,6 +1099,7 @@ struct device {
 	bool			offline:1;
 	bool			of_node_reused:1;
 	bool			has_edit_links:1;
+	bool			state_synced:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1422,6 +1441,8 @@ struct device_link *device_link_add(struct device *consumer,
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_link_remove_from_wfs(struct device *consumer);
+void device_links_supplier_sync_state_pause(void);
+void device_links_supplier_sync_state_resume(void);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.657.g960e92d24f-goog

