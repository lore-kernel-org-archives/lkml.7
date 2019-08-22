Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A9C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C8D23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfHVHC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:02:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731985AbfHVHC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:02:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DBFF3A7227D4AE8C8C53;
        Thu, 22 Aug 2019 15:02:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 22 Aug 2019 15:02:12 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>, <vz@mleia.com>,
        <slemieux.tyco@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] usb: udc: lpc32xx: remove set but not used 3 variables
Date:   Thu, 22 Aug 2019 15:05:57 +0800
Message-ID: <20190822070557.74874-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:
drivers/usb/gadget/udc/lpc32xx_udc.c: In function ‘udc_protocol_cmd_r’:
drivers/usb/gadget/udc/lpc32xx_udc.c:744:6: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

drivers/usb/gadget/udc/lpc32xx_udc.c: In function ‘udc_handle_dma_ep’:
drivers/usb/gadget/udc/lpc32xx_udc.c:1994:14: warning: variable ‘epstatus’ set but not used [-Wunused-but-set-variable]

drivers/usb/gadget/udc/lpc32xx_udc.c: In function ‘udc_handle_ep0_setup’:
drivers/usb/gadget/udc/lpc32xx_udc.c:2200:22: warning: variable ‘wLength’ set but not used [-Wunused-but-set-variable]

It is not used since commit 90fccb529d24 ("usb: gadget: Gadget directory cleanup - group UDC drivers")

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/usb/gadget/udc/lpc32xx_udc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 606c8bc..b3e073f 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -741,7 +741,6 @@ static inline void udc_protocol_cmd_data_w(struct lpc32xx_udc *udc, u32 cmd,
  * response data */
 static u32 udc_protocol_cmd_r(struct lpc32xx_udc *udc, u32 cmd)
 {
-	u32 tmp;
 	int to = 1000;
 
 	/* Write a command and read data from the protocol engine */
@@ -751,7 +750,6 @@ static u32 udc_protocol_cmd_r(struct lpc32xx_udc *udc, u32 cmd)
 	/* Write command code */
 	udc_protocol_cmd_w(udc, cmd);
 
-	tmp = readl(USBD_DEVINTST(udc->udp_baseaddr));
 	while ((!(readl(USBD_DEVINTST(udc->udp_baseaddr)) & USBD_CDFULL))
 	       && (to > 0))
 		to--;
@@ -1991,7 +1989,7 @@ void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 /* DMA end of transfer completion */
 static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 {
-	u32 status, epstatus;
+	u32 status;
 	struct lpc32xx_request *req;
 	struct lpc32xx_usbd_dd_gad *dd;
 
@@ -2085,7 +2083,7 @@ static void udc_handle_dma_ep(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
 		if (udc_clearep_getsts(udc, ep->hwep_num) & EP_SEL_F) {
 			udc_clearep_getsts(udc, ep->hwep_num);
 			uda_enable_hwepint(udc, ep->hwep_num);
-			epstatus = udc_clearep_getsts(udc, ep->hwep_num);
+			udc_clearep_getsts(udc, ep->hwep_num);
 
 			/* Let the EP interrupt handle the ZLP */
 			return;
@@ -2197,7 +2195,7 @@ static void udc_handle_ep0_setup(struct lpc32xx_udc *udc)
 	struct lpc32xx_ep *ep, *ep0 = &udc->ep[0];
 	struct usb_ctrlrequest ctrlpkt;
 	int i, bytes;
-	u16 wIndex, wValue, wLength, reqtype, req, tmp;
+	u16 wIndex, wValue, reqtype, req, tmp;
 
 	/* Nuke previous transfers */
 	nuke(ep0, -EPROTO);
@@ -2213,7 +2211,6 @@ static void udc_handle_ep0_setup(struct lpc32xx_udc *udc)
 	/* Native endianness */
 	wIndex = le16_to_cpu(ctrlpkt.wIndex);
 	wValue = le16_to_cpu(ctrlpkt.wValue);
-	wLength = le16_to_cpu(ctrlpkt.wLength);
 	reqtype = le16_to_cpu(ctrlpkt.bRequestType);
 
 	/* Set direction of EP0 */
-- 
2.7.4

