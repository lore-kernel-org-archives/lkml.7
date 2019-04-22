Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B05C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568BE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963404;
	bh=L1aehz1EFWzPIIRniZGjnB9/I8mVEb7GpixGNpjL9aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DpXvWe9MTLak97iYvjFnfLo+bm4Md0J3T+fjFjnjpvbmom2Dl6ClOb9gv73YPerEr
	 /qmf64njXo+2niPimVETIRgMfgw3CPEgufFS0x0GE0wobBhr0BpRfeB1wPu6nIwwbJ
	 H4L6lAkRJSqIqWDkuotPisLtUR2dopFsUaVauxFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfDVUDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbfDVTqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A8E1218D9;
        Mon, 22 Apr 2019 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962359;
        bh=L1aehz1EFWzPIIRniZGjnB9/I8mVEb7GpixGNpjL9aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iCmPbVZj5FBnm5PTZZNbN7efRDx0qTUdwmdhjpUVThmWkOxnydb9ceb2VsRNSQWOl
         9O3PvKU+hQCzgOPdE96gP3Y6Mq+eq9sFUH4T8rn5Pm9/Y83EST6xbQdt2hZBnASXDh
         PzMktfML0ksx1UhNs0x0bZwIQmCbWLMXOM8uxRck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guido Kiener <guido@kiener-muenchen.de>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/68] usb: gadget: net2280: Fix overrun of OUT messages
Date:   Mon, 22 Apr 2019 15:44:30 -0400
Message-Id: <20190422194516.11634-22-sashal@kernel.org>
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

[ Upstream commit 9d6a54c1430647355a5e23434881b2ca3d192b48 ]

The OUT endpoint normally blocks (NAK) subsequent packets when a
short packet was received and returns an incomplete queue entry to
the gadget driver. Thereby the gadget driver can detect a short packet
when reading queue entries with a length that is not equal to a
multiple of packet size.

The start_queue() function enables receiving OUT packets regardless of
the content of the OUT FIFO. This results in a race: With the current
code, it's possible that the "!ep->is_in && (readl(&ep->regs->ep_stat)
& BIT(NAK_OUT_PACKETS))" test in start_dma() will fail, then a short
packet will be received, and then start_queue() will call
stop_out_naking(). That's what we don't want (OUT naking gets turned
off while there is data in the FIFO) because then the next driver
request might receive a mixture of old and new packets.

With the patch, this race can't occur because the FIFO's state is
tested after we know that OUT naking is already turned on, and OUT
naking is stopped only when both of the conditions are met.  This
ensures that all received data is delivered to the gadget driver,
which can detect a short packet now before new packets are appended
to the last short packet.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Guido Kiener <guido.kiener@rohde-schwarz.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/usb/gadget/udc/net2280.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index b02ab2a8d927..c57046b1da0e 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -866,9 +866,6 @@ static void start_queue(struct net2280_ep *ep, u32 dmactl, u32 td_dma)
 	(void) readl(&ep->dev->pci->pcimstctl);
 
 	writel(BIT(DMA_START), &dma->dmastat);
-
-	if (!ep->is_in)
-		stop_out_naking(ep);
 }
 
 static void start_dma(struct net2280_ep *ep, struct net2280_request *req)
@@ -907,6 +904,7 @@ static void start_dma(struct net2280_ep *ep, struct net2280_request *req)
 			writel(BIT(DMA_START), &dma->dmastat);
 			return;
 		}
+		stop_out_naking(ep);
 	}
 
 	tmp = dmactl_default;
-- 
2.19.1

