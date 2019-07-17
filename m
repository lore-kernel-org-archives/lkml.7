Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B539C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2461521871
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 00:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfGQAHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 20:07:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:42048 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfGQAHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 20:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 17:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,272,1559545200"; 
   d="scan'208";a="172698735"
Received: from fei-dev-host.jf.intel.com ([10.7.198.158])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2019 17:07:33 -0700
From:   fei.yang@intel.com
To:     felipe.balbi@linux.intel.com, john.stultz@linaro.org,
        andrzej.p@samsung.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: trb_dequeue is not updated properly
Date:   Tue, 16 Jul 2019 17:07:25 -0700
Message-Id: <1563322045-49515-1-git-send-email-fei.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Yang <fei.yang@intel.com>

If scatter-gather operation is allowed, a large USB request is split into
multiple TRBs. These TRBs are chained up by setting DWC3_TRB_CTRL_CHN bit
except the last one which has DWC3_TRB_CTRL_IOC bit set instead.
Since only the last TRB has IOC set for the whole USB request, the
dwc3_gadget_ep_reclaim_completed_trb() gets called only once for the request
and all TRBs are supposed to be reclaimed. However that is not what happens
with the current code.

This patch addresses the issue by checking req->num_pending_sgs. In case the
pending sgs is not zero, update trb_dequeue and req->num_trbs accordingly.

Signed-off-by: Fei Yang <fei.yang@intel.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/dwc3/gadget.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 173f532..4d5b4eb 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2394,8 +2394,14 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & DEPEVT_STATUS_IOC) {
+		for (count = 0; count < req->num_pending_sgs; count++) {
+			dwc3_ep_inc_deq(dep);
+			req->num_trbs--;
+		}
+		req->num_pending_sgs = 0;
 		return 1;
+	}
 
 	return 0;
 }
@@ -2404,7 +2410,7 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req, const struct dwc3_event_depevt *event,
 		int status)
 {
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
+	struct dwc3_trb *trb;
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
 	unsigned int pending = req->num_pending_sgs;
-- 
2.7.4

