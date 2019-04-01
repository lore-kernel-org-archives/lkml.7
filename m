Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AECC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0105E213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzW6MNVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfDAEPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:15:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46875 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbfDAEOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so3795068pll.13;
        Sun, 31 Mar 2019 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZaiapWGaoTXU0LkYBkg6M2w0Maqr9Jo6agWZcaWhl0=;
        b=WzW6MNVtCCw9ZK2EyTzyFDr11uZ1JO2aglZ/ak3oJ+6keln9/wxmLxPV8Imj9ztKR4
         ZM20JBdMAF/JHyjHOXhbd4nIDblv/7Hog3CmBC45FtnRezVXn6Xp1j9FNqlmy6u2/M+o
         rG3aV33Rp1fyQbHCSqxlN0uqvZXFl9XAmj4IVuy2ZZ4mqBnueKPdV/4AVsEIRZdUNnfO
         bmlQrv5hlR004VeEJEUv1FOsI8JtpNgrTFHinmaezg8nYTZih39JBwkJIkz4NJ8/U8HT
         S31QU+VTU7+A/G+Lu57KqeKzC4WlPCJRFy8CMXS1DH3YX2E4cbs9fI7l29ooeOHZd/zn
         XjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZaiapWGaoTXU0LkYBkg6M2w0Maqr9Jo6agWZcaWhl0=;
        b=d9KmLLwL7DtSoxmPeV39cMtYU2WEChP29ZGSOoAHELyfME13CwtIKSl+onLg9h/TJl
         lLMnWtd3S9+LWhsiyJj2n6+6Vgmt2mvZxGGZ4InX5vrAvoZTDlP8T4hWtkxsvBAsRc6p
         09K+oGxFSKDtivCJWg/Skqho5WJnk1t9km0C8jFpmszRR58n0OT0OQ9n01AE1HAYZT2k
         zDKTS/3WBKfNNGx/MtE7OBuiCFRBIFxOHsJ93iw3TcWvVOK4LyFDMLPZNdpUW1IOGoU2
         1arODEOvzrMe1VTUgr73jTriB+GU+8ie6BSuld3iNcH3j/2o1zXkFJ8S4xL+jiPOdloj
         gVyQ==
X-Gm-Message-State: APjAAAUrnbj9oFpYSap/bMxA6RtQbl5ghefgP0Vz6c8rE3ABhBlkT2cH
        DcFS5INwK615kLlGUiRPhGmPEpV/
X-Google-Smtp-Source: APXvYqy6YX0rCiGNhRYii2b08Ds1ZfizK7HEhVylGnFKRKg+o/E2qW6fJYY0StgGmg9Nyaj+4C80uw==
X-Received: by 2002:a17:902:b715:: with SMTP id d21mr33326061pls.103.1554092090892;
        Sun, 31 Mar 2019 21:14:50 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:50 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] thermal_hwmon: Add devres wrapper for thermal_add_hwmon_sysfs()
Date:   Sun, 31 Mar 2019 21:14:17 -0700
Message-Id: <20190401041418.5999-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
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
Cc: Zhang Rui <rui.zhang@intel.com>
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

