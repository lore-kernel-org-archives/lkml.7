Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD601C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1DC217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfKFShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:37:51 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:8448 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfKFSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:37:49 -0500
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6IbkhoV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 19:37:46 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply regulator
Date:   Wed,  6 Nov 2019 19:35:36 +0100
Message-Id: <20191106183536.123070-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106183536.123070-1-stephan@gerhold.net>
References: <20191106183536.123070-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPU6050 has two power supply pins: VDD and VLOGIC, but the mpu6050
only supports enabling one of them at the moment. In some cases,
they may need to be enabled separately.

Add an additional "vdd-supply", but keep the code simple by making
the driver use the regulator bulk API. This actually allows further
simplifying the code since regulator_bulk_* already logs the errors
for us.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 +++++++---------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  5 ++--
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 354030e9bed5..8e50dbcd730b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1144,11 +1144,8 @@ static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
 {
 	int result;
 
-	result = regulator_enable(st->vddio_supply);
-	if (result) {
-		dev_err(regmap_get_device(st->map),
-			"Failed to enable regulator: %d\n", result);
-	} else {
+	result = regulator_bulk_enable(ARRAY_SIZE(st->supplies), st->supplies);
+	if (result == 0) {
 		/* Give the device a little bit of time to start up. */
 		usleep_range(35000, 70000);
 	}
@@ -1158,14 +1155,7 @@ static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
 
 static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
 {
-	int result;
-
-	result = regulator_disable(st->vddio_supply);
-	if (result)
-		dev_err(regmap_get_device(st->map),
-			"Failed to disable regulator: %d\n", result);
-
-	return result;
+	return regulator_bulk_disable(ARRAY_SIZE(st->supplies), st->supplies);
 }
 
 static void inv_mpu_core_disable_regulator_action(void *_data)
@@ -1239,14 +1229,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return -EINVAL;
 	}
 
-	st->vddio_supply = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(st->vddio_supply)) {
-		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vddio regulator %d\n",
-				(int)PTR_ERR(st->vddio_supply));
-
-		return PTR_ERR(st->vddio_supply);
-	}
+	st->supplies[0].supply = "vdd";
+	st->supplies[1].supply = "vddio";
+	result = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->supplies),
+					 st->supplies);
+	if (result)
+		return result;
 
 	result = inv_mpu_core_enable_regulator(st);
 	if (result)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 52fcf45050a5..96cbd7f2b4b3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
@@ -130,7 +131,7 @@ struct inv_mpu6050_hw {
  *  @chip_period:	chip internal period estimation (~1kHz).
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
- *  @vddio_supply	voltage regulator for the chip.
+ *  @supplies:		voltage regulators for the chip.
  *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  *  @magn_orient:       magnetometer sensor chip orientation if available.
@@ -154,7 +155,7 @@ struct inv_mpu6050_state {
 	s64 chip_period;
 	s64 it_timestamp;
 	s64 data_timestamp;
-	struct regulator *vddio_supply;
+	struct regulator_bulk_data supplies[2];
 	bool magn_disabled;
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
-- 
2.23.0

