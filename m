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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C27C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726420850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8fHtasO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfDMI3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:29:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39574 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfDMI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so6281057pga.6;
        Sat, 13 Apr 2019 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IlSs5sCa3k+IzCgDt4GsO58Km3IKBuiTWLQ+G9cHQI=;
        b=Y8fHtasOI80D4jRTHB/51CfeYsFIVIXYuzJ+GleydQP8nAfzYwUnJw9R4w7Dh0uneh
         //fwTGtSD/CcnZy+iF+Xww+35jpNzOC4bO7XHtkHtMfWgWjbch482dQ5Rc+crj2hnh8d
         W1M22KUiw37Pns7sCmFLV9+CqQQ3Mo0ftYbuKJ/LlrUCfPsKgb7tRcejLPto6U9zBWhO
         1eEutDCWhZqotzaW2yop+eywWKFqyrsU7hrt6uXbd9wq3QzvFUKPbBwY4FYNcXwh/+B+
         0SeI95bTrLStxHgArT2DCgbjfWaldQZ9Zt60+QyJWA8XOYh3zXQiJ9ZYs9JS13IN8Z9e
         PGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IlSs5sCa3k+IzCgDt4GsO58Km3IKBuiTWLQ+G9cHQI=;
        b=Y4upJqocB5UjdjwM9XADI0sqN8c2xM31dMJ4xU/5aJbK+50ARozN8KR7UtimR9Ed38
         JFBhLcIE9T+xh29kR+Ej/U00q/lMUjxwxo/gDXX9yfdJr9lJzI31VM7KGNuebN2ooeme
         XFlW99JVZa1GZrDPQhgTL99NL3sj+9R8sDNgnHDX1DEKO5Sna05K18Kx0yIYQNoTByeo
         sZvey7B8mehKqOFxBPSlnuIxulLh2umGzCCYfWFl2oGAHWhnuE8jHVmNXT8QFU+c2ftx
         aP6mUxri2NnME3iRSqZ6mzILE65Uc0uLfsERc2kefJzC08wX72YyfkcVYMicNpUn8BIX
         2Mdg==
X-Gm-Message-State: APjAAAVng3/8WSNAHuRYAPgdSYBjd8RSv+uzQ05/gmVG2txwrrzkataG
        WWAiHSboxO+B0l1MUYrPgW+jTzdv
X-Google-Smtp-Source: APXvYqzinN9zQFs39+z+v8msgKTwNvCYpkgX0fg0tX9dFHE4s1WUrYBERlxIqus2HzzbiTKwQp9YwA==
X-Received: by 2002:a65:4048:: with SMTP id h8mr47152888pgp.6.1555144091560;
        Sat, 13 Apr 2019 01:28:11 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:10 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/12] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Sat, 13 Apr 2019 01:27:41 -0700
Message-Id: <20190413082748.29990-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a paltform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

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
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3500e238fe3e..3419505a2f0a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -95,15 +95,15 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp_id = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   qdata, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
@@ -198,7 +198,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.20.1

