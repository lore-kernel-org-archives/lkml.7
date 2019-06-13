Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83707C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFCB208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390154AbfFMPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:54:41 -0400
Received: from sauhun.de ([88.99.104.3]:41940 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731773AbfFMPy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:54:27 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id 6F2F24A12AA;
        Thu, 13 Jun 2019 17:54:25 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] media: mn88473: don't check retval after our own assignemt
Date:   Thu, 13 Jun 2019 17:54:19 +0200
Message-Id: <20190613155421.16408-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
References: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check a retval after we assigned a constant to it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/dvb-frontends/mn88473.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/mn88473.c b/drivers/media/dvb-frontends/mn88473.c
index 08118b38533b..d1b11909825c 100644
--- a/drivers/media/dvb-frontends/mn88473.c
+++ b/drivers/media/dvb-frontends/mn88473.c
@@ -661,8 +661,7 @@ static int mn88473_probe(struct i2c_client *client,
 	if (dev->client[1] == NULL) {
 		ret = -ENODEV;
 		dev_err(&client->dev, "I2C registration failed\n");
-		if (ret)
-			goto err_regmap_0_regmap_exit;
+		goto err_regmap_0_regmap_exit;
 	}
 	dev->regmap[1] = regmap_init_i2c(dev->client[1], &regmap_config);
 	if (IS_ERR(dev->regmap[1])) {
@@ -675,8 +674,7 @@ static int mn88473_probe(struct i2c_client *client,
 	if (dev->client[2] == NULL) {
 		ret = -ENODEV;
 		dev_err(&client->dev, "2nd I2C registration failed\n");
-		if (ret)
-			goto err_regmap_1_regmap_exit;
+		goto err_regmap_1_regmap_exit;
 	}
 	dev->regmap[2] = regmap_init_i2c(dev->client[2], &regmap_config);
 	if (IS_ERR(dev->regmap[2])) {
-- 
2.20.1

