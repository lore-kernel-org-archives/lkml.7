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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D48C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E976213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBbAtGpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfDAEOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34541 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfDAEOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so3876358pfd.1;
        Sun, 31 Mar 2019 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhTqVnSchDOT1KawwaBFkLaXTS5wVmw5iYBOs+60wPw=;
        b=KBbAtGpHhd8sC17zkp+sl7XZUe2zil6zXxfd7Nmi+Y5TdGjCc0RbYt0HwVfTrnQLfT
         6OZAFm9SeS0RlK5W1ZY6MEYeNyUdhdTXaj40CtQaSWmyBXp3/gyDcb1TqthFL5R/0mXk
         LqFaMCfOUKOpBooAEmGVrEZ4Vz0+9Igh/M0jNAGIzd5l6saT3qS5EzXBmxwP4mMptW4Z
         S+MILBONCtFNoKNK9Q6G2XlWtqXZIpvaU1PNIjaki5MAh2i2XlbEvTm28R58Z0mSeaBr
         wP8QKGdNsSdAt50GtfdJMNRUQlj27ZEpJzknTeZQnTxtKTZ8xVepFt3YUWNtbEmI6oTx
         dfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhTqVnSchDOT1KawwaBFkLaXTS5wVmw5iYBOs+60wPw=;
        b=Q8cNI3+n7dDjYNSWjCl0lUW0UAxX4fosupZ0aI1xgQl6+8ygdostAjrn/vXRZ2c7Cm
         jhNcklCW1DuQtbZF3noathvoLMB4j/nCQXJvnpAwS67i3E+/JlF9egRZBvdAtcT59SdZ
         jKmio6Ds2zUF+n3hlGS7g6dHKdV9vUFgwYbTj9x05ny7Yrh09bl6Whs6foN+hLuyw5KL
         BDJGxerhWVZvHNi6ox6QIUHtDmY+E0FI/rw65xthn+qVdeX40yqpwnUYIVfT9YstqsDd
         E3XX6zSd1PXB6gbC05aEn3yVixRKD52JSWlO/i6nfQ+KJHqf0wEIGXKyKKw1vZ7rpTVI
         iYIw==
X-Gm-Message-State: APjAAAWCLiWh8KDKA8j54DVwZuP2iILoaS99PAyrsrCG75nvfSl0gL3m
        +czz9T3u78aF9DcRVjEn0tjNJnZM
X-Google-Smtp-Source: APXvYqzha1xcdnfCtBiqd212zbouQ2GwZ/u/AjHuZNpjTnicNejBDPdbNs5ujDR+zd0nl/LrGhZh2w==
X-Received: by 2002:a62:4ecb:: with SMTP id c194mr31616974pfb.254.1554092079459;
        Sun, 31 Mar 2019 21:14:39 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:38 -0700 (PDT)
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
Subject: [PATCH v3 04/13] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Sun, 31 Mar 2019 21:14:09 -0700
Message-Id: <20190401041418.5999-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
for brevity.

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
 drivers/thermal/qoriq_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 6d40b9788266..e281bdcfa11f 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
+		struct qoriq_sensor *s;
 
-		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
+		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
 			return -ENOMEM;
 
-		qdata->sensor[id]->id = id;
-		qdata->sensor[id]->qdata = qdata;
+		s->id = id;
+		s->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-							   qdata->sensor[id],
-							   &tmu_tz_ops);
+							   s, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
-- 
2.20.1

