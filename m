Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190382148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCiDb+BT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfDXGsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:48:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43149 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfDXGsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:48:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id e67so922595pfe.10;
        Tue, 23 Apr 2019 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6u1+0A+lINz/WkgWeou5rXL2yFzVra0Yn/3CNTT8IsI=;
        b=jCiDb+BTrBNgqDMDF5zMriMM3urqQvfqkSN0GUYqR/SrL7zeV0hv3lyhM2sBpKCSw+
         RbDoaSRebzqMijRxmYZucfkgkmQqxW7SHVUnUBMZ9cALc5HJcpduL1LxhzYMP9uX6fUz
         imtIAj0JscwXujeJN7ZtlQx9WyYPmyzzqwK7hhEf/h02MT2RLEldRO6qdoLRwwOo+EzF
         r+Z9j9W26h1kc9hPTt/wyc4BAnuLCiK/HCpGO3juc+v31qwq3PAny8gkq5/CsaFUgxUC
         g4tqKZKaCcupff0WkycrTllAkeif/8FnYuubjLcrzUiGDwwZiBVh8ptzXRl1dfml3caq
         jRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6u1+0A+lINz/WkgWeou5rXL2yFzVra0Yn/3CNTT8IsI=;
        b=pPdJnAB2tMC0Q2NpQeHrlBsbqcndziDy6EnP80lu/Imp4WwDU9y6edLIeR3tbs7TdB
         RpykYio37IaoZuTzTbFG7/SdNpFr01l3K7WQUO+toTpPrCCEeB/74cwg7h+MIJwsZR4+
         lCcwLncO5PrDQBZOUji0/rDZQGTk/lvRtZksxjn1/IMfmIwGcmMnYuh9+ubu7H30PM6x
         JcJKLa2QgWyWV6n0DVH00kG7cT0Gw8+AQbqIOjRrzQAxRjlsOhPd42CNCuDzmmbGKXPK
         KqaXTIWTM9b69G/r2GzNXfA/h76zPVoULnIMdcSGIfUga/iMAAMqRTUsRTW2AXWp/x+d
         f+Bg==
X-Gm-Message-State: APjAAAXO8V/nAXS7NvsL+pNkjiJmf+RAKvWGmePEOjO6VVh/fYkOKLql
        aYQSXNG+KVSzeGunNAnX1Y/MdVGnj4Y=
X-Google-Smtp-Source: APXvYqzaZ77aKaSSj36ibN96Q9yNsvwo+qW66X4nW4ybznOo98v0U7iKvCbScbHqeUFy2/JaW0Wchw==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr31591588pff.94.1556088521295;
        Tue, 23 Apr 2019 23:48:41 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:48:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Tue, 23 Apr 2019 23:48:21 -0700
Message-Id: <20190424064830.18179-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct thermal_zone_device reference stored as sensor's private data
isn't really used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
 drivers/thermal/qoriq_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c3ed6ed81dfb..c041d1ae3500 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -65,7 +65,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		qdata->sensor[id]->id = id;
 		qdata->sensor[id]->qdata = qdata;
-		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
-				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
-		if (IS_ERR(qdata->sensor[id]->tzd)) {
-			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+
+		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+							   qdata->sensor[id],
+							   &tmu_tz_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return PTR_ERR(tzd);
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.20.1

