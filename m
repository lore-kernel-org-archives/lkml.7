Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTnc3xxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfDPTli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:41:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45944 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfDPTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:41:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so10821392plb.12;
        Tue, 16 Apr 2019 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kPsNBNGRZIREHuLkWl5OQs57K/lLEwg+3DT+aodwTVw=;
        b=lTnc3xxLX6TghNRPbG9dqrGDIS//VJConEojYRafTjk2lJcOzT+uEs3phcmni3Izqu
         7ANikKLkLIMp5mTOEGjhcN2J27bnGXK5VjBHpd/IcnRWs9d/WuQM9heZlkICKcPBsFry
         g/qtz2qZY2UfCdSwDHs4XYlMRbFpLMEbEgHqRslfwcwOh6xUJH7yjdziKRGlLl8+acyQ
         cKeIVYQu+JXLCYVqW7b4Txlckn37qvcb6Qau6N1bcGurypC6diPZ38aVh6osSyEb1QTo
         8H5TJol/H/g3vOSHqRRN2Crbq49MlC3CCEagsDtTChnWsvFjrugV3c9CdRGv+hPeD+NH
         PFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPsNBNGRZIREHuLkWl5OQs57K/lLEwg+3DT+aodwTVw=;
        b=A7FHY/BEInNvT/4LQGTNtvSKyH/PyRE+tgwK9qb6OX36sPZW4nZTTuO3EhchrWEDLC
         36R/J1Z0pZIVi2z9DWjJeO+AmKFHiNkPUiso7PrIKQalo/q2BYJmIfUKq1Adm/WSDr8h
         pUiEbN70Znrkfg96/10fGBj18Ai5p+BRMfB7Re0ZSFFHRsBMzcLZqBtn3A1kpA9HYiGw
         Zuwtqk5N+xEDwXYKY5gXG1+o9kRKbQl1kUmbvdVjxeeQEju/Lrvs00vOTIxBhlbcoX/H
         /qyTgTcJGYhDPshgx6p5HY3szpCREflkj551yqRVDf4MKW376Jy3C750GoLicBKXPaK/
         6brg==
X-Gm-Message-State: APjAAAWuJvm2w//MmctZULt+PkaetsP+jRxXMDpgbjIOR0jBCpgqv+Ep
        hoPnzuPPs171mBkd3zu0Z04=
X-Google-Smtp-Source: APXvYqyGLUsF0GRTqPUm3jbRkMNhxsFYDJeGCEwr+SZn/wFwM5rPnQIA3Vr9lxsdC3wdNm+h1YW7Bw==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr84322919plo.0.1555443696701;
        Tue, 16 Apr 2019 12:41:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f5sm55346249pgo.75.2019.04.16.12.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:41:36 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH v2] hwmon: (ina3221) Add averaging mode support
Date:   Tue, 16 Apr 2019 12:41:31 -0700
Message-Id: <20190416194131.29560-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG register has a 3-bit averaging mode field for users
to setup the number of samples that are collected and averaged
together. This is very useful to filter noise from sensor data.

This patch adds a 'samples' sysfs node using hwmon_chip_samples
of hwmon core, and updates wait time calculation by taking this
samples value into account.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Implemented "samples" through hwmon_chip_info
 * Used find_closest()

 Documentation/hwmon/ina3221 |  3 ++
 drivers/hwmon/ina3221.c     | 67 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 4b82cbfb551c..ed3f22769d4b 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -35,3 +35,6 @@ curr[123]_max           Warning alert current(mA) setting, activates the
                           average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+samples                 Number of samples using in the averaging mode.
+                          Supports the list of number of samples:
+                          1, 4, 16, 64, 128, 256, 512, 1024
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e6f43df0435c..74d39d212931 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/util_macros.h>
 
 #define INA3221_DRIVER_NAME		"ina3221"
 
@@ -51,6 +52,9 @@
 #define INA3221_CONFIG_VBUS_CT_SHIFT	6
 #define INA3221_CONFIG_VBUS_CT_MASK	GENMASK(8, 6)
 #define INA3221_CONFIG_VBUS_CT(x)	(((x) & GENMASK(8, 6)) >> 6)
+#define INA3221_CONFIG_AVG_SHIFT	9
+#define INA3221_CONFIG_AVG_MASK		GENMASK(11, 9)
+#define INA3221_CONFIG_AVG(x)		(((x) & GENMASK(11, 9)) >> 9)
 #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
@@ -135,17 +139,24 @@ static const u16 ina3221_conv_time[] = {
 	140, 204, 332, 588, 1100, 2116, 4156, 8244,
 };
 
+/* Lookup table for number of samples using in averaging mode */
+static const int ina3221_avg_samples[] = {
+	1, 4, 16, 64, 128, 256, 512, 1024,
+};
+
 static inline int ina3221_wait_for_data(struct ina3221_data *ina)
 {
 	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
 	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
 	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
+	u32 samples_idx = INA3221_CONFIG_AVG(ina->reg_config);
+	u32 samples = ina3221_avg_samples[samples_idx];
 	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
 	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
 	u32 wait, cvrf;
 
 	/* Calculate total conversion time */
-	wait = channels * (vbus_ct + vsh_ct);
+	wait = channels * (vbus_ct + vsh_ct) * samples;
 
 	/* Polling the CVRF bit to make sure read data is ready */
 	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
@@ -176,6 +187,21 @@ static const u8 ina3221_in_reg[] = {
 	INA3221_SHUNT3,
 };
 
+static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int regval;
+
+	switch (attr) {
+	case hwmon_chip_samples:
+		regval = INA3221_CONFIG_AVG(ina->reg_config);
+		*val = ina3221_avg_samples[regval];
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 {
 	const bool is_shunt = channel > INA3221_CHANNEL3;
@@ -279,6 +305,30 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	}
 }
 
+static int ina3221_write_chip(struct device *dev, u32 attr, long val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret, idx;
+
+	switch (attr) {
+	case hwmon_chip_samples:
+		idx = find_closest(val, ina3221_avg_samples,
+				   ARRAY_SIZE(ina3221_avg_samples));
+
+		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+					 INA3221_CONFIG_AVG_MASK,
+					 idx << INA3221_CONFIG_AVG_SHIFT);
+		if (ret)
+			return ret;
+
+		/* Update reg_config accordingly */
+		return regmap_read(ina->regmap, INA3221_CONFIG,
+				   &ina->reg_config);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int ina3221_write_curr(struct device *dev, u32 attr,
 			      int channel, long val)
 {
@@ -361,6 +411,9 @@ static int ina3221_read(struct device *dev, enum hwmon_sensor_types type,
 	mutex_lock(&ina->lock);
 
 	switch (type) {
+	case hwmon_chip:
+		ret = ina3221_read_chip(dev, attr, val);
+		break;
 	case hwmon_in:
 		/* 0-align channel ID */
 		ret = ina3221_read_in(dev, attr, channel - 1, val);
@@ -387,6 +440,9 @@ static int ina3221_write(struct device *dev, enum hwmon_sensor_types type,
 	mutex_lock(&ina->lock);
 
 	switch (type) {
+	case hwmon_chip:
+		ret = ina3221_write_chip(dev, attr, val);
+		break;
 	case hwmon_in:
 		/* 0-align channel ID */
 		ret = ina3221_write_enable(dev, channel - 1, val);
@@ -423,6 +479,13 @@ static umode_t ina3221_is_visible(const void *drvdata,
 	const struct ina3221_input *input = NULL;
 
 	switch (type) {
+	case hwmon_chip:
+		switch (attr) {
+		case hwmon_chip_samples:
+			return 0644;
+		default:
+			return 0;
+		}
 	case hwmon_in:
 		/* Ignore in0_ */
 		if (channel == 0)
@@ -463,6 +526,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
 				   HWMON_C_MAX | HWMON_C_MAX_ALARM)
 
 static const struct hwmon_channel_info *ina3221_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_SAMPLES),
 	HWMON_CHANNEL_INFO(in,
 			   /* 0: dummy, skipped in is_visible */
 			   HWMON_I_INPUT,
-- 
2.17.1

