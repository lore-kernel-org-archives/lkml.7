Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8312AC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568738123;
	bh=TjvEZPe2a+RFVr9FYE1FEfJIkFGBeX7rSiQpcRtHAts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJDfTeBsZHeUxnNnxjq/75ymQyPHOv0OR0Wvy88U7JNwcxQK9ZIhOPf7zsrXHiShe
	 JHcpboW5gSNghlc5xY6KTisWr9F1rpwAA9zczKww5PhySsG7iqkA5/QY8VcUjgdTUR
	 CazVLjbuMRkWYJAYewNUVNieJaqEVn9dQ+gcxtV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfIQQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:35:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42984 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfIQQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:21 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so9083837iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRbhVfvRjBgPiFZTzfKxL4tHG34+Dl9OtCfa42+v2MQ=;
        b=e8B5/nHmz3KnXtQhBp9saALcYvmJsEcmtKtFnWEtfNrFq9Wf+6wI1rmvMO3LNxLLeg
         XEqvDNLsv+fUDlD8rpYaCy3UCRNdS+ZcIa7Kpm86qmZtjMwyZaQmWEnQE6WcPYnKpzwD
         uYbCDLibRtl83AvkgJmcjuL5Sk2ePDUXTKdww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRbhVfvRjBgPiFZTzfKxL4tHG34+Dl9OtCfa42+v2MQ=;
        b=M4HC90a8K2mgTP/e5RvdVO4rnWDGXTQC5dH9AOe2/lS8EX/uqdEjU6KLTWQido7zEE
         0fur0fTolzrAfYwOLGPuk9yEkymrhQLI/6rmTkgy/Sm90IjO6lfbkUiQ0lOg8FmcAhmF
         rXy/qNr+J6XWstT2SUijf2XXEiuAl5RMiNAN0I9GMQdPy0FgsMksDQC+XCyonObGcVIF
         GFJAVxWrncHQCj2PSaFjtjeT0ofx8cxV62JA2eorh3yKZVTY0Na+Hd29Ls9cJDLmimp+
         T2q0D4JIdZqX/M6va31rKXXc88YltGla4UVu3ixKSP0AVI73+dWJxVp2ZPHG+USp3iT/
         NO0Q==
X-Gm-Message-State: APjAAAXD2Ii7NmkSE6bBr8h4a04sUnQjw1vdcJlJ/chkBGSqXJLeJUGW
        P1l0JbwW30JDqgJcwGRPVBpaTg==
X-Google-Smtp-Source: APXvYqznJo6RDb3Wnpbt0iL/OLIWgoFfXqTiSdC31cUaKrUW3hlXn7a6d8viQTm+eDFyKzKYv7kw7w==
X-Received: by 2002:a5d:89da:: with SMTP id a26mr1704786iot.61.1568738120464;
        Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm2593781ioh.51.2019.09.17.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 09:35:20 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] vimc: move duplicated IS_SRC and IS_SINK to common header
Date:   Tue, 17 Sep 2019 10:35:10 -0600
Message-Id: <776b23b8fa963df3eea3c4920c78b052ef4567a1.1568689325.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1568689325.git.skhan@linuxfoundation.org>
References: <cover.1568689325.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move duplicated IS_SRC and IS_SINK dfines to common header. Rename
them to VIMC_IS_SRC and VIM_IS_SINK.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/media/platform/vimc/vimc-common.h  |  4 ++++
 drivers/media/platform/vimc/vimc-debayer.c | 11 ++++-------
 drivers/media/platform/vimc/vimc-scaler.c  |  8 +++-----
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/vimc/vimc-common.h b/drivers/media/platform/vimc/vimc-common.h
index d7aaf31175bc..698db7c07645 100644
--- a/drivers/media/platform/vimc/vimc-common.h
+++ b/drivers/media/platform/vimc/vimc-common.h
@@ -27,6 +27,10 @@
 
 #define VIMC_FRAME_INDEX(lin, col, width, bpp) ((lin * width + col) * bpp)
 
+/* Source and sink pad checks */
+#define VIMC_IS_SRC(pad)	(pad)
+#define VIMC_IS_SINK(pad)	(!(pad))
+
 /**
  * struct vimc_colorimetry_clamp - Adjust colorimetry parameters
  *
diff --git a/drivers/media/platform/vimc/vimc-debayer.c b/drivers/media/platform/vimc/vimc-debayer.c
index 4125159e8f31..feac47d79449 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -20,9 +20,6 @@ MODULE_PARM_DESC(deb_mean_win_size, " the window size to calculate the mean.\n"
 	"stays in the center of the window, otherwise the next odd number "
 	"is considered");
 
-#define IS_SINK(pad) (!pad)
-#define IS_SRC(pad)  (pad)
-
 enum vimc_deb_rgb_colors {
 	VIMC_DEB_RED = 0,
 	VIMC_DEB_GREEN = 1,
@@ -155,7 +152,7 @@ static int vimc_deb_enum_mbus_code(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_mbus_code_enum *code)
 {
 	/* We only support one format for source pads */
-	if (IS_SRC(code->pad)) {
+	if (VIMC_IS_SRC(code->pad)) {
 		struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
 
 		if (code->index)
@@ -181,7 +178,7 @@ static int vimc_deb_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index)
 		return -EINVAL;
 
-	if (IS_SINK(fse->pad)) {
+	if (VIMC_IS_SINK(fse->pad)) {
 		const struct vimc_deb_pix_map *vpix =
 			vimc_deb_pix_map_by_code(fse->code);
 
@@ -211,7 +208,7 @@ static int vimc_deb_get_fmt(struct v4l2_subdev *sd,
 		      vdeb->sink_fmt;
 
 	/* Set the right code for the source pad */
-	if (IS_SRC(fmt->pad))
+	if (VIMC_IS_SRC(fmt->pad))
 		fmt->format.code = vdeb->src_code;
 
 	return 0;
@@ -258,7 +255,7 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 	 * Do not change the format of the source pad,
 	 * it is propagated from the sink
 	 */
-	if (IS_SRC(fmt->pad)) {
+	if (VIMC_IS_SRC(fmt->pad)) {
 		fmt->format = *sink_fmt;
 		/* TODO: Add support for other formats */
 		fmt->format.code = vdeb->src_code;
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index 1a593d81ea7c..a6a3cc5be872 100644
--- a/drivers/media/platform/vimc/vimc-scaler.c
+++ b/drivers/media/platform/vimc/vimc-scaler.c
@@ -16,8 +16,6 @@ static unsigned int sca_mult = 3;
 module_param(sca_mult, uint, 0000);
 MODULE_PARM_DESC(sca_mult, " the image size multiplier");
 
-#define IS_SINK(pad)	(!pad)
-#define IS_SRC(pad)	(pad)
 #define MAX_ZOOM	8
 
 struct vimc_sca_device {
@@ -93,7 +91,7 @@ static int vimc_sca_enum_frame_size(struct v4l2_subdev *sd,
 	fse->min_width = VIMC_FRAME_MIN_WIDTH;
 	fse->min_height = VIMC_FRAME_MIN_HEIGHT;
 
-	if (IS_SINK(fse->pad)) {
+	if (VIMC_IS_SINK(fse->pad)) {
 		fse->max_width = VIMC_FRAME_MAX_WIDTH;
 		fse->max_height = VIMC_FRAME_MAX_HEIGHT;
 	} else {
@@ -116,7 +114,7 @@ static int vimc_sca_get_fmt(struct v4l2_subdev *sd,
 			 vsca->sink_fmt;
 
 	/* Scale the frame size for the source pad */
-	if (IS_SRC(format->pad)) {
+	if (VIMC_IS_SRC(format->pad)) {
 		format->format.width = vsca->sink_fmt.width * sca_mult;
 		format->format.height = vsca->sink_fmt.height * sca_mult;
 	}
@@ -165,7 +163,7 @@ static int vimc_sca_set_fmt(struct v4l2_subdev *sd,
 	 * Do not change the format of the source pad,
 	 * it is propagated from the sink
 	 */
-	if (IS_SRC(fmt->pad)) {
+	if (VIMC_IS_SRC(fmt->pad)) {
 		fmt->format = *sink_fmt;
 		fmt->format.width = sink_fmt->width * sca_mult;
 		fmt->format.height = sink_fmt->height * sca_mult;
-- 
2.20.1

