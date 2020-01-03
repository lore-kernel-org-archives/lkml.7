Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF99C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5FA2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgACIkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:40:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:40:19 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inIVC-0003Sp-4G; Fri, 03 Jan 2020 08:40:14 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/3] xhci: Ensure link state is U3 after setting USB_SS_PORT_LS_U3
Date:   Fri,  3 Jan 2020 16:40:06 +0800
Message-Id: <20200103084008.3579-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xHCI spec doesn't specify the upper bound of U3 transition time. For
some devices 20ms is not enough, so we need to make sure the link state
is in U3 before further actions.

I've tried to use U3 Entry Capability by setting U3 Entry Enable in
config register, however the port change event for U3 transition
interrupts the system suspend process.

For now let's use the less ideal method by polling PLS.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7a3a29e5e9d2..2b2e9d004dbf 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1228,6 +1228,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			break;
 		case USB_PORT_FEAT_LINK_STATE:
 			temp = readl(ports[wIndex]->addr);
+			xhci_dbg(xhci, "before setting link state, actual port %d-%d status = 0x%0x\n", hcd->self.busnum, wIndex + 1, temp);
 			/* Disable port */
 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
 				xhci_dbg(xhci, "Disable port %d\n", wIndex);
@@ -1316,9 +1317,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			msleep(20); /* wait device to enter */
 			spin_lock_irqsave(&xhci->lock, flags);
 
-			temp = readl(ports[wIndex]->addr);
-			if (link_state == USB_SS_PORT_LS_U3)
+			if (link_state == USB_SS_PORT_LS_U3) {
+				retval = xhci_handshake(ports[wIndex]->addr, PORT_PLS_MASK, XDEV_U3, 80 * 1000);
+				if (retval)
+					xhci_dbg(xhci, "polling XDEV_U3 on port %d-%d timeout\n", hcd->self.busnum, wIndex + 1);
+
 				bus_state->suspended_ports |= 1 << wIndex;
+			}
+
+			temp = readl(ports[wIndex]->addr);
+			xhci_dbg(xhci, "after setting link state, port %d-%d status = 0x%0x\n", hcd->self.busnum, wIndex + 1, temp);
+
 			break;
 		case USB_PORT_FEAT_POWER:
 			/*
-- 
2.17.1

