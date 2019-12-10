Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD11CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891720663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IozziQiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLJLeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:34:14 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:16166 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575977653; x=1607513653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPziW0dLjY9DvgtbJPoGFRZkja9CKYaPD9IgY+xvU3Y=;
  b=IozziQiMiTtVtqCnty7Md2CgxTn6SCDXea4i0vne/+Y8ehuGAT+vpqO9
   +UP3lvMuulZdJuiz0Tiw+Vxsax5uEQAPhIEp8Q+lmJdcNyPHzwR+d/jUG
   zIYkcX6uQ+SZ2VKHjIbmqMIAnq54VPoDyNbytkDn4qg2sCb9ysib+TBoD
   c=;
IronPort-SDR: d8F7m+ntFLm4JeurEShiAWdrMfjuZ+jeZaDYybmliHDcYNkXbr19qt8xlZkstIdGYOkZnI90U0
 r3YDWGCO4HUQ==
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="6964413"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Dec 2019 11:34:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 3CBD1A1C16;
        Tue, 10 Dec 2019 11:34:09 +0000 (UTC)
Received: from EX13D32EUB001.ant.amazon.com (10.43.166.125) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:08 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUB001.ant.amazon.com (10.43.166.125) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:07 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 11:34:06 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 1/4] xenbus: move xenbus_dev_shutdown() into frontend code...
Date:   Tue, 10 Dec 2019 11:33:44 +0000
Message-ID: <20191210113347.3404-2-pdurrant@amazon.com>
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

...and make it static

xenbus_dev_shutdown() is seemingly intended to cause clean shutdown of PV
frontends when a guest is rebooted. Indeed the function waits for a
conpletion which is only set by a call to xenbus_frontend_closed().

This patch removes the shutdown() method from backends and moves
xenbus_dev_shutdown() from xenbus_probe.c into xenbus_probe_frontend.c,
renaming it appropriately and making it static.

NOTE: In the case where the backend is running in a driver domain, the
      toolstack should have already terminated any frontends that may be
      using it (since Xen does not support re-startable PV driver domains)
      so xenbus_dev_shutdown() should never be called.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/xenbus/xenbus.h                |  2 --
 drivers/xen/xenbus/xenbus_probe.c          | 23 ---------------------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 +++++++++++++++++++++-
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index d75a2385b37c..5f5b8a7d5b80 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -116,8 +116,6 @@ int xenbus_probe_devices(struct xen_bus_type *bus);
 
 void xenbus_dev_changed(const char *node, struct xen_bus_type *bus);
 
-void xenbus_dev_shutdown(struct device *_dev);
-
 int xenbus_dev_suspend(struct device *dev);
 int xenbus_dev_resume(struct device *dev);
 int xenbus_dev_cancel(struct device *dev);
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 4461f4583476..a10311c348b9 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -281,29 +281,6 @@ int xenbus_dev_remove(struct device *_dev)
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_remove);
 
-void xenbus_dev_shutdown(struct device *_dev)
-{
-	struct xenbus_device *dev = to_xenbus_device(_dev);
-	unsigned long timeout = 5*HZ;
-
-	DPRINTK("%s", dev->nodename);
-
-	get_device(&dev->dev);
-	if (dev->state != XenbusStateConnected) {
-		pr_info("%s: %s: %s != Connected, skipping\n",
-			__func__, dev->nodename, xenbus_strstate(dev->state));
-		goto out;
-	}
-	xenbus_switch_state(dev, XenbusStateClosing);
-	timeout = wait_for_completion_timeout(&dev->down, timeout);
-	if (!timeout)
-		pr_info("%s: %s timeout closing device\n",
-			__func__, dev->nodename);
- out:
-	put_device(&dev->dev);
-}
-EXPORT_SYMBOL_GPL(xenbus_dev_shutdown);
-
 int xenbus_register_driver_common(struct xenbus_driver *drv,
 				  struct xen_bus_type *bus,
 				  struct module *owner, const char *mod_name)
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..14876faff3b0 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -198,7 +198,6 @@ static struct xen_bus_type xenbus_backend = {
 		.uevent		= xenbus_uevent_backend,
 		.probe		= xenbus_dev_probe,
 		.remove		= xenbus_dev_remove,
-		.shutdown	= xenbus_dev_shutdown,
 		.dev_groups	= xenbus_dev_groups,
 	},
 };
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index a7d90a719cea..8a1650bbe18f 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -126,6 +126,28 @@ static int xenbus_frontend_dev_probe(struct device *dev)
 	return xenbus_dev_probe(dev);
 }
 
+static void xenbus_frontend_dev_shutdown(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	unsigned long timeout = 5*HZ;
+
+	DPRINTK("%s", dev->nodename);
+
+	get_device(&dev->dev);
+	if (dev->state != XenbusStateConnected) {
+		pr_info("%s: %s: %s != Connected, skipping\n",
+			__func__, dev->nodename, xenbus_strstate(dev->state));
+		goto out;
+	}
+	xenbus_switch_state(dev, XenbusStateClosing);
+	timeout = wait_for_completion_timeout(&dev->down, timeout);
+	if (!timeout)
+		pr_info("%s: %s timeout closing device\n",
+			__func__, dev->nodename);
+ out:
+	put_device(&dev->dev);
+}
+
 static const struct dev_pm_ops xenbus_pm_ops = {
 	.suspend	= xenbus_dev_suspend,
 	.resume		= xenbus_frontend_dev_resume,
@@ -146,7 +168,7 @@ static struct xen_bus_type xenbus_frontend = {
 		.uevent		= xenbus_uevent_frontend,
 		.probe		= xenbus_frontend_dev_probe,
 		.remove		= xenbus_dev_remove,
-		.shutdown	= xenbus_dev_shutdown,
+		.shutdown	= xenbus_frontend_dev_shutdown,
 		.dev_groups	= xenbus_dev_groups,
 
 		.pm		= &xenbus_pm_ops,
-- 
2.20.1

