Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C6FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AEB2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDCMlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:41:25 -0400
Received: from sauhun.de ([88.99.104.3]:48360 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDCMkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:40:40 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id C022E3E43CD;
        Wed,  3 Apr 2019 14:40:37 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 06/12] i2c: omap: Add the master_xfer_irqless hook
Date:   Wed,  3 Apr 2019 14:40:13 +0200
Message-Id: <20190403124019.8947-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the master_xfer_irqless hook to enable i2c transactions
in irq disabled contexts like the poweroff case.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
[wsa: simplified code a little: 'timeout = !ret']
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-omap.c | 76 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cd9c65f3d404..faa0394048a0 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -269,6 +269,8 @@ static const u8 reg_map_ip_v2[] = {
 	[OMAP_I2C_IP_V2_IRQENABLE_CLR] = 0x30,
 };
 
+static int omap_i2c_xfer_data(struct omap_i2c_dev *omap);
+
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *omap,
 				      int reg, u16 val)
 {
@@ -648,15 +650,28 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *omap, u8 size, bool is_rx)
 			(1000 * omap->speed / 8);
 }
 
+static void omap_i2c_wait(struct omap_i2c_dev *omap)
+{
+	u16 stat;
+	u16 mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	int count = 0;
+
+	do {
+		stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
+		count++;
+	} while (!(stat & mask) && count < 5);
+}
+
 /*
  * Low level master read/write transaction.
  */
 static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
-			     struct i2c_msg *msg, int stop)
+			     struct i2c_msg *msg, int stop, bool polling)
 {
 	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	unsigned long timeout;
 	u16 w;
+	int ret;
 
 	dev_dbg(omap->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
@@ -680,7 +695,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
 	omap_i2c_write_reg(omap, OMAP_I2C_BUF_REG, w);
 
-	reinit_completion(&omap->cmd_complete);
+	if (!polling)
+		reinit_completion(&omap->cmd_complete);
 	omap->cmd_err = 0;
 
 	w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
@@ -732,8 +748,18 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
-	timeout = wait_for_completion_timeout(&omap->cmd_complete,
-						OMAP_I2C_TIMEOUT);
+	if (!polling) {
+		timeout = wait_for_completion_timeout(&omap->cmd_complete,
+						      OMAP_I2C_TIMEOUT);
+	} else {
+		do {
+			omap_i2c_wait(omap);
+			ret = omap_i2c_xfer_data(omap);
+		} while (ret == -EAGAIN);
+
+		timeout = !ret;
+	}
+
 	if (timeout == 0) {
 		dev_err(omap->dev, "controller timed out\n");
 		omap_i2c_reset(omap);
@@ -772,7 +798,8 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
  * to do the work during IRQ processing.
  */
 static int
-omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+omap_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg msgs[], int num,
+		     bool polling)
 {
 	struct omap_i2c_dev *omap = i2c_get_adapdata(adap);
 	int i;
@@ -794,7 +821,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		omap->set_mpu_wkup_lat(omap->dev, omap->latency);
 
 	for (i = 0; i < num; i++) {
-		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
+		r = omap_i2c_xfer_msg(adap, &msgs[i], (i == (num - 1)),
+				      polling);
 		if (r != 0)
 			break;
 	}
@@ -813,6 +841,18 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	return r;
 }
 
+static int
+omap_i2c_xfer_irq(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	return omap_i2c_xfer_common(adap, msgs, num, false);
+}
+
+static int
+omap_i2c_xfer_polling(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	return omap_i2c_xfer_common(adap, msgs, num, true);
+}
+
 static u32
 omap_i2c_func(struct i2c_adapter *adap)
 {
@@ -1035,10 +1075,8 @@ omap_i2c_isr(int irq, void *dev_id)
 	return ret;
 }
 
-static irqreturn_t
-omap_i2c_isr_thread(int this_irq, void *dev_id)
+static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 {
-	struct omap_i2c_dev *omap = dev_id;
 	u16 bits;
 	u16 stat;
 	int err = 0, count = 0;
@@ -1056,7 +1094,8 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 
 		if (!stat) {
 			/* my work here is done */
-			goto out;
+			err = -EAGAIN;
+			break;
 		}
 
 		dev_dbg(omap->dev, "IRQ (ISR = 0x%04x)\n", stat);
@@ -1165,14 +1204,25 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		}
 	} while (stat);
 
-	omap_i2c_complete_cmd(omap, err);
+	return err;
+}
+
+static irqreturn_t
+omap_i2c_isr_thread(int this_irq, void *dev_id)
+{
+	int ret;
+	struct omap_i2c_dev *omap = dev_id;
+
+	ret = omap_i2c_xfer_data(omap);
+	if (ret != -EAGAIN)
+		omap_i2c_complete_cmd(omap, ret);
 
-out:
 	return IRQ_HANDLED;
 }
 
 static const struct i2c_algorithm omap_i2c_algo = {
-	.master_xfer	= omap_i2c_xfer,
+	.master_xfer	= omap_i2c_xfer_irq,
+	.master_xfer_atomic	= omap_i2c_xfer_polling,
 	.functionality	= omap_i2c_func,
 };
 
-- 
2.11.0

