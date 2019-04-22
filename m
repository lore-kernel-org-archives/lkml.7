Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C7BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A811218CD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962635;
	bh=4p1ViJP7nWF7GWckE1LCukqQ2Ye/qP7N7i4nnAQ8E2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjb2h3N2YlVFILnMiKzM7o8eCpqxKFKxpM/Q3rxU2WcGPBEF04IMlvBGF5a57230l
	 g3N7GQz4zefxMiEUApQHNXxITqAWZSDIw9Oojhqs/N3Sc7hJAxu0kKYPsKRHe6mmYq
	 /Bat5oTAlzy4OmmGlAxpTug0PS5koJqsbb7+ZM/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfDVTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbfDVTu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:50:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0413204EC;
        Mon, 22 Apr 2019 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962626;
        bh=4p1ViJP7nWF7GWckE1LCukqQ2Ye/qP7N7i4nnAQ8E2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wR1dTadDnUlwVE7+14zkCUxx4NpSSotvOzw1rFjxExek2lffez6uEgPpH3eRZ6cpZ
         Eg9Tq7Tb6d9yWANQjNOAs/BwDOnse+HnJ1XEyhJBuAHWaI1oNmBNLqXNELzqcA4p/w
         ealkl1c0hFtwxFfvGdsEAJ4cnnrZeyJvFDPBs9/I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guido Kiener <guido@kiener-muenchen.de>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 02/15] usb: gadget: net2280: Fix overrun of OUT messages
Date:   Mon, 22 Apr 2019 15:50:09 -0400
Message-Id: <20190422195022.13760-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422195022.13760-1-sashal@kernel.org>
References: <20190422195022.13760-1-sashal@kernel.org>
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
index 8d13337e2dde..931765208286 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -800,9 +800,6 @@ static void start_queue(struct net2280_ep *ep, u32 dmactl, u32 td_dma)
 	(void) readl(&ep->dev->pci->pcimstctl);
 
 	writel(BIT(DMA_START), &dma->dmastat);
-
-	if (!ep->is_in)
-		stop_out_naking(ep);
 }
 
 static void start_dma(struct net2280_ep *ep, struct net2280_request *req)
@@ -841,6 +838,7 @@ static void start_dma(struct net2280_ep *ep, struct net2280_request *req)
 			writel(BIT(DMA_START), &dma->dmastat);
 			return;
 		}
+		stop_out_naking(ep);
 	}
 
 	tmp = dmactl_default;
-- 
2.19.1

