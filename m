Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD2C10F0C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEA42064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfCFLrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:04 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54639 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729602AbfCFLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:02 -0500
X-UUID: 3b247122dcd3447c8133c725d64d7662-20190306
X-UUID: 3b247122dcd3447c8133c725d64d7662-20190306
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 336922383; Wed, 06 Mar 2019 19:46:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:51 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 06/11] usb: mtu3: rebuild qmu_gpd struct to prepare to support new QMU format
Date:   Wed, 6 Mar 2019 19:46:18 +0800
Message-ID: <1551872783-13707-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support USB3 Gen2 ISOC, the data buffer length need be extended,
it's hard to make the current qmu_gpd struct compatible, so here
rebuild qmu_gpd struct and make easy to support new QMU format

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h     | 45 +++++++++++------------------
 drivers/usb/mtu3/mtu3_qmu.c | 56 +++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index e3143f81b6a0..4dda7ed6e24e 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -144,45 +144,32 @@ struct mtu3_fifo_info {
  *	The format of TX GPD is a little different from RX one.
  *	And the size of GPD is 16 bytes.
  *
- * @flag:
+ * @dw0_info:
  *	bit0: Hardware Own (HWO)
  *	bit1: Buffer Descriptor Present (BDP), always 0, BD is not supported
  *	bit2: Bypass (BPS), 1: HW skips this GPD if HWO = 1
  *	bit7: Interrupt On Completion (IOC)
- * @chksum: This is used to validate the contents of this GPD;
- *	If TXQ_CS_EN / RXQ_CS_EN bit is set, an interrupt is issued
- *	when checksum validation fails;
- *	Checksum value is calculated over the 16 bytes of the GPD by default;
- * @data_buf_len (RX ONLY): This value indicates the length of
- *	the assigned data buffer
- * @tx_ext_addr (TX ONLY): [3:0] are 4 extension bits of @buffer,
- *	[7:4] are 4 extension bits of @next_gpd
+ *	bit[31:16]: allow data buffer length (RX ONLY),
+ *		the buffer length of the data to receive
+ *	bit[23:16]: extension address (TX ONLY),
+ *		lower 4 bits are extension bits of @buffer,
+ *		upper 4 bits are extension bits of @next_gpd
  * @next_gpd: Physical address of the next GPD
  * @buffer: Physical address of the data buffer
- * @buf_len:
- *	(TX): This value indicates the length of the assigned data buffer
- *	(RX): The total length of data received
- * @ext_len: reserved
- * @rx_ext_addr(RX ONLY): [3:0] are 4 extension bits of @buffer,
- *	[7:4] are 4 extension bits of @next_gpd
- * @ext_flag:
- *	bit5 (TX ONLY): Zero Length Packet (ZLP),
+ * @dw3_info:
+ *	bit[15:0]: data buffer length,
+ *		(TX): the buffer length of the data to transmit
+ *		(RX): The total length of data received
+ *	bit[23:16]: extension address (RX ONLY),
+ *		lower 4 bits are extension bits of @buffer,
+ *		upper 4 bits are extension bits of @next_gpd
+ *	bit29: Zero Length Packet (ZLP) (TX ONLY)
  */
 struct qmu_gpd {
-	__u8 flag;
-	__u8 chksum;
-	union {
-		__le16 data_buf_len;
-		__le16 tx_ext_addr;
-	};
+	__le32 dw0_info;
 	__le32 next_gpd;
 	__le32 buffer;
-	__le16 buf_len;
-	union {
-		__u8 ext_len;
-		__u8 rx_ext_addr;
-	};
-	__u8 ext_flag;
+	__le32 dw3_info;
 } __packed;
 
 /**
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index f4b5431264c1..7a1919fc9f9e 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -29,10 +29,13 @@
 #define GPD_FLAGS_BDP	BIT(1)
 #define GPD_FLAGS_BPS	BIT(2)
 #define GPD_FLAGS_IOC	BIT(7)
+#define GET_GPD_HWO(gpd)	(le32_to_cpu((gpd)->dw0_info) & GPD_FLAGS_HWO)
 
-#define GPD_EXT_FLAG_ZLP	BIT(5)
-#define GPD_EXT_NGP(x)		(((x) & 0xf) << 4)
-#define GPD_EXT_BUF(x)		(((x) & 0xf) << 0)
+#define GPD_RX_BUF_LEN(x)	(((x) & 0xffff) << 16)
+#define GPD_DATA_LEN(x)		((x) & 0xffff)
+#define GPD_EXT_FLAG_ZLP	BIT(29)
+#define GPD_EXT_NGP(x)		(((x) & 0xf) << 20)
+#define GPD_EXT_BUF(x)		(((x) & 0xf) << 16)
 
 #define HILO_GEN64(hi, lo) (((u64)(hi) << 32) + (lo))
 #define HILO_DMA(hi, lo)	\
@@ -125,7 +128,7 @@ static void reset_gpd_list(struct mtu3_ep *mep)
 	struct qmu_gpd *gpd = ring->start;
 
 	if (gpd) {
-		gpd->flag &= ~GPD_FLAGS_HWO;
+		gpd->dw0_info &= cpu_to_le32(~GPD_FLAGS_HWO);
 		gpd_ring_init(ring, gpd);
 	}
 }
@@ -215,15 +218,12 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	struct qmu_gpd *gpd = ring->enqueue;
 	struct usb_request *req = &mreq->request;
 	dma_addr_t enq_dma;
-	u16 ext_addr;
-
-	/* set all fields to zero as default value */
-	memset(gpd, 0, sizeof(*gpd));
+	u32 ext_addr;
 
+	gpd->dw0_info = 0;	/* SW own it */
 	gpd->buffer = cpu_to_le32(lower_32_bits(req->dma));
 	ext_addr = GPD_EXT_BUF(upper_32_bits(req->dma));
-	gpd->buf_len = cpu_to_le16(req->length);
-	gpd->flag |= GPD_FLAGS_IOC;
+	gpd->dw3_info = cpu_to_le32(GPD_DATA_LEN(req->length));
 
 	/* get the next GPD */
 	enq = advance_enq_gpd(ring);
@@ -231,15 +231,15 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	dev_dbg(mep->mtu->dev, "TX-EP%d queue gpd=%p, enq=%p, qdma=%pad\n",
 		mep->epnum, gpd, enq, &enq_dma);
 
-	enq->flag &= ~GPD_FLAGS_HWO;
+	enq->dw0_info &= cpu_to_le32(~GPD_FLAGS_HWO);
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
 	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
-	gpd->tx_ext_addr = cpu_to_le16(ext_addr);
+	gpd->dw0_info = cpu_to_le32(ext_addr);
 
 	if (req->zero)
-		gpd->ext_flag |= GPD_EXT_FLAG_ZLP;
+		gpd->dw3_info |= cpu_to_le32(GPD_EXT_FLAG_ZLP);
 
-	gpd->flag |= GPD_FLAGS_HWO;
+	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
 	mreq->gpd = gpd;
 
@@ -253,15 +253,12 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	struct qmu_gpd *gpd = ring->enqueue;
 	struct usb_request *req = &mreq->request;
 	dma_addr_t enq_dma;
-	u16 ext_addr;
-
-	/* set all fields to zero as default value */
-	memset(gpd, 0, sizeof(*gpd));
+	u32 ext_addr;
 
+	gpd->dw0_info = 0;	/* SW own it */
 	gpd->buffer = cpu_to_le32(lower_32_bits(req->dma));
 	ext_addr = GPD_EXT_BUF(upper_32_bits(req->dma));
-	gpd->data_buf_len = cpu_to_le16(req->length);
-	gpd->flag |= GPD_FLAGS_IOC;
+	gpd->dw0_info = cpu_to_le32(GPD_RX_BUF_LEN(req->length));
 
 	/* get the next GPD */
 	enq = advance_enq_gpd(ring);
@@ -269,11 +266,11 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	dev_dbg(mep->mtu->dev, "RX-EP%d queue gpd=%p, enq=%p, qdma=%pad\n",
 		mep->epnum, gpd, enq, &enq_dma);
 
-	enq->flag &= ~GPD_FLAGS_HWO;
+	enq->dw0_info &= cpu_to_le32(~GPD_FLAGS_HWO);
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
 	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
-	gpd->rx_ext_addr = cpu_to_le16(ext_addr);
-	gpd->flag |= GPD_FLAGS_HWO;
+	gpd->dw3_info = cpu_to_le32(ext_addr);
+	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
 	mreq->gpd = gpd;
 
@@ -394,7 +391,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 	cur_gpd_dma = read_txq_cur_addr(mbase, epnum);
 	gpd_current = gpd_dma_to_virt(ring, cur_gpd_dma);
 
-	if (le16_to_cpu(gpd_current->buf_len) != 0) {
+	if (GPD_DATA_LEN(le32_to_cpu(gpd_current->dw3_info)) != 0) {
 		dev_err(mtu->dev, "TX EP%d buffer length error(!=0)\n", epnum);
 		return;
 	}
@@ -412,8 +409,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 	mtu3_setbits(mbase, MU3D_EP_TXCR0(mep->epnum), TX_TXPKTRDY);
 
 	/* by pass the current GDP */
-	gpd_current->flag |= GPD_FLAGS_BPS;
-	gpd_current->flag |= GPD_FLAGS_HWO;
+	gpd_current->dw0_info |= cpu_to_le32(GPD_FLAGS_BPS | GPD_FLAGS_HWO);
 
 	/*enable DMAREQEN, switch back to QMU mode */
 	mtu3_setbits(mbase, MU3D_EP_TXCR0(mep->epnum), TX_DMAREQEN);
@@ -445,7 +441,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !(gpd->flag & GPD_FLAGS_HWO)) {
+	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
@@ -455,7 +451,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 		}
 
 		request = &mreq->request;
-		request->actual = le16_to_cpu(gpd->buf_len);
+		request->actual = GPD_DATA_LEN(le32_to_cpu(gpd->dw3_info));
 		mtu3_req_complete(mep, request, 0);
 
 		gpd = advance_deq_gpd(ring);
@@ -483,7 +479,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !(gpd->flag & GPD_FLAGS_HWO)) {
+	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
@@ -493,7 +489,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 		}
 		req = &mreq->request;
 
-		req->actual = le16_to_cpu(gpd->buf_len);
+		req->actual = GPD_DATA_LEN(le32_to_cpu(gpd->dw3_info));
 		mtu3_req_complete(mep, req, 0);
 
 		gpd = advance_deq_gpd(ring);
-- 
2.20.1

