Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E75CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F52217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFNRXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:23:30 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:50801 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfFNRXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:23:24 -0400
X-Greylist: delayed 2129 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 13:23:05 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id x5EGlAnW020159;
        Fri, 14 Jun 2019 19:47:15 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 3983186C93;
        Fri, 14 Jun 2019 19:47:09 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] usb: musb: Decrease URB starting latency in musb_advance_schedule()
Date:   Fri, 14 Jun 2019 19:45:54 +0300
Message-Id: <20190614164554.27679-7-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614164554.27679-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
 <20190614164554.27679-1-matwey@sai.msu.ru>
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
started before URB giveback. When qh is empty or current URB has an
error then the behaviour is intentionally kept in order
  a) not to break existing inter qh scheduling: URB giveback could
potentionally enqueue other URB to the empty qh preventing it from being
disposed;
  b) allow the class driver to cancel outstanding URBs in the queue.

Correct URB giveback order is guaranteed as the following. For each
qh there can be at most three ready URBs processing by the driver.
Indeed, every ready URB can send at most one URB in
musb_advance_schedule(), and in the worst case scenario we have the
following ready URBs:
  1) URB in the giveback lock protected section inside musb_giveback()
  2) URB waiting at the giveback lock acqusition in musb_giveback()
  3) URB waiting at the controller lock acqusition in the glue layer
     interrput handler
Here URB #2 and URB #3 are triggered by URB #1 and URB #2
correspondingly when they passed through musb_advance_schedule().
Since URB #3 is waiting before musb_advance_schedule(), no other new
URBs will be sent until URB#1 is finished, URB#2 goes to the giveback
lock protected section, and URB#3 goes to the controller lock protected
musb_advance_schedule().

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
 drivers/usb/musb/musb_host.c | 36 ++++++++++++++++++++++++++++++++----
 drivers/usb/musb/musb_host.h |  1 +
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index ed99ecd4e63a..5c43996f2de5 100644
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
@@ -301,15 +306,24 @@ musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 }
 
 /* Context: caller owns controller lock, IRQs are blocked */
-static void musb_giveback(struct musb *musb, struct urb *urb, int status)
+static void musb_giveback(struct musb *musb, struct musb_qh *qh, struct urb *urb, int status)
 __releases(musb->lock)
 __acquires(musb->lock)
 {
 	trace_musb_urb_gb(musb, urb);
 
+	/*
+	 * This line is protected by the controller lock: at most
+	 * one thread waiting on the giveback lock.
+	 */
+	spin_lock(&qh->giveback_lock);
 	usb_hcd_unlink_urb_from_ep(musb->hcd, urb);
+
 	spin_unlock(&musb->lock);
+
 	usb_hcd_giveback_urb(musb->hcd, urb, status);
+	spin_unlock(&qh->giveback_lock);
+
 	spin_lock(&musb->lock);
 }
 
@@ -362,8 +376,21 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 		break;
 	}
 
+	if (ready && !musb_qh_singular(qh) && !status) {
+		struct urb *next_urb = list_next_entry(urb, urb_list);
+
+		musb_dbg(musb, "... next ep%d %cX urb %p", hw_ep->epnum, is_in ? 'R' : 'T', next_urb);
+		musb_start_urb(musb, is_in, qh, next_urb);
+
+		qh->is_ready = 0;
+		musb_giveback(musb, qh, urb, status);
+		qh->is_ready = ready;
+
+		return;
+	}
+
 	qh->is_ready = 0;
-	musb_giveback(musb, urb, status);
+	musb_giveback(musb, qh, urb, status);
 	qh->is_ready = ready;
 
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
@@ -2207,6 +2234,7 @@ static int musb_urb_enqueue(
 	qh->hep = hep;
 	qh->dev = urb->dev;
 	INIT_LIST_HEAD(&qh->ring);
+	spin_lock_init(&qh->giveback_lock);
 	qh->is_ready = 1;
 
 	qh->maxpacket = usb_endpoint_maxp(epd);
@@ -2439,7 +2467,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		int	ready = qh->is_ready;
 
 		qh->is_ready = 0;
-		musb_giveback(musb, urb, 0);
+		musb_giveback(musb, qh, urb, 0);
 		qh->is_ready = ready;
 
 		/* If nothing else (usually musb_giveback) is using it
@@ -2498,7 +2526,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		 * will activate any of these as it advances.
 		 */
 		while (!musb_qh_empty(qh))
-			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
+			musb_giveback(musb, qh, next_urb(qh), -ESHUTDOWN);
 
 		musb_qh_free(qh);
 	}
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
index 2999845632ce..6223b0177c68 100644
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -19,6 +19,7 @@ struct musb_qh {
 	struct musb_hw_ep	*hw_ep;		/* current binding */
 
 	struct list_head	ring;		/* of musb_qh */
+	spinlock_t		giveback_lock;	/* to keep URB giveback order */
 	/* struct musb_qh		*next; */	/* for periodic tree */
 	u8			mux;		/* qh multiplexed to hw_ep */
 
-- 
2.16.4

