Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261BC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8815121841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054779;
	bh=laaMfB6GJi+RjTfheKYuRjfFtHFXzzuj98IyPvCP3RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gFuq6+gQ5BtWHT/55llCi4pPbTe35OiTt7N2DNkTH1h6Tbfx4VK9b6CQre13qtmWE
	 IKp3Vtgzv8tOdZG6Rc+Zb74x/teyPTwXGjbS197wkebIVfcCz1QqZqpmBZ161P2xWT
	 6/n/fmIaygFahU0i7kb3u07flwuGhWxiY6k8o+5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfGBIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfGBIGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8152183F;
        Tue,  2 Jul 2019 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054769;
        bh=laaMfB6GJi+RjTfheKYuRjfFtHFXzzuj98IyPvCP3RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REAFnLjTXEnP0xIrT4FV6hxw8YJVDIOhZb4hAdlNzOvZq4Q4HXUIAI1UrQuMRyE3/
         LA2maqD3NHG/ixYERhDExq5100FETvzO0ND9wpEIp1kQNsTxRXI+4t0loMC3ocwHAH
         eB/9zbrURt1A8X9vTlQG47jga34YwUoJy0iPgu60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Yang <fei.yang@intel.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/72] usb: dwc3: gadget: move requests to cancelled_list
Date:   Tue,  2 Jul 2019 10:01:30 +0200
Message-Id: <20190702080126.178119054@linuxfoundation.org>
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

commit d4f1afe5e896c18ae01099a85dab5e1a198bd2a8 upstream

Whenever we have a request in flight, we can move it to the cancelled
list and later simply iterate over that list and skip over any TRBs we
find.

Cc: Fei Yang <fei.yang@intel.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org # 4.19.y
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
(cherry picked from commit d4f1afe5e896c18ae01099a85dab5e1a198bd2a8)
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c2169bc626c8..8291fa1624e1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1364,6 +1364,17 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 	}
 }
 
+static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep)
+{
+	struct dwc3_request		*req;
+	struct dwc3_request		*tmp;
+
+	list_for_each_entry_safe(req, tmp, &dep->cancelled_list, list) {
+		dwc3_gadget_ep_skip_trbs(dep, req);
+		dwc3_gadget_giveback(dep, req, -ECONNRESET);
+	}
+}
+
 static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		struct usb_request *request)
 {
@@ -1400,8 +1411,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			if (!r->trb)
 				goto out0;
 
-			dwc3_gadget_ep_skip_trbs(dep, r);
-			goto out1;
+			dwc3_gadget_move_cancelled_request(req);
+			dwc3_gadget_ep_cleanup_cancelled_requests(dep);
+			goto out0;
 		}
 		dev_err(dwc->dev, "request %pK was not queued to %s\n",
 				request, ep->name);
@@ -1409,7 +1421,6 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		goto out0;
 	}
 
-out1:
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
-- 
2.20.1



