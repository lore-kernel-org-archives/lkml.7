Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B656C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEC4218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfHHIDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:03:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43392 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbfHHIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:02:57 -0400
Received: from [167.98.27.226] (helo=ct-lt-765.unassigned)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hvdNp-0008KE-Tm; Thu, 08 Aug 2019 09:02:50 +0100
Received: from ikerpalomar by ct-lt-765.unassigned with local (Exim 4.89)
        (envelope-from <ikerpalomar@ct-lt-765.unassigned>)
        id 1hvdNp-0002Bq-5E; Thu, 08 Aug 2019 09:02:49 +0100
From:   Iker Perez <iker.perez@codethink.co.uk>
To:     linux-hwmon@vger.kernel.org, linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>
Subject: [PATCH v2 4/4] hwmon: (lm75) Modularize lm75_write and make hwmon_chip writable
Date:   Thu,  8 Aug 2019 09:02:46 +0100
Message-Id: <20190808080246.8371-5-iker.perez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190808080246.8371-1-iker.perez@codethink.co.uk>
References: <20190808080246.8371-1-iker.perez@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>

* Create two separate functions to write into hwmon_temp and hwmon_chip.
* Call the functions from lm75_write.
* Make hwm_chip writable if the chip supports more than one sample time.

Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
---
 drivers/hwmon/lm75.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index ed72455bcfa3..f83bfd7ceef7 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/util_macros.h>
 #include "lm75.h"
 
 /*
@@ -325,16 +326,12 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 	return 0;
 }
 
-static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
-		      u32 attr, int channel, long temp)
+static int lm75_write_temp(struct device *dev, u32 attr, long temp)
 {
 	struct lm75_data *data = dev_get_drvdata(dev);
 	u8 resolution;
 	int reg;
 
-	if (type != hwmon_temp)
-		return -EINVAL;
-
 	switch (attr) {
 	case hwmon_temp_max:
 		reg = LM75_REG_MAX;
@@ -362,13 +359,58 @@ static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
 	return regmap_write(data->regmap, reg, temp);
 }
 
+static int lm75_write_chip(struct device *dev, u32 attr, long val)
+{
+	struct lm75_data *data = dev_get_drvdata(dev);
+	u8 index;
+	s32 err;
+
+	switch (attr) {
+	case hwmon_chip_update_interval:
+		index = find_closest(val, data->params->sample_times,
+				     (int)data->params->num_sample_times);
+
+		err = lm75_write_config(data,
+					data->params->sample_set_masks[index],
+					data->params->sample_clr_mask);
+		if (err)
+			return err;
+		data->sample_time = data->params->sample_times[index];
+
+		if (data->params->resolutions)
+			data->resolution = data->params->resolutions[index];
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_chip:
+		return lm75_write_chip(dev, attr, val);
+	case hwmon_temp:
+		return lm75_write_temp(dev, attr, val);
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
 			       u32 attr, int channel)
 {
+	const struct lm75_data *config_data = data;
+
 	switch (type) {
 	case hwmon_chip:
 		switch (attr) {
 		case hwmon_chip_update_interval:
+			if (config_data->params->num_sample_times > 1)
+				return 0644;
 			return 0444;
 		}
 		break;
-- 
2.11.0

