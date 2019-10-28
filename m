Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CC1CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A2222D0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7ANTgpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfJ1HUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:20:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36769 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbfJ1HUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:20:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id j22so275618pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ipn4aXAOp87D2v3r9KdhlrkAx9KnL+jbYVkv6tX05Nc=;
        b=H7ANTgpgwQ2+56L1vk0+gI3rNxCVOKam39g5rW/rxFArWeEN7xShdeud1+d5tj9sYT
         zIQeHuJdV1Lrm6P/tHiq/LJK/fJmt6fMPFh4FcD0bMWcXf1HVdxlg5m7eSqz+oW7EB2o
         HaJBqfCN2qoz0tVbDYTRIEa+2kA2Lq/Qkidt+66llOixVDJ8k3YK3NVMYE4CJFAyjuFq
         icvCAHsQbWSsbgrczubJZTzyDXX5YRAM2GtS5FH7mxhDU/vSdQAbmz8Zy8gKhAP9W71m
         xVIfVf2rJsZgtJsnFsVAQHRy4M9ThVbBpi9/JPuSPrNWQJLqTZ9DIH+1BPmKuydMRADC
         SVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ipn4aXAOp87D2v3r9KdhlrkAx9KnL+jbYVkv6tX05Nc=;
        b=QB1PcterR2JSstddDtn4zW4Y0CNZpk0cO6c1Q1eJRtls31dZNdBL1FiN5yMxPAO01+
         Yzj1gUniE5mhlrzhbuw8ACtryJmg7GwFfxNnqSGN9jhl4kza/9iia5JwvYwF/1J6M8bp
         6CSrogWpKeXScygzYk0cQVeaw4p/pDFy3zAenbgNRrceJb0p5VYXGotTnirQ3Q5Ql2y6
         caTHxi9l081CtmUhDhGe4UKPUQqaYqdlCHSr59v83KPd6H1lJASm64HtdRSxPeLmrqL3
         hSCQR55Qw8cGvl89OVugt/Qe0mCqB9S+K4lj0+AOMRhWezI60YCNkr47/dfTd+Q144je
         +jmA==
X-Gm-Message-State: APjAAAU3eulfUV5HT5SEqkR9E8Uq6F95mPsonIfwqZ6q8qVzydc2dsad
        BRwVJcAUqYg20cICCyVES3VGZA==
X-Google-Smtp-Source: APXvYqwhfpmk1l+DF5Y1sQ12XRinFJFSNZF3ttAyMH6+2ZcV2cfOiRJp48ZX1gTKmZUnmk+OgQ2Yaw==
X-Received: by 2002:a63:ff54:: with SMTP id s20mr18562592pgk.398.1572247202088;
        Mon, 28 Oct 2019 00:20:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 13sm11504703pgq.72.2019.10.28.00.19.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:20:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH 3/5] power: supply: sc27xx: Optimize the battery resistance with measuring temperature
Date:   Mon, 28 Oct 2019 15:18:59 +0800
Message-Id: <ebd283542884e08e5a7f7b06e8d51ec47896743e.1572245011.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Optimize the battery internal resistance in a certain temerature to
get a accurate battery internal resistance.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   32 ++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index bc8f5bd..221b6fb 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -81,9 +81,11 @@
  * @max_volt: the maximum constant input voltage in millivolt
  * @min_volt: the minimum drained battery voltage in microvolt
  * @table_len: the capacity table length
+ * @resist_table_len: the resistance table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
  * @vol_1000mv_adc: ADC value corresponding to 1000 mV
  * @cap_table: capacity table with corresponding ocv
+ * @resist_table: resistance percent table with corresponding temperature
  */
 struct sc27xx_fgu_data {
 	struct regmap *regmap;
@@ -103,15 +105,18 @@ struct sc27xx_fgu_data {
 	int max_volt;
 	int min_volt;
 	int table_len;
+	int resist_table_len;
 	int cur_1000ma_adc;
 	int vol_1000mv_adc;
 	struct power_supply_battery_ocv_table *cap_table;
+	struct power_supply_resistance_temp_table *resist_table;
 };
 
 static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity);
 static void sc27xx_fgu_capacity_calibration(struct sc27xx_fgu_data *data,
 					    int cap, bool int_mode);
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap);
+static int sc27xx_fgu_get_temp(struct sc27xx_fgu_data *data, int *temp);
 
 static const char * const sc27xx_charger_supply_name[] = {
 	"sc2731_charger",
@@ -434,7 +439,7 @@ static int sc27xx_fgu_get_current(struct sc27xx_fgu_data *data, int *val)
 
 static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 {
-	int vol, cur, ret;
+	int vol, cur, ret, temp, resistance;
 
 	ret = sc27xx_fgu_get_vbat_vol(data, &vol);
 	if (ret)
@@ -444,8 +449,19 @@ static int sc27xx_fgu_get_vbat_ocv(struct sc27xx_fgu_data *data, int *val)
 	if (ret)
 		return ret;
 
+	resistance = data->internal_resist;
+	if (data->resist_table_len > 0) {
+		ret = sc27xx_fgu_get_temp(data, &temp);
+		if (ret)
+			return ret;
+
+		resistance = power_supply_temp2resist_simple(data->resist_table,
+						data->resist_table_len, temp);
+		resistance = data->internal_resist * resistance / 100;
+	}
+
 	/* Return the battery OCV in micro volts. */
-	*val = vol * 1000 - cur * data->internal_resist;
+	*val = vol * 1000 - cur * resistance;
 
 	return 0;
 }
@@ -929,6 +945,18 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!data->alarm_cap)
 		data->alarm_cap += 1;
 
+	data->resist_table_len = info.resist_table_size;
+	if (data->resist_table_len > 0) {
+		data->resist_table = devm_kmemdup(data->dev, info.resist_table,
+						  data->resist_table_len *
+						  sizeof(struct power_supply_resistance_temp_table),
+						  GFP_KERNEL);
+		if (!data->resist_table) {
+			power_supply_put_battery_info(data->battery, &info);
+			return -ENOMEM;
+		}
+	}
+
 	power_supply_put_battery_info(data->battery, &info);
 
 	ret = sc27xx_fgu_calibration(data);
-- 
1.7.9.5

