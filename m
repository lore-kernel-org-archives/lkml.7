Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D121C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A2217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfGVR0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:21 -0400
Received: from sauhun.de ([88.99.104.3]:42116 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731307AbfGVR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:08 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 983614A1493;
        Mon, 22 Jul 2019 19:26:06 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] media: dvb-frontends: mn88473: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:25:58 +0200
Message-Id: <20190722172604.3572-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
References: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
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

 drivers/media/dvb-frontends/mn88473.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/mn88473.c b/drivers/media/dvb-frontends/mn88473.c
index 08118b38533b..71cedce6c7d0 100644
--- a/drivers/media/dvb-frontends/mn88473.c
+++ b/drivers/media/dvb-frontends/mn88473.c
@@ -657,9 +657,9 @@ static int mn88473_probe(struct i2c_client *client,
 	 * Also, register bank 2 do not support sequential I/O. Only single
 	 * register write or read is allowed to that bank.
 	 */
-	dev->client[1] = i2c_new_dummy(client->adapter, 0x1a);
-	if (dev->client[1] == NULL) {
-		ret = -ENODEV;
+	dev->client[1] = i2c_new_dummy_device(client->adapter, 0x1a);
+	if (IS_ERR(dev->client[1])) {
+		ret = PTR_ERR(dev->client[1]);
 		dev_err(&client->dev, "I2C registration failed\n");
 		if (ret)
 			goto err_regmap_0_regmap_exit;
@@ -671,9 +671,9 @@ static int mn88473_probe(struct i2c_client *client,
 	}
 	i2c_set_clientdata(dev->client[1], dev);
 
-	dev->client[2] = i2c_new_dummy(client->adapter, 0x1c);
-	if (dev->client[2] == NULL) {
-		ret = -ENODEV;
+	dev->client[2] = i2c_new_dummy_device(client->adapter, 0x1c);
+	if (IS_ERR(dev->client[2])) {
+		ret = PTR_ERR(dev->client[2]);
 		dev_err(&client->dev, "2nd I2C registration failed\n");
 		if (ret)
 			goto err_regmap_1_regmap_exit;
-- 
2.20.1

