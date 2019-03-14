Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1149C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09E720693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="WfYdosfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCNLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:55:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37835 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfCNLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:55:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so245658pfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9wM1Yn3UiXh+JDJYuFE+iMNyZ5Ql1vKhmKfpYHLQycw=;
        b=WfYdosfMVaKzV2pux6wbMHCwD0/ic7MV1cbR75LOub5sARQ/a5/8RQPmHrUQWCYwyA
         vLX3wlE+FXj09ZD95+gco79kaZN6KsFCW2fDXXdktiEH+hq5OXm3tWunxltKqbnWg775
         RlkyrL7I13vRX6k3IOGo9D5bsLgDtroMFPhK2IwXeUglCJZmJHD0Xc7qJEfh7oBzfMwE
         6ppF1Bvjy5s+or2brkdN2dAjvxZ+PfDug0qMklDV5tESPHI87PsqodzAx48OoFv9YRVl
         wjiDlFwaBAdxzeH7eUZGpp0Ie58fzVqZzcPik9UMTpuaRpwEFSifNW0RW2ffMvLv3qvI
         bfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9wM1Yn3UiXh+JDJYuFE+iMNyZ5Ql1vKhmKfpYHLQycw=;
        b=LM/fxAjLwRCDXKNl1BvGNj+OqiQN3cV7NKMp6XbzSHPqqoSXTDl4sTcphApYQYKOIb
         2Zxniy2vVMdhnj4fT+tOkaw7N/x4R2PkzJLEea3I50q2G0DvgPv41gh4uE9Dxbyqt93Q
         f1PytO8Qyw602TBQQTu6IyXNrLEOZLZJy+KelfZRuR5Ceou3Izx5KeuzFj5DZe3RTcpn
         aqHZyuQI5SNzzvgYdoAAdVsp3mTV/wHz9sq1qdPs4wxPAt0pfwjAAWp6qvXQxNk1pAwA
         2bWjRpYx6iJiS9bBdrFkoKgCcj/6etoGIM7KcYTq/kuQ1rYKy9ltB8Kk0g3ekW6RzRB/
         J79Q==
X-Gm-Message-State: APjAAAWqRbdf2Ymz9afUopybGPVNDyGxqKbNiYvv28V3xIfvjg4ZDgWZ
        FgkXc8tyNQOsR/XKOntMRXQx2g==
X-Google-Smtp-Source: APXvYqwV3NZcAaAvFtSrUmNn5tU3/B4gzLdBZMECSZo769sm7/LFr5XlLoSQuOCykyW7pcfXNpEHOw==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr45185524pgv.416.1552564531741;
        Thu, 14 Mar 2019 04:55:31 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-125.dynamic-ip.hinet.net. [36.239.209.125])
        by smtp.gmail.com with ESMTPSA id p63sm9841484pfb.4.2019.03.14.04.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:55:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vaibhav Hiremath <vaibhav.hiremath@linaro.org>,
        Yi Zhang <yizhang@marvell.com>,
        Chao Xie <chao.xie@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: 88pm800: Get rid of struct pm800_regulators
Date:   Thu, 14 Mar 2019 19:55:19 +0800
Message-Id: <20190314115519.7689-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct pm800_regulators only has 2 members: *chip and *map.
The pm800_data->chip is not used. The pm800_data->map is not necessary.
Thus remove the struct pm800_regulators.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/88pm800.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
index 89bbd6e8bad1..9fd379732d18 100644
--- a/drivers/regulator/88pm800.c
+++ b/drivers/regulator/88pm800.c
@@ -77,11 +77,6 @@ struct pm800_regulator_info {
 	int max_ua;
 };
 
-struct pm800_regulators {
-	struct pm80x_chip *chip;
-	struct regmap *map;
-};
-
 /*
  * vreg - the buck regs string.
  * ereg - the string for the enable register.
@@ -235,7 +230,6 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 {
 	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
 	struct pm80x_platform_data *pdata = dev_get_platdata(pdev->dev.parent);
-	struct pm800_regulators *pm800_data;
 	struct regulator_config config = { };
 	struct regulator_init_data *init_data;
 	int i, ret;
@@ -252,18 +246,8 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	pm800_data = devm_kzalloc(&pdev->dev, sizeof(*pm800_data),
-					GFP_KERNEL);
-	if (!pm800_data)
-		return -ENOMEM;
-
-	pm800_data->map = chip->subchip->regmap_power;
-	pm800_data->chip = chip;
-
-	platform_set_drvdata(pdev, pm800_data);
-
 	config.dev = chip->dev;
-	config.regmap = pm800_data->map;
+	config.regmap = chip->subchip->regmap_power;
 	for (i = 0; i < PM800_ID_RG_MAX; i++) {
 		struct regulator_dev *regulator;
 
-- 
2.17.1

