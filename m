Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C897C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B9F218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfCUCy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:54:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:25061 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727859AbfCUCys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:54:48 -0400
X-UUID: 17d9e9488f5b49b7919ee4363d793a14-20190321
X-UUID: 17d9e9488f5b49b7919ee4363d793a14-20190321
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 337617462; Thu, 21 Mar 2019 10:54:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 10:54:32 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 10:54:31 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 05/11] usb: mtu3: fix transfer error of USB3 Gen2 isoc
Date:   Thu, 21 Mar 2019 10:53:43 +0800
Message-ID: <1553136829-14712-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support USB3 Gen2 ISOC, the registers of TXCSR1 and RXCSR1
are adjusted to support greater maxpkt and mult value, this
patch fix this issue

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h         | 11 ++++++++++
 drivers/usb/mtu3/mtu3_core.c    | 14 +++++++------
 drivers/usb/mtu3/mtu3_hw_regs.h | 36 +++++++++++++++++++++++++++++----
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 87823ac0d120..e3143f81b6a0 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -62,6 +62,15 @@ struct mtu3_request;
 #define MTU3_U3_IP_SLOT_DEFAULT 2
 #define MTU3_U2_IP_SLOT_DEFAULT 1
 
+/**
+ * IP TRUNK version
+ * from 0x1003 version, USB3 Gen2 is supported, two changes affect driver:
+ * 1. MAXPKT and MULTI bits layout of TXCSR1 and RXCSR1 are adjusted,
+ *    but not backward compatible
+ * 2. QMU extend buffer length supported
+ */
+#define MTU3_TRUNK_VERS_1003	0x1003
+
 /**
  * Normally the device works on HS or SS, to simplify fifo management,
  * devide fifo into some 512B parts, use bitmap to manage it; And
@@ -316,6 +325,7 @@ static inline struct ssusb_mtk *dev_to_ssusb(struct device *dev)
  * @may_wakeup: means device's remote wakeup is enabled
  * @is_self_powered: is reported in device status and the config descriptor
  * @delayed_status: true when function drivers ask for delayed status
+ * @gen2cp: compatible with USB3 Gen2 IP
  * @ep0_req: dummy request used while handling standard USB requests
  *		for GET_STATUS and SET_SEL
  * @setup_buf: ep0 response buffer for GET_STATUS and SET_SEL requests
@@ -356,6 +366,7 @@ struct mtu3 {
 	unsigned u2_enable:1;
 	unsigned is_u3_ip:1;
 	unsigned delayed_status:1;
+	unsigned gen2cp:1;
 
 	u8 address;
 	u8 test_mode_nr;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 4fee200795a5..ef27c2052ad6 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -299,6 +299,7 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 			int interval, int burst, int mult)
 {
 	void __iomem *mbase = mtu->mac_base;
+	bool gen2cp = mtu->gen2cp;
 	int epnum = mep->epnum;
 	u32 csr0, csr1, csr2;
 	int fifo_sgsz, fifo_addr;
@@ -319,7 +320,7 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 
 		num_pkts = (burst + 1) * (mult + 1) - 1;
 		csr1 = TX_SS_BURST(burst) | TX_SLOT(mep->slot);
-		csr1 |= TX_MAX_PKT(num_pkts) | TX_MULT(mult);
+		csr1 |= TX_MAX_PKT(gen2cp, num_pkts) | TX_MULT(gen2cp, mult);
 
 		csr2 = TX_FIFOADDR(fifo_addr >> 4);
 		csr2 |= TX_FIFOSEGSIZE(fifo_sgsz);
@@ -355,7 +356,7 @@ int mtu3_config_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 
 		num_pkts = (burst + 1) * (mult + 1) - 1;
 		csr1 = RX_SS_BURST(burst) | RX_SLOT(mep->slot);
-		csr1 |= RX_MAX_PKT(num_pkts) | RX_MULT(mult);
+		csr1 |= RX_MAX_PKT(gen2cp, num_pkts) | RX_MULT(gen2cp, mult);
 
 		csr2 = RX_FIFOADDR(fifo_addr >> 4);
 		csr2 |= RX_FIFOSEGSIZE(fifo_sgsz);
@@ -749,13 +750,14 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 
 static int mtu3_hw_init(struct mtu3 *mtu)
 {
-	u32 cap_dev;
+	u32 value;
 	int ret;
 
-	mtu->hw_version = mtu3_readl(mtu->ippc_base, U3D_SSUSB_HW_ID);
+	value = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_TRUNK_VERS);
+	mtu->hw_version = IP_TRUNK_VERS(value);
 
-	cap_dev = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
-	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(cap_dev);
+	value = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
+	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(value);
 
 	dev_info(mtu->dev, "IP version 0x%x(%s IP)\n", mtu->hw_version,
 		mtu->is_u3_ip ? "U3" : "U2");
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 1d65b7476f23..fae3b8de1092 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -133,11 +133,23 @@
 #define TX_W1C_BITS		(~(TX_SENTSTALL))
 
 /* U3D_TX1CSR1 */
-#define TX_MULT(x)		(((x) & 0x3) << 22)
-#define TX_MAX_PKT(x)		(((x) & 0x3f) << 16)
+#define TX_MAX_PKT_G2(x)	(((x) & 0x7f) << 24)
+#define TX_MULT_G2(x)		(((x) & 0x7) << 21)
+#define TX_MULT_OG(x)		(((x) & 0x3) << 22)
+#define TX_MAX_PKT_OG(x)	(((x) & 0x3f) << 16)
 #define TX_SLOT(x)		(((x) & 0x3f) << 8)
 #define TX_TYPE(x)		(((x) & 0x3) << 4)
 #define TX_SS_BURST(x)		(((x) & 0xf) << 0)
+#define TX_MULT(g2c, x)		\
+({				\
+	typeof(x) x_ = (x);	\
+	(g2c) ? TX_MULT_G2(x_) : TX_MULT_OG(x_);	\
+})
+#define TX_MAX_PKT(g2c, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	(g2c) ? TX_MAX_PKT_G2(x_) : TX_MAX_PKT_OG(x_);	\
+})
 
 /* for TX_TYPE & RX_TYPE */
 #define TYPE_BULK		(0x0)
@@ -160,11 +172,23 @@
 #define RX_W1C_BITS		(~(RX_SENTSTALL | RX_RXPKTRDY))
 
 /* U3D_RX1CSR1 */
-#define RX_MULT(x)		(((x) & 0x3) << 22)
-#define RX_MAX_PKT(x)		(((x) & 0x3f) << 16)
+#define RX_MAX_PKT_G2(x)	(((x) & 0x7f) << 24)
+#define RX_MULT_G2(x)		(((x) & 0x7) << 21)
+#define RX_MULT_OG(x)		(((x) & 0x3) << 22)
+#define RX_MAX_PKT_OG(x)	(((x) & 0x3f) << 16)
 #define RX_SLOT(x)		(((x) & 0x3f) << 8)
 #define RX_TYPE(x)		(((x) & 0x3) << 4)
 #define RX_SS_BURST(x)		(((x) & 0xf) << 0)
+#define RX_MULT(g2c, x)		\
+({				\
+	typeof(x) x_ = (x);	\
+	(g2c) ? RX_MULT_G2(x_) : RX_MULT_OG(x_);	\
+})
+#define RX_MAX_PKT(g2c, x)	\
+({				\
+	typeof(x) x_ = (x);	\
+	(g2c) ? RX_MAX_PKT_G2(x_) : RX_MAX_PKT_OG(x_);	\
+})
 
 /* U3D_RX1CSR2 */
 #define RX_BINTERVAL(x)		(((x) & 0xff) << 24)
@@ -419,6 +443,7 @@
 #define U3D_SSUSB_DEV_RST_CTRL	(SSUSB_SIFSLV_IPPC_BASE + 0x0098)
 #define U3D_SSUSB_HW_ID		(SSUSB_SIFSLV_IPPC_BASE + 0x00A0)
 #define U3D_SSUSB_HW_SUB_ID	(SSUSB_SIFSLV_IPPC_BASE + 0x00A4)
+#define U3D_SSUSB_IP_TRUNK_VERS	(U3D_SSUSB_HW_SUB_ID)
 #define U3D_SSUSB_IP_SPARE0	(SSUSB_SIFSLV_IPPC_BASE + 0x00C8)
 
 /*---------------- SSUSB_SIFSLV_IPPC FIELD DEFINITION ----------------*/
@@ -483,4 +508,7 @@
 /* U3D_SSUSB_DEV_RST_CTRL */
 #define SSUSB_DEV_SW_RST		BIT(0)
 
+/* U3D_SSUSB_IP_TRUNK_VERS */
+#define IP_TRUNK_VERS(x)		(((x) >> 16) & 0xffff)
+
 #endif	/* _SSUSB_HW_REGS_H_ */
-- 
2.20.1

