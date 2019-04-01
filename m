Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE069C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036C20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139735;
	bh=MwtwoPKpEjKk072iGT4cVRmiLWgJugAvYNJp+akxuC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m7RRaT++te1Fgdt2L8xp6xFOet0SSQGKiGFU/R2m0Ck4uvlp/tNrLp63roueQWLko
	 PLJAjPNNf2Ry+vggsFYM2pwpzakfJ+PViK3kKuaduEo1jqfwy868w1y0pZTM/XV+Bi
	 wttFAxc3U1i8jKAsw0AqoLUTglw0T1kxg5HzQwtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfDAR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbfDAR2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC09C20830;
        Mon,  1 Apr 2019 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139730;
        bh=MwtwoPKpEjKk072iGT4cVRmiLWgJugAvYNJp+akxuC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQWYCy0K03wkVEMX8UKZEylHqJ7qJPpORbTpbtfj3geibuv6yfxtEEHMTihbISsWA
         JbIcWje+ZKqtp8trenR10viTKdR2hIK/NW08NkT3oMUTEb7gDNAUdaWqQGJUpefe1l
         DB3rvpR+GubmlzFhOGHlm0Uf0i0p0ur7DON2YDNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 54/56] xhci: Fix port resume done detection for SS ports with LPM enabled
Date:   Mon,  1 Apr 2019 19:03:10 +0200
Message-Id: <20190401170106.832778548@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1645,10 +1645,13 @@ static void handle_port_status(struct xh
 		}
 	}
 
-	if ((temp & PORT_PLC) && (temp & PORT_PLS_MASK) == XDEV_U0 &&
-			DEV_SUPERSPEED_ANY(temp)) {
+	if ((temp & PORT_PLC) &&
+	    DEV_SUPERSPEED_ANY(temp) &&
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
@@ -311,6 +311,7 @@ struct xhci_op_regs {
  */
 #define PORT_PLS_MASK	(0xf << 5)
 #define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
 #define XDEV_U2		(0x2 << 5)
 #define XDEV_U3		(0x3 << 5)
 #define XDEV_INACTIVE	(0x6 << 5)


