Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C429C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5876320880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDIMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:36 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43739 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:34 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C988620003;
        Tue,  9 Apr 2019 12:09:30 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] usb: gadget: udc: lpc32xx: rework interrupt handling
Date:   Tue,  9 Apr 2019 14:09:08 +0200
Message-Id: <20190409120908.12079-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no actual need to do the enable/disable_irq dance. Instead enable
the interrupts on the phy only when necessary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 29 ++++++++++------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5d6246d23b99..d8f1c60793ed 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -617,17 +617,13 @@ static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 		(ISP1301_I2C_OTG_CONTROL_1 | ISP1301_I2C_REG_CLEAR_ADDR),
 		OTG1_VBUS_DISCHRG);
 
-	/* Clear and enable VBUS high edge interrupt */
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_LATCH | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
+
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_FALLING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
-	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
-		ISP1301_I2C_INTERRUPT_FALLING, INT_SESS_VLD | INT_VBUS_VLD);
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
-	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
-		ISP1301_I2C_INTERRUPT_RISING, INT_SESS_VLD | INT_VBUS_VLD);
 
 	dev_info(udc->dev, "ISP1301 Vendor ID  : 0x%04x\n", vendor);
 	dev_info(udc->dev, "ISP1301 Product ID : 0x%04x\n", product);
@@ -2887,9 +2883,6 @@ static void vbus_work(struct lpc32xx_udc *udc)
 			lpc32xx_vbus_session(&udc->gadget, udc->vbus);
 		}
 	}
-
-	/* Re-enable after completion */
-	enable_irq(udc->udp_irq[IRQ_USB_ATX]);
 }
 
 static irqreturn_t lpc32xx_usb_vbus_irq(int irq, void *_udc)
@@ -2905,7 +2898,6 @@ static int lpc32xx_start(struct usb_gadget *gadget,
 			 struct usb_gadget_driver *driver)
 {
 	struct lpc32xx_udc *udc = to_udc(gadget);
-	int i;
 
 	if (!driver || driver->max_speed < USB_SPEED_FULL || !driver->setup) {
 		dev_err(udc->dev, "bad parameter.\n");
@@ -2927,20 +2919,23 @@ static int lpc32xx_start(struct usb_gadget *gadget,
 	udc->last_vbus = udc->vbus = 0;
 	vbus_work(udc);
 
-	/* Do not re-enable ATX IRQ (3) */
-	for (i = IRQ_USB_LP; i < IRQ_USB_ATX; i++)
-		enable_irq(udc->udp_irq[i]);
+	/* enable interrupts */
+	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
+		ISP1301_I2C_INTERRUPT_FALLING, INT_SESS_VLD | INT_VBUS_VLD);
+	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
+		ISP1301_I2C_INTERRUPT_RISING, INT_SESS_VLD | INT_VBUS_VLD);
 
 	return 0;
 }
 
 static int lpc32xx_stop(struct usb_gadget *gadget)
 {
-	int i;
 	struct lpc32xx_udc *udc = to_udc(gadget);
 
-	for (i = IRQ_USB_LP; i <= IRQ_USB_ATX; i++)
-		disable_irq(udc->udp_irq[i]);
+	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
+		ISP1301_I2C_INTERRUPT_FALLING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
+	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
+		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
 
 	if (udc->clocked) {
 		spin_lock(&udc->lock);
@@ -3172,10 +3167,6 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	init_waitqueue_head(&udc->ep_disable_wait_queue);
 	atomic_set(&udc->enabled_ep_cnt, 0);
 
-	/* Keep all IRQs disabled until GadgetFS starts up */
-	for (i = IRQ_USB_LP; i <= IRQ_USB_ATX; i++)
-		disable_irq(udc->udp_irq[i]);
-
 	retval = usb_add_gadget_udc(dev, &udc->gadget);
 	if (retval < 0)
 		goto add_gadget_fail;
-- 
2.20.1

