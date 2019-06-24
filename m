Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83DBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D801205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371246;
	bh=thTpi9PNfAcGCFlW1lMEAJawxqzpp0uS7r3uAR2VxWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAx69L90fTKc87pdBf8n/4Md0jyEOybZP8vq7g2IEBPb3W8+cSF5oDkwwLFWxfUba
	 yogPjFrYrXJu0IJTb1AOdM8iVRSfoSm5m5LoElCAyBemwlrpQg4tQn47d9Gbf8Lxv8
	 JfTrDj2Md80QrUqu9HRh6pMzbQqPLacg/dXUJiPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfFXKCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbfFXKCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:02:36 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24416213F2;
        Mon, 24 Jun 2019 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370555;
        bh=thTpi9PNfAcGCFlW1lMEAJawxqzpp0uS7r3uAR2VxWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICRkzlBcmFm5LT9bXdzgZlDGcFRCwWBJrDoBgj+cSA48sUkvDoz8gDRVaZzZp8Bsm
         Q4ViBGjVrlA275C3wC34SZyN6ttEJ8qgptST2M/7iCWTh5acCjZXVCnaBT7vU/C6it
         ArXnMs2HQtGs3gOZU2k6TB3/VHcoRppHQcBJGNH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 18/90] xhci: detect USB 3.2 capable host controllers correctly
Date:   Mon, 24 Jun 2019 17:56:08 +0800
Message-Id: <20190624092315.210468511@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit ddd57980a0fde30f7b5d14b888a2cc84d01610e8 upstream.

USB 3.2 capability in a host can be detected from the
xHCI Supported Protocol Capability major and minor revision fields.

If major is 0x3 and minor 0x20 then the host is USB 3.2 capable.

For USB 3.2 capable hosts set the root hub lane count to 2.

The Major Revision and Minor Revision fields contain a BCD version number.
The value of the Major Revision field is JJh and the value of the Minor
Revision field is MNh for version JJ.M.N, where JJ = major revision number,
M - minor version number, N = sub-minor version number,
e.g. version 3.1 is represented with a value of 0310h.

Also fix the extra whitespace printed out when announcing regular
SuperSpeed hosts.

Cc: <stable@vger.kernel.org> # v4.18+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5030,16 +5030,26 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 	} else {
 		/*
 		 * Some 3.1 hosts return sbrn 0x30, use xhci supported protocol
-		 * minor revision instead of sbrn
+		 * minor revision instead of sbrn. Minor revision is a two digit
+		 * BCD containing minor and sub-minor numbers, only show minor.
 		 */
-		minor_rev = xhci->usb3_rhub.min_rev;
-		if (minor_rev) {
+		minor_rev = xhci->usb3_rhub.min_rev / 0x10;
+
+		switch (minor_rev) {
+		case 2:
+			hcd->speed = HCD_USB32;
+			hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
+			hcd->self.root_hub->rx_lanes = 2;
+			hcd->self.root_hub->tx_lanes = 2;
+			break;
+		case 1:
 			hcd->speed = HCD_USB31;
 			hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
+			break;
 		}
-		xhci_info(xhci, "Host supports USB 3.%x %s SuperSpeed\n",
+		xhci_info(xhci, "Host supports USB 3.%x %sSuperSpeed\n",
 			  minor_rev,
-			  minor_rev ? "Enhanced" : "");
+			  minor_rev ? "Enhanced " : "");
 
 		xhci->usb3_rhub.hcd = hcd;
 		/* xHCI private pointer was set in xhci_pci_probe for the second


