Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF87C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760DA21850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD7mWxNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfDQXM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:12:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35939 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbfDQXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:12:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so208928plb.3;
        Wed, 17 Apr 2019 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4aPw5Ss1ULiiPwjXbGqyBm8NkCH5TS8p9B/SjrFm/tc=;
        b=bD7mWxNhbAn/1gQdmwUYYyeFLkNwqtRAzw4mEEPmEVQtQMNeit5skiwx3AqSmMXzxy
         NdB9CWyvqJlFz9CWnZS/9kWaXr8VM83P3OXdHivNdomyaGfqSkC4YdKWXu2nAcjMLXCx
         kcQ/sSKQuZH549IZoCJ6sFJvcqLgynkbhphSnBfQvPJ8umi5GCDG8kpeLbkIw6meMhlH
         9IF189wFqOHCrpvqlWjUuF3/MhI984c8EPK4X+B0fu9hrboOP3a2jfUCtE9xRtTsf4Wn
         wrwOxRpu2d14emWjM2CNmGViTZpSUIi+JK+68kZoXEvoYgInj9sYmZkHFCxgSU73//tz
         rqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4aPw5Ss1ULiiPwjXbGqyBm8NkCH5TS8p9B/SjrFm/tc=;
        b=UkhtjZY20IZGCaBs6czQlKaLmXBcLQibHOMwxNYQl1e6ez8bcdfUSUtfMWCuAz0quV
         goLVyG+3Ohcq8S19C3Zq+ccDiE1nrTf4sKSpuQr5/icyU7maO7FyuGQSjK/Fl3L++SWl
         ig00NADUwIGT8KKXaTi3AzQN7ec1LSFyfDkqa0f9bXsssNllYvDlxngL3Am9SXWN11NW
         yj0nljMaB93CZx6sUTAI5M+Ch/sIf5yHoDfR/h0sjNu4gFcuZ59UWZ6HMHJt6saTHjiK
         MqQGmQUimiSKy7I2x6tV5w04PqJwvK5c861OJpl9gbCrL2zv8M9kcdU8I+nHIj1oa2oq
         9VQQ==
X-Gm-Message-State: APjAAAVa6ZYW5fttrak2SFtSiqnQIfU85YfuJkCulNgRM9HlYo7/7MeA
        cnomfjSe2JdiCsD4oJIxfLs=
X-Google-Smtp-Source: APXvYqxZPm+TY9Wyh1rUUZlaEYngHs0ll6TtnuoxHCHvU5uFPlCcMX+UwmqidOU2xAQqfFJliRtrpA==
X-Received: by 2002:a17:902:2907:: with SMTP id g7mr55472975plb.238.1555542746891;
        Wed, 17 Apr 2019 16:12:26 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j62sm370466pfg.6.2019.04.17.16.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:12:26 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (ina3221) Do not read-back to cache reg_config
Date:   Wed, 17 Apr 2019 16:12:09 -0700
Message-Id: <20190417231210.5762-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417231210.5762-1-nicoleotsuka@gmail.com>
References: <20190417231210.5762-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading back the CONFIG register increases an extra I2C
transaction. This's not necessary and could be replaced
with a local variable caching the register settings.

So this patch replaces two readback regmap_read() calls
with a tmp variable.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/ina3221.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 74d39d212931..62040aac653c 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -309,21 +309,22 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	int ret, idx;
+	u32 tmp;
 
 	switch (attr) {
 	case hwmon_chip_samples:
 		idx = find_closest(val, ina3221_avg_samples,
 				   ARRAY_SIZE(ina3221_avg_samples));
 
-		ret = regmap_update_bits(ina->regmap, INA3221_CONFIG,
-					 INA3221_CONFIG_AVG_MASK,
-					 idx << INA3221_CONFIG_AVG_SHIFT);
+		tmp = (ina->reg_config & ~INA3221_CONFIG_AVG_MASK) |
+		      (idx << INA3221_CONFIG_AVG_SHIFT);
+		ret = regmap_write(ina->regmap, INA3221_CONFIG, tmp);
 		if (ret)
 			return ret;
 
 		/* Update reg_config accordingly */
-		return regmap_read(ina->regmap, INA3221_CONFIG,
-				   &ina->reg_config);
+		ina->reg_config = tmp;
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -359,6 +360,7 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
 	u16 config_old = ina->reg_config & mask;
+	u32 tmp;
 	int ret;
 
 	config = enable ? mask : 0;
@@ -377,14 +379,13 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 	}
 
 	/* Enable or disable the channel */
-	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
+	tmp = (ina->reg_config & ~mask) | (config & mask);
+	ret = regmap_write(ina->regmap, INA3221_CONFIG, tmp);
 	if (ret)
 		goto fail;
 
 	/* Cache the latest config register value */
-	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
-	if (ret)
-		goto fail;
+	ina->reg_config = tmp;
 
 	/* For disabling routine, decrease refcount or suspend() at last */
 	if (!enable)
-- 
2.17.1

