Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A8A208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfD0P1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:27:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbfD0PPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2s-000144-T6; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004es-6g; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Arend van Spriel" <arend@broadcom.com>,
        "Pieter-Paul Giesberts" <pieter-paul.giesberts@broadcom.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Franky Lin" <franky.lin@broadcom.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.452302109@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 195/202] brcmfmac: screening firmware event packet
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

From: Franky Lin <franky.lin@broadcom.com>

commit c56caa9db8abbbfb9e31325e0897705aa897db37 upstream.

Firmware uses asynchronized events as a communication method to the
host. The event packets are marked as ETH_P_LINK_CTL protocol type. For
SDIO and PCIe bus, this kind of packets are delivered through virtual
event channel not data channel. This patch adds a screening logic to
make sure the event handler only processes the events coming from the
correct channel.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Signed-off-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16:
 - Drop changes to PCIe bus support
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_bus.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_bus.h
@@ -168,7 +168,9 @@ bool brcmf_c_prec_enq(struct device *dev
 		      int prec);
 
 /* Receive frame for delivery to OS.  Callee disposes of rxp. */
-void brcmf_rx_frame(struct device *dev, struct sk_buff *rxp);
+void brcmf_rx_frame(struct device *dev, struct sk_buff *rxp, bool handle_evnt);
+/* Receive async event packet from firmware. Callee disposes of rxp. */
+void brcmf_rx_event(struct device *dev, struct sk_buff *rxp);
 
 /* Indication from bus module regarding presence/insertion of dongle. */
 int brcmf_attach(struct device *dev);
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
@@ -306,16 +306,17 @@ void brcmf_txflowblock(struct device *de
 	brcmf_fws_bus_blocked(drvr, state);
 }
 
-static void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb)
+static void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb,
+			    bool handle_event)
 {
-	skb->dev = ifp->ndev;
-	skb->protocol = eth_type_trans(skb, skb->dev);
+	skb->protocol = eth_type_trans(skb, ifp->ndev);
 
 	if (skb->pkt_type == PACKET_MULTICAST)
 		ifp->stats.multicast++;
 
 	/* Process special event packets */
-	brcmf_fweh_process_skb(ifp->drvr, skb);
+	if (handle_event)
+		brcmf_fweh_process_skb(ifp->drvr, skb);
 
 	if (!(ifp->ndev->flags & IFF_UP)) {
 		brcmu_pkt_buf_free_skb(skb);
@@ -376,7 +377,7 @@ static void brcmf_rxreorder_process_info
 	/* validate flags and flow id */
 	if (flags == 0xFF) {
 		brcmf_err("invalid flags...so ignore this packet\n");
-		brcmf_netif_rx(ifp, pkt);
+		brcmf_netif_rx(ifp, pkt, false);
 		return;
 	}
 
@@ -388,7 +389,7 @@ static void brcmf_rxreorder_process_info
 		if (rfi == NULL) {
 			brcmf_dbg(INFO, "received flags to cleanup, but no flow (%d) yet\n",
 				  flow_id);
-			brcmf_netif_rx(ifp, pkt);
+			brcmf_netif_rx(ifp, pkt, false);
 			return;
 		}
 
@@ -413,7 +414,7 @@ static void brcmf_rxreorder_process_info
 		rfi = kzalloc(buf_size, GFP_ATOMIC);
 		if (rfi == NULL) {
 			brcmf_err("failed to alloc buffer\n");
-			brcmf_netif_rx(ifp, pkt);
+			brcmf_netif_rx(ifp, pkt, false);
 			return;
 		}
 
@@ -527,11 +528,11 @@ static void brcmf_rxreorder_process_info
 netif_rx:
 	skb_queue_walk_safe(&reorder_list, pkt, pnext) {
 		__skb_unlink(pkt, &reorder_list);
-		brcmf_netif_rx(ifp, pkt);
+		brcmf_netif_rx(ifp, pkt, false);
 	}
 }
 
-void brcmf_rx_frame(struct device *dev, struct sk_buff *skb)
+void brcmf_rx_frame(struct device *dev, struct sk_buff *skb, bool handle_evnt)
 {
 	struct brcmf_if *ifp;
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
@@ -555,7 +556,32 @@ void brcmf_rx_frame(struct device *dev,
 	if (rd->reorder)
 		brcmf_rxreorder_process_info(ifp, rd->reorder, skb);
 	else
-		brcmf_netif_rx(ifp, skb);
+		brcmf_netif_rx(ifp, skb, handle_evnt);
+}
+
+void brcmf_rx_event(struct device *dev, struct sk_buff *skb)
+{
+	struct brcmf_if *ifp;
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pub *drvr = bus_if->drvr;
+	int ret;
+
+	brcmf_dbg(EVENT, "Enter: %s: rxp=%p\n", dev_name(dev), skb);
+
+	/* process and remove protocol-specific header */
+	ret = brcmf_proto_hdrpull(drvr, true, skb, &ifp);
+
+	if (ret || !ifp || !ifp->ndev) {
+		if (ret != -ENODATA && ifp)
+			ifp->stats.rx_errors++;
+		brcmu_pkt_buf_free_skb(skb);
+		return;
+	}
+
+	skb->protocol = eth_type_trans(skb, ifp->ndev);
+
+	brcmf_fweh_process_skb(ifp->drvr, skb);
+	brcmu_pkt_buf_free_skb(skb);
 }
 
 void brcmf_txfinalize(struct brcmf_pub *drvr, struct sk_buff *txp, u8 ifidx,
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_sdio.c
@@ -1339,6 +1339,17 @@ static inline u8 brcmf_sdio_getdatoffset
 	return (u8)((hdrvalue & SDPCM_DOFFSET_MASK) >> SDPCM_DOFFSET_SHIFT);
 }
 
+static inline bool brcmf_sdio_fromevntchan(u8 *swheader)
+{
+	u32 hdrvalue;
+	u8 ret;
+
+	hdrvalue = *(u32 *)swheader;
+	ret = (u8)((hdrvalue & SDPCM_CHANNEL_MASK) >> SDPCM_CHANNEL_SHIFT);
+
+	return (ret == SDPCM_EVENT_CHANNEL);
+}
+
 static int brcmf_sdio_hdparse(struct brcmf_sdio *bus, u8 *header,
 			      struct brcmf_sdio_hdrinfo *rd,
 			      enum brcmf_sdio_frmtype type)
@@ -1699,7 +1710,11 @@ static u8 brcmf_sdio_rxglom(struct brcmf
 					   pfirst->len, pfirst->next,
 					   pfirst->prev);
 			skb_unlink(pfirst, &bus->glom);
-			brcmf_rx_frame(bus->sdiodev->dev, pfirst);
+			if (brcmf_sdio_fromevntchan(pfirst->data))
+				brcmf_rx_event(bus->sdiodev->dev, pfirst);
+			else
+				brcmf_rx_frame(bus->sdiodev->dev, pfirst,
+					       false);
 			bus->sdcnt.rxglompkts++;
 		}
 
@@ -2026,18 +2041,19 @@ static uint brcmf_sdio_readframes(struct
 		__skb_trim(pkt, rd->len);
 		skb_pull(pkt, rd->dat_offset);
 
+		if (pkt->len == 0)
+			brcmu_pkt_buf_free_skb(pkt);
+		else if (rd->channel == SDPCM_EVENT_CHANNEL)
+			brcmf_rx_event(bus->sdiodev->dev, pkt);
+		else
+			brcmf_rx_frame(bus->sdiodev->dev, pkt,
+				       false);
+
 		/* prepare the descriptor for the next read */
 		rd->len = rd->len_nxtfrm << 4;
 		rd->len_nxtfrm = 0;
 		/* treat all packet as event if we don't know */
 		rd->channel = SDPCM_EVENT_CHANNEL;
-
-		if (pkt->len == 0) {
-			brcmu_pkt_buf_free_skb(pkt);
-			continue;
-		}
-
-		brcmf_rx_frame(bus->sdiodev->dev, pkt);
 	}
 
 	rxcount = maxframes - rxleft;
--- a/drivers/net/wireless/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/usb.c
@@ -441,7 +441,7 @@ static void brcmf_usb_rx_complete(struct
 
 	if (devinfo->bus_pub.state == BRCMFMAC_USB_STATE_UP) {
 		skb_put(skb, urb->actual_length);
-		brcmf_rx_frame(devinfo->dev, skb);
+		brcmf_rx_frame(devinfo->dev, skb, true);
 		brcmf_usb_rx_refill(devinfo, req);
 	} else {
 		brcmu_pkt_buf_free_skb(skb);

