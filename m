Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501AF20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrI82FVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfDHVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:43:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40607 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfDHVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:43:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so10627541lfo.7;
        Mon, 08 Apr 2019 14:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NENsT2NLOI8UTcTWM+JMOR9wkbUmlrUzrLqxG+pnjm4=;
        b=MrI82FVbWabTUtG+jGIz5JUUtLm0LgLp8ckjj6x6m43Zsn8elameDJOQd9ey3Xn49V
         ev8XkZLV6MqnevpQ5zyoGiGI1YJwMGQIXX9/6hwBsRcLyQ2uDCzZ7Gghc2XnXLxBJAN2
         yg+4kg0By0Sud9WNhVqHWs65bugYE8gUpzjuhRKn/nbZiL1leW/a94+ZTPea5gglR01p
         a/r+kFxHESY6xfVnhQnae2v+ZTVBkXx4NFDlMykYh1BsfjBwH39i1T343NiR1Vk9Dz8z
         Yt+mUAhRWNatijLWVXwjcuFjMCM/gzmaMODnwFt5eKpniCzwLWALTQPdxX3RvfCNGQkd
         oKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NENsT2NLOI8UTcTWM+JMOR9wkbUmlrUzrLqxG+pnjm4=;
        b=WiD3JTup6Lod24gtj63j+1GkTDB/MT5WzcbqEA8b61m2vYj4ft2D9Y8CuqdJBCH6LW
         6FbJl6REK64RqSAcJjmQZ7HCP+ipYEXXwfvY2kmmDYwhEjC8mle87lxBMFICjyCMxfEL
         lTX+rlLt1NkT357AncrOAehQqR7kPK0M9q2kc3UCSjX8tLNFE1JmadhQ3s+/GmaHVw2g
         HHX5cScMaQBztRXL3yBYfnQPYEsOKoXLUWFTE24uxFSpfw0H+J12j9CRrrFGdxm7clMA
         Ao4iWosb/XFSSUiWKaT/uWHZJXpvxPvpgDbWGr+GEyqwwJn3Y0mNFcjEPjH+yslokE0u
         FqHA==
X-Gm-Message-State: APjAAAW5r3cfQErJ4lBcGhz+YwNz+6KLCJDUKMp22RGPaTS2I917brQq
        4jvvuHrJHMBR6qLQxukaBmY=
X-Google-Smtp-Source: APXvYqzlNvX6eZVRQHIFMamGG3srIfiy6oDh4zCEp5Qxcz+J/IaujKlokld4iI9+htuxcPhR1WqjeQ==
X-Received: by 2002:a19:d14e:: with SMTP id i75mr3025684lfg.55.1554759797611;
        Mon, 08 Apr 2019 14:43:17 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j6sm5286048ljc.0.2019.04.08.14.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:43:17 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 09/14] media: ov6650: Fix incorrect use of JPEG colorspace
Date:   Mon,  8 Apr 2019 23:42:37 +0200
Message-Id: <20190408214242.9603-10-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408214242.9603-1-jmkrzyszt@gmail.com>
References: <20190408214242.9603-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since its initial submission, the driver selects V4L2_COLORSPACE_JPEG
for supported formats other than V4L2_MBUS_FMT_SBGGR8_1X8.  According
to v4l2-compliance test program, V4L2_COLORSPACE_JPEG applies
exclusively to V4L2_PIX_FMT_JPEG.  Since the sensor does not support
JPEG format, fix it to always select V4L2_COLORSPACE_SRGB.

Fixes: 2f6e2404799a ("[media] SoC Camera: add driver for OV6650 sensor")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/i2c/ov6650.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 07d7a0708cca..dfee07ec976e 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -203,7 +203,6 @@ struct ov6650 {
 	unsigned long		pclk_max;	/* from resolution and format */
 	struct v4l2_fract	tpf;		/* as requested with s_frame_interval */
 	u32 code;
-	enum v4l2_colorspace	colorspace;
 };
 
 
@@ -534,7 +533,7 @@ static int ov6650_get_fmt(struct v4l2_subdev *sd,
 	mf->width	= priv->rect.width >> priv->half_scale;
 	mf->height	= priv->rect.height >> priv->half_scale;
 	mf->code	= priv->code;
-	mf->colorspace	= priv->colorspace;
+	mf->colorspace	= V4L2_COLORSPACE_SRGB;
 	mf->field	= V4L2_FIELD_NONE;
 
 	return 0;
@@ -642,11 +641,6 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 		priv->pclk_max = 8000000;
 	}
 
-	if (code == MEDIA_BUS_FMT_SBGGR8_1X8)
-		priv->colorspace = V4L2_COLORSPACE_SRGB;
-	else if (code != 0)
-		priv->colorspace = V4L2_COLORSPACE_JPEG;
-
 	if (half_scale) {
 		dev_dbg(&client->dev, "max resolution: QCIF\n");
 		coma_set |= COMA_QCIF;
@@ -677,7 +671,6 @@ static int ov6650_s_fmt(struct v4l2_subdev *sd, struct v4l2_mbus_framefmt *mf)
 		ret = ov6650_reg_rmw(client, REG_COML, coml_set, coml_mask);
 
 	if (!ret) {
-		mf->colorspace	= priv->colorspace;
 		mf->width = priv->rect.width >> half_scale;
 		mf->height = priv->rect.height >> half_scale;
 	}
@@ -711,6 +704,7 @@ static int ov6650_set_fmt(struct v4l2_subdev *sd,
 				&mf->height, 2, H_CIF, 1, 0);
 
 	mf->field = V4L2_FIELD_NONE;
+	mf->colorspace = V4L2_COLORSPACE_SRGB;
 
 	switch (mf->code) {
 	case MEDIA_BUS_FMT_Y10_1X10:
@@ -721,13 +715,11 @@ static int ov6650_set_fmt(struct v4l2_subdev *sd,
 	case MEDIA_BUS_FMT_YUYV8_2X8:
 	case MEDIA_BUS_FMT_VYUY8_2X8:
 	case MEDIA_BUS_FMT_UYVY8_2X8:
-		mf->colorspace = V4L2_COLORSPACE_JPEG;
 		break;
 	default:
 		mf->code = MEDIA_BUS_FMT_SBGGR8_1X8;
 		/* fall through */
 	case MEDIA_BUS_FMT_SBGGR8_1X8:
-		mf->colorspace = V4L2_COLORSPACE_SRGB;
 		break;
 	}
 
@@ -1055,7 +1047,6 @@ static int ov6650_probe(struct i2c_client *client,
 	priv->rect.height = H_CIF;
 	priv->half_scale  = false;
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
-	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-- 
2.21.0

