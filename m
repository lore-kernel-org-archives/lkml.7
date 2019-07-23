Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E8C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9152253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JezetA0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfGWU1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:27:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33731 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfGWU1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:27:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so19708394pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOfhFeRwrk1NDQAubrKcIwqzw+J4sPXSqFL3j8L4jQk=;
        b=JezetA0Nxiw1OmCAW2DXcbq3AmvNuAKkd8EZaqtaZE02yn5PvkQjeWHGm89Hdz/5x0
         ZL73gKx15WWh+UArNMwog4UBdRwhmA8Aays93Bv5o44Kj6UuElrGHFE0oqlQ6L7Lu2kJ
         0jDtfZU+Wr3MXAV4msLIdr/sT1MbA82oTkWRSPhySp0tLXs+dR9/YHF/3UQOUU/Y3OJp
         FrOqsBBL9FByy1fTW5o4xilcETT+or2inIAtjcbVo+EjXq7WpE9JQMUUBkFJ9aiw4fyv
         DgxZdF2eLiLg8U5C9f4yWFJ8D1QS4s4Nb9UfauWvP+esjMgTbNPzSAx6zFw3Fr8GkPco
         fmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WOfhFeRwrk1NDQAubrKcIwqzw+J4sPXSqFL3j8L4jQk=;
        b=JM556paFrdi7FGonbxoqEJIkXNfmndscqIJ5rY5jqFasGyEwv/x5XzWq24brpR0rvE
         EoLnP6q73t2Ja+H8hsg6SgSswkyu0zYviRHjWLQG42qk+2L9KWPrgC7GQXJJDYkoman1
         ULD3mtnwvi3QKiPpW2dGUjqiiYzn3z3fwISDmBmyihS+qWZgvZ2OSjUKjP04yXm0Hqz4
         pKJK9EKzU1jPh/czjRLwGC3R38/ThSXA7WTG60LxsQ9pNLf3KYWGHkOdLQakl/1BVhU2
         t8LduVVVC3sYmpJbu3rtHwJwvFeJD3pmcUX3Xu0t4WyhaqCobDaRaGdrUPrTF6zFX7Hj
         KATQ==
X-Gm-Message-State: APjAAAUOQ20jD1RN1YWpKNkiU8wg5LrGJH0VAVRgty3U1Dssk5eja9GA
        /KjSSrIO7fCTXxLP+Pnrhbea/gDa96I=
X-Google-Smtp-Source: APXvYqwRAuZr7uU9qydDUT8b6JlLLZPXYg4os9EGyOFJ139Z/P8r3tDqZio8CygZ1zwDz3EFcrGD9Q==
X-Received: by 2002:a17:90a:109:: with SMTP id b9mr79845273pjb.112.1563913663333;
        Tue, 23 Jul 2019 13:27:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r2sm59205538pfl.67.2019.07.23.13.27.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 13:27:42 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Tue, 23 Jul 2019 20:27:35 +0000
Message-Id: <20190723202735.113381-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CY4PR1201MB003708ADAD79BF4FD24D3445AACB0@CY4PR1201MB0037.namprd12.prod.outlook.com>
References: <CY4PR1201MB003708ADAD79BF4FD24D3445AACB0@CY4PR1201MB0037.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

At a practical level, this patch resolves USB transfer stalls seen
with adb on dwc3 based Android devices after functionfs gadget
added scatter-gather support around v4.20.

Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: Tejas Joglekar <tejas.joglekar@synopsys.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Cc: stable <stable@vger.kernel.org>
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
[jstultz: forward ported to mainline, added note to commit log]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
Just wanted to send this out so we're all looking at the same thing.
Not sure if its correct, but it seems to solve the adb stalls I've
been seeing for awhile.

 thanks
 -john

 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c9cecb3a9670..1d9701dde69b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2394,7 +2394,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.17.1

