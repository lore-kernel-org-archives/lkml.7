Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D93C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BC22075B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404173AbfEXOwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403860AbfEXOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:52:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E02AFAF7F;
        Fri, 24 May 2019 14:52:34 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: clear port_remote_wakeup after resume failure
Date:   Fri, 24 May 2019 16:52:30 +0200
Message-Id: <20190524145231.6605-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was seen on a Dell Precision 5520 using it's WD15 dock. The dock's
Ethernet device interfaces with the laptop through one of it's USB3
ports. While idle, the Ethernet device and HCD are suspended by runtime
PM, being the only device connected on the bus. Then, both are resumed on
behalf of the Ethernet device, which has remote wake-up capabilities.

The Ethernet device was observed to randomly disconnect from the USB
port shortly after submitting it's remote wake-up request. Probably a
weird timing issue yet to be investigated. This causes runtime PM to
busyloop causing some tangible CPU load. The reason is the port gets
stuck in the middle of a remote wake-up operation, waiting for the
device to switch to U0. This never happens, leaving "port_remote_wakeup"
enabled, and automatically triggering a failure on any further suspend
operation.

This patch clears "port_remote_wakeup" upon detecting a device with a
wrong resuming port state (see Table 4-9 in 4.15.2.3). Making sure the
above mentioned situation doesn't trigger a PM busyloop.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-hub.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 3abe70ff1b1e..53f5ee50ef8c 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1047,8 +1047,8 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 		xhci_get_usb2_port_status(port, &status, raw_port_status,
 					  flags);
 	/*
-	 * Clear stale usb2 resume signalling variables in case port changed
-	 * state during resume signalling. For example on error
+	 * Clear stale resume signalling variables in case port changed
+	 * state during resume signalling. For example on error.
 	 */
 	if ((bus_state->resume_done[wIndex] ||
 	     test_bit(wIndex, &bus_state->resuming_ports)) &&
@@ -1057,6 +1057,12 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 		bus_state->resume_done[wIndex] = 0;
 		clear_bit(wIndex, &bus_state->resuming_ports);
 		usb_hcd_end_port_resume(&hcd->self, wIndex);
+	} else if (bus_state->port_remote_wakeup & (1 << port->hcd_portnum) &&
+		   ((raw_port_status & PORT_PLS_MASK) != XDEV_RESUME ||
+		   !(raw_port_status & PORT_CONNECT) ||
+		   !(raw_port_status & PORT_PE) ||
+		   raw_port_status & PORT_OC)) {
+		bus_state->port_remote_wakeup &= ~(1 << port->hcd_portnum);
 	}
 
 	if (bus_state->port_c_suspend & (1 << wIndex))
-- 
2.21.0

