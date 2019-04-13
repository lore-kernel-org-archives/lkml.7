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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA41C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E2C20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcB3DUgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfDMI3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:29:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfDMI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so6242437pfo.6;
        Sat, 13 Apr 2019 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXzfvmogFkg7sNZrMv98pUmnce88F++D6aDSyWLVFDU=;
        b=TcB3DUgr1bBDl5zUnoUPBo3dF9jmpV3fwxXzCdsSj0yL8kxZ1Wk9krkkRNT8ZXdnHn
         Q+3MK3Qg1h3ZiuiVf8XGuYCld6laXF3Gx9sUwchy+i91IAFSlHkHazUXBH9BMcqXDtzC
         PmqXAdCOR+987SiFBOTh0JSNPKMrqTKHhaipbOJ181WmrSSyQk32A+QFYO5mDhl1rQlZ
         nBsCrAkdKJv7BUBRgai3vBMcvHRORrXwJ0xMgaztZsuezx1VIlXsvrW2eSljGlj5Weo1
         tYyEyDflEHoiIt0mFnNNXJsLe3S0oVMLHHiRPgblMgNKABO9FBPkYOoGcQILMCd4YBoU
         MStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXzfvmogFkg7sNZrMv98pUmnce88F++D6aDSyWLVFDU=;
        b=MNFatmC82hrp6Am8CAgmZz6l/karwCdrzn3MiN7yxblHA3Nmx5kl4+hf10houDSIq9
         19Wz+iA6QwW+X2lDEpysk5uEKfxA0V6yfZWIS390e/hrEZCVAjJWfMglBhwTiyEFNQyR
         5acZcppjaGPOTWIMc01j3ewrOu2PKZcl0NPUN0YPorlHfpBrNen0EkmBHKH30pRBbJYi
         Xdk896WyqfIYaULmwaFh5PHTbRqkBaHuPQ3n9Z1fBEaS3x9aK/HF1gzkW4dLxsqQcK/p
         vzfWXRi+Pzi5O1kMYMGjPxR0nliqKPCwTVoJfnGZGyhq+tErN0jT+fhEa5YR9dhrD7tn
         dLfw==
X-Gm-Message-State: APjAAAX9TTe3vzPZ0s0RjtN4BuuobzpNyXYdsO9aRq1Iv2WDItb2Hi5s
        RXzL0xO5wR18/WYoJ5P9bFvCo6+M
X-Google-Smtp-Source: APXvYqwAbUzxFE/2eMUGtPR+x5O67JRxRIKCFcIhhJKOAOx7I2XZp+P0ahX71Xyrd4Q7ae3/ot7vIg==
X-Received: by 2002:a63:d250:: with SMTP id t16mr56961355pgi.288.1555144089961;
        Sat, 13 Apr 2019 01:28:09 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:09 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/12] thermal: qoriq: Drop per-sensor data
Date:   Sat, 13 Apr 2019 01:27:40 -0700
Message-Id: <20190413082748.29990-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that driver is converted to use get_temp_id() instead of
get_temp() we no longer need per sensor data. Drop all of the code
related to it.

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
 drivers/thermal/qoriq_thermal.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c041d1ae3500..3500e238fe3e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -59,20 +59,9 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
 };
 
-struct qoriq_tmu_data;
-
-/*
- * Thermal zone data
- */
-struct qoriq_sensor {
-	struct qoriq_tmu_data		*qdata;
-	int				id;
-};
-
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
 	bool little_endian;
-	struct qoriq_sensor	*sensor[SITES_MAX];
 };
 
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
@@ -93,8 +82,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 
 static int tmu_get_temp(int id, void *p, int *temp)
 {
-	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = p;
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[id].tritsr);
@@ -115,17 +103,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
 
-		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
-				sizeof(struct qoriq_sensor), GFP_KERNEL);
-		if (!qdata->sensor[id])
-			return -ENOMEM;
-
-		qdata->sensor[id]->id = id;
-		qdata->sensor[id]->qdata = qdata;
-
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-							   qdata->sensor[id],
-							   &tmu_tz_ops);
+							   qdata, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
-- 
2.20.1

