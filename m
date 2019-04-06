Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C2C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0F1213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5F5TkFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDFXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:09:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33799 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDFXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:09:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so5069267plt.1;
        Sat, 06 Apr 2019 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KR2SKJZVR7dpL/K3IRH5SfiJbtnvBNtS7TM5fTzvwUU=;
        b=Y5F5TkFX0AnKxwmdZeCsztIQ2thjKHOFsP07ycnxDutXTty4MFyxoQuTznuq6QvUM4
         biPSvSIR03t4r/qfv2qio2Nsoi/tBM2lZnZbxRJrUCWaGrI2h9LN26g6uo4CuY/qcFa1
         d/HokLTzBGhBaqo8zDdF9/WlfKJXhuMXh6x8+32hVJ5JPlaykmMffjM74tJpsdParhzh
         C9iCwhGS1hKtQcnCo6yytJEDZdnwXLeshRAmYVfponTH2KpUQc5dWmDoNujKy+MCvO7E
         Pa1DZN/21kZDpQ3kiXLnoWdKoF8MbFuV5X5JmIazDzy2WUksWc8bxrzOzJbqqWTzhE9e
         vRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KR2SKJZVR7dpL/K3IRH5SfiJbtnvBNtS7TM5fTzvwUU=;
        b=lah5B5X7yC9VwrJWjJDvWYyaBUy4dauX0soMeG6ZoTntZK6QIBCRSvDeYX2FbLuUgx
         oQzg4Eefx2WqHva0az9wbEbsmoTX912RjRcsJaPnN+lPwsjraeqEsvQzNI3+GhyjjKxb
         euAp+g60fQdyWmn1dOSNvgeT2xuaV1f0TZ7FewQbcAK/bcCiGYu5wmsiv0gPIBwSqqlT
         quoTNAG1HZiz7Pn8pC7s7XXqlqcD0Wnei6OOUkagN2bTSv43xSDIJArRcsSI/HT7b7TL
         uPx3wfvcx1z/WHmu5kwxmApSapuilYvHIg/K2SNyFJsxdUjIR37M+b0S1MTshTONOK29
         UN4Q==
X-Gm-Message-State: APjAAAV02KAv8VwuUPbhEv32fAFJulLyC62SCZl0JTPB9xhQiG+RKPL0
        Iipt3F06igQrjTXML/l6n0eaCn9D
X-Google-Smtp-Source: APXvYqxKxSL7YQ8p0JJbSeUFp9TvxUjtb9CN6lXk7shdPIcioJL8LuNTtMK9Dte4l6hkxMZir+bQiA==
X-Received: by 2002:a17:902:2aa6:: with SMTP id j35mr21692612plb.56.1554592157281;
        Sat, 06 Apr 2019 16:09:17 -0700 (PDT)
Received: from mappy.sklembedded.com (c-24-4-228-186.hsd1.ca.comcast.net. [24.4.228.186])
        by smtp.gmail.com with ESMTPSA id i31sm44550127pgi.36.2019.04.06.16.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 16:09:16 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 3/5] gpu: ipu-v3: ipu-ic-csc: Add support for limited range encoding
Date:   Sat,  6 Apr 2019 16:09:01 -0700
Message-Id: <20190406230903.16488-4-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406230903.16488-1-slongerbeam@gmail.com>
References: <20190406230903.16488-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for encodings to or from limited range quantization.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes in v7:
- hard-code the coefficients instead of deriving the limited range
  coefficients from the full2full coefficients on the fly with
  fixed-point math.
- add support for RGB limited-range.
---
 drivers/gpu/ipu-v3/ipu-ic-csc.c | 180 +++++++++++++++++++++++++++++---
 1 file changed, 166 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-ic-csc.c b/drivers/gpu/ipu-v3/ipu-ic-csc.c
index 5fb469cd64fe..8e9150b1d668 100644
--- a/drivers/gpu/ipu-v3/ipu-ic-csc.c
+++ b/drivers/gpu/ipu-v3/ipu-ic-csc.c
@@ -10,6 +10,10 @@
 #include <linux/sizes.h>
 #include "ipu-prv.h"
 
+#define QUANT_MAP(q)					\
+	((q) == V4L2_QUANTIZATION_FULL_RANGE ||		\
+	 (q) == V4L2_QUANTIZATION_DEFAULT ? 0 : 1)
+
 /* identity matrix */
 static const struct ipu_ic_csc_params identity = {
 	.coeff = {
@@ -21,12 +25,87 @@ static const struct ipu_ic_csc_params identity = {
 	.scale = 2,
 };
 
+/*
+ * RGB full-range to RGB limited-range
+ *
+ * R_lim = 0.8588 * R_full + 16
+ * G_lim = 0.8588 * G_full + 16
+ * B_lim = 0.8588 * B_full + 16
+ */
+static const struct ipu_ic_csc_params rgbf2rgbl = {
+	.coeff = {
+		{  220,    0,    0, },
+		{    0,  220,    0, },
+		{    0,    0,  220, },
+	},
+	.offset = { 64, 64, 64, },
+	.scale = 1,
+};
+
+/*
+ * RGB limited-range to RGB full-range
+ *
+ * R_full = 1.1644 * (R_lim - 16)
+ * G_full = 1.1644 * (G_lim - 16)
+ * B_full = 1.1644 * (B_lim - 16)
+ */
+static const struct ipu_ic_csc_params rgbl2rgbf = {
+	.coeff = {
+		{  149,    0,    0, },
+		{    0,  149,    0, },
+		{    0,    0,  149, },
+	},
+	.offset = { -37, -37, -37, },
+	.scale = 2,
+};
+
+/*
+ * YUV full-range to YUV limited-range
+ *
+ * Y_lim  = 0.8588 * Y_full + 16
+ * Cb_lim = 0.8784 * (Cb_full - 128) + 128
+ * Cr_lim = 0.8784 * (Cr_full - 128) + 128
+ */
+static const struct ipu_ic_csc_params yuvf2yuvl = {
+	.coeff = {
+		{  220,    0,    0, },
+		{    0,  225,    0, },
+		{    0,    0,  225, },
+	},
+	.offset = { 64, 62, 62, },
+	.scale = 1,
+	.sat = true,
+};
+
+/*
+ * YUV limited-range to YUV full-range
+ *
+ * Y_full  = 1.1644 * (Y_lim - 16)
+ * Cb_full = 1.1384 * (Cb_lim - 128) + 128
+ * Cr_full = 1.1384 * (Cr_lim - 128) + 128
+ */
+static const struct ipu_ic_csc_params yuvl2yuvf = {
+	.coeff = {
+		{  149,    0,    0, },
+		{    0,  146,    0, },
+		{    0,    0,  146, },
+	},
+	.offset = { -37, -35, -35, },
+	.scale = 2,
+};
+
 static const struct ipu_ic_csc_params *rgb2rgb[] = {
 	&identity,
+	&rgbf2rgbl,
+	&rgbl2rgbf,
+	&identity,
 };
 
 static const struct ipu_ic_csc_params *yuv2yuv[] = {
 	&identity,
+	&yuvf2yuvl,
+	&yuvl2yuvf,
+	&identity,
 };
 
 /*
@@ -46,6 +125,41 @@ static const struct ipu_ic_csc_params rgbf2yuvf_601 = {
 	.scale = 1,
 };
 
+/* BT.601 RGB full-range to YUV limited-range */
+static const struct ipu_ic_csc_params rgbf2yuvl_601 = {
+	.coeff = {
+		{   66,  129,   25, },
+		{  -38,  -74,  112, },
+		{  112,  -94,  -18, },
+	},
+	.offset = { 64, 512, 512, },
+	.scale = 1,
+	.sat = true,
+};
+
+/* BT.601 RGB limited-range to YUV full-range */
+static const struct ipu_ic_csc_params rgbl2yuvf_601 = {
+	.coeff = {
+		{   89,  175,   34, },
+		{  -50,  -99,  149, },
+		{  149, -125,  -24, },
+	},
+	.offset = { -75, 512, 512, },
+	.scale = 1,
+};
+
+/* BT.601 RGB limited-range to YUV limited-range */
+static const struct ipu_ic_csc_params rgbl2yuvl_601 = {
+	.coeff = {
+		{   77,  150,   29, },
+		{  -44,  -87,  131, },
+		{  131, -110,  -21, },
+	},
+	.offset = { 0, 512, 512, },
+	.scale = 1,
+	.sat = true,
+};
+
 /*
  * BT.601 YUV full-range to RGB full-range
  *
@@ -69,39 +183,77 @@ static const struct ipu_ic_csc_params yuvf2rgbf_601 = {
 	.scale = 2,
 };
 
+/* BT.601 YUV full-range to RGB limited-range */
+static const struct ipu_ic_csc_params yuvf2rgbl_601 = {
+	.coeff = {
+		{  110,    0,  154, },
+		{  110,  -38,  -78, },
+		{  110,  195,    0, },
+	},
+	.offset = { -276, 265, -358, },
+	.scale = 2,
+};
+
+/* BT.601 YUV limited-range to RGB full-range */
+static const struct ipu_ic_csc_params yuvl2rgbf_601 = {
+	.coeff = {
+		{   75,    0,  102, },
+		{   75,  -25,  -52, },
+		{   75,  129,    0, },
+	},
+	.offset = { -223, 136, -277, },
+	.scale = 3,
+};
+
+/* BT.601 YUV limited-range to RGB limited-range */
+static const struct ipu_ic_csc_params yuvl2rgbl_601 = {
+	.coeff = {
+		{  128,    0,  175, },
+		{  128,  -43,  -89, },
+		{  128,  222,    0, },
+	},
+	.offset = { -351, 265, -443, },
+	.scale = 2,
+};
+
 static const struct ipu_ic_csc_params *rgb2yuv_601[] = {
 	&rgbf2yuvf_601,
+	&rgbf2yuvl_601,
+	&rgbl2yuvf_601,
+	&rgbl2yuvl_601,
 };
 
 static const struct ipu_ic_csc_params *yuv2rgb_601[] = {
 	&yuvf2rgbf_601,
+	&yuvf2rgbl_601,
+	&yuvl2rgbf_601,
+	&yuvl2rgbl_601,
 };
 
 static int calc_csc_coeffs(struct ipu_ic_csc *csc)
 {
+	const struct ipu_ic_csc_params **params_tbl;
+	int tbl_idx;
+
 	if (csc->out_cs.enc != V4L2_YCBCR_ENC_601)
 		return -ENOTSUPP;
 
-	if ((csc->in_cs.cs == IPUV3_COLORSPACE_YUV &&
-	     csc->in_cs.quant != V4L2_QUANTIZATION_FULL_RANGE) ||
-	    (csc->out_cs.cs == IPUV3_COLORSPACE_YUV &&
-	     csc->out_cs.quant != V4L2_QUANTIZATION_FULL_RANGE))
-		return -ENOTSUPP;
-
-	if ((csc->in_cs.cs == IPUV3_COLORSPACE_RGB &&
-	     csc->in_cs.quant != V4L2_QUANTIZATION_FULL_RANGE) ||
-	    (csc->out_cs.cs == IPUV3_COLORSPACE_RGB &&
-	     csc->out_cs.quant != V4L2_QUANTIZATION_FULL_RANGE))
-		return -ENOTSUPP;
+	tbl_idx = (QUANT_MAP(csc->in_cs.quant) << 1) |
+		QUANT_MAP(csc->out_cs.quant);
 
 	if (csc->in_cs.cs == csc->out_cs.cs) {
 		csc->params = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
-			*yuv2yuv[0] : *rgb2rgb[0];
+			*yuv2yuv[tbl_idx] : *rgb2rgb[tbl_idx];
+
 		return 0;
 	}
 
-	csc->params = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
-		*yuv2rgb_601[0] : *rgb2yuv_601[0];
+	/* YUV <-> RGB encoding is required */
+
+	params_tbl = (csc->in_cs.cs == IPUV3_COLORSPACE_YUV) ?
+		yuv2rgb_601 : rgb2yuv_601;
+
+	csc->params = *params_tbl[tbl_idx];
 
 	return 0;
 }
-- 
2.17.1

