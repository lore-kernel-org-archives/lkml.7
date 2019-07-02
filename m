Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FAFC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A66020665
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055182;
	bh=XgDgixqehRUh9h6YIMMXtwTLxuXOmB4Mj8ai+vE2OA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/fOaJh2f/E15lCIqKfErcuc8jDAxvUucnShfk+czLYlPpEeqzmiO1vPdJkJBcYw4
	 k25uKVZgY8AMNHTvq9iP5StovZPISJn1N8QP/anHfwCTsKRN59ohXGnblkoWR8jc/F
	 1/xux3CpEtGntjkcjfx6+JeKT0jZmNpJgzVWLiQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfGBIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfGBIIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:08:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1D4206A2;
        Tue,  2 Jul 2019 08:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054892;
        bh=XgDgixqehRUh9h6YIMMXtwTLxuXOmB4Mj8ai+vE2OA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuwzWTUS95KYOZskMi6vJzFkkNRxljhQenghq/TwCZC14m0xRgQHfnPnuuzIQQtMT
         gF+JJbP7+s/A2SxMJc7WlMNrqLp+3GruCWtRLXVYFAUdIWniTT5vpciGbxkXuOzLvV
         jI5k1eiDoIPqhaEKtQEa5cbd8PtT8T1GuNKz5o08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Yang <fei.yang@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 27/72] usb: dwc3: gadget: extract dwc3_gadget_ep_skip_trbs()
Date:   Tue,  2 Jul 2019 10:01:28 +0200
Message-Id: <20190702080126.079029804@linuxfoundation.org>
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

commit 7746a8dfb3f9c91b3a0b63a1d5c2664410e6498d upstream

Extract the logic for skipping over TRBs to its own function. This
makes the code slightly more readable and makes it easier to move this
call to its final resting place as a following patch.

Cc: Fei Yang <fei.yang@intel.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org # 4.19.y
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit 7746a8dfb3f9c91b3a0b63a1d5c2664410e6498d)
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 61 +++++++++++++++------------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4e08904890ed..46aa20b376cd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1341,6 +1341,29 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	return ret;
 }
 
+static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req)
+{
+	int i;
+
+	/*
+	 * If request was already started, this means we had to
+	 * stop the transfer. With that we also need to ignore
+	 * all TRBs used by the request, however TRBs can only
+	 * be modified after completion of END_TRANSFER
+	 * command. So what we do here is that we wait for
+	 * END_TRANSFER completion and only after that, we jump
+	 * over TRBs by clearing HWO and incrementing dequeue
+	 * pointer.
+	 */
+	for (i = 0; i < req->num_trbs; i++) {
+		struct dwc3_trb *trb;
+
+		trb = req->trb + i;
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+		dwc3_ep_inc_deq(dep);
+	}
+}
+
 static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		struct usb_request *request)
 {
@@ -1368,38 +1391,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				break;
 		}
 		if (r == req) {
-			int i;
-
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dep, true);
-
-			/*
-			 * If request was already started, this means we had to
-			 * stop the transfer. With that we also need to ignore
-			 * all TRBs used by the request, however TRBs can only
-			 * be modified after completion of END_TRANSFER
-			 * command. So what we do here is that we wait for
-			 * END_TRANSFER completion and only after that, we jump
-			 * over TRBs by clearing HWO and incrementing dequeue
-			 * pointer.
-			 *
-			 * Note that we have 2 possible types of transfers here:
-			 *
-			 * i) Linear buffer request
-			 * ii) SG-list based request
-			 *
-			 * SG-list based requests will have r->num_pending_sgs
-			 * set to a valid number (> 0). Linear requests,
-			 * normally use a single TRB.
-			 *
-			 * For each of these two cases, if r->unaligned flag is
-			 * set, one extra TRB has been used to align transfer
-			 * size to wMaxPacketSize.
-			 *
-			 * All of these cases need to be taken into
-			 * consideration so we don't mess up our TRB ring
-			 * pointers.
-			 */
 			wait_event_lock_irq(dep->wait_end_transfer,
 					!(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
 					dwc->lock);
@@ -1407,13 +1400,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			if (!r->trb)
 				goto out0;
 
-			for (i = 0; i < r->num_trbs; i++) {
-				struct dwc3_trb *trb;
-
-				trb = r->trb + i;
-				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
-				dwc3_ep_inc_deq(dep);
-			}
+			dwc3_gadget_ep_skip_trbs(dep, r);
 			goto out1;
 		}
 		dev_err(dwc->dev, "request %pK was not queued to %s\n",
-- 
2.20.1



