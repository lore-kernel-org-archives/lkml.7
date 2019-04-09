Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D954C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4860A21841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfDIMJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:43 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52355 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfDIMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:24 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E318E2001A;
        Tue,  9 Apr 2019 12:09:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/5] usb: gadget: udc: lpc32xx: properly setup phy interrupts
Date:   Tue,  9 Apr 2019 14:09:06 +0200
Message-Id: <20190409120908.12079-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only INT_VBUS_VLD is set to generate ATX interrupts on the phy but
INT_SESS_VLD is checked in vbus_work. This leads to cases where
hot-plugging USB doesn't work after boot.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 777279fa4637..12f2d76e50fe 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -604,11 +604,11 @@ static void isp1301_udc_configure(struct lpc32xx_udc *udc)
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_FALLING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
-		ISP1301_I2C_INTERRUPT_FALLING, INT_VBUS_VLD);
+		ISP1301_I2C_INTERRUPT_FALLING, INT_SESS_VLD | INT_VBUS_VLD);
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
 		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
 	i2c_smbus_write_byte_data(udc->isp1301_i2c_client,
-		ISP1301_I2C_INTERRUPT_RISING, INT_VBUS_VLD);
+		ISP1301_I2C_INTERRUPT_RISING, INT_SESS_VLD | INT_VBUS_VLD);
 
 	dev_info(udc->dev, "ISP1301 Vendor ID  : 0x%04x\n",
 		 i2c_smbus_read_word_data(udc->isp1301_i2c_client, 0x00));
-- 
2.20.1

