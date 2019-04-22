Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661ECC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BC721903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962368;
	bh=j6yeyVD+1tbV3hxfCLXAfvN5O6IhzeGm9btec9OKgkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MjMucuaiQeVJYEm9RCVIu2F+TozmdtETosQ0C6S40oHGomO9tz4pHq9u4uQWri7QB
	 JALeB7vTShOM5HvdQnLV1dd3UYMEo/l+siTGPx0ptVsAOSc6ECGP+eI4kNBjuf83YN
	 /8rexBpA9t7B/+l/6xLniLY2qvkjuqafbc3zPdAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfDVTqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbfDVTqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474A2218B0;
        Mon, 22 Apr 2019 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962362;
        bh=j6yeyVD+1tbV3hxfCLXAfvN5O6IhzeGm9btec9OKgkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP9svqd/q298+H627hu6ZXYrM9mn5k5mgrsVVOLba/ZzR2P9IIbq2CLhQ+C2PAlGc
         JjfdoHA6hffOkvxA6gVp1wKtcQpPdUbUX5m6UclMBf9wRl1nacUtfg/R5jUV+OdAax
         w7W6cVvjQ2yDEz/ezgbbpuRkRV2d4SrE5sO6MkQ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guido Kiener <guido@kiener-muenchen.de>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/68] usb: gadget: net2280: Fix net2280_dequeue()
Date:   Mon, 22 Apr 2019 15:44:31 -0400
Message-Id: <20190422194516.11634-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index c57046b1da0e..ee872cad5270 100644
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

