Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3058FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FCE205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556812075;
	bh=39h+DdM+XOX7c9yMgptLx9m4eAoBdXw6fPJlEiOzJKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zohC75R7iFuuTcWhbtKLE0M7YcBj7gAcG4HUDCeUCKW5zC+cVrCNaMqSRDiK79LN9
	 ql2N1QqQSC/xfovnbDupenB/Qvg2nrik/SknQUmD1Yo+z5nWvAk1/yoz1gPUBZLQKs
	 BmM+sfVV9a/5UePVt/4fPhCJ7GtgAcllqs+p5/4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfEBPXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfEBPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:23:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE0921734;
        Thu,  2 May 2019 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810625;
        bh=39h+DdM+XOX7c9yMgptLx9m4eAoBdXw6fPJlEiOzJKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAt8ZoMm18L0hJBzd7PgBJs5ZmTSQpxbJABdSaMZVave0a0pud7zoxR1QN60OYqSA
         EDzgSYkhtxYmkI0tHTwA9Pvr1OkfbGRrCDzjUx3nNXmAPKQIW0P0o/ooe3zfIHDiLP
         DnSDbOTI3iLjXiYxJEEQ6ooWAmUNcQWYWA6S7544=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 18/49] usb: gadget: net2280: Fix net2280_dequeue()
Date:   Thu,  2 May 2019 17:20:55 +0200
Message-Id: <20190502143326.354202653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index a071ab0c163b..170327f84ea1 100644
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



