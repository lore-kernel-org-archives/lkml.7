Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8861C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27B5206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521745;
	bh=AtPJOJjZvSlxSemNifGn2AXG+FwEBWhSA7Wid+V8wcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c7p3roLGPLwX1W88vkO6KmUKUGsvecRqFKp7BE1yLeKEECMMHsVTh85rZw84WxkfX
	 ld4ksuy4kpxfbwk8jp7KYW7yJJeTzQE1r/IjbYN0URcLjkI4viU8oHvD1L2z0ORXS0
	 DzGT1DJLfyW8ryeWe1wGBBpIfcX33RBEL15m0BVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfLPSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbfLPSAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7235206B7;
        Mon, 16 Dec 2019 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519219;
        bh=AtPJOJjZvSlxSemNifGn2AXG+FwEBWhSA7Wid+V8wcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAV44f31wkLTDs8/tZ1NTaVYpGT2AglqlhgSTqjm1b0bj34kA4ruR2s0Jv+vkm1WW
         In8eO+cLWIjhiR9S8iL5d5czNlMJY0rI1TZsYkHAliUYuZ/1fllLZYGL7oXEASZ+7x
         JwKvO4y9OJbbfzgHaTT/wOgb4VEqeCw/om60BIGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 245/267] xhci: make sure interrupts are restored to correct state
Date:   Mon, 16 Dec 2019 18:49:31 +0100
Message-Id: <20191216174915.981408128@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit bd82873f23c9a6ad834348f8b83f3b6a5bca2c65 ]

spin_unlock_irqrestore() might be called with stale flags after
reading port status, possibly restoring interrupts to a incorrect
state.

If a usb2 port just finished resuming while the port status is read
the spin lock will be temporary released and re-acquired in a separate
function. The flags parameter is passed as value instead of a pointer,
not updating flags properly before the final spin_unlock_irqrestore()
is called.

Cc: <stable@vger.kernel.org> # v3.12+
Fixes: 8b3d45705e54 ("usb: Fix xHCI host issues on remote wakeup.")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20191211142007.8847-7-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 997ff183c9cbb..95503bb9b067d 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -855,7 +855,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 		struct xhci_bus_state *bus_state,
 		__le32 __iomem **port_array,
 		u16 wIndex, u32 raw_port_status,
-		unsigned long flags)
+		unsigned long *flags)
 	__releases(&xhci->lock)
 	__acquires(&xhci->lock)
 {
@@ -937,12 +937,12 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			xhci_set_link_state(xhci, port_array, wIndex,
 					XDEV_U0);
 
-			spin_unlock_irqrestore(&xhci->lock, flags);
+			spin_unlock_irqrestore(&xhci->lock, *flags);
 			time_left = wait_for_completion_timeout(
 					&bus_state->rexit_done[wIndex],
 					msecs_to_jiffies(
 						XHCI_MAX_REXIT_TIMEOUT_MS));
-			spin_lock_irqsave(&xhci->lock, flags);
+			spin_lock_irqsave(&xhci->lock, *flags);
 
 			if (time_left) {
 				slot_id = xhci_find_slot_id_by_port(hcd,
@@ -1090,7 +1090,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		}
 		status = xhci_get_port_status(hcd, bus_state, port_array,
-				wIndex, temp, flags);
+				wIndex, temp, &flags);
 		if (status == 0xffffffff)
 			goto error;
 
-- 
2.20.1



