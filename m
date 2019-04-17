Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91324C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5719C2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnMN9/ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfDQXMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:12:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45523 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbfDQXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:12:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so190269plb.12;
        Wed, 17 Apr 2019 16:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y+si/MwOKEK0HuIzKih+4rSRin1ig09f5uIFhtRPou8=;
        b=XnMN9/mlwHXPPXll3q9OYTaKvlf/CdU32wRFYpLX+J0VQ32FQHFZZie5H1X7/g1WH9
         DiCOmHAKggwieAORSJMkqQjicmyktuN/jvXBnu1phpN8LSAZWz9kQdwnOkr290BpdBCL
         KRXFFTlbc2Z87a83sPr+EJ7BPqYS7NUwETJyC4b/+CsVuSHedQNFw6ToPO6ULxEFvpY4
         p42HDccVu+tuuI/xnUWv4UzTVk/gR0cx5kkNjfzC4VWnfg074SrgtdjkVXhv+7YWg3cQ
         wbv9YblegJ6LH14dOMZdF4xkF2/v7gB2ZOVuLHLsKTkPLhGx8xkPgLpkLgCDD+SMK8Tg
         keUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y+si/MwOKEK0HuIzKih+4rSRin1ig09f5uIFhtRPou8=;
        b=bKOOAAJ25gNQNSKlADlYIYnCQsiQFcBcOL59NBTO7rHMlNn6RyLL504bIj4+DSm2L1
         NDHemdJTjM0C31wB60MLoXhW2WgmxLb8nVkZYBLGHC3TXjHNBUJbEqRN7AuMN6OUHZXU
         liFYpmcFjS9Jz/vJFeirqQOqSgfh65X0COz5yk57SONibpt8ZKwTFP6to+432OPnlmYa
         hpOTSZLO7aH15OIosgS7EhLNiGnihZu3el2WP4APVyDuK+lSZjvj7v+fgITOJbsRu9Fq
         TSB2T2ZdRFg/uzb2IkGDDoMGtcDyHOaF8lBPlELxhXYfsB9nIeot9DJEY+mVcKngy38d
         08UQ==
X-Gm-Message-State: APjAAAW8CnNlb5AFHATfbWEX1k/EY2HzM7COxV0566KHWClQf9u0ASx9
        tGsZGEIRTPWKTWgVXDHMSnc=
X-Google-Smtp-Source: APXvYqyScexx133Eb1XYbNIeAfMJgD7wEUjrrDt1PBfl9KN0P8GQ3rUPhzfNaP/tQhM99EJlE1Sv/A==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12mr42256086plb.192.1555542747997;
        Wed, 17 Apr 2019 16:12:27 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j62sm370466pfg.6.2019.04.17.16.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:12:27 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (ina3221) Add voltage conversion time settings
Date:   Wed, 17 Apr 2019 16:12:10 -0700
Message-Id: <20190417231210.5762-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417231210.5762-1-nicoleotsuka@gmail.com>
References: <20190417231210.5762-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG register has two 3-bit fields for conversion time
settings of Bus-voltage and Shunt-voltage, respectively. The
conversion settings, along with averaging mode, allow users
to optimize available timing requirement.

This patch adds an 'update_interval' sysfs node through the
hwmon_chip_info of hwmon core. It reflects a total hardware
conversion time:
    samples * channels * (Bus + Shunt conversion times)

Though INA3221 supports different conversion time setups for
Bus and Shunt voltages, this patch only adds the support of
a unified setting for both conversion times, by dividing the
conversion time into two equal values.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Merged two adjacent calls of regmap_update_bits().
 * Replaced CONFIG register read-back with tmp variable

 Documentation/hwmon/ina3221 |  9 ++++++
 drivers/hwmon/ina3221.c     | 58 ++++++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index ed3f22769d4b..3b05170112f0 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -38,3 +38,12 @@ in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
 samples                 Number of samples using in the averaging mode.
                           Supports the list of number of samples:
                           1, 4, 16, 64, 128, 256, 512, 1024
+update_interval         Data conversion time in millisecond, following:
+                          update_interval = C x S x (BC + SC)
+                              C: number of enabled channels
+                              S: number of samples
+                             BC: bus-voltage conversion time in millisecond
+                             SC: shunt-voltage conversion time in millisecond
+                          Affects both Bus- and Shunt-voltage conversion time.
+                          Note that setting update_interval to 0ms sets both BC
+                          and SC to 140 us (minimum conversion time).
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 62040aac653c..e0637fed9585 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -144,19 +144,37 @@ static const int ina3221_avg_samples[] = {
 	1, 4, 16, 64, 128, 256, 512, 1024,
 };
 
-static inline int ina3221_wait_for_data(struct ina3221_data *ina)
+/* Converting update_interval in msec to conversion time in usec */
+static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
+{
+	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
+	u32 samples_idx = INA3221_CONFIG_AVG(config);
+	u32 samples = ina3221_avg_samples[samples_idx];
+
+	/* Bisect the result to Bus and Shunt conversion times */
+	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
+}
+
+/* Converting CONFIG register value to update_interval in usec */
+static inline u32 ina3221_reg_to_interval_us(u16 config)
 {
-	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
-	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
-	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
-	u32 samples_idx = INA3221_CONFIG_AVG(ina->reg_config);
+	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
+	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(config);
+	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(config);
+	u32 samples_idx = INA3221_CONFIG_AVG(config);
 	u32 samples = ina3221_avg_samples[samples_idx];
 	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
 	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
-	u32 wait, cvrf;
 
 	/* Calculate total conversion time */
-	wait = channels * (vbus_ct + vsh_ct) * samples;
+	return channels * (vbus_ct + vsh_ct) * samples;
+}
+
+static inline int ina3221_wait_for_data(struct ina3221_data *ina)
+{
+	u32 wait, cvrf;
+
+	wait = ina3221_reg_to_interval_us(ina->reg_config);
 
 	/* Polling the CVRF bit to make sure read data is ready */
 	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
@@ -197,6 +215,11 @@ static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
 		regval = INA3221_CONFIG_AVG(ina->reg_config);
 		*val = ina3221_avg_samples[regval];
 		return 0;
+	case hwmon_chip_update_interval:
+		/* Return in msec */
+		*val = ina3221_reg_to_interval_us(ina->reg_config);
+		*val = DIV_ROUND_CLOSEST(*val, 1000);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -322,6 +345,23 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 		if (ret)
 			return ret;
 
+		/* Update reg_config accordingly */
+		ina->reg_config = tmp;
+		return 0;
+	case hwmon_chip_update_interval:
+		tmp = ina3221_interval_ms_to_conv_time(ina->reg_config, val);
+		idx = find_closest(tmp, ina3221_conv_time,
+				   ARRAY_SIZE(ina3221_conv_time));
+
+		/* Update Bus and Shunt voltage conversion times */
+		tmp = INA3221_CONFIG_VBUS_CT_MASK | INA3221_CONFIG_VSH_CT_MASK;
+		tmp = (ina->reg_config & ~tmp) |
+		      (idx << INA3221_CONFIG_VBUS_CT_SHIFT) |
+		      (idx << INA3221_CONFIG_VSH_CT_SHIFT);
+		ret = regmap_write(ina->regmap, INA3221_CONFIG, tmp);
+		if (ret)
+			return ret;
+
 		/* Update reg_config accordingly */
 		ina->reg_config = tmp;
 		return 0;
@@ -483,6 +523,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
 	case hwmon_chip:
 		switch (attr) {
 		case hwmon_chip_samples:
+		case hwmon_chip_update_interval:
 			return 0644;
 		default:
 			return 0;
@@ -528,7 +569,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
 
 static const struct hwmon_channel_info *ina3221_info[] = {
 	HWMON_CHANNEL_INFO(chip,
-			   HWMON_C_SAMPLES),
+			   HWMON_C_SAMPLES,
+			   HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(in,
 			   /* 0: dummy, skipped in is_visible */
 			   HWMON_I_INPUT,
-- 
2.17.1

