Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D621738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962183;
	bh=tdnyn7TX3KQXrd545pwSGqc4A9p3MbBSGaY1ee9cg1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jEq+cF+zY+4VJrd+d93NGh4cA/I4yGTk8WmyWFVZuua2OMqbZ0bhYHCIZgmo90JIr
	 JNSqD3iO51zE/0GpB5+HbVObHucXCvUjxxCP1jrL7Vk17LF+Cfo1j2yyrY9jSxr3Lt
	 yLZn1MxeR1cxbBCX4ABHJKU0wo4ZT9zdtFpQFawQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDVTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfDVTm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610CC21738;
        Mon, 22 Apr 2019 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962179;
        bh=tdnyn7TX3KQXrd545pwSGqc4A9p3MbBSGaY1ee9cg1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEyghscj3VmPHiQGDyIKWrWc7yj+ibab1dDn8TB+e5Iez3SDHMyIbnmw9X/Z5MLVU
         ExNO7eM8d+hoMugx1nGB3cLbAyTX6p5u+WkuseWyX3eALEj7g2CDm8jEDGMiuNO0NQ
         toutat+6DM/5GU66iozeFxi1Tu3Ye5xsSo1AOnRQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guido Kiener <guido@kiener-muenchen.de>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 32/98] usb: gadget: net2280: Fix net2280_dequeue()
Date:   Mon, 22 Apr 2019 15:40:59 -0400
Message-Id: <20190422194205.10404-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Kiener <guido@kiener-muenchen.de>

[ Upstream commit f1d3fba17cd4eeea20397f1324b7b9c69a6a935c ]

When a request must be dequeued with net2280_dequeue() e.g. due
to a device clear action and the same request is finished by the
function scan_dma_completions() then the function net2280_dequeue()
does not find the request in the following search loop and
returns the error -EINVAL without restoring the status ep->stopped.
Thus the endpoint keeps blocked and does not receive any data
anymore.
This fix restores the status and does not issue an error message.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guido Kiener <guido.kiener@rohde-schwarz.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2280.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index dc6f5a78d124..d93cf4171953 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1273,9 +1273,9 @@ static int net2280_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 			break;
 	}
 	if (&req->req != _req) {
+		ep->stopped = stopped;
 		spin_unlock_irqrestore(&ep->dev->lock, flags);
-		dev_err(&ep->dev->pdev->dev, "%s: Request mismatch\n",
-								__func__);
+		ep_dbg(ep->dev, "%s: Request mismatch\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.19.1

