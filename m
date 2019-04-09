Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C64C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E84D20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDIMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:26 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60749 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:22 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5550D1BF210;
        Tue,  9 Apr 2019 12:09:20 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/5] usb: gadget: udc: lpc32xx: simplify vbus handling
Date:   Tue,  9 Apr 2019 14:09:05 +0200
Message-Id: <20190409120908.12079-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a threaded IRQ to handle vbus_work instead of using the global
worqueue.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5546cb509085..777279fa4637 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -152,7 +152,6 @@ struct lpc32xx_udc {
 
 	/* Work queues related to I2C support */
 	struct work_struct	pullup_job;
-	struct work_struct	vbus_job;
 	struct work_struct	power_job;
 
 	/* USB device peripheral - various */
@@ -2828,11 +2827,9 @@ static irqreturn_t lpc32xx_usb_devdma_irq(int irq, void *_udc)
  * VBUS detection, pullup handler, and Gadget cable state notification
  *
  */
-static void vbus_work(struct work_struct *work)
+static void vbus_work(struct lpc32xx_udc *udc)
 {
 	u8 value;
-	struct lpc32xx_udc *udc = container_of(work, struct lpc32xx_udc,
-					       vbus_job);
 
 	if (udc->enabled != 0) {
 		/* Discharge VBUS real quick */
@@ -2877,9 +2874,7 @@ static irqreturn_t lpc32xx_usb_vbus_irq(int irq, void *_udc)
 {
 	struct lpc32xx_udc *udc = _udc;
 
-	/* Defer handling of VBUS IRQ to work queue */
-	disable_irq_nosync(udc->udp_irq[IRQ_USB_ATX]);
-	schedule_work(&udc->vbus_job);
+	vbus_work(udc);
 
 	return IRQ_HANDLED;
 }
@@ -2908,7 +2903,7 @@ static int lpc32xx_start(struct usb_gadget *gadget,
 
 	/* Force VBUS process once to check for cable insertion */
 	udc->last_vbus = udc->vbus = 0;
-	schedule_work(&udc->vbus_job);
+	vbus_work(udc);
 
 	/* Do not re-enable ATX IRQ (3) */
 	for (i = IRQ_USB_LP; i < IRQ_USB_ATX; i++)
@@ -3080,7 +3075,6 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	/* Setup deferred workqueue data */
 	udc->poweron = udc->pullup = 0;
 	INIT_WORK(&udc->pullup_job, pullup_work);
-	INIT_WORK(&udc->vbus_job, vbus_work);
 #ifdef CONFIG_PM
 	INIT_WORK(&udc->power_job, power_work);
 #endif
@@ -3143,8 +3137,9 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 
 	/* The transceiver interrupt is used for VBUS detection and will
 	   kick off the VBUS handler function */
-	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_ATX],
-				  lpc32xx_usb_vbus_irq, 0, "udc_otg", udc);
+	retval = devm_request_threaded_irq(dev, udc->udp_irq[IRQ_USB_ATX], NULL,
+					   lpc32xx_usb_vbus_irq, IRQF_ONESHOT,
+					   "udc_otg", udc);
 	if (retval < 0) {
 		dev_err(udc->dev, "VBUS request irq %d failed\n",
 			udc->udp_irq[IRQ_USB_ATX]);
-- 
2.20.1

