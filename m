Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B762C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69B21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254767;
	bh=y7orHly8pY4hOrfuf0vM8Bm1e8V3a83myHjWFa0wJLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eALGTqI2aia3L7jPY5p1vSaTin+jcMb3povezUaLNn6tXB+LSeJvats8IjVv5BdUU
	 goC44KvYYqjX1vioSkahSy0SxKdYXV8fuV2iv4EGN5CQrYG5pFoSeINynltDLheAcj
	 z3Y70FHj/kZxA9QbDWKNmuLUSXr+siAJekBIRLrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfCVLjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfCVLjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:39:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA59A2082C;
        Fri, 22 Mar 2019 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254761;
        bh=y7orHly8pY4hOrfuf0vM8Bm1e8V3a83myHjWFa0wJLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0IaTy1aGiE11wX4OGMmFbOYhDs7l0sc7IIPh4ETyg4QyEdzfquKHRDAWXeB6eLaF
         v7JnByFHohfT85JhrLgnzINEVlrGU3iQpZoNCMlQuk8y3kr6AuJOOYpV2th4+96FPC
         GOKswoSzwouX54LqJ2xlpyEq5ZTcsi8k4KhuIuIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.4 226/230] media: uvcvideo: Avoid NULL pointer dereference at the end of streaming
Date:   Fri, 22 Mar 2019 12:16:04 +0100
Message-Id: <20190322111252.811811099@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -638,6 +638,14 @@ void uvc_video_clock_update(struct uvc_s
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


