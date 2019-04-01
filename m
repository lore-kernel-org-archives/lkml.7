Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2614C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155820830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140363;
	bh=E5d57PCYI9pnt1WSNaN4EApnKc6tQcG17EIlRdlWeUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GZ3p550YofLym5R9+/n5v1AQLzRB7n7/VqdTGKPxtdFWkVR4LNmV6rj8ti5dbdi1s
	 BTqgTzdo/XIvgMtSzpWQSVEQ4APr+pmIgJmPCeJffJOvM21l8bvpAmJN9DDUdiHST/
	 J4/8auXTGH13fqWc9tlsz0QpMSkeSJKRlyTbRQPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbfDARjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbfDARjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A10208E4;
        Mon,  1 Apr 2019 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140358;
        bh=E5d57PCYI9pnt1WSNaN4EApnKc6tQcG17EIlRdlWeUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+nl6LuVcY2tJcwoc+p5ECaBUvDGRah5LuW2Y5PVNBL5raAMaJsZbjOcnV2Av5Q6F
         zr9KIm9L874apNb/CmSYzMjUInrc8gmPtnaTl2M1TAJq/IAn8wIA9tHcZm9g9lXmXQ
         d/G0pJsXDIewL+X9ilx36+nL+gIURJlTHCNQq2VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3.18 48/50] xhci: Fix port resume done detection for SS ports with LPM enabled
Date:   Mon,  1 Apr 2019 19:03:31 +0200
Message-Id: <20190401170046.523169240@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 6cbcf596934c8e16d6288c7cc62dfb7ad8eadf15 upstream.

A suspended SS port in U3 link state will go to U0 when resumed, but
can almost immediately after that enter U1 or U2 link power save
states before host controller driver reads the port status.

Host controller driver only checks for U0 state, and might miss
the finished resume, leaving flags unclear and skip notifying usb
code of the wake.

Add U1 and U2 to the possible link states when checking for finished
port resume.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/usb/host/xhci-ring.c |    9 ++++++---
 drivers/usb/host/xhci.h      |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1599,10 +1599,13 @@ static void handle_port_status(struct xh
 		}
 	}
 
-	if ((temp & PORT_PLC) && (temp & PORT_PLS_MASK) == XDEV_U0 &&
-			DEV_SUPERSPEED(temp)) {
+	if ((temp & PORT_PLC) &&
+	    DEV_SUPERSPEED(temp) &&
+	    ((temp & PORT_PLS_MASK) == XDEV_U0 ||
+	     (temp & PORT_PLS_MASK) == XDEV_U1 ||
+	     (temp & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
-		/* We've just brought the device into U0 through either the
+		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
 		 * initiated remote wake, don't pass up the link state change,
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -283,6 +283,7 @@ struct xhci_op_regs {
  */
 #define PORT_PLS_MASK	(0xf << 5)
 #define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
 #define XDEV_U2		(0x2 << 5)
 #define XDEV_U3		(0x3 << 5)
 #define XDEV_RESUME	(0xf << 5)


