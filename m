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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DC3C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED720850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRVDuWZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDMI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37648 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfDMI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so6290698pgc.4;
        Sat, 13 Apr 2019 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6SN3nX4S9vp1GlMD+l/YmLqa1bxpAZGh6pSi3V7e68=;
        b=LRVDuWZI38MFME3WNImVpwsE2LmJmla8j5hdINI6k/Yp/m6a5w7OK9tQvApL9xmgD7
         IwmC19jjI8Nof2t9pE39a9rXee/EMQLz+/K0A5k1fH+L4xz7JbRVw38jkfmtBzCRlx7o
         a2JSEPfkxLNVzDklQ9XRBfBt3jY/UpdoBNe+zMpvdbIREe8lniEvwEaxF2AIDwVSTJ9q
         Q4J2v5sEE4rJTLKlfnVCs5pTDJJgUTIS6NEc+eie+3ODOFI2WXKf2IwY5i18TGgP95vt
         NxhqzwBqDf9AchmmAY5QD5c9Yp+WDN8NiuBqNV+yDHBI+9J+/YSMbt1YR12TzXPgX2ej
         0gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6SN3nX4S9vp1GlMD+l/YmLqa1bxpAZGh6pSi3V7e68=;
        b=rY4dFbW3NTGHsdLTKrFi+9cG1poeP5QIEaa2fGK0cYlXuWF8SJta+KDd1SLnx+YQwd
         CS4je8TAkT6TTpLqD1MLtUJimthhIPfqhtk6MlQHGz736OdJ9Fk1KdcFQISrwJKJQAsR
         VjZncqdqLrwYOjOdMeuxWVX46G4MCCP8QqWLhRAhaTYIRUZONeTDQKdbNIawVvNtFY1u
         4m1cXhr+WeG3hCpJLqm+6M98+PxUiT5cVaQlSz+mr6S5t6os4WkHqFMv8ItERp3Adrs5
         0eLsXZbVkkb0tyc2a8eoHPRgl5fyqz3jMmjHguQRkQSoQNf498T+yJ5MX5uKgc4HySEy
         t6bw==
X-Gm-Message-State: APjAAAVIFnembTHCn7JkmQnSyH/Q3Ks/MKtIXQ4haI1SB2fMg55LxdPj
        +tbo6calsaNWUhezBczAewn19yFd
X-Google-Smtp-Source: APXvYqytoI1JYi6HoTSaIHvcmyqcl9fuBkRRQsYZfUJEyYsMHzFAjbSmHzv2oWFP9plHi2+Vot0owg==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr61884998pfn.31.1555144088691;
        Sat, 13 Apr 2019 01:28:08 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/12] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Sat, 13 Apr 2019 01:27:39 -0700
Message-Id: <20190413082748.29990-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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

