Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5C222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmDLD54W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLSSXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:23:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34802 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:23:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so2935360pln.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AFvgHo+YGqFoje0Tn82GYQJ1a/RGDe/xy+Kyh3iTfBI=;
        b=kmDLD54Wg3ujI/AZ5o82fQsFYrDiuccUSsctI4Y7S7mXX6MyEfNbDjjW9+s6zcVUKS
         nygmXBu+d+VM9XCAAmQ3nbV9d3I72uZUIsjZ2SF8TFVUHPw9QRjNM6Jw+1BRPLeBXvp1
         cBNCRZIY/A1kpYJfHUDMOI8ai1nkGnezL24ODwAzUUPH7TiHct5j6i/A08jdpjRE3R5J
         pQvdnIciCIRAL3pDWcp2YfwuPzLAraQHzAVxWEuuc2oUYwHjmUQ7vD7F4aLl++6gwKFt
         mqL2MxBLFXllu3VhBGuTZzEB+Xzt4jE5lsgOpSSCUES1bflOqdaIw4CudFV4w25Q/kpG
         sIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AFvgHo+YGqFoje0Tn82GYQJ1a/RGDe/xy+Kyh3iTfBI=;
        b=gFrEtxv75d9wFjUe1SfTt8uHLMbhXUM+i8GSMV79m2GvAE6QwEV0x648V8QMJa+iFP
         ivRN7SwiEVBiD9QLbt8TkYkjKkVBTuR+cZ/wcWkzS5pRLa9d/1bRvZ3PeDGrNhQ8gbFF
         5Hg+O6GwKGnStkOby35nl82cjd/q529GWGuYOZWT/KBTina/PFthuerdenPUivrj9rYG
         oPP+lCw4odh9RR5Bj5x8EjEu5Az7oHanmE0beweC6V2Vcu5x/cLfrbJR3JHJe16RXLlg
         6dwGxVb8+8GqexLfG8ibMCALKwSr1USadEeQhqEjldyLtDsidftuZPP8cfMa3FcEFgJK
         +L6Q==
X-Gm-Message-State: APjAAAWbV+4gRiR9XmD2bZHvLa0R0YoXcNcqrU4Wskr/vHCp9HaD69iD
        V0q5m/kWMlyrclfpmIUCMqaj
X-Google-Smtp-Source: APXvYqzXfMn0kZmuBjpUAbmkAgP2/fMJH486K6UgeYhEJzoLI3sQVo78zCN+SN0jVd3rtq83ZuxG7Q==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19mr8338103pls.134.1576779780558;
        Thu, 19 Dec 2019 10:23:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6010:65a5:a416:e9bd:178a:9286])
        by smtp.gmail.com with ESMTPSA id i3sm9085735pfg.94.2019.12.19.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:23:00 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/6] media: i2c: imx290: Add RAW12 mode support
Date:   Thu, 19 Dec 2019 23:52:19 +0530
Message-Id: <20191219182222.18961-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219182222.18961-1-manivannan.sadhasivam@linaro.org>
References: <20191219182222.18961-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX290 is capable of outputting frames in both Raw Bayer (packed) 10 and
12 bit formats. Since the driver already supports RAW10 mode, let's add
the missing RAW12 mode as well.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/imx290.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 96eea0aafd3e..b6eeca56d3c9 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -75,6 +75,7 @@ struct imx290 {
 	struct clk *xclk;
 	struct regmap *regmap;
 	u8 nlanes;
+	u8 bpp;
 
 	struct v4l2_subdev sd;
 	struct v4l2_fwnode_endpoint ep;
@@ -98,6 +99,7 @@ struct imx290_pixfmt {
 
 static const struct imx290_pixfmt imx290_formats[] = {
 	{ MEDIA_BUS_FMT_SRGGB10_1X10 },
+	{ MEDIA_BUS_FMT_SRGGB12_1X12 },
 };
 
 static const struct regmap_config imx290_regmap_config = {
@@ -265,6 +267,18 @@ static const struct imx290_regval imx290_10bit_settings[] = {
 	{ 0x300b, 0x00},
 };
 
+static const struct imx290_regval imx290_12bit_settings[] = {
+	{ 0x3005, 0x01 },
+	{ 0x3046, 0x01 },
+	{ 0x3129, 0x00 },
+	{ 0x317c, 0x00 },
+	{ 0x31ec, 0x0e },
+	{ 0x3441, 0x0c },
+	{ 0x3442, 0x0c },
+	{ 0x300a, 0xf0 },
+	{ 0x300b, 0x00 },
+};
+
 /* supported link frequencies */
 static const s64 imx290_link_freq[] = {
 	IMX290_DEFAULT_LINK_FREQ,
@@ -550,6 +564,21 @@ static int imx290_write_current_format(struct imx290 *imx290,
 			dev_err(imx290->dev, "Could not set format registers\n");
 			return ret;
 		}
+
+		imx290->bpp = 10;
+
+		break;
+	case MEDIA_BUS_FMT_SRGGB12_1X12:
+		ret = imx290_set_register_array(imx290, imx290_12bit_settings,
+						ARRAY_SIZE(
+							imx290_12bit_settings));
+		if (ret < 0) {
+			dev_err(imx290->dev, "Could not set format registers\n");
+			return ret;
+		}
+
+		imx290->bpp = 12;
+
 		break;
 	default:
 		dev_err(imx290->dev, "Unknown pixel format\n");
@@ -913,6 +942,9 @@ static int imx290_probe(struct i2c_client *client)
 		goto free_err;
 	}
 
+	/* Default bits per pixel value */
+	imx290->bpp = 10;
+
 	mutex_init(&imx290->lock);
 
 	v4l2_ctrl_handler_init(&imx290->ctrls, 4);
-- 
2.17.1

