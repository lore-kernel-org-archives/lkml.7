Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BADDCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D80521E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6uDInPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfJ1HUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:20:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43469 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732644AbfJ1HUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so6273167pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HKtGe92TapQ2KIwqzwkswK8RAIuyaGxBvNdNmUU4dN4=;
        b=v6uDInPrs2q1qq4SFLLdTjpdDc3eS25cnyOgpZtsm/H1e6dUBVUjCnRTrIW9Je4DLe
         XqJz6uv+N5YdTtXGCsY5Nwk+YABBQWVqJRGdRpgtWscX0dTeHgTPJbLMsxO2Nn6Hjz3S
         dbBAmtfdRa2obhR4Db360QfEdyh2kQKCBrXYwvs4DQUeecLSmuAgCNg+8vDcZ+byWbxq
         kvfNWHa1AXgqxiYlqzAl/rAe0f36GBnVfL8P29Oh6h2SM/31I+Xd91PIcC63SXDmcHIo
         jZzak31XqYgXmaToPXOP0+62BYK/AyoRWAgahLk4g/uE6jWTpMz8/SETq2QRPAsWDrvB
         +2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HKtGe92TapQ2KIwqzwkswK8RAIuyaGxBvNdNmUU4dN4=;
        b=La12nVslncBgmq65eESlTCKtn4B/lFiIz2PGmN9oGHavgv41Pbt5LmrDfv8escM9xd
         Oyxsxv8cLVS4H0ncqXcz7KjJ7woVmCMwJQ+fsqs+SSLspMfnYqxANQmj+Ipl+Q4lE8B9
         +FQaR2Tx+rTOiiT++D6pzVvS0FPztF5FlhXmntUCo6OmcrRE9jrW1pgKqmAywnt9/l2F
         y3ZzmfhnOEYxtVtnHoRqILFvPEISYLQ1E304ZPU6I4ZA811HsRIBwKMnw5FYZaaFg3A1
         Cptg9snSYeWUFtO9VPSGbzMIIrV5fp6J81nus6Qef0sQxfs6dv+h3c2+blC2jHKVIIhI
         WRRg==
X-Gm-Message-State: APjAAAV1n2UdYBO4RmeosCsujW9a2G1BttrZsIwPfK3QbsU2gE1nqP4P
        0r+bRSReAsrWyJIUXAaEtG9Xeg==
X-Google-Smtp-Source: APXvYqy3mTOff/5UucNGniK8fyS/O+Xgm14NgFfPUR1PrG8IBcUY/kuiLl/NHA1b0kfdyxfyfp644Q==
X-Received: by 2002:a62:108:: with SMTP id 8mr9220601pfb.53.1572247209947;
        Mon, 28 Oct 2019 00:20:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 13sm11504703pgq.72.2019.10.28.00.20.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:20:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH 5/5] power: supply: sc27xx: Calibrate the resistance of coulomb counter
Date:   Mon, 28 Oct 2019 15:19:01 +0800
Message-Id: <9c25e3ab9bdba2914b22cfe7495818740437ef27.1572245011.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
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
index 221b6fb..f363fa7 100644
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
+				       "sprd,calib-resistance",
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

