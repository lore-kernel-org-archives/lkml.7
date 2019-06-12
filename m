Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F13C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D9F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7wTl0xJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408289AbfFLBRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:17:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34994 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404906AbfFLBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:17:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so5886558plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y+UdVFpKtToAwMpoojIPPMwSl93o12ffMgVZ1H7mtl0=;
        b=D7wTl0xJ9F9JNFbnpTSHd+uoY6rphqSDyENrPDTK9vqlDIunQWMaqUioQjDoy8GOn4
         PRfOm6EUnzHx8fFcmQABEkb4Ub/N40sRuuAjchjz62qc2+rsm/3QrItPVf/khd6FJSdq
         EClNsiNub7upjMZbKe7DPBkqOy+tkJNTRJK3FpcloYfk+K2DlvzWAz5Z7FZNE2KdtQJ1
         NKz64kYmroru5tlFuqKGNb/g16+K+53I3kk8Vrd6fx4RTRlC+FZSkwwmBicr30wBqCaa
         fcT0BEmLoSKGtoOcpq6AzEMPZoknHBg9Dat/rMYiX+S+3tO5Nk21z1JIgXQFJ5QTzGPf
         Dj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y+UdVFpKtToAwMpoojIPPMwSl93o12ffMgVZ1H7mtl0=;
        b=goREo5ShOCc6AD72dhTQBmZcT0HvKH1pNO/HWurL5ughHm0ZUa3HzjpfJf8pHyKnuz
         ZCNGoONu2rgZbS4jpyPZFN035A55vvWMtQ/tbGgrgRTNp4uZtsLZNk+T1wPh8V3apTWN
         PJkKyca9fyrpTTFHCKf3ACxSpAbEGFz7uQy7DpVDIfgyhiuQmpkJu7PnoBtDGbgSMwpo
         ZeFWoXIHrvQNeYq6qI7FlJv85cMt++dSg4vNUX3aSV0Obc62E253FPUkxL4bEAgHT7gi
         pJSTGFg0bsvD9q0seDfUcO6p+GIKcYqx/OSax6diECYPtQBDFkhQHOUOCAE4vq1H3L+R
         69MQ==
X-Gm-Message-State: APjAAAWAeIsGPqUIJmtlMLL5Ng90haGae8lAuhiC/FrFI9x+HJ9PKF70
        VieNaAr/jUYXmM2jzakYqco=
X-Google-Smtp-Source: APXvYqxR5efuvwybOL9xJecB56NAS7Qtog+UTb5ZkWMaesBYdMmalfp6I+k64C3dYE6NO9uoto9mQw==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr56329787plo.217.1560302223851;
        Tue, 11 Jun 2019 18:17:03 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-107-3-185-39.hsd1.ca.comcast.net. [107.3.185.39])
        by smtp.gmail.com with ESMTPSA id y22sm13257015pgj.38.2019.06.11.18.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:17:03 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] gpu: ipu-v3: image-convert: Fix input bytesperline width/height align
Date:   Tue, 11 Jun 2019 18:16:55 -0700
Message-Id: <20190612011657.12119-1-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output width and height alignment values were being used in the
input bytesperline calculation. Fix by separating local vars w_align
and h_align into w_align_in, h_align_in, w_align_out, and h_align_out.

Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
adjustment")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 32 +++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 36e88434513a..36eb4c77ad91 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1876,7 +1876,8 @@ void ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
 			      enum ipu_rotate_mode rot_mode)
 {
 	const struct ipu_image_pixfmt *infmt, *outfmt;
-	u32 w_align, h_align;
+	u32 w_align_out, h_align_out;
+	u32 w_align_in, h_align_in;
 
 	infmt = get_format(in->pix.pixelformat);
 	outfmt = get_format(out->pix.pixelformat);
@@ -1908,22 +1909,31 @@ void ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
 	}
 
 	/* align input width/height */
-	w_align = ilog2(tile_width_align(IMAGE_CONVERT_IN, infmt, rot_mode));
-	h_align = ilog2(tile_height_align(IMAGE_CONVERT_IN, infmt, rot_mode));
-	in->pix.width = clamp_align(in->pix.width, MIN_W, MAX_W, w_align);
-	in->pix.height = clamp_align(in->pix.height, MIN_H, MAX_H, h_align);
+	w_align_in = ilog2(tile_width_align(IMAGE_CONVERT_IN, infmt,
+					    rot_mode));
+	h_align_in = ilog2(tile_height_align(IMAGE_CONVERT_IN, infmt,
+					     rot_mode));
+	in->pix.width = clamp_align(in->pix.width, MIN_W, MAX_W,
+				    w_align_in);
+	in->pix.height = clamp_align(in->pix.height, MIN_H, MAX_H,
+				     h_align_in);
 
 	/* align output width/height */
-	w_align = ilog2(tile_width_align(IMAGE_CONVERT_OUT, outfmt, rot_mode));
-	h_align = ilog2(tile_height_align(IMAGE_CONVERT_OUT, outfmt, rot_mode));
-	out->pix.width = clamp_align(out->pix.width, MIN_W, MAX_W, w_align);
-	out->pix.height = clamp_align(out->pix.height, MIN_H, MAX_H, h_align);
+	w_align_out = ilog2(tile_width_align(IMAGE_CONVERT_OUT, outfmt,
+					     rot_mode));
+	h_align_out = ilog2(tile_height_align(IMAGE_CONVERT_OUT, outfmt,
+					      rot_mode));
+	out->pix.width = clamp_align(out->pix.width, MIN_W, MAX_W,
+				     w_align_out);
+	out->pix.height = clamp_align(out->pix.height, MIN_H, MAX_H,
+				      h_align_out);
 
 	/* set input/output strides and image sizes */
 	in->pix.bytesperline = infmt->planar ?
-		clamp_align(in->pix.width, 2 << w_align, MAX_W, w_align) :
+		clamp_align(in->pix.width, 2 << w_align_in, MAX_W,
+			    w_align_in) :
 		clamp_align((in->pix.width * infmt->bpp) >> 3,
-			    2 << w_align, MAX_W, w_align);
+			    2 << w_align_in, MAX_W, w_align_in);
 	in->pix.sizeimage = infmt->planar ?
 		(in->pix.height * in->pix.bytesperline * infmt->bpp) >> 3 :
 		in->pix.height * in->pix.bytesperline;
-- 
2.17.1

