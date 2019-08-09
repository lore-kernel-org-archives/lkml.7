Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B13C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AB02166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY6YN0Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404864AbfHIA1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:27:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39605 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfHIA1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:27:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so94122054qtu.6;
        Thu, 08 Aug 2019 17:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11xnYV0nLuTfHH50YX7WG8U4a7R04qxCQzIia3Aq77A=;
        b=DY6YN0HidRLoCjDAVy75tPCMpvaFqFDYG77GX+XnUoZwnRS6PXKQGa8fKrzJ5Leslv
         ZIMyxR4gMHDP2lb5pPOdurSKUha5/jWlJZRYMmZ/wn2yQ0UuyVuFdTKWNSZclYg4DrPr
         Cv+uOS1GWI/u9pPja1fWsirXQfNeZeQJypEiUin8+0FRoVRtBb3dA/RcOm6Y4TKQoee3
         L5PJX/NTOwehJbIEI6gdtU7hUwM0Srj8HQpowFRULXz+9l5sH8q+ezJbHqpNvrtRGB2s
         DdSjx5d58TI6BwYXDCF9+xDoyKtPfrVoWeyJP+uZRlXh0lOJRAP8COg4vn5h9BbjdOJk
         V6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11xnYV0nLuTfHH50YX7WG8U4a7R04qxCQzIia3Aq77A=;
        b=a5xWJfFJFpHnE+E9aAOTOgG+X2E70uFDjLv21ag+8MuKeCQ7M4slD6PPa4rN0qzRAs
         +/Jj9NgDjXZzKxINYoNpy3AlnscSQa2z3n7KIqh+nwmkPWiW+zzZn+oVeEP3f4D8Y+X7
         nZ+vJnn+vZwiFOiTfQkJy6mpu0I8Ew9IWxPDXjIFpQG4Ezxkrj19+n1U9Lm1CE0vLodr
         tKu+3qn3bPzC6YSRJhTs4D8V1fzboyb7SAdiDFD5LctJUtt2wEr3TTMQYz7upNho0S40
         9uArltLjbatJ6PAOxF6iEqlFaBAFSeZpgjQaVQZCqDkXWa074nJb2q8kkw07HYqvPWjN
         fumA==
X-Gm-Message-State: APjAAAWt6RklQmZ4xGrXw+UPFOBaeJiJf/u6t53O/ss89DAI3jpZ2pr2
        kP9BTCD4N4BvyXwvkL5408IqEQ1PkJc=
X-Google-Smtp-Source: APXvYqzK3eJvHmjsNqUI0sk+E12L5i8bn+3ZHOt03w4bAA9dG/xXnQ2sJX9qYmaDhOcccs5jDTjNFg==
X-Received: by 2002:ac8:32a1:: with SMTP id z30mr15816454qta.117.1565310467076;
        Thu, 08 Aug 2019 17:27:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7f0:20d6:c52:d75:1f0d:f1e9])
        by smtp.gmail.com with ESMTPSA id d71sm4489082qkg.70.2019.08.08.17.27.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 17:27:46 -0700 (PDT)
From:   =?UTF-8?q?Lucas=20A=2E=20M=2E=20Magalh=C3=A3es?= 
        <lucmaga@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        kernel@collabora.com, skhan@linuxfoundation.org,
        helen.koike@collabora.com,
        "Lucas A . M . Magalhaes" <lucmaga@gmail.com>
Subject: [PATCH v2 1/2] media: Revert "media: vimc: Remove or modify stream checks"
Date:   Thu,  8 Aug 2019 21:27:40 -0300
Message-Id: <b3eec274c34f7516acf0b963587f6e094f2fe01a.1565309305.git.lucmaga@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helen Koike <helen.koike@collabora.com>

This reverts commit 3c1b9ac753e99005d7ee0a883d6e5b577ba32aa9.

Required to Revert "media: vimc: propagate pixel format in the stream"
which introduced the stream object in the vimc_ent_device struct.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Lucas A. M. Magalhaes <lucmaga@gmail.com>
---

I'm just helping out Helen by solving this patch set conflicts.
There was no conflict in this patch.

 drivers/media/platform/vimc/vimc-debayer.c | 5 ++++-
 drivers/media/platform/vimc/vimc-scaler.c  | 7 +++++--
 drivers/media/platform/vimc/vimc-sensor.c  | 6 +++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
index 00598fbf3cba..72adba6cf892 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -262,7 +262,7 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vdeb->ved.stream)
+		if (vdeb->src_frame)
 			return -EBUSY;
 
 		sink_fmt = &vdeb->sink_fmt;
@@ -329,6 +329,9 @@ static int vimc_deb_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
+		if (vdeb->src_frame)
+			return 0;
+
 		/* We only support translating bayer to RGB24 */
 		if (src_pixelformat != V4L2_PIX_FMT_RGB24) {
 			dev_err(vdeb->dev,
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index c7123a45c55b..5f31c1e351a3 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -148,7 +148,7 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vsca->ved.stream)
+		if (vsca->src_frame)
 			return -EBUSY;
 
 		sink_fmt = &vsca->sink_fmt;
@@ -203,6 +203,9 @@ static int vimc_sca_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
+		if (vsca->src_frame)
+			return 0;
+
 		if (!vimc_sca_is_pixfmt_supported(pixelformat)) {
 			dev_err(vsca->dev, "pixfmt (0x%08x) is not supported\n",
 				pixelformat);
@@ -324,7 +327,7 @@ static void *vimc_sca_process_frame(struct vimc_ent_device *ved,
 						    ved);
 
 	/* If the stream in this node is not active, just return */
-	if (!ved->stream)
+	if (!vsca->src_frame)
 		return ERR_PTR(-EINVAL);
 
 	vimc_sca_fill_src_frame(vsca, sink_frame);
diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 51359472eef2..c47454cc7f70 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -131,7 +131,7 @@ static int vimc_sen_set_fmt(struct v4l2_subdev *sd,
 
 	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		/* Do not change the format while stream is on */
-		if (vsen->ved.stream)
+		if (vsen->frame)
 			return -EBUSY;
 
 		mf = &vsen->mbus_format;
@@ -187,6 +187,10 @@ static int vimc_sen_s_stream(struct v4l2_subdev *sd, int enable)
 		const struct v4l2_format_info *pix_info;
 		unsigned int frame_size;
 
+		if (vsen->kthread_sen)
+			/* tpg is already executing */
+			return 0;
+
 		/* Calculate the frame size */
 		pix_info = v4l2_format_info(pixelformat);
 		frame_size = vsen->mbus_format.width * pix_info->bpp[0] *
-- 
2.23.0.rc1

