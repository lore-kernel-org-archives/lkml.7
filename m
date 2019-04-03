Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C172133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDCT0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:26:00 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:49521 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfDCTZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:25:58 -0400
X-Greylist: delayed 1904 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 15:25:44 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id x33IraYN024087;
        Wed, 3 Apr 2019 21:53:41 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 202EF81435;
        Wed,  3 Apr 2019 21:53:37 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 6/6] usb: musb: Decrease URB starting latency in musb_advance_schedule()
Date:   Wed,  3 Apr 2019 21:53:10 +0300
Message-Id: <20190403185310.8437-7-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the algorithm was the following:

 1. giveback current URB
 2. if current qh is not empty
    then start next URB
 3. if current qh is empty
    then dispose the qh, find next qh if any, and start URB.

It may take a while to run urb->callback inside URB giveback which is
run synchronously in musb. In order to improve the latency we rearrange
the function behaviour for the case when qh is not empty: next URB is
started before URB giveback. When qh is empty then the behaviour is
intentionally kept in order not to break existing inter qh scheduling:
URB giveback could potentionally enqueue other URB to the empty qh
preventing it from being disposed.

Before this patch, time spent in urb->callback led to the following
glitches between the host and a hub during isoc transfer (line 4):

    11.624492 d=  0.000124 [130.6 +  1.050] [  4] SPLIT
    11.624492 d=  0.000000 [130.6 +  1.467] [  3] IN   : 3.5
    11.624493 d=  0.000000 [130.6 +  1.967] [ 37] DATA0: aa 08 [skipped...]
    11.625617 d=  0.001124 [131.7 +  1.050] [  4] SPLIT
    11.625617 d=  0.000000 [131.7 +  1.467] [  3] IN   : 3.5
    11.625867 d=  0.000250 [132.1 +  1.050] [  4] SPLIT
    11.625867 d=  0.000000 [132.1 +  1.467] [  3] IN   : 3.5
    11.625868 d=  0.000001 [132.1 +  1.983] [  3] DATA0: 00 00
    11.626617 d=  0.000749 [132.7 +  1.050] [  4] SPLIT
    11.626617 d=  0.000000 [132.7 +  1.467] [  3] IN   : 3.5
    11.626867 d=  0.000250 [133.1 +  1.050] [  4] SPLIT
    11.626867 d=  0.000000 [133.1 +  1.467] [  3] IN   : 3.5
    11.626868 d=  0.000000 [133.1 +  1.967] [  3] DATA0: 00 00

After the hub, they look as the following and may lead to broken
perepherial transfer (as in case of PWC based webcam):

    11.332004 d=  0.000997 [ 30.0 +  3.417] [  3] IN   : 5.5
    11.332007 d=  0.000003 [ 30.0 +  6.833] [800] DATA0: 8a 1c [skipped...]
    11.334004 d=  0.001997 [ 32.0 +  3.417] [  3] IN   : 5.5
    11.334007 d=  0.000003 [ 32.0 +  6.750] [  3] DATA0: 00 00
    11.335004 d=  0.000997 [ 33   +  3.417] [  3] IN   : 5.5
    11.335007 d=  0.000003 [ 33   +  6.750] [  3] DATA0: 00 00

Removing this glitches makes us able to successfully run 10fps
video stream from the webcam attached via USB hub. That was
previously impossible.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ed99ecd4e63a..75be92873b5b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -85,6 +85,11 @@ static bool musb_qh_empty(struct musb_qh *qh)
 	return list_empty(&qh->hep->urb_list);
 }
 
+static bool musb_qh_singular(struct musb_qh *qh)
+{
+	return list_is_singular(&qh->hep->urb_list);
+}
+
 static void musb_qh_unlink_hep(struct musb_qh *qh)
 {
 	if (!qh->hep)
@@ -362,6 +367,19 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 		break;
 	}
 
+	if (ready && !musb_qh_singular(qh)) {
+		struct urb *next_urb = list_next_entry(urb, urb_list);
+
+		musb_dbg(musb, "... next ep%d %cX urb %p", hw_ep->epnum, is_in ? 'R' : 'T', next_urb);
+		musb_start_urb(musb, is_in, qh, next_urb);
+
+		qh->is_ready = 0;
+		musb_giveback(musb, urb, status);
+		qh->is_ready = ready;
+
+		return;
+	}
+
 	qh->is_ready = 0;
 	musb_giveback(musb, urb, status);
 	qh->is_ready = ready;
-- 
2.16.4

