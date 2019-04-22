Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66D218FD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962547;
	bh=ncTTy5MLwAyNHkaa7rAJ4dHZbEPDcAFiZGorQVTG798=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvT3+Hy0VFHo9Si1PNnN82QfHzLQb//g3MuN2jD9+U8K69KDTiT3qdu3ejuHUsRO4
	 S/AeOCDnHz9POqFjxB2cPhhIJtQbQQJhROArc2CScG9PViEn0wA3BunGFN/vlXd1ao
	 NRqPOHicmtEz2n5ICmNKapstlchJk5dOfecrsx9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfDVTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730706AbfDVTtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C09218FD;
        Mon, 22 Apr 2019 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962544;
        bh=ncTTy5MLwAyNHkaa7rAJ4dHZbEPDcAFiZGorQVTG798=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUq6OwwKiI0pK8ojwjQD09LxTdy1/2akcxPyWIKA+ZfXHCJHVKbtpP7kD2uzqEZKd
         cQUNbla4Vg2WExVPQ8H0tsX5Nb4hbOEvFc6qc62EzVWacD7lvEzK4aGHItK+ujhQe3
         DPHbclX7h+19L9H3SReFbtrSyDEvVkhZaQEd/Wug=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guido Kiener <guido@kiener-muenchen.de>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/29] usb: gadget: net2280: Fix net2280_dequeue()
Date:   Mon, 22 Apr 2019 15:48:28 -0400
Message-Id: <20190422194848.13049-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194848.13049-1-sashal@kernel.org>
References: <20190422194848.13049-1-sashal@kernel.org>
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
index 57b88f4f49c5..dfaed8e8cc52 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1277,9 +1277,9 @@ static int net2280_dequeue(struct usb_ep *_ep, struct usb_request *_req)
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

