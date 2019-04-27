Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1460BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED5208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfD0P2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:28:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33116 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727353AbfD0PPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000z8-0q; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004f3-8A; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Hante Meuleman" <hante.meuleman@broadcom.com>,
        "Franky Lin" <franky.lin@broadcom.com>,
        "Arend van Spriel" <arend@broadcom.com>,
        "Pieter-Paul Giesberts" <pieter-paul.giesberts@broadcom.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.319831062@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 197/202] brcmfmac: revise handling events in receive path
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

From: Arend van Spriel <arend@broadcom.com>

commit 9c349892ccc90c6de2baaa69cc78449f58082273 upstream.

Move event handling out of brcmf_netif_rx() avoiding the need
to pass a flag. This flag is only ever true for USB hosts as
other interface use separate brcmf_rx_event() function.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16 as dependency of commit a4176ec356c7
 "brcmfmac: add subtype check for event handling in data path"
 - Drop changes to PCIe bus support
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_bus.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_bus.h
@@ -168,7 +168,7 @@ bool brcmf_c_prec_enq(struct device *dev
 		      int prec);
 
 /* Receive frame for delivery to OS.  Callee disposes of rxp. */
-void brcmf_rx_frame(struct device *dev, struct sk_buff *rxp, bool handle_evnt);
+void brcmf_rx_frame(struct device *dev, struct sk_buff *rxp, bool handle_event);
 /* Receive async event packet from firmware. Callee disposes of rxp. */
 void brcmf_rx_event(struct device *dev, struct sk_buff *rxp);
 
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
@@ -306,18 +306,11 @@ void brcmf_txflowblock(struct device *de
 	brcmf_fws_bus_blocked(drvr, state);
 }
 
-static void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb,
-			    bool handle_event)
+static void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb)
 {
-	skb->protocol = eth_type_trans(skb, ifp->ndev);
-
 	if (skb->pkt_type == PACKET_MULTICAST)
 		ifp->stats.multicast++;
 
-	/* Process special event packets */
-	if (handle_event)
-		brcmf_fweh_process_skb(ifp->drvr, skb);
-
 	if (!(ifp->ndev->flags & IFF_UP)) {
 		brcmu_pkt_buf_free_skb(skb);
 		return;
@@ -377,7 +370,7 @@ static void brcmf_rxreorder_process_info
 	/* validate flags and flow id */
 	if (flags == 0xFF) {
 		brcmf_err("invalid flags...so ignore this packet\n");
-		brcmf_netif_rx(ifp, pkt, false);
+		brcmf_netif_rx(ifp, pkt);
 		return;
 	}
 
@@ -389,7 +382,7 @@ static void brcmf_rxreorder_process_info
 		if (rfi == NULL) {
 			brcmf_dbg(INFO, "received flags to cleanup, but no flow (%d) yet\n",
 				  flow_id);
-			brcmf_netif_rx(ifp, pkt, false);
+			brcmf_netif_rx(ifp, pkt);
 			return;
 		}
 
@@ -414,7 +407,7 @@ static void brcmf_rxreorder_process_info
 		rfi = kzalloc(buf_size, GFP_ATOMIC);
 		if (rfi == NULL) {
 			brcmf_err("failed to alloc buffer\n");
-			brcmf_netif_rx(ifp, pkt, false);
+			brcmf_netif_rx(ifp, pkt);
 			return;
 		}
 
@@ -528,11 +521,11 @@ static void brcmf_rxreorder_process_info
 netif_rx:
 	skb_queue_walk_safe(&reorder_list, pkt, pnext) {
 		__skb_unlink(pkt, &reorder_list);
-		brcmf_netif_rx(ifp, pkt, false);
+		brcmf_netif_rx(ifp, pkt);
 	}
 }
 
-void brcmf_rx_frame(struct device *dev, struct sk_buff *skb, bool handle_evnt)
+void brcmf_rx_frame(struct device *dev, struct sk_buff *skb, bool handle_event)
 {
 	struct brcmf_if *ifp;
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
@@ -552,11 +545,18 @@ void brcmf_rx_frame(struct device *dev,
 		return;
 	}
 
+	skb->protocol = eth_type_trans(skb, ifp->ndev);
+
 	rd = (struct brcmf_skb_reorder_data *)skb->cb;
-	if (rd->reorder)
+	if (rd->reorder) {
 		brcmf_rxreorder_process_info(ifp, rd->reorder, skb);
-	else
-		brcmf_netif_rx(ifp, skb, handle_evnt);
+	} else {
+		/* Process special event packets */
+		if (handle_event)
+			brcmf_fweh_process_skb(ifp->drvr, skb);
+
+		brcmf_netif_rx(ifp, skb);
+	}
 }
 
 void brcmf_rx_event(struct device *dev, struct sk_buff *skb)

