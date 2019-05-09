Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3CC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2802173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dUvm8nws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEIMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:03:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2693 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEIMDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:03:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd416e50000>; Thu, 09 May 2019 05:02:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 May 2019 05:03:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 May 2019 05:03:22 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 May
 2019 12:03:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 9 May 2019 12:03:19 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd417070002>; Thu, 09 May 2019 05:03:21 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v7 1/1] usb: xhci: Add Clear_TT_Buffer
Date:   Thu, 9 May 2019 20:03:15 +0800
Message-ID: <1557403395-30877-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557403366; bh=4BNRQUnX0VhRtHzymnRkGPEsQHsUPdak/BSiTG0wGEY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=dUvm8nwsJP6XObTMH7mvBxW1WWxygKe9DfGftaliV7+mlBbzxU7UtCEMtyFfGQauP
         IGTo2Ehd9xGKWLEkUsqfq2s2hFNqxCS43OJ7j0gKSVxErCH1JS+j6Q0GvtxtETrLun
         gh6Lym6yQjgFZsrk2lOSbCWHzqlF1YVsROW/iY/HaZKpXkkQCpaiF1wtQ9Hi8hTjWO
         BATi3NQZx9wjqvl5fwAO3DKuys8nP2HnSJBEb7dVNwsEviArF5FSD2var2fLKMLwZG
         oOVeIUSbDC8P/IeeEacWAYsRyBQO/7sFjdUBT4fRu+PUMDXoxu+hrS8P5P4ZDpw1Q8
         dE3aEq1xOFzKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
processing for full-/low-speed endpoints connected via a TT, the host
software must use the Clear_TT_Buffer request to the TT to ensure
that the buffer is not in the busy state".

In our case, a full-speed speaker (ConferenceCam) is behind a high-
speed hub (ConferenceCam Connect), sometimes once we get STALL on a
request we may continue to get STALL with the folllowing requests,
like Set_Interface.

Solution is to invoke usb_hub_clear_tt_buffer() to send
Clear_TT_Buffer request to the hub of the device for the following
Set_Interface requests to the device to get ACK successfully.

The Clear_TT_Buffer request sent to the hub includes the address of
the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
uses udev->devnum to set the address wValue. This won't work for
devices connected to xHC.

For other host controllers udev->devnum is the same as the address of
the usb device, chosen and set by usb core. With xHC the controller
hardware assigns the address, and won't be the same as devnum.

In the fix we add devaddr field in "struct usb_device" (usb.h),
update it in the address_device callback function of XHCI driver.
In usb_hub_clear_tt_buffer() we use udev->devaddr in wValue field if
hcd driver has address_device callback function defined.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
v2: xhci_clear_tt_buffer_complete: add static, shorter indentation
    , remove its claiming in xhci.h
v3: Add description for clearing_tt (xhci.h)
v4: Remove clearing_tt flag because hub_tt_work has hub->tt.lock
    to protect for Clear_TT_Buffer to be run serially.
    Remove xhci_clear_tt_buffer_complete as it's not necessary.
    Same reason as the above.
    Extend usb_hub_clear_tt_buffer parameter
v5: Not extending usb_hub_clear_tt_buffer parameter
    Add description.
v6: Remove unused parameter slot_id from xhci_clear_hub_tt_buffer
v7: Add devaddr field in "struct usb_device"

 drivers/usb/core/hub.c       |  6 +++++-
 drivers/usb/host/xhci-ring.c | 12 ++++++++++++
 drivers/usb/host/xhci.c      |  1 +
 include/linux/usb.h          |  2 ++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 15a2934dc29d..a6621e151c8c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -858,6 +858,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	struct usb_tt		*tt = udev->tt;
 	unsigned long		flags;
 	struct usb_tt_clear	*clear;
+	struct usb_hcd		*hcd = bus_to_hcd(udev->bus);
 
 	/* we've got to cope with an arbitrary number of pending TT clears,
 	 * since each TT has "at least two" buffers that can need it (and
@@ -873,7 +874,10 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	/* info that CLEAR_TT_BUFFER needs */
 	clear->tt = tt->multi ? udev->ttport : 1;
 	clear->devinfo = usb_pipeendpoint (pipe);
-	clear->devinfo |= udev->devnum << 4;
+	if (hcd->driver->address_device)
+		clear->devinfo |= udev->devaddr << 4;
+	else
+		clear->devinfo |= udev->devnum << 4;
 	clear->devinfo |= usb_pipecontrol(pipe)
 			? (USB_ENDPOINT_XFER_CONTROL << 11)
 			: (USB_ENDPOINT_XFER_BULK << 11);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9215a28dad40..739737faf752 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1786,6 +1786,17 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 	return NULL;
 }
 
+static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci, struct xhci_td *td)
+{
+	/*
+	 * As part of low/full-speed endpoint-halt processing
+	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
+	 */
+	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
+	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub))
+		usb_hub_clear_tt_buffer(td->urb);
+}
+
 static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 		unsigned int slot_id, unsigned int ep_index,
 		unsigned int stream_id, struct xhci_td *td,
@@ -1804,6 +1815,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 	if (reset_type == EP_HARD_RESET) {
 		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
+		xhci_clear_hub_tt_buffer(xhci, td);
 	}
 	xhci_ring_cmd_db(xhci);
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7fa58c99f126..7c86c9eeb4d5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4096,6 +4096,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	/* Zero the input context control for later use */
 	ctrl_ctx->add_flags = 0;
 	ctrl_ctx->drop_flags = 0;
+	udev->devaddr = le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK;
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
 		       "Internal device address = %d",
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4229eb74bd2c..86d42f42cae4 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -625,6 +625,7 @@ struct usb3_lpm_parameters {
  *		parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
  *
  *	Will be used as wValue for SetIsochDelay requests.
+ * @devaddr: address on a USB bus, assigned by controller like XHCI
  *
  * Notes:
  * Usbcore drivers should not set usbdev->state directly.  Instead use
@@ -709,6 +710,7 @@ struct usb_device {
 	unsigned lpm_disable_count;
 
 	u16 hub_delay;
+	int devaddr;
 };
 #define	to_usb_device(d) container_of(d, struct usb_device, dev)
 
-- 
2.1.4

