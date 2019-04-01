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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0961120870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtRNoQHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfDAEOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38896 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfDAEOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so3804030plb.5;
        Sun, 31 Mar 2019 21:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OHfaSS1hZcZZSMfigWHCrLb+ckl8aQH1dv2ajLO8zTA=;
        b=DtRNoQHPoj7RFuUOnt5MxxP+ZwvWIYV2vRxjYNlkEiO6mL2axc+qY2VdKK8k2nuPo6
         Ztr3hiIk7MG85d2WMcm4+dLGq7wqvshHB+inzbwQo5tiHVNQLJFoJj8I+ks32iST8DX2
         xuS69k9+qCp3+wuBPN2ngnIb6PAodISxPVXXhItJKg45m+7W1OpGSIMhrrFPAr6ilLXt
         XG3II4yYHViNEZ84hO98o5SG0WBhZmLu4Kpxq6RhSPWEjgT7vr6JpIIGq80M5uxfliGz
         MisuabwCTWfUEaP0JMuJEEOvFeXcwYBp8a7zi0FPQcCa+llbpUrqgW4a4QkteM0yX9bL
         WLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OHfaSS1hZcZZSMfigWHCrLb+ckl8aQH1dv2ajLO8zTA=;
        b=DGf/rYgg5AG2hBBA0GiaCMkBYeLS16x+9sIfOZlgqE00oAhagS2Ali0FivSy3/ilKn
         sYHRpIJ5Y1AZ0V+w5SMejnA1xohMGMEqRLXnUuCjkG2cpryxZnX2oo2LO5FlWvPG5RUd
         68o5WECRbII9THOPYNsI58Pze0MKHCuW2+v7N4ltcz5jlfPMltLel5odkNdBQJP7i8X7
         f7zayvHFgLaXrv+N4LRQekyonykUKug4ss226TcyvRgxW1DAvVfqiIIvMKjTPRPMRD7C
         aUtQlj8H9mAYZpJlBQrW8QDi63I3AZwBo4QtAzVJk8rb/pEC00SDimgsf6U48RH0rfDM
         PqsQ==
X-Gm-Message-State: APjAAAXCgAyrbiQ92/CY3Kqni/Ea5gKuHDicpL+fjNX3a/LFpFSGdQOQ
        ueCh1kTftP/3Co98IX96SRKwmtpa
X-Google-Smtp-Source: APXvYqzhGy5goA1wAh772Eu/jpmOU3eES6cBmLcv3LjQFkLfXi3vjCEJfSHymcu6O+cUUfDW1tlj0g==
X-Received: by 2002:a17:902:7793:: with SMTP id o19mr9683430pll.275.1554092080813;
        Sun, 31 Mar 2019 21:14:40 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:39 -0700 (PDT)
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
Subject: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Sun, 31 Mar 2019 21:14:10 -0700
Message-Id: <20190401041418.5999-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed per-sensor data into struct qoriq_tmu_data so we can drop the
code allocating it. This also allows us to get rid of per-sensor back
reference to struct qoriq_tmu_data since now its address can be
caluclated using container_of().

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
 drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e281bdcfa11f..deb5cb6a0baf 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
 };
 
-struct qoriq_tmu_data;
-
 /*
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
 
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
 	bool little_endian;
-	struct qoriq_sensor	*sensor[SITES_MAX];
+	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
+static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
+{
+	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
+}
+
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
 {
 	if (p->little_endian)
@@ -94,7 +96,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
@@ -114,15 +116,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
-		struct qoriq_sensor *s;
-
-		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
-				sizeof(struct qoriq_sensor), GFP_KERNEL);
-		if (!qdata->sensor[id])
-			return -ENOMEM;
+		struct qoriq_sensor *s = &qdata->sensor[id];
 
 		s->id = id;
-		s->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
 							   s, &tmu_tz_ops);
-- 
2.20.1

