Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303D2176F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToRDYw92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfDPXzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:55:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40360 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:55:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so11179963pfc.7;
        Tue, 16 Apr 2019 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FafW789Qixf3yGtjX5GjHHsOmeQ6Y/2e1HgsZOq4wds=;
        b=ToRDYw92LOiX7Y8fCJUIot+WXPgzF3Ff1CGpJBw2p7L9/msgPJta3k/UN2JQHUjfiz
         hU0iorlPWybFbbsjwFdb49ztRxMLFbZnrhRkNG5MV8uAz+c2/hn7Xc2mmlxZM2Beonwn
         m8MlNB1ZW8S/2sE5J8Xfy3nssXdhV/H/j/0erZv0SuX5oXXt3LSYi2XqnoV0qNIJZbLC
         norupoHihTJTxgE8sO7VMRkLEuINrMKe/s7AnAoY2/ZMyfeKHcgZfkyj1RhaB+c0RgbV
         k/D/rKN+86hq7fDt7YhgnH69jlKj1xGyOTMniJk4i+u2zm1NgtV3uu0aU46lpN8em0MX
         S7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FafW789Qixf3yGtjX5GjHHsOmeQ6Y/2e1HgsZOq4wds=;
        b=tEoEr8RfPZyFPSBHtTAPy3KIpX2ny127xncQp/6qDvn+DyHNPFzr5oJ04pin58aX0D
         XAQRrinLS7p2++qGPdHbKjfblkXtj8w8TLgBWnXeabacO6abcHc0WMoPaKZOPygvzK8j
         P+8imE3on550fFQkVUhBiAd6Me84KUo5rBoFXGfsX1Z+kDACkp5w/t6g4FUUNtvBkD75
         dHnngtwDjb6MsLTLLkYrJfNAzVzjW6zva0YYxaLmUHvO8ewFp2mMtLzzw9CttSnGbuNZ
         tLB7l0N3FLzlN31pVnkn9wSo/vCN6NfbXEXkNC90Pnal65QE34EaalGMIptN5cq5Pr18
         b37w==
X-Gm-Message-State: APjAAAVdnyr4IKjtKgQ1+M0wMilX8ZfnKXXHgzRA9KI4Ec3+M8z4TaAp
        axggzzvwgev/ajC46816PyggOg/XFB8=
X-Google-Smtp-Source: APXvYqxxrzGmQVq/OZOqWFQanb9ZR9cWaXxyosNTSwRrBbwlIpcDPFs93OvIkATwposc3a3QOBnbKA==
X-Received: by 2002:aa7:9888:: with SMTP id r8mr31861750pfl.116.1555458953955;
        Tue, 16 Apr 2019 16:55:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 71sm120384429pfs.36.2019.04.16.16.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:55:53 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] hwmon: (ina3221) Add voltage conversion time settings
Date:   Tue, 16 Apr 2019 16:55:48 -0700
Message-Id: <20190416235548.22733-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Hi Guenter,

I am not quite sure if this update_interval is the best way to
implement the conversion time settings but I can't find another
common approach. This implementation certainly has drawbacks:
 1) It can't configure Bus and Shunt conversion times separately
    (Not crucial for me at this point as I set them equally)
 2) Users need to calculate for the settings of conversion time
 3) The ABI defines update_interval in msec while the hardware
    and datasheet does in usec, and that generates rounding diff
 4) The update_interval value would be spontaneously modified
    everytime number of samples or number of enabled channels
    gets changed. This might confuses users who tries to have
    a fixed update_interval other than really merely setting
    conversion time.

I see IIO subsystem have something like IIO_CHAN_INFO_INT_TIME
for conversion time setting exclusively. Do we have something
similar under hwmon?

Thanks

 Documentation/hwmon/ina3221 |  9 +++++
 drivers/hwmon/ina3221.c     | 65 ++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 9 deletions(-)

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
index 74d39d212931..af4ab8ddddce 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -144,19 +144,37 @@ static const int ina3221_avg_samples[] = {
 	1, 4, 16, 64, 128, 256, 512, 1024,
 };
 
-static inline int ina3221_wait_for_data(struct ina3221_data *ina)
+/* Converting update_interval in msec to conversion time in usec */
+static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
 {
-	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
-	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
-	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
-	u32 samples_idx = INA3221_CONFIG_AVG(ina->reg_config);
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
+{
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
@@ -308,7 +331,7 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
-	int ret, idx;
+	int ret, idx, tmp;
 
 	switch (attr) {
 	case hwmon_chip_samples:
@@ -321,6 +344,28 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 		if (ret)
 			return ret;
 
+		/* Update reg_config accordingly */
+		return regmap_read(ina->regmap, INA3221_CONFIG,
+				   &ina->reg_config);
+	case hwmon_chip_update_interval:
+		tmp = ina3221_interval_ms_to_conv_time(ina->reg_config, val);
+		idx = find_closest(tmp, ina3221_conv_time,
+				   ARRAY_SIZE(ina3221_conv_time));
+
+		/* Update Bus-voltage conversion time */
+		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+					 INA3221_CONFIG_VBUS_CT_MASK,
+					 idx << INA3221_CONFIG_VBUS_CT_SHIFT);
+		if (ret)
+			return ret;
+
+		/* Update Shunt-voltage conversion time */
+		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
+					 INA3221_CONFIG_VSH_CT_MASK,
+					 idx << INA3221_CONFIG_VSH_CT_SHIFT);
+		if (ret)
+			return ret;
+
 		/* Update reg_config accordingly */
 		return regmap_read(ina->regmap, INA3221_CONFIG,
 				   &ina->reg_config);
@@ -482,6 +527,7 @@ static umode_t ina3221_is_visible(const void *drvdata,
 	case hwmon_chip:
 		switch (attr) {
 		case hwmon_chip_samples:
+		case hwmon_chip_update_interval:
 			return 0644;
 		default:
 			return 0;
@@ -527,7 +573,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
 
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

