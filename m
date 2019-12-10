Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61779C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320602073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga+8gM7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfLJQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:42:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35274 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLJQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:42:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so126731pfo.2;
        Tue, 10 Dec 2019 08:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U90+xxPa/n6CEWdGb92kTN2mRHFkhOKFhP+vKnVn8pU=;
        b=ga+8gM7y0/a7dq8h7Be7uego7Viw+xRA4OAMvc8ASgW2a/Ugh5/sGxd2g+uaSYRNmq
         fqYAUgo5R3hQWYC8S6daWKT4SJZrDKv9CRhN8o7rne8oSWovy6DIxNaheBvFJWerApSU
         6Mzg8h+BoufdPRY4Dl0aRCqlaTI7YA99ndFzTNU9DPmT5eK4OWGz/7oj4FPLdO70a1i7
         W6awMxhNGDcTjeUq+xY6cniGqZqsFIbidlJq7NntjMV0RU9/E0q52KndT2C8mCz3Lh3Q
         k5VX8/aVTT1Fi1ZdneHBVhaNX8z3Djz+jNH1J6SHVWRjex4QXBRnxVnotR6kp6ASw8T/
         D+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U90+xxPa/n6CEWdGb92kTN2mRHFkhOKFhP+vKnVn8pU=;
        b=gXlqgDy80gld2MVfrRyUBfOTZ9rQcrUpjQLhJyXJ54lFVcp48dCazn82FhkNxZ197x
         eIg+Rvd0sjYGNDMOD9KeRzhEJKd/DhKe/VWJS2Kjs2Z5MtNOp+2H9L+OYVSB727L3tn7
         prAyB+T5abb/vNvKnSodJE+7Bu24HPc66pDGF3lUo8pW0DjucTUhuXLoZdH7lxbg7aF/
         m80OvavBRiJe8p/NNy00i3ZM6K/9HtMKdIFCsiQSDI5+/ABs9QMktsF+LlUyUaWYv/TP
         1e6p611YvqA8suhqQOzHt9Wlb1Ayuc4l0N1/ek01Rm/3SogeP9qHzHdPNCleMfcMe/Uk
         W9HA==
X-Gm-Message-State: APjAAAWU6M8wajj0M2K6FXV7r2KSYugWQGirexc4V1mjn86V7CyxpztM
        6nOno3M4MA+0F9muw15V3LA=
X-Google-Smtp-Source: APXvYqxNayeTWaLSe9RInRfTVj1oOjtaqUWtxFeFSKVUSRKIs280RrcgkQ0po0Tu4au3EG3heSR9FA==
X-Received: by 2002:a63:4f64:: with SMTP id p36mr26649705pgl.271.1575996148068;
        Tue, 10 Dec 2019 08:42:28 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:26 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/12] thermal: qoriq: Add hwmon support
Date:   Tue, 10 Dec 2019 08:41:53 -0800
Message-Id: <20191210164153.10463-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index b684d3ceda69..b75d34e07da5 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -13,6 +13,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
@@ -139,6 +140,11 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
 		}
+
+		if (devm_thermal_add_hwmon_sysfs(tzd))
+			dev_warn(dev,
+				 "Failed to add hwmon sysfs attributes\n");
+
 	}
 
 	return 0;
-- 
2.21.0

