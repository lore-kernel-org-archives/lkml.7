Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67731C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0C520663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rfeQrXTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfLJLec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:34:32 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62268 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575977672; x=1607513672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJN0wSFtdOZDYjIZyP04UHN4GCv/sSLr82yiruvNA8s=;
  b=rfeQrXTt8Adg1cg1n56VnPS2hd3iQPCLamyav/J0APYaE58oqLLcL3bU
   NOyhYqjDCEx16kbmNakQLEbPTcf3Enggb1abxs+lfbfcDWPIvhHLHgZtb
   GhCvhmUoXS+0rz6i/DZsrsmpuo5xoUwP+hev6uWS6YxQxJ9Xn2SqfAJ6U
   E=;
IronPort-SDR: v9HAsxUvYmEiTpVmKIHL6RlIhHRXGh0KROqBNNZAN+n39/I6tRV+5fSJgtDts5HUSYayq9NVAY
 7jAdk/ztpExw==
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="12635017"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Dec 2019 11:34:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 05FA3A1F60;
        Tue, 10 Dec 2019 11:34:10 +0000 (UTC)
Received: from EX13D32EUB002.ant.amazon.com (10.43.166.114) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:10 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUB002.ant.amazon.com (10.43.166.114) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:09 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 11:34:08 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v2 2/4] xenbus: limit when state is forced to closed
Date:   Tue, 10 Dec 2019 11:33:45 +0000
Message-ID: <20191210113347.3404-3-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210113347.3404-1-pdurrant@amazon.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a driver probe() fails then leave the xenstore state alone. There is no
reason to modify it as the failure may be due to transient resource
allocation issues and hence a subsequent probe() may succeed.

If the driver supports re-binding then only force state to closed during
remove() only in the case when the toolstack may need to clean up. This can
be detected by checking whether the state in xenstore has been set to
closing prior to device removal.

NOTE: Re-bind support is indicated by new boolean in struct xenbus_driver,
      which defaults to false. Subsequent patches will add support to
      some backend drivers.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Introduce the 'allow_rebind' flag
 - Expand the commit comment
---
 drivers/xen/xenbus/xenbus_probe.c | 12 ++++++++++--
 include/xen/xenbus.h              |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index a10311c348b9..9303ff35b2bd 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -255,7 +255,6 @@ int xenbus_dev_probe(struct device *_dev)
 	module_put(drv->driver.owner);
 fail:
 	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
-	xenbus_switch_state(dev, XenbusStateClosed);
 	return err;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_probe);
@@ -276,7 +275,16 @@ int xenbus_dev_remove(struct device *_dev)
 
 	free_otherend_details(dev);
 
-	xenbus_switch_state(dev, XenbusStateClosed);
+	/*
+	 * If the toolstack has forced the device state to closing then set
+	 * the state to closed now to allow it to be cleaned up.
+	 * Similarly, if the driver does not support re-bind, set the
+	 * closed.
+	 */
+	if (!drv->allow_rebind ||
+	    xenbus_read_driver_state(dev->nodename) == XenbusStateClosing)
+		xenbus_switch_state(dev, XenbusStateClosed);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_remove);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..24228a102141 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -93,6 +93,7 @@ struct xenbus_device_id
 struct xenbus_driver {
 	const char *name;       /* defaults to ids[0].devicetype */
 	const struct xenbus_device_id *ids;
+	bool allow_rebind; /* avoid setting xenstore closed during remove */
 	int (*probe)(struct xenbus_device *dev,
 		     const struct xenbus_device_id *id);
 	void (*otherend_changed)(struct xenbus_device *dev,
-- 
2.20.1

