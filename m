Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB57C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9732053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155025;
	bh=JjMQHWf7en1JnPMl25Brc/ONJrEvJ0JAbONFCKfVaBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H3OQELKCS85ijpLscJyK6RrvfZUy/O69lNndqHpoQW9LWFi3k6SwWaJlAMXPJzqTq
	 64Wxu/PBdvi5qbilcze0H0JUVFNDW4xkXhDBZ5kFg0/26FFiMqYH4L2BXCmGam06+a
	 u1iu86ysArN8S7tbT5R+UncSnyCzS2MFwudcLg/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEFOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfEFOj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D4B20449;
        Mon,  6 May 2019 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153567;
        bh=JjMQHWf7en1JnPMl25Brc/ONJrEvJ0JAbONFCKfVaBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cs69r2no0cBGDMuysKcEeHQAPk0ay2F5OvLSuda7xOlGHRFkYHycRpe+XL0k6pZ/y
         xxzO52zjF3amFZZwlTvwg4EUcJwRx/9Po9IFmiUfLDOnPmXKaiq/6Dhq7eXd/lPh7O
         08IxZqylUfMZK6yTekg0KQujgtOw9e37KEBAkA5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com
Subject: [PATCH 4.19 15/99] USB: dummy-hcd: Fix failure to give back unlinked URBs
Date:   Mon,  6 May 2019 16:31:48 +0200
Message-Id: <20190506143055.255269547@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit fc834e607ae3d18e1a20bca3f9a2d7f52ea7a2be upstream.

The syzkaller USB fuzzer identified a failure mode in which dummy-hcd
would never give back an unlinked URB.  This causes usb_kill_urb() to
hang, leading to WARNINGs and unkillable threads.

In dummy-hcd, all URBs are given back by the dummy_timer() routine as
it scans through the list of pending URBS.  Failure to give back URBs
can be caused by failure to start or early exit from the scanning
loop.  The code currently has two such pathways: One is triggered when
an unsupported bus transfer speed is encountered, and the other by
exhausting the simulated bandwidth for USB transfers during a frame.

This patch removes those two paths, thereby allowing all unlinked URBs
to be given back in a timely manner.  It adds a check for the bus
speed when the gadget first starts running, so that dummy_timer() will
never thereafter encounter an unsupported speed.  And it prevents the
loop from exiting as soon as the total bandwidth has been used up (the
scanning loop continues, giving back unlinked URBs as they are found,
but not transferring any more data).

Thanks to Andrey Konovalov for manually running the syzkaller fuzzer
to help track down the source of the bug.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/dummy_hcd.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -979,8 +979,18 @@ static int dummy_udc_start(struct usb_ga
 	struct dummy_hcd	*dum_hcd = gadget_to_dummy_hcd(g);
 	struct dummy		*dum = dum_hcd->dum;
 
-	if (driver->max_speed == USB_SPEED_UNKNOWN)
+	switch (g->speed) {
+	/* All the speeds we support */
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		break;
+	default:
+		dev_err(dummy_dev(dum_hcd), "Unsupported driver max speed %d\n",
+				driver->max_speed);
 		return -EINVAL;
+	}
 
 	/*
 	 * SLAVE side init ... the layer above hardware, which
@@ -1784,9 +1794,10 @@ static void dummy_timer(struct timer_lis
 		/* Bus speed is 500000 bytes/ms, so use a little less */
 		total = 490000;
 		break;
-	default:
+	default:	/* Can't happen */
 		dev_err(dummy_dev(dum_hcd), "bogus device speed\n");
-		return;
+		total = 0;
+		break;
 	}
 
 	/* FIXME if HZ != 1000 this will probably misbehave ... */
@@ -1828,7 +1839,7 @@ restart:
 
 		/* Used up this frame's bandwidth? */
 		if (total <= 0)
-			break;
+			continue;
 
 		/* find the gadget's ep for this request (if configured) */
 		address = usb_pipeendpoint (urb->pipe);


