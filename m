Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CC12087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rMN1ETWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfD2Kgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:36:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19999 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfD2Kgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:36:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc6d3a50000>; Mon, 29 Apr 2019 03:36:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 03:36:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 29 Apr 2019 03:36:50 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 10:36:50 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 10:36:49 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 29 Apr 2019 10:36:49 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc6d3c00002>; Mon, 29 Apr 2019 03:36:49 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH 1/1] usb: xhci: Add Clear_TT_Buffer
Date:   Mon, 29 Apr 2019 18:36:44 +0800
Message-ID: <1556534204-17826-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556534181; bh=oG+UgkoI1H0HnoK6iSsX7MbtgMNDVfxYFAgBXvtrQ8Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=rMN1ETWkrhZUe1qSggTobFAUHM/22ojPtroEiOoUIPyZ5z+F00ig6MYW26PYzdG0b
         gGjGB/1qPN92OsxM8ipfD3xbeLRdxnltKDUct0znqITiwaF82KJo1jZF66mL9HNUoM
         DP9Gglu6NglqBxTm9iAarPXTAQO8xsDR2DGSY+B8JKZ4ONpRt6OGx3DLJKMiUq88HL
         I7NMzUUsNOKJMeS6fedL10s5bUvz86IESlWXrx/LTPPC4crMOEgZTUW1RYtvS4yw1Q
         E2eaxh/41RNDZLZY49upO38G9bsvOM77gsHEugAOT1j09OOUt/9wIr6Hr2gKS2AIF2
         QCPHG5jBA4mIA==
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

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/host/xhci-ring.c | 28 ++++++++++++++++++++++++++++
 drivers/usb/host/xhci.c      |  7 +++++++
 drivers/usb/host/xhci.h      |  3 +++
 3 files changed, 38 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9215a28dad40..02b1ebad81e7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1786,6 +1786,33 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
 	return NULL;
 }
 
+static void xhci_clear_hub_tt_buffer(struct xhci_hcd *xhci,
+	unsigned int slot_id, struct xhci_td *td)
+{
+	struct xhci_virt_device *dev;
+	struct xhci_slot_ctx *slot_ctx;
+	int saved_devnum;
+
+	/*
+	 * As part of low/full-speed endpoint-halt processing
+	 * we must clear the TT buffer (USB 2.0 specification 11.17.5).
+	 */
+	if (td->urb->dev->tt && !usb_pipeint(td->urb->pipe) &&
+	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub) &&
+	    !xhci->clearing_tt) {
+		xhci->clearing_tt = 1;
+		dev = xhci->devs[slot_id];
+		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
+		/* Update devnum temporarily for usb_hub_clear_tt_buffer */
+		saved_devnum = td->urb->dev->devnum;
+		td->urb->dev->devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
+			DEV_ADDR_MASK;
+		if (usb_hub_clear_tt_buffer(td->urb))
+			xhci->clearing_tt = 0;
+		td->urb->dev->devnum = saved_devnum;
+	}
+}
+
 static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 		unsigned int slot_id, unsigned int ep_index,
 		unsigned int stream_id, struct xhci_td *td,
@@ -1804,6 +1831,7 @@ static void xhci_cleanup_halted_endpoint(struct xhci_hcd *xhci,
 	if (reset_type == EP_HARD_RESET) {
 		ep->ep_state |= EP_HARD_CLEAR_TOGGLE;
 		xhci_cleanup_stalled_ring(xhci, ep_index, stream_id, td);
+		xhci_clear_hub_tt_buffer(xhci, slot_id, td);
 	}
 	xhci_ring_cmd_db(xhci);
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7fa58c99f126..cb8c1048d4d3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5132,6 +5132,12 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 }
 EXPORT_SYMBOL_GPL(xhci_gen_setup);
 
+void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
+						struct usb_host_endpoint *ep)
+{
+	hcd_to_xhci(hcd)->clearing_tt = 0;
+}
+
 static const struct hc_driver xhci_hc_driver = {
 	.description =		"xhci-hcd",
 	.product_desc =		"xHCI Host Controller",
@@ -5192,6 +5198,7 @@ static const struct hc_driver xhci_hc_driver = {
 	.enable_usb3_lpm_timeout =	xhci_enable_usb3_lpm_timeout,
 	.disable_usb3_lpm_timeout =	xhci_disable_usb3_lpm_timeout,
 	.find_raw_port_number =	xhci_find_raw_port_number,
+	.clear_tt_buffer_complete = xhci_clear_tt_buffer_complete,
 };
 
 void xhci_init_driver(struct hc_driver *drv,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 9334cdee382a..f786bb0992c4 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1864,6 +1864,7 @@ struct xhci_hcd {
 	unsigned		hw_lpm_support:1;
 	/* Broken Suspend flag for SNPS Suspend resume issue */
 	unsigned		broken_suspend:1;
+	unsigned		clearing_tt:1;
 	/* cached usb2 extened protocol capabilites */
 	u32                     *ext_caps;
 	unsigned int            num_ext_caps;
@@ -2052,6 +2053,8 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		struct usb_device *hdev,
 		struct usb_tt *tt, gfp_t mem_flags);
+void xhci_clear_tt_buffer_complete(struct usb_hcd *hcd,
+		struct usb_host_endpoint *ep);
 
 /* xHCI ring, segment, TRB, and TD functions */
 dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg, union xhci_trb *trb);
-- 
2.1.4

