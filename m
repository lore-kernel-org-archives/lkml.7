Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B56C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A3821823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y9qZ7WYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfLEOBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:01:43 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:42822 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfLEOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575554502; x=1607090502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T78jIw2G+NoTyOExzPIFxHYe8NsRzGe0PdgYlPNaGmg=;
  b=Y9qZ7WYRGp3bSBnj6CA+o8XlnU0DLW290xu2P0EhPee4ZKRNpzIY/zs9
   0zNF70PHScSvZR++0h9Q/iR5dQn9SP6pZ2RT/+wHyFlFFutyHXvScwynb
   QWSp4WKT2ij0y7ELrSPyK3oL6mD05wD79DXOYhI5Kr8X5FPDKGnjaaZz1
   w=;
IronPort-SDR: TrQOkzDuolXJUMTPo2K5HXoHg/ggo3T0ufETrbzTLZWL9eor9HDoWJ13NLIxasnRSejJg9I0w4
 O0aBChzSre4Q==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="7211159"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Dec 2019 14:01:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 197A6A27D0;
        Thu,  5 Dec 2019 14:01:39 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:38 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:37 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 14:01:35 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH 2/4] xenbus: limit when state is forced to closed
Date:   Thu, 5 Dec 2019 14:01:21 +0000
Message-ID: <20191205140123.3817-3-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205140123.3817-1-pdurrant@amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only force state to closed in the case when the toolstack may need to
clean up. This can be detected by checking whether the state in xenstore
has been set to closing prior to device removal.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index a10311c348b9..c54a53da0106 100644
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
@@ -264,6 +263,7 @@ int xenbus_dev_remove(struct device *_dev)
 {
 	struct xenbus_device *dev = to_xenbus_device(_dev);
 	struct xenbus_driver *drv = to_xenbus_driver(_dev->driver);
+	enum xenbus_state state;
 
 	DPRINTK("%s", dev->nodename);
 
@@ -276,7 +276,14 @@ int xenbus_dev_remove(struct device *_dev)
 
 	free_otherend_details(dev);
 
-	xenbus_switch_state(dev, XenbusStateClosed);
+	/*
+	 * If the toolstack had force the device state to closing then set
+	 * the state to closed now to allow it to be cleaned up.
+	 */
+	state = xenbus_read_driver_state(dev->nodename);
+	if (state == XenbusStateClosing)
+		xenbus_switch_state(dev, XenbusStateClosed);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(xenbus_dev_remove);
-- 
2.20.1

