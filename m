Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C94FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A1B2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oPvDDC/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfDZOuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:50:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3013 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:50:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc31ab30001>; Fri, 26 Apr 2019 07:50:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 07:50:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 07:50:21 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 14:50:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 14:50:20 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc31aac0002>; Fri, 26 Apr 2019 07:50:20 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <linux-usb@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jim Lin <jilin@nvidia.com>
Subject: [PATCH 2/6] usb: isp1760:Adjusted for usb_hub_clear_tt_buffer
Date:   Fri, 26 Apr 2019 22:50:18 +0800
Message-ID: <1556290218-9436-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556290227; bh=NxQERjSCGZyhDFxGHImVNe7OVFgLr0UrsSrAMz86Ix8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=oPvDDC/sC45alIZG5yMQWjzgcGYfp9OfpdNa2wyM00FdYGssE7vpvwU6l9YHgMonb
         SlCGCfMNHQsX8hgRZqIo/NoC7mzBHKXw/kJthdXrGC3x82E8BbR/GMN1gbyvVZ0alP
         vc749KroF3z9ogJTMNp3CaJC7KFg/ZHVqrbHPdh1XVZU57Iogjw8WX+uwPUyx4cMRF
         CsgJ8+iioMZyExeRAwZ6UABneBk7cmFMKV5HZ89lEd2lFVeuNppj2Xzewnpm0CojO/
         NJWdTvCCB3yNieIBCeR7AZZz8WXobYZ2HRJOdpyh0L/RHEO3K8Ks5VnuTsCoEi1CCA
         ZbL0iJONrcMfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add argument for usb_hub_clear_tt_buffer to specify device number
that will have the TT state of its hub cleared.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/isp1760/isp1760-hcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
index 8142c6b4c4cf..f1d68092becb 100644
--- a/drivers/usb/isp1760/isp1760-hcd.c
+++ b/drivers/usb/isp1760/isp1760-hcd.c
@@ -1166,7 +1166,8 @@ static void handle_done_ptds(struct usb_hcd *hcd)
 					(qtd->urb->status != -EPIPE) &&
 					(qtd->urb->status != -EREMOTEIO)) {
 				qh->tt_buffer_dirty = 1;
-				if (usb_hub_clear_tt_buffer(qtd->urb))
+				if (usb_hub_clear_tt_buffer(qtd->urb,
+						qtd->urb->dev->devnum))
 					/* Clear failed; let's hope things work
 					   anyway */
 					qh->tt_buffer_dirty = 0;
@@ -1633,7 +1634,7 @@ static void dequeue_urb_from_qtd(struct usb_hcd *hcd, struct isp1760_qh *qh,
 
 	if ((urb->dev->speed != USB_SPEED_HIGH) && urb_was_running) {
 		qh->tt_buffer_dirty = 1;
-		if (usb_hub_clear_tt_buffer(urb))
+		if (usb_hub_clear_tt_buffer(urb, urb->dev->devnum))
 			/* Clear failed; let's hope things work anyway */
 			qh->tt_buffer_dirty = 0;
 	}
-- 
2.1.4

