Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D282FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975AA20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419645;
	bh=Ezy/2toqxH4vDYuGNzQ7l2KT4KeAUcuyJ9W611bMqB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVljeGJS7ngMeYNJ16oxy58HZF+06M+Ydj8gSvr8m5ny7+8MTTQ7SfgaAvpLKE7XF
	 jRJu2NZrD9SdNHd5FoLh5e0Qhq6mcNgmT6m/gpOht3uvfOUqmzDvQbtbBeapZZfcOC
	 uZB8l7pIJFu6sKgs9DhQSXhgyGpTaTdnjug0+yMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfKVKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfKVKrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:47:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D74120718;
        Fri, 22 Nov 2019 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419641;
        bh=Ezy/2toqxH4vDYuGNzQ7l2KT4KeAUcuyJ9W611bMqB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4jDpmLl5B5hpKbnHBXQ5VwI3IFUTKAxvw5xyirCzpmSlwqCTNh2w8B1fUKng6W4i
         41UMSXGL7hslaluxgN0qO7e0XTV4oXuzFbT/xDAzX6e00/e/Ka0QGtA1g0QYUEbTeI
         icY7zE4XkgbB7/6nE1w3J/hPmq7q+r9OEuOoOOQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 165/222] usb: gadget: udc: fotg210-udc: Fix a sleep-in-atomic-context bug in fotg210_get_status()
Date:   Fri, 22 Nov 2019 11:28:25 +0100
Message-Id: <20191122100914.505807337@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 2337a77c1cc86bc4e504ecf3799f947659c86026 ]

The driver may sleep in an interrupt handler.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] fotg210_ep_queue(GFP_KERNEL)
drivers/usb/gadget/udc/fotg210-udc.c, 744:
	fotg210_ep_queue in fotg210_get_status
drivers/usb/gadget/udc/fotg210-udc.c, 768:
	fotg210_get_status in fotg210_setup_packet
drivers/usb/gadget/udc/fotg210-udc.c, 949:
	fotg210_setup_packet in fotg210_irq (interrupt handler)

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
If possible, spin_unlock() and spin_lock() around fotg210_ep_queue()
can be also removed.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 95df2b3bb6a1a..76e991557116a 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -744,7 +744,7 @@ static void fotg210_get_status(struct fotg210_udc *fotg210,
 	fotg210->ep0_req->length = 2;
 
 	spin_unlock(&fotg210->lock);
-	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_KERNEL);
+	fotg210_ep_queue(fotg210->gadget.ep0, fotg210->ep0_req, GFP_ATOMIC);
 	spin_lock(&fotg210->lock);
 }
 
-- 
2.20.1



