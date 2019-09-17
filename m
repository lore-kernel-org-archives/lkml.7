Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20B8C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F23521852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfIQPk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:40:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47103 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfIQPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:40:28 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaZ-0003Zb-HU; Tue, 17 Sep 2019 17:40:23 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAFaY-0003yg-GN; Tue, 17 Sep 2019 17:40:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     zhang.chunyan@linaro.org, dianders@chromium.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        ckeepax@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] regulator: core: make regulator_register() EPROBE_DEFER aware
Date:   Tue, 17 Sep 2019 17:40:21 +0200
Message-Id: <20190917154021.14693-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917154021.14693-1-m.felsch@pengutronix.de>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it can happen that the regulator_of_get_init_data() can't
retrieve the config due to a not probed device the regulator depends on.
Fix that by checking the return value of of_parse_cb() and return
EPROBE_DEFER in such cases.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/regulator/core.c         | 13 +++++++++++++
 drivers/regulator/of_regulator.c | 19 ++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f9444f509440..e8e145c2a5df 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5047,6 +5047,19 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
+
+	/*
+	 * Sometimes not all resources are probed already so we need to take
+	 * that into account. This happens most the time if the ena_gpiod comes
+	 * from a gpio extender or something else.
+	 */
+	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
+		kfree(config);
+		kfree(rdev);
+		ret = -EPROBE_DEFER;
+		goto rinse;
+	}
+
 	/*
 	 * We need to keep track of any GPIO descriptor coming from the
 	 * device tree until we have handled it over to the core. If the
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 38dd06fbab38..ef7198b76e50 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -445,11 +445,20 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		goto error;
 	}
 
-	if (desc->of_parse_cb && desc->of_parse_cb(child, desc, config)) {
-		dev_err(dev,
-			"driver callback failed to parse DT for regulator %pOFn\n",
-			child);
-		goto error;
+	if (desc->of_parse_cb) {
+		int ret;
+
+		ret = desc->of_parse_cb(child, desc, config);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(child);
+				return ERR_PTR(-EPROBE_DEFER);
+			}
+			dev_err(dev,
+				"driver callback failed to parse DT for regulator %pOFn\n",
+				child);
+			goto error;
+		}
 	}
 
 	*node = child;
-- 
2.20.1

