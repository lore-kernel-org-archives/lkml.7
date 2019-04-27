Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7AAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D390206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfD0PPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33112 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727350AbfD0PPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000zA-4q; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004en-5u; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Arend van Spriel" <arend@broadcom.com>,
        "Pieter-Paul Giesberts" <pieterpg@broadcom.com>,
        "Franky (Zhenhui) Lin" <frankyl@broadcom.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Hante Meuleman" <meuleman@broadcom.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.770933866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 194/202] brcmfmac: make brcmf_proto_hdrpull() return
 struct brcmf_if instance
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

commit 796cfb65e3ed01a9b08e3a0b93e34120c54bbbd2 upstream.

Avoid spreading the ifidx in the driver, but have it return the
struct brcmf_if instance.

Reviewed-by: Hante Meuleman <meuleman@broadcom.com>
Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16:
 - Drop changes to PCIe bus support
 - Adjust filenames]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/wireless/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/bcdc.c
@@ -272,11 +272,11 @@ brcmf_proto_bcdc_hdrpush(struct brcmf_pu
 }
 
 static int
-brcmf_proto_bcdc_hdrpull(struct brcmf_pub *drvr, bool do_fws, u8 *ifidx,
-			 struct sk_buff *pktbuf)
+brcmf_proto_bcdc_hdrpull(struct brcmf_pub *drvr, bool do_fws,
+			 struct sk_buff *pktbuf, struct brcmf_if **ifp)
 {
 	struct brcmf_proto_bcdc_header *h;
-	struct brcmf_if *ifp;
+	struct brcmf_if *tmp_if;
 
 	brcmf_dbg(BCDC, "Enter\n");
 
@@ -290,21 +290,21 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 	trace_brcmf_bcdchdr(pktbuf->data);
 	h = (struct brcmf_proto_bcdc_header *)(pktbuf->data);
 
-	ifp = brcmf_get_ifp(drvr, BCDC_GET_IF_IDX(h));
-	if (IS_ERR_OR_NULL(ifp)) {
+	tmp_if = brcmf_get_ifp(drvr, BCDC_GET_IF_IDX(h));
+	if (!tmp_if) {
 		brcmf_dbg(INFO, "no matching ifp found\n");
 		return -EBADE;
 	}
 	if (((h->flags & BCDC_FLAG_VER_MASK) >> BCDC_FLAG_VER_SHIFT) !=
 	    BCDC_PROTO_VER) {
 		brcmf_err("%s: non-BCDC packet received, flags 0x%x\n",
-			  brcmf_ifname(drvr, ifp->ifidx), h->flags);
+			  brcmf_ifname(drvr, tmp_if->ifidx), h->flags);
 		return -EBADE;
 	}
 
 	if (h->flags & BCDC_FLAG_SUM_GOOD) {
 		brcmf_dbg(BCDC, "%s: BDC rcv, good checksum, flags 0x%x\n",
-			  brcmf_ifname(drvr, ifp->ifidx), h->flags);
+			  brcmf_ifname(drvr, tmp_if->ifidx), h->flags);
 		pktbuf->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
@@ -312,7 +312,7 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 
 	skb_pull(pktbuf, BCDC_HEADER_LEN);
 	if (do_fws)
-		brcmf_fws_hdrpull(drvr, ifp->ifidx, h->data_offset << 2,
+		brcmf_fws_hdrpull(drvr, tmp_if->ifidx, h->data_offset << 2,
 				  pktbuf);
 	else
 		skb_pull(pktbuf, h->data_offset << 2);
@@ -320,7 +320,7 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 	if (pktbuf->len == 0)
 		return -ENODATA;
 
-	*ifidx = ifp->ifidx;
+	*ifp = tmp_if;
 	return 0;
 }
 
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
@@ -85,7 +85,7 @@ struct brcmf_if *brcmf_get_ifp(struct br
 {
 	if (ifidx < 0 || ifidx >= BRCMF_MAX_IFS) {
 		brcmf_err("ifidx %d out of range\n", ifidx);
-		return ERR_PTR(-ERANGE);
+		return NULL;
 	}
 
 	/* The ifidx is the idx to map to matching netdev/ifp. When receiving
@@ -537,17 +537,15 @@ void brcmf_rx_frame(struct device *dev,
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
 	struct brcmf_pub *drvr = bus_if->drvr;
 	struct brcmf_skb_reorder_data *rd;
-	u8 ifidx;
 	int ret;
 
 	brcmf_dbg(DATA, "Enter: %s: rxp=%p\n", dev_name(dev), skb);
 
 	/* process and remove protocol-specific header */
-	ret = brcmf_proto_hdrpull(drvr, true, &ifidx, skb);
-	ifp = drvr->iflist[ifidx];
+	ret = brcmf_proto_hdrpull(drvr, true, skb, &ifp);
 
 	if (ret || !ifp || !ifp->ndev) {
-		if ((ret != -ENODATA) && ifp)
+		if (ret != -ENODATA && ifp)
 			ifp->stats.rx_errors++;
 		brcmu_pkt_buf_free_skb(skb);
 		return;
@@ -590,17 +588,17 @@ void brcmf_txcomplete(struct device *dev
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
 	struct brcmf_pub *drvr = bus_if->drvr;
-	u8 ifidx;
+	struct brcmf_if *ifp;
 
 	/* await txstatus signal for firmware if active */
 	if (brcmf_fws_fc_active(drvr->fws)) {
 		if (!success)
 			brcmf_fws_bustxfail(drvr->fws, txp);
 	} else {
-		if (brcmf_proto_hdrpull(drvr, false, &ifidx, txp))
+		if (brcmf_proto_hdrpull(drvr, false, txp, &ifp))
 			brcmu_pkt_buf_free_skb(txp);
 		else
-			brcmf_txfinalize(drvr, txp, ifidx, success);
+			brcmf_txfinalize(drvr, txp, ifp->ifidx, success);
 	}
 }
 
--- a/drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c
@@ -1420,7 +1420,7 @@ brcmf_fws_txs_process(struct brcmf_fws_i
 	struct sk_buff *skb;
 	struct brcmf_skbuff_cb *skcb;
 	struct brcmf_fws_mac_descriptor *entry = NULL;
-	u8 ifidx;
+	struct brcmf_if *ifp;
 
 	brcmf_dbg(DATA, "flags %d\n", flags);
 
@@ -1469,15 +1469,16 @@ brcmf_fws_txs_process(struct brcmf_fws_i
 	}
 	brcmf_fws_macdesc_return_req_credit(skb);
 
-	if (brcmf_proto_hdrpull(fws->drvr, false, &ifidx, skb)) {
+	ret = brcmf_proto_hdrpull(fws->drvr, false, skb, &ifp);
+	if (ret) {
 		brcmu_pkt_buf_free_skb(skb);
 		return -EINVAL;
 	}
 	if (!remove_from_hanger)
-		ret = brcmf_fws_txstatus_suppressed(fws, fifo, skb, ifidx,
+		ret = brcmf_fws_txstatus_suppressed(fws, fifo, skb, ifp->ifidx,
 						    genbit, seq);
 	if (remove_from_hanger || ret)
-		brcmf_txfinalize(fws->drvr, skb, ifidx, true);
+		brcmf_txfinalize(fws->drvr, skb, ifp->ifidx, true);
 
 	return 0;
 }
@@ -1820,7 +1821,7 @@ static int brcmf_fws_commit_skb(struct b
 		entry->transit_count--;
 		if (entry->suppressed)
 			entry->suppr_transit_count--;
-		brcmf_proto_hdrpull(fws->drvr, false, &ifidx, skb);
+		(void)brcmf_proto_hdrpull(fws->drvr, false, skb, NULL);
 		goto rollback;
 	}
 
--- a/drivers/net/wireless/brcm80211/brcmfmac/proto.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/proto.h
@@ -17,8 +17,8 @@
 #define BRCMFMAC_PROTO_H
 
 struct brcmf_proto {
-	int (*hdrpull)(struct brcmf_pub *drvr, bool do_fws, u8 *ifidx,
-		       struct sk_buff *skb);
+	int (*hdrpull)(struct brcmf_pub *drvr, bool do_fws,
+		       struct sk_buff *skb, struct brcmf_if **ifp);
 	int (*query_dcmd)(struct brcmf_pub *drvr, int ifidx, uint cmd,
 			  void *buf, uint len);
 	int (*set_dcmd)(struct brcmf_pub *drvr, int ifidx, uint cmd, void *buf,
@@ -33,9 +33,19 @@ int brcmf_proto_attach(struct brcmf_pub
 void brcmf_proto_detach(struct brcmf_pub *drvr);
 
 static inline int brcmf_proto_hdrpull(struct brcmf_pub *drvr, bool do_fws,
-				      u8 *ifidx, struct sk_buff *skb)
+				      struct sk_buff *skb,
+				      struct brcmf_if **ifp)
 {
-	return drvr->proto->hdrpull(drvr, do_fws, ifidx, skb);
+	struct brcmf_if *tmp = NULL;
+
+	/* assure protocol is always called with
+	 * non-null initialized pointer.
+	 */
+	if (ifp)
+		*ifp = NULL;
+	else
+		ifp = &tmp;
+	return drvr->proto->hdrpull(drvr, do_fws, skb, ifp);
 }
 static inline int brcmf_proto_query_dcmd(struct brcmf_pub *drvr, int ifidx,
 					 uint cmd, void *buf, uint len)

