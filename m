Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ECC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A652218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XcERbb63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfC2R4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:56:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52947 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfC2R4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:56:40 -0400
Received: by mail-it1-f196.google.com with SMTP id g17so5114192ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=Y3cdsZxy9wy7Cmpvdb+MPPxHcwzw9zAxNMNfyFXm/kg=;
        b=XcERbb63R8TDhx5a798HB/Ut6NnPQYN2wPwKIgjUlqlMhfwHYqTqalGSvpH5X52uiB
         2EWYsyUxHjQ5kqEfJY84VnYQWU13LiekTD34ibMFJB2Pcw5CSrsHRxIZBVhbMHpaLZ4u
         GSqBrKUqYG5PT1zxBrMDjnMKpiOJ+pFWtZE4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=Y3cdsZxy9wy7Cmpvdb+MPPxHcwzw9zAxNMNfyFXm/kg=;
        b=AVEPBG7oa1Zz6ADPGz3B790rUNuwELkyqPGqEFPvN6iiPQIE80tgRx42G8LAF6+vf4
         lQOlh2AZoGWhqtz0rYljfDTx5YCXI59QN/W0x2xmkCL5VXF4JiRZrtwMQ805NHW4LP+p
         hfZsE/k/wKex8WYE20CndUt/z5Ku7b2YcL2Bg2nfR6w0xOSRHQI19BGJOKTU+aKsMHf/
         bF2Umd5Fqm6+ihN7I3TnaPJnqD8RUpGXcq+P3mlwK+sYP1ib2ifBqTn9Fpi3zN8n3x/q
         lPdvVk7P1jGJAqgIMSX2ITtSjvLVPDYEGeabhzp/q8cSOnkxPpdyWU4/aI7R24lykjzw
         25GQ==
X-Gm-Message-State: APjAAAXodD7dG/GDyJsQP345bj9akq8Lr0wT/urlUuyHvupwMUMQRTSg
        dseTeQ5+TJ7E4P5Y6ue8wgYbyhgJmfHGATUUfJ9OBQ==
X-Google-Smtp-Source: APXvYqyeL+gevOe2NiYdZk3YtJN/xEmVn3LQOZGs4bCLNfjNsRLdq663vKRSd257rS3DxIVAXHpKe1IdrLdfk+6UJkM=
X-Received: by 2002:a24:ee4c:: with SMTP id b73mr5381093iti.100.1553882198012;
 Fri, 29 Mar 2019 10:56:38 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Mar 2019 10:56:37 -0700
From:   Gwendal Grignou <gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190329175628.31481-1-gwendal@chromium.org>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
 <20190329175628.31481-1-gwendal@chromium.org>
MIME-Version: 1.0
Date:   Fri, 29 Mar 2019 10:56:37 -0700
Message-ID: <CAPUE2uuh2TvUiQCuG7KzQ=GD5Gm3C5ZbfZ42J0__H2R6yD1j9Q@mail.gmail.com>
Subject: [PATCH 3/3] mfd: cros: Update EC to use BIT() and merge
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using 1 << ..., use BIT() cleaner and safer.
Fix minor fixes since major cros_ec_commands.h cleanup was uploaded.

TEST=compile.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 268 ++++++++++++++-------------
 1 file changed, 143 insertions(+), 125 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h
b/include/linux/mfd/cros_ec_commands.h
index ea25e1644d23..5c4764e3db6f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -46,7 +46,7 @@ extern "C"{
 #define EC_PROTO_VERSION          0x00000002

 /* Command version mask */
-#define EC_VER_MASK(version) (1UL << (version))
+#define EC_VER_MASK(version) BIT(version)

 /* I/O addresses for ACPI commands */
 #define EC_LPC_ADDR_ACPI_DATA  0x62
@@ -72,13 +72,13 @@ extern "C"{
 #define EC_HOST_CMD_REGION_SIZE 0x80

 /* EC command register bit functions */
-#define EC_LPC_CMDR_DATA	(1 << 0)  /* Data ready for host to read */
-#define EC_LPC_CMDR_PENDING	(1 << 1)  /* Write pending to EC */
-#define EC_LPC_CMDR_BUSY	(1 << 2)  /* EC is busy processing a command */
-#define EC_LPC_CMDR_CMD		(1 << 3)  /* Last host write was a command */
-#define EC_LPC_CMDR_ACPI_BRST	(1 << 4)  /* Burst mode (not used) */
-#define EC_LPC_CMDR_SCI		(1 << 5)  /* SCI event is pending */
-#define EC_LPC_CMDR_SMI		(1 << 6)  /* SMI event is pending */
+#define EC_LPC_CMDR_DATA	BIT(0)  /* Data ready for host to read */
+#define EC_LPC_CMDR_PENDING	BIT(1)  /* Write pending to EC */
+#define EC_LPC_CMDR_BUSY	BIT(2)  /* EC is busy processing a command */
+#define EC_LPC_CMDR_CMD		BIT(3)  /* Last host write was a command */
+#define EC_LPC_CMDR_ACPI_BRST	BIT(4)  /* Burst mode (not used) */
+#define EC_LPC_CMDR_SCI		BIT(5)  /* SCI event is pending */
+#define EC_LPC_CMDR_SMI		BIT(6)  /* SMI event is pending */

 #define EC_LPC_ADDR_MEMMAP       0x900
 #define EC_MEMMAP_SIZE         255 /* ACPI IO buffer max is 255 bytes */
@@ -136,8 +136,8 @@ extern "C"{

 /* Define the format of the accelerometer mapped memory status byte. */
 #define EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK  0x0f
-#define EC_MEMMAP_ACC_STATUS_BUSY_BIT        (1 << 4)
-#define EC_MEMMAP_ACC_STATUS_PRESENCE_BIT    (1 << 7)
+#define EC_MEMMAP_ACC_STATUS_BUSY_BIT        BIT(4)
+#define EC_MEMMAP_ACC_STATUS_PRESENCE_BIT    BIT(7)

 /* Number of temp sensors at EC_MEMMAP_TEMP_SENSOR */
 #define EC_TEMP_SENSOR_ENTRIES     16
@@ -312,8 +312,8 @@ extern "C"{
  *   bit 1 enables/disables the selected threshold (0 = off, 1 = on)
  * Each write to the commit register affects one threshold.
  */
-#define EC_ACPI_MEM_TEMP_COMMIT_SELECT_MASK (1 << 0)
-#define EC_ACPI_MEM_TEMP_COMMIT_ENABLE_MASK (1 << 1)
+#define EC_ACPI_MEM_TEMP_COMMIT_SELECT_MASK BIT(0)
+#define EC_ACPI_MEM_TEMP_COMMIT_ENABLE_MASK BIT(1)
 /*
  * Example:
  *
@@ -632,7 +632,7 @@ enum host_event_code {
 	EC_HOST_EVENT_INVALID = 32
 };
 /* Host event mask */
-#define EC_HOST_EVENT_MASK(event_code) (1ULL << ((event_code) - 1))
+#define EC_HOST_EVENT_MASK(event_code) BIT_ULL((event_code) - 1)

 /**
  * struct ec_lpc_host_args - Arguments at EC_LPC_ADDR_HOST_ARGS
@@ -1160,7 +1160,7 @@ struct ec_response_get_cmd_versions {

 /* Avoid using ec_status which is for return values */
 enum ec_comms_status {
-	EC_COMMS_STATUS_PROCESSING	= 1 << 0,	/* Processing cmd */
+	EC_COMMS_STATUS_PROCESSING	= BIT(0),	/* Processing cmd */
 };

 /**
@@ -1192,7 +1192,7 @@ struct ec_response_test_protocol {

 /* Flags for ec_response_get_protocol_info.flags */
 /* EC_RES_IN_PROGRESS may be returned if a command is slow */
-#define EC_PROTOCOL_INFO_IN_PROGRESS_SUPPORTED (1 << 0)
+#define EC_PROTOCOL_INFO_IN_PROGRESS_SUPPORTED BIT(0)

 /**
  * struct ec_response_get_protocol_info - Response to the get protocol info.
@@ -1347,12 +1347,12 @@ enum ec_feature_code {
 	EC_FEATURE_AUDIO_CODEC = 38,
 	/* EC Supports SCP. */
 	EC_FEATURE_SCP = 39,
-	/* The MCU is Intel Integrated Sensor Hub */
+	/* The MCU is an Integrated Sensor Hub */
 	EC_FEATURE_ISH = 40,
 };

-#define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-#define EC_FEATURE_MASK_1(event_code) (1UL << (event_code - 32))
+#define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
+#define EC_FEATURE_MASK_1(event_code) BIT(event_code - 32)

 struct ec_response_get_features {
 	uint32_t flags[2];
@@ -1399,7 +1399,7 @@ struct ec_response_flash_info {
  * Flags for version 1+ flash info command
  * EC flash erases bits to 0 instead of 1.
  */
-#define EC_FLASH_INFO_ERASE_TO_0 (1 << 0)
+#define EC_FLASH_INFO_ERASE_TO_0 BIT(0)

 /*
  * Flash must be selected for read/write/erase operations to succeed.  This may
@@ -1408,7 +1408,7 @@ struct ec_response_flash_info {
  * or where the read/write/erase operations require cleanly suspending other
  * chip functionality.
  */
-#define EC_FLASH_INFO_SELECT_REQUIRED (1 << 1)
+#define EC_FLASH_INFO_SELECT_REQUIRED BIT(1)

 /**
  * struct ec_response_flash_info_1 - Response to the flash info v1 command.
@@ -1587,34 +1587,34 @@ struct ec_params_flash_erase_v1 {

 /* Flags for flash protection */
 /* RO flash code protected when the EC boots */
-#define EC_FLASH_PROTECT_RO_AT_BOOT         (1 << 0)
+#define EC_FLASH_PROTECT_RO_AT_BOOT         BIT(0)
 /*
  * RO flash code protected now.  If this bit is set, at-boot status cannot
  * be changed.
  */
-#define EC_FLASH_PROTECT_RO_NOW             (1 << 1)
+#define EC_FLASH_PROTECT_RO_NOW             BIT(1)
 /* Entire flash code protected now, until reboot. */
-#define EC_FLASH_PROTECT_ALL_NOW            (1 << 2)
+#define EC_FLASH_PROTECT_ALL_NOW            BIT(2)
 /* Flash write protect GPIO is asserted now */
-#define EC_FLASH_PROTECT_GPIO_ASSERTED      (1 << 3)
+#define EC_FLASH_PROTECT_GPIO_ASSERTED      BIT(3)
 /* Error - at least one bank of flash is stuck locked, and cannot be
unlocked */
-#define EC_FLASH_PROTECT_ERROR_STUCK        (1 << 4)
+#define EC_FLASH_PROTECT_ERROR_STUCK        BIT(4)
 /*
  * Error - flash protection is in inconsistent state.  At least one bank of
  * flash which should be protected is not protected.  Usually fixed by
  * re-requesting the desired flags, or by a hard reset if that fails.
  */
-#define EC_FLASH_PROTECT_ERROR_INCONSISTENT (1 << 5)
+#define EC_FLASH_PROTECT_ERROR_INCONSISTENT BIT(5)
 /* Entire flash code protected when the EC boots */
-#define EC_FLASH_PROTECT_ALL_AT_BOOT        (1 << 6)
+#define EC_FLASH_PROTECT_ALL_AT_BOOT        BIT(6)
 /* RW flash code protected when the EC boots */
-#define EC_FLASH_PROTECT_RW_AT_BOOT         (1 << 7)
+#define EC_FLASH_PROTECT_RW_AT_BOOT         BIT(7)
 /* RW flash code protected now. */
-#define EC_FLASH_PROTECT_RW_NOW             (1 << 8)
+#define EC_FLASH_PROTECT_RW_NOW             BIT(8)
 /* Rollback information flash region protected when the EC boots */
-#define EC_FLASH_PROTECT_ROLLBACK_AT_BOOT   (1 << 9)
+#define EC_FLASH_PROTECT_ROLLBACK_AT_BOOT   BIT(9)
 /* Rollback information flash region protected now */
-#define EC_FLASH_PROTECT_ROLLBACK_NOW       (1 << 10)
+#define EC_FLASH_PROTECT_ROLLBACK_NOW       BIT(10)


 /**
@@ -2169,8 +2169,8 @@ enum ec_led_id {
 };

 /* LED control flags */
-#define EC_LED_FLAGS_QUERY (1 << 0) /* Query LED capability only */
-#define EC_LED_FLAGS_AUTO  (1 << 1) /* Switch LED back to automatic control */
+#define EC_LED_FLAGS_QUERY BIT(0) /* Query LED capability only */
+#define EC_LED_FLAGS_AUTO  BIT(1) /* Switch LED back to automatic control */

 enum ec_led_colors {
 	EC_LED_COLOR_RED = 0,
@@ -2438,6 +2438,7 @@ enum motionsensor_chip {
 	MOTIONSENSE_CHIP_LIS2DE = 15,
 	MOTIONSENSE_CHIP_LIS2MDL = 16,
 	MOTIONSENSE_CHIP_LSM6DS3 = 17,
+	MOTIONSENSE_CHIP_LSM6DSO = 18,
 	MOTIONSENSE_CHIP_MAX,
 };

@@ -2508,19 +2509,20 @@ struct ec_motion_sense_activity {
 } __ec_todo_unpacked;

 /* Module flag masks used for the dump sub-command. */
-#define MOTIONSENSE_MODULE_FLAG_ACTIVE (1<<0)
+#define MOTIONSENSE_MODULE_FLAG_ACTIVE BIT(0)

 /* Sensor flag masks used for the dump sub-command. */
-#define MOTIONSENSE_SENSOR_FLAG_PRESENT (1<<0)
+#define MOTIONSENSE_SENSOR_FLAG_PRESENT BIT(0)

 /*
  * Flush entry for synchronization.
  * data contains time stamp
  */
-#define MOTIONSENSE_SENSOR_FLAG_FLUSH (1<<0)
-#define MOTIONSENSE_SENSOR_FLAG_TIMESTAMP (1<<1)
-#define MOTIONSENSE_SENSOR_FLAG_WAKEUP (1<<2)
-#define MOTIONSENSE_SENSOR_FLAG_TABLET_MODE (1<<3)
+#define MOTIONSENSE_SENSOR_FLAG_FLUSH BIT(0)
+#define MOTIONSENSE_SENSOR_FLAG_TIMESTAMP BIT(1)
+#define MOTIONSENSE_SENSOR_FLAG_WAKEUP BIT(2)
+#define MOTIONSENSE_SENSOR_FLAG_TABLET_MODE BIT(3)
+#define MOTIONSENSE_SENSOR_FLAG_ODR BIT(4)

 /*
  * Send this value for the data element to only perform a read. If you
@@ -2533,10 +2535,10 @@ struct ec_motion_sense_activity {

 /* MOTIONSENSE_CMD_SENSOR_OFFSET subcommand flag */
 /* Set Calibration information */
-#define MOTION_SENSE_SET_OFFSET (1 << 0)
+#define MOTION_SENSE_SET_OFFSET BIT(0)

 /* Default Scale value, factor 1. */
-#define MOTION_SENSE_DEFAULT_SCALE (1 << 15)
+#define MOTION_SENSE_DEFAULT_SCALE BIT(15)

 #define LID_ANGLE_UNRELIABLE 500

@@ -2653,7 +2655,7 @@ struct ec_params_motion_sense {
 			/*
 			 * Scale for calibration:
 			 * By default scale is 1, it is encoded on 16bits:
-			 * 1 = 1 << 15
+			 * 1 = BIT(15)
 			 * ~2 = 0xFFFF
 			 * ~0 = 0.
 			 */
@@ -2854,7 +2856,7 @@ struct ec_params_force_lid_open {

 enum ec_config_power_button_flags {
 	/* Enable/Disable power button pulses for x86 devices */
-	EC_POWER_BUTTON_ENABLE_PULSE = (1 << 0),
+	EC_POWER_BUTTON_ENABLE_PULSE = BIT(0),
 };

 struct ec_params_config_power_button {
@@ -3278,13 +3280,13 @@ enum mkbp_config_flags {
 };

 enum mkbp_config_valid {
-	EC_MKBP_VALID_SCAN_PERIOD		= 1 << 0,
-	EC_MKBP_VALID_POLL_TIMEOUT		= 1 << 1,
-	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= 1 << 3,
-	EC_MKBP_VALID_OUTPUT_SETTLE		= 1 << 4,
-	EC_MKBP_VALID_DEBOUNCE_DOWN		= 1 << 5,
-	EC_MKBP_VALID_DEBOUNCE_UP		= 1 << 6,
-	EC_MKBP_VALID_FIFO_MAX_DEPTH		= 1 << 7,
+	EC_MKBP_VALID_SCAN_PERIOD		= BIT(0),
+	EC_MKBP_VALID_POLL_TIMEOUT		= BIT(1),
+	EC_MKBP_VALID_MIN_POST_SCAN_DELAY	= BIT(3),
+	EC_MKBP_VALID_OUTPUT_SETTLE		= BIT(4),
+	EC_MKBP_VALID_DEBOUNCE_DOWN		= BIT(5),
+	EC_MKBP_VALID_DEBOUNCE_UP		= BIT(6),
+	EC_MKBP_VALID_FIFO_MAX_DEPTH		= BIT(7),
 };

 /*
@@ -3338,7 +3340,7 @@ enum ec_collect_flags {
 	 * Indicates this scan was processed by the EC. Due to timing, some
 	 * scans may be skipped.
 	 */
-	EC_KEYSCAN_SEQ_FLAG_DONE	= 1 << 0,
+	EC_KEYSCAN_SEQ_FLAG_DONE	= BIT(0),
 };

 struct ec_collect_item {
@@ -3392,10 +3394,10 @@ struct ec_result_keyscan_seq_ctrl {
  * We use the most significant bit of the event type to indicate to the host
  * that the EC has more MKBP events available to provide.
  */
-#define EC_MKBP_HAS_MORE_EVENTS (1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT)
+#define EC_MKBP_HAS_MORE_EVENTS BIT(EC_MKBP_HAS_MORE_EVENTS_SHIFT)

 /* The mask to apply to get the raw event type */
-#define EC_MKBP_EVENT_TYPE_MASK ((1 << EC_MKBP_HAS_MORE_EVENTS_SHIFT) - 1)
+#define EC_MKBP_EVENT_TYPE_MASK (BIT(EC_MKBP_HAS_MORE_EVENTS_SHIFT) - 1)

 enum ec_mkbp_event {
 	/* Keyboard matrix changed. The event data is the new matrix state. */
@@ -3533,11 +3535,11 @@ struct ec_response_keyboard_factory_test {
 #define EC_MKBP_FP_MATCH_IDX_MASK 0x0000F000
 #define EC_MKBP_FP_MATCH_IDX(fpe) (((fpe) & EC_MKBP_FP_MATCH_IDX_MASK) \
 					 >> EC_MKBP_FP_MATCH_IDX_OFFSET)
-#define EC_MKBP_FP_ENROLL               (1 << 27)
-#define EC_MKBP_FP_MATCH                (1 << 28)
-#define EC_MKBP_FP_FINGER_DOWN          (1 << 29)
-#define EC_MKBP_FP_FINGER_UP            (1 << 30)
-#define EC_MKBP_FP_IMAGE_READY          (1 << 31)
+#define EC_MKBP_FP_ENROLL               BIT(27)
+#define EC_MKBP_FP_MATCH                BIT(28)
+#define EC_MKBP_FP_FINGER_DOWN          BIT(29)
+#define EC_MKBP_FP_FINGER_UP            BIT(30)
+#define EC_MKBP_FP_IMAGE_READY          BIT(31)
 /* code given by EC_MKBP_FP_ERRCODE() when EC_MKBP_FP_ENROLL is set */
 #define EC_MKBP_FP_ERR_ENROLL_OK               0
 #define EC_MKBP_FP_ERR_ENROLL_LOW_QUALITY      1
@@ -3885,7 +3887,7 @@ struct ec_params_console_read_v1 {
  */
 #define EC_CMD_BATTERY_CUT_OFF 0x0099

-#define EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN	(1 << 0)
+#define EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN	BIT(0)

 struct ec_params_battery_cutoff {
 	uint8_t flags;
@@ -3956,13 +3958,13 @@ struct ec_response_power_info {
 #define EC_CMD_I2C_PASSTHRU 0x009E

 /* Read data; if not present, message is a write */
-#define EC_I2C_FLAG_READ	(1 << 15)
+#define EC_I2C_FLAG_READ	BIT(15)

 /* Mask for address */
 #define EC_I2C_ADDR_MASK	0x3ff

-#define EC_I2C_STATUS_NAK	(1 << 0) /* Transfer was not acknowledged */
-#define EC_I2C_STATUS_TIMEOUT	(1 << 1) /* Timeout during transfer */
+#define EC_I2C_STATUS_NAK	BIT(0) /* Transfer was not acknowledged */
+#define EC_I2C_STATUS_TIMEOUT	BIT(1) /* Timeout during transfer */

 /* Any error */
 #define EC_I2C_STATUS_ERROR	(EC_I2C_STATUS_NAK | EC_I2C_STATUS_TIMEOUT)
@@ -3992,27 +3994,27 @@ struct ec_response_i2c_passthru {

 /* Reasons to start hang detection timer */
 /* Power button pressed */
-#define EC_HANG_START_ON_POWER_PRESS  (1 << 0)
+#define EC_HANG_START_ON_POWER_PRESS  BIT(0)

 /* Lid closed */
-#define EC_HANG_START_ON_LID_CLOSE    (1 << 1)
+#define EC_HANG_START_ON_LID_CLOSE    BIT(1)

  /* Lid opened */
-#define EC_HANG_START_ON_LID_OPEN     (1 << 2)
+#define EC_HANG_START_ON_LID_OPEN     BIT(2)

 /* Start of AP S3->S0 transition (booting or resuming from suspend) */
-#define EC_HANG_START_ON_RESUME       (1 << 3)
+#define EC_HANG_START_ON_RESUME       BIT(3)

 /* Reasons to cancel hang detection */

 /* Power button released */
-#define EC_HANG_STOP_ON_POWER_RELEASE (1 << 8)
+#define EC_HANG_STOP_ON_POWER_RELEASE BIT(8)

 /* Any host command from AP received */
-#define EC_HANG_STOP_ON_HOST_COMMAND  (1 << 9)
+#define EC_HANG_STOP_ON_HOST_COMMAND  BIT(9)

 /* Stop on end of AP S0->S3 transition (suspending or shutting down) */
-#define EC_HANG_STOP_ON_SUSPEND       (1 << 10)
+#define EC_HANG_STOP_ON_SUSPEND       BIT(10)

 /*
  * If this flag is set, all the other fields are ignored, and the hang detect
@@ -4020,14 +4022,14 @@ struct ec_response_i2c_passthru {
  * without reconfiguring any of the other hang detect settings.  Note that
  * you must previously have configured the timeouts.
  */
-#define EC_HANG_START_NOW             (1 << 30)
+#define EC_HANG_START_NOW             BIT(30)

 /*
  * If this flag is set, all the other fields are ignored (including
  * EC_HANG_START_NOW).  This provides the AP a way to stop the hang timer
  * without reconfiguring any of the other hang detect settings.
  */
-#define EC_HANG_STOP_NOW              (1 << 31)
+#define EC_HANG_STOP_NOW              BIT(31)

 struct ec_params_hang_detect {
 	/* Flags; see EC_HANG_* */
@@ -4229,7 +4231,7 @@ enum ec_device_event_param {
 	EC_DEVICE_EVENT_PARAM_SET_ENABLED_EVENTS,
 };

-#define EC_DEVICE_EVENT_MASK(event_code) (1UL << (event_code % 32))
+#define EC_DEVICE_EVENT_MASK(event_code) BIT(event_code % 32)

 struct ec_params_device_event {
 	uint32_t event_mask;
@@ -4465,9 +4467,9 @@ enum cec_command {
 /* Events from CEC to AP */
 enum mkbp_cec_event {
 	/* Outgoing message was acknowledged by a follower */
-	EC_MKBP_CEC_SEND_OK			= 1 << 0,
+	EC_MKBP_CEC_SEND_OK			= BIT(0),
 	/* Outgoing message was not acknowledged */
-	EC_MKBP_CEC_SEND_FAILED			= 1 << 1,
+	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
 };

 /*****************************************************************************/
@@ -4582,9 +4584,9 @@ enum ec_reboot_cmd {
 };

 /* Flags for ec_params_reboot_ec.reboot_flags */
-#define EC_REBOOT_FLAG_RESERVED0      (1 << 0)  /* Was recovery request */
-#define EC_REBOOT_FLAG_ON_AP_SHUTDOWN (1 << 1)  /* Reboot after AP shutdown */
-#define EC_REBOOT_FLAG_SWITCH_RW_SLOT (1 << 2)  /* Switch RW slot */
+#define EC_REBOOT_FLAG_RESERVED0      BIT(0)  /* Was recovery request */
+#define EC_REBOOT_FLAG_ON_AP_SHUTDOWN BIT(1)  /* Reboot after AP shutdown */
+#define EC_REBOOT_FLAG_SWITCH_RW_SLOT BIT(2)  /* Switch RW slot */

 struct ec_params_reboot_ec {
 	uint8_t cmd;           /* enum ec_reboot_cmd */
@@ -4658,7 +4660,7 @@ enum pd_charge_state {
 };

 /* Status of EC being sent to PD */
-#define EC_STATUS_HIBERNATING	(1 << 0)
+#define EC_STATUS_HIBERNATING	BIT(0)

 struct ec_params_pd_status {
 	uint8_t status;       /* EC status */
@@ -4667,13 +4669,13 @@ struct ec_params_pd_status {
 } __ec_align1;

 /* Status of PD being sent back to EC */
-#define PD_STATUS_HOST_EVENT      (1 << 0) /* Forward host event to AP */
-#define PD_STATUS_IN_RW           (1 << 1) /* Running RW image */
-#define PD_STATUS_JUMPED_TO_IMAGE (1 << 2) /* Current image was jumped to */
-#define PD_STATUS_TCPC_ALERT_0    (1 << 3) /* Alert active in port 0 TCPC */
-#define PD_STATUS_TCPC_ALERT_1    (1 << 4) /* Alert active in port 1 TCPC */
-#define PD_STATUS_TCPC_ALERT_2    (1 << 5) /* Alert active in port 2 TCPC */
-#define PD_STATUS_TCPC_ALERT_3    (1 << 6) /* Alert active in port 3 TCPC */
+#define PD_STATUS_HOST_EVENT      BIT(0) /* Forward host event to AP */
+#define PD_STATUS_IN_RW           BIT(1) /* Running RW image */
+#define PD_STATUS_JUMPED_TO_IMAGE BIT(2) /* Current image was jumped to */
+#define PD_STATUS_TCPC_ALERT_0    BIT(3) /* Alert active in port 0 TCPC */
+#define PD_STATUS_TCPC_ALERT_1    BIT(4) /* Alert active in port 1 TCPC */
+#define PD_STATUS_TCPC_ALERT_2    BIT(5) /* Alert active in port 2 TCPC */
+#define PD_STATUS_TCPC_ALERT_3    BIT(6) /* Alert active in port 3 TCPC */
 #define PD_STATUS_EC_INT_ACTIVE  (PD_STATUS_TCPC_ALERT_0 | \
 				      PD_STATUS_TCPC_ALERT_1 | \
 				      PD_STATUS_HOST_EVENT)
@@ -4687,10 +4689,10 @@ struct ec_response_pd_status {
 #define EC_CMD_PD_HOST_EVENT_STATUS 0x0104

 /* PD MCU host event status bits */
-#define PD_EVENT_UPDATE_DEVICE     (1 << 0)
-#define PD_EVENT_POWER_CHANGE      (1 << 1)
-#define PD_EVENT_IDENTITY_RECEIVED (1 << 2)
-#define PD_EVENT_DATA_SWAP         (1 << 3)
+#define PD_EVENT_UPDATE_DEVICE     BIT(0)
+#define PD_EVENT_POWER_CHANGE      BIT(1)
+#define PD_EVENT_IDENTITY_RECEIVED BIT(2)
+#define PD_EVENT_DATA_SWAP         BIT(3)
 struct ec_response_host_event_status {
 	uint32_t status;      /* PD MCU host event status */
 } __ec_align4;
@@ -4733,17 +4735,17 @@ struct ec_params_usb_pd_control {
 	uint8_t swap;
 } __ec_align1;

-#define PD_CTRL_RESP_ENABLED_COMMS      (1 << 0) /* Communication enabled */
-#define PD_CTRL_RESP_ENABLED_CONNECTED  (1 << 1) /* Device connected */
-#define PD_CTRL_RESP_ENABLED_PD_CAPABLE (1 << 2) /* Partner is PD capable */
+#define PD_CTRL_RESP_ENABLED_COMMS      BIT(0) /* Communication enabled */
+#define PD_CTRL_RESP_ENABLED_CONNECTED  BIT(1) /* Device connected */
+#define PD_CTRL_RESP_ENABLED_PD_CAPABLE BIT(2) /* Partner is PD capable */

-#define PD_CTRL_RESP_ROLE_POWER         (1 << 0) /* 0=SNK/1=SRC */
-#define PD_CTRL_RESP_ROLE_DATA          (1 << 1) /* 0=UFP/1=DFP */
-#define PD_CTRL_RESP_ROLE_VCONN         (1 << 2) /* Vconn status */
-#define PD_CTRL_RESP_ROLE_DR_POWER      (1 << 3) /* Partner is
dualrole power */
-#define PD_CTRL_RESP_ROLE_DR_DATA       (1 << 4) /* Partner is dualrole data */
-#define PD_CTRL_RESP_ROLE_USB_COMM      (1 << 5) /* Partner USB comm capable */
-#define PD_CTRL_RESP_ROLE_EXT_POWERED   (1 << 6) /* Partner
externally powerd */
+#define PD_CTRL_RESP_ROLE_POWER         BIT(0) /* 0=SNK/1=SRC */
+#define PD_CTRL_RESP_ROLE_DATA          BIT(1) /* 0=UFP/1=DFP */
+#define PD_CTRL_RESP_ROLE_VCONN         BIT(2) /* Vconn status */
+#define PD_CTRL_RESP_ROLE_DR_POWER      BIT(3) /* Partner is dualrole power */
+#define PD_CTRL_RESP_ROLE_DR_DATA       BIT(4) /* Partner is dualrole data */
+#define PD_CTRL_RESP_ROLE_USB_COMM      BIT(5) /* Partner USB comm capable */
+#define PD_CTRL_RESP_ROLE_EXT_POWERED   BIT(6) /* Partner externally powerd */

 struct ec_response_usb_pd_control {
 	uint8_t enabled;
@@ -4759,6 +4761,22 @@ struct ec_response_usb_pd_control_v1 {
 	char state[32];
 } __ec_align1;

+/* Values representing usbc PD CC state */
+#define USBC_PD_CC_NONE		0 /* No accessory connected */
+#define USBC_PD_CC_NO_UFP	1 /* No UFP accessory connected */
+#define USBC_PD_CC_AUDIO_ACC	2 /* Audio accessory connected */
+#define USBC_PD_CC_DEBUG_ACC	3 /* Debug accessory connected */
+#define USBC_PD_CC_UFP_ATTACHED	4 /* UFP attached to usbc */
+#define USBC_PD_CC_DFP_ATTACHED	5 /* DPF attached to usbc */
+
+struct ec_response_usb_pd_control_v2 {
+	uint8_t enabled;
+	uint8_t role;
+	uint8_t polarity;
+	char state[32];
+	uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
+} __ec_align1;
+
 #define EC_CMD_USB_PD_PORTS 0x0102

 /* Maximum number of PD ports on a device, num_ports will be <= this */
@@ -4937,11 +4955,11 @@ struct ec_response_pd_log {
  * the data field contains the port state flags as defined below :
  */
 /* Port partner is a dual role device */
-#define CHARGE_FLAGS_DUAL_ROLE         (1 << 15)
+#define CHARGE_FLAGS_DUAL_ROLE         BIT(15)
 /* Port is the pending override port */
-#define CHARGE_FLAGS_DELAYED_OVERRIDE  (1 << 14)
+#define CHARGE_FLAGS_DELAYED_OVERRIDE  BIT(14)
 /* Port is the override port */
-#define CHARGE_FLAGS_OVERRIDE          (1 << 13)
+#define CHARGE_FLAGS_OVERRIDE          BIT(13)
 /* Charger type */
 #define CHARGE_FLAGS_TYPE_SHIFT               3
 #define CHARGE_FLAGS_TYPE_MASK       (0xf << CHARGE_FLAGS_TYPE_SHIFT)
@@ -5038,11 +5056,11 @@ struct ec_params_usb_pd_mux_info {
 } __ec_align1;

 /* Flags representing mux state */
-#define USB_PD_MUX_USB_ENABLED       (1 << 0) /* USB connected */
-#define USB_PD_MUX_DP_ENABLED        (1 << 1) /* DP connected */
-#define USB_PD_MUX_POLARITY_INVERTED (1 << 2) /* CC line Polarity inverted */
-#define USB_PD_MUX_HPD_IRQ           (1 << 3) /* HPD IRQ is asserted */
-#define USB_PD_MUX_HPD_LVL           (1 << 4) /* HPD level is asserted */
+#define USB_PD_MUX_USB_ENABLED       BIT(0) /* USB connected */
+#define USB_PD_MUX_DP_ENABLED        BIT(1) /* DP connected */
+#define USB_PD_MUX_POLARITY_INVERTED BIT(2) /* CC line Polarity inverted */
+#define USB_PD_MUX_HPD_IRQ           BIT(3) /* HPD IRQ is asserted */
+#define USB_PD_MUX_HPD_LVL           BIT(4) /* HPD level is asserted */

 struct ec_response_usb_pd_mux_info {
 	uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
@@ -5133,7 +5151,7 @@ enum cbi_data_tag {
  * RELOAD:  Invalidate cache and read data from EEPROM. Useful to verify
  *          write was successful without reboot.
  */
-#define CBI_GET_RELOAD		(1 << 0)
+#define CBI_GET_RELOAD		BIT(0)

 struct ec_params_get_cbi {
 	uint32_t tag;		/* enum cbi_data_tag */
@@ -5148,8 +5166,8 @@ struct ec_params_get_cbi {
  * INIT:    Need to be set when creating a new CBI from scratch. All fields
  *          will be initialized to zero first.
  */
-#define CBI_SET_NO_SYNC		(1 << 0)
-#define CBI_SET_INIT		(1 << 1)
+#define CBI_SET_NO_SYNC		BIT(0)
+#define CBI_SET_INIT		BIT(1)

 struct ec_params_set_cbi {
 	uint32_t tag;		/* enum cbi_data_tag */
@@ -5289,23 +5307,23 @@ struct ec_params_fp_passthru {
 #define EC_CMD_FP_MODE 0x0402

 /* Put the sensor in its lowest power mode */
-#define FP_MODE_DEEPSLEEP      (1<<0)
+#define FP_MODE_DEEPSLEEP      BIT(0)
 /* Wait to see a finger on the sensor */
-#define FP_MODE_FINGER_DOWN    (1<<1)
+#define FP_MODE_FINGER_DOWN    BIT(1)
 /* Poll until the finger has left the sensor */
-#define FP_MODE_FINGER_UP      (1<<2)
+#define FP_MODE_FINGER_UP      BIT(2)
 /* Capture the current finger image */
-#define FP_MODE_CAPTURE        (1<<3)
+#define FP_MODE_CAPTURE        BIT(3)
 /* Finger enrollment session on-going */
-#define FP_MODE_ENROLL_SESSION (1<<4)
+#define FP_MODE_ENROLL_SESSION BIT(4)
 /* Enroll the current finger image */
-#define FP_MODE_ENROLL_IMAGE   (1<<5)
+#define FP_MODE_ENROLL_IMAGE   BIT(5)
 /* Try to match the current finger image */
-#define FP_MODE_MATCH          (1<<6)
+#define FP_MODE_MATCH          BIT(6)
 /* Reset and re-initialize the sensor. */
-#define FP_MODE_RESET_SENSOR   (1<<7)
+#define FP_MODE_RESET_SENSOR   BIT(7)
 /* special value: don't change anything just read back current mode */
-#define FP_MODE_DONT_CHANGE    (1<<31)
+#define FP_MODE_DONT_CHANGE    BIT(31)

 #define FP_VALID_MODES (FP_MODE_DEEPSLEEP      | \
 			FP_MODE_FINGER_DOWN    | \
@@ -5359,13 +5377,13 @@ struct ec_response_fp_mode {
 /* Unknown number of dead pixels detected on the last maintenance */
 #define FP_ERROR_DEAD_PIXELS_UNKNOWN (0x3FF)
 /* No interrupt from the sensor */
-#define FP_ERROR_NO_IRQ    (1 << 12)
+#define FP_ERROR_NO_IRQ    BIT(12)
 /* SPI communication error */
-#define FP_ERROR_SPI_COMM  (1 << 13)
+#define FP_ERROR_SPI_COMM  BIT(13)
 /* Invalid sensor Hardware ID */
-#define FP_ERROR_BAD_HWID  (1 << 14)
+#define FP_ERROR_BAD_HWID  BIT(14)
 /* Sensor initialization failed */
-#define FP_ERROR_INIT_FAIL (1 << 15)
+#define FP_ERROR_INIT_FAIL BIT(15)

 struct ec_response_fp_info_v0 {
 	/* Sensor identification */
@@ -5472,8 +5490,8 @@ struct ec_params_fp_context {

 #define EC_CMD_FP_STATS 0x0407

-#define FPSTATS_CAPTURE_INV  (1 << 0)
-#define FPSTATS_MATCHING_INV (1 << 1)
+#define FPSTATS_CAPTURE_INV  BIT(0)
+#define FPSTATS_MATCHING_INV BIT(1)

 struct ec_response_fp_stats {
 	uint32_t capture_time_us;
-- 
2.21.0.392.gf8f6787159e-goog
