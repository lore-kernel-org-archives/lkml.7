Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CEB208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfD0P2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:28:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33120 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfD0PPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:22 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000zB-4x; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004ei-57; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hante Meuleman" <meuleman@broadcom.com>,
        "Kalle Valo" <kvalo@codeaurora.org>,
        "Arend van Spriel" <arend@broadcom.com>,
        "Pieter-Paul Giesberts" <pieterpg@broadcom.com>,
        "Franky (Zhenhui) Lin" <frankyl@broadcom.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.418735009@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 193/202] brcmfmac: consolidate ifp lookup in driver core
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

commit 75effb03ee8e4c9d4bbc909118ce5444b047dfde upstream.

In rx path the firmware provide an interface index which is used to
map to a struct brcmf_if instance. However, this involves some trick
that is done in two places. This is changed by having driver core
providing brcmf_get_ifp() function.

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
@@ -276,6 +276,7 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 			 struct sk_buff *pktbuf)
 {
 	struct brcmf_proto_bcdc_header *h;
+	struct brcmf_if *ifp;
 
 	brcmf_dbg(BCDC, "Enter\n");
 
@@ -289,30 +290,21 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 	trace_brcmf_bcdchdr(pktbuf->data);
 	h = (struct brcmf_proto_bcdc_header *)(pktbuf->data);
 
-	*ifidx = BCDC_GET_IF_IDX(h);
-	if (*ifidx >= BRCMF_MAX_IFS) {
-		brcmf_err("rx data ifnum out of range (%d)\n", *ifidx);
+	ifp = brcmf_get_ifp(drvr, BCDC_GET_IF_IDX(h));
+	if (IS_ERR_OR_NULL(ifp)) {
+		brcmf_dbg(INFO, "no matching ifp found\n");
 		return -EBADE;
 	}
-	/* The ifidx is the idx to map to matching netdev/ifp. When receiving
-	 * events this is easy because it contains the bssidx which maps
-	 * 1-on-1 to the netdev/ifp. But for data frames the ifidx is rcvd.
-	 * bssidx 1 is used for p2p0 and no data can be received or
-	 * transmitted on it. Therefor bssidx is ifidx + 1 if ifidx > 0
-	 */
-	if (*ifidx)
-		(*ifidx)++;
-
 	if (((h->flags & BCDC_FLAG_VER_MASK) >> BCDC_FLAG_VER_SHIFT) !=
 	    BCDC_PROTO_VER) {
 		brcmf_err("%s: non-BCDC packet received, flags 0x%x\n",
-			  brcmf_ifname(drvr, *ifidx), h->flags);
+			  brcmf_ifname(drvr, ifp->ifidx), h->flags);
 		return -EBADE;
 	}
 
 	if (h->flags & BCDC_FLAG_SUM_GOOD) {
 		brcmf_dbg(BCDC, "%s: BDC rcv, good checksum, flags 0x%x\n",
-			  brcmf_ifname(drvr, *ifidx), h->flags);
+			  brcmf_ifname(drvr, ifp->ifidx), h->flags);
 		pktbuf->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
@@ -320,12 +312,15 @@ brcmf_proto_bcdc_hdrpull(struct brcmf_pu
 
 	skb_pull(pktbuf, BCDC_HEADER_LEN);
 	if (do_fws)
-		brcmf_fws_hdrpull(drvr, *ifidx, h->data_offset << 2, pktbuf);
+		brcmf_fws_hdrpull(drvr, ifp->ifidx, h->data_offset << 2,
+				  pktbuf);
 	else
 		skb_pull(pktbuf, h->data_offset << 2);
 
 	if (pktbuf->len == 0)
 		return -ENODATA;
+
+	*ifidx = ifp->ifidx;
 	return 0;
 }
 
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
@@ -81,6 +81,25 @@ char *brcmf_ifname(struct brcmf_pub *drv
 	return "<if_none>";
 }
 
+struct brcmf_if *brcmf_get_ifp(struct brcmf_pub *drvr, int ifidx)
+{
+	if (ifidx < 0 || ifidx >= BRCMF_MAX_IFS) {
+		brcmf_err("ifidx %d out of range\n", ifidx);
+		return ERR_PTR(-ERANGE);
+	}
+
+	/* The ifidx is the idx to map to matching netdev/ifp. When receiving
+	 * events this is easy because it contains the bssidx which maps
+	 * 1-on-1 to the netdev/ifp. But for data frames the ifidx is rcvd.
+	 * bssidx 1 is used for p2p0 and no data can be received or
+	 * transmitted on it. Therefor bssidx is ifidx + 1 if ifidx > 0
+	 */
+	if (ifidx)
+		ifidx++;
+
+	return drvr->iflist[ifidx];
+}
+
 static void _brcmf_set_multicast_list(struct work_struct *work)
 {
 	struct brcmf_if *ifp;
--- a/drivers/net/wireless/brcm80211/brcmfmac/dhd.h
+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd.h
@@ -178,7 +178,7 @@ int brcmf_netdev_wait_pend8021x(struct n
 
 /* Return pointer to interface name */
 char *brcmf_ifname(struct brcmf_pub *drvr, int idx);
-
+struct brcmf_if *brcmf_get_ifp(struct brcmf_pub *drvr, int ifidx);
 int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked);
 struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bssidx, s32 ifidx,
 			      char *name, u8 *mac_addr);

