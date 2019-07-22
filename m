Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC4B2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfGVR0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:43 -0400
Received: from sauhun.de ([88.99.104.3]:42206 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfGVR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:17 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id B5F004A1497;
        Mon, 22 Jul 2019 19:26:15 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: pressure: hp03: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:13 +0200
Message-Id: <20190722172613.3890-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
References: <20190722172613.3890-1-wsa+renesas@sang-engineering.com>
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

 drivers/iio/pressure/hp03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index f00102577fd5..026ba15ef68f 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -243,10 +243,10 @@ static int hp03_probe(struct i2c_client *client,
 	 * which has it's dedicated I2C address and contains
 	 * the calibration constants for the sensor.
 	 */
-	priv->eeprom_client = i2c_new_dummy(client->adapter, HP03_EEPROM_ADDR);
-	if (!priv->eeprom_client) {
+	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
+	if (IS_ERR(priv->eeprom_client)) {
 		dev_err(dev, "New EEPROM I2C device failed\n");
-		return -ENODEV;
+		return PTR_ERR(priv->eeprom_client);
 	}
 
 	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
-- 
2.20.1

