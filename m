Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48907C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8EA20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDIMJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58189 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:29 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 218B0E0016;
        Tue,  9 Apr 2019 12:09:24 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/5] usb: gadget: udc: lpc32xx: add support for stotg04 phy
Date:   Tue,  9 Apr 2019 14:09:07 +0200
Message-Id: <20190409120908.12079-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STOTG04 phy is used as a drop-in replacement of the ISP1301 but some
bits doesn't have exactly the same meaning and this can lead to issues.
Detect the phy dynamically and avoid writing to reserved bits.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 32 +++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 12f2d76e50fe..5d6246d23b99 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -115,6 +115,11 @@ struct lpc32xx_ep {
 	bool			wedge;
 };
 
+enum atx_type {
+	ISP1301,
+	STOTG04,
+};
+
 /*
  * Common UDC structure
  */
@@ -149,6 +154,7 @@ struct lpc32xx_udc {
 	u8			last_vbus;
 	int			pullup;
 	int			poweron;
+	enum atx_type		atx;
 
 	/* Work queues related to I2C support */
 	struct work_struct	pullup_job;
@@ -550,6 +556,15 @@ static inline void remove_debug_file(struct lpc32xx_udc *udc) {}
 /* Primary initialization sequence for the ISP1301 transceiver */
 static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 {
+	u8 value;
+	s32 vendor, product;
+
+	vendor = i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x00);
+	product = i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x02);
+
+	if (vendor == 0x0483 && product == 0xa0c4)
+		udc->atx = STOTG04;
+
 	/* LPC32XX only supports DAT_SE0 USB mode */
 	/* This sequence is important */
 
@@ -569,8 +584,12 @@ static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 	 */
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		(ISP1301_I2C_MODE_CONTROL_2 | ISP1301_I2C_REG_CLEAR_ADDR), ~0);
+
+	value = MC2_BI_DI;
+	if (udc->atx != STOTG04)
+		value |= MC2_SPD_SUSP_CTRL;
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
-		ISP1301_I2C_MODE_CONTROL_2, (MC2_BI_DI | MC2_SPD_SUSP_CTRL));
+		ISP1301_I2C_MODE_CONTROL_2, value);
 
 	/* Driver VBUS_DRV high or low depending on board setup */
 	if (udc->board->vbus_drv_pol != 0)
@@ -610,12 +629,11 @@ static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_RISING, INT_SESS_VLD | INT_VBUS_VLD);
 
-	dev_info(udc->dev, "ISP1301 Vendor ID  : 0x%04x\n",
-		 i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x00));
-	dev_info(udc->dev, "ISP1301 Product ID : 0x%04x\n",
-		 i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x02));
+	dev_info(udc->dev, "ISP1301 Vendor ID  : 0x%04x\n", vendor);
+	dev_info(udc->dev, "ISP1301 Product ID : 0x%04x\n", product);
 	dev_info(udc->dev, "ISP1301 Version ID : 0x%04x\n",
 		 i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x14));
+
 }
 
 /* Enables or disables the USB device pullup via the ISP1301 transceiver */
@@ -658,6 +676,10 @@ static void isp1301_pullup_enable(struct lpc32xx_udc *udc, int en_pullup,
 /* Powers up or down the ISP1301 transceiver */
 static void isp1301_set_powerstate(struct lpc32xx_udc *udc, int enable)
 {
+	/* There is no "global power down" register for stotg04 */
+	if (udc->atx == STOTG04)
+		return;
+
 	if (enable != 0)
 		/* Power up ISP1301 - this ISP1301 will automatically wakeup
 		   when VBUS is detected */
-- 
2.20.1

