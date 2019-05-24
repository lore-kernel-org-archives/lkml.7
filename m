Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327E21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="uN1RsIo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbfEXKDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:03:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33248 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389745AbfEXKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:03:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so4816992pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYimUrGOBy8Z7FWpgXX8R6HaR0HMIEOPhzq62MNghAI=;
        b=uN1RsIo2wkVIwEIR05cxOaaAn99vFBWzP/x8T7BSmEncapE16Ll2xRg04M2qvH81Q9
         rxq08ociUC6b95KEj3JYEUBS6Pgnfa/LoCN/Ua3udgTQD2wp5i6NRzAXPqB46QLifVNz
         kpCXVFN4vN6L3UR2oc5ERHooQcAgex72s3O4YdH51P9D+nzEMIEnQbbPdAkRhZHzbeR4
         sgtY9hA7teLHGqSRExLyTaXKqW7YSZ18k4iOwyBU3XWPOSTqK9cNtKnR90LeW+W78eFu
         jfIrMRL2Uw/iWf+oudTIKdRmuheRbXXGvfY9qe8vXwk7PZ2YbHGl9tZmEvokkTH5FJ9p
         gnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYimUrGOBy8Z7FWpgXX8R6HaR0HMIEOPhzq62MNghAI=;
        b=d0FgKmh90+M0wamSZpnl1GpVDpTdZLhq/9WAtBV90bT87Y5wTWX6xPP4kuS7xoR7iC
         HmQGMw9az60FbUDrBBREfq93q/cYxl+Cuo+8onFAukk4jidpc7GDqDO233HRsF2uw5+m
         +D6gpAmBOaXQHqTL3GvaN/MNMb/UAGPxAbN9PPc8Q7tRU4RcFdZ37TG3AGoO0Y64Yu5J
         VZK/oGx5sLm/0E8EpxGX8kR+O51ghcmvfKKGT5bGNzf+73LsYpOgGjZ0M/vHfEJAuKKJ
         RATd2DJBPVdFx/0NTP7cw5RnxxspC0lQ4LIdJ4jM8FxL8nbMPsr2OtojeD6V2pi9W5RP
         hbfg==
X-Gm-Message-State: APjAAAUEA1DikZHcMbgjLxve3EA6c0ZwiERf8uTrAbEvIW+2WsGUwth5
        ITAGJ9N1bIZ8R9dFF3yclUifWg==
X-Google-Smtp-Source: APXvYqzW6m9G5GJmEftoBG2GVxPNQCx5waxrmyGk7m4+zYSLpSsl/s29CFGMF+Fh9NFGWuy2ZyPyzg==
X-Received: by 2002:a17:90b:14e:: with SMTP id em14mr7951719pjb.19.1558692192923;
        Fri, 24 May 2019 03:03:12 -0700 (PDT)
Received: from localhost.localdomain (36-239-208-165.dynamic-ip.hinet.net. [36.239.208.165])
        by smtp.gmail.com with ESMTPSA id f29sm3126700pfq.11.2019.05.24.03.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:03:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Eric Jeong <eric.jeong.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: slg51000: Remove unneeded regl_pdata from struct slg51000
Date:   Fri, 24 May 2019 18:02:47 +0800
Message-Id: <20190524100247.7267-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524100247.7267-1-axel.lin@ingics.com>
References: <20190524100247.7267-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use a local variable *ena_gpiod in slg51000_of_parse_cb instead.
With this change, the struct slg51000_pdata can be removed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/slg51000-regulator.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index a06a18f220e0..04b732991d69 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -35,14 +35,9 @@ enum slg51000_regulators {
 	SLG51000_MAX_REGULATORS,
 };
 
-struct slg51000_pdata {
-	struct gpio_desc *ena_gpiod;
-};
-
 struct slg51000 {
 	struct device *dev;
 	struct regmap *regmap;
-	struct slg51000_pdata regl_pdata[SLG51000_MAX_REGULATORS];
 	struct regulator_desc *rdesc[SLG51000_MAX_REGULATORS];
 	struct regulator_dev *rdev[SLG51000_MAX_REGULATORS];
 	struct gpio_desc *cs_gpiod;
@@ -204,14 +199,14 @@ static int slg51000_of_parse_cb(struct device_node *np,
 				struct regulator_config *config)
 {
 	struct slg51000 *chip = config->driver_data;
-	struct slg51000_pdata *rpdata = &chip->regl_pdata[desc->id];
+	struct gpio_desc *ena_gpiod;
 	enum gpiod_flags gflags = GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
 
-	rpdata->ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
-							"enable-gpios", 0,
-							gflags, "gpio-en-ldo");
-	if (rpdata->ena_gpiod) {
-		config->ena_gpiod = rpdata->ena_gpiod;
+	ena_gpiod = devm_gpiod_get_from_of_node(chip->dev, np,
+						"enable-gpios", 0,
+						gflags, "gpio-en-ldo");
+	if (ena_gpiod) {
+		config->ena_gpiod = ena_gpiod;
 		devm_gpiod_unhinge(chip->dev, config->ena_gpiod);
 	}
 
-- 
2.20.1

