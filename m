Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1EAC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 03:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA23214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 03:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Nx5VD1xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfIHDzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 23:55:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39285 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfIHDzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 23:55:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so4998589plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jljIIyAxCHxfSTikpTEvJGUX0bCUYZlkCKTu7DSTE6U=;
        b=Nx5VD1xK8hbxrVE7cI9oGnidtGTfB753yAbOvW+3U98smXbwwEee7gjXb7/zbw6N0j
         guFclXcjzgXW1XBuZz+MExbHq5/29G6u1E2J58wuKXQwgKcogTjIzCdV1ynnEb4FOtPw
         M7df3v+500Igv403XJCcmR2Svh5tccepefodLxGcV2NRbOJJvBOJt/WpXy25BsKBamkv
         qpeeTEk081RUDNoL1bQJlvzgsT2Pv7HeKQXj8Kaf0bffd+fnx01grTUc4mvs32hvm9U9
         W12NFQbYNyTj8biYOYWKxsuBaZ760piCj2QMdJafE4Lf9ueeil2vyVslDQ4zVA/MzKRd
         gKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jljIIyAxCHxfSTikpTEvJGUX0bCUYZlkCKTu7DSTE6U=;
        b=jTohG6BiyYVrfAeCDqxXjlAb2vWs2GEca9d2MZ9L+jJTQef4Nt21ghavOZb3qRCZ1N
         RPUj1ebBAT2Nn7bRSJY3PyZUgbUAY5FupvoK24acMKZOAAGzJjGE47kj7NrmZXwUSxd6
         l9H+2P4H7psggjBg6zt7UP+ogI1Sy76K0hkqHHT/TgXjLUK+RA/+f80uMGBvMlql7kjO
         tSEpLt/c0v7Nx1b+IJCIZZ7vzLMt/km25EmN/qhpWkw0+z4X2yA0AunWvIp5vCvTy+Ng
         9RQgCN4TRrcAR7U/qtiEbQ5k0sXxtxwmtMZ6z/fSRRsxtFWx3ytaX92tECj7CViOpaFJ
         LnUg==
X-Gm-Message-State: APjAAAUuchPaxx79KyCBaT3s0gX72qQLnusJ7lMmqGWP3/WWChlG9tVJ
        uc+a89eoUDPbsaDhcH0ezEyuWg==
X-Google-Smtp-Source: APXvYqzBcj2SXDtDqH9k1CkSN0OHaXrNU6hZ9tIJbkdrOh39C8TScw/5fl1txTK3onXMuxwZFUJYwg==
X-Received: by 2002:a17:902:9f8c:: with SMTP id g12mr6348347plq.326.1567914916822;
        Sat, 07 Sep 2019 20:55:16 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id j9sm10634657pfi.128.2019.09.07.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 20:55:16 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: Simplify lp87565_buck_set_ramp_delay
Date:   Sun,  8 Sep 2019 11:55:06 +0800
Message-Id: <20190908035506.17611-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rdev->regmap/&rdev->dev instead of lp87565->regmap/lp87565->dev.
In additional, the lp87565->dev actually is the parent mfd device,
so the dev_err message is misleading here with lp87565->dev.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp87565-regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 0c440c5e2832..4ae12ac1f4c6 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -65,7 +65,6 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 				       int ramp_delay)
 {
 	int id = rdev_get_id(rdev);
-	struct lp87565 *lp87565 = rdev_get_drvdata(rdev);
 	unsigned int reg;
 	int ret;
 
@@ -86,11 +85,11 @@ static int lp87565_buck_set_ramp_delay(struct regulator_dev *rdev,
 	else
 		reg = 0;
 
-	ret = regmap_update_bits(lp87565->regmap, regulators[id].ctrl2_reg,
+	ret = regmap_update_bits(rdev->regmap, regulators[id].ctrl2_reg,
 				 LP87565_BUCK_CTRL_2_SLEW_RATE,
 				 reg << __ffs(LP87565_BUCK_CTRL_2_SLEW_RATE));
 	if (ret) {
-		dev_err(lp87565->dev, "SLEW RATE write failed: %d\n", ret);
+		dev_err(&rdev->dev, "SLEW RATE write failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

