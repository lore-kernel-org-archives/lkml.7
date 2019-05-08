Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BBC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8771F206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD6BDPB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfEHSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:46:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38089 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:46:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so10531157pgl.5;
        Wed, 08 May 2019 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjWr7A4I6wrCVekiaLqsGdBePGpwWiWT94AbX1NT9d4=;
        b=WD6BDPB+Th+QkDF0v2sQr7Ri9+1azG8Iff04dhcNHbaVVINNdiNgS8sNad5OTKffzM
         6TPLZBrSYL03RBhTKhxweI2IL4ueCy7c77Zu8ZCPEc3DNHXb0fTa7j3dhS4NLLb+trvg
         fGc/uzL+zNC+nysK3IyXfM9vjuq5/nsQmHKO+Y8D6ydjRPDxyp/P5wWGw0nzwy/P62G+
         12uTaajACxZzNR6CTiA0bYtYmXIVreEkJOBiDt/EK34lOGjRov65mEokFoPmZXqP8SkN
         ewvBaYcYcdnMvqDKNCBOVpOg0PA+yaNFPRVt6I34H25ISzOpIpn+RsSSDAEeXp0a4WyZ
         EnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jjWr7A4I6wrCVekiaLqsGdBePGpwWiWT94AbX1NT9d4=;
        b=tVQVV9tFYPrfNF8wrYe9fF9JTbLoJGG8/Fi2FspoRDHBm8xnG+J6xRjdTegyK8CXkm
         LLwuWPCxE56wQA3E5IsOwRNHe6jsRmvx5BPaCtYvZpK0U3DXApUXniOZsmSbvl6Qy6Y6
         xT/jdUeqCNXIlzDnH2jFvM/TmpNsJhBK7z6pQfKz9Gy0x0tFsg9JHqHQ0fkZKx5a41PY
         fgJwHJJUBPceFbiwat3qc/JP6WxLEUi76sOgNsnKuLxcZRfu17lnZ22qiUhOwAgt8Lg1
         sGJ3zQPssNg4Iy2K7bxxJhfNx432xbj80OYY+IilUWmjzo8uhO/MFknGs2bp2DynBMq6
         1Rmw==
X-Gm-Message-State: APjAAAVTx5Oi6bhcIchhua23ZbCnJd/86mUnjLrRlqoSROHASJ2KKy5v
        LDyu/AbbV3UhA+aT5TzTGsZscSOR
X-Google-Smtp-Source: APXvYqxhWMIbkdgMB2EMmuGoDM9bgUZBWyQ53tKLMhKoRzPYn3OPYVL9dzOq0o8hZd+6GeR/LUXbag==
X-Received: by 2002:a63:317:: with SMTP id 23mr29515935pgd.414.1557341204061;
        Wed, 08 May 2019 11:46:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o66sm23257953pfb.184.2019.05.08.11.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:46:43 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v5 2/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Wed,  8 May 2019 11:46:35 -0700
Message-Id: <20190508184635.5054-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508184635.5054-1-f.fainelli@gmail.com>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SCMI firmware implementation is reporting values in a scale that
is different from the HWMON units, we need to scale up or down the value
according to how far appart they are.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index a80183a488c5..2c7b87edf5aa 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -18,6 +18,47 @@ struct scmi_sensors {
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
+	if (abs(scale) > 19)
+		return -E2BIG;
+
+	f = __pow10(abs(scale));
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
@@ -29,6 +70,10 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 
 	sensor = *(scmi_sensors->info[type] + channel);
 	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	if (ret)
+		return ret;
+
+	ret = scmi_hwmon_scale(sensor, &value);
 	if (!ret)
 		*val = value;
 
-- 
2.17.1

