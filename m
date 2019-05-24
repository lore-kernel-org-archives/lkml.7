Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C91920862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rg3HmEtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbfEXBBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:01:41 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38422 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388715AbfEXBBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:01:38 -0400
Received: by mail-yb1-f202.google.com with SMTP id a13so6884447ybm.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dLVbLGeLPRKDQpbmXUkLBOtDFn4QZcgYqnH/YbjiLco=;
        b=Rg3HmEtHpFEVOqMgIgsDAoPmogxS7qgwYHDFpkqCXM92mKUfk3I/bRXfeGpZH0H2wg
         PRU2cKeE2R7SmaLFIKmNs9JpsO6p51piO8xB5t/ssxVlIu3X+Y6Y7BHlmfOZ1kWy2Dqf
         cmXws/ubUXjEUM6m+crDVtU211MkUUlEKuNFQWMwBiPbc42HyTPbFJbXUVR2MN0dz56c
         NMTzoIU5oUJSrBqs8V7GfiIbgfeIVgyM2Gf9YvFoOFE+oy8TQylBoi3UMKpDKAPK8zYn
         dGu79djAyqa7rjobbEFIZq2beyHBu4Zujk2CigP5/w73OySHxPF4rRi9FCW2RMNvW0Tq
         kBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dLVbLGeLPRKDQpbmXUkLBOtDFn4QZcgYqnH/YbjiLco=;
        b=LpHKLsAeCblql2oCjCSmx88a2CsZDYu462e+Q3HdyyFfvgUmuemgvcGq8t4IdEghym
         eSnxq7cqwehqvdLWPlTlVbPSq10cY1GUOkGPEY98A4l4diJ043iwjF4Osd13LpQza6Oj
         F8B0FadCWmrMU2DGxdMdfzQSdc41+s2+iyImhQIcSTrMLL9/Ve+fLMEpWxFdNhODCFuY
         Bhz1XHMl1w8XybNoU7vxzmMoCDMlJVVWkzpIlWEQcbLlr2ClgnAxUYGduW2Z04pLjrG3
         VpJXsQdS9If1Gvka2stj4KZaNrHtIh7MW9VYEfpMYTxDNpTlJeogcy5jCyO73mKvQATN
         woCg==
X-Gm-Message-State: APjAAAXPNtcf+mbQqg21AJQ6cfcofmcNLbIZ2pKcakJB734UOi4tVqIg
        9WOYpHOjV4fEPqBJjOD9beiKKSkEhQlq4uo=
X-Google-Smtp-Source: APXvYqz0uCcFg6xc/Ma/bAYX/UdfBRcZEqc8TgoMgcZbJwXxyAzLIueevyIvdJuEnZOry/nadtA+CQixBcWCms0=
X-Received: by 2002:a25:388d:: with SMTP id f135mr2388512yba.251.1558659697070;
 Thu, 23 May 2019 18:01:37 -0700 (PDT)
Date:   Thu, 23 May 2019 18:01:13 -0700
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Message-Id: <20190524010117.225219-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190524010117.225219-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v1 2/5] driver core: Add device links support for pending
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

