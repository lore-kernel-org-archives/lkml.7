Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E88C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0636C21835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004081;
	bh=FXLWGfb+mUAqSMXTCRBzIGJizba0Ms/m50Fos2BtZL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XnneXDrnduCgHfTAyDDN2S+C2bC1htCPDPCc+p15uh/CauzxFHXxqPeIhwZwSoN/S
	 Kvh5bY0jsD1t4SeMe0bt4D7UkzHDgikNMc2Hgtw1V3l54TiW9ZpIPVT8/AdKHXMA+V
	 aW23daxV3TOBN/5WLlJjhcBIyWaIwHB41z0KKBsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgABW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbgABW15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:27:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB78020866;
        Thu,  2 Jan 2020 22:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004077;
        bh=FXLWGfb+mUAqSMXTCRBzIGJizba0Ms/m50Fos2BtZL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDXHouV3d+iUU+TEWRypRKvp8hSLRMPOg1QN8fPpnbIvRHVV5/kwrtjMKPeMVVasU
         kNO/n3aTZIAMFqSPUSTN1DmEoMHC5QTJ0RgzoM2QmzAtrq3KlGaPQi4oWnTUqeEKJ3
         vcc/GdjLjyPvZl6XEoSxzOzUGjNrLt/iYyvCCFOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 028/171] media: ti-vpe: vpe: fix a v4l2-compliance warning about invalid pixel format
Date:   Thu,  2 Jan 2020 23:05:59 +0100
Message-Id: <20200102220550.958914081@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit 06bec72b250b2cb3ba96fa45c2b8e0fb83745517 ]

v4l2-compliance warns with this message:

   warn: v4l2-test-formats.cpp(717): \
 	TRY_FMT cannot handle an invalid pixelformat.
   warn: v4l2-test-formats.cpp(718): \
 	This may or may not be a problem. For more information see:
   warn: v4l2-test-formats.cpp(719): \
 	http://www.mail-archive.com/linux-media@vger.kernel.org/msg56550.html
	...
   test VIDIOC_TRY_FMT: FAIL

We need to make sure that the returns a valid pixel format in all
instance. Based on the v4l2 framework convention drivers must return a
valid pixel format when the requested pixel format is either invalid or
not supported.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti-vpe/vpe.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 0189f7f7cb03..da308fa6561f 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -330,20 +330,25 @@ enum {
 };
 
 /* find our format description corresponding to the passed v4l2_format */
-static struct vpe_fmt *find_format(struct v4l2_format *f)
+static struct vpe_fmt *__find_format(u32 fourcc)
 {
 	struct vpe_fmt *fmt;
 	unsigned int k;
 
 	for (k = 0; k < ARRAY_SIZE(vpe_formats); k++) {
 		fmt = &vpe_formats[k];
-		if (fmt->fourcc == f->fmt.pix.pixelformat)
+		if (fmt->fourcc == fourcc)
 			return fmt;
 	}
 
 	return NULL;
 }
 
+static struct vpe_fmt *find_format(struct v4l2_format *f)
+{
+	return __find_format(f->fmt.pix.pixelformat);
+}
+
 /*
  * there is one vpe_dev structure in the driver, it is shared by
  * all instances.
@@ -1433,9 +1438,9 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
 	int i, depth, depth_bytes;
 
 	if (!fmt || !(fmt->types & type)) {
-		vpe_err(ctx->dev, "Fourcc format (0x%08x) invalid.\n",
+		vpe_dbg(ctx->dev, "Fourcc format (0x%08x) invalid.\n",
 			pix->pixelformat);
-		return -EINVAL;
+		fmt = __find_format(V4L2_PIX_FMT_YUYV);
 	}
 
 	if (pix->field != V4L2_FIELD_NONE && pix->field != V4L2_FIELD_ALTERNATE)
-- 
2.20.1



