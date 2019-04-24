Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E548EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9B3205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB2LpK2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfDXGtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37661 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so8792221ply.4;
        Tue, 23 Apr 2019 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pOBhoUcUQSUTE6/OanJCqpiU8LW9C0RIfBiQtMH2XM=;
        b=FB2LpK2B7+7s7LsNpDkj9sfM9CIoGoiAnAa94YUVeb4ksY4DN1jXnCHzwek0uAqHpI
         JnDkeyGXAQuM1OQpn7XBP44xxpijf/OUIWGVQe03kVrU4S65U3F9fbbX+LffjFQYRata
         28bw3jNTMaV168QZN6dhovxq87yqYzu/45u482VPD474HG10A5jwDAtyGM0i8NldALm5
         koP0yQ5TmrqDmTsNs0xzYEefB1H/i/lRoaWNPqJZbsaw44gQaMBmes8dVpivKrX4V+5e
         PkXQ1lVJ68h0PECSPuh4egVHwB5f1trNTKyq/S84Cqf+7lFt/BV8p1kfqGlH0IAdU7xP
         fwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pOBhoUcUQSUTE6/OanJCqpiU8LW9C0RIfBiQtMH2XM=;
        b=csckHuT+WGlI83f4xvlIEczsKGnn1wrVszBrDITm7plABBoz0lZxOcUhIAnUpKUQ/S
         rMe61hD1Z55U/bU/Bi/W2WHmje6tLKpIw5xHpDsEnbP1mgoXDnN83hzQVe22POUx+F6r
         sPRC4cUWJrjj+uhvu3KBUvoAiaX7qkhFBNatMalZvLflbXsB/OldGsEx8raYQPQi/Lxn
         PDij9EXMDMZuAVw+Vi+W7cvQjO7/ZmgFpQp9Id3R2tiCJ+ok57S0V6tZ/OVatGPpPaER
         PcgQrCm/BiznXHBr7Xed8eAuAimiUt+zSQr5NZvPfT+j9h6vj63erj4Y/2NYJzONRPCw
         RjIg==
X-Gm-Message-State: APjAAAUx/5xDsmz2JnOrbmaQD3nqReCiL/Zv8jK1TpQkewWKGHUN0rVC
        1DpqgOPotuKt7wCjn2U+QWLw7CjE4Vs=
X-Google-Smtp-Source: APXvYqxTI7Z5kf937iWSv0Qaqzn9Xx1ySU2iKDmeQQOBKYOaJyz6sQVv8FrguOX6QLpL/w3vWzK27g==
X-Received: by 2002:a17:902:801:: with SMTP id 1mr29515821plk.14.1556088552955;
        Tue, 23 Apr 2019 23:49:12 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:48:41 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/12] thermal: qoriq: Drop per-sensor data
Date:   Tue, 23 Apr 2019 23:48:22 -0700
Message-Id: <20190424064830.18179-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
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

