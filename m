Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FDC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF32206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138634;
	bh=ifDhmr4F2QpI8jNQ5Ec5asi3sryv9vlE3qrPevfjtBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dDKtaIYMJJ1IWLEFAVhNixDsV+IidsktV3Ozhwak3Y6W2hPW75BuHeVSU4MtM3UoP
	 1MfVyu4efXgAYt4Szw7hqNNfCNxszx0DVD+8VZonOC20et2vqsai4G80Wv7KAxvjdO
	 DjnG86kEIbuJqb+Bz83vE1jXNXAAQOlYz0xXiuHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfDARKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbfDARKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC43206B8;
        Mon,  1 Apr 2019 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138629;
        bh=ifDhmr4F2QpI8jNQ5Ec5asi3sryv9vlE3qrPevfjtBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyTpMMkdv/V/cNB0ok9KN86zUvGa/Z12DI5f+aYEB6ITVZuPuGXsnZ3pPwJFGWXcV
         LS8JeDRWFfdroG5up+Epa1wjAENtMo4H+XMU1UG07kpPhyAwaDvllb2cZkdYd4oWn8
         kU2KUmk24IrCAAYbTiJTXLsQXMOVw8LEdAf9Ru7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.0 121/146] xhci: Dont let USB3 ports stuck in polling state prevent suspend
Date:   Mon,  1 Apr 2019 19:02:13 +0200
Message-Id: <20190401170058.586845083@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit d92f2c59cc2cbca6bfb2cc54882b58ba76b15fd4 upstream.

Commit 2f31a67f01a8 ("usb: xhci: Prevent bus suspend if a port connect
change or polling state is detected") was intended to prevent ports that
were still link training from being forced to U3 suspend state mid
enumeration.
This solved enumeration issues for devices with slow link training.

Turns out some devices are stuck in the link training/polling state,
and thus that patch will prevent suspend completely for these devices.
This is seen with USB3 card readers in some MacBooks.

Instead of preventing suspend, give some time to complete the link
training. On successful training the port will end up as connected
and enabled.
If port instead is stuck in link training the bus suspend will continue
suspending after 360ms (10 * 36ms) timeout (tPollingLFPSTimeout).

Original patch was sent to stable, this one should go there as well

Fixes: 2f31a67f01a8 ("usb: xhci: Prevent bus suspend if a port connect change or polling state is detected")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |   19 ++++++++++++-------
 drivers/usb/host/xhci.h     |    8 ++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1545,20 +1545,25 @@ int xhci_bus_suspend(struct usb_hcd *hcd
 	port_index = max_ports;
 	while (port_index--) {
 		u32 t1, t2;
-
+		int retries = 10;
+retry:
 		t1 = readl(ports[port_index]->addr);
 		t2 = xhci_port_state_to_neutral(t1);
 		portsc_buf[port_index] = 0;
 
-		/* Bail out if a USB3 port has a new device in link training */
-		if ((hcd->speed >= HCD_USB3) &&
+		/*
+		 * Give a USB3 port in link training time to finish, but don't
+		 * prevent suspend as port might be stuck
+		 */
+		if ((hcd->speed >= HCD_USB3) && retries-- &&
 		    (t1 & PORT_PLS_MASK) == XDEV_POLLING) {
-			bus_state->bus_suspended = 0;
 			spin_unlock_irqrestore(&xhci->lock, flags);
-			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");
-			return -EBUSY;
+			msleep(XHCI_PORT_POLLING_LFPS_TIME);
+			spin_lock_irqsave(&xhci->lock, flags);
+			xhci_dbg(xhci, "port %d polling in bus suspend, waiting\n",
+				 port_index);
+			goto retry;
 		}
-
 		/* suspend ports in U0, or bail out for new connect changes */
 		if ((t1 & PORT_PE) && (t1 & PORT_PLS_MASK) == XDEV_U0) {
 			if ((t1 & PORT_CSC) && wake_enabled) {
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -452,6 +452,14 @@ struct xhci_op_regs {
  */
 #define XHCI_DEFAULT_BESL	4
 
+/*
+ * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
+ * to complete link training. usually link trainig completes much faster
+ * so check status 10 times with 36ms sleep in places we need to wait for
+ * polling to complete.
+ */
+#define XHCI_PORT_POLLING_LFPS_TIME  36
+
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable


