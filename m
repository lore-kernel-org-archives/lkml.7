Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB74C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED85216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH2En+8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfEHRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:00:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39015 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbfEHRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:00:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so9087360pgi.6;
        Wed, 08 May 2019 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Arjf5SjBWyqdlOF7ZBaYh9oh1wq7UwM1Y2hcNdX8mds=;
        b=LH2En+8GU9Jfc/Y08z8NM3JMYSd06Otfgk9YajGHKw8GLCAsze8McVlMGwMZ+1Fr8k
         GwpRAjy7GW3i5/0cd/TcVwKOZM5xu7bSEZOwYHT0RxDGRLWBqZbMCONfJIBKj++/dw9D
         VU+3FqgafzKAclaP0BBGBoR61bg5WhqlCm3uMdspjdUWiOLt7xHwrbFSBpbloe5EpMul
         raX7pnci8OoUb+ESIOMhsHx3/zAokq6jhAJDzKXhD+DT35ynJJqX5vCAtOKpsJAAPrMh
         +9vUwl/2oQo5sYI/D6LXsGKcBT8YgHC00FzobxJIu87XWEuPqRLkcwlNNByutJzTMshY
         t+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Arjf5SjBWyqdlOF7ZBaYh9oh1wq7UwM1Y2hcNdX8mds=;
        b=Kdbp9gAbSTdJq0nao4HMoO439eSnBP5cvzaH3eP4+x0x9ra6HSilVohH5tUGuLjdL3
         hrWLCmqgY9cOSGCRmc0I2/8XDkHK0dA9F+LWXEh9m/RCJpW1rDlKH3x+A0JgiNGshYIh
         g9aYNESmwLimRaJNg1vO64Il9NnfDY541nJQP8SABTrIwH4hgTk3npj+alyxOWdkfArN
         AldDnVXixbiMjpt++O47Scu6yXdI3eQyl9Y7u5jA4TrTAfMQy02uKRWzM9JXV4jnfilx
         JEhr5usw6uXXWuByjv1HlExxz/F+yvexX2cgHHty6zq4izIay0YVpqvqgVZmTr7eNSaX
         gdlQ==
X-Gm-Message-State: APjAAAXJ3wkAOt9JT/IDcJOBzoMTi43D0hbzqH51+LZfwHD/zj4H0m/T
        fcI8UawwsSm3wPk+RK+0J8Sih3oe
X-Google-Smtp-Source: APXvYqwl9CXMPkpW61t5Q7DpVogsdh0PvSav6XMhmjJj84u2l1Kj6Zj/6Czq4HsuCQ8DX4bCnY+48Q==
X-Received: by 2002:a62:570a:: with SMTP id l10mr39828406pfb.151.1557334842162;
        Wed, 08 May 2019 10:00:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a80sm11347773pfj.105.2019.05.08.10.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:00:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v4 2/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Wed,  8 May 2019 10:00:35 -0700
Message-Id: <20190508170035.19671-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508170035.19671-1-f.fainelli@gmail.com>
References: <20190508170035.19671-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SCMI firmware implementation is reporting values in a scale that
is different from the HWMON units, we need to scale up or down the value
according to how far appart they are.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..4399372e2131 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/hwmon.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
@@ -18,6 +19,47 @@ struct scmi_sensors {
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
+static inline u64 __pow10(u8 x)
+{
+	u64 r = 1;
+
+	while (x--)
+		r *= 10;
+
+	return r;
+}
+
+static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
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
+	if (f == U64_MAX)
+		return -E2BIG;
+
+	if (scale > 0)
+		*value *= f;
+	else
+		*value = div64_u64(*value, f);
+
+        return 0;
+}
+
 static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
@@ -29,6 +71,10 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 
 	sensor = *(scmi_sensors->info[type] + channel);
 	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	if (ret)
+		return ret;
+
+	ret = scmi_hwmon_scale(sensor, value);
 	if (!ret)
 		*val = value;
 
-- 
2.17.1

