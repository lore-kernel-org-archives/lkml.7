Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EDE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jyx6t8Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDZOvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:51:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11865 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:51:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31ad50000>; Fri, 26 Apr 2019 07:51:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:51:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:51:04 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:51:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:51:04 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31ad70001>; Fri, 26 Apr 2019 07:51:04 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 6/6] usb: xhci: Add Clear_TT_Buffer
Date:   Fri, 26 Apr 2019 22:50:59 +0800
Message-ID: <1556290259-9610-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290261; bh=jsiYAGCIqxOvLaM8hSo4kuYHJAnxya8TxXxvrDmjo4A=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=jyx6t8RzYy351aWb8ZUkefzpU/FA0Vt+fKAUgIrrPfiRpWkQpptOvG6W6x15VPLNE
         sexUwXX9LUdVEsnt1nnKotOJGJ0vq8pFs5QpHMf/73DnKQY5VULtrv00ezn24HleJ8
         JSp4ZK1h3jtLMa3BH1xOkKSRemd3lB6Gcq5bhRYk7DXimfiAfi8RZAH5zgTclWJu28
         HRtMgETGKELhG7AovRd9NM/yNasp0GxaKY+XP0ng4WaJWfotP100CyLdExe82Mg0at
         vxL8I7QBsCgzQcxPovKlqk7UkQPQVlxVQkY8sntgOv4U4pnExgh36/BCB+wxXxMF3m
         HGnDHBBMOH50g==
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

After adding this fix the following Set_Interface requests will be
able to get ACK successfully.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/host/xhci-ring.c | 25 +++++++++++++++++++++++++
 drivers/usb/host/xhci.c      |  7 +++++++
 drivers/usb/host/xhci.h      |  3 +++
 3 files changed, 35 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9215a28dad40..ecf40db562ee 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1786,6 +1786,30 @@ struct xhci_segment *trb_in_td(struct xhci_hcd *xhci,
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
+	    (td->urb->dev->tt->hub != xhci_to_hcd(xhci)->self.root_hub) &&
+	    !xhci->clearing_tt) {
+		xhci->clearing_tt = 1;
+		dev = xhci->devs[slot_id];
+		slot_ctx = xhci_get_slot_ctx(xhci, dev->out_ctx);
+		devnum = (int) le32_to_cpu(slot_ctx->dev_state) &
+			DEV_ADDR_MASK;
+		if (usb_hub_clear_tt_buffer(td->urb, devnum))
+			xhci->clearing_tt = 0;
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

