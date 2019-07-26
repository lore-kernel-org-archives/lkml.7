Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837E322BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfGZIvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:51:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45332 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZIvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:51:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D69E81A0966;
        Fri, 26 Jul 2019 10:51:45 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 222B41A0976;
        Fri, 26 Jul 2019 10:51:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8BDA7402A9;
        Fri, 26 Jul 2019 16:51:37 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RFC] mailbox: imx: Add support for i.MX v1 messaging unit
Date:   Fri, 26 Jul 2019 16:29:36 +0800
Message-Id: <1564129776-19574-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a version1.0 MU on i.MX7ULP platform.
One new version ID register is added, and the offset is 0.
TRn registers are defined at the offset 0x20 ~ 0x2C.
RRn registers are defined at the offset 0x40 ~ 0x4C.
SR/CR registers are defined at 0x60/0x64.
Extend this driver to support it.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 45 +++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 25be8bb..eb55bbe 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -12,10 +12,14 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 
+#define MU_VER_ID_V1		0x0100
+
 /* Transmit Register */
 #define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
+#define IMX_MU_xTRn_V1(x)	(0x20 + 4 * (x))
 /* Receive Register */
 #define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
+#define IMX_MU_xRRn_V1(x)	(0x40 + 4 * (x))
 /* Status Register */
 #define IMX_MU_xSR		0x20
 #define IMX_MU_xSR_GIPn(x)	BIT(28 + (3 - (x)))
@@ -25,6 +29,7 @@
 
 /* Control Register */
 #define IMX_MU_xCR		0x24
+#define IMX_MU_xSCR_V1_OFFSET	0x40
 /* General Purpose Interrupt Enable */
 #define IMX_MU_xCR_GIEn(x)	BIT(28 + (3 - (x)))
 /* Receive Interrupt Enable */
@@ -63,6 +68,7 @@ struct imx_mu_priv {
 	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
 	struct clk		*clk;
 	int			irq;
+	int			version;
 
 	bool			side_b;
 };
@@ -85,13 +91,16 @@ static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
 static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
 {
 	unsigned long flags;
-	u32 val;
+	u32 val, offset;
+
+	offset = unlikely(priv->version == MU_VER_ID_V1) ?
+			IMX_MU_xSCR_V1_OFFSET : 0;
 
 	spin_lock_irqsave(&priv->xcr_lock, flags);
-	val = imx_mu_read(priv, IMX_MU_xCR);
+	val = imx_mu_read(priv, IMX_MU_xCR + offset);
 	val &= ~clr;
 	val |= set;
-	imx_mu_write(priv, val, IMX_MU_xCR);
+	imx_mu_write(priv, val, IMX_MU_xCR + offset);
 	spin_unlock_irqrestore(&priv->xcr_lock, flags);
 
 	return val;
@@ -109,10 +118,13 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	struct mbox_chan *chan = p;
 	struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
 	struct imx_mu_con_priv *cp = chan->con_priv;
-	u32 val, ctrl, dat;
+	u32 val, ctrl, dat, offset;
+
+	offset = unlikely(priv->version == MU_VER_ID_V1) ?
+			IMX_MU_xSCR_V1_OFFSET : 0;
 
-	ctrl = imx_mu_read(priv, IMX_MU_xCR);
-	val = imx_mu_read(priv, IMX_MU_xSR);
+	ctrl = imx_mu_read(priv, IMX_MU_xCR + offset);
+	val = imx_mu_read(priv, IMX_MU_xSR + offset);
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
@@ -138,10 +150,14 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
 		mbox_chan_txdone(chan, 0);
 	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
-		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
+		if (unlikely(priv->version == MU_VER_ID_V1))
+			dat = imx_mu_read(priv, IMX_MU_xRRn_V1(cp->idx));
+		else
+			dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
 		mbox_chan_received_data(chan, (void *)&dat);
 	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), IMX_MU_xSR);
+		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx),
+				IMX_MU_xSR + offset);
 		mbox_chan_received_data(chan, NULL);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
@@ -159,7 +175,10 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
+		if (unlikely(priv->version == MU_VER_ID_V1))
+			imx_mu_write(priv, *arg, IMX_MU_xTRn_V1(cp->idx));
+		else
+			imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
@@ -253,11 +272,17 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
 
 static void imx_mu_init_generic(struct imx_mu_priv *priv)
 {
+	u32 offset;
+
 	if (priv->side_b)
 		return;
 
+	priv->version = imx_mu_read(priv, 0) >> 16;
+	offset = unlikely(priv->version == MU_VER_ID_V1) ?
+			IMX_MU_xSCR_V1_OFFSET : 0;
+
 	/* Set default MU configuration */
-	imx_mu_write(priv, 0, IMX_MU_xCR);
+	imx_mu_write(priv, 0, IMX_MU_xCR + offset);
 }
 
 static int imx_mu_probe(struct platform_device *pdev)
-- 
2.7.4

