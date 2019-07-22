Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578FEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9521897
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGVR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:29:24 -0400
Received: from sauhun.de ([88.99.104.3]:42138 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731340AbfGVR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:12 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id C52B34A1490;
        Mon, 22 Jul 2019 19:26:11 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: asb100: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:08 +0200
Message-Id: <20190722172611.3797-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
References: <20190722172611.3797-1-wsa+renesas@sang-engineering.com>
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

 drivers/hwmon/asb100.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index c9fa84b25678..4c609e23a4ef 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -706,21 +706,21 @@ static int asb100_detect_subclients(struct i2c_client *client)
 		goto ERROR_SC_2;
 	}
 
-	data->lm75[0] = i2c_new_dummy(adapter, sc_addr[0]);
-	if (!data->lm75[0]) {
+	data->lm75[0] = i2c_new_dummy_device(adapter, sc_addr[0]);
+	if (IS_ERR(data->lm75[0])) {
 		dev_err(&client->dev,
 			"subclient %d registration at address 0x%x failed.\n",
 			1, sc_addr[0]);
-		err = -ENOMEM;
+		err = PTR_ERR(data->lm75[0]);
 		goto ERROR_SC_2;
 	}
 
-	data->lm75[1] = i2c_new_dummy(adapter, sc_addr[1]);
-	if (!data->lm75[1]) {
+	data->lm75[1] = i2c_new_dummy_device(adapter, sc_addr[1]);
+	if (IS_ERR(data->lm75[1])) {
 		dev_err(&client->dev,
 			"subclient %d registration at address 0x%x failed.\n",
 			2, sc_addr[1]);
-		err = -ENOMEM;
+		err = PTR_ERR(data->lm75[1]);
 		goto ERROR_SC_3;
 	}
 
-- 
2.20.1

