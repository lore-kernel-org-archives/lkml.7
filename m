Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B12C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F36521707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hervEiYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGHW4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:56:47 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35548 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfGHW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:56:45 -0400
Received: by mail-pf1-f201.google.com with SMTP id r142so11179159pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mgBpCx6CWfEZqhYDHYS+zPohWIoo7fdF1geROPA0ULA=;
        b=hervEiYDs7Q2SvRkIEf4brdnTQw7MghOqdn01eWpOIXXBzvIUrL4jTkv4icYVN2koO
         brxuISIVjc9VvRW4aalVzfm6BQjNdpUKauHIJNNcQBkfpNQi3kjOhi9hsiiP11+8K+8p
         VoIzjJnjaB99WjFGjehw34T0aQndgbmBFZiPaaxqMdFyeiklH+DviZ2YIoH+CmpggYA9
         DPb5pu0zmGBundTxk5VBYS4uY8jWR/vjchjNawojxL4wEthSGO5ihTQVXogbPdenT8Ui
         eTlmueTUJP8c9+pDz1oBrklJ5JjD5CsqSFQiL7gkd2LTWsa4jTUJMsDPCP8tp77WoPh6
         3Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgBpCx6CWfEZqhYDHYS+zPohWIoo7fdF1geROPA0ULA=;
        b=fTRoaBw90KKsil6VnPBHCjZKJD0ZGvlesqjCZLdkZH5kVThRdFgcueY8bIn47PI1T3
         1165QntM/JNgKWn5MO5xp5BWzTttQh/BFr3L4XwgUsvTWWF/EhX5Gw9gG//yGg4KsfmQ
         RR/IlMSnRYLYE6RrHHBoIIhXViTjP4Y7xyWR8KOEGz18D/SjOTYFl8uWlNTyKn0e91+6
         sjgKJbTQWu7cYguja3rcjDXS4nCegMTdnL5CRRae4qaRmEdebI6AcSxQsNJ8wKc2qbFc
         +VZgwTSC65gCNtHNgTUH46KkLpsgbtt96mn9LlVGS0/q6EQLPypWnwxQubXVM/zQ/eav
         KXyg==
X-Gm-Message-State: APjAAAUCoOf7FZXB2rGwdu9X/yYN65pez4KMBeRlWn32zHR/B5Sdz3se
        NK8t2lG2sqJdSWnwJEn2SR/PQ6OllR4vI7I=
X-Google-Smtp-Source: APXvYqw+JRwFHBWaLEPLqJFvJKQ+G1E3/hF7EaAb3AIHa4dGZbu0e1sAZPJNBDubpeqbj2mmUlAabS326cgaiIU=
X-Received: by 2002:a63:1310:: with SMTP id i16mr26194626pgl.187.1562626604106;
 Mon, 08 Jul 2019 15:56:44 -0700 (PDT)
Date:   Mon,  8 Jul 2019 15:56:21 -0700
In-Reply-To: <20190708225624.119973-1-saravanak@google.com>
Message-Id: <20190708225624.119973-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190708225624.119973-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 5/8] driver core: Add APIs to pause/resume sync state callbacks
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

When multiple devices are added after kernel init, some suppliers could be
added before their consumer devices get added. In these instances, the
supplier devices could get their sync_state callback called right after
they probe because the consumers haven't had a chance to create device
links to the suppliers.

This change adds APIs to pause/resume sync state callbacks so that when
multiple devices are added, their sync_state callback evaluation can be
postponed to happen after all of them are added.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 34 +++++++++++++++++++++++++++-------
 drivers/of/platform.c  |  5 ++---
 include/linux/device.h |  6 ++++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dce97b5f3536..1c08f8614ae1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -46,7 +46,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
 /* Device links support. */
 static LIST_HEAD(wait_for_suppliers);
 static DEFINE_MUTEX(wfs_lock);
-static bool supplier_sync_state_enabled;
+static LIST_HEAD(deferred_sync);
+static unsigned int supplier_sync_state_disabled;
 
 #ifdef CONFIG_SRCU
 static DEFINE_MUTEX(device_links_lock);
@@ -657,17 +658,32 @@ static void __device_links_supplier_sync_state(struct device *dev)
 	dev->state_synced = true;
 }
 
-int device_links_supplier_sync_state(struct device *dev, void *data)
+void device_links_supplier_sync_state_pause(void)
 {
 	device_links_write_lock();
-	__device_links_supplier_sync_state(dev);
+	supplier_sync_state_disabled++;
 	device_links_write_unlock();
-	return 0;
 }
 
-void device_links_supplier_sync_state_enable(void)
+void device_links_supplier_sync_state_resume(void)
 {
-	supplier_sync_state_enabled = true;
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
 }
 
 /**
@@ -715,7 +731,9 @@ void device_links_driver_bound(struct device *dev)
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
 
-		if (supplier_sync_state_enabled)
+		if (supplier_sync_state_disabled)
+			list_add_tail(&dev->links.defer_sync, &deferred_sync);
+		else
 			__device_links_supplier_sync_state(link->supplier);
 	}
 
@@ -826,6 +844,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -1797,6 +1816,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->links.consumers);
 	INIT_LIST_HEAD(&dev->links.suppliers);
 	INIT_LIST_HEAD(&dev->links.needs_suppliers);
+	INIT_LIST_HEAD(&dev->links.defer_sync);
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 4d12d6658999..56b718f09929 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -581,6 +581,7 @@ static int __init of_platform_default_populate_init(void)
 		return -ENODEV;
 
 	platform_bus_type.add_links = of_link_to_suppliers;
+	device_links_supplier_sync_state_pause();
 	/*
 	 * Handle certain compatibles explicitly, since we don't want to create
 	 * platform_devices for every node in /reserved-memory with a
@@ -604,9 +605,7 @@ arch_initcall_sync(of_platform_default_populate_init);
 
 static int __init of_platform_sync_state_init(void)
 {
-	device_links_supplier_sync_state_enable();
-	bus_for_each_dev(&platform_bus_type, NULL, NULL,
-			 device_links_supplier_sync_state);
+	device_links_supplier_sync_state_resume();
 	return 0;
 }
 late_initcall_sync(of_platform_sync_state_init);
diff --git a/include/linux/device.h b/include/linux/device.h
index d3c9e70052d8..0ea28cb8c77e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -926,12 +926,14 @@ enum dl_dev_state {
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
 
@@ -1438,8 +1440,8 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
-int device_links_supplier_sync_state(struct device *dev, void *data);
-void device_links_supplier_sync_state_enable(void);
+void device_links_supplier_sync_state_pause(void);
+void device_links_supplier_sync_state_resume(void);
 void device_link_remove_from_wfs(struct device *consumer);
 
 #ifndef dev_fmt
-- 
2.22.0.410.gd8fdbe21b5-goog

