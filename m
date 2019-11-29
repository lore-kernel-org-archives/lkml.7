Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55B21771
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 19:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNqp5p7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK2TGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 14:06:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:45888 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfK2TGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 14:06:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id r11so5794727pjp.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 11:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FM9xo7QIIBKERzlsc9RY2lQmdtL0uWG+xaaghB/dV4=;
        b=tNqp5p7dcPlaZftpP3TycmCHaYycdBuJHeVbtDykKAoJibe93S5N8XsAUYK9ayfAcl
         Iaw1JF/4vRMyErNfvVyZm2qWAKkrV0SakuAY7meg13MWatjW1Ob2Byu2+QJoeCPV+r0d
         VgnBSHlvUbgxIiU8k1S3UAy0/pnc0urZFPkQL/ChnqlyO1A3mv0znx6AU+mS5A+hUDBc
         3NLPVkZE+F+tWYSGU2PlGSm3CSmuEPS/uVSKr+uIqkM8qaC8ilzsCLoI6utdaggXBFps
         Y+FUI2/lkIlOWLfNxaduQYR0K5UI4frt90Mc4OszFfpizS+NqPqTAbwEarlLoOmOkr3E
         2KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/FM9xo7QIIBKERzlsc9RY2lQmdtL0uWG+xaaghB/dV4=;
        b=g7Ftw7NvFUjdRYvX3/KLH4r93qjC9/Y+s3bOf/RF2ijeE+P+LxC1OxfR6CF4ISL8sJ
         tferjHCfY7gVQZYx8cMtWpyfnz2/f2J/KeTgDZ2VZk1b33qrzc0GGr3KKRp/iyy4/+fv
         OfOeOyoOEpL/AVewrA+i3fTKDvSGcEpayKqYlgdSq+ejiYbpybpCpB2WorrxsoTs89mc
         WFBnWKr3MzTYNwlBf54M2ej/5HLj/4zBZplIWZoM3RuhHCHVFaZq/gVPza5yab2Yh68e
         +Sa/Vk+gnpcBiPDWhbRVhLCddh2YGNKSx1dx7OKEkTIoVnT25P384SNHSew99HwopFw1
         Xm2g==
X-Gm-Message-State: APjAAAWfD/4LOFr7ogXWUsKvqdLDK43Ks8EotwJvq8OGkSK5JhR6E86+
        nTP7vzIpheehgUt1I2+FWCQJ
X-Google-Smtp-Source: APXvYqw99CLh8HXavEoyULyhtO2nxTDFigWCoqEaIX82JYh7hHk+VlWTCUefWQFUD7lg1xwR+i2dYw==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr16072824pln.125.1575054375293;
        Fri, 29 Nov 2019 11:06:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:638d:cc55:d006:f721:cde2:1059])
        by smtp.gmail.com with ESMTPSA id h9sm25159974pgk.84.2019.11.29.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 11:06:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] media: i2c: imx290: Add support to enumerate all frame sizes
Date:   Sat, 30 Nov 2019 00:35:40 +0530
Message-Id: <20191129190541.30315-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129190541.30315-1-manivannan.sadhasivam@linaro.org>
References: <20191129190541.30315-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to enumerate all frame sizes supported by IMX290. This is
required for using with userspace tools such as libcamera.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index d5bb3a59ac46..f26c4a0ee0a0 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -468,6 +468,25 @@ static int imx290_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int imx290_enum_frame_size(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_pad_config *cfg,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	if ((fse->code != imx290_formats[0].code) &&
+	    (fse->code != imx290_formats[1].code))
+		return -EINVAL;
+
+	if (fse->index >= ARRAY_SIZE(imx290_modes))
+		return -EINVAL;
+
+	fse->min_width = imx290_modes[fse->index].width;
+	fse->max_width = imx290_modes[fse->index].width;
+	fse->min_height = imx290_modes[fse->index].height;
+	fse->max_height = imx290_modes[fse->index].height;
+
+	return 0;
+}
+
 static int imx290_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
 			  struct v4l2_subdev_format *fmt)
@@ -820,6 +839,7 @@ static const struct v4l2_subdev_video_ops imx290_video_ops = {
 static const struct v4l2_subdev_pad_ops imx290_pad_ops = {
 	.init_cfg = imx290_entity_init_cfg,
 	.enum_mbus_code = imx290_enum_mbus_code,
+	.enum_frame_size = imx290_enum_frame_size,
 	.get_fmt = imx290_get_fmt,
 	.set_fmt = imx290_set_fmt,
 };
-- 
2.17.1

