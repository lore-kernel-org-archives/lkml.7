Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277A3C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEC3206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054887;
	bh=v1TKwauUXKHlGY/N6fS/FcuaLV0SVGZvQfoU3vyREn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2C+SlUd3C4XGVvR/vI5I9UpI5yU6ycDC1npX0E46G7u7VnYSadUBNw0DtMTZ6nli
	 MMe9ZobY+XjQDOTRySEEQ/iqSI/vYOaMQN8B6sIPSUGUKzfQ9bbfFYPiNmDQ0roQA0
	 ZOiLy4GjOLGWQI9BZpx3Vn+nI82geDJHQ+Mrm3X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfGBIIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfGBIIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84739206A2;
        Tue,  2 Jul 2019 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054883;
        bh=v1TKwauUXKHlGY/N6fS/FcuaLV0SVGZvQfoU3vyREn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrcfjH6L/9g0DBSbqkVhLVLpFj+0aHo3bW0+37ighEZZuYpOCCxpBUt8J3r4ieEph
         pmf9exFSqmFJ9Nz3GO8EjatN/e7DnYt5B+44jSX4/Znh4V9a194h+EDiGXbekryCtu
         Yn8NzNrVK7tgxEZDfzWI2lwUi5LqsxUIB79nFyKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Yang <fei.yang@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/72] usb: dwc3: gadget: combine unaligned and zero flags
Date:   Tue,  2 Jul 2019 10:01:25 +0200
Message-Id: <20190702080125.929938236@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1a22ec643580626f439c8583edafdcc73798f2fb upstream

Both flags are used for the same purpose in dwc3: appending an extra
TRB at the end to deal with controller requirements. By combining both
flags into one, we make it clear that the situation is the same and
that they should be treated equally.

Cc: Fei Yang <fei.yang@intel.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org # 4.19.y
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 1a22ec643580626f439c8583edafdcc73798f2fb)
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   |  7 +++----
 drivers/usb/dwc3/gadget.c | 18 +++++++++---------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb62533e0f..4872cba8699b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -847,11 +847,11 @@ struct dwc3_hwparams {
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
- * @unaligned: true for OUT endpoints with length not divisible by maxp
+ * @needs_extra_trb: true when request needs one extra TRB (either due to ZLP
+ *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  * @started: request is started
- * @zero: wants a ZLP
  */
 struct dwc3_request {
 	struct usb_request	request;
@@ -867,11 +867,10 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
-	unsigned		unaligned:1;
+	unsigned		needs_extra_trb:1;
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
-	unsigned		zero:1;
 };
 
 /*
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eaa78e6c972c..8db7466e4f76 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1068,7 +1068,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			struct dwc3	*dwc = dep->dwc;
 			struct dwc3_trb	*trb;
 
-			req->unaligned = true;
+			req->needs_extra_trb = true;
 
 			/* prepare normal TRB */
 			dwc3_prepare_one_trb(dep, req, true, i);
@@ -1112,7 +1112,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
-		req->unaligned = true;
+		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
 		dwc3_prepare_one_trb(dep, req, true, 0);
@@ -1128,7 +1128,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
 
-		req->zero = true;
+		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
 		dwc3_prepare_one_trb(dep, req, true, 0);
@@ -1410,7 +1410,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 					dwc3_ep_inc_deq(dep);
 				}
 
-				if (r->unaligned || r->zero) {
+				if (r->needs_extra_trb) {
 					trb = r->trb + r->num_pending_sgs + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -1421,7 +1421,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 				dwc3_ep_inc_deq(dep);
 
-				if (r->unaligned || r->zero) {
+				if (r->needs_extra_trb) {
 					trb = r->trb + 1;
 					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 					dwc3_ep_inc_deq(dep);
@@ -2250,7 +2250,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if ((req->zero || req->unaligned) && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
+
+	if (req->needs_extra_trb && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}
@@ -2327,11 +2328,10 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
 
-	if (req->unaligned || req->zero) {
+	if (req->needs_extra_trb) {
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
-		req->unaligned = false;
-		req->zero = false;
+		req->needs_extra_trb = false;
 	}
 
 	req->request.actual = req->request.length - req->remaining;
-- 
2.20.1



