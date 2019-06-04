Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD32C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A74C2462A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkDJE04L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFDAcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:32:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51966 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFDAca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:32:30 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so12795231pla.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dLVbLGeLPRKDQpbmXUkLBOtDFn4QZcgYqnH/YbjiLco=;
        b=UkDJE04LAalSJ1AcG0xBGYHsFGFGAasxF/2AhaPMqSxawwHqg6lWSqfuKMysM9hWvq
         f76878BTnhsOAS3Y2nA15KZHXVsqVhH6WkhmdHXi3jLAOhsP+MLFbZsadLTccsJYKS3k
         2gx1OoSeerEH0iqyW4iCEOMCwfIJZdoeOPi0wWx9Pv87ZpWpRFR9qeQ0HLCm3k79kkyE
         CYjGah5TsVMe/zL+RkklNetP/za6n7OqL9p95O58WqO6wGMhp+BkDQwb25KX8NLwBXgc
         tfTKQ4Cfr1BV6HvsYLgxvbKhzHVaQnaAcWZDxvLrxxmmjDwSjdH0HBdF0htXLsU1kCOw
         Lotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dLVbLGeLPRKDQpbmXUkLBOtDFn4QZcgYqnH/YbjiLco=;
        b=K1UpJjK1ehdNX/5BBY18fzMI4/rsMkan5hLLAZGQKcOqPH0iUB0VXDunmUuU7iu76M
         CGX0giDha5Gnvk5nyaoTPyT9k4qZJT0zGSHzL8/WDmBcTn5jBA4Jv5JvM4ZMRqzy6ROZ
         nZdqUsrDQsLBFl3/oAJPOr9RWZP7C0JtUBFRY8HCArph05uRWQw3XARfXus04R+Vw6p0
         Ak5OxL5qwcTWpG7z8D5OWnEnIz6F7ptHKfqv4PK9PbFb+wCc/KHWUezhhizSE94jzw1r
         YEtXULLKzV9Ugjk/zX4uPJrWNowznl26QXDHSF+R5fDjYyTvbSRPM647kRSQtQZfK0Tq
         0vwQ==
X-Gm-Message-State: APjAAAWu12Z+4eQbZEWLsLL+SKD0KBKTAxNzvtA3sg6Wp5sQbkVkovUj
        /yyHWBs6XbAkmsT0/KOqytY8kZ8rp0rAWpk=
X-Google-Smtp-Source: APXvYqz3WQNWZHJUQ4FANXEHAgnqXgVw712ylZTQb3kYsI/1JNnZB+Z55brVvgn2dDQp7jlUvy2SAGYiGuB0tqU=
X-Received: by 2002:a63:b1d:: with SMTP id 29mr31916043pgl.103.1559608349714;
 Mon, 03 Jun 2019 17:32:29 -0700 (PDT)
Date:   Mon,  3 Jun 2019 17:32:15 -0700
In-Reply-To: <20190604003218.241354-1-saravanak@google.com>
Message-Id: <20190604003218.241354-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190604003218.241354-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RESEND PATCH v1 2/5] driver core: Add device links support for
 pending links to suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        David Collins <collinsd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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
index e85264fb6616..4e71e5386aae 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -887,11 +887,13 @@ enum dl_dev_state {
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
 
@@ -1395,6 +1397,9 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+void device_link_wait_for_supplier(struct device *consumer);
+void device_link_check_waiting_consumers(
+		int (*add_suppliers)(struct device *consumer));
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
-- 
2.22.0.rc1.257.g3120a18244-goog

