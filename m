Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C71C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456B820833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLfOv2En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDHVnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43371 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDHVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id g7so10615782lfh.10;
        Mon, 08 Apr 2019 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpgBHfdugHtSLDjxeKpwcp9o2D+S4DB29Nc+VO4NBko=;
        b=pLfOv2EnDzLRhBTQw/uaMX3KbgMLELjbECTK+qcI2yoOirS/jpInJDAQ9cPNJ7xXjP
         WtFK1b1nlBawFE6gGvhzU93XFZPgrmKsXZ4PW4R1zivpXy1FxB0mgwvlTMTglmcLLjVN
         2s9w352FiaGGjsa0Z2vin0q2UiNvuM9zoYbi0wXpdbYyRRI1gyLZ228z7WPH+8PiLmPC
         7egoKfxLUX2p4wgR0Fp/COl3a9KgwnTzaVmeQMN4k5oW92OKJuTGuZGidC2SnTZKqhWD
         9qU/TphZLCVc1eOCeDN+Q/mhHEoozURxADsikzopKHpgK+nnJ01fMjAThot8ei/Fm1B9
         O6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpgBHfdugHtSLDjxeKpwcp9o2D+S4DB29Nc+VO4NBko=;
        b=FVwAZgg/cXW3rgBBKHQoD5FYMgzu8cb3lQ2qLcanWCZ3EoH0f5X9BpmcOZnaj3sRQK
         cSKRrfxNW8h1+fDAO7YRBmK7o7J3b9xt7Q0B8WdB403dXxYwe0R6KbkZqE40A/DQaT0T
         ubH1649uZfN4R1mJnQKClueH9fSJI9Vx5RYRbWe/RE5dR/kwPzeZwtu7yx/gOz1/MS8i
         jUvocc20alVs4bD2gke1W63uwCxVF19WKLtzDLHRZk7Cbco87HhvaO17aDQxUIXOUtyO
         Eva1jOABVtm8gSQ267gL5Ptf+PIMF63z6wjrSuTktEvLWIjgH1s6RQ1j7f+wUl80vRFu
         0Ruw==
X-Gm-Message-State: APjAAAX6lgdBjDo/SxdQbS6Iib2pZR5ojJYIq+MoLH0NRnfxApU3T+Op
        KNtSbEMEA/pyNo3ABCoxptM=
X-Google-Smtp-Source: APXvYqzzTo2PWLsrOTa6Rn5v2Z+MLKGPDye2F8sOiRpIEJ+kSqcZ6Oa+WW6rsaKAYDXlsrqHv+l0Nw==
X-Received: by 2002:a19:7114:: with SMTP id m20mr17297213lfc.63.1554759798853;
        Mon, 08 Apr 2019 14:43:18 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:18 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 10/14] media: ov6650: Fix some format attributes not under control
Date:   Mon,  8 Apr 2019 23:42:38 +0200
Message-Id: <20190408214242.9603-11-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User arguments passed to .get/set_fmt() pad operation callbacks may
contain unsupported values.  The driver takes control over frame size
and pixel code as well as colorspace and field attributes but has never
cared for remainig format attributes, i.e., ycbcr_enc, quantization
and xfer_func, introduced by commit 11ff030c7365 ("[media]
v4l2-mediabus: improve colorspace support").  Fix it.

Set up a static v4l2_mbus_framefmt structure with attributes
initialized to reasonable defaults and use it for updating content of
user provided arguments.  In case of V4L2_SUBDEV_FORMAT_ACTIVE,
postpone frame size update, now performed from inside ov6650_s_fmt()
helper, util the user argument is first updated in ov6650_set_fmt() with
default frame format content.  For V4L2_SUBDEV_FORMAT_TRY, don't copy
all attributes to pad config, only those handled by the driver, then
fill the response with the default frame format updated with resulting
pad config format code and frame size.

Fixes: 11ff030c7365 ("[media] v4l2-mediabus: improve colorspace support")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 51 +++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index dfee07ec976e..f6b0b77c5abf 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -215,6 +215,17 @@ static u32 ov6650_codes[] = {
 	MEDIA_BUS_FMT_Y8_1X8,
 };
 
+static const struct v4l2_mbus_framefmt ov6650_def_fmt = {
+	.width		= W_CIF,
+	.height		= H_CIF,
+	.code		= MEDIA_BUS_FMT_SBGGR8_1X8,
+	.colorspace	= V4L2_COLORSPACE_SRGB,
+	.field		= V4L2_FIELD_NONE,
+	.ycbcr_enc	= V4L2_YCBCR_ENC_DEFAULT,
+	.quantization	= V4L2_QUANTIZATION_DEFAULT,
+	.xfer_func	= V4L2_XFER_FUNC_DEFAULT,
+};
+
 /* read a register */
 static int ov6650_reg_read(struct i2c_client *client, u8 reg, u8 *val)
 {
@@ -530,11 +541,13 @@ static int ov6650_get_fmt(struct v4l2_subdev *sd,
 		return -EINVAL;
 	}
 
+	/* initialize response with default media bus frame format */
+	*mf = ov6650_def_fmt;
+
+	/* update media bus format code and frame size */
 	mf->width	= priv->rect.width >> priv->half_scale;
 	mf->height	= priv->rect.height >> priv->half_scale;
 	mf->code	= priv->code;
-	mf->colorspace	= V4L2_COLORSPACE_SRGB;
-	mf->field	= V4L2_FIELD_NONE;
 
 	return 0;
 }
@@ -670,10 +683,6 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 	if (!ret)
 		ret = ov6650_reg_rmw(client, REG_COML, coml_set, coml_mask);
 
-	if (!ret) {
-		mf->width = priv->rect.width >> half_scale;
-		mf->height = priv->rect.height >> half_scale;
-	}
 	return ret;
 }
 
@@ -703,9 +712,6 @@ static int ov6650_set_fmt(struct v4l2_subdev *sd,
 		v4l_bound_align_image(&mf->width, 2, W_CIF, 1,
 				&mf->height, 2, H_CIF, 1, 0);
 
-	mf->field = V4L2_FIELD_NONE;
-	mf->colorspace = V4L2_COLORSPACE_SRGB;
-
 	switch (mf->code) {
 	case MEDIA_BUS_FMT_Y10_1X10:
 		mf->code = MEDIA_BUS_FMT_Y8_1X8;
@@ -723,10 +729,31 @@ static int ov6650_set_fmt(struct v4l2_subdev *sd,
 		break;
 	}
 
-	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
-		return ov6650_s_fmt(sd, mf);
-	cfg->try_fmt = *mf;
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
+		/* store media bus format code and frame size in pad config */
+		cfg->try_fmt.width = mf->width;
+		cfg->try_fmt.height = mf->height;
+		cfg->try_fmt.code = mf->code;
 
+		/* return default mbus frame format updated with pad config */
+		*mf = ov6650_def_fmt;
+		mf->width = cfg->try_fmt.width;
+		mf->height = cfg->try_fmt.height;
+		mf->code = cfg->try_fmt.code;
+
+	} else {
+		/* apply new media bus format code and frame size */
+		int ret = ov6650_s_fmt(sd, mf);
+
+		if (ret)
+			return ret;
+
+		/* return default format updated with active size and code */
+		*mf = ov6650_def_fmt;
+		mf->width = priv->rect.width >> priv->half_scale;
+		mf->height = priv->rect.height >> priv->half_scale;
+		mf->code = priv->code;
+	}
 	return 0;
 }
 
-- 
2.21.0

