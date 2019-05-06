Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB20C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865520830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD8Bl/oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfEFWlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:41:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45948 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfEFWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:41:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so7168010pgi.12;
        Mon, 06 May 2019 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FL8AbszKRwppcPe458VUea1JFGXeL+AyuUIjEd2fdow=;
        b=WD8Bl/oz4MmtFrgl/OR94+xGKMcER30iXdBiIr4cfyk1QUcR5T6uNyJUFUGTkXpwvS
         cyBf92CemP6O/jgpDmadEEXXJQXaB50ksCHXaLl8OL3UOesvt/RIvo5mIaCinVXp37V2
         NzSwXCFOw4VZMoJLhEAaOeByPwVXfN97zDFmZZUSM4RADzzcWPxo6c0wALyVFp1kSY4r
         vXS+JgG/+w7dw1E/u7NoB7l0TfMaBYZxEUE+CwGB11X0hsfTGO+jcFkGkvwVRM2qrcR8
         NcqYW5lEkUE9C8j/gvHc9jSodFPbNJ9VkoJ7lUr2DFVWsMJ1lyMy2IIpgQqZ9jet7hky
         gXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FL8AbszKRwppcPe458VUea1JFGXeL+AyuUIjEd2fdow=;
        b=omNsQzAlVL7iDy/cu+nwI3x2nK5yOd8L1Np6rqqXnebmdGJXrma/Vzwsj10v5vso86
         8S5VnUcS+CX4MFIX26DU1y0to41T9h32DNtJ6ej3YmHDRMSsiWBjVTfCatwu5EQ1/kQC
         HoDlHad0Zx92oauc62cDwu8PKs6SlvRkAS6RkLYnhg7s8TA70rVgEoOkYvvfCxCx6ma7
         hZpDOi2D/o8V1sctoYdMcxrANdteSpO5lgPyRTRztHt5FJ5bHvfNOr6zid1hSqgUkRVU
         xdV32Dul3nCBb+/RDtzWLaCWfNUHlHwXV54iG3eEg43Wa7LIWgJFN6FlR4sNo6uE+NX3
         KKNA==
X-Gm-Message-State: APjAAAU8SVJj/uCvQpB135cm21VugHLhnrPCPT5zCMZ0mJAhdBXIsm1U
        dfb5m/B1wc6idEZ7r3Wf+OoHPxG7
X-Google-Smtp-Source: APXvYqzazBLsdP/PngE2ih+OrbyZh7ATgIiJ4YmGbGaickNYpdl6b/VcxzBShKtEhMdIOZbF6BYLhg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr34894833pgh.86.1557182478738;
        Mon, 06 May 2019 15:41:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id s11sm19784153pga.36.2019.05.06.15.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:41:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH 2/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Mon,  6 May 2019 15:41:09 -0700
Message-Id: <20190506224109.9357-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506224109.9357-1-f.fainelli@gmail.com>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SCMI firmware implementation is reporting values in a scale that
is different from the HWMON units, we need to scale up or down the value
according to how far appart they are.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 55 +++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..e9913509cb88 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -18,6 +18,51 @@ struct scmi_sensors {
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
+static enum hwmon_sensor_types scmi_types[] = {
+	[TEMPERATURE_C] = hwmon_temp,
+	[VOLTAGE] = hwmon_in,
+	[CURRENT] = hwmon_curr,
+	[POWER] = hwmon_power,
+	[ENERGY] = hwmon_energy,
+};
+
+static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
+{
+	u64 scaled_value = value;
+	s8 desired_scale;
+	int n, p;
+
+	switch (sensor->type) {
+	case TEMPERATURE_C:
+	case VOLTAGE:
+	case CURRENT:
+		/* fall through */
+		desired_scale = -3;
+		break;
+	case POWER:
+	case ENERGY:
+		/* fall through */
+		desired_scale = -6;
+		break;
+	default:
+		return scaled_value;
+	}
+
+	n = (s8)sensor->scale - desired_scale;
+        if (n == 0)
+                return scaled_value;
+
+	for (p = 0; p < abs(n); p++) {
+		/* Need to scale up from sensor to HWMON */
+		if (n > 0)
+			scaled_value *= 10;
+		else
+			do_div(scaled_value, 10);
+	}
+
+        return scaled_value;
+}
+
 static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
@@ -30,7 +75,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	sensor = *(scmi_sensors->info[type] + channel);
 	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
 	if (!ret)
-		*val = value;
+		*val = scmi_hwmon_scale(sensor, value);
 
 	return ret;
 }
@@ -91,14 +136,6 @@ static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
 	return 0;
 }
 
-static enum hwmon_sensor_types scmi_types[] = {
-	[TEMPERATURE_C] = hwmon_temp,
-	[VOLTAGE] = hwmon_in,
-	[CURRENT] = hwmon_curr,
-	[POWER] = hwmon_power,
-	[ENERGY] = hwmon_energy,
-};
-
 static u32 hwmon_attributes[] = {
 	[hwmon_chip] = HWMON_C_REGISTER_TZ,
 	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
-- 
2.17.1

