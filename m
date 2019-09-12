Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8FC49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436C720872
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 01:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcAihO1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfILBfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 21:35:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43005 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfILBfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 21:35:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id g6so366670plj.9;
        Wed, 11 Sep 2019 18:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFSJfi3ZJCYXJKXtfe/e03Q38MolntauiwlSEHO3ZX0=;
        b=EcAihO1qWRSofOzVvvWF296PjLO9/ngsnRkOVeTv1AuMifMeI+8d6w5zADnBnPZLvQ
         cY4/c+MMb24yGJTRq6Zlq9Kw0OzyxpF6gHx1mrvV/vrh0SUUTIFeVhUaujHpXAQ4sr8h
         v+gJlpK4HyIj/JwSi2jPXWldVDKKOkc1KxcnXijyNov7V7Mt7/xaKnhlbECx2Rkj88x5
         Zre1iXYZw+VMpE7a8oQEBhmHU+w1LrCH3BGyYJvmINRixof8ujV9jkUUgZWbimM0R6bk
         d98Ck4hKq0Gme3NMqf+L3e/AKT7Vy1/dPa4M2eBR8LPuo4461qKZY5U5tBUnijNk7/Dd
         Wx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFSJfi3ZJCYXJKXtfe/e03Q38MolntauiwlSEHO3ZX0=;
        b=G2Im7PJA051lfp29PNmsgMWEZ/qRd+5UioLQ1VlSJF4D2i/uU12Z0HN4DNhR/gCoQq
         Y2bbDChPjfRCgz77VmnPf66UVJYsgpF4GxUhnXIUwbvOHiTmR8pSV54I04CfMdfuXPWm
         Fmp0YvVGqyiLjmkmbRPGvTuxooBFXJRHa2RoTsK9PNx7BxTO7nVs2RgO5PmnVQ18DUt2
         wYijSkuN0KjdNyneY7XRyCMxKWs5O56Q8V1kbIxKSx740NMC3ZLvWbHzl4XchFmzWA5O
         al+dAXV7DSNcAKLwj0RQB9mDO1hirIgvWtL/7CQidC0iVf0t8LbjrfMXYll20ToDXt0n
         abQQ==
X-Gm-Message-State: APjAAAWscxLkfcoy2wbVDzbLCCWBq20xfKKsOKOzQVdfagkroe0ReFpC
        lZ5spq8zzI4QqBBFoyJ40j4g8qza19w=
X-Google-Smtp-Source: APXvYqw9/YRrLAhRhYRXGSmkXfw5lt9ho74SUnC71ljTA6ZDuKvZeZ2DurYfoZGyn+B36TAzzkvM/g==
X-Received: by 2002:a17:902:9684:: with SMTP id n4mr9751094plp.266.1568252100474;
        Wed, 11 Sep 2019 18:35:00 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b126sm35248236pfa.177.2019.09.11.18.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 18:34:59 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Wed, 11 Sep 2019 18:34:44 -0700
Message-Id: <20190912013447.2977-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912013447.2977-1-andrew.smirnov@gmail.com>
References: <20190912012920.29601-1-andrew.smirnov@gmail.com>
 <20190912013447.2977-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tmu_get_temp will get called as a part of sensor registration via
devm_thermal_zone_of_sensor_register(). To prevent it from retruning
bogus data we need to enable sensor monitoring before that. Looking at
the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
enabling them all, so, for the sake of simplicity, change the code to
do just that.

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
 drivers/thermal/qoriq_thermal.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 32bf5ed57f5c..1cc53a4a5c47 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -24,6 +24,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -77,7 +78,10 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id, sites = 0;
+	int id;
+
+	regmap_write(qdata->regmap, REGS_TMR,
+		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
@@ -93,18 +97,12 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		if (ret) {
 			if (ret == -ENODEV)
 				continue;
-			else
-				return ret;
-		}
 
-		sites |= 0x1 << (15 - id);
+			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+			return ret;
+		}
 	}
 
-	/* Enable monitoring */
-	if (sites != 0)
-		regmap_write(qdata->regmap, REGS_TMR,
-			     sites | TMR_ME | TMR_ALPF);
-
 	return 0;
 }
 
-- 
2.21.0

