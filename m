Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF062171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwHznNze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfDDV14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:27:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33359 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:27:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so3782105otq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9SV3FH2+wkz9gqGz5Ak/J5kqbrGksI18bILx8Q2+12Y=;
        b=kwHznNzeAllYt2pATcIGVvGmTWnuu0nTU2d5cIxNF1XCCgbAHFq0T3qRUxDcw62uZB
         u/irQQHSASMCON2UHh+IXP8VcolkAru6vsin8axOb65fUZ2TnCmknIrVCFMaWxO7ES0R
         CQxiMgcelr+JeVGe3m8fs4e4exFrPwfrRbjasRitR3SG7QIvRsShzs0RbjjoU9DBCimm
         no3KEpsFG+ASUrjKmou9WnSUjOJ8PnhMlkFgraZ9ZDWqeXteB3H3g3Q9Ph+atYG5sqxX
         fC8R/m8+iSF1mwnwMU7mthbiBYQsuKuqHaEufaXDiYU2B9YP663Sb0IdC8nHU9We0cN+
         U81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9SV3FH2+wkz9gqGz5Ak/J5kqbrGksI18bILx8Q2+12Y=;
        b=h1F/4toSXXDCRrJ+GLEYhiqyDU8E1CQ6xCSuwl03vHrsDJNBM0fijBCQR9R8uTjyUp
         msMrywFo4ajIpFr1wUEjF4GDZ3RhL3ro9TNfeqmHUgYzmREHdTu4wKW6t1mmmMfK2guq
         vi68tfdt9agJtKFhjvyxiExunrWKpA+zFCMtqHN6stQGqPW+xVFIyAK4JGLgk8u47W2W
         9+otiQ+Ox9qUeoeJk7uDkoKETClcM8rTyqC1R7Tn35mMFw/JdTW1FqdBRLTYsOgkr1gn
         Bh/L7H1rKY6nFSugM0tGat1sIOb0b5wnC/D4t7/tF12ttzKbY1s4C9kY5uTGszbVst1X
         GfBw==
X-Gm-Message-State: APjAAAX3NfEs1TksI89s3PbcMxBP6WKJ9ymeOxCb5V6LFpceRYWXq8RD
        3VWyK268DiskXDSgw5sWhdI=
X-Google-Smtp-Source: APXvYqxCRcKCHCq5OBfBt1nA5omeuTqSUEcIx3hEtSM2NftOwujLwxzKYWyWPg9+SF3lNv0jbVqkIA==
X-Received: by 2002:a9d:77da:: with SMTP id w26mr5660958otl.17.1554413274644;
        Thu, 04 Apr 2019 14:27:54 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id n77sm10317623ota.77.2019.04.04.14.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:27:53 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     eric@anholt.net, stefan.wahren@i2se.com,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: vc04_services: bcm2835-camera: Remove an exceptional &
Date:   Thu,  4 Apr 2019 16:27:37 -0500
Message-Id: <20190404212737.3497-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an exceptional & on function names, otherwise they are used as
pointers without &.

Issue suggested using Coccinelle.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 .../vc04_services/bcm2835-camera/controls.c   | 58 +++++++++----------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index a2c55cb2192a..e39ab5fae724 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -930,49 +930,49 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		V4L2_CID_SATURATION, MMAL_CONTROL_TYPE_STD,
 		-100, 100, 0, 1, NULL,
 		MMAL_PARAMETER_SATURATION,
-		&ctrl_set_rational,
+		ctrl_set_rational,
 		false
 	},
 	{
 		V4L2_CID_SHARPNESS, MMAL_CONTROL_TYPE_STD,
 		-100, 100, 0, 1, NULL,
 		MMAL_PARAMETER_SHARPNESS,
-		&ctrl_set_rational,
+		ctrl_set_rational,
 		false
 	},
 	{
 		V4L2_CID_CONTRAST, MMAL_CONTROL_TYPE_STD,
 		-100, 100, 0, 1, NULL,
 		MMAL_PARAMETER_CONTRAST,
-		&ctrl_set_rational,
+		ctrl_set_rational,
 		false
 	},
 	{
 		V4L2_CID_BRIGHTNESS, MMAL_CONTROL_TYPE_STD,
 		0, 100, 50, 1, NULL,
 		MMAL_PARAMETER_BRIGHTNESS,
-		&ctrl_set_rational,
+		ctrl_set_rational,
 		false
 	},
 	{
 		V4L2_CID_ISO_SENSITIVITY, MMAL_CONTROL_TYPE_INT_MENU,
 		0, ARRAY_SIZE(iso_qmenu) - 1, 0, 1, iso_qmenu,
 		MMAL_PARAMETER_ISO,
-		&ctrl_set_iso,
+		ctrl_set_iso,
 		false
 	},
 	{
 		V4L2_CID_ISO_SENSITIVITY_AUTO, MMAL_CONTROL_TYPE_STD_MENU,
 		0, 1, V4L2_ISO_SENSITIVITY_AUTO, 1, NULL,
 		MMAL_PARAMETER_ISO,
-		&ctrl_set_iso,
+		ctrl_set_iso,
 		false
 	},
 	{
 		V4L2_CID_IMAGE_STABILIZATION, MMAL_CONTROL_TYPE_STD,
 		0, 1, 0, 1, NULL,
 		MMAL_PARAMETER_VIDEO_STABILISATION,
-		&ctrl_set_value,
+		ctrl_set_value,
 		false
 	},
 /*	{
@@ -983,7 +983,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		V4L2_CID_EXPOSURE_AUTO, MMAL_CONTROL_TYPE_STD_MENU,
 		~0x03, 3, V4L2_EXPOSURE_AUTO, 0, NULL,
 		MMAL_PARAMETER_EXPOSURE_MODE,
-		&ctrl_set_exposure,
+		ctrl_set_exposure,
 		false
 	},
 /* todo this needs mixing in with set exposure
@@ -996,7 +996,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		/* Units of 100usecs */
 		1, 1 * 1000 * 10, 100 * 10, 1, NULL,
 		MMAL_PARAMETER_SHUTTER_SPEED,
-		&ctrl_set_exposure,
+		ctrl_set_exposure,
 		false
 	},
 	{
@@ -1004,7 +1004,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		0, ARRAY_SIZE(ev_bias_qmenu) - 1,
 		(ARRAY_SIZE(ev_bias_qmenu) + 1) / 2 - 1, 0, ev_bias_qmenu,
 		MMAL_PARAMETER_EXPOSURE_COMP,
-		&ctrl_set_value_ev,
+		ctrl_set_value_ev,
 		false
 	},
 	{
@@ -1012,7 +1012,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		0, 1,
 		0, 1, NULL,
 		0,	/* Dummy MMAL ID as it gets mapped into FPS range*/
-		&ctrl_set_exposure,
+		ctrl_set_exposure,
 		false
 	},
 	{
@@ -1020,7 +1020,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		MMAL_CONTROL_TYPE_STD_MENU,
 		~0x7, 2, V4L2_EXPOSURE_METERING_AVERAGE, 0, NULL,
 		MMAL_PARAMETER_EXP_METERING_MODE,
-		&ctrl_set_metering_mode,
+		ctrl_set_metering_mode,
 		false
 	},
 	{
@@ -1028,56 +1028,56 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		MMAL_CONTROL_TYPE_STD_MENU,
 		~0x3ff, 9, V4L2_WHITE_BALANCE_AUTO, 0, NULL,
 		MMAL_PARAMETER_AWB_MODE,
-		&ctrl_set_awb_mode,
+		ctrl_set_awb_mode,
 		false
 	},
 	{
 		V4L2_CID_RED_BALANCE, MMAL_CONTROL_TYPE_STD,
 		1, 7999, 1000, 1, NULL,
 		MMAL_PARAMETER_CUSTOM_AWB_GAINS,
-		&ctrl_set_awb_gains,
+		ctrl_set_awb_gains,
 		false
 	},
 	{
 		V4L2_CID_BLUE_BALANCE, MMAL_CONTROL_TYPE_STD,
 		1, 7999, 1000, 1, NULL,
 		MMAL_PARAMETER_CUSTOM_AWB_GAINS,
-		&ctrl_set_awb_gains,
+		ctrl_set_awb_gains,
 		false
 	},
 	{
 		V4L2_CID_COLORFX, MMAL_CONTROL_TYPE_STD_MENU,
 		0, 15, V4L2_COLORFX_NONE, 0, NULL,
 		MMAL_PARAMETER_IMAGE_EFFECT,
-		&ctrl_set_image_effect,
+		ctrl_set_image_effect,
 		false
 	},
 	{
 		V4L2_CID_COLORFX_CBCR, MMAL_CONTROL_TYPE_STD,
 		0, 0xffff, 0x8080, 1, NULL,
 		MMAL_PARAMETER_COLOUR_EFFECT,
-		&ctrl_set_colfx,
+		ctrl_set_colfx,
 		false
 	},
 	{
 		V4L2_CID_ROTATE, MMAL_CONTROL_TYPE_STD,
 		0, 360, 0, 90, NULL,
 		MMAL_PARAMETER_ROTATION,
-		&ctrl_set_rotate,
+		ctrl_set_rotate,
 		false
 	},
 	{
 		V4L2_CID_HFLIP, MMAL_CONTROL_TYPE_STD,
 		0, 1, 0, 1, NULL,
 		MMAL_PARAMETER_MIRROR,
-		&ctrl_set_flip,
+		ctrl_set_flip,
 		false
 	},
 	{
 		V4L2_CID_VFLIP, MMAL_CONTROL_TYPE_STD,
 		0, 1, 0, 1, NULL,
 		MMAL_PARAMETER_MIRROR,
-		&ctrl_set_flip,
+		ctrl_set_flip,
 		false
 	},
 	{
@@ -1085,14 +1085,14 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		0, ARRAY_SIZE(bitrate_mode_qmenu) - 1,
 		0, 0, bitrate_mode_qmenu,
 		MMAL_PARAMETER_RATECONTROL,
-		&ctrl_set_bitrate_mode,
+		ctrl_set_bitrate_mode,
 		false
 	},
 	{
 		V4L2_CID_MPEG_VIDEO_BITRATE, MMAL_CONTROL_TYPE_STD,
 		25 * 1000, 25 * 1000 * 1000, 10 * 1000 * 1000, 25 * 1000, NULL,
 		MMAL_PARAMETER_VIDEO_BIT_RATE,
-		&ctrl_set_bitrate,
+		ctrl_set_bitrate,
 		false
 	},
 	{
@@ -1100,7 +1100,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		1, 100,
 		30, 1, NULL,
 		MMAL_PARAMETER_JPEG_Q_FACTOR,
-		&ctrl_set_image_encode_output,
+		ctrl_set_image_encode_output,
 		false
 	},
 	{
@@ -1108,7 +1108,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		0, ARRAY_SIZE(mains_freq_qmenu) - 1,
 		1, 1, mains_freq_qmenu,
 		MMAL_PARAMETER_FLICKER_AVOID,
-		&ctrl_set_flicker_avoidance,
+		ctrl_set_flicker_avoidance,
 		false
 	},
 	{
@@ -1116,7 +1116,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		0, 1,
 		0, 1, NULL,
 		MMAL_PARAMETER_VIDEO_ENCODE_INLINE_HEADER,
-		&ctrl_set_video_encode_param_output,
+		ctrl_set_video_encode_param_output,
 		true	/* Errors ignored as requires latest firmware to work */
 	},
 	{
@@ -1129,7 +1129,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
 		V4L2_MPEG_VIDEO_H264_PROFILE_HIGH, 1, NULL,
 		MMAL_PARAMETER_PROFILE,
-		&ctrl_set_video_encode_profile_level,
+		ctrl_set_video_encode_profile_level,
 		false
 	},
 	{
@@ -1149,7 +1149,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		V4L2_MPEG_VIDEO_H264_LEVEL_4_0,
 		V4L2_MPEG_VIDEO_H264_LEVEL_4_0, 1, NULL,
 		MMAL_PARAMETER_PROFILE,
-		&ctrl_set_video_encode_profile_level,
+		ctrl_set_video_encode_profile_level,
 		false
 	},
 	{
@@ -1158,14 +1158,14 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		V4L2_SCENE_MODE_TEXT,
 		V4L2_SCENE_MODE_NONE, 1, NULL,
 		MMAL_PARAMETER_PROFILE,
-		&ctrl_set_scene_mode,
+		ctrl_set_scene_mode,
 		false
 	},
 	{
 		V4L2_CID_MPEG_VIDEO_H264_I_PERIOD, MMAL_CONTROL_TYPE_STD,
 		0, 0x7FFFFFFF, 60, 1, NULL,
 		MMAL_PARAMETER_INTRAPERIOD,
-		&ctrl_set_video_encode_param_output,
+		ctrl_set_video_encode_param_output,
 		false
 	},
 };
-- 
2.17.1

