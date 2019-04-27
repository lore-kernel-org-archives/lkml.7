Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ABCC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15C0206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfD0PXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:23:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34704 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728179AbfD0PXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:23:30 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zQ-NR; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004RG-C8; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Thierry Reding" <treding@nvidia.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.874292778@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 046/202] media: v4l: ioctl: Validate num_planes for
 debug messages
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 7fe9f01c04c2673bd6662c35b664f0f91888b96f upstream.

The num_planes field in struct v4l2_pix_format_mplane is used in a loop
before validating it. As the use is printing a debug message in this case,
just cap the value to the maximum allowed.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -247,6 +247,7 @@ static void v4l_print_format(const void
 	const struct v4l2_sliced_vbi_format *sliced;
 	const struct v4l2_window *win;
 	const struct v4l2_sdr_format *sdr;
+	u32 planes;
 	unsigned i;
 
 	pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
@@ -279,7 +280,8 @@ static void v4l_print_format(const void
 			(mp->pixelformat >> 24) & 0xff,
 			prt_names(mp->field, v4l2_field_names),
 			mp->colorspace, mp->num_planes);
-		for (i = 0; i < mp->num_planes; i++)
+		planes = min_t(u32, mp->num_planes, VIDEO_MAX_PLANES);
+		for (i = 0; i < planes; i++)
 			printk(KERN_DEBUG "plane %u: bytesperline=%u sizeimage=%u\n", i,
 					mp->plane_fmt[i].bytesperline,
 					mp->plane_fmt[i].sizeimage);

