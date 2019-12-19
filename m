Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84823222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQ8G1RAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLSSXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:23:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45025 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:23:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so2915718plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2o+AG3RvUH+GxTzi1IbYJSvnHQRcuO5FLTvuUuElWHc=;
        b=gQ8G1RAeBnSBMUz9vxx63vb4M+B8ZgAkiKSSzFgs7w5UGWiXl6ndClyr3rfdt0ukjV
         pBwFrlIdO6Lk3XgBiB6b3zA6FNde+Nwrkr2b3+Wxe3nyxUFGxFN7vb0qaA65jtXetc5A
         p7Dpr8fva+rX4v9D9hpA1+FNcW+sgJk2hFWLQI0Q5oblXjF3DkXyJLYTFOu4VTLS1TQi
         U0W327PywietOTD3gTTtx8SKJLPVpea8lYTjEBHvs1D7poJhOFEHjkUixb4pz/9MVOv0
         UVNTPvJNXkh/jXwXv7JuRsiIUh1cREVBP0c4C6GEjefuJqSC2pOQNG6GfhK6OEy4dAAu
         sjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2o+AG3RvUH+GxTzi1IbYJSvnHQRcuO5FLTvuUuElWHc=;
        b=Bsxga+YSkDk6ZrFdlZ3SkOUaWALim9fFCvN0UyHDE9CKFGNHc42rS6pjpvdQC7BuiB
         do5kNXyduaoUwbDV9nEfla1HLk4wZCayeyA3F0/zC3DZCmAK9q5Z8KLXF92XHq7ktxqc
         5B5SkGjL0z8SmlNPholoGnlJ2ODLlvclVMBhFnGYfRe0H7qJZ5mjykKwvABh98m4L6jb
         TuRvPtsEpg7N1CPs1jcyKgGqVpkaGZElDV1Tegn/dR6vRSglTbosdDmFD9t5+qMwqV+G
         s3jm+LIVwzeR0yDAIitQXiNLjp2MZzxAMFY5WDnYmrIQXcFqbrsjUj08qitwDtjzIpVG
         deWQ==
X-Gm-Message-State: APjAAAVAu+j3jbgSJazO/0EHeCyjlzHegH1xbZzVqA9mPYr1XVcu/CuM
        9j+Es3bp14LQgW3thQWhqiTt
X-Google-Smtp-Source: APXvYqyzVnZODv06yR3mjE0LzOn3l+hcZpCkDYMSSVHn9s9fFrnBf0tRvxzqCDRbMLZlsMAYZMYNuw==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr10707013ple.324.1576779785449;
        Thu, 19 Dec 2019 10:23:05 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6010:65a5:a416:e9bd:178a:9286])
        by smtp.gmail.com with ESMTPSA id i3sm9085735pfg.94.2019.12.19.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:23:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/6] media: i2c: imx290: Add support to enumerate all frame sizes
Date:   Thu, 19 Dec 2019 23:52:20 +0530
Message-Id: <20191219182222.18961-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219182222.18961-1-manivannan.sadhasivam@linaro.org>
References: <20191219182222.18961-1-manivannan.sadhasivam@linaro.org>
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
index b6eeca56d3c9..a1974340e6fa 100644
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
@@ -823,6 +842,7 @@ static const struct v4l2_subdev_video_ops imx290_video_ops = {
 static const struct v4l2_subdev_pad_ops imx290_pad_ops = {
 	.init_cfg = imx290_entity_init_cfg,
 	.enum_mbus_code = imx290_enum_mbus_code,
+	.enum_frame_size = imx290_enum_frame_size,
 	.get_fmt = imx290_get_fmt,
 	.set_fmt = imx290_set_fmt,
 };
-- 
2.17.1

