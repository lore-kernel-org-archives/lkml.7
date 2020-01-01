Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B198C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7C9206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgAARWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 12:22:48 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:35309 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbgAARWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:22:47 -0500
X-Greylist: delayed 3350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jan 2020 12:22:39 EST
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 001GQItn001783;
        Wed, 1 Jan 2020 19:26:23 +0300
Received: from oak.local (unknown [188.123.231.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 6EBEFC4A0A;
        Wed,  1 Jan 2020 19:26:20 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/6] usb: musb: Introduce musb_qh_empty() helper function
Date:   Wed,  1 Jan 2020 19:26:06 +0300
Message-Id: <20200101162610.15819-3-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200101162610.15819-1-matwey@sai.msu.ru>
References: <20200101162610.15819-1-matwey@sai.msu.ru>
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use musb_qh_empty() instead of &qh->hep->urb_list to avoid code
duplicating.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3ffea6a5e022..37aa9f6155d9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -80,6 +80,11 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *urb, int is_out,
 			u8 *buf, u32 offset, u32 len);
 
+static bool musb_qh_empty(struct musb_qh *qh)
+{
+	return list_empty(&qh->hep->urb_list);
+}
+
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
  */
@@ -342,7 +347,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	/* reclaim resources (and bandwidth) ASAP; deschedule it, and
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
-	if (list_empty(&qh->hep->urb_list)) {
+	if (musb_qh_empty(qh)) {
 		struct list_head	*head;
 		struct dma_controller	*dma = musb->dma_controller;
 
@@ -2430,7 +2435,7 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* If nothing else (usually musb_giveback) is using it
 		 * and its URB list has emptied, recycle this qh.
 		 */
-		if (ready && list_empty(&qh->hep->urb_list)) {
+		if (ready && musb_qh_empty(qh)) {
 			qh->hep->hcpriv = NULL;
 			list_del(&qh->ring);
 			kfree(qh);
@@ -2475,7 +2480,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		/* Then nuke all the others ... and advance the
 		 * queue on hw_ep (e.g. bulk ring) when we're done.
 		 */
-		while (!list_empty(&hep->urb_list)) {
+		while (!musb_qh_empty(qh)) {
 			urb = next_urb(qh);
 			urb->status = -ESHUTDOWN;
 			musb_advance_schedule(musb, urb, qh->hw_ep, is_in);
@@ -2485,7 +2490,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		 * other transfers, and since !qh->is_ready nothing
 		 * will activate any of these as it advances.
 		 */
-		while (!list_empty(&hep->urb_list))
+		while (!musb_qh_empty(qh))
 			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
 
 		hep->hcpriv = NULL;
-- 
2.16.4

