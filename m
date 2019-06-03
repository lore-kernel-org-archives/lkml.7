Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B282C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16186280D3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JrK3jpS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfFCKx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:53:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8649 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfFCKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:53:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf4fc410000>; Mon, 03 Jun 2019 03:53:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Jun 2019 03:53:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Jun 2019 03:53:53 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Jun
 2019 10:53:53 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 3 Jun 2019 10:53:53 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cf4fc3f0000>; Mon, 03 Jun 2019 03:53:53 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v11 2/2] usb: xhci: Add Clear_TT_Buffer
Date:   Mon, 3 Jun 2019 18:53:44 +0800
Message-ID: <1559559224-9845-3-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559559233; bh=qJsqgG/wairsxZLuJhaLHWT5QFH0t31DOAuVLrlkZ6M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=JrK3jpS1RQD7Xv3/lgYb4EpZhJjSK8T0V2XsDAFJea1ZBrfAuI7rfKfcKzV/PQC86
         hM5wy/KufjMRWuI9jmQYmG22yIADWpL42yxhD0mkdcdsHmsYsEbbnKyOuW+j4RfNa4
         I5G8T+4geVWs5Mim4mZ7ng7jZgth93XT8/PYxjqwaS4mGdi/kWxPdJNDszQUEp8Rzb
         Cyu1ENPrL/bThT4HwPvdzV0O6YQArevMjhaSyb2K14X/Sk4pvDLzNwm1RbCptOXXFw
         6LHw0mNyJmZcrpVdTfnFRK634CPYp7ICqPWVHnjk3Qm7pZQXwJUV0AKJFqnygXsXvK
         WutEIYXySOopA==
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

Here we invoke usb_hub_clear_tt_buffer() to send Clear_TT_Buffer
request to the hub of the device for the following Set_Interface
requests to the device to get ACK successfully.

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
v8: split as two patches
v9: no change flag
v10: Add EP_CLEARING_TT flag
v11: Add spin_lock/unlock in xhci_clear_tt_buffer_complete


 drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c      | 21 +++++++++++++++++++++
 drivers/usb/host/xhci.h      |  5 +++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index feffceb31e8a..a52fd96e70e9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -399,7 +399,7 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
 	 * stream once the endpoint is on the HW schedule.
 	 */
 	if ((ep_state & EP_STOP_CMD_PENDING) || (ep_state & SET_DEQ_PENDING) ||
-	    (ep_state & EP_HALTED))
+	    (ep_state & EP_HALTED) || (ep_state & EP_CLEARING_TT))
 		return;
 	writel(DB_VALUE(ep_index, stream_id), db_addr);
 	/* The CPU has better things to do at this point than wait for a
@@ -433,6 +433,13 @@ static void ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 	}
 }
 
+void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
+		unsigned int slot_id,
+		unsigned int ep_index)
+{
+	ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+}
+
 /* Get the right ring for the given slot_id, ep_index and stream_id.
  * If the endpoint supports streams, boundary check the URB's stream ID.
  * If the endpoint doesn't support streams, return the singular endpoint ring.
@@ -1794,6 +1801,23 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 	return NULL;
 }
 
+static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci, struct xhci_td *td,
+		struct xhci_virt_ep *ep)
+{
+	/*
+	 * As part of low/full-speed endpoint-halt processing
+	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
+	 */
+	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
+	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub) &&
+	    !(ep->ep_state & EP_CLEARING_TT)) {
+		ep->ep_state |= EP_CLEARING_TT;
+		td->urb->ep->hcpriv = td->urb->dev;
+		if (usb_hub_clear_tt_buffer(td->urb))
+			ep->ep_state &= ~EP_CLEARING_TT;
+	}
+}
+
 static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 		unsigned int slot_id, unsigned int ep_index,
 		unsigned int stream_id, struct xhci_td *td,
@@ -1812,6 +1836,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 	if (reset_type == EP_HARD_RESET) {
 		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
+		xhci_clear_hub_tt_buffer(xhci, td, ep);
 	}
 	xhci_ring_cmd_db(xhci);
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 4f92643e3a4c..ef5702a45067 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5163,6 +5163,26 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 }
 EXPORT_SYMBOL_GPL(xhci_gen_setup);
 
+static void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
+		struct usb_host_endpoint *ep)
+{
+	struct xhci_hcd *xhci;
+	struct usb_device *udev;
+	unsigned int slot_id;
+	unsigned int ep_index;
+	unsigned long flags;
+
+	xhci = hcd_to_xhci(hcd);
+	udev = (struct usb_device *)ep->hcpriv;
+	slot_id = udev->slot_id;
+	ep_index = xhci_get_endpoint_index(&ep->desc);
+
+	spin_lock_irqsave(&xhci->lock, flags);
+	xhci->devs[slot_id]->eps[ep_index].ep_state &= ~EP_CLEARING_TT;
+	xhci_ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+}
+
 static const struct hc_driver xhci_hc_driver = {
 	.description =		"xhci-hcd",
 	.product_desc =		"xHCI Host Controller",
@@ -5224,6 +5244,7 @@ static const struct hc_driver xhci_hc_driver = {
 	.enable_usb3_lpm_timeout =	xhci_enable_usb3_lpm_timeout,
 	.disable_usb3_lpm_timeout =	xhci_disable_usb3_lpm_timeout,
 	.find_raw_port_number =	xhci_find_raw_port_number,
+	.clear_tt_buffer_complete = xhci_clear_tt_buffer_complete,
 };
 
 void xhci_init_driver(struct hc_driver *drv,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7f8b950d1a73..34789f4db555 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -936,6 +936,8 @@ struct xhci_virt_ep {
 #define EP_GETTING_NO_STREAMS	(1 << 5)
 #define EP_HARD_CLEAR_TOGGLE	(1 << 6)
 #define EP_SOFT_CLEAR_TOGGLE	(1 << 7)
+/* usb_hub_clear_tt_buffer is in progress */
+#define EP_CLEARING_TT		(1 << 8)
 	/* ----  Related to URB cancellation ---- */
 	struct list_head	cancelled_td_list;
 	/* Watchdog timer for stop endpoint command to cancel URBs */
@@ -2102,6 +2104,9 @@ void xhci_handle_command_timeout(struct work_struct *work);
 
 void xhci_ring_ep_doorbell(struct xhci_hcd *xhci, unsigned int slot_id,
 		unsigned int ep_index, unsigned int stream_id);
+void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
+		unsigned int slot_id,
+		unsigned int ep_index);
 void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
-- 
2.1.4

