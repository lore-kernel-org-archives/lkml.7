Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E9C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9C20726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519414;
	bh=c3EVOE7rBoG49p5s/13gTeHrW0LebXBiVSmLQdyu9qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2eGsvNQLWjs1W5frRuC7dpI22q5zAUsM4LbrMYObMztiYs4ZxT5G1q+rQEav/eJi1
	 WG44FXkVSFhAsV0DcSnk3e41b5o2r7pmq+hbGOeo0GSx6d+efC4Ia7ceo38LzRY4yg
	 4jz7ih5Xo3x6OlKrcBEu/1/AQF9PSUab2iPd+4G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfLPSDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbfLPSDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:03:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 932C820726;
        Mon, 16 Dec 2019 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519402;
        bh=c3EVOE7rBoG49p5s/13gTeHrW0LebXBiVSmLQdyu9qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgBfq6+6VnJScu/N3p4/444rkJgR886s4EGuwx528U29zJC3ygbY/f/ga4ebjyqfu
         fVeswf9p9oEjzAXmDfrIc6CgA0ln5yKK3GnYMF0sVDI8EgLJfVmqCC0qObnyz71Z2W
         lCfa0RJUgPLoKknLbU7VTUj2TllXiRuS+a68tF+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 014/140] usb: xhci: only set D3hot for pci device
Date:   Mon, 16 Dec 2019 18:48:02 +0100
Message-Id: <20191216174754.411011978@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

commit f2c710f7dca8457e88b4ac9de2060f011254f9dd upstream.

Xhci driver cannot call pci_set_power_state() on non-pci xhci host
controllers. For example, NVIDIA Tegra XHCI host controller which acts
as platform device with XHCI_SPURIOUS_WAKEUP quirk set in some platform
hits this issue during shutdown.

Cc: <stable@vger.kernel.org>
Fixes: 638298dc66ea ("xhci: Fix spurious wakeups after S5 on Haswell")
Signed-off-by: Henry Lin <henryl@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20191211142007.8847-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |   13 +++++++++++++
 drivers/usb/host/xhci.c     |    7 ++-----
 drivers/usb/host/xhci.h     |    1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -495,6 +495,18 @@ static int xhci_pci_resume(struct usb_hc
 }
 #endif /* CONFIG_PM */
 
+static void xhci_pci_shutdown(struct usb_hcd *hcd)
+{
+	struct xhci_hcd		*xhci = hcd_to_xhci(hcd);
+	struct pci_dev		*pdev = to_pci_dev(hcd->self.controller);
+
+	xhci_shutdown(hcd);
+
+	/* Yet another workaround for spurious wakeups at shutdown with HSW */
+	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /* PCI driver selection metadata; PCI hotplugging uses this */
@@ -530,6 +542,7 @@ static int __init xhci_pci_init(void)
 #ifdef CONFIG_PM
 	xhci_pci_hc_driver.pci_suspend = xhci_pci_suspend;
 	xhci_pci_hc_driver.pci_resume = xhci_pci_resume;
+	xhci_pci_hc_driver.shutdown = xhci_pci_shutdown;
 #endif
 	return pci_register_driver(&xhci_pci_driver);
 }
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -769,7 +769,7 @@ static void xhci_stop(struct usb_hcd *hc
  *
  * This will only ever be called with the main usb_hcd (the USB3 roothub).
  */
-static void xhci_shutdown(struct usb_hcd *hcd)
+void xhci_shutdown(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 
@@ -788,11 +788,8 @@ static void xhci_shutdown(struct usb_hcd
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"xhci_shutdown completed - status = %x",
 			readl(&xhci->op_regs->status));
-
-	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
 }
+EXPORT_SYMBOL_GPL(xhci_shutdown);
 
 #ifdef CONFIG_PM
 static void xhci_save_registers(struct xhci_hcd *xhci)
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2052,6 +2052,7 @@ int xhci_start(struct xhci_hcd *xhci);
 int xhci_reset(struct xhci_hcd *xhci);
 int xhci_run(struct usb_hcd *hcd);
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
+void xhci_shutdown(struct usb_hcd *hcd);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);


