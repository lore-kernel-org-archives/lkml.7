Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C60CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39606218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qv9oiHU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbfJ1WAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:00:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:55012 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfJ1WAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:00:40 -0400
Received: by mail-yw1-f73.google.com with SMTP id 123so8444818ywq.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=upotkqq+9g/nTJCCHScNfZXgcoXdKEqGwLzb+Bn6D0Y=;
        b=Qv9oiHU7AUKTP0R5gGeXdUxj68ExoehUu9oDXkbMNcG68LytyaAqOaWMHTvi6qjMlL
         4kHkBlG0nvyxdKgPf0vmDcM97YaW799Rwp/eQgdHZhRdXTLiZrO3TibOL2e6KHuJX3t3
         F3LLCBGfL8A5wuA0YQtn/N9AqhfqCtKy8IA/5+dICz4hGjSRGih0Ed5OuBTME0s18y+v
         utT4L1ISxBCS9qdPLCdiJBvNR+dJy+eqTyEV7bBHNnVp6iRFro7HdbXivVtRh2pwMkDe
         yS6Md2B8LZjzD5AFFevJxHoADZq1lErKQPG0Mge4mnkdV3/jkJqe9RMFOkLanRlNA8Am
         8yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=upotkqq+9g/nTJCCHScNfZXgcoXdKEqGwLzb+Bn6D0Y=;
        b=fODCybdFjlZglg9GsTxs5wzQJBxG+4sM5czSOD1YAXL0i7mVzUlvblW0ic44OVLGN2
         pQKrxEqxG5zGo5BY+BrM3ta0TZkZdxhxgdBYHRju2ROOUwD4p6a1NA6tjDaqJZZs3Zio
         6nkEMplqN7S+DilEQZuZJrutiqIqD0Fw4cSVg/pnV8BkK2t7/VUTMPi0EY9tVgn+qBO4
         /7sUdiLx4WvLTNGWHo4lZd9kU4dk4xdzhHt33z7LUik7pAk+xM3GZblL0FwB4NfLaha4
         J47+lyLk8mUopRt+ptg303cGaTCZjQDrtuyTseNRG5h9H9igeuQmXdDVVw02gpdpAmHA
         VpKw==
X-Gm-Message-State: APjAAAV/My6siSTDmCTZHVpM5NQyhFhB8IGDqbJOAE1g8gQPEhZ/LV4D
        gg+tTZo3eM9kdK1B46xaw8DPfTXEnRwhKjY=
X-Google-Smtp-Source: APXvYqzcURfhua2CKyamK/sUULVUfXDKxXcKCDQwXhh9lS4MtwXiZPDAirm4HkPHHKjlnqf46/JbWEWCoXfGpHU=
X-Received: by 2002:a81:59c2:: with SMTP id n185mr14319764ywb.64.1572300037529;
 Mon, 28 Oct 2019 15:00:37 -0700 (PDT)
Date:   Mon, 28 Oct 2019 15:00:23 -0700
In-Reply-To: <20191028220027.251605-1-saravanak@google.com>
Message-Id: <20191028220027.251605-3-saravanak@google.com>
Mime-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v1 2/5] driver core: Allow a device to wait on optional suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, if a device is waiting on suppliers, it's assumed
that all those suppliers are needed for the device to probe
successfully. This change allows marking a devices as waiting only on
optional suppliers. This allows a device to wait on suppliers (and link
to them as soon as they are available) without preventing the device
from being probed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 28 +++++++++++++++++++++++++---
 include/linux/device.h |  3 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 17ed054c4132..48cd43a91ce6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -480,13 +480,25 @@ EXPORT_SYMBOL_GPL(device_link_add);
  * This function is NOT meant to be called from the probe function of the
  * consumer but rather from code that creates/adds the consumer device.
  */
-static void device_link_wait_for_supplier(struct device *consumer)
+static void device_link_wait_for_supplier(struct device *consumer,
+					  bool need_for_probe)
 {
 	mutex_lock(&wfs_lock);
 	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
+	consumer->links.need_for_probe = need_for_probe;
 	mutex_unlock(&wfs_lock);
 }
 
+static void device_link_wait_for_mandatory_supplier(struct device *consumer)
+{
+	device_link_wait_for_supplier(consumer, true);
+}
+
+static void device_link_wait_for_optional_supplier(struct device *consumer)
+{
+	device_link_wait_for_supplier(consumer, false);
+}
+
 /**
  * device_link_add_missing_supplier_links - Add links from consumer devices to
  *					    supplier devices, leaving any
@@ -656,7 +668,8 @@ int device_links_check_suppliers(struct device *dev)
 	 * probe.
 	 */
 	mutex_lock(&wfs_lock);
-	if (!list_empty(&dev->links.needs_suppliers)) {
+	if (!list_empty(&dev->links.needs_suppliers) &&
+	    dev->links.need_for_probe) {
 		mutex_unlock(&wfs_lock);
 		return -EPROBE_DEFER;
 	}
@@ -760,6 +773,15 @@ void device_links_driver_bound(struct device *dev)
 {
 	struct device_link *link;
 
+	/*
+	 * If a device probes successfully, it's expected to have created all
+	 * the device links it needs to or make new device links as it needs
+	 * them. So, it no longer needs to wait on any suppliers.
+	 */
+	mutex_lock(&wfs_lock);
+	list_del_init(&dev->links.needs_suppliers);
+	mutex_unlock(&wfs_lock);
+
 	device_links_write_lock();
 
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
@@ -2393,7 +2415,7 @@ int device_add(struct device *dev)
 
 	if (fwnode_has_op(dev->fwnode, add_links)
 	    && fwnode_call_int_op(dev->fwnode, add_links, dev))
-		device_link_wait_for_supplier(dev);
+		device_link_wait_for_mandatory_supplier(dev, true);
 
 	bus_probe_device(dev);
 	if (parent)
diff --git a/include/linux/device.h b/include/linux/device.h
index f1f2aa0b19da..4fd33da9a848 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1156,6 +1156,8 @@ enum dl_dev_state {
  * @consumers: List of links to consumer devices.
  * @needs_suppliers: Hook to global list of devices waiting for suppliers.
  * @defer_sync: Hook to global list of devices that have deferred sync_state.
+ * @need_for_probe: If needs_suppliers is on a list, this indicates if the
+ *		    suppliers are needed for probe or not.
  * @status: Driver status information.
  */
 struct dev_links_info {
@@ -1163,6 +1165,7 @@ struct dev_links_info {
 	struct list_head consumers;
 	struct list_head needs_suppliers;
 	struct list_head defer_sync;
+	bool need_for_probe;
 	enum dl_dev_state status;
 };
 
-- 
2.24.0.rc0.303.g954a862665-goog

