Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D0C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C052D2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917921;
	bh=XbHFDS6p7UpHsE3PAgEs/qcaXGxKbFDyyumsitjBcCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lvJyzob0Q3DD99oCS4hGszw52xm7rBBmX8+SwvYGCLm4nAX578jOaqXjve3z7oMdO
	 m0glxfbYP8bjdK6Xg4zLzXxdJqi6exgnNsgJWkzQk5ARpBIe1IAwwQ3w5Lro8uR1LV
	 NNTaY0TarY1VbxvuirvhxwOsMpw97TmOxuHpZ6SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEOK6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfEOK6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:58:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E35C216FD;
        Wed, 15 May 2019 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917915;
        bh=XbHFDS6p7UpHsE3PAgEs/qcaXGxKbFDyyumsitjBcCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x5pIJu+W8lunyckCToCclqidJi0SznedfF48lnNS1qqqiKdEBU0re0aPYa8e8U3LI
         UWoA32r3dxR/CwcOAiMTziz1gqJfv/KuWefV1OfA76jpoSW2RXvaTcMmjv6qOb7ZQH
         Vy4W1IuusYxr3ofC/iyOmQpJKBk16+DjQVxrVeYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 3.18 16/86] usb: gadget: net2272: Fix net2272_dequeue()
Date:   Wed, 15 May 2019 12:54:53 +0200
Message-Id: <20190515090645.846966532@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 091dacc3cc10979ab0422f0a9f7fcc27eee97e69 ]

Restore the status of ep->stopped in function net2272_dequeue().

When the given request is not found in the endpoint queue
the function returns -EINVAL without restoring the state of
ep->stopped. Thus the endpoint keeps blocked and does not transfer
any data anymore.

This fix is only compile-tested, since we do not have a
corresponding hardware. An analogous fix was tested in the sibling
driver. See "usb: gadget: net2280: Fix net2280_dequeue()"

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guido Kiener <guido.kiener@rohde-schwarz.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2272.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 4b2444e75840..83d0544338ca 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -962,6 +962,7 @@ net2272_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 			break;
 	}
 	if (&req->req != _req) {
+		ep->stopped = stopped;
 		spin_unlock_irqrestore(&ep->dev->lock, flags);
 		return -EINVAL;
 	}
-- 
2.19.1



