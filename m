Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB70C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE6420449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810789;
	bh=fCTKQbpDjbLFW+41dr2DCnqUwGn0k4TigEQXyKRoi7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ptGrcH0brMW9qXTEAeblCBxdySOtIG6xu+zhNu8jig5zFhwV8wWLgtuGB7NRKKTH4
	 npm7yIMi7+YTZeu0/ijmgSJDgSr4aMbNHHRHIMoRtMuhfui37LkiaFwn5bUlWZSRD8
	 c6vSGeoL+tKsLUT++jdlgYIywzf27cxwa3j0tuMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfEBP02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfEBP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:26:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A1320449;
        Thu,  2 May 2019 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810783;
        bh=fCTKQbpDjbLFW+41dr2DCnqUwGn0k4TigEQXyKRoi7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxZtfOYu1fNJKhfal256Fta/bWw9kM6XG1+df3hST2anl+MedqxeSwDsC4ELivtGo
         3xNmw65WmnTlW6u3qf/30i/QT3an1FkZSct3ac+qaj5ZnpOusYR3mkSekzS4Bx7WfP
         Qo7Gaw1Padcozu/AfQyLB0sJClLm7G51jF2NNKPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Guido Kiener <guido.kiener@rohde-schwarz.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 28/72] usb: gadget: net2280: Fix overrun of OUT messages
Date:   Thu,  2 May 2019 17:20:50 +0200
Message-Id: <20190502143335.718228247@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



