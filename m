Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC30C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C3522CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urmie0jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfICIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfICIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WowrPXJWXwRHe/ZfVy1xduZ4nYQkuT9srIDr2fzdgQ0=; b=urmie0jpX7kIOxzUC5bJPxUdzt
        4QIxmuSU6F+JeljlXqUa4ZkB5j2RKtK4ouc1C5gEVrmHq54PZsrnY+XPqCdnDVdH1/nWMhIQ8DhVU
        FwGyFddo4xsQVaBtDxN8hI+YYKW9D+WcNjbUwHrwySdyQZMJ2et0BvebPmFRSButdTMNq5ry1I2HB
        hXZSX9NKZsuQMsIEErFVmQeL3lp/f/nIzHU8L6pRIvPcWj7evGqQgd6TlLIeUGLvPvooIwln31oCD
        AQ86ILYtYvBZyVa8TaHMlsjCzMdTniBBrZLX2RV8rbubyX6rFOIviivIXOIlj/9+Nmo+0tNmwR7Mq
        OB2JdhDQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SH-0003ro-GQ; Tue, 03 Sep 2019 08:46:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] usb-storage: use hcd_uses_dma to check for DMA capabilities
Date:   Tue,  3 Sep 2019 10:46:12 +0200
Message-Id: <20190903084615.19161-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903084615.19161-1-hch@lst.de>
References: <20190903084615.19161-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_mask on its own doesn't mean much.  Instead check for the actual
flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/storage/scsiglue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 05b80211290d..7e0bc640c237 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -40,6 +40,7 @@
 #include <scsi/scsi_eh.h>
 
 #include "usb.h"
+#include <linux/usb/hcd.h>
 #include "scsiglue.h"
 #include "debug.h"
 #include "transport.h"
@@ -141,11 +142,10 @@ static int slave_configure(struct scsi_device *sdev)
 
 	/*
 	 * Some USB host controllers can't do DMA; they have to use PIO.
-	 * They indicate this by setting their dma_mask to NULL.  For
-	 * such controllers we need to make sure the block layer sets
+	 * For such controllers we need to make sure the block layer sets
 	 * up bounce buffers in addressable memory.
 	 */
-	if (!us->pusb_dev->bus->controller->dma_mask)
+	if (!hcd_uses_dma(bus_to_hcd(us->pusb_dev->bus)))
 		blk_queue_bounce_limit(sdev->request_queue, BLK_BOUNCE_HIGH);
 
 	/*
-- 
2.20.1

