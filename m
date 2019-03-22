Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835D9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257387;
	bh=+Gbdkue/KXi0wqxgHGgUKIVeCevhPx/vl/j4vnb5YqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SXePqj33pJ8heP8V6Nt2GnPgwmvKePIvr7wrUmU6rA/0aKaA07ZolZGz0BtVdFaPS
	 KewRWajD26BhV8ByPUJjo5V4dqDIOL9CDk9tJ5e4AC9TxRgzDEbXimX+KBkSzU3JlO
	 7Nhs4VORfXJtx6WHIIfxLKT0dnh2N+N3ha9GBjI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbfCVMXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390731AbfCVMXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643D3218A1;
        Fri, 22 Mar 2019 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257382;
        bh=+Gbdkue/KXi0wqxgHGgUKIVeCevhPx/vl/j4vnb5YqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkPBBMNGIdodZ1721n4L136je0lHc1/PuCgpRDxpxEsLkUSL760G6yIPoanWp1xVm
         thplTYAHNViQUw+6czz9HlLJagep5pPbIOV8mFb6KIAwmCyff2l0AGq/ty22OhM5Tg
         To0/1EQ/OZDVfQZvW494cdZgqN+sctHOWk4kdwSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 215/238] media: uvcvideo: Avoid NULL pointer dereference at the end of streaming
Date:   Fri, 22 Mar 2019 12:17:14 +0100
Message-Id: <20190322111310.969306751@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 9dd0627d8d62a7ddb001a75f63942d92b5336561 upstream.

The UVC video driver converts the timestamp from hardware specific unit
to one known by the kernel at the time when the buffer is dequeued. This
is fine in general, but the streamoff operation consists of the
following steps (among other things):

1. uvc_video_clock_cleanup --- the hardware clock sample array is
   released and the pointer to the array is set to NULL,

2. buffers in active state are returned to the user and

3. buf_finish callback is called on buffers that are prepared.
   buf_finish includes calling uvc_video_clock_update that accesses the
   hardware clock sample array.

The above is serialised by a queue specific mutex. Address the problem
by skipping the clock conversion if the hardware clock sample array is
already released.

Fixes: 9c0863b1cc48 ("[media] vb2: call buf_finish from __queue_cancel")

Reported-by: Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Tested-by: Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_video.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -676,6 +676,14 @@ void uvc_video_clock_update(struct uvc_s
 	if (!uvc_hw_timestamps_param)
 		return;
 
+	/*
+	 * We will get called from __vb2_queue_cancel() if there are buffers
+	 * done but not dequeued by the user, but the sample array has already
+	 * been released at that time. Just bail out in that case.
+	 */
+	if (!clock->samples)
+		return;
+
 	spin_lock_irqsave(&clock->lock, flags);
 
 	if (clock->count < clock->size)


