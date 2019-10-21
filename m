Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C558CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1B72084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0BE8wee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfJUKf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:35:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44382 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfJUKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:35:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so7540131pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=H0BE8weeGQn2WySiuRb+gKaFVKFQ7KMLVZ3dRmtUOI8X5pcqHTFM7GXNw27rl2sawo
         P7jYI09TXntT0JzSLhGxYPIHV5GSPV6U+4apNg7kDFWtz5vu5CCgmtfyD5nbC02pl5Rl
         47uIDf+hqdDydBjT1xdlYLy21GCjcBGTFliZYzQylLmwe5Ir/cs6FWAuy5wfGfJEIt9t
         VoQiw1oiGRpqByof/t7G6Tn1i/MVgJpqkCMzusZPJwmlgptfgbk/YvIX0QIbnyQr2LSC
         5nfNsPnqowCRjdXzkCDfhdKpRkc4cjTfno9WAppgdirgW2zMsG6FJN3n+FLzNBlNYmIk
         7MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cALbZwSOU8EvtF0iOAGpF4/JluhlENqnhyD2XhJQYmg=;
        b=uPkIvRbD0WnA4hBTrkF/jvdcw24xIdP150hbVh1yc07TKO54G5ejGrCyCQz/r7+WZS
         21KLq3GYt85dfNn3bM7IFCU6EikMrzHvt1xNGte8nqtJDZzr9OK/Yv8tocg20RMl57EZ
         FxwHYlRcKcO+rd1keO1dnt4g4Y2Nehi8rGTJnjaj9ife9yc8V7jcU26MIQD4HqgtJxpo
         Xijyy6B3YClTJhFCKGNUa3XlZT65wlza1T3J95unxOW6BCSIUajvcdBfhxEvlgwq2Y/r
         I+kP9DjkKM6hWwZtxN2wQIxtCKQPtLe12v2sO9lW1QgZgru+Um3u6Y9QCRUfo4SDW73P
         eYAQ==
X-Gm-Message-State: APjAAAXWVKByNpv8NH62mkVrzfi3EZZc5PwrzPFc+YNBmY70vth1zoVs
        L1ZDFEcB1gkM8Mo+P3YacufEyYF+6DuanQ==
X-Google-Smtp-Source: APXvYqxwkCdW3hoZGhMouiok1E3s+a9UAP5ShBjMBhUBTUWzHLBGV5I+r7kyAAQ6ox9BpaKt3icvCw==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr27995872pjq.96.1571654152956;
        Mon, 21 Oct 2019 03:35:52 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id r30sm15644244pfl.42.2019.10.21.03.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 03:35:52 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v6 03/15] drivers: thermal: tsens: Add __func__ identifier to debug statements
Date:   Mon, 21 Oct 2019 16:05:22 +0530
Message-Id: <18717de35f31098d3ebc12564c2767b6d54d37d8.1571652874.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571652874.git.amit.kucheria@linaro.org>
References: <cover.1571652874.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the function name when enabling debugging makes logs easier to
read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 drivers/thermal/qcom/tsens.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c037bdf92c663..7437bfe196e50 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -42,8 +42,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
-			"sensor%d - data_point1:%#x data_point2:%#x\n",
-			i, p1[i], p2[i]);
+			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
+			__func__, i, p1[i], p2[i]);
 
 		priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
@@ -60,7 +60,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
 				(CAL_DEGC_PT1 *
 				priv->sensor[i].slope);
-		dev_dbg(priv->dev, "offset:%d\n", priv->sensor[i].offset);
+		dev_dbg(priv->dev, "%s: offset:%d\n", __func__, priv->sensor[i].offset);
 	}
 }
 
@@ -209,7 +209,7 @@ int __init init_common(struct tsens_priv *priv)
 	if (ret)
 		goto err_put_device;
 	if (!enabled) {
-		dev_err(dev, "tsens device is not enabled\n");
+		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
 	}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 542a7f8c3d962..06c6bbd69a1a7 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -127,7 +127,7 @@ static int tsens_probe(struct platform_device *pdev)
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
 
 	if (num_sensors <= 0) {
-		dev_err(dev, "invalid number of sensors\n");
+		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
 	}
 
@@ -156,7 +156,7 @@ static int tsens_probe(struct platform_device *pdev)
 
 	ret = priv->ops->init(priv);
 	if (ret < 0) {
-		dev_err(dev, "tsens init failed\n");
+		dev_err(dev, "%s: init failed\n", __func__);
 		return ret;
 	}
 
@@ -164,7 +164,7 @@ static int tsens_probe(struct platform_device *pdev)
 		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "tsens calibration failed\n");
+				dev_err(dev, "%s: calibration failed\n", __func__);
 			return ret;
 		}
 	}
-- 
2.17.1

