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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2FB20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8hGsFz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfDAEOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37295 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbfDAEOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so857692ply.4;
        Sun, 31 Mar 2019 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yqkwRWnuRQ7Yq0VJ0b5LATX0eyC5/URdUuXpLhHz8sU=;
        b=t8hGsFz1sZdc1Pp1cNPhEG59oDn6QhgYmJsNCxlFX4WO1Rc0631Daf5ebOJwtz33+B
         AbPcZH6H+Tk0Wwp/kp5AqZIkzLBISfPHXpRM/n75N9REtImwcG4oxv7+rq9M5hhDNgOo
         pb2oXKEXUg4dVxDyWEB/W5m86FzGyois9PdWxd8UqCKBsjSHY3QVUTFllXA8KKu4fxAk
         oegmda+MXHzsOE9EuSf7zNbePtG/GyVwzW098AeuXKmVYe5PoesWrvLqTBF5/GTpZV+3
         u1O9mkLyL6F3FL2EVq9zO4VlTXvtquXmghvshMzV9DfxqGqQxgU9ICxRljszQH1WRhWL
         KpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yqkwRWnuRQ7Yq0VJ0b5LATX0eyC5/URdUuXpLhHz8sU=;
        b=jK1zNtZo3PfHIcfPjX3IDVQZhZlWXoAmzGxOphd6Zw0h0gCoQpr9PUcIsF2FtOfEb9
         cmgVIttmQPBmxkMdPOdm3iTvb8OggAcoJ/Dqs1smCdis/SnygicH5W+cqoMXcKsSVCTJ
         lhuTWw/GIB/B+iYjfSbgQqVeyuLsNJvx1ZJlYhGF8TF1JkWYm5TC6reYOXm38yGn+2bi
         uyQ9mwvnYF4MVAaSyogBq0tqeEe8AgMXbTy5ZVdR0vKsgkD0a5hatw2kYFZVDT2qRXe7
         6U+rm5tnhhFSbzDtTOullR/BdgbUlMd5aOA9FPYxAJQvQ9qjk/PtlbYJv86FmkMkYT8l
         4uYg==
X-Gm-Message-State: APjAAAX4lg8c20XNxLLuLMscBeBy/5AugCiT9M7WXtal7hi0Yhn0staH
        tCkrQ1UpBIFcWLgvfOprAj050Sz9
X-Google-Smtp-Source: APXvYqyGl2PKAdzx+9ZyJiVXPOE69JUsy1IxYhWI30NI3SLXA/MnHh67wCXJO2RhNKxHJFIBkwFoSQ==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr62564194plr.188.1554092087992;
        Sun, 31 Mar 2019 21:14:47 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:46 -0700 (PDT)
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
Subject: [PATCH v3 10/13] thermal: qoriq: Enable all sensors before registering them
Date:   Sun, 31 Mar 2019 21:14:15 -0700
Message-Id: <20190401041418.5999-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
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
Cc: Zhang Rui <rui.zhang@intel.com>
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
index a909acee4354..7ff93dfcd68b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -75,7 +76,10 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
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
@@ -85,21 +89,18 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   s, &tmu_tz_ops);
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

