Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FCC742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C51D20874
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXcvXIe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfGLXxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:53:14 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:52930 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfGLXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:53:06 -0400
Received: by mail-pl1-f201.google.com with SMTP id g18so5992084plj.19
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZEVp2FCp1m5Avn1zvXLMIQboGrgTrI7qvc1ZsTzxPVA=;
        b=tXcvXIe2kvoVcWyV5vJrUI4NMxZlZITLOAHkR4m+X9tLPBSzepy2Aq5Q8ocCI7fFlf
         BzKkEyLxc4iQCMI4yCAFnxW4hcjXoyF13oiKC0o0TRiCpRRz02ZH49phlN5qe6/hd4N5
         KFcoLLue5fa+qjsOhJplb8wGSthDc13X3r4sPHb+Z4I79Tthi7KDw5GQPewK95komqvF
         5cH6Yaxt4i8m4xXrHoZNP0okWhLR5J0EVRhdSeIGWLLMNDZPaURTa30cTfIVFD4aDGGH
         CaPOrWn6sqmgmCnYOniac8jrO2BQ+H0dwMEukI+RaPOvjBXTL3hfFagsUa9yH3gJHV1P
         tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEVp2FCp1m5Avn1zvXLMIQboGrgTrI7qvc1ZsTzxPVA=;
        b=i9x0sRkBMjkhjGL7HZOUEPuJcDLCFrCcZNIQa4sUOWp+7HBlDNw+9zNCoDa8/honBG
         1YMuMvdRcWj0wY6kev8edAx0+Ujx+wEyZ3WNE7GMp2eSrWQ/3JXqYVwTkJB3JQ7z7LJn
         7ZAqEV/ItV24zrgSH2UgY53Im/8gezdfhQDNyArFbf81Q4qthsmQZcqs3wy5JGw8OR4M
         eA+A8l8jP+wNccRfIjCwRXOVIHmmHhY/Zq6HsHV7GOZqT+v2X0kcNiE5o3F9QQ1K69tz
         Hj5aaDMjGReKcnHQhpHAYEGGKxQI6dGJaoNH2345kh8l9E/c5O12tCpp9YFE46mQd5wL
         GsoA==
X-Gm-Message-State: APjAAAXTlP6r5t8pRM8hBSPa92GV2ZqptvdMCRCpXcZNABTIX49XtG3z
        aPdS+8zq72eTCijbYxKJMGm/zcf35cGObvw=
X-Google-Smtp-Source: APXvYqwE93haDcWZIlE2uV9aKH/dihxMkEOtWldOKrJoEgGLHZA+61FZ6MoYEiiGgPqIAnMgMdh/D+ehB20Y96o=
X-Received: by 2002:a63:4612:: with SMTP id t18mr5009360pga.85.1562975585221;
 Fri, 12 Jul 2019 16:53:05 -0700 (PDT)
Date:   Fri, 12 Jul 2019 16:52:38 -0700
In-Reply-To: <20190712235245.202558-1-saravanak@google.com>
Message-Id: <20190712235245.202558-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190712235245.202558-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v5 05/11] driver core: Add APIs to pause/resume sync state callbacks
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
 drivers/base/core.c    | 40 +++++++++++++++++++++++++++++++++-------
 drivers/of/platform.c  |  5 ++---
 include/linux/device.h |  6 ++++--
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dce97b5f3536..b03e679faea4 100644
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
@@ -657,17 +658,38 @@ static void __device_links_supplier_sync_state(struct device *dev)
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
+}
+
+static void __device_links_supplier_defer_sync(struct device *sup)
+{
+	if (list_empty(&sup->links.defer_sync))
+		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
 /**
@@ -715,7 +737,9 @@ void device_links_driver_bound(struct device *dev)
 		WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
 		WRITE_ONCE(link->status, DL_STATE_ACTIVE);
 
-		if (supplier_sync_state_enabled)
+		if (supplier_sync_state_disabled)
+			__device_links_supplier_defer_sync(link->supplier);
+		else
 			__device_links_supplier_sync_state(link->supplier);
 	}
 
@@ -826,6 +850,7 @@ void device_links_driver_cleanup(struct device *dev)
 		WRITE_ONCE(link->status, DL_STATE_DORMANT);
 	}
 
+	list_del_init(&dev->links.defer_sync);
 	__device_links_no_driver(dev);
 
 	device_links_write_unlock();
@@ -1797,6 +1822,7 @@ void device_initialize(struct device *dev)
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
2.22.0.510.g264f2c817a-goog

