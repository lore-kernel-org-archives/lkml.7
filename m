Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F8E217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBZgZ7FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCLWEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:04:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:04:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so2863199pgr.3;
        Tue, 12 Mar 2019 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WQ5nF0qwMvjgFIS1ccYGUaQPeQt3uTtxoXOOHA4yMnY=;
        b=mBZgZ7FCd1dykAADtbXvYewv8sFBU3+KEcOx28Z2NIrbARoj9gktrfaTTJAQdNubB6
         wkUhjXrLhmoigu/TGfKZQqk6Dc4nHkZe2TMPzl5mB/yQowdbB9RAKCONELCQXgCB9bLn
         f0BO92aCIWi7R2Ol23FI+yTlAI71E2fcliYnQGw92uyvUxnqmLnrXPeiYV8bnx9hQ9ps
         Qa2oP/CA64t9pEORmMoUJESmz0uAY9JVRNT//WlIG9Iz1yTbCQ3iqV2jxImwvif8sOUu
         l30oYUWI6opQxXoo35eFZ0FMG4NUGIDZTPJuEPsGPguPfK4eme1y/guMq0dF+b66qb+i
         OGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WQ5nF0qwMvjgFIS1ccYGUaQPeQt3uTtxoXOOHA4yMnY=;
        b=CvrYbG8MK9V94JQZxqrr50RwDkF59wiwf5A2uq3qcfi7AQC7z7iN2mKhS2wl3Swyd6
         Lggvhogp1Kg+LgmB0FI+qKT4HG2mzfWUratC4/pnWdigWmHZfvxwEcZJF0V2hNmSC6me
         BJZjjMfU45UV/DbN1Jxr1dhCzLGUtp8OiUY+fHagMP2UWGoQlbjRMIZ/B2rkuEDoOWfz
         wt1e+EJS2eTXxR5NMo1mXaJsF79udBRgCvRcsMrkMh/OZ1KRz7v1kUswyZeLKR1Yjwkq
         Uj8/Matxj9z5Sd2uAU3koLIDeOT9JtMR+zU7tzPMeuOYBR8aebmDi4K2YLXc+QNPiHLw
         L9Jw==
X-Gm-Message-State: APjAAAVNXrj32w7x7bFGhYZwiSNiWISRX2XsWd5SBXrq0fICXQJniBb3
        efahloc71xa6rBIj0XzjPbMe3zyc
X-Google-Smtp-Source: APXvYqzyB73CTbQFNeqAbSW8dcSPTScrepj8DhduoY1NMyfpeycNBDRT70uyx/bbmKeUIjbt9t16Nw==
X-Received: by 2002:a17:902:4081:: with SMTP id c1mr42312130pld.297.1552428280378;
        Tue, 12 Mar 2019 15:04:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z67sm25279323pfi.152.2019.03.12.15.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 15:04:39 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] hwmon: (ina3221) Add averaging mode support
Date:   Tue, 12 Mar 2019 15:04:31 -0700
Message-Id: <20190312220431.26710-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG register has a 3-bit averaging mode field for users
to setup the number of samples that are collected and averaged
together. This is very useful to filter noise from sensor data.

This patch adds an 'average' sysfs node, and updates wait time
calculation by taking this average value into account.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/ina3221 |  2 ++
 drivers/hwmon/ina3221.c     | 61 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 4b82cbfb551c..1e25be009d24 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -35,3 +35,5 @@ curr[123]_max           Warning alert current(mA) setting, activates the
                           average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+average                 Averaging mode. Supports the list of number of samples:
+                          1, 4, 16, 64, 128, 256, 512, 1024
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 3626b87a5fd2..259c192427ac 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -51,6 +51,9 @@
 #define INA3221_CONFIG_VBUS_CT_SHIFT	6
 #define INA3221_CONFIG_VBUS_CT_MASK	GENMASK(8, 6)
 #define INA3221_CONFIG_VBUS_CT(x)	(((x) & GENMASK(8, 6)) >> 6)
+#define INA3221_CONFIG_AVG_SHIFT	9
+#define INA3221_CONFIG_AVG_MASK		GENMASK(11, 9)
+#define INA3221_CONFIG_AVG(x)		(((x) & GENMASK(11, 9)) >> 9)
 #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
@@ -135,17 +138,24 @@ static const u16 ina3221_conv_time[] = {
 	140, 204, 332, 588, 1100, 2116, 4156, 8244,
 };
 
+/* Lookup table for averaging rates */
+static const int ina3221_avg[] = {
+	1, 4, 16, 64, 128, 256, 512, 1024,
+};
+
 static inline int ina3221_wait_for_data(struct ina3221_data *ina)
 {
 	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
 	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
 	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
+	u32 avg_idx = INA3221_CONFIG_AVG(ina->reg_config);
 	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
 	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
+	u32 avg = ina3221_avg[avg_idx];
 	u32 wait, cvrf;
 
 	/* Calculate total conversion time */
-	wait = channels * (vbus_ct + vsh_ct);
+	wait = channels * (vbus_ct + vsh_ct) * avg;
 
 	/* Polling the CVRF bit to make sure read data is ready */
 	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
@@ -545,15 +555,64 @@ static ssize_t ina3221_shunt_store(struct device *dev,
 	return count;
 }
 
+static ssize_t ina3221_avg_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	u32 avg_idx = INA3221_CONFIG_AVG(ina->reg_config);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", ina3221_avg[avg_idx]);
+}
+
+static ssize_t ina3221_avg_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	int ret, avg, i;
+
+	ret = kstrtoint(buf, 0, &avg);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(ina3221_avg); i++)
+		if (ina3221_avg[i] == avg)
+			break;
+
+	if (i == ARRAY_SIZE(ina3221_avg))
+		return -EINVAL;
+
+	mutex_lock(&ina->lock);
+
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+				 INA3221_CONFIG_AVG_MASK,
+				 i << INA3221_CONFIG_AVG_SHIFT);
+	if (ret)
+		goto unlock;
+
+	/* Update reg_config accordingly */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		goto unlock;
+
+unlock:
+	mutex_unlock(&ina->lock);
+
+	return ret ? ret : count;
+}
+
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR_RW(shunt1_resistor, ina3221_shunt, INA3221_CHANNEL1);
 static SENSOR_DEVICE_ATTR_RW(shunt2_resistor, ina3221_shunt, INA3221_CHANNEL2);
 static SENSOR_DEVICE_ATTR_RW(shunt3_resistor, ina3221_shunt, INA3221_CHANNEL3);
+/* averaging mode */
+static SENSOR_DEVICE_ATTR_RW(average, ina3221_avg, 0);
 
 static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
+	&sensor_dev_attr_average.dev_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(ina3221);
-- 
2.17.1

