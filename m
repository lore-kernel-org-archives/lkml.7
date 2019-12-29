Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BFC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62947207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640742;
	bh=zKupZsP3hwBkIV+DX9F2WhuhPMqFF5B4PJdUbkfqzxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QVlTzpgi36A6X15O6+YFY72oGIiSstvmiAc1Jf1RyPkqkfg1uTWjVB+iNeFC2y/xp
	 Ek92OLAelQh5YUrdOEoOgukLvkD7entuFMUzg+gak1/jZfbxvB1v1USs/2bBIgiz39
	 Qp0B7H2NUQmpAmZNJLurZR0XItLv1ph8a51as9U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfL2RcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfL2RcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5138D20409;
        Sun, 29 Dec 2019 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640735;
        bh=zKupZsP3hwBkIV+DX9F2WhuhPMqFF5B4PJdUbkfqzxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYJYvj7ugvVZAf/Ck9KfrisEKAcb0g8XBT6tGhp8RaYe++Wkm2Rti6EIXsRAQkNx0
         8HZT6sesEpmzvwZytKQcZ73Oe9SDbeSxy/wDkT76YN94aWYbsVr4m5cYDnFMWcLGGC
         fXIjd7hmHqz1KzGhhDSjl57r6Bc2Q1PDUOc2pSOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vandana BN <bnvandana@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 116/219] media: v4l2-core: fix touch support in v4l_g_fmt
Date:   Sun, 29 Dec 2019 18:18:38 +0100
Message-Id: <20191229162526.206349119@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vandana BN <bnvandana@gmail.com>

[ Upstream commit 545b618cfb5cadacd00c25066b9a36540e5ca9e9 ]

v4l_s_fmt, for VFL_TYPE_TOUCH, sets unneeded members of
the v4l2_pix_format structure to default values.This was
missing in v4l_g_fmt, which would lead to failures in
v4l2-compliance tests.

Signed-off-by: Vandana BN <bnvandana@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index a4d3e94a400c..7675b645db2e 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1415,10 +1415,26 @@ static int v4l_enum_fmt(const struct v4l2_ioctl_ops *ops,
 	return ret;
 }
 
+static void v4l_pix_format_touch(struct v4l2_pix_format *p)
+{
+	/*
+	 * The v4l2_pix_format structure contains fields that make no sense for
+	 * touch. Set them to default values in this case.
+	 */
+
+	p->field = V4L2_FIELD_NONE;
+	p->colorspace = V4L2_COLORSPACE_RAW;
+	p->flags = 0;
+	p->ycbcr_enc = 0;
+	p->quantization = 0;
+	p->xfer_func = 0;
+}
+
 static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
 	struct v4l2_format *p = arg;
+	struct video_device *vfd = video_devdata(file);
 	int ret = check_fmt(file, p->type);
 
 	if (ret)
@@ -1456,6 +1472,8 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
 		ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
 		/* just in case the driver zeroed it again */
 		p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
+		if (vfd->vfl_type == VFL_TYPE_TOUCH)
+			v4l_pix_format_touch(&p->fmt.pix);
 		return ret;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
@@ -1491,21 +1509,6 @@ static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
 	return -EINVAL;
 }
 
-static void v4l_pix_format_touch(struct v4l2_pix_format *p)
-{
-	/*
-	 * The v4l2_pix_format structure contains fields that make no sense for
-	 * touch. Set them to default values in this case.
-	 */
-
-	p->field = V4L2_FIELD_NONE;
-	p->colorspace = V4L2_COLORSPACE_RAW;
-	p->flags = 0;
-	p->ycbcr_enc = 0;
-	p->quantization = 0;
-	p->xfer_func = 0;
-}
-
 static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
-- 
2.20.1



