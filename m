Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F1C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E3821019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2CJHuP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDFXJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:09:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41765 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDFXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:09:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so5064466plj.8;
        Sat, 06 Apr 2019 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LWWo6vClK616q2qAdH10ez3h7JYhnb9DJf05zCL0Rc=;
        b=u2CJHuP+mlcuAlWQcV+owWFbPFC6wVKcWwh80i3aZoFl6gw7mh5esYsKmDURBbknUz
         Sn41Ks+a/L9sB8YjmtAKfSAMLmUcQXxk2Tz8DKhwKfvp1VfVBhEGhx1E0NDtYeVVB4H3
         7Yx5JnFro5faXv5HURzYnPsE2qdpAr5adYXFkQu0izPsARg5pDtEYAonqBbzxZSBTkUU
         kJAt3PZewG//fUrFwXweB8fimmt8QFh+qF/bm1LE2NkFJJmwoZDW+KA9D8G7vOeh+63F
         Kcbcsvu+3ntHxUSRF04o7HSte/O8ZjIdEuy0rVSnDXCwV/1vFu9J6p0r8CR4L/v+3EA5
         bLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LWWo6vClK616q2qAdH10ez3h7JYhnb9DJf05zCL0Rc=;
        b=TpI/Zv+Zg/AGWm4qRqjjGNQ8GsBns81cHCuqK7NoAQy6cx94kvZIJOi199RA3B7VcI
         oyncCEyEdLQ+DuQa0Fs+I52BXr7mnZENhKYbbeCzgCqX0fHJ85qG1hIfIEHSFEQwca7E
         xROD3R33rbU5XgwGZMU5+KqFWRMRR9Yoi6D8Kn8RaPWjH0sXkK1sqmWAmKbEaV8Q2Zxs
         ADqlrveW1Z096gkB4DVK1H8bHpAiXWXgx4wDq0qWDadh0b4e1z5FLY2fkkBuJJeKq+1F
         tAMwBkUvNWSpWtfe8m4jPNC42tp1s6av3sIVXIGpDNbJe4wGuGZQgOcmOWMqmyNzQktp
         6j+A==
X-Gm-Message-State: APjAAAWgH4rx3foaAJ185vbbyAkCs/yP+/TZ7NsYApKr6VzKOx1ekTxp
        E5U59jNhKfhYLLVo1EsE4toFDCfP
X-Google-Smtp-Source: APXvYqyB2zkXHJyKOMcaXbH72PsVzQ752yWo+UhPbj8OCDS9YFc0h8937cv0rgq2n+jqie8Vt7IIsA==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20mr21626181pll.263.1554592158783;
        Sat, 06 Apr 2019 16:09:18 -0700 (PDT)
Received: from mappy.sklembedded.com (c-24-4-228-186.hsd1.ca.comcast.net. [24.4.228.186])
        by smtp.gmail.com with ESMTPSA id i31sm44550127pgi.36.2019.04.06.16.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 16:09:18 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 4/5] gpu: ipu-v3: ipu-ic-csc: Add support for Rec.709 encoding
Date:   Sat,  6 Apr 2019 16:09:02 -0700
Message-Id: <20190406230903.16488-5-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406230903.16488-1-slongerbeam@gmail.com>
References: <20190406230903.16488-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Rec.709 encoding and inverse encoding.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes in v7:
- moved CSC tables to new module ipu-ic-csc.c.
- express negative coefficients as true signed int's, for better
  readability.
Changes in v5:
- moved API changes to a previous patch.
- moved CSC coeff calc to new function calc_csc_coeffs().
Changes in v4:
- fix compile error.
Chnges in v3:
- none.
Changes in v2:
- only return "Unsupported YCbCr encoding" error if inf != outf,
  since if inf == outf, the identity matrix can be used. Reported
  by Tim Harvey.
---
 drivers/gpu/ipu-v3/ipu-ic-csc.c | 139 ++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic-csc.c b/drivers/gpu/ipu-v3/ipu-ic-csc.c
index 8e9150b1d668..09e94aa12c40 100644
--- a/drivers/gpu/ipu-v3/ipu-ic-csc.c
+++ b/drivers/gpu/ipu-v3/ipu-ic-csc.c
@@ -230,14 +230,133 @@ static const struct ipu_ic_csc_params *yuv2rgb_601[] = {
 	&yuvl2rgbl_601,
 };
 
+/*
+ * REC.709 encoding from RGB full range to YUV full range:
+ *
+ * Y =  .2126 * R + .7152 * G + .0722 * B
+ * U = -.1146 * R - .3854 * G + .5000 * B + 128
+ * V =  .5000 * R - .4542 * G - .0458 * B + 128
+ */
+static const struct ipu_ic_csc_params rgbf2yuvf_709 = {
+	.coeff = {
+		{  54,  183,  19 },
+		{ -29,  -99, 128 },
+		{ 128, -116, -12 },
+	},
+	.offset = { 0, 512, 512 },
+	.scale = 1,
+};
+
+/* Rec.709 RGB full-range to YUV limited-range */
+static const struct ipu_ic_csc_params rgbf2yuvl_709 = {
+	.coeff = {
+		{   47,  157,   16, },
+		{  -26,  -87,  112, },
+		{  112, -102,  -10, },
+	},
+	.offset = { 64, 512, 512, },
+	.scale = 1,
+	.sat = true,
+};
+
+/* Rec.709 RGB limited-range to YUV full-range */
+static const struct ipu_ic_csc_params rgbl2yuvf_709 = {
+	.coeff = {
+		{   63,  213,   22, },
+		{  -34, -115,  149, },
+		{  149, -135,  -14, },
+	},
+	.offset = { -75, 512, 512, },
+	.scale = 1,
+};
+
+/* Rec.709 RGB limited-range to YUV limited-range */
+static const struct ipu_ic_csc_params rgbl2yuvl_709 = {
+	.coeff = {
+		{   54,  183,   18, },
+		{  -30, -101,  131, },
+		{  131, -119,  -12, },
+	},
+	.offset = { 0, 512, 512, },
+	.scale = 1,
+	.sat = true,
+};
+
+/*
+ * Inverse REC.709 encoding from YUV full range to RGB full range:
+ *
+ * R = 1. * Y +      0 * (Cb - 128) + 1.5748 * (Cr - 128)
+ * G = 1. * Y -  .1873 * (Cb - 128) -  .4681 * (Cr - 128)
+ * B = 1. * Y + 1.8556 * (Cb - 128) +      0 * (Cr - 128)
+ *
+ * equivalently (factoring out the offsets):
+ *
+ * R = 1. * Y  +      0 * Cb + 1.5748 * Cr - 201.574
+ * G = 1. * Y  -  .1873 * Cb -  .4681 * Cr +  83.891
+ * B = 1. * Y  + 1.8556 * Cb +      0 * Cr - 237.517
+ */
+static const struct ipu_ic_csc_params yuvf2rgbf_709 = {
+	.coeff = {
+		{  128,   0, 202 },
+		{  128, -24, -60 },
+		{  128, 238,   0 },
+	},
+	.offset = { -403, 168, -475 },
+	.scale = 2,
+};
+
+/* Rec.709 YUV full-range to RGB limited-range */
+static const struct ipu_ic_csc_params yuvf2rgbl_709 = {
+	.coeff = {
+		{  110,    0,  173, },
+		{  110,  -21,  -51, },
+		{  110,  204,    0, },
+	},
+	.offset = { -314, 176, -376, },
+	.scale = 2,
+};
+
+/* Rec.709 YUV limited-range to RGB full-range */
+static const struct ipu_ic_csc_params yuvl2rgbf_709 = {
+	.coeff = {
+		{   75,    0,  115, },
+		{   75,  -14,  -34, },
+		{   75,  135,    0, },
+	},
+	.offset = { -248, 77, -289, },
+	.scale = 3,
+};
+
+/* Rec.709 YUV limited-range to RGB limited-range */
+static const struct ipu_ic_csc_params yuvl2rgbl_709 = {
+	.coeff = {
+		{  128,    0,  197, },
+		{  128,  -23,  -59, },
+		{  128,  232,    0, },
+	},
+	.offset = { -394, 164, -464, },
+	.scale = 2,
+};
+
+static const struct ipu_ic_csc_params *rgb2yuv_709[] = {
+	&rgbf2yuvf_709,
+	&rgbf2yuvl_709,
+	&rgbl2yuvf_709,
+	&rgbl2yuvl_709,
+};
+
+static const struct ipu_ic_csc_params *yuv2rgb_709[] = {
+	&yuvf2rgbf_709,
+	&yuvf2rgbl_709,
+	&yuvl2rgbf_709,
+	&yuvl2rgbl_709,
+};
+
 static int calc_csc_coeffs(struct ipu_ic_csc *csc)
 {
 	const struct ipu_ic_csc_params **params_tbl;
 	int tbl_idx;
 
-	if (csc->out_cs.enc != V4L2_YCBCR_ENC_601)
-		return -ENOTSUPP;
-
 	tbl_idx = (QUANT_MAP(csc->in_cs.quant) << 1) |
 		QUANT_MAP(csc->out_cs.quant);
 
@@ -250,8 +369,18 @@ static int calc_csc_coeffs(struct ipu_ic_csc *csc)
 
 	/* YUV <-> RGB encoding is required */
 
-	params_tbl = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
-		yuv2rgb_601 : rgb2yuv_601;
+	switch (csc->out_cs.enc) {
+	case V4L2_YCBCR_ENC_601:
+		params_tbl = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
+			yuv2rgb_601 : rgb2yuv_601;
+		break;
+	case V4L2_YCBCR_ENC_709:
+		params_tbl = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
+			yuv2rgb_709 : rgb2yuv_709;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
 
 	csc->params = *params_tbl[tbl_idx];
 
-- 
2.17.1

