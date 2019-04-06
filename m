Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30BBC282DD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5259D21019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 23:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWLV2kAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDFXJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 19:09:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40503 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfDFXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 19:09:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so5344552pfc.7;
        Sat, 06 Apr 2019 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9vFEtR41P1AeMUFHOos3mmBMGwqw/eIJuTUHN6Bzt0E=;
        b=tWLV2kAtZ0zCBoYqByF2BIn61QI61S+DaiWeHI6ME0YzikrKg61D240PXVwQC2GI0c
         efRkfAx7PeQSLSuO/00SCfDxz6amkFZBPma+HsXZ/D9byjDGPcm/Iq4+E63PmVdmQ98f
         eRxUx7b9OFMcBoJ0fU+bcOfgv6mw8dhavlhKno/+jgnHOyjL4aYzfoxCuDc15XkqFcBn
         qUkHPPGIufmW8u8qlVUteB7hx95COHxbPwgUAD5HPWGTprjdSJiFpVtEAF89qaEhFhyS
         Kw961ZuXQt5Eybm8ggUI98XRBupLUEsacrUsL/JV0lVJpt3yhnAoxYrGnw2YOCOGpfd0
         rVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9vFEtR41P1AeMUFHOos3mmBMGwqw/eIJuTUHN6Bzt0E=;
        b=uQKrXAt5EprSiGY1s2dr+iR1haNpu5O4Z69juVylr7WM40c+fc3IDVPiUjXOcGVUi7
         ZqY6rE6Puc/Z78zY8RREgaN6fOsFgPqYs0melGdhWCHJYVI8vl3uO0ej1EhNpqHzynRC
         p6mCu0eaFhD5MYOiPePsGYPqQl+a13NTlneWAQtgBnbalHBjzXM1byIMIrFw+WVjoyD4
         IBtdbhAEwfiekQ7b0+WSKMnxlYdWBsApeOjC/bFpUDsh3iSnkv8muaHCnc8YU3AplWJ1
         H6sqUTYQhOyjlM+pLr0lNiH6yA064J7NNz/QG1x+3TZdGl3URbb6ix1VXEESy3d0NcC2
         BaxA==
X-Gm-Message-State: APjAAAXj1LgpXLTaZZxIdQxEJD6TCPlN/H1N6OmnTKGgB7L5CT/3xn5j
        FXJxkSBOMRzq+CEMpFRAfPIezvXz
X-Google-Smtp-Source: APXvYqwqqHvfxjQg6esfqRcwFPixYio4QGyNrLwc9PXpiDO0HIUQJ3uAkxnOnDp0ZPcmjT3AoX097w==
X-Received: by 2002:a65:5189:: with SMTP id h9mr19973347pgq.304.1554592160759;
        Sat, 06 Apr 2019 16:09:20 -0700 (PDT)
Received: from mappy.sklembedded.com (c-24-4-228-186.hsd1.ca.comcast.net. [24.4.228.186])
        by smtp.gmail.com with ESMTPSA id i31sm44550127pgi.36.2019.04.06.16.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 16:09:20 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 5/5] media: imx: Try colorimetry at both sink and source pads
Date:   Sat,  6 Apr 2019 16:09:03 -0700
Message-Id: <20190406230903.16488-6-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406230903.16488-1-slongerbeam@gmail.com>
References: <20190406230903.16488-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retask imx_media_fill_default_mbus_fields() to try colorimetry parameters,
renaming it to to imx_media_try_colorimetry(), and call it at both sink and
source pad try_fmt's. The unrelated check for uninitialized field value is
moved out to appropriate places in each subdev try_fmt.

The IC now supports Rec.709 and BT.601 Y'CbCr encoding, and both limited
and full range quantization for both YUV and RGB space, so allow those
for pipelines that route through the IC.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes in v7:
- squashed with "media: imx: Allow Rec.709 encoding for IC routes".
- remove the RGB full-range quantization restriction for IC routes.
---
 drivers/staging/media/imx/imx-ic-prp.c      |  6 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c |  8 +--
 drivers/staging/media/imx/imx-media-csi.c   | 19 +++---
 drivers/staging/media/imx/imx-media-utils.c | 73 ++++++++++-----------
 drivers/staging/media/imx/imx-media-vdic.c  |  5 +-
 drivers/staging/media/imx/imx-media.h       |  5 +-
 drivers/staging/media/imx/imx7-media-csi.c  |  8 +--
 7 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prp.c b/drivers/staging/media/imx/imx-ic-prp.c
index 3d43cdcb4bb9..8010ee706164 100644
--- a/drivers/staging/media/imx/imx-ic-prp.c
+++ b/drivers/staging/media/imx/imx-ic-prp.c
@@ -197,8 +197,8 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 			sdformat->format.code = cc->codes[0];
 		}
 
-		imx_media_fill_default_mbus_fields(&sdformat->format, infmt,
-						   true);
+		if (sdformat->format.field == V4L2_FIELD_ANY)
+			sdformat->format.field = V4L2_FIELD_NONE;
 		break;
 	case PRP_SRC_PAD_PRPENC:
 	case PRP_SRC_PAD_PRPVF:
@@ -207,6 +207,8 @@ static int prp_set_fmt(struct v4l2_subdev *sd,
 		break;
 	}
 
+	imx_media_try_colorimetry(&sdformat->format, true);
+
 	fmt = __prp_get_fmt(priv, cfg, sdformat->pad, sdformat->which);
 	*fmt = sdformat->format;
 out:
diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 7e8405d3b75c..5cc41cec59bf 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -911,8 +911,6 @@ static void prp_try_fmt(struct prp_priv *priv,
 		/* propagate colorimetry from sink */
 		sdformat->format.colorspace = infmt->colorspace;
 		sdformat->format.xfer_func = infmt->xfer_func;
-		sdformat->format.quantization = infmt->quantization;
-		sdformat->format.ycbcr_enc = infmt->ycbcr_enc;
 	} else {
 		v4l_bound_align_image(&sdformat->format.width,
 				      MIN_W_SINK, MAX_W_SINK, W_ALIGN_SINK,
@@ -920,9 +918,11 @@ static void prp_try_fmt(struct prp_priv *priv,
 				      MIN_H_SINK, MAX_H_SINK, H_ALIGN_SINK,
 				      S_ALIGN);
 
-		imx_media_fill_default_mbus_fields(&sdformat->format, infmt,
-						   true);
+		if (sdformat->format.field == V4L2_FIELD_ANY)
+			sdformat->format.field = V4L2_FIELD_NONE;
 	}
+
+	imx_media_try_colorimetry(&sdformat->format, true);
 }
 
 static int prp_set_fmt(struct v4l2_subdev *sd,
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index 41965d8b56c4..19865218646e 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1379,9 +1379,15 @@ static void csi_try_field(struct csi_priv *priv,
 	struct v4l2_mbus_framefmt *infmt =
 		__csi_get_fmt(priv, cfg, CSI_SINK_PAD, sdformat->which);
 
-	/* no restrictions on sink pad field type */
-	if (sdformat->pad == CSI_SINK_PAD)
+	/*
+	 * no restrictions on sink pad field type except must
+	 * be initialized.
+	 */
+	if (sdformat->pad == CSI_SINK_PAD) {
+		if (sdformat->format.field == V4L2_FIELD_ANY)
+			sdformat->format.field = V4L2_FIELD_NONE;
 		return;
+	}
 
 	switch (infmt->field) {
 	case V4L2_FIELD_SEQ_TB:
@@ -1459,8 +1465,6 @@ static void csi_try_fmt(struct csi_priv *priv,
 		/* propagate colorimetry from sink */
 		sdformat->format.colorspace = infmt->colorspace;
 		sdformat->format.xfer_func = infmt->xfer_func;
-		sdformat->format.quantization = infmt->quantization;
-		sdformat->format.ycbcr_enc = infmt->ycbcr_enc;
 
 		break;
 	case CSI_SINK_PAD:
@@ -1480,10 +1484,6 @@ static void csi_try_fmt(struct csi_priv *priv,
 
 		csi_try_field(priv, cfg, sdformat);
 
-		imx_media_fill_default_mbus_fields(
-			&sdformat->format, infmt,
-			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
-
 		/* Reset crop and compose rectangles */
 		crop->left = 0;
 		crop->top = 0;
@@ -1499,6 +1499,9 @@ static void csi_try_fmt(struct csi_priv *priv,
 
 		break;
 	}
+
+	imx_media_try_colorimetry(&sdformat->format,
+			priv->active_output_pad == CSI_SRC_PAD_DIRECT);
 }
 
 static int csi_set_fmt(struct v4l2_subdev *sd,
diff --git a/drivers/staging/media/imx/imx-media-utils.c b/drivers/staging/media/imx/imx-media-utils.c
index 1c63a2765a81..a1fd8d610549 100644
--- a/drivers/staging/media/imx/imx-media-utils.c
+++ b/drivers/staging/media/imx/imx-media-utils.c
@@ -515,21 +515,18 @@ int imx_media_init_cfg(struct v4l2_subdev *sd,
 EXPORT_SYMBOL_GPL(imx_media_init_cfg);
 
 /*
- * Check whether the field and colorimetry parameters in tryfmt are
- * uninitialized, and if so fill them with the values from fmt,
- * or if tryfmt->colorspace has been initialized, all the default
- * colorimetry params can be derived from tryfmt->colorspace.
+ * Default the colorspace in tryfmt to SRGB if set to an unsupported
+ * colorspace or not initialized. Then set the remaining colorimetry
+ * parameters based on the colorspace if they are uninitialized.
  *
  * tryfmt->code must be set on entry.
  *
  * If this format is destined to be routed through the Image Converter,
- * quantization and Y`CbCr encoding must be fixed. The IC expects and
- * produces fixed quantization and Y`CbCr encoding at its input and output
- * (full range for RGB, limited range for YUV, and V4L2_YCBCR_ENC_601).
+ * Y`CbCr encoding must be fixed. The IC supports only BT.601 Y`CbCr
+ * or Rec.709 Y`CbCr encoding.
  */
-void imx_media_fill_default_mbus_fields(struct v4l2_mbus_framefmt *tryfmt,
-					struct v4l2_mbus_framefmt *fmt,
-					bool ic_route)
+void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
+			       bool ic_route)
 {
 	const struct imx_media_pixfmt *cc;
 	bool is_rgb = false;
@@ -537,44 +534,46 @@ void imx_media_fill_default_mbus_fields(struct v4l2_mbus_framefmt *tryfmt,
 	cc = imx_media_find_mbus_format(tryfmt->code, CS_SEL_ANY, true);
 	if (!cc)
 		cc = imx_media_find_ipu_format(tryfmt->code, CS_SEL_ANY);
-	if (cc && cc->cs != IPUV3_COLORSPACE_YUV)
+	if (cc && cc->cs == IPUV3_COLORSPACE_RGB)
 		is_rgb = true;
 
-	/* fill field if necessary */
-	if (tryfmt->field == V4L2_FIELD_ANY)
-		tryfmt->field = fmt->field;
+	switch (tryfmt->colorspace) {
+	case V4L2_COLORSPACE_SMPTE170M:
+	case V4L2_COLORSPACE_REC709:
+	case V4L2_COLORSPACE_JPEG:
+	case V4L2_COLORSPACE_SRGB:
+	case V4L2_COLORSPACE_BT2020:
+	case V4L2_COLORSPACE_OPRGB:
+	case V4L2_COLORSPACE_DCI_P3:
+	case V4L2_COLORSPACE_RAW:
+		break;
+	default:
+		tryfmt->colorspace = V4L2_COLORSPACE_SRGB;
+		break;
+	}
+
+	if (tryfmt->xfer_func == V4L2_XFER_FUNC_DEFAULT)
+		tryfmt->xfer_func =
+			V4L2_MAP_XFER_FUNC_DEFAULT(tryfmt->colorspace);
 
-	/* fill colorimetry if necessary */
-	if (tryfmt->colorspace == V4L2_COLORSPACE_DEFAULT) {
-		tryfmt->colorspace = fmt->colorspace;
-		tryfmt->xfer_func = fmt->xfer_func;
-		tryfmt->ycbcr_enc = fmt->ycbcr_enc;
-		tryfmt->quantization = fmt->quantization;
+	if (ic_route) {
+		if (tryfmt->ycbcr_enc != V4L2_YCBCR_ENC_601 &&
+		    tryfmt->ycbcr_enc != V4L2_YCBCR_ENC_709)
+			tryfmt->ycbcr_enc = V4L2_YCBCR_ENC_601;
 	} else {
-		if (tryfmt->xfer_func == V4L2_XFER_FUNC_DEFAULT) {
-			tryfmt->xfer_func =
-				V4L2_MAP_XFER_FUNC_DEFAULT(tryfmt->colorspace);
-		}
 		if (tryfmt->ycbcr_enc == V4L2_YCBCR_ENC_DEFAULT) {
 			tryfmt->ycbcr_enc =
 				V4L2_MAP_YCBCR_ENC_DEFAULT(tryfmt->colorspace);
 		}
-		if (tryfmt->quantization == V4L2_QUANTIZATION_DEFAULT) {
-			tryfmt->quantization =
-				V4L2_MAP_QUANTIZATION_DEFAULT(
-					is_rgb, tryfmt->colorspace,
-					tryfmt->ycbcr_enc);
-		}
 	}
 
-	if (ic_route) {
-		tryfmt->quantization = is_rgb ?
-			V4L2_QUANTIZATION_FULL_RANGE :
-			V4L2_QUANTIZATION_LIM_RANGE;
-		tryfmt->ycbcr_enc = V4L2_YCBCR_ENC_601;
-	}
+	if (tryfmt->quantization == V4L2_QUANTIZATION_DEFAULT)
+		tryfmt->quantization =
+			V4L2_MAP_QUANTIZATION_DEFAULT(is_rgb,
+						      tryfmt->colorspace,
+						      tryfmt->ycbcr_enc);
 }
-EXPORT_SYMBOL_GPL(imx_media_fill_default_mbus_fields);
+EXPORT_SYMBOL_GPL(imx_media_try_colorimetry);
 
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 				  struct v4l2_rect *compose,
diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 5439b88dba20..33f2b90c6e31 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -621,14 +621,13 @@ static void vdic_try_fmt(struct vdic_priv *priv,
 				      &sdformat->format.height,
 				      MIN_H, MAX_H_VDIC, H_ALIGN, S_ALIGN);
 
-		imx_media_fill_default_mbus_fields(&sdformat->format, infmt,
-						   true);
-
 		/* input must be interlaced! Choose SEQ_TB if not */
 		if (!V4L2_FIELD_HAS_BOTH(sdformat->format.field))
 			sdformat->format.field = V4L2_FIELD_SEQ_TB;
 		break;
 	}
+
+	imx_media_try_colorimetry(&sdformat->format, true);
 }
 
 static int vdic_set_fmt(struct v4l2_subdev *sd,
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index dd603a6b3a70..83ae1433fc57 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -176,9 +176,8 @@ int imx_media_init_mbus_fmt(struct v4l2_mbus_framefmt *mbus,
 			    const struct imx_media_pixfmt **cc);
 int imx_media_init_cfg(struct v4l2_subdev *sd,
 		       struct v4l2_subdev_pad_config *cfg);
-void imx_media_fill_default_mbus_fields(struct v4l2_mbus_framefmt *tryfmt,
-					struct v4l2_mbus_framefmt *fmt,
-					bool ic_route);
+void imx_media_try_colorimetry(struct v4l2_mbus_framefmt *tryfmt,
+			       bool ic_route);
 int imx_media_mbus_fmt_to_pix_fmt(struct v4l2_pix_format *pix,
 				  struct v4l2_rect *compose,
 				  const struct v4l2_mbus_framefmt *mbus,
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 18eb5d3ecf10..99fb519da754 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1003,8 +1003,6 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
 
 		sdformat->format.colorspace = in_fmt->colorspace;
 		sdformat->format.xfer_func = in_fmt->xfer_func;
-		sdformat->format.quantization = in_fmt->quantization;
-		sdformat->format.ycbcr_enc = in_fmt->ycbcr_enc;
 		break;
 	case IMX7_CSI_PAD_SINK:
 		*cc = imx_media_find_mbus_format(sdformat->format.code,
@@ -1015,14 +1013,14 @@ static int imx7_csi_try_fmt(struct imx7_csi *csi,
 							 false);
 			sdformat->format.code = (*cc)->codes[0];
 		}
-
-		imx_media_fill_default_mbus_fields(&sdformat->format, in_fmt,
-						   false);
 		break;
 	default:
 		return -EINVAL;
 		break;
 	}
+
+	imx_media_try_colorimetry(&sdformat->format, false);
+
 	return 0;
 }
 
-- 
2.17.1

