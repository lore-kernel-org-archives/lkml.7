Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FCC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBB924680
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC69QMes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLFHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:52:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44784 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfLFHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:52:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id bh2so1253041plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/nVMSvIlBe6KxhL/GKB+x3grLOZijuR5eaAuvD4Z3g=;
        b=aC69QMes8d8Y60ab+b/nr3pzwc2OcICzdEZglBU4tCczyIBnlwC8/SwivcCPU7/Uip
         LeiwmwTcApgtDTxCZ9H3fNcVUu13E9gqNXArnFg2vUJ9j23Hi7Qq5Zq1nH++ujGKtffq
         ST4kpRiBvj2umUUpHSvu0jBLwKgmZgCkjmlsed5wiZMk9xmLNr62LAFZkl3HgMzE5mCd
         +Q7IYGw4vAU1WpdzK1RCdZCSoZZ3URWnBrZ8K+mACqQaoburreR/oswT0ldlenbZe0h1
         VNl3U5hF/KG/FZmlsnkICnC115+m53L/3vwY4eorv/aIVL19fE4dim6omGwfH/UoA7HI
         lUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/nVMSvIlBe6KxhL/GKB+x3grLOZijuR5eaAuvD4Z3g=;
        b=pZsAy3fvGvZBRQG5U8ikFSJf3maT7aDX4X3XKXLFWuYRlJjMN+alpSVabA98OWfAS8
         h7CwFU6WoYybYaiW8TOGBZsp8+BhuG//6oU5BHJ/RAMxxkMsao2KUyFZa1REfzB55B1r
         J12uMYNZV4sOKdcxIa0M+BUHyF6ls2t3eDP7XyTAtC4rSBfwBLmUz9/Xx0Jk6InA00oe
         GhGb8QVrK+OOWaR10YCwmUKNT7DHlOlQhQbsNgLccA0gffL0yaU+oFdSFkRPYj9cyUOD
         0ZexVHx6HL+X0bnAWENgSbi6KnO3Uco9kYw0JPE14g8KxH/Th39qdKgg7GKTh4p8aebv
         TEiA==
X-Gm-Message-State: APjAAAW+a6fprCuXZOLO2+b1QZvThX2VCG5UwHDDCK2Ua7x/8ZQPYY52
        kxUy7fId81BPv4MojZtveBk=
X-Google-Smtp-Source: APXvYqxMyuR+T1yV865sqEMXS9IDUST5vK00nDZONJTWjFfaGJUHCgtS3FvbuE1jXuMDmVFJd9xWcw==
X-Received: by 2002:a17:902:fe03:: with SMTP id g3mr13652599plj.1.1575618744043;
        Thu, 05 Dec 2019 23:52:24 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y199sm16009412pfb.137.2019.12.05.23.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:52:23 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in remove and fix probe failure
Date:   Fri,  6 Dec 2019 15:52:09 +0800
Message-Id: <20191206075209.18068-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call regulator_bulk_disable() in remove like that
in probe failure.
Besides, some failed branches in probe do not handle failure correctly.
Add the missed call and revise wrong direct returns to fix it.

Fixes: 2c394ca79604b ("ASoC: Add support for CS42L42 codec")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/cs42l42.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 5125bb9b37b5..96b3cff50ce9 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1796,8 +1796,10 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	/* Reset the Device */
 	cs42l42->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
 		"reset", GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l42->reset_gpio))
-		return PTR_ERR(cs42l42->reset_gpio);
+	if (IS_ERR(cs42l42->reset_gpio)) {
+		ret = PTR_ERR(cs42l42->reset_gpio);
+		goto err_disable;
+	}
 
 	if (cs42l42->reset_gpio) {
 		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
@@ -1831,13 +1833,13 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"CS42L42 Device ID (%X). Expected %X\n",
 			devid, CS42L42_CHIP_ID);
-		return ret;
+		goto err_disable;
 	}
 
 	ret = regmap_read(cs42l42->regmap, CS42L42_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		return ret;
+		goto err_disable;
 	}
 
 	dev_info(&i2c_client->dev,
@@ -1863,7 +1865,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	if (i2c_client->dev.of_node) {
 		ret = cs42l42_handle_device_data(i2c_client, cs42l42);
 		if (ret != 0)
-			return ret;
+			goto err_disable;
 	}
 
 	/* Setup headset detection */
@@ -1892,6 +1894,8 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
+				cs42l42->supplies);
 	return 0;
 }
 
-- 
2.24.0

