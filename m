Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BAEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785FA21019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aIQvJMFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEFOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:34:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5366 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEFOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:34:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd045d40000>; Mon, 06 May 2019 07:33:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 07:34:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 May 2019 07:34:30 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 14:34:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 6 May 2019 14:34:29 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd045f30000>; Mon, 06 May 2019 07:34:29 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <hminas@synopsys.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <prime.zeng@hisilicon.com>, <malat@debian.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>,
        <linus.walleij@linaro.org>, <clabbe@baylibre.com>,
        <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v4 1/1] usb: xhci: Add Clear_TT_Buffer
Date:   Mon, 6 May 2019 22:34:22 +0800
Message-ID: <1557153262-22972-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557153236; bh=Q/DEh0KWbfxsLAH92wY6N5X/0pxwczeiWJVLn2rXiz0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=aIQvJMFdJT/Bxvg9Dzyu2zyfHOxF4gVaoLQabwfl2LTdgtZ6e9Q3/8waaiO3VO2O0
         QS0qR05gslyEQVeHTHNhSPfnQY+3oaFdUGqiQMBnmhKOnSiKClZwQQCj4CzLw075Nc
         yzefh3hABlD35I/1iOOzvW96rVDaIHWP+PPdXT4wKUvn2WHUZhL2mR5tV4E29jwzdl
         jToknEh0Wt8KZLHphNSC//f83UVGCG6JzwRlNS+zcn6idAgiMQCbz497pRDq0YQO+4
         Rs95Nhtet9stpgC5EfkT5o5qZ4aP8v38pvxIZnfQ9DcRcC+5aSW8znl1pJ/ARUF+5t
         2Zh/XDrdiyc7g==
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

Here we add Clear_TT_Buffer for the following Set_Interface requests
to get ACK successfully.

Originally usb_hub_clear_tt_buffer uses urb->dev->devnum as device
address while sending Clear_TT_Buffer command, but this doesn't work
for XHCI.
We have to extend usb_hub_clear_tt_buffer parameter to specify device
number that will have the TT state of its hub cleared.

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

 drivers/usb/core/hub.c            |  5 +++--
 drivers/usb/dwc2/hcd_intr.c       |  2 +-
 drivers/usb/host/ehci-q.c         |  2 +-
 drivers/usb/host/fotg210-hcd.c    |  2 +-
 drivers/usb/host/xhci-ring.c      | 22 ++++++++++++++++++++++
 drivers/usb/isp1760/isp1760-hcd.c |  5 +++--
 include/linux/usb/hcd.h           |  2 +-
 7 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 15a2934dc29d..4dec054c9776 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -840,6 +840,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
 /**
  * usb_hub_clear_tt_buffer - clear control/bulk TT state in high speed hub
  * @urb: an URB associated with the failed or incomplete split transaction
+ * @devnum : device number that will have the TT state of its hub cleared
  *
  * High speed HCDs use this to tell the hub driver that some split control or
  * bulk transaction failed in a way that requires clearing internal state of
@@ -851,7 +852,7 @@ int usb_hub_set_port_power(struct usb_device *hdev, struct usb_hub *hub,
  *
  * Return: 0 if successful. A negative error code otherwise.
  */
-int usb_hub_clear_tt_buffer(struct urb *urb)
+int usb_hub_clear_tt_buffer(struct urb *urb, int devnum)
 {
 	struct usb_device	*udev = urb->dev;
 	int			pipe = urb->pipe;
@@ -873,7 +874,7 @@ int usb_hub_clear_tt_buffer(struct urb *urb)
 	/* info that CLEAR_TT_BUFFER needs */
 	clear->tt = tt->multi ? udev->ttport : 1;
 	clear->devinfo = usb_pipeendpoint (pipe);
-	clear->devinfo |= udev->devnum << 4;
+	clear->devinfo |= devnum << 4;
 	clear->devinfo |= usb_pipecontrol(pipe)
 			? (USB_ENDPOINT_XFER_CONTROL << 11)
 			: (USB_ENDPOINT_XFER_BULK << 11);
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 88b5dcf3aefc..a3bb6911a62a 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -125,7 +125,7 @@ static void dwc2_hc_handle_tt_clear(struct dwc2_hsotg *hsotg,
 
 	if (qtd->urb->status != -EPIPE && qtd->urb->status != -EREMOTEIO) {
 		chan->qh->tt_buffer_dirty = 1;
-		if (usb_hub_clear_tt_buffer(usb_urb))
+		if (usb_hub_clear_tt_buffer(usb_urb, usb_urb->dev->devnum))
 			/* Clear failed; let's hope things work anyway */
 			chan->qh->tt_buffer_dirty = 0;
 	}
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index aa2f77f1506d..9f64c260239e 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -169,7 +169,7 @@ static void ehci_clear_tt_buffer(struct ehci_hcd *ehci, struct ehci_qh *qh,
 		if (!ehci_is_TDI(ehci)
 				|| urb->dev->tt->hub !=
 				   ehci_to_hcd(ehci)->self.root_hub) {
-			if (usb_hub_clear_tt_buffer(urb) == 0)
+			if (!usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 				qh->clearing_tt = 1;
 		} else {
 
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 0da68df259c8..bd29ed0fbd46 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -2123,7 +2123,7 @@ static void fotg210_clear_tt_buffer(struct fotg210_hcd *fotg210,
 
 		if (urb->dev->tt->hub !=
 				fotg210_to_hcd(fotg210)->self.root_hub) {
-			if (usb_hub_clear_tt_buffer(urb) == 0)
+			if (!usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 				qh->clearing_tt = 1;
 		}
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9215a28dad40..aa2a21e6cde3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1786,6 +1786,27 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 	return NULL;
 }
 
+static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci,
+	unsigned int slot_id, struct xhci_td *td)
+{
+	struct xhci_virt_device *dev;
+	struct xhci_slot_ctx *slot_ctx;
+	int devnum;
+
+	/*
+	 * As part of low/full-speed endpoint-halt processing
+	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
+	 */
+	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
+	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub)) {
+		dev = xhci->devs[slot_id];
+		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
+		devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
+			DEV_ADDR_MASK;
+		usb_hub_clear_tt_buffer(td->urb, devnum);
+	}
+}
+
 static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 		unsigned int slot_id, unsigned int ep_index,
 		unsigned int stream_id, struct xhci_td *td,
@@ -1804,6 +1825,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 	if (reset_type == EP_HARD_RESET) {
 		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
+		xhci_clear_hub_tt_buffer(xhci, slot_id, td);
 	}
 	xhci_ring_cmd_db(xhci);
 }
diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 8142c6b4c4cf..f1d68092becb 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -1166,7 +1166,8 @@ static void handle_done_ptds(struct usb_hcd *hcd)
 					(qtd->urb->status != -EPIPE) &&
 					(qtd->urb->status != -EREMOTEIO)) {
 				qh->tt_buffer_dirty = 1;
-				if (usb_hub_clear_tt_buffer(qtd->urb))
+				if (usb_hub_clear_tt_buffer(qtd->urb,
+						qtd->urb->dev->devnum))
 					/* Clear failed; let's hope things work
 					   anyway */
 					qh->tt_buffer_dirty = 0;
@@ -1633,7 +1634,7 @@ static void dequeue_urb_from_qtd(struct usb_hcd *hcd, struct isp1760_qh *qh,
 
 	if ((urb->dev->speed != USB_SPEED_HIGH) && urb_was_running) {
 		qh->tt_buffer_dirty = 1;
-		if (usb_hub_clear_tt_buffer(urb))
+		if (usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 			/* Clear failed; let's hope things work anyway */
 			qh->tt_buffer_dirty = 0;
 	}
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 695931b03684..01720f1f7d62 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -559,7 +559,7 @@ struct usb_tt_clear {
 	struct usb_host_endpoint	*ep;
 };
 
-extern int usb_hub_clear_tt_buffer(struct urb *urb);
+extern int usb_hub_clear_tt_buffer(struct urb *urb, int devnum);
 extern void usb_ep0_reinit(struct usb_device *);
 
 /* (shifted) direction/type/recipient from the USB 2.0 spec, table 9.2 */
-- 
2.1.4

