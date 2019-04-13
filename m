Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE0AC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3741120869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFSFmZSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfDMI2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41300 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfDMI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so6280044pgs.8;
        Sat, 13 Apr 2019 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioF0cKR12rI6esgkEu/uGcNVeKMcEFlcMNhoifYw7yg=;
        b=bFSFmZSJk3ZIyC0DhLCpFf0UxxbQW6TIF/zLUDNiou0sDoos0AtMdtvOeXVFjCVo+j
         mrVx68aNc9vA7oVkZkI4cT8U6ibg4KJ19DM1kgEFRrqHpBujJqNZ1M6aTxpejLpiL7od
         iHhAP+voymDBvHIGipdR8IR7bKULH4ixzrC93i2trDyFTaxz1moAbUVpSyJJl24saOQD
         GhzyZbRauTF2Ganlx3wO0Fh6ZyzQ9wUwCiDz0h9UGPERqT3h2+IjqSm+oY54FwCwK8Gd
         NfkQSuPIMDFRvOWYZaOMAI5oIDyShx8dCXF+JgQl1ulzWOTaAszE4HgKqY3WJPjhVf4h
         7vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioF0cKR12rI6esgkEu/uGcNVeKMcEFlcMNhoifYw7yg=;
        b=scUrGJIiBaaRhkvUgmw3rdlWXiMbtqj+5VNIP2S2H/G0z5FaomM6rzWQoKFQya/sB3
         ftWq2VL2bjcvrvTaQRkviAlG7bgVIk/IBj/M/u6w30V54h131Mg27CejkdxWzQCYep5b
         6gaKt64DFsMnyVeoJtOcGlhQpTGIYPgUmdJKLvolGkPPl5cqT+3bqjlOinE73pILQTIg
         7dvpMYAPZtdU4jpeKAJTA4yoiDPrWbRX/nGbuC/cQpYG+G4/o334Q7Qv2IQkJNmAH+Ow
         8LxLOcLzqIHLwDOv79iL0KCkJtPdNY+TKPXH6zYjAitN/rI+86RzNrK9umyTaZS/440z
         MBbw==
X-Gm-Message-State: APjAAAXxFCAyh8cUxJIvAWj0VCVAof8GjfzcMkLoqpfx0yg6YJf2YTC7
        WYh1e5sXtjDiNUS/pFaINHlOjLHw
X-Google-Smtp-Source: APXvYqzUG3V6eE9t3J3TivTCeehch77k03rKnqUHnXlEXeeAl9+huIRiEGknUEHlK5GtMC37IQ/HLw==
X-Received: by 2002:a63:2983:: with SMTP id p125mr59194840pgp.262.1555144099049;
        Sat, 13 Apr 2019 01:28:19 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:18 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Sat, 13 Apr 2019 01:27:47 -0700
Message-Id: <20190413082748.29990-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
code.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
 drivers/thermal/thermal_hwmon.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 40c69a533b24..4e79524182e1 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	kfree(hwmon);
 }
 EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
+
+static void devm_thermal_hwmon_release(struct device *dev, void *res)
+{
+	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
+}
+
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = thermal_add_hwmon_sysfs(tz);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = tz;
+	devres_add(&tz->device, ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index a160b9d62dd0..1a9d65f6a6a8 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -17,6 +17,7 @@
 
 #ifdef CONFIG_THERMAL_HWMON
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
+int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
 static inline int
@@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	return 0;
 }
 
+static inline int
+devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
 static inline void
 thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 {
-- 
2.20.1

