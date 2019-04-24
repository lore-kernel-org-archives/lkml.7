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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2514C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACA620656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjZYiqT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfDXGt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36102 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfDXGtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so8792216plb.3;
        Tue, 23 Apr 2019 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7dKqeMctMgCtn11qBOW/p6BHRdJ5DhcJYKhYg4aTPE=;
        b=ZjZYiqT+Gv7WEg9u3S43bSguaBqxBIgoO8Gac+1R6Cwm9mdQaozHo/MwY5Ml1L1v82
         fo2aTWp1HEEtOd6/vn7vd80ATDHMCCnfoSwo8iNtdXk79EbJbjDeeXjTbbK7Df+6AKKa
         lZG2oT9N2qsWY40xTyRqPpYHCZJNbmKvTkHsWZq0s194WLwQcYMUYpGlkDrrtgEX0a9g
         YbXmWDrisglFJ8U2g4s1UIsswFE90i0vZD6WWMJAq6Q5SxCZB8OAKKUJ6fkwaoxRtnTm
         QqOc2TbYqQWqYgzKGasiebNvLhtRYS51GF1wUK3QPtH/i3c6dtFppt5hAZMUYaQBy9rg
         UbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7dKqeMctMgCtn11qBOW/p6BHRdJ5DhcJYKhYg4aTPE=;
        b=khPDBYCjayR1dN+Mj9yqU6rvOdBv/SrLlu4Nx6O9aoAlscSasnpYemK/Vjs0DqxAGj
         dTS1CK6Sv36pv60XTMnLwhcr6Y0f9J6A8eT0Tc0tzw9bFiS4faVr4zwK7kbMPDHQzSYg
         Ws4FuWQFjqQ2GXGu+rolvMq4p3PJ+DwZFOBgpE8vzJLKw1qUON5ZbFD82NWXKd9axGSG
         E1NzdJ/YYyXW1g/yK2zmtILXLwpGGSz/Fg964pyHRuEkFWOAXKWAlU3pDc7IsqX5fcQ9
         51sWd5eKd0IK6aI+vEwAGXJCO/4h5Gs5hMvbK6rg57JMne4u2H58VoynIBEpsRaNCxf6
         IR9Q==
X-Gm-Message-State: APjAAAXYyi/4qyrzyvliqMd8Vg0TxKSUcyok6WBkTR7ipw+JeRT0W6K5
        LtlSfAfMSXciktPscIAVXyUBBl+fLn8=
X-Google-Smtp-Source: APXvYqzwlh5npk9Ah0bYThzGVk7Ypdg823LvaucPbLRCAyYmjWPdB3catRhouzU7zxJI42OFm1d/Lg==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr29516884plo.32.1556088560704;
        Tue, 23 Apr 2019 23:49:20 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/12] thermal: qoriq: Enable all sensors before registering them
Date:   Tue, 23 Apr 2019 23:48:27 -0700
Message-Id: <20190424064830.18179-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9774323a17bf..d8d9f567a632 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -61,28 +62,26 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
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
+		ret = PTR_ERR_OR_ZERO(tzd);
+		if (ret) {
+			if (ret == -ENODEV)
 				continue;
-			else
-				return PTR_ERR(tzd);
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
2.20.1

