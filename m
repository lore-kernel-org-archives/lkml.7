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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E9C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4F218D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6UMSAM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDMI2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfDMI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so6246949pfo.5;
        Sat, 13 Apr 2019 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i23+oyBgEnXB9qRq+mm3/3KuLAYqITPcLrHTT0eBkK4=;
        b=a6UMSAM6IZ1Jwtu3fFmUlSxvbOYNpjBOxgMFxIbQg+MFsUP6y9csAR4Opb7bx08011
         8f2jwshad/s4lECcglUWC7GT4plQn5ll6eH313BPfQ5LDUMolpULiJx2qLwhp4AhwCQv
         9hNm2SVACXXVG4SdNussjRekBGn8kThAM5AC5umoy6ukZiwby39Bj/TFEmO8dkxDfVSJ
         A0sjBYBbe9QrQ5VNmKXrvI8ghO7gbc54XR8K4t2LmnSAeT77QNyy9YzNenrrr0xt22zA
         fwSQfUg04Kj13TzV3nQTcNiPHHeg90AlOUn+mqh4f4v4hpFIJd97TjUHZ/bccCbHez0Z
         SMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i23+oyBgEnXB9qRq+mm3/3KuLAYqITPcLrHTT0eBkK4=;
        b=nZ93r88BVuUzzoKkDHB/wW83qX3lL6I4ZOU16gsIFAYi4mmnvX+VQDdiOaiGdCeNgx
         tblTcNAh7e2NuaP+efndKS/3MTjxt9alEkh2F63OHVXvXmcH/qDDZoC0CTWTpRCSelpr
         VXysZldEKua1d9jgBwjIctag2FBqYcjsdmSEYjrYi2jo4FkGqwH9ky3RSqzQ2gIhLTz2
         NQ93+sbph8NwqLI+mWg+bx56VUUwtq4Pq6Bw1YUXN8fq2dVBHj5/+4xgWk8mrsNiGvEc
         hHa80mmnI7re2j94QLkGHMYX08m+xEZ0Qot/jZkDwZOF06wGpKp1mIGXrYoEWa0zHyeO
         O4PQ==
X-Gm-Message-State: APjAAAVqMgrqDlvAwef3RMGO/L33HPGR+H2x38Knao24Ka+aSq2jeO4G
        uOuDN5xkEMtGD5K2FMsoXdq9n2sy
X-Google-Smtp-Source: APXvYqzt6+UZ4YN+Y2WMXaFTJ7g5XJlXxthGjIf2OL0UMXHpo/ERjVEYVYKBXewxrG17urRSbypUyQ==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr58046205pgb.302.1555144096688;
        Sat, 13 Apr 2019 01:28:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:15 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Sat, 13 Apr 2019 01:27:45 -0700
Message-Id: <20190413082748.29990-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9774323a17bf..abbbfe88422e 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -61,28 +62,28 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id, sites = 0;
+	int id, ret;
+
+	regmap_write(qdata->regmap, REGS_TMR,
+		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
 
 		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   qdata, &tmu_tz_ops);
-		if (IS_ERR(tzd)) {
-			if (PTR_ERR(tzd) == -ENODEV)
-				continue;
-			else
-				return PTR_ERR(tzd);
+		ret = PTR_ERR_OR_ZERO(tzd);
+		switch (ret) {
+		case -ENODEV:
+			continue;
+		case 0:
+			break;
+		default:
+			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+			return ret;
 		}
-
-		sites |= 0x1 << (15 - id);
 	}
 
-	/* Enable monitoring */
-	if (sites != 0)
-		regmap_write(qdata->regmap, REGS_TMR,
-			     sites | TMR_ME | TMR_ALPF);
-
 	return 0;
 }
 
-- 
2.20.1

