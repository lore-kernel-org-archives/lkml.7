Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F15EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250032064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfCFLrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:08 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22939 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729651AbfCFLrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:04 -0500
X-UUID: af621c63d1dc4cf9adf52c6e57ad61ab-20190306
X-UUID: af621c63d1dc4cf9adf52c6e57ad61ab-20190306
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 967236970; Wed, 06 Mar 2019 19:46:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:52 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 07/11] usb: mtu3: supports new QMU format
Date:   Wed, 6 Mar 2019 19:46:19 +0800
Message-ID: <1551872783-13707-8-git-send-email-chunfeng.yun@mediatek.com>
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

In order to support U3gen2 ISOC transfer upto 96DPs, extend
the data buffer length.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h         | 11 +++---
 drivers/usb/mtu3/mtu3_core.c    |  5 +++
 drivers/usb/mtu3/mtu3_gadget.c  |  6 ++--
 drivers/usb/mtu3/mtu3_hw_regs.h |  1 +
 drivers/usb/mtu3/mtu3_qmu.c     | 64 +++++++++++++++++++++++++--------
 drivers/usb/mtu3/mtu3_qmu.h     |  1 +
 6 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 4dda7ed6e24e..76ecf12fdf62 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -148,22 +148,23 @@ struct mtu3_fifo_info {
  *	bit0: Hardware Own (HWO)
  *	bit1: Buffer Descriptor Present (BDP), always 0, BD is not supported
  *	bit2: Bypass (BPS), 1: HW skips this GPD if HWO = 1
+ *	bit6: [EL] Zero Length Packet (ZLP), moved from @dw3_info[29]
  *	bit7: Interrupt On Completion (IOC)
- *	bit[31:16]: allow data buffer length (RX ONLY),
+ *	bit[31:16]: ([EL] bit[31:12]) allow data buffer length (RX ONLY),
  *		the buffer length of the data to receive
- *	bit[23:16]: extension address (TX ONLY),
+ *	bit[23:16]: ([EL] bit[31:24]) extension address (TX ONLY),
  *		lower 4 bits are extension bits of @buffer,
  *		upper 4 bits are extension bits of @next_gpd
  * @next_gpd: Physical address of the next GPD
  * @buffer: Physical address of the data buffer
  * @dw3_info:
- *	bit[15:0]: data buffer length,
+ *	bit[15:0]: ([EL] bit[19:0]) data buffer length,
  *		(TX): the buffer length of the data to transmit
  *		(RX): The total length of data received
- *	bit[23:16]: extension address (RX ONLY),
+ *	bit[23:16]: ([EL] bit[31:24]) extension address (RX ONLY),
  *		lower 4 bits are extension bits of @buffer,
  *		upper 4 bits are extension bits of @next_gpd
- *	bit29: Zero Length Packet (ZLP) (TX ONLY)
+ *	bit29: ([EL] abandoned) Zero Length Packet (ZLP) (TX ONLY)
  */
 struct qmu_gpd {
 	__le32 dw0_info;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index ef27c2052ad6..d354f5c3805a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -601,6 +601,10 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
 	/* enable automatical HWRW from L1 */
 	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
+
+	/* use new QMU format when HW version >= 0x1003 */
+	if (mtu->gen2cp)
+		mtu3_writel(mbase, U3D_QFCR, ~0x0);
 }
 
 static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
@@ -755,6 +759,7 @@ static int mtu3_hw_init(struct mtu3 *mtu)
 
 	value = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_TRUNK_VERS);
 	mtu->hw_version = IP_TRUNK_VERS(value);
+	mtu->gen2cp = !!(mtu->hw_version >= MTU3_TRUNK_VERS_1003);
 
 	value = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
 	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(value);
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index bbcd3332471d..fe798b94a357 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -278,10 +278,12 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
 		__func__, mep->is_in ? "TX" : "RX", mreq->epnum, ep->name,
 		mreq, ep->maxpacket, mreq->request.length);
 
-	if (req->length > GPD_BUF_SIZE) {
+	if (req->length > GPD_BUF_SIZE ||
+	    (mtu->gen2cp && req->length > GPD_BUF_SIZE_EL)) {
 		dev_warn(mtu->dev,
 			"req length > supported MAX:%d requested:%d\n",
-			GPD_BUF_SIZE, req->length);
+			mtu->gen2cp ? GPD_BUF_SIZE_EL : GPD_BUF_SIZE,
+			req->length);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index fae3b8de1092..bf70ea2426a9 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -49,6 +49,7 @@
 #define U3D_QCR1		(SSUSB_DEV_BASE + 0x0404)
 #define U3D_QCR2		(SSUSB_DEV_BASE + 0x0408)
 #define U3D_QCR3		(SSUSB_DEV_BASE + 0x040C)
+#define U3D_QFCR		(SSUSB_DEV_BASE + 0x0428)
 #define U3D_TXQHIAR1		(SSUSB_DEV_BASE + 0x0484)
 #define U3D_RXQHIAR1		(SSUSB_DEV_BASE + 0x04C4)
 
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 7a1919fc9f9e..9f017aa8fbeb 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -28,14 +28,42 @@
 #define GPD_FLAGS_HWO	BIT(0)
 #define GPD_FLAGS_BDP	BIT(1)
 #define GPD_FLAGS_BPS	BIT(2)
+#define GPD_FLAGS_ZLP	BIT(6)
 #define GPD_FLAGS_IOC	BIT(7)
 #define GET_GPD_HWO(gpd)	(le32_to_cpu((gpd)->dw0_info) & GPD_FLAGS_HWO)
 
-#define GPD_RX_BUF_LEN(x)	(((x) & 0xffff) << 16)
-#define GPD_DATA_LEN(x)		((x) & 0xffff)
+#define GPD_RX_BUF_LEN_OG(x)	(((x) & 0xffff) << 16)
+#define GPD_RX_BUF_LEN_EL(x)	(((x) & 0xfffff) << 12)
+#define GPD_RX_BUF_LEN(mtu, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	((mtu)->gen2cp) ? GPD_RX_BUF_LEN_EL(x_) : GPD_RX_BUF_LEN_OG(x_); \
+})
+
+#define GPD_DATA_LEN_OG(x)	((x) & 0xffff)
+#define GPD_DATA_LEN_EL(x)	((x) & 0xfffff)
+#define GPD_DATA_LEN(mtu, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	((mtu)->gen2cp) ? GPD_DATA_LEN_EL(x_) : GPD_DATA_LEN_OG(x_); \
+})
+
 #define GPD_EXT_FLAG_ZLP	BIT(29)
-#define GPD_EXT_NGP(x)		(((x) & 0xf) << 20)
-#define GPD_EXT_BUF(x)		(((x) & 0xf) << 16)
+#define GPD_EXT_NGP_OG(x)	(((x) & 0xf) << 20)
+#define GPD_EXT_BUF_OG(x)	(((x) & 0xf) << 16)
+#define GPD_EXT_NGP_EL(x)	(((x) & 0xf) << 28)
+#define GPD_EXT_BUF_EL(x)	(((x) & 0xf) << 24)
+#define GPD_EXT_NGP(mtu, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	((mtu)->gen2cp) ? GPD_EXT_NGP_EL(x_) : GPD_EXT_NGP_OG(x_); \
+})
+
+#define GPD_EXT_BUF(mtu, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	((mtu)->gen2cp) ? GPD_EXT_BUF_EL(x_) : GPD_EXT_BUF_OG(x_); \
+})
 
 #define HILO_GEN64(hi, lo) (((u64)(hi) << 32) + (lo))
 #define HILO_DMA(hi, lo)	\
@@ -217,13 +245,14 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	struct mtu3_gpd_ring *ring = &mep->gpd_ring;
 	struct qmu_gpd *gpd = ring->enqueue;
 	struct usb_request *req = &mreq->request;
+	struct mtu3 *mtu = mep->mtu;
 	dma_addr_t enq_dma;
 	u32 ext_addr;
 
 	gpd->dw0_info = 0;	/* SW own it */
 	gpd->buffer = cpu_to_le32(lower_32_bits(req->dma));
-	ext_addr = GPD_EXT_BUF(upper_32_bits(req->dma));
-	gpd->dw3_info = cpu_to_le32(GPD_DATA_LEN(req->length));
+	ext_addr = GPD_EXT_BUF(mtu, upper_32_bits(req->dma));
+	gpd->dw3_info = cpu_to_le32(GPD_DATA_LEN(mtu, req->length));
 
 	/* get the next GPD */
 	enq = advance_enq_gpd(ring);
@@ -233,11 +262,15 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 
 	enq->dw0_info &= cpu_to_le32(~GPD_FLAGS_HWO);
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
-	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
+	ext_addr |= GPD_EXT_NGP(mtu, upper_32_bits(enq_dma));
 	gpd->dw0_info = cpu_to_le32(ext_addr);
 
-	if (req->zero)
-		gpd->dw3_info |= cpu_to_le32(GPD_EXT_FLAG_ZLP);
+	if (req->zero) {
+		if (mtu->gen2cp)
+			gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_ZLP);
+		else
+			gpd->dw3_info |= cpu_to_le32(GPD_EXT_FLAG_ZLP);
+	}
 
 	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
@@ -252,13 +285,14 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	struct mtu3_gpd_ring *ring = &mep->gpd_ring;
 	struct qmu_gpd *gpd = ring->enqueue;
 	struct usb_request *req = &mreq->request;
+	struct mtu3 *mtu = mep->mtu;
 	dma_addr_t enq_dma;
 	u32 ext_addr;
 
 	gpd->dw0_info = 0;	/* SW own it */
 	gpd->buffer = cpu_to_le32(lower_32_bits(req->dma));
-	ext_addr = GPD_EXT_BUF(upper_32_bits(req->dma));
-	gpd->dw0_info = cpu_to_le32(GPD_RX_BUF_LEN(req->length));
+	ext_addr = GPD_EXT_BUF(mtu, upper_32_bits(req->dma));
+	gpd->dw0_info = cpu_to_le32(GPD_RX_BUF_LEN(mtu, req->length));
 
 	/* get the next GPD */
 	enq = advance_enq_gpd(ring);
@@ -268,7 +302,7 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 
 	enq->dw0_info &= cpu_to_le32(~GPD_FLAGS_HWO);
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
-	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
+	ext_addr |= GPD_EXT_NGP(mtu, upper_32_bits(enq_dma));
 	gpd->dw3_info = cpu_to_le32(ext_addr);
 	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
@@ -391,7 +425,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 	cur_gpd_dma = read_txq_cur_addr(mbase, epnum);
 	gpd_current = gpd_dma_to_virt(ring, cur_gpd_dma);
 
-	if (GPD_DATA_LEN(le32_to_cpu(gpd_current->dw3_info)) != 0) {
+	if (GPD_DATA_LEN(mtu, le32_to_cpu(gpd_current->dw3_info)) != 0) {
 		dev_err(mtu->dev, "TX EP%d buffer length error(!=0)\n", epnum);
 		return;
 	}
@@ -451,7 +485,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 		}
 
 		request = &mreq->request;
-		request->actual = GPD_DATA_LEN(le32_to_cpu(gpd->dw3_info));
+		request->actual = GPD_DATA_LEN(mtu, le32_to_cpu(gpd->dw3_info));
 		mtu3_req_complete(mep, request, 0);
 
 		gpd = advance_deq_gpd(ring);
@@ -489,7 +523,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 		}
 		req = &mreq->request;
 
-		req->actual = GPD_DATA_LEN(le32_to_cpu(gpd->dw3_info));
+		req->actual = GPD_DATA_LEN(mtu, le32_to_cpu(gpd->dw3_info));
 		mtu3_req_complete(mep, req, 0);
 
 		gpd = advance_deq_gpd(ring);
diff --git a/drivers/usb/mtu3/mtu3_qmu.h b/drivers/usb/mtu3/mtu3_qmu.h
index 81f5151a55ed..9cfde201db63 100644
--- a/drivers/usb/mtu3/mtu3_qmu.h
+++ b/drivers/usb/mtu3/mtu3_qmu.h
@@ -15,6 +15,7 @@
 #define QMU_GPD_RING_SIZE	(MAX_GPD_NUM * QMU_GPD_SIZE)
 
 #define GPD_BUF_SIZE		65532
+#define GPD_BUF_SIZE_EL		1048572
 
 void mtu3_qmu_stop(struct mtu3_ep *mep);
 int mtu3_qmu_start(struct mtu3_ep *mep);
-- 
2.20.1

