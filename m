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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EC7213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu2SeBi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbfDAEOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37288 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfDAEOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so857598ply.4;
        Sun, 31 Mar 2019 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60TClwD6E8Gl/DfA5jhbFi9/SFspap9XKckHACFfOs8=;
        b=Gu2SeBi+Br+/1Ge1fDkvSZLfVbpPX3bVCIWisfYi4881JFHIIw7OEx5s8rHGGbRX4m
         CRpguldFkkr+gMl+x0IoRGLm+/BMEBfg1YckKph5xa5MG0obEbjSk7oSeDwabue4CVg4
         yTgi3gZKGWfJcFDw+lb5MOqFpam1iLbhKPMiXWGjdybZYy5f0GOBSBl+XuA7UUcafE7R
         1wMz43yXsojyE3wBzjTzkYMxaasyQOWvscWBecfKe6DpTC2UQ8H7fDmNz/J3uiRa6jd+
         BiG2bl8Jts/s1BsB+KgvO5Z8zGC700eFqKFQzfJbd3iOr2Qf7iYNnFt9kwsLLOItIYo8
         j2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60TClwD6E8Gl/DfA5jhbFi9/SFspap9XKckHACFfOs8=;
        b=S+5CXaivv6VidmY8bdzoib4lEGHGkdjjY651SbbyThXdKUmjG/lW8GSrSP5FMJ7OEo
         LGPkZXoQ2p8vU5smcvZfU04BqJkXOy8MxSXW+OXutip8EN+XSLAqF4u9nTUkJlKvhHU4
         s3Tx97I4HgmMgHoyIANOwBqg+2T4b/9MeE09qQgIR/Oi6hvToGKeQf6QbVPsDkfw2uMX
         Rc08NAlas2xxpH7eQDHJ0jSbjiVM4DwHl02Qv2OJKvvHAE32AfkIkjw3CukS3j+/swAy
         fuBiqByXCHs1rP0VHBkasVzvLNhDAwKenkEv1oStf2k4sGCwkK037BX2a0wU/yVSgIPs
         jHtQ==
X-Gm-Message-State: APjAAAWvaQFYuZohYlaqQ6FPHBF3sBsMLAKfOL882covvWAtUuiRKxJP
        sebY96vjTfoOWg5FvLDvDzTDbnLE
X-Google-Smtp-Source: APXvYqz2WPTrTz5LzHfiHAik9aMFf0VTvDhqRCOimSXB18NEmjgw9opArNbv5yxvG06u42CoyEfR6A==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr62039173plv.157.1554092082244;
        Sun, 31 Mar 2019 21:14:42 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:41 -0700 (PDT)
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
Subject: [PATCH v3 06/13] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Sun, 31 Mar 2019 21:14:11 -0700
Message-Id: <20190401041418.5999-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index deb5cb6a0baf..24a2a57f61c9 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		s->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   s, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
@@ -215,7 +215,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.20.1

