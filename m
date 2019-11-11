Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2242184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKKP07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:26:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45295 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfKKP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:26:57 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUBac-0000hz-10; Mon, 11 Nov 2019 16:26:50 +0100
Received: from mol by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iUBaa-0003bP-RG; Mon, 11 Nov 2019 16:26:48 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Olbrich <m.olbrich@pengutronix.de>
Subject: [PATCH 1/2] usb: dwc3: gadget: make starting isoc transfers more robust
Date:   Mon, 11 Nov 2019 16:26:44 +0100
Message-Id: <20191111152645.13792-2-m.olbrich@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111152645.13792-1-m.olbrich@pengutronix.de>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __dwc3_gadget_start_isoc must be called very shortly after
XferNotReady. Otherwise the frame number is outdated and start transfer
will fail, even with several retries.

DSTS provides the lower 14 bit of the frame number. Use it in combination
with the frame number provided by XferNotReady to guess the current frame
number. This will succeed unless more than one 14 rollover has happened
since XferNotReady.

Start transfer might still fail if the frame number is increased
immediately after DSTS is read. So retries are still needed.
Don't drop the current request if this happens. This way it is not lost and
can be used immediately to try again with the next frame number.

With this change, __dwc3_gadget_start_isoc is still not successfully in all
cases bit it increases the acceptable delay after XferNotReady
significantly.

Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
---
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dd783b889cb..c5b223656e08 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -709,6 +709,7 @@ struct dwc3_ep {
 	u8			type;
 	u8			resource_index;
 	u32			frame_number;
+	u32			last_frame_number;
 	u32			interval;
 
 	char			name[20];
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 173f5329d3d9..ac4673d91939 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1204,7 +1204,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	}
 }
 
-static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
+static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, bool keep_req)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_request		*req;
@@ -1242,7 +1242,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 	}
 
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	if (ret < 0) {
+	if (ret < 0 && (!keep_req || ret != -EAGAIN)) {
 		/*
 		 * FIXME we need to iterate over the list of requests
 		 * here and stop, unmap, free and del each of the linked
@@ -1254,7 +1254,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
@@ -1377,7 +1377,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 	dep->start_cmd_status = 0;
 	dep->combo_num = 0;
 
-	return __dwc3_gadget_kick_transfer(dep);
+	return __dwc3_gadget_kick_transfer(dep, false);
 }
 
 static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
@@ -1402,9 +1402,23 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 	}
 
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
-		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
+		/*
+		 * last_frame_number is set from XferNotReady and may be
+		 * already out of date. DSTS only provides the lower 14 bit
+		 * of the current frame number. So add the upper two bits of
+		 * last_frame_number and handle a possible rollover.
+		 * This will provide the correct frame_number unless more than
+		 * rollover has happened since XferNotReady.
+		 */
+		u32 frame = __dwc3_gadget_get_frame(dwc);
+
+		dep->frame_number = (dep->last_frame_number & ~0x3fff) | frame;
+		if (frame < (dep->last_frame_number & 0x3fff))
+			dep->frame_number += 0x4000;
+		dep->frame_number = DWC3_ALIGN_FRAME(dep, 1);
 
-		ret = __dwc3_gadget_kick_transfer(dep);
+		ret = __dwc3_gadget_kick_transfer(dep,
+				i + 1 < DWC3_ISOC_MAX_RETRIES);
 		if (ret != -EAGAIN)
 			break;
 	}
@@ -1461,7 +1475,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		}
 	}
 
-	return __dwc3_gadget_kick_transfer(dep);
+	return __dwc3_gadget_kick_transfer(dep, false);
 }
 
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
@@ -2467,7 +2481,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	if (!dwc3_gadget_ep_request_completed(req) &&
 			req->num_pending_sgs) {
-		__dwc3_gadget_kick_transfer(dep);
+		__dwc3_gadget_kick_transfer(dep, false);
 		goto out;
 	}
 
@@ -2497,6 +2511,7 @@ static void dwc3_gadget_endpoint_frame_from_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
 	dep->frame_number = event->parameters;
+	dep->last_frame_number = event->parameters;
 }
 
 static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
-- 
2.20.1

