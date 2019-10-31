Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D598CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA7208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0/sfJRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJaMX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:23:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45602 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfJaMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:23:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so3935597pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3oVOdq8I07h/GCMR1jINzKAZkqhi2YtbfA6UhRaG+n8=;
        b=a0/sfJRTsmfaNdczbP/UocpLZeZWofQtNcy/OCkKLyPFEzM62I2i+2UIUeRohI2Pzh
         dJuAqpawZBwB5gf8KbLZvqBtZ66tXwq2oxP+j3mLWZj9WIvAfeeHLVRlv5iZRzYdIGY/
         +BJkEgbFY56XdIUiDecypECQx/gY0Cw/rRF3Zk1aB6ci+f3XVrTAqSJbI/9gvnmt/0TW
         Y9N42pwj+OY+n4tYx/ZGe85ChkV3wNss7JpiczK4K3v54hwlYdHYduIzEo/qO/rURc8w
         tj1UPWzFILDZuc0MMFy/cm6aLQw95ceusZWQGBscvGtkPJgt+FVEIxblgYJ12ZkCJfQP
         vwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3oVOdq8I07h/GCMR1jINzKAZkqhi2YtbfA6UhRaG+n8=;
        b=bm1kqWIfwnVoCMWhBqjABwxw0foOjgd8/5HWmA38Ml9+FlSVGuBU/5P7m0A3Was44d
         d5HcAm+wxy3zq66HnyNsoSoUoxvslT3uacK7kh1PmuVaAZnC1yqigs1+FwsJ8s260AD2
         ZWFLM6cBpatfePjwDCNIPvOZHMXr9LUB7DW1CZjM2l/CHlKQDR0bPBeAMw36BeIdU650
         xOZTH4g1iSzBIT13rH9U9JFh9hoSMT9IC9vtIZKLy7d6q1K6Xi5tVHAMs76GRhpMM3+V
         D6tLAesX9GLxTkwzrH5uF+Z69KAVS/xbGR7vUCiQHGGuwmm0b5Q9sOO9MFZ+gSiIU6nN
         LvRA==
X-Gm-Message-State: APjAAAVFem9wOBFvMgN9u0k5qr1TXr3seCpzC+qIh1kZZeY11ZK6Dbi1
        OS6JnCrd7b3djdHFaI63NKzZkw==
X-Google-Smtp-Source: APXvYqwRsBatPyRPC6H5u3bNXQ3d9fpGbW7bwKpnEtOkZpwtidHIsC1wSk8dAdf1LqVvm7kugUi34w==
X-Received: by 2002:a63:6d8b:: with SMTP id i133mr6165132pgc.241.1572524636826;
        Thu, 31 Oct 2019 05:23:56 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:55 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 5/5] power: supply: sc27xx: Calibrate the resistance of coulomb counter
Date:   Thu, 31 Oct 2019 20:22:44 +0800
Message-Id: <d32db383ed63c4775b92c30a129cb5f6b0929007.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some deviations between the real resistance and the ideal
resistance of coulomb counter, which will affect the accuracy of
the coulomb counter, thus calibrate the real resistance of coulomb
counter to improve the accuracy.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 221b6fb..951d5d1 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -62,6 +62,8 @@
 
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
+/* micro Ohms */
+#define SC27XX_FGU_IDEAL_RESISTANCE	20000
 
 /*
  * struct sc27xx_fgu_data: describe the FGU device
@@ -84,6 +86,7 @@
  * @resist_table_len: the resistance table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
  * @vol_1000mv_adc: ADC value corresponding to 1000 mV
+ * @calib_resist: the real resistance of coulomb counter chip in mOhm
  * @cap_table: capacity table with corresponding ocv
  * @resist_table: resistance percent table with corresponding temperature
  */
@@ -108,6 +111,7 @@ struct sc27xx_fgu_data {
 	int resist_table_len;
 	int cur_1000ma_adc;
 	int vol_1000mv_adc;
+	int calib_resist;
 	struct power_supply_battery_ocv_table *cap_table;
 	struct power_supply_resistance_temp_table *resist_table;
 };
@@ -900,7 +904,9 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
 	 */
 	cal_4200mv = (calib_data & 0x1ff) + 6963 - 4096 - 256;
 	data->vol_1000mv_adc = DIV_ROUND_CLOSEST(cal_4200mv * 10, 42);
-	data->cur_1000ma_adc = data->vol_1000mv_adc * 4;
+	data->cur_1000ma_adc =
+		DIV_ROUND_CLOSEST(data->vol_1000mv_adc * 4 * data->calib_resist,
+				  SC27XX_FGU_IDEAL_RESISTANCE);
 
 	kfree(buf);
 	return 0;
@@ -1079,6 +1085,15 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = device_property_read_u32(&pdev->dev,
+				       "sprd,calib-resistance-micro-ohms",
+				       &data->calib_resist);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to get fgu calibration resistance\n");
+		return ret;
+	}
+
 	data->channel = devm_iio_channel_get(dev, "bat-temp");
 	if (IS_ERR(data->channel)) {
 		dev_err(dev, "failed to get IIO channel\n");
-- 
1.7.9.5

