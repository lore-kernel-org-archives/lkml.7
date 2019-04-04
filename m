Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479E8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A252171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367981;
	bh=VfnnB7An0fGf7stQVSm2p9DOftpbW0VYZpz3zHsWEqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spii1PVXj/I0rHmw8xq4GgbVn4Q23dKXK6oCaCcxIPwreHde/FRm7WHGDMW7EiZue
	 VLSKRpBO0gkpfdjwN0svNWm6ntA4MEIzLk7yOIzTzZMT1s+wxvnHVJiADDEdvtwg6b
	 ZpedVBr/y6rDa5a3zzDAzxdfvkNStxxJ6t9dkieQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfDDIw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbfDDIwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5312220882;
        Thu,  4 Apr 2019 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367974;
        bh=VfnnB7An0fGf7stQVSm2p9DOftpbW0VYZpz3zHsWEqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcC9tBzig+WKU0nHYAPb4MQEoGo6MOx5ZbEKsjzhCqT1YiIQmyO36HvnLz1tuXRuY
         u5szkdOXHzPvVvuY4Ai3eus0CXQQ3vnk6SzWOUSXOwAN1ZWa8aGlCV6lYKDagpvWZt
         +o6hy2esYKI53jD4rC9Z0/WGh8ZB2b9iqyLxWQzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 82/91] media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration
Date:   Thu,  4 Apr 2019 10:48:06 +0200
Message-Id: <20190404084540.196898062@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 49710c32cd9d6626a77c9f5f978a5f58cb536b35 ]

Previously when doing format enumeration, it was returning all
 formats supported by driver, even if they're not supported by hw.
Add missing check for fmt_ver_flag, so it'll be fixed and only those
 supported by hw will be returned. Similar thing is already done
 in s5p_jpeg_find_format.

It was found by using v4l2-compliance tool and checking result
 of VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS test
and using v4l2-ctl to get list of all supported formats.

Tested on s5pv210-galaxys (Samsung i9000 phone).

Fixes: bb677f3ac434 ("[media] Exynos4 JPEG codec v4l2 driver")

Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
[hverkuil-cisco@xs4all.nl: fix a few alignment issues]
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-jpeg/jpeg-core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
index 06e2b72d07ca..c89922fb42ce 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
@@ -1264,13 +1264,16 @@ static int s5p_jpeg_querycap(struct file *file, void *priv,
 	return 0;
 }
 
-static int enum_fmt(struct s5p_jpeg_fmt *sjpeg_formats, int n,
+static int enum_fmt(struct s5p_jpeg_ctx *ctx,
+		    struct s5p_jpeg_fmt *sjpeg_formats, int n,
 		    struct v4l2_fmtdesc *f, u32 type)
 {
 	int i, num = 0;
+	unsigned int fmt_ver_flag = ctx->jpeg->variant->fmt_ver_flag;
 
 	for (i = 0; i < n; ++i) {
-		if (sjpeg_formats[i].flags & type) {
+		if (sjpeg_formats[i].flags & type &&
+		    sjpeg_formats[i].flags & fmt_ver_flag) {
 			/* index-th format of type type found ? */
 			if (num == f->index)
 				break;
@@ -1297,11 +1300,11 @@ static int s5p_jpeg_enum_fmt_vid_cap(struct file *file, void *priv,
 	struct s5p_jpeg_ctx *ctx = fh_to_ctx(priv);
 
 	if (ctx->mode == S5P_JPEG_ENCODE)
-		return enum_fmt(sjpeg_formats, SJPEG_NUM_FORMATS, f,
+		return enum_fmt(ctx, sjpeg_formats, SJPEG_NUM_FORMATS, f,
 				SJPEG_FMT_FLAG_ENC_CAPTURE);
 
-	return enum_fmt(sjpeg_formats, SJPEG_NUM_FORMATS, f,
-					SJPEG_FMT_FLAG_DEC_CAPTURE);
+	return enum_fmt(ctx, sjpeg_formats, SJPEG_NUM_FORMATS, f,
+			SJPEG_FMT_FLAG_DEC_CAPTURE);
 }
 
 static int s5p_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
@@ -1310,11 +1313,11 @@ static int s5p_jpeg_enum_fmt_vid_out(struct file *file, void *priv,
 	struct s5p_jpeg_ctx *ctx = fh_to_ctx(priv);
 
 	if (ctx->mode == S5P_JPEG_ENCODE)
-		return enum_fmt(sjpeg_formats, SJPEG_NUM_FORMATS, f,
+		return enum_fmt(ctx, sjpeg_formats, SJPEG_NUM_FORMATS, f,
 				SJPEG_FMT_FLAG_ENC_OUTPUT);
 
-	return enum_fmt(sjpeg_formats, SJPEG_NUM_FORMATS, f,
-					SJPEG_FMT_FLAG_DEC_OUTPUT);
+	return enum_fmt(ctx, sjpeg_formats, SJPEG_NUM_FORMATS, f,
+			SJPEG_FMT_FLAG_DEC_OUTPUT);
 }
 
 static struct s5p_jpeg_q_data *get_q_data(struct s5p_jpeg_ctx *ctx,
-- 
2.19.1



