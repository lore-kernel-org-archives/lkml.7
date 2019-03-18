Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8849CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E39205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfCRRAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:00:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfCRRAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:00:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AB07AE9D;
        Mon, 18 Mar 2019 17:00:45 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     oneukum@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] xhci: clear port_remote_wakeup on device disconnection
Date:   Mon, 18 Mar 2019 18:00:37 +0100
Message-Id: <20190318170038.23914-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported on a Dell Precision 5520 using it's WD15 dock. The
dock's Ethernet device interfaces with the laptop through one of it's
USB3 ports. While idle, the Ethernet device and HCD are suspended by
runtime PM, being the only active device connected to the bus. They are
both generally resumed on behalf of the Ethernet device, which has
remote wake-up capabilities.

The Ethernet device was observed randomly disconnecting from the USB
port shortly after submitting it's remote wake-up request. This causes
the PM to busyloop, as the port is in the middle of a remote wake-up
operation, waiting for the device to switch to U0. This leaves a bit set
in "port_remote_wakeup", which stops any further suspend/resume
operations.

The logs look like this (I added the port status print in the first
one):

[28128.472101] xhci_hcd:handle_port_status: xhci_hcd 0000:3e:00.0: port resume event for port 3, port status 0xc4013e3
[28128.472165] xhci_hcd:xhci_hub_control: xhci_hcd 0000:3e:00.0: get port status, actual port 0 status  = 0x1e0
[28128.472200] usbcore:hub_event: hub 4-0:1.0: state 7 ports 2 chg 0002 evt 0000
[28128.472221] usb 4-1: USB disconnect, device number 2

In between the first two logs we acknowledge the remote wake-up request,
setting the link state as U0 and setting the relevant bit in
"port_remote_wakeup". We also call usb_hcd_resume_root_hub() which will
wake up the hub device. Note the CCS & PED bits on the port status are
still set (see 5.4.8 in spec). In between the second and third log, the
hub device finds out about the disconnection (CSS & PED are now 0),
which triggers a call to hub_port_connect() which finds an already
existing USB device and disconnects it. Runtime PM, seeing no devices
connected to the HCD busyloops trying to suspend the device, which fails
every time because of "port_remote_wakeup", generating a tangible CPU
load.

This patch clears "port_remote_wakeup" upon detecting a device
disconnection. Making sure the above mentioned situation doesn't trigger
a PM busyloop.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/host/xhci-hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index e2eece693655..bea853f45aec 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -942,6 +942,9 @@ static void xhci_get_usb3_port_status(struct xhci_port *port, u32 *status,
 			bus_state->suspended_ports &= ~(1 << portnum);
 	}
 
+	if (!(portsc & PORT_CONNECT))
+		bus_state->port_remote_wakeup &= ~(1 << portnum);
+
 	xhci_hub_report_usb3_link_state(xhci, status, portsc);
 	xhci_del_comp_mod_timer(xhci, portsc, portnum);
 }
-- 
2.21.0

