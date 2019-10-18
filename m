Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004BBCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD45E222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504081AbfJRFFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4717 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504058AbfJRFFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EB375B02C356D3B56BA6;
        Fri, 18 Oct 2019 11:19:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:27 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 14/33] idsn: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:31 +0800
Message-ID: <20191018031850.48498-14-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Karsten Keil <isdn@linux-pingi.de>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/isdn/hardware/mISDN/avmfritz.c  | 16 ++++++++--------
 drivers/isdn/hardware/mISDN/hfcmulti.c  |  8 ++++----
 drivers/isdn/hardware/mISDN/hfcpci.c    |  3 +--
 drivers/isdn/hardware/mISDN/hfcsusb.c   |  4 ++--
 drivers/isdn/hardware/mISDN/mISDNipac.c |  4 ++--
 drivers/isdn/hardware/mISDN/mISDNisar.c | 10 +++++-----
 drivers/isdn/hardware/mISDN/netjet.c    |  8 ++++----
 drivers/isdn/hardware/mISDN/w6692.c     | 12 ++++++------
 drivers/isdn/mISDN/hwchannel.c          |  7 +++----
 9 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/avmfritz.c b/drivers/isdn/hardware/mISDN/avmfritz.c
index 1137dd152b5c..ecc1ef6c386d 100644
--- a/drivers/isdn/hardware/mISDN/avmfritz.c
+++ b/drivers/isdn/hardware/mISDN/avmfritz.c
@@ -402,8 +402,8 @@ hdlc_empty_fifo(struct bchannel *bch, int count)
 	} else {
 		cnt = bchannel_get_rxbuf(bch, count);
 		if (cnt < 0) {
-			pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-				   fc->name, bch->nr, count);
+			pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+				fc->name, bch->nr, count);
 			return;
 		}
 		p = skb_put(bch->rx_skb, count);
@@ -538,8 +538,8 @@ HDLC_irq(struct bchannel *bch, u32 stat)
 	}
 	if (stat & HDLC_INT_RPR) {
 		if (stat & HDLC_STAT_RDO) {
-			pr_warning("%s: ch%d stat %x RDO\n",
-				   fc->name, bch->nr, stat);
+			pr_warn("%s: ch%d stat %x RDO\n",
+				fc->name, bch->nr, stat);
 			hdlc->ctrl.sr.xml = 0;
 			hdlc->ctrl.sr.cmd |= HDLC_CMD_RRS;
 			write_ctrl(bch, 1);
@@ -561,8 +561,8 @@ HDLC_irq(struct bchannel *bch, u32 stat)
 				    HDLC_STAT_CRCVFR) {
 					recv_Bchannel(bch, 0, false);
 				} else {
-					pr_warning("%s: got invalid frame\n",
-						   fc->name);
+					pr_warn("%s: got invalid frame\n",
+						fc->name);
 					skb_trim(bch->rx_skb, 0);
 				}
 			}
@@ -574,8 +574,8 @@ HDLC_irq(struct bchannel *bch, u32 stat)
 		 * restart transmitting the whole frame on HDLC
 		 * in transparent mode we send the next data
 		 */
-		pr_warning("%s: ch%d stat %x XDU %s\n", fc->name, bch->nr,
-			   stat, bch->tx_skb ? "tx_skb" : "no tx_skb");
+		pr_warn("%s: ch%d stat %x XDU %s\n", fc->name, bch->nr,
+			stat, bch->tx_skb ? "tx_skb" : "no tx_skb");
 		if (bch->tx_skb && bch->tx_skb->len) {
 			if (!test_bit(FLG_TRANSPARENT, &bch->Flags))
 				bch->tx_idx = 0;
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 86669ec8b977..7013a3f08429 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -2248,8 +2248,8 @@ hfcmulti_rx(struct hfc_multi *hc, int ch)
 	if (bch) {
 		maxlen = bchannel_get_rxbuf(bch, Zsize);
 		if (maxlen < 0) {
-			pr_warning("card%d.B%d: No bufferspace for %d bytes\n",
-				   hc->id + 1, bch->nr, Zsize);
+			pr_warn("card%d.B%d: No bufferspace for %d bytes\n",
+				hc->id + 1, bch->nr, Zsize);
 			return;
 		}
 		sp = &bch->rx_skb;
@@ -2260,8 +2260,8 @@ hfcmulti_rx(struct hfc_multi *hc, int ch)
 		if (*sp == NULL) {
 			*sp = mI_alloc_skb(maxlen, GFP_ATOMIC);
 			if (*sp == NULL) {
-				pr_warning("card%d: No mem for dch rx_skb\n",
-					   hc->id + 1);
+				pr_warn("card%d: No mem for dch rx_skb\n",
+					hc->id + 1);
 				return;
 			}
 		}
diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index 2330a7d24267..abdf787c1a71 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -566,8 +566,7 @@ hfcpci_empty_fifo_trans(struct bchannel *bch, struct bzfifo *rxbz,
 	}
 	maxlen = bchannel_get_rxbuf(bch, fcnt_rx);
 	if (maxlen < 0) {
-		pr_warning("B%d: No bufferspace for %d bytes\n",
-			   bch->nr, fcnt_rx);
+		pr_warn("B%d: No bufferspace for %d bytes\n", bch->nr, fcnt_rx);
 	} else {
 		ptr = skb_put(bch->rx_skb, fcnt_rx);
 		if (le16_to_cpu(*z2r) + fcnt_rx <= B_FIFO_SIZE + B_SUB_VAL)
diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index 008a74a1ed44..621364bb6b12 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -841,8 +841,8 @@ hfcsusb_rx_frame(struct usb_fifo *fifo, __u8 *data, unsigned int len,
 		if (maxlen < 0) {
 			if (rx_skb)
 				skb_trim(rx_skb, 0);
-			pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-				   hw->name, fifo->bch->nr, len);
+			pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+				hw->name, fifo->bch->nr, len);
 			spin_unlock_irqrestore(&hw->lock, flags);
 			return;
 		}
diff --git a/drivers/isdn/hardware/mISDN/mISDNipac.c b/drivers/isdn/hardware/mISDN/mISDNipac.c
index bca880213e91..ec475087fbf9 100644
--- a/drivers/isdn/hardware/mISDN/mISDNipac.c
+++ b/drivers/isdn/hardware/mISDN/mISDNipac.c
@@ -936,8 +936,8 @@ hscx_empty_fifo(struct hscx_hw *hscx, u8 count)
 		hscx_cmdr(hscx, 0x80); /* RMC */
 		if (hscx->bch.rx_skb)
 			skb_trim(hscx->bch.rx_skb, 0);
-		pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-			   hscx->ip->name, hscx->bch.nr, count);
+		pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+			hscx->ip->name, hscx->bch.nr, count);
 		return;
 	}
 	p = skb_put(hscx->bch.rx_skb, count);
diff --git a/drivers/isdn/hardware/mISDN/mISDNisar.c b/drivers/isdn/hardware/mISDN/mISDNisar.c
index 4a3e748a1c26..096d8c5e5df9 100644
--- a/drivers/isdn/hardware/mISDN/mISDNisar.c
+++ b/drivers/isdn/hardware/mISDN/mISDNisar.c
@@ -222,7 +222,7 @@ load_firmware(struct isar_hw *isar, const u8 *buf, int size)
 			goto reterror;
 		}
 		if (!poll_mbox(isar, 1000)) {
-			pr_warning("ISAR poll_mbox dkey failed\n");
+			pr_warn("ISAR poll_mbox dkey failed\n");
 			ret = -ETIME;
 			goto reterror;
 		}
@@ -432,8 +432,8 @@ isar_rcv_frame(struct isar_ch *ch)
 	case ISDN_P_B_MODEM_ASYNC:
 		maxlen = bchannel_get_rxbuf(&ch->bch, ch->is->clsb);
 		if (maxlen < 0) {
-			pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-				   ch->is->name, ch->bch.nr, ch->is->clsb);
+			pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+				ch->is->name, ch->bch.nr, ch->is->clsb);
 			ch->is->write_reg(ch->is->hw, ISAR_IIA, 0);
 			break;
 		}
@@ -443,8 +443,8 @@ isar_rcv_frame(struct isar_ch *ch)
 	case ISDN_P_B_HDLC:
 		maxlen = bchannel_get_rxbuf(&ch->bch, ch->is->clsb);
 		if (maxlen < 0) {
-			pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-				   ch->is->name, ch->bch.nr, ch->is->clsb);
+			pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+				ch->is->name, ch->bch.nr, ch->is->clsb);
 			ch->is->write_reg(ch->is->hw, ISAR_IIA, 0);
 			break;
 		}
diff --git a/drivers/isdn/hardware/mISDN/netjet.c b/drivers/isdn/hardware/mISDN/netjet.c
index 61caa7e50b9a..6aae97e827b7 100644
--- a/drivers/isdn/hardware/mISDN/netjet.c
+++ b/drivers/isdn/hardware/mISDN/netjet.c
@@ -380,8 +380,8 @@ read_dma(struct tiger_ch *bc, u32 idx, int cnt)
 	stat = bchannel_get_rxbuf(&bc->bch, cnt);
 	/* only transparent use the count here, HDLC overun is detected later */
 	if (stat == -ENOMEM) {
-		pr_warning("%s.B%d: No memory for %d bytes\n",
-			   card->name, bc->bch.nr, cnt);
+		pr_warn("%s.B%d: No memory for %d bytes\n",
+			card->name, bc->bch.nr, cnt);
 		return;
 	}
 	if (test_bit(FLG_TRANSPARENT, &bc->bch.Flags))
@@ -420,8 +420,8 @@ read_dma(struct tiger_ch *bc, u32 idx, int cnt)
 			recv_Bchannel(&bc->bch, 0, false);
 			stat = bchannel_get_rxbuf(&bc->bch, bc->bch.maxlen);
 			if (stat < 0) {
-				pr_warning("%s.B%d: No memory for %d bytes\n",
-					   card->name, bc->bch.nr, cnt);
+				pr_warn("%s.B%d: No memory for %d bytes\n",
+					card->name, bc->bch.nr, cnt);
 				return;
 			}
 		} else if (stat == -HDLC_CRC_ERROR) {
diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
index bad55fdacd36..f3b8db7b48fe 100644
--- a/drivers/isdn/hardware/mISDN/w6692.c
+++ b/drivers/isdn/hardware/mISDN/w6692.c
@@ -466,8 +466,8 @@ W6692_empty_Bfifo(struct w6692_ch *wch, int count)
 		WriteW6692B(wch, W_B_CMDR, W_B_CMDR_RACK | W_B_CMDR_RACT);
 		if (wch->bch.rx_skb)
 			skb_trim(wch->bch.rx_skb, 0);
-		pr_warning("%s.B%d: No bufferspace for %d bytes\n",
-			   card->name, wch->bch.nr, count);
+		pr_warn("%s.B%d: No bufferspace for %d bytes\n",
+			card->name, wch->bch.nr, count);
 		return;
 	}
 	ptr = skb_put(wch->bch.rx_skb, count);
@@ -729,8 +729,8 @@ W6692B_interrupt(struct w6692_hw *card, int ch)
 				 wch->bch.nr, star);
 		}
 		if (star & W_B_STAR_XDOW) {
-			pr_warning("%s: B%d XDOW proto=%x\n", card->name,
-				   wch->bch.nr, wch->bch.state);
+			pr_warn("%s: B%d XDOW proto=%x\n", card->name,
+				wch->bch.nr, wch->bch.state);
 #ifdef ERROR_STATISTIC
 			wch->bch.err_xdu++;
 #endif
@@ -747,8 +747,8 @@ W6692B_interrupt(struct w6692_hw *card, int ch)
 			return; /* handle XDOW only once */
 	}
 	if (stat & W_B_EXI_XDUN) {
-		pr_warning("%s: B%d XDUN proto=%x\n", card->name,
-			   wch->bch.nr, wch->bch.state);
+		pr_warn("%s: B%d XDUN proto=%x\n", card->name,
+			wch->bch.nr, wch->bch.state);
 #ifdef ERROR_STATISTIC
 		wch->bch.err_xdu++;
 #endif
diff --git a/drivers/isdn/mISDN/hwchannel.c b/drivers/isdn/mISDN/hwchannel.c
index f378173bcf6f..8c93af06ed02 100644
--- a/drivers/isdn/mISDN/hwchannel.c
+++ b/drivers/isdn/mISDN/hwchannel.c
@@ -474,8 +474,8 @@ bchannel_get_rxbuf(struct bchannel *bch, int reqlen)
 	if (bch->rx_skb) {
 		len = skb_tailroom(bch->rx_skb);
 		if (len < reqlen) {
-			pr_warning("B%d no space for %d (only %d) bytes\n",
-				   bch->nr, reqlen, len);
+			pr_warn("B%d no space for %d (only %d) bytes\n",
+				bch->nr, reqlen, len);
 			if (test_bit(FLG_TRANSPARENT, &bch->Flags)) {
 				/* send what we have now and try a new buffer */
 				recv_Bchannel(bch, 0, true);
@@ -508,8 +508,7 @@ bchannel_get_rxbuf(struct bchannel *bch, int reqlen)
 	}
 	bch->rx_skb = mI_alloc_skb(len, GFP_ATOMIC);
 	if (!bch->rx_skb) {
-		pr_warning("B%d receive no memory for %d bytes\n",
-			   bch->nr, len);
+		pr_warn("B%d receive no memory for %d bytes\n", bch->nr, len);
 		len = -ENOMEM;
 	}
 	return len;
-- 
2.20.1

