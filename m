Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED95CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB9E21473
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCRPs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:48:59 -0400
Received: from sauhun.de ([88.99.104.3]:36826 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfCRPs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:48:58 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id D84DF4A1346;
        Mon, 18 Mar 2019 16:48:56 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Date:   Mon, 18 Mar 2019 16:47:54 +0100
Message-Id: <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-kernel users anymore, so remove this outdated interface.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/input/misc/da9063_onkey.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 3e9c353d82ef..e3a273c74123 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -22,7 +22,6 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/mfd/da9063/core.h>
-#include <linux/mfd/da9063/pdata.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9062/core.h>
 #include <linux/mfd/da9062/registers.h>
@@ -201,8 +200,6 @@ static void da9063_cancel_poll(void *data)
 
 static int da9063_onkey_probe(struct platform_device *pdev)
 {
-	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
-	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
 	struct da9063_onkey *onkey;
 	const struct of_device_id *match;
 	int irq;
@@ -229,12 +226,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	if (pdata)
-		onkey->key_power = pdata->key_power;
-	else
-		onkey->key_power =
-			!of_property_read_bool(pdev->dev.of_node,
-					       "dlg,disable-key-power");
+	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
+						  "dlg,disable-key-power");
 
 	onkey->input = devm_input_allocate_device(&pdev->dev);
 	if (!onkey->input) {
-- 
2.11.0

