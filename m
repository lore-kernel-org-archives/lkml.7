Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904ADC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D6520675
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H6p2Yf+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfEPOlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:41:13 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14034 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfEPOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:41:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdd765a0000>; Thu, 16 May 2019 07:40:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 07:41:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 May 2019 07:41:07 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 14:41:07 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 14:41:07 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdd7681000e>; Thu, 16 May 2019 07:41:07 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v10 2/2] usb: xhci: Add Clear_TT_Buffer
Date:   Thu, 16 May 2019 22:40:57 +0800
Message-ID: <1558017657-13835-3-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1558017657-13835-1-git-send-email-jilin@nvidia.com>
References: <1558017657-13835-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558017626; bh=z5hhf5kO9VobCdLONudYfxj6heFAre6ayYrvT2/LBCI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=H6p2Yf+opYZd8EWSf24mV2G2IltzAyYxJuJktiSrtnA8X/GBlGuNur1hGihsLfuOr
         Z3NUEtEpIJRgpJj/aqRQHQeoBhBMc/bN4MgGU2iyKg5xA2sXmG7o0rsWrPqafc8qWI
         k7+n4sqyvLLyWjtNxMjeE0rHlydjeSjpF6AsOstuSu7F2NBr/wxXErpWd2o4Tqq3TD
         45nYxPiUibt46XV9SeJAISgMSwCyHDUbxj2Y8JwaDjmQT/Z6hsbZQ+ZfbiIz1ic4jt
         A+NayGSMt3iQ1Mv9Mm/Gh/GF2ou5PKUJsp8c77CD8e5IjywNIeKRrPDcTOAnFhxBDa
         r3mVwtVw277GA==
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

 drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c      | 17 +++++++++++++++++
 drivers/usb/host/xhci.h      |  5 +++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9215a28dad40..11d498b6c09b 100644
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
@@ -1786,6 +1793,23 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
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
@@ -1804,6 +1828,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 	if (reset_type == EP_HARD_RESET) {
 		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
+		xhci_clear_hub_tt_buffer(xhci, td, ep);
 	}
 	xhci_ring_cmd_db(xhci);
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 68b393e5a453..0dc108e61a89 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5133,6 +5133,22 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 }
 EXPORT_SYMBOL_GPL(xhci_gen_setup);
 
+static void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
+		struct usb_host_endpoint *ep)
+{
+	struct xhci_hcd *xhci;
+	struct usb_device *udev;
+	unsigned int slot_id;
+	unsigned int ep_index;
+
+	xhci = hcd_to_xhci(hcd);
+	udev = (struct usb_device *)ep->hcpriv;
+	slot_id = udev->slot_id;
+	ep_index = xhci_get_endpoint_index(&ep->desc);
+	xhci->devs[slot_id]->eps[ep_index].ep_state &= ~EP_CLEARING_TT;
+	xhci_ring_doorbell_for_active_rings(xhci, slot_id, ep_index);
+}
+
 static const struct hc_driver xhci_hc_driver = {
 	.description =		"xhci-hcd",
 	.product_desc =		"xHCI Host Controller",
@@ -5193,6 +5209,7 @@ static const struct hc_driver xhci_hc_driver = {
 	.enable_usb3_lpm_timeout =	xhci_enable_usb3_lpm_timeout,
 	.disable_usb3_lpm_timeout =	xhci_disable_usb3_lpm_timeout,
 	.find_raw_port_number =	xhci_find_raw_port_number,
+	.clear_tt_buffer_complete = xhci_clear_tt_buffer_complete,
 };
 
 void xhci_init_driver(struct hc_driver *drv,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 9334cdee382a..dbe7eb46c1d8 100644
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
@@ -2100,6 +2102,9 @@ void xhci_handle_command_timeout(struct work_struct *work);
 
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

