Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7C5C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A68229EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsoudCgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGXALP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:11:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46592 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfGXALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:11:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id k9so22969101pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzzD3Rk7iCRJjzro+6wf/0OW4le48QYOJbjS3If0lBM=;
        b=SsoudCgIEdRvJ6SthZKf5IdwSkwUaKdpt4Q15TeAZM561c3641htMbORNtP1ooCRq3
         qGtHS9lN39Q8AjIXyDEJsHTOJgvrdAqlhLjxtsWWB7H2Afz/10FFXW+zZtDDaWTUvqyk
         MEvabVfHJFINwvFfJ2W+Rj/6M3J7MdTTVjRNLjbj3WZu1XfWUJDB7HrO0OOWIculb79c
         /A55kytadVwu883Rqv6iXXdaJTuSFbpA/CW+QEckxK6PCdsjIBgwz9tJEQCygN0IQtWs
         FfQZ50tSSpIf31RgXnJ1sept8299mk09TDJr4nfkx8Vd7h8byFbsWKPolwCIzXL9NFEj
         Pmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzzD3Rk7iCRJjzro+6wf/0OW4le48QYOJbjS3If0lBM=;
        b=mqcSePlhOrJnWfAUWJ5d3cotinataZSuzAMfM6Cl+7SBx7gMOuKt1cPJWfHzbMiYAi
         0Oy5WKSOLzZ2xYFyWCZVpdhFYFcJ3+q+urW6HXpfD3fUIS11eCxqC4NJzCDq4gcyJUGm
         gqxuPOi1FBE+BaBOObCZCgohk3OQ7b9Z+JHriqlWjt3xWZTtwIoxVnNkkV2M+EIZ4Lvn
         yNOP6q6lpi0WuC71TAElCnB2Xa6riIkmpWxRMc5cHyULC2tZdsMVXJca4K7Mq49U/bye
         N51DdLQ9KEUwIHzTH9bqmkbtypfQrN4pUEdGsdog+I/sR/qj2voStYKf2Wxc/Tzy9/bB
         u3tQ==
X-Gm-Message-State: APjAAAVVuEgiOlqQM8lEI6BS2pkHySG111z49nezKI8EfpZDxbylwfqV
        sw44SiB0wRQwgkXx8oD189A4rtsv7yCFp6I=
X-Google-Smtp-Source: APXvYqyBraTCcadqG9PySzkCTbXsphamVmtHyEuREOhKZpp0XpAhBTKyR0gyvMHEEbgr/BrID0kKo6XEoTbfGkQ=
X-Received: by 2002:a63:d315:: with SMTP id b21mr54998372pgg.326.1563927071371;
 Tue, 23 Jul 2019 17:11:11 -0700 (PDT)
Date:   Tue, 23 Jul 2019 17:10:55 -0700
In-Reply-To: <20190724001100.133423-1-saravanak@google.com>
Message-Id: <20190724001100.133423-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190724001100.133423-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v7 2/7] driver core: Add edit_links() callback for drivers
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

The driver core/bus adding supplier-consumer dependencies by default
enables functional dependencies to be tracked correctly even when the
consumer devices haven't had their drivers registered or loaded (if they
are modules).

However, when the bus incorrectly adds dependencies that it shouldn't
have added, the devices might never probe.

For example, if device-C is a consumer of device-S and they have
phandles to each other in DT, the following could happen:

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

Neither devices will get probed since the supplier is marked as
dependent on the consumer. And the consumer will never probe because the
consumer can't get resources from the supplier.

Without this patch, things stay in this broken state. However, with this
patch, the execution will continue like this:

9.  Device-C's driver is loaded.
10. Device-C's driver removes Device-S as a consumer of Device-C.
11. Device-C's driver adds Device-C as a consumer of Device-S.
12. Device-S probes.
14. Device-C probes.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 24 ++++++++++++++++++++++--
 drivers/base/dd.c      | 29 +++++++++++++++++++++++++++++
 include/linux/device.h | 18 ++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1b4eb221968f..733d8a9aec76 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -422,6 +422,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
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
@@ -439,12 +452,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
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
index 994a90747420..5e7041ede0d7 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -698,6 +698,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
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
@@ -786,6 +792,29 @@ struct device_attach_data {
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
index 5d70babb7462..35aed50033c4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -263,6 +263,20 @@ enum probe_type {
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
@@ -302,6 +316,7 @@ struct device_driver {
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
 
+	int (*edit_links)(struct device *dev);
 	int (*probe) (struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
@@ -1078,6 +1093,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
+	bool			has_edit_links:1;
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
@@ -1329,6 +1345,7 @@ extern int  __must_check device_attach(struct device *dev);
 extern int __must_check driver_attach(struct device_driver *drv);
 extern void device_initial_probe(struct device *dev);
 extern int __must_check device_reprobe(struct device *dev);
+extern int driver_edit_links(struct device *dev);
 
 extern bool device_is_bound(struct device *dev);
 
@@ -1419,6 +1436,7 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+void device_link_remove_from_wfs(struct device *consumer);
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.709.g102302147b-goog

