Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2828216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lTC241SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEJJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:02:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14057 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfEJJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:02:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd53dfe0000>; Fri, 10 May 2019 02:01:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 May 2019 02:02:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 May 2019 02:02:27 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 09:02:27 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 09:02:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 May 2019 09:02:26 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd53e210000>; Fri, 10 May 2019 02:02:26 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v8 2/2] usb: xhci: Add Clear_TT_Buffer support
Date:   Fri, 10 May 2019 17:02:17 +0800
Message-ID: <1557478937-30486-3-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1557478937-30486-1-git-send-email-jilin@nvidia.com>
References: <1557478937-30486-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557478910; bh=6KvCGIA3DsfNZQ5OldjPXEU/o9P9J+I/XJEfrIShoHI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=lTC241SCoyjpWbO90T1k2+KAPbF/zTO5V9fw1JFBHXGIhTkXzPLwhclHyyHfxDqxe
         bnYPZbIw52ZlPuTWx6u060aysfhui4AFMR193iSGrKEZ3fdubnrsMQDSknt1ZwUOXl
         aveHSxcn6uk6m5QDUzSY1tA/ap+zQkVPy4kXrevoiapamcChLuRZa65cxTI8JTGV4Y
         rRamyLz/5RODB1Djy2N1rdpmqRN+Zg/wI85YN5jbqlZIY3hN0UYvZQn68D76AuR8Yb
         Etdcl/JYKfpy6pD3kUNTVBbS+G8pUyCuRrwmiv+FhL/PMfxXayG4n3KkJ+GATNf6/u
         ffmEYZepW7mjQ==
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

Here we update udev->devaddr in address_device callback function
(this USB device address is assigned by XHCI controller) and invoke
usb_hub_clear_tt_buffer() to send Clear_TT_Buffer request to the hub
of the device for the following Set_Interface requests to the device
to get ACK successfully.

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

 drivers/usb/host/xhci-ring.c | 12 ++++++++++++
 drivers/usb/host/xhci.c      |  1 +
 2 files changed, 13 insertions(+)

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
index 7fa58c99f126..68b393e5a453 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4096,6 +4096,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	/* Zero the input context control for later use */
 	ctrl_ctx->add_flags = 0;
 	ctrl_ctx->drop_flags = 0;
+	udev->devaddr = (u8)(le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_address,
 		       "Internal device address = %d",
-- 
2.1.4

