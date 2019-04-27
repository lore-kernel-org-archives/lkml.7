Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6471C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF2A214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfD0PUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:20:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34028 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbfD0PPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:35 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP35-0000zA-MF; Sat, 27 Apr 2019 16:15:31 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004U8-Pm; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Bin Liu" <b-liu@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paul Elder" <paul.elder@ideasonboard.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.397543377@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 078/202] usb: gadget: musb: fix short isoc packets
 with inventra dma
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Elder <paul.elder@ideasonboard.com>

commit c418fd6c01fbc5516a2cd1eaf1df1ec86869028a upstream.

Handling short packets (length < max packet size) in the Inventra DMA
engine in the MUSB driver causes the MUSB DMA controller to hang. An
example of a problem that is caused by this problem is when streaming
video out of a UVC gadget, only the first video frame is transferred.

For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
set manually by the driver. This was previously done in musb_g_tx
(musb_gadget.c), but incorrectly (all csr flags were cleared, and only
MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY were set). Fixing that problem
allows some requests to be transferred correctly, but multiple requests
were often put together in one USB packet, and caused problems if the
packet size was not a multiple of 4. Instead, set MUSB_TXCSR_TXPKTRDY
in dma_controller_irq (musbhsdma.c), just like host mode transfers.

This topic was originally tackled by Nicolas Boichat [0] [1] and is
discussed further at [2] as part of his GSoC project [3].

[0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
[1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
[2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
[3] http://elinux.org/BeagleBoard/GSoC/USBSniffer

Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Fold in the earlier commit fb91cddc54e7 "usb: musb: Remove DMA ifdef
   for musb_gadget.c short_packet"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/musb/musb_gadget.c | 13 +------------
 drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 22 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -488,10 +488,8 @@ void musb_g_tx(struct musb *musb, u8 epn
 	}
 
 	if (request) {
-		u8	is_dma = 0;
 
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
-			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
 			csr &= ~(MUSB_TXCSR_DMAENAB | MUSB_TXCSR_P_UNDERRUN |
 				 MUSB_TXCSR_TXPKTRDY | MUSB_TXCSR_AUTOSET);
@@ -507,15 +505,10 @@ void musb_g_tx(struct musb *musb, u8 epn
 		 * First, maybe a terminating short packet. Some DMA
 		 * engines might handle this by themselves.
 		 */
-		if ((request->zero && request->length
+		if ((request->zero && request->length)
 			&& (request->length % musb_ep->packet_sz == 0)
-			&& (request->actual == request->length))
-#if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_UX500_DMA)
-			|| (is_dma && (!dma->desired_mode ||
-				(request->actual &
-					(musb_ep->packet_sz - 1))))
-#endif
-		) {
+			&& (request->actual == request->length)) {
+
 			/*
 			 * On DMA completion, FIFO may not be
 			 * available yet...
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -319,12 +319,10 @@ static irqreturn_t dma_controller_irq(in
 				channel->status = MUSB_DMA_STATUS_FREE;
 
 				/* completed */
-				if ((devctl & MUSB_DEVCTL_HM)
-					&& (musb_channel->transmit)
-					&& ((channel->desired_mode == 0)
-					    || (channel->actual_len &
-					    (musb_channel->max_packet_sz - 1)))
-				    ) {
+				if (musb_channel->transmit &&
+					(!channel->desired_mode ||
+					(channel->actual_len %
+					    musb_channel->max_packet_sz))) {
 					u8  epnum  = musb_channel->epnum;
 					int offset = MUSB_EP_OFFSET(epnum,
 								    MUSB_TXCSR);
@@ -336,11 +334,14 @@ static irqreturn_t dma_controller_irq(in
 					 */
 					musb_ep_select(mbase, epnum);
 					txcsr = musb_readw(mbase, offset);
-					txcsr &= ~(MUSB_TXCSR_DMAENAB
+					if (channel->desired_mode == 1) {
+						txcsr &= ~(MUSB_TXCSR_DMAENAB
 							| MUSB_TXCSR_AUTOSET);
-					musb_writew(mbase, offset, txcsr);
-					/* Send out the packet */
-					txcsr &= ~MUSB_TXCSR_DMAMODE;
+						musb_writew(mbase, offset, txcsr);
+						/* Send out the packet */
+						txcsr &= ~MUSB_TXCSR_DMAMODE;
+						txcsr |= MUSB_TXCSR_DMAENAB;
+					}
 					txcsr |=  MUSB_TXCSR_TXPKTRDY;
 					musb_writew(mbase, offset, txcsr);
 				}

