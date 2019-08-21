Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883D1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DE72339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfHUN0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:26:00 -0400
Received: from comms.puri.sm ([159.203.221.185]:44952 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfHUNZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:25:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A8C05DF916;
        Wed, 21 Aug 2019 06:25:57 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TUKCMW9f2kc0; Wed, 21 Aug 2019 06:25:56 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v5 2/4] iio: imu: st_lsm6sdx: move register definitions to sensor_settings struct
Date:   Wed, 21 Aug 2019 15:25:18 +0200
Message-Id: <20190821132520.28225-3-martin.kepplinger@puri.sm>
In-Reply-To: <20190821132520.28225-1-martin.kepplinger@puri.sm>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some register definitions to the per-device array of struct
st_lsm6dsx_sensor_settings in order to simplify adding new sensor
devices to the driver.

Also, remove completely unused register definitions.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 055e52dec36a..090b7bd3c5b0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -203,6 +203,9 @@ struct st_lsm6dsx_ext_dev_settings {
 /**
  * struct st_lsm6dsx_settings - ST IMU sensor settings
  * @wai: Sensor WhoAmI default value.
+ * @int1_addr: Control Register address for INT1
+ * @int2_addr: Control Register address for INT2
+ * @reset_addr: register address for reset/reboot
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @channels: IIO channels supported by the device.
@@ -216,6 +219,9 @@ struct st_lsm6dsx_ext_dev_settings {
  */
 struct st_lsm6dsx_settings {
 	u8 wai;
+	u8 int1_addr;
+	u8 int2_addr;
+	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
 		enum st_lsm6dsx_hw_id hw_id;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0aa93b45d772..1b46d9dc2089 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -49,17 +49,12 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_INT1_ADDR		0x0d
-#define ST_LSM6DSX_REG_INT2_ADDR		0x0e
 #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
-#define ST_LSM6DSX_REG_RESET_ADDR		0x12
 #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
 #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
 #define ST_LSM6DSX_REG_BDU_ADDR			0x12
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
-#define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
-#define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
@@ -78,6 +73,9 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x69,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 1365,
 		.id = {
 			{
@@ -187,6 +185,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -296,6 +297,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6a,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -414,6 +418,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6c,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -544,6 +551,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -645,6 +655,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -1172,10 +1185,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 
 	switch (drdy_pin) {
 	case 1:
-		*drdy_reg = ST_LSM6DSX_REG_INT1_ADDR;
+		*drdy_reg = hw->settings->int1_addr;
 		break;
 	case 2:
-		*drdy_reg = ST_LSM6DSX_REG_INT2_ADDR;
+		*drdy_reg = hw->settings->int2_addr;
 		break;
 	default:
 		dev_err(hw->dev, "unsupported data ready pin\n");
@@ -1275,7 +1288,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	int err;
 
 	/* device sw reset */
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
 				 ST_LSM6DSX_REG_RESET_MASK,
 				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
 	if (err < 0)
@@ -1284,7 +1297,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	msleep(50);
 
 	/* reload trimming parameter */
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
 				 ST_LSM6DSX_REG_BOOT_MASK,
 				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
 	if (err < 0)
-- 
2.20.1

