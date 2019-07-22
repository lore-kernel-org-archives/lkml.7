Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD6C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5871021955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfGVR2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:28:23 -0400
Received: from sauhun.de ([88.99.104.3]:42320 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbfGVR00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:26 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 3EA064A149C;
        Mon, 22 Jul 2019 19:26:25 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] mfd: 88pm860x-core: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:09 +0200
Message-Id: <20190722172623.4166-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/88pm860x-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 9e0bd135730f..c9bae71f643a 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1178,12 +1178,12 @@ static int pm860x_probe(struct i2c_client *client)
 	 */
 	if (pdata->companion_addr && (pdata->companion_addr != client->addr)) {
 		chip->companion_addr = pdata->companion_addr;
-		chip->companion = i2c_new_dummy(chip->client->adapter,
+		chip->companion = i2c_new_dummy_device(chip->client->adapter,
 						chip->companion_addr);
-		if (!chip->companion) {
+		if (IS_ERR(chip->companion)) {
 			dev_err(&client->dev,
 				"Failed to allocate I2C companion device\n");
-			return -ENODEV;
+			return PTR_ERR(chip->companion);
 		}
 		chip->regmap_companion = regmap_init_i2c(chip->companion,
 							&pm860x_regmap_config);
-- 
2.20.1

