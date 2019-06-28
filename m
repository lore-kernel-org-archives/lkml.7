Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34104C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B912086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5rr6mM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1CWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:22:14 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:34957 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF1CWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:22:12 -0400
Received: by mail-vs1-f73.google.com with SMTP id m186so1365870vsm.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l8VcVmZR9TNNBOjYeWWIuX/2PdvU4jGAK44I56HzliA=;
        b=n5rr6mM9x5lj7RDJeKbo0G6fqAgDv1CQPOilQQIiaRqExf1pWkdVNq91DOfq3o61Qs
         Hy/HRRGD6duXfYl2yOnRHc3cQSWX6RyYj6TMOrIt1hzSwWoGMpoX09D4CIOs/3x/hBVB
         DooamyJ16yuulj/la8VuX2G2fFY/O8TF5h96i7VNuV3fYiAaxHr4KXdDiaAVTt6Im5sc
         xd/WESTPvc5rpAa55nyyjklyelJaJlvClYuG37m/54ABEChiEzQ9jeoRs/tf1924co0H
         fK82+YAqEovPmawGqgb5vMvxWu64oM6tBvxB10CgVncf68oLzyk2YIBVmpB4uU14FTJ7
         xUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l8VcVmZR9TNNBOjYeWWIuX/2PdvU4jGAK44I56HzliA=;
        b=aGZ7QO7yl6TPF2C9atl5yoVEDiCe2oPzk83M1VcR+oejzFPBz+KYBTrITLCohEHNOE
         d5hs7Nr8CGuoTZMytXMmWxm0nUbz3Q96J3OnfVyeh7gSJ6bHhw+1qhVv5k3TiA+J0m9S
         rq/k/k1yguRHmSQbaw/wd6NtzldcaUJQyoZHAnr+hnbHaKu8Xy4zeAm+Sjp0wwlkW4EC
         aXo3tIIdMnKl0weh6vaQqJTAf94P9IW4QyvfBygm45wQDEAxpbHJjau1FkblKQf9KVGZ
         tnG02sLV7WyvD5fFgJ9tg/bnozUiQwin/3rcYI1I1mv27cerlYrxUsGSCUzOS2FeEaDr
         +sTA==
X-Gm-Message-State: APjAAAUyD2gPopb61zviKKnwED0FEQA3HvuQh3fFpvmwNc/Qfri/TijB
        wjyY5j3h2qHbfZwHZkPFSUvHYgP5UIqODWI=
X-Google-Smtp-Source: APXvYqz6HQ3jH17o5pfxeyUaGzk37q3wHVNTkFtmBpmteSKN7OWaAu2BKRpsqy5Lm/FW3uUO4hNfwKTsc+J+3wM=
X-Received: by 2002:ab0:3119:: with SMTP id e25mr4326781ual.96.1561688531641;
 Thu, 27 Jun 2019 19:22:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:22:00 -0700
In-Reply-To: <20190628022202.118166-1-saravanak@google.com>
Message-Id: <20190628022202.118166-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190628022202.118166-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 1/3] driver core: Add device links support for pending
 links to suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When consumer devices are added, they might not have a supplier device
to link to despite needing mandatory resources/functionality from one
or more suppliers. Add a waiting_for_suppliers list to track such
consumers and add helper functions to manage the list.

Marking/unmarking a consumer device as waiting for suppliers is
generally expected to be done by the entity that's creating the
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 67 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  5 ++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index fd7511e04e62..9ab6782dda1c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
 /* Device links support. */
+static LIST_HEAD(wait_for_suppliers);
+static DEFINE_MUTEX(wfs_lock);
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -401,6 +403,53 @@ struct device_link *device_link_add(struct device *consumer,
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
+ * consumer but rather from code that creates the consumer device.
+ */
+void device_link_wait_for_supplier(struct device *consumer)
+{
+	mutex_lock(&wfs_lock);
+	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
+/**
+ * device_link_check_waiting_consumers - Try to unmark waiting consumers
+ * @add_suppliers: Callback function to add suppliers to waiting consumer
+ *
+ * Loops through all consumers waiting on suppliers and tries to add all their
+ * supplier links. If that succeeds, the consumer device is unmarked as waiting
+ * for suppliers. Otherwise, they are left marked as waiting on suppliers,
+ *
+ * The add_suppliers callback is expected to return 0 if it has found and added
+ * all the supplier links for the consumer device. It should return an error if
+ * it isn't able to do so.
+ *
+ * The caller of device_link_wait_for_supplier() is expected to call this once
+ * it's aware of potential suppliers becoming available.
+ */
+void device_link_check_waiting_consumers(
+		int (*add_suppliers)(struct device *consumer))
+{
+	struct device *dev, *tmp;
+
+	mutex_lock(&wfs_lock);
+	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
+				 links.needs_suppliers)
+		if (!add_suppliers(dev))
+			list_del_init(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+}
+
 static void device_link_free(struct device_link *link)
 {
 	while (refcount_dec_not_one(&link->rpm_active))
@@ -535,6 +584,19 @@ int device_links_check_suppliers(struct device *dev)
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
@@ -812,6 +874,10 @@ static void device_links_purge(struct device *dev)
 {
 	struct device_link *link, *ln;
 
+	mutex_lock(&wfs_lock);
+	list_del(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+
 	/*
 	 * Delete all of the remaining links from this device to any other
 	 * devices (either consumers or suppliers).
@@ -1673,6 +1739,7 @@ void device_initialize(struct device *dev)
 #endif
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
+	INIT_LIST_HEAD(&dev->links.needs_suppliers);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/include/linux/device.h b/include/linux/device.h
index 848fc71c6ba6..026dd842e511 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -888,11 +888,13 @@ enum dl_dev_state {
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
 
@@ -1396,6 +1398,9 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+void device_link_wait_for_supplier(struct device *consumer);
+void device_link_check_waiting_consumers(
+		int (*add_suppliers)(struct device *consumer));
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.410.gd8fdbe21b5-goog

