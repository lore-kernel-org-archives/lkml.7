Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0A20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6HCWjxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfEGXKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:10:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38407 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEGXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:10:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so9058169pgl.5;
        Tue, 07 May 2019 16:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKMO64xZ/NLNKAqyiQNdSxQ5RK52UXZdK9wfMghWcTw=;
        b=S6HCWjxdMhJXtpwtM6/5wElmUx+WcK79V76XMFaSdug+PAu+yyFKLenuOkNhRbUxmS
         v3peC+1jROrGVnrXIO+nS9/OSVcDeZ0XUNanPKar19SXIlUGdEois0Y36nWjHYo55e+t
         Apt2ZkWGfyiHwqu8+2TeAWya9gA+W3IanulvL9jEBzQBrfuBZUuOnqV3OycdOW45RDgQ
         ietXGqmx6LdjfDE8N760ppa9EixmyUX/Mebgb4XYQjyT0pWlFOH+1RYHxeZ4g0fODrjV
         /CdGuaj/I+JvyJ8z51L4ubjESbAmmGTB6BZWI1e/dlj5qk6WT+YUJNX/csrzSFx0fbAb
         7keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKMO64xZ/NLNKAqyiQNdSxQ5RK52UXZdK9wfMghWcTw=;
        b=EQ3HQERgeH6ToT89zscMxgaa2p9/HpXUDI6GHaij0EHa25lO5hEhPR0YdW9vaNOdNN
         Q7jgvvUDbD7YywIWq4RPgCcZcpn/7l/KdwMi/Vryi+w31ofi/Ctt66rFQl7/EVWvSsxJ
         qJG4NqJPFJ5K5Svt/SY6zBAWqLn1bHoM/spFgooM58lH3IBt3/FcOr9qutX+59PXtUky
         3LQlpWnzeXaWVMoqN307jckziC+yUgl0CeYLQiD1Ry04ZKvnWvMek/1auMedTppGB+S4
         4Y08Mns5njL2OKSJLR5B2Ahz82YSbPU2vVJvbMMCSx/71gTxCnHURCNFAfAeWQdewus/
         M17A==
X-Gm-Message-State: APjAAAVNEqQLYTwO5tanCTJP1RnUWGxQD2cxuMW/YsrH5B9lp6E0hNBN
        Kn4czfxWDF2X99v0Znsohpf7PZoJ
X-Google-Smtp-Source: APXvYqxwBYjE6jd3+l8NIjy4bYaiYCnr9KFnXMPOKo6jq8A3gHkYS7MaEekUk25FuV5XGUSfcQ+cjw==
X-Received: by 2002:a63:e956:: with SMTP id q22mr43144036pgj.277.1557270616179;
        Tue, 07 May 2019 16:10:16 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w12sm7154742pfj.41.2019.05.07.16.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:10:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v3 2/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Tue,  7 May 2019 16:09:17 -0700
Message-Id: <20190507230917.21659-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507230917.21659-1-f.fainelli@gmail.com>
References: <20190507230917.21659-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SCMI firmware implementation is reporting values in a scale that
is different from the HWMON units, we need to scale up or down the value
according to how far appart they are.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..7820854e5954 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -18,6 +18,47 @@ struct scmi_sensors {
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
+static inline u64 __pow10(u8 x)
+{
+	u64 r = 1;
+
+	if (unlikely(x > 18))
+		return r;
+
+	while (x--)
+		r *= 10;
+
+	return r;
+}
+
+static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 value)
+{
+	s8 scale = sensor->scale;
+	u64 f;
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
+	f = __pow10(abs(scale));
+	if (scale > 0)
+		value *= f;
+	else
+		value = div64_u64(value, f);
+
+        return value;
+}
+
 static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
@@ -30,7 +71,7 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	sensor = *(scmi_sensors->info[type] + channel);
 	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
 	if (!ret)
-		*val = value;
+		*val = scmi_hwmon_scale(sensor, value);
 
 	return ret;
 }
-- 
2.17.1

