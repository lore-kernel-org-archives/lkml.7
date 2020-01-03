Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FFBC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6680F21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgACIkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:40:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58177 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgACIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:40:21 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1inIVF-0003T5-Vv; Fri, 03 Jan 2020 08:40:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/3] xhci: Wait until link state trainsits to U0 after setting USB_SS_PORT_LS_U0
Date:   Fri,  3 Jan 2020 16:40:07 +0800
Message-Id: <20200103084008.3579-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103084008.3579-1-kai.heng.feng@canonical.com>
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
time. The 20ms is not enough for some devices.

Intead of polling PLS or PLC, we can facilitate the port change event to
know that the link transits to U0 is completed.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c  | 8 +++++++-
 drivers/usb/host/xhci-mem.c  | 1 +
 drivers/usb/host/xhci-ring.c | 1 +
 drivers/usb/host/xhci.h      | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 2b2e9d004dbf..07886a1bce62 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1310,11 +1310,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 					spin_lock_irqsave(&xhci->lock, flags);
 				}
 			}
+			if (link_state == USB_SS_PORT_LS_U0)
+				reinit_completion(&ports[wIndex]->link_state_changed);
 
 			xhci_set_link_state(xhci, ports[wIndex], link_state);
 
 			spin_unlock_irqrestore(&xhci->lock, flags);
-			msleep(20); /* wait device to enter */
+			if (link_state == USB_SS_PORT_LS_U0) {
+				if (!wait_for_completion_timeout(&ports[wIndex]->link_state_changed, msecs_to_jiffies(100)))
+					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n", hcd->self.busnum, wIndex + 1);
+			} else
+				msleep(20); /* wait device to enter */
 			spin_lock_irqsave(&xhci->lock, flags);
 
 			if (link_state == USB_SS_PORT_LS_U3) {
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 3b1388fa2f36..c760a28e3556 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2268,6 +2268,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 		xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
 			NUM_PORT_REGS * i;
 		xhci->hw_ports[i].hw_portnum = i;
+		init_completion(&xhci->hw_ports[i].link_state_changed);
 	}
 
 	xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d23f7408c81f..44d91a53bf07 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1677,6 +1677,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
 	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
+		complete(&port->link_state_changed);
 		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 13d8838cd552..b86a664453dc 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1708,6 +1708,7 @@ struct xhci_port {
 	int			hw_portnum;
 	int			hcd_portnum;
 	struct xhci_hub		*rhub;
+	struct completion       link_state_changed;
 };
 
 struct xhci_hub {
-- 
2.17.1

