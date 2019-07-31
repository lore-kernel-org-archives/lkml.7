Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219DDC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E668A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfGaJOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:14:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48470 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfGaJOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:14:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B9A0200959;
        Wed, 31 Jul 2019 11:14:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 56F3620093B;
        Wed, 31 Jul 2019 11:14:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AF014402F2;
        Wed, 31 Jul 2019 17:14:04 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3] mailbox: imx: add support for imx v1 mu
Date:   Wed, 31 Jul 2019 16:51:47 +0800
Message-Id: <1564563107-23736-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a version1.0 MU on i.MX7ULP platform.
One new version ID register is added, and it's offset is 0.
TRn registers are defined at the offset 0x20 ~ 0x2C.
RRn registers are defined at the offset 0x40 ~ 0x4C.
SR/CR registers are defined at 0x60/0x64.
Extend this driver to support it.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Change logs:

v2 --> v3:
  - Format the patch-set refer to Oleksij's guidance.
  - Init the register array by a simple way recommended by Oleksij.
  - Add Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de> tag.

v1 --> v2:
  - Use to have the register layout linked on probe, suggested by
  Oleksij Rempel <o.rempel@pengutronix.de>.
  - Add Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com> tag.


Richard Zhu (1):
  mailbox: imx: add support for imx v1 mu

 drivers/mailbox/imx-mailbox.c | 55 ++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 25be8bb..c81be1c 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -12,19 +12,11 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 
-/* Transmit Register */
-#define IMX_MU_xTRn(x)		(0x00 + 4 * (x))
-/* Receive Register */
-#define IMX_MU_xRRn(x)		(0x10 + 4 * (x))
-/* Status Register */
-#define IMX_MU_xSR		0x20
 #define IMX_MU_xSR_GIPn(x)	BIT(28 + (3 - (x)))
 #define IMX_MU_xSR_RFn(x)	BIT(24 + (3 - (x)))
 #define IMX_MU_xSR_TEn(x)	BIT(20 + (3 - (x)))
 #define IMX_MU_xSR_BRDIP	BIT(9)
 
-/* Control Register */
-#define IMX_MU_xCR		0x24
 /* General Purpose Interrupt Enable */
 #define IMX_MU_xCR_GIEn(x)	BIT(28 + (3 - (x)))
 /* Receive Interrupt Enable */
@@ -44,6 +36,13 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
 };
 
+struct imx_mu_dcfg {
+	u32	xTR[4];		/* Transmit Registers */
+	u32	xRR[4];		/* Receive Registers */
+	u32	xSR;		/* Status Register */
+	u32	xCR;		/* Control Register */
+};
+
 struct imx_mu_con_priv {
 	unsigned int		idx;
 	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
@@ -61,12 +60,27 @@ struct imx_mu_priv {
 	struct mbox_chan	mbox_chans[IMX_MU_CHANS];
 
 	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+	const struct imx_mu_dcfg	*dcfg;
 	struct clk		*clk;
 	int			irq;
 
 	bool			side_b;
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
+	.xTR	= {0x0, 0x4, 0x8, 0xc},
+	.xRR	= {0x10, 0x14, 0x18, 0x1c},
+	.xSR	= 0x20,
+	.xCR	= 0x24,
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
+	.xTR	= {0x20, 0x24, 0x28, 0x2c},
+	.xRR	= {0x40, 0x44, 0x48, 0x4c},
+	.xSR	= 0x60,
+	.xCR	= 0x64,
+};
+
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
 {
 	return container_of(mbox, struct imx_mu_priv, mbox);
@@ -88,10 +102,10 @@ static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
 	u32 val;
 
 	spin_lock_irqsave(&priv->xcr_lock, flags);
-	val = imx_mu_read(priv, IMX_MU_xCR);
+	val = imx_mu_read(priv, priv->dcfg->xCR);
 	val &= ~clr;
 	val |= set;
-	imx_mu_write(priv, val, IMX_MU_xCR);
+	imx_mu_write(priv, val, priv->dcfg->xCR);
 	spin_unlock_irqrestore(&priv->xcr_lock, flags);
 
 	return val;
@@ -111,8 +125,8 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	struct imx_mu_con_priv *cp = chan->con_priv;
 	u32 val, ctrl, dat;
 
-	ctrl = imx_mu_read(priv, IMX_MU_xCR);
-	val = imx_mu_read(priv, IMX_MU_xSR);
+	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
+	val = imx_mu_read(priv, priv->dcfg->xSR);
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
@@ -138,10 +152,10 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
 		mbox_chan_txdone(chan, 0);
 	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
-		dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
+		dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
 		mbox_chan_received_data(chan, (void *)&dat);
 	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), IMX_MU_xSR);
+		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
 		mbox_chan_received_data(chan, NULL);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
@@ -159,7 +173,7 @@ static int imx_mu_send_data(struct mbox_chan *chan, void *data)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
+		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
@@ -257,7 +271,7 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 		return;
 
 	/* Set default MU configuration */
-	imx_mu_write(priv, 0, IMX_MU_xCR);
+	imx_mu_write(priv, 0, priv->dcfg->xCR);
 }
 
 static int imx_mu_probe(struct platform_device *pdev)
@@ -265,6 +279,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct imx_mu_priv *priv;
+	const struct imx_mu_dcfg *dcfg;
 	unsigned int i;
 	int ret;
 
@@ -282,6 +297,11 @@ static int imx_mu_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	dcfg = of_device_get_match_data(dev);
+	if (!dcfg)
+		return -EINVAL;
+	priv->dcfg = dcfg;
+
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		if (PTR_ERR(priv->clk) != -ENOENT)
@@ -335,7 +355,8 @@ static int imx_mu_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_mu_dt_ids[] = {
-	{ .compatible = "fsl,imx6sx-mu" },
+	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
+	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
-- 
2.7.4

