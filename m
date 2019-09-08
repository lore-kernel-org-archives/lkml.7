Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5C8C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6F214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4BAQw3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfIHRxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 13:53:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44419 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbfIHRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:53:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so5500344pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8hexIeF0LOmscVfTQjmfddiTigHgr4BlT+skvWAN1Og=;
        b=G4BAQw3j0GQQWbsKVWhroLRFnzED0L7Hw7dC29djQ7/plisprtGUDWFf6giaWtEsB+
         27llYDLeYzY5iHGp6eEcEA5puGTRR+6nmSgiLXHEjEj/Ta+SYd6slK4PmSbCXTbTLqhL
         +rW29QcdmAPeDGshPk77wZwN9tf2yHzwtIhRumv94LtUreB0C6e1wLMbqKci6sszJVqU
         x/AO7DadrIk4S95DoRfphgLIufpkQIuXqj33vWf9lHD00AZh4X0ju/PtZ1L6oBA29sSy
         GLeukWrJRIvddTKjFxIDjpaK9ryBSpXonTXM/cJr58kpZ4y0McFhKdpFDvQmyEDetZAh
         Ce6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8hexIeF0LOmscVfTQjmfddiTigHgr4BlT+skvWAN1Og=;
        b=uKZFcvDtNjfdmjiXuSYSpr5AWzcx6RXFU2AHfcV6wrzg19TTushHRuGijU+XGIyGmA
         OmZK/YqmYcvaXsyM6RUKajSG4y1LLQEgeowVWNSh0pLHViF+9JwKBZUOiiYnTlffIijR
         9onecGD2q2C2Kt/OBeWJCFx4HtIwDRTkeE/rtZuFRb6PCadi1ebCUpGAt/Gg0B2/wWzk
         cxzUZhb0UPPD8qhmBTDDh33lCPSJAS0hcrtHShj2g7bWR+KxGx01bxc5P2M+5UgxKcO/
         P8E28CS86P2X534GZGOEgRvCspDCn1vvflvx0thLrxTUMSeaer3G5wDXwDA7Wwn7q7FW
         /qOQ==
X-Gm-Message-State: APjAAAV/YiOVwZqoX7BRIbqgZfcZSpON8Ozr2s6Yji8wHEQ/2fXwPaZx
        wVFZptCqGfdXPvQomwRxQ6M7snS5
X-Google-Smtp-Source: APXvYqzqPIZIJb6BMRx8A/L2DiNdq6VgyduGMU067Pq8bO65Tzl1I/l7d3t9LNz6/nnTUOIQrupbZg==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr20584679plb.320.1567965183315;
        Sun, 08 Sep 2019 10:53:03 -0700 (PDT)
Received: from SD ([106.222.6.141])
        by smtp.gmail.com with ESMTPSA id 185sm14038434pfd.125.2019.09.08.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 10:53:02 -0700 (PDT)
Date:   Sun, 8 Sep 2019 23:22:47 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: emxx_udc: remove local TRUE/FALSE definition
Message-ID: <20190908175247.GA20699@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the function argument and variables are defined as type 'bool',
remove local TRUE/FALSE define and change usage of those macros
with boolean value.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 76 ++++++++++++++---------------
 drivers/staging/emxx_udc/emxx_udc.h |  5 --
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 489cde4e915e..147481bf680c 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -165,7 +165,7 @@ static void _nbu2ss_create_ep0_packet(struct nbu2ss_udc *udc,
 	udc->ep0_req.req.buf		= p_buf;
 	udc->ep0_req.req.length		= length;
 	udc->ep0_req.req.dma		= 0;
-	udc->ep0_req.req.zero		= TRUE;
+	udc->ep0_req.req.zero		= true;
 	udc->ep0_req.req.complete	= _nbu2ss_ep0_complete;
 	udc->ep0_req.req.status		= -EINPROGRESS;
 	udc->ep0_req.req.context	= udc;
@@ -668,7 +668,7 @@ static int _nbu2ss_ep0_in_transfer(struct nbu2ss_udc *udc,
 		if ((req->req.actual % EP0_PACKETSIZE) == 0) {
 			if (req->zero) {
 				req->zero = false;
-				EP0_send_NULL(udc, FALSE);
+				EP0_send_NULL(udc, false);
 				return 1;
 			}
 		}
@@ -695,7 +695,7 @@ static int _nbu2ss_ep0_in_transfer(struct nbu2ss_udc *udc,
 	i_remain_size -= result;
 
 	if (i_remain_size == 0) {
-		EP0_send_NULL(udc, FALSE);
+		EP0_send_NULL(udc, false);
 		return result;
 	}
 
@@ -754,7 +754,7 @@ static int _nbu2ss_ep0_out_transfer(struct nbu2ss_udc *udc,
 		if ((req->req.actual % EP0_PACKETSIZE) == 0) {
 			if (req->zero) {
 				req->zero = false;
-				EP0_receive_NULL(udc, FALSE);
+				EP0_receive_NULL(udc, false);
 				return 1;
 			}
 		}
@@ -799,7 +799,7 @@ static int _nbu2ss_out_dma(struct nbu2ss_udc *udc, struct nbu2ss_req *req,
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
 
-	req->dma_flag = TRUE;
+	req->dma_flag = true;
 	p_buffer = req->req.dma;
 	p_buffer += req->req.actual;
 
@@ -997,7 +997,7 @@ static int _nbu2ss_in_dma(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 	if (req->req.actual == 0)
 		_nbu2ss_dma_map_single(udc, ep, req, USB_DIR_IN);
 #endif
-	req->dma_flag = TRUE;
+	req->dma_flag = true;
 
 	/* MAX Packet Size */
 	mpkt = _nbu2ss_readl(&preg->EP_REGS[num].EP_PCKT_ADRS) & EPN_MPKT;
@@ -1166,7 +1166,7 @@ static int _nbu2ss_start_transfer(struct nbu2ss_udc *udc,
 {
 	int		nret = -EINVAL;
 
-	req->dma_flag = FALSE;
+	req->dma_flag = false;
 	req->div_len = 0;
 
 	if (req->req.length == 0) {
@@ -1190,7 +1190,7 @@ static int _nbu2ss_start_transfer(struct nbu2ss_udc *udc,
 			break;
 
 		case EP0_IN_STATUS_PHASE:
-			nret = EP0_send_NULL(udc, TRUE);
+			nret = EP0_send_NULL(udc, true);
 			break;
 
 		default:
@@ -1216,7 +1216,7 @@ static int _nbu2ss_start_transfer(struct nbu2ss_udc *udc,
 static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 {
 	u32		length;
-	bool	bflag = FALSE;
+	bool	bflag = false;
 	struct nbu2ss_req *req;
 
 	req = list_first_entry_or_null(&ep->queue, struct nbu2ss_req, queue);
@@ -1229,7 +1229,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
-			bflag = TRUE;
+			bflag = true;
 	}
 
 	_nbu2ss_start_transfer(ep->udc, ep, req, bflag);
@@ -1280,7 +1280,7 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
 
 		if (bstall) {
 			/* Set STALL */
-			ep->halted = TRUE;
+			ep->halted = true;
 
 			if (ep_adrs & USB_DIR_IN)
 				data = EPN_BCLR | EPN_ISTL;
@@ -1290,7 +1290,7 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
 			_nbu2ss_bitset(&preg->EP_REGS[num].EP_CONTROL, data);
 		} else {
 			/* Clear STALL */
-			ep->stalled = FALSE;
+			ep->stalled = false;
 			if (ep_adrs & USB_DIR_IN) {
 				_nbu2ss_bitclr(&preg->EP_REGS[num].EP_CONTROL
 						, EPN_ISTL);
@@ -1305,9 +1305,9 @@ static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
 						, data);
 			}
 
-			ep->stalled = FALSE;
+			ep->stalled = false;
 			if (ep->halted) {
-				ep->halted = FALSE;
+				ep->halted = false;
 				_nbu2ss_restert_transfer(ep);
 			}
 		}
@@ -1533,13 +1533,13 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 /*-------------------------------------------------------------------------*/
 static int std_req_clear_feature(struct nbu2ss_udc *udc)
 {
-	return _nbu2ss_req_feature(udc, FALSE);
+	return _nbu2ss_req_feature(udc, false);
 }
 
 /*-------------------------------------------------------------------------*/
 static int std_req_set_feature(struct nbu2ss_udc *udc)
 {
-	return _nbu2ss_req_feature(udc, TRUE);
+	return _nbu2ss_req_feature(udc, true);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1601,7 +1601,7 @@ static inline void _nbu2ss_read_request_data(struct nbu2ss_udc *udc, u32 *pdata)
 /*-------------------------------------------------------------------------*/
 static inline int _nbu2ss_decode_request(struct nbu2ss_udc *udc)
 {
-	bool			bcall_back = TRUE;
+	bool			bcall_back = true;
 	int			nret = -EINVAL;
 	struct usb_ctrlrequest	*p_ctrl;
 
@@ -1623,22 +1623,22 @@ static inline int _nbu2ss_decode_request(struct nbu2ss_udc *udc)
 		switch (p_ctrl->bRequest) {
 		case USB_REQ_GET_STATUS:
 			nret = std_req_get_status(udc);
-			bcall_back = FALSE;
+			bcall_back = false;
 			break;
 
 		case USB_REQ_CLEAR_FEATURE:
 			nret = std_req_clear_feature(udc);
-			bcall_back = FALSE;
+			bcall_back = false;
 			break;
 
 		case USB_REQ_SET_FEATURE:
 			nret = std_req_set_feature(udc);
-			bcall_back = FALSE;
+			bcall_back = false;
 			break;
 
 		case USB_REQ_SET_ADDRESS:
 			nret = std_req_set_address(udc);
-			bcall_back = FALSE;
+			bcall_back = false;
 			break;
 
 		case USB_REQ_SET_CONFIGURATION:
@@ -1655,7 +1655,7 @@ static inline int _nbu2ss_decode_request(struct nbu2ss_udc *udc)
 			if (nret >= 0) {
 				/*--------------------------------------*/
 				/* Status Stage */
-				nret = EP0_send_NULL(udc, TRUE);
+				nret = EP0_send_NULL(udc, true);
 			}
 		}
 
@@ -1688,7 +1688,7 @@ static inline int _nbu2ss_ep0_in_data_stage(struct nbu2ss_udc *udc)
 	nret = _nbu2ss_ep0_in_transfer(udc, req);
 	if (nret == 0) {
 		udc->ep0state = EP0_OUT_STATUS_PAHSE;
-		EP0_receive_NULL(udc, TRUE);
+		EP0_receive_NULL(udc, true);
 	}
 
 	return 0;
@@ -1708,7 +1708,7 @@ static inline int _nbu2ss_ep0_out_data_stage(struct nbu2ss_udc *udc)
 	nret = _nbu2ss_ep0_out_transfer(udc, req);
 	if (nret == 0) {
 		udc->ep0state = EP0_IN_STATUS_PHASE;
-		EP0_send_NULL(udc, TRUE);
+		EP0_send_NULL(udc, true);
 
 	} else if (nret < 0) {
 		_nbu2ss_bitset(&udc->p_regs->EP0_CONTROL, EP0_BCLR);
@@ -1817,7 +1817,7 @@ static inline void _nbu2ss_ep0_int(struct nbu2ss_udc *udc)
 
 	if (nret < 0) {
 		/* Send Stall */
-		_nbu2ss_set_endpoint_stall(udc, 0, TRUE);
+		_nbu2ss_set_endpoint_stall(udc, 0, true);
 	}
 }
 
@@ -1925,7 +1925,7 @@ static inline void _nbu2ss_epn_in_dma_int(struct nbu2ss_udc *udc,
 
 	preq->actual += req->div_len;
 	req->div_len = 0;
-	req->dma_flag = FALSE;
+	req->dma_flag = false;
 
 #ifdef USE_DMA
 	_nbu2ss_dma_unmap_single(udc, ep, req, USB_DIR_IN);
@@ -1961,7 +1961,7 @@ static inline void _nbu2ss_epn_out_dma_int(struct nbu2ss_udc *udc,
 	if (req->req.actual == req->req.length) {
 		if ((req->req.length % ep->ep.maxpacket) && !req->zero) {
 			req->div_len = 0;
-			req->dma_flag = FALSE;
+			req->dma_flag = false;
 			_nbu2ss_ep_done(ep, req, 0);
 			return;
 		}
@@ -1990,7 +1990,7 @@ static inline void _nbu2ss_epn_out_dma_int(struct nbu2ss_udc *udc,
 	if ((req->req.actual % ep->ep.maxpacket) > 0) {
 		if (req->req.actual == req->div_len) {
 			req->div_len = 0;
-			req->dma_flag = FALSE;
+			req->dma_flag = false;
 			_nbu2ss_ep_done(ep, req, 0);
 			return;
 		}
@@ -1998,7 +1998,7 @@ static inline void _nbu2ss_epn_out_dma_int(struct nbu2ss_udc *udc,
 
 	req->req.actual += req->div_len;
 	req->div_len = 0;
-	req->dma_flag = FALSE;
+	req->dma_flag = false;
 
 	_nbu2ss_epn_out_int(udc, ep, req);
 }
@@ -2187,7 +2187,7 @@ static int _nbu2ss_enable_controller(struct nbu2ss_udc *udc)
 	/* USB Interrupt Enable */
 	_nbu2ss_bitset(&udc->p_regs->USB_INT_ENA, USB_INT_EN_BIT);
 
-	udc->udc_enabled = TRUE;
+	udc->udc_enabled = true;
 
 	return 0;
 }
@@ -2203,7 +2203,7 @@ static void _nbu2ss_reset_controller(struct nbu2ss_udc *udc)
 static void _nbu2ss_disable_controller(struct nbu2ss_udc *udc)
 {
 	if (udc->udc_enabled) {
-		udc->udc_enabled = FALSE;
+		udc->udc_enabled = false;
 		_nbu2ss_reset_controller(udc);
 		_nbu2ss_bitset(&udc->p_regs->EPCTR, (DIRPD | EPC_RST));
 	}
@@ -2456,8 +2456,8 @@ static int nbu2ss_ep_enable(struct usb_ep *_ep,
 	ep->direct = desc->bEndpointAddress & USB_ENDPOINT_DIR_MASK;
 	ep->ep_type = ep_type;
 	ep->wedged = 0;
-	ep->halted = FALSE;
-	ep->stalled = FALSE;
+	ep->halted = false;
+	ep->stalled = false;
 
 	ep->ep.maxpacket = le16_to_cpu(desc->wMaxPacketSize);
 
@@ -2588,9 +2588,9 @@ static int nbu2ss_ep_queue(struct usb_ep *_ep,
 
 #ifdef USE_DMA
 	if ((uintptr_t)req->req.buf & 0x3)
-		req->unaligned = TRUE;
+		req->unaligned = true;
 	else
-		req->unaligned = FALSE;
+		req->unaligned = false;
 
 	if (req->unaligned) {
 		if (!ep->virt_buf)
@@ -2616,7 +2616,7 @@ static int nbu2ss_ep_queue(struct usb_ep *_ep,
 	list_add_tail(&req->queue, &ep->queue);
 
 	if (bflag && !ep->stalled) {
-		result = _nbu2ss_start_transfer(udc, ep, req, FALSE);
+		result = _nbu2ss_start_transfer(udc, ep, req, false);
 		if (result < 0) {
 			dev_err(udc->dev, " *** %s, result = %d\n", __func__,
 				result);
@@ -2704,12 +2704,12 @@ static int nbu2ss_ep_set_halt(struct usb_ep *_ep, int value)
 	ep_adrs = ep->epnum | ep->direct;
 	if (value == 0) {
 		_nbu2ss_set_endpoint_stall(udc, ep_adrs, value);
-		ep->stalled = FALSE;
+		ep->stalled = false;
 	} else {
 		if (list_empty(&ep->queue))
 			_nbu2ss_epn_set_stall(udc, ep);
 		else
-			ep->stalled = TRUE;
+			ep->stalled = true;
 	}
 
 	if (value == 0)
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index b8c3dee5626c..9c2671cb32f7 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -19,11 +19,6 @@
 #define	USE_DMA	1
 #define USE_SUSPEND_WAIT	1
 
-#ifndef TRUE
-#define TRUE	1
-#define FALSE	0
-#endif
-
 /*------------ Board dependence(Resource) */
 #define	VBUS_VALUE		GPIO_VBUS
 
-- 
2.20.1

