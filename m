Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501AC00307
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E2521835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 02:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567824154;
	bh=hi6ARMNo4mt/ILpIl0D98oI9zo/bHpyE+9xRTup/Fb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEdOVrlPCfDvwhUbQRolM3xX+iioUNsKcLx3PVvRT8t34Tafm90Q8FFvpafpXtBjN
	 kiNJrlOMSR06xy4PCypQMFWOEYBDgiAb/f1qPZyo06EjSmTUExkZ/VRiCIcT54c82Y
	 sl7lQSdJocUf4aPnhdIYU478BY7KAca3UznaLj6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393930AbfIGCmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 22:42:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45065 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405630AbfIGCmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 22:42:32 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so17166760iog.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 19:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1Kn+fE99mbrL4seopxhHm4xOwT2+Ma+pxdkYjRzpLY=;
        b=UsvNjQ4peEdIz5Q80XWZuKeP4vXsfKYArk18XiDD/R0wBQLVrA5cJQCJru7ECgWglr
         /A1+KkyksPoucp+0XOXh+EStMtnXopO/nf6NLA4jPXDS3CDHwitH7Leu+Law1KlqW2mq
         Yyx7Umd3bby0G/7yv4Qql5aQ303hK7fDYADsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1Kn+fE99mbrL4seopxhHm4xOwT2+Ma+pxdkYjRzpLY=;
        b=jqe1vspkTxvygpKNKH8Cvo9YnOfydM9Cq0ZBMIFKcdFtae8YDavXjVUJAzFiS2BMW8
         gXd2Z+0w/6SElNF40qzXn6avaBa5S4tMax9mesqdywviuB/kGp1ATLiSf+7qFHLxVJdT
         aHVNKVnKe8MsXj660UHqkvkm+garV55WDrQPNj4g4N7sc/z4DscRqUxiK90czOve+pp8
         Oy6vfKOQC5PncHENxnrbtBYZ3wOQygnJ7rmReKhE9PlQ/SwntMR//DaSTUMK1hms/d57
         vxdyRXo8ETGeP26yo8zAqjkbcF0nOnSEaipcX/uIjUWQphgzcTgA8slec38JXE0UEsRM
         0EdQ==
X-Gm-Message-State: APjAAAUyPaGxUwj/vxUWlF9102KQqkqeWdQHh5t7ZYjR1Z7JGNPoQ8Ln
        websIrKDEu6WsYNBZPqJqzEGTg==
X-Google-Smtp-Source: APXvYqwDNeAD/jEjr3uhBZ9w/LkuK0Ra7z2rjhhXH6PeJbuGZmkn7RqmM4a/XMJoJm/K5+M3N6ggYQ==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr13623306jaa.106.1567824150802;
        Fri, 06 Sep 2019 19:42:30 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b7sm6441427iod.78.2019.09.06.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 19:42:30 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] vimc: move duplicated IS_SRC and IS_SINK to common header
Date:   Fri,  6 Sep 2019 20:42:17 -0600
Message-Id: <8dbc93c2a7291d942d2d37491833444d77316211.1567822793.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1567822792.git.skhan@linuxfoundation.org>
References: <cover.1567822792.git.skhan@linuxfoundation.org>
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
index 87ee84f78322..236412ad7548 100644
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
index b38b55f51a24..37f3767db469 100644
--- a/drivers/media/platform/vimc/vimc-debayer.c
+++ b/drivers/media/platform/vimc/vimc-debayer.c
@@ -22,9 +22,6 @@ MODULE_PARM_DESC(deb_mean_win_size, " the window size to calculate the mean.\n"
 	"stays in the center of the window, otherwise the next odd number "
 	"is considered");
 
-#define IS_SINK(pad) (!pad)
-#define IS_SRC(pad)  (pad)
-
 enum vimc_deb_rgb_colors {
 	VIMC_DEB_RED = 0,
 	VIMC_DEB_GREEN = 1,
@@ -157,7 +154,7 @@ static int vimc_deb_enum_mbus_code(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_mbus_code_enum *code)
 {
 	/* We only support one format for source pads */
-	if (IS_SRC(code->pad)) {
+	if (VIMC_IS_SRC(code->pad)) {
 		struct vimc_deb_device *vdeb = v4l2_get_subdevdata(sd);
 
 		if (code->index)
@@ -183,7 +180,7 @@ static int vimc_deb_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index)
 		return -EINVAL;
 
-	if (IS_SINK(fse->pad)) {
+	if (VIMC_IS_SINK(fse->pad)) {
 		const struct vimc_deb_pix_map *vpix =
 			vimc_deb_pix_map_by_code(fse->code);
 
@@ -213,7 +210,7 @@ static int vimc_deb_get_fmt(struct v4l2_subdev *sd,
 		      vdeb->sink_fmt;
 
 	/* Set the right code for the source pad */
-	if (IS_SRC(fmt->pad))
+	if (VIMC_IS_SRC(fmt->pad))
 		fmt->format.code = vdeb->src_code;
 
 	return 0;
@@ -260,7 +257,7 @@ static int vimc_deb_set_fmt(struct v4l2_subdev *sd,
 	 * Do not change the format of the source pad,
 	 * it is propagated from the sink
 	 */
-	if (IS_SRC(fmt->pad)) {
+	if (VIMC_IS_SRC(fmt->pad)) {
 		fmt->format = *sink_fmt;
 		/* TODO: Add support for other formats */
 		fmt->format.code = vdeb->src_code;
diff --git a/drivers/media/platform/vimc/vimc-scaler.c b/drivers/media/platform/vimc/vimc-scaler.c
index 05db5070e268..a5a0855ad9cd 100644
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

