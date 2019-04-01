Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21038C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCD0206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138626;
	bh=hZEF/XpQxB8c103hka6bCROhwDi4CdbJXnz98wFuARE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gsP6gTsqs744DmTPkNDhNCgbWMVsq4PVogBsnmTGl6HzEE4INO/Pz9MN/vPOYTzrP
	 MIVkij/a+ysUa4MvihHYzWuJKv8bIi6cV/Xv2Kl/Ctl1kmVEBiSMCwsLcc4fFfSc1i
	 74e+AcBxsujJE7n79H8Nexbh62F0RV7UZh7y2eaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfDARKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbfDARKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EB021934;
        Mon,  1 Apr 2019 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138623;
        bh=hZEF/XpQxB8c103hka6bCROhwDi4CdbJXnz98wFuARE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGMyHKDQwVVDwDerj9/S38XoFGKi0gY3AjfC3L94LnKiVnVyXYIY4Y3/B+xVEmOen
         Vet9kjCuXWcafETRq/TaXBRBVYIfDXTArBjn0KD07V7iqjH/89VHCqMIeRtsvCz4Qm
         YnJng12xXmwb9GhfjmlRUsmGtuXaYWEHh9z0UOTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.0 119/146] xhci: Fix port resume done detection for SS ports with LPM enabled
Date:   Mon,  1 Apr 2019 19:02:11 +0200
Message-Id: <20190401170058.423961572@linuxfoundation.org>
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
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1647,10 +1647,13 @@ static void handle_port_status(struct xh
 		}
 	}
 
-	if ((portsc & PORT_PLC) && (portsc & PORT_PLS_MASK) == XDEV_U0 &&
-			DEV_SUPERSPEED_ANY(portsc)) {
+	if ((portsc & PORT_PLC) &&
+	    DEV_SUPERSPEED_ANY(portsc) &&
+	    ((portsc & PORT_PLS_MASK) == XDEV_U0 ||
+	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
+	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
 		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
-		/* We've just brought the device into U0 through either the
+		/* We've just brought the device into U0/1/2 through either the
 		 * Resume state after a device remote wakeup, or through the
 		 * U3Exit state after a host-initiated resume.  If it's a device
 		 * initiated remote wake, don't pass up the link state change,


