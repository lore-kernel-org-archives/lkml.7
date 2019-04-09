Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC6CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC13920880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfDIMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:24 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43539 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDIMJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:22 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 542D820015;
        Tue,  9 Apr 2019 12:09:18 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] usb: gadget: udc: lpc32xx: simplify probe
Date:   Tue,  9 Apr 2019 14:09:04 +0200
Message-Id: <20190409120908.12079-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
References: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify .probe and .remove by using devm managed allocations and requests.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 93 ++++++++--------------------
 1 file changed, 25 insertions(+), 68 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index b0781771704e..5546cb509085 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -129,8 +129,6 @@ struct lpc32xx_udc {
 
 	/* Board and device specific */
 	struct lpc32xx_usbd_cfg	*board;
-	u32			io_p_start;
-	u32			io_p_size;
 	void __iomem		*udp_baseaddr;
 	int			udp_irq[4];
 	struct clk		*usb_slv_clk;
@@ -2999,7 +2997,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	dma_addr_t dma_handle;
 	struct device_node *isp1301_node;
 
-	udc = kmemdup(&controller_template, sizeof(*udc), GFP_KERNEL);
+	udc = devm_kmemdup(dev, &controller_template, sizeof(*udc), GFP_KERNEL);
 	if (!udc)
 		return -ENOMEM;
 
@@ -3022,8 +3020,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 
 	udc->isp1301_i2c_client = isp1301_get_client(isp1301_node);
 	if (!udc->isp1301_i2c_client) {
-		retval = -EPROBE_DEFER;
-		goto phy_fail;
+		return -EPROBE_DEFER;
 	}
 
 	dev_info(udc->dev, "ISP1301 I2C device at address 0x%x\n",
@@ -3032,7 +3029,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
 	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval)
-		goto resource_fail;
+		return retval;
 
 	udc->board = &lpc32xx_usbddata;
 
@@ -3045,10 +3042,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	 *  IORESOURCE_IRQ, USB transceiver interrupt number
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		retval = -ENXIO;
-		goto resource_fail;
-	}
+	if (!res)
+		return -ENXIO;
 
 	spin_lock_init(&udc->lock);
 
@@ -3058,39 +3053,28 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 		if (udc->udp_irq[i] < 0) {
 			dev_err(udc->dev,
 				"irq resource %d not available!\n", i);
-			retval = udc->udp_irq[i];
-			goto irq_fail;
+			return udc->udp_irq[i];
 		}
 	}
 
-	udc->io_p_start = res->start;
-	udc->io_p_size = resource_size(res);
-	if (!request_mem_region(udc->io_p_start, udc->io_p_size, driver_name)) {
-		dev_err(udc->dev, "someone's using UDC memory\n");
-		retval = -EBUSY;
-		goto request_mem_region_fail;
-	}
-
-	udc->udp_baseaddr = ioremap(udc->io_p_start, udc->io_p_size);
+	udc->udp_baseaddr = devm_ioremap_resource(dev, res);
 	if (!udc->udp_baseaddr) {
-		retval = -ENOMEM;
 		dev_err(udc->dev, "IO map failure\n");
-		goto io_map_fail;
+		return -ENOMEM;
 	}
 
 	/* Get USB device clock */
-	udc->usb_slv_clk = clk_get(&pdev->dev, NULL);
+	udc->usb_slv_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(udc->usb_slv_clk)) {
 		dev_err(udc->dev, "failed to acquire USB device clock\n");
-		retval = PTR_ERR(udc->usb_slv_clk);
-		goto usb_clk_get_fail;
+		return PTR_ERR(udc->usb_slv_clk);
 	}
 
 	/* Enable USB device clock */
 	retval = clk_prepare_enable(udc->usb_slv_clk);
 	if (retval < 0) {
 		dev_err(udc->dev, "failed to start USB device clock\n");
-		goto usb_clk_enable_fail;
+		return retval;
 	}
 
 	/* Setup deferred workqueue data */
@@ -3134,37 +3118,37 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 
 	/* Request IRQs - low and high priority USB device IRQs are routed to
 	 * the same handler, while the DMA interrupt is routed elsewhere */
-	retval = request_irq(udc->udp_irq[IRQ_USB_LP], lpc32xx_usb_lp_irq,
-			     0, "udc_lp", udc);
+	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_LP],
+				  lpc32xx_usb_lp_irq, 0, "udc_lp", udc);
 	if (retval < 0) {
 		dev_err(udc->dev, "LP request irq %d failed\n",
 			udc->udp_irq[IRQ_USB_LP]);
-		goto irq_lp_fail;
+		goto irq_req_fail;
 	}
-	retval = request_irq(udc->udp_irq[IRQ_USB_HP], lpc32xx_usb_hp_irq,
-			     0, "udc_hp", udc);
+	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_HP],
+				  lpc32xx_usb_hp_irq, 0, "udc_hp", udc);
 	if (retval < 0) {
 		dev_err(udc->dev, "HP request irq %d failed\n",
 			udc->udp_irq[IRQ_USB_HP]);
-		goto irq_hp_fail;
+		goto irq_req_fail;
 	}
 
-	retval = request_irq(udc->udp_irq[IRQ_USB_DEVDMA],
-			     lpc32xx_usb_devdma_irq, 0, "udc_dma", udc);
+	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_DEVDMA],
+				  lpc32xx_usb_devdma_irq, 0, "udc_dma", udc);
 	if (retval < 0) {
 		dev_err(udc->dev, "DEV request irq %d failed\n",
 			udc->udp_irq[IRQ_USB_DEVDMA]);
-		goto irq_dev_fail;
+		goto irq_req_fail;
 	}
 
 	/* The transceiver interrupt is used for VBUS detection and will
 	   kick off the VBUS handler function */
-	retval = request_irq(udc->udp_irq[IRQ_USB_ATX], lpc32xx_usb_vbus_irq,
-			     0, "udc_otg", udc);
+	retval = devm_request_irq(dev, udc->udp_irq[IRQ_USB_ATX],
+				  lpc32xx_usb_vbus_irq, 0, "udc_otg", udc);
 	if (retval < 0) {
 		dev_err(udc->dev, "VBUS request irq %d failed\n",
 			udc->udp_irq[IRQ_USB_ATX]);
-		goto irq_xcvr_fail;
+		goto irq_req_fail;
 	}
 
 	/* Initialize wait queue */
@@ -3190,32 +3174,15 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	return 0;
 
 add_gadget_fail:
-	free_irq(udc->udp_irq[IRQ_USB_ATX], udc);
-irq_xcvr_fail:
-	free_irq(udc->udp_irq[IRQ_USB_DEVDMA], udc);
-irq_dev_fail:
-	free_irq(udc->udp_irq[IRQ_USB_HP], udc);
-irq_hp_fail:
-	free_irq(udc->udp_irq[IRQ_USB_LP], udc);
-irq_lp_fail:
+irq_req_fail:
 	dma_pool_destroy(udc->dd_cache);
 dma_alloc_fail:
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
 i2c_fail:
 	clk_disable_unprepare(udc->usb_slv_clk);
-usb_clk_enable_fail:
-	clk_put(udc->usb_slv_clk);
-usb_clk_get_fail:
-	iounmap(udc->udp_baseaddr);
-io_map_fail:
-	release_mem_region(udc->io_p_start, udc->io_p_size);
 	dev_err(udc->dev, "%s probe failed, %d\n", driver_name, retval);
-request_mem_region_fail:
-irq_fail:
-resource_fail:
-phy_fail:
-	kfree(udc);
+
 	return retval;
 }
 
@@ -3231,24 +3198,14 @@ static int lpc32xx_udc_remove(struct platform_device *pdev)
 	udc_disable(udc);
 	pullup(udc, 0);
 
-	free_irq(udc->udp_irq[IRQ_USB_ATX], udc);
-
 	device_init_wakeup(&pdev->dev, 0);
 	remove_debug_file(udc);
 
 	dma_pool_destroy(udc->dd_cache);
 	dma_free_coherent(&pdev->dev, UDCA_BUFF_SIZE,
 			  udc->udca_v_base, udc->udca_p_base);
-	free_irq(udc->udp_irq[IRQ_USB_DEVDMA], udc);
-	free_irq(udc->udp_irq[IRQ_USB_HP], udc);
-	free_irq(udc->udp_irq[IRQ_USB_LP], udc);
 
 	clk_disable_unprepare(udc->usb_slv_clk);
-	clk_put(udc->usb_slv_clk);
-
-	iounmap(udc->udp_baseaddr);
-	release_mem_region(udc->io_p_start, udc->io_p_size);
-	kfree(udc);
 
 	return 0;
 }
-- 
2.20.1

