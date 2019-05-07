Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A4520825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFOUUtGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEGTiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:38:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46729 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEGTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:38:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi2so8668667plb.13;
        Tue, 07 May 2019 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0un4Zq1Ylcl4MILUCeu+0vxFmB6uI/BzyrLOsfSvsMM=;
        b=RFOUUtGXP8OJR5bQmeIdNY3FuggAcfnTfuyUoXqn9lbFOD3gfZnBbA63LWUpgklwQ0
         7MI/Qs3Ae2RpZm4tI4XSW4RxXp7Y3xj7Z1uwkilzE6NDrPqc3uvJwx8/vr2giw9wKfB0
         zkDlRQXeb/bF6fflJkc0DBDNJNtkVoQIdoeimGxZJUPGfJGRLaCpbx2IIkj3foDMYjOO
         PWaPmr/M3yhPf7N681uWwQDkxLfH2/8qL9wUalhnAnG5ihkkEaJK+G+QhLmANO7vRiTn
         cgcZ8jdoAM7U3czBbWeKKh7ObtbqV5/X4mA9beUOefb+nLMwGUReTc2+PVbgv41TMLfO
         gXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0un4Zq1Ylcl4MILUCeu+0vxFmB6uI/BzyrLOsfSvsMM=;
        b=DaY1NFiMQNmL4I1nseJxl2l74ew+xt6RG9GeJuw01Fk5I9jPQ4Oc0U7OHuZYNtpLyw
         PzZvzf+MOMsmg8/3cp3CIsTILLdXRZM7vf2SUCXWG+HoCIHT7RrqPwpUkXo8whfr9FVP
         15amTxVu0XWxlupH0Z489fWjAKqs7GR2DFfy80lv5WkxGufmRZBjQBfTIZblAUQyBUAL
         oKIksqUtbh6ClaHhwaYUNqlAt3YJW7R724jUE/UY8aV1bWaSCRDryJUPUM+gKqrJchwj
         SNS/KxjPHajfxTbsTHD3yFK4maqQgoNHKnUIe+sakT0p+EFUqmIEXkdNQ5Appk3+8e3r
         SAXg==
X-Gm-Message-State: APjAAAXQwMyI2qnz368APL+8Pgk7npums5ksQgoMqpFaqhOZc+Vw6GEA
        RodoiyjD/nCNFemcVFxR0dPEYhKA
X-Google-Smtp-Source: APXvYqy9JrXGy3NKwIYDouYAWcrRPVQJ8hxuwN5Y/em8coxBLkR2WaURI4/cr8v4DaOdBargyNfPXA==
X-Received: by 2002:a17:902:e188:: with SMTP id cd8mr20263009plb.110.1557257899147;
        Tue, 07 May 2019 12:38:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l21sm5964658pff.40.2019.05.07.12.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:38:18 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 3/3] hwmon: scmi: Scale values to target desired HWMON units
Date:   Tue,  7 May 2019 12:35:04 -0700
Message-Id: <20190507193504.28248-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507193504.28248-1-f.fainelli@gmail.com>
References: <20190507193504.28248-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SCMI firmware implementation is reporting values in a scale that
is different from the HWMON units, we need to scale up or down the value
according to how far appart they are.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..5c244053efc8 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -18,6 +18,34 @@ struct scmi_sensors {
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
+static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
+{
+	s8 scale = sensor->scale;
+	unsigned long long f;
+
+	switch (sensor->type) {
+	case TEMPERATURE_C:
+	case VOLTAGE:
+	case CURRENT:
+		scale += 3;
+		break;
+	case POWER:
+	case ENERGY:
+		scale += 6;
+		break;
+	default:
+		break;
+	}
+
+	__pow10(abs(scale), f);
+	if (scale > 0)
+		value *= f;
+	else
+		do_div(value, f);
+
+        return value;
+}
+
 static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
@@ -30,7 +58,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	sensor = *(scmi_sensors->info[type] + channel);
 	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
 	if (!ret)
-		*val = value;
+		*val = scmi_hwmon_scale(sensor, value);
 
 	return ret;
 }
-- 
2.17.1

