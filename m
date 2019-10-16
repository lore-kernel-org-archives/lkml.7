Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C4FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2893A206A4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIZB2AsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391554AbfJPX5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:57:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33867 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbfJPX5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:57:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id k20so204581pgi.1;
        Wed, 16 Oct 2019 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P7sRBJmE3gU5mLKndoYic2ds2qzZ0LQMpodcKiAN8Yw=;
        b=uIZB2AsJnWv6yjB1YixB9HBwQ4NFeEr365nWN24Z2y52cx/P1RyVIFuLjyEk/rpapV
         2WFj2edxShTNihAW8xKidBHPU8/BLSbf83yWfv17WavAqeysAmKDGHEH8eoFpznN4n8J
         D9RmTVrVN5/8eXvCaOO2YgmxA13jlMpzcF0sId2Fxp+2GxrmE1bq6pF+zbbIsDytm3Ee
         Wkq4d2RDsI6560AkLu3NRg9w1JfnaCYsi4Dmjgeg5N30aAvtF3GBnanFwNRVYZtNZikf
         w6lEWcqQHWSDCgaomHxZ8KRLi02SE47I6aD6/adtEmcl7SPIQYpl+tvWhkerj9X0v92G
         Zc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P7sRBJmE3gU5mLKndoYic2ds2qzZ0LQMpodcKiAN8Yw=;
        b=iH5uRiaFjuuXBvF9p7MeBYmI1tIePGT3X98wYojiMJK6Oa4zkK7EJBvyAf7olLt/of
         DXF1gR8rA7LoLIcYjobh3AaPhp9G1ilC7R1c5n0OOB1dgoDynn1DMZatGdIAS/Pqh6c2
         8eY2FLj2skTASVtMIgKF1IkU1AwaQN+87wFQbzBEu8xc9Ra+duQYDGA3DGWZXphgMdf7
         hI0tAf5ydy/g9/jn/IDM4B4GxKCCHPzIVW6piWddRiSUp6NcbPV+S4iAPkNDj3eFJV2o
         CZAyqKwyERmPuphvmjyH4sHAS0CuF0iBrDjZcWKtR+gb0jvFIV4/yNAjCfHjbvR9Hwg4
         Sieg==
X-Gm-Message-State: APjAAAUQd0DXS6ztmeQ6m4fD07s/hSbbEWb6eET1bDfra3Hsj/srDAxF
        fHsC+IfKrqySd2fyVLq/9MA=
X-Google-Smtp-Source: APXvYqzyrxGVD/+o9s6UEKQtCpORJme7cweYcYymTlNOZ5dXCZS0sP37zp59cypeEZJ0Tme0iMuKXQ==
X-Received: by 2002:a63:258:: with SMTP id 85mr836310pgc.352.1571270252309;
        Wed, 16 Oct 2019 16:57:32 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v8sm286959pje.6.2019.10.16.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:57:31 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] hwmon: (ina3221) Add summation feature support
Date:   Wed, 16 Oct 2019 16:57:02 -0700
Message-Id: <20191016235702.22039-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the summation feature of INA3221, mainly the
SCC (enabling) and SF (warning flag) bits of MASK_ENABLE register,
INA3221_SHUNT_SUM (summation of shunt voltages) register, and the
INA3221_CRIT_SUM (its critical alert setting) register.

Although the summation feature allows user to select which channels
to be added to the result, as an initial support, this patch simply
selects all channels by default, with one only condition: all shunt
resistor values need to be the same. This is because the summation
of current channels can be only accurately calculated, using shunt
voltage sum register, if all shunt resistors are equivalent.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Hi Guenter,

I know my previous questions haven't been answered yet, so nodes
for enabling bits aren't decided completely. But this patch only
adds voltage and its current, and we had a conclusion for these
two already last time. So I think we may add them first. Thanks!

 Documentation/hwmon/ina3221.rst |  12 +++
 drivers/hwmon/ina3221.c         | 163 +++++++++++++++++++++++++++-----
 2 files changed, 153 insertions(+), 22 deletions(-)

diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
index f6007ae8f4e2..bf9051339dec 100644
--- a/Documentation/hwmon/ina3221.rst
+++ b/Documentation/hwmon/ina3221.rst
@@ -41,6 +41,18 @@ curr[123]_max           Warning alert current(mA) setting, activates the
 			average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+in7_input               Summation of shunt voltage(uV) channels
+in7_label               Channel label for summation of shunt voltage
+curr4_input             Summation of current(mA) measurement channels,
+                        (only available when all channels use the same resistor
+                        value for their shunt resistors)
+curr4_crit              Critical alert current(mA) setting for summation of
+                        current measurement, activates the corresponding alarm
+                        when the respective current is above this value
+                        (only effective when all channels use the same resistor
+                        value for their shunt resistors)
+curr4_crit_alarm        Critical alert current limit exceeded for summation of
+                        current measurements.
 samples                 Number of samples using in the averaging mode.
 
                         Supports the list of number of samples:
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 0037e2bdacd6..0a60d7513037 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -31,6 +31,8 @@
 #define INA3221_WARN2			0x0a
 #define INA3221_CRIT3			0x0b
 #define INA3221_WARN3			0x0c
+#define INA3221_SHUNT_SUM		0x0d
+#define INA3221_CRIT_SUM		0x0e
 #define INA3221_MASK_ENABLE		0x0f
 
 #define INA3221_CONFIG_MODE_MASK	GENMASK(2, 0)
@@ -50,6 +52,8 @@
 #define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
+#define INA3221_MASK_ENABLE_SCC_MASK	GENMASK(14, 12)
+
 #define INA3221_CONFIG_DEFAULT		0x7127
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -60,9 +64,11 @@ enum ina3221_fields {
 	/* Status Flags */
 	F_CVRF,
 
-	/* Alert Flags */
+	/* Warning Flags */
 	F_WF3, F_WF2, F_WF1,
-	F_CF3, F_CF2, F_CF1,
+
+	/* Alert Flags: SF is the summation-alert flag */
+	F_SF, F_CF3, F_CF2, F_CF1,
 
 	/* sentinel */
 	F_MAX_FIELDS
@@ -75,6 +81,7 @@ static const struct reg_field ina3221_reg_fields[] = {
 	[F_WF3] = REG_FIELD(INA3221_MASK_ENABLE, 3, 3),
 	[F_WF2] = REG_FIELD(INA3221_MASK_ENABLE, 4, 4),
 	[F_WF1] = REG_FIELD(INA3221_MASK_ENABLE, 5, 5),
+	[F_SF] = REG_FIELD(INA3221_MASK_ENABLE, 6, 6),
 	[F_CF3] = REG_FIELD(INA3221_MASK_ENABLE, 7, 7),
 	[F_CF2] = REG_FIELD(INA3221_MASK_ENABLE, 8, 8),
 	[F_CF1] = REG_FIELD(INA3221_MASK_ENABLE, 9, 9),
@@ -107,6 +114,7 @@ struct ina3221_input {
  * @inputs: Array of channel input source specific structures
  * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
+ * @summation_shunt_resistor: equivalent shunt resistor value for summation
  * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
@@ -116,16 +124,51 @@ struct ina3221_data {
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	struct mutex lock;
 	u32 reg_config;
+	int summation_shunt_resistor;
 
 	bool single_shot;
 };
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 {
+	/* Summation channel checks shunt resistor values */
+	if (channel > INA3221_CHANNEL3)
+		return ina->summation_shunt_resistor != 0;
+
 	return pm_runtime_active(ina->pm_dev) &&
 	       (ina->reg_config & INA3221_CONFIG_CHx_EN(channel));
 }
 
+/**
+ * Helper function to return the resistor value for current summation.
+ *
+ * There is a condition to calculate current summation -- all the shunt
+ * resistor values should be the same, so as to simply fit the formula:
+ *     current summation = shunt voltage summation / shunt resistor
+ *
+ * Returns the equivalent shunt resistor value on success or 0 on failure
+ */
+static inline int ina3221_summation_shunt_resistor(struct ina3221_data *ina)
+{
+	struct ina3221_input *input = ina->inputs;
+	int i, shunt_resistor = 0;
+
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (input[i].disconnected || !input[i].shunt_resistor)
+			continue;
+		if (!shunt_resistor) {
+			/* Found the reference shunt resistor value */
+			shunt_resistor = input[i].shunt_resistor;
+		} else {
+			/* No summation if resistor values are different */
+			if (shunt_resistor != input[i].shunt_resistor)
+				return 0;
+		}
+	}
+
+	return shunt_resistor;
+}
+
 /* Lookup table for Bus and Shunt conversion times in usec */
 static const u16 ina3221_conv_time[] = {
 	140, 204, 332, 588, 1100, 2116, 4156, 8244,
@@ -183,7 +226,14 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 	if (ret)
 		return ret;
 
-	*val = sign_extend32(regval >> 3, 12);
+	/*
+	 * Shunt Voltage Sum register has 14-bit value with 1-bit shift
+	 * Other Shunt Voltage registers have 12 bits with 3-bit shift
+	 */
+	if (reg == INA3221_SHUNT_SUM)
+		*val = sign_extend32(regval >> 1, 14);
+	else
+		*val = sign_extend32(regval >> 3, 12);
 
 	return 0;
 }
@@ -195,6 +245,7 @@ static const u8 ina3221_in_reg[] = {
 	INA3221_SHUNT1,
 	INA3221_SHUNT2,
 	INA3221_SHUNT3,
+	INA3221_SHUNT_SUM,
 };
 
 static int ina3221_read_chip(struct device *dev, u32 attr, long *val)
@@ -224,8 +275,12 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 	u8 reg = ina3221_in_reg[channel];
 	int regval, ret;
 
-	/* Translate shunt channel index to sensor channel index */
-	channel %= INA3221_NUM_CHANNELS;
+	/*
+	 * Translate shunt channel index to sensor channel index except
+	 * the 7th channel (6 since being 0-aligned) is for summation.
+	 */
+	if (channel != 6)
+		channel %= INA3221_NUM_CHANNELS;
 
 	switch (attr) {
 	case hwmon_in_input:
@@ -259,22 +314,29 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 	}
 }
 
-static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS] = {
-	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2, INA3221_SHUNT3 },
-	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3 },
-	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2, INA3221_CRIT3 },
-	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3 },
-	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3 },
+static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS + 1] = {
+	[hwmon_curr_input] = { INA3221_SHUNT1, INA3221_SHUNT2,
+			       INA3221_SHUNT3, INA3221_SHUNT_SUM },
+	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3, 0 },
+	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2,
+			      INA3221_CRIT3, INA3221_CRIT_SUM },
+	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3, 0 },
+	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3, F_SF },
 };
 
 static int ina3221_read_curr(struct device *dev, u32 attr,
 			     int channel, long *val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
-	struct ina3221_input *input = &ina->inputs[channel];
-	int resistance_uo = input->shunt_resistor;
+	struct ina3221_input *input = ina->inputs;
 	u8 reg = ina3221_curr_reg[attr][channel];
-	int regval, voltage_nv, ret;
+	int resistance_uo, voltage_nv;
+	int regval, ret;
+
+	if (channel > INA3221_CHANNEL3)
+		resistance_uo = ina->summation_shunt_resistor;
+	else
+		resistance_uo = input[channel].shunt_resistor;
 
 	switch (attr) {
 	case hwmon_curr_input:
@@ -293,6 +355,9 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		/* fall through */
 	case hwmon_curr_crit:
 	case hwmon_curr_max:
+		if (!resistance_uo)
+			return -ENODATA;
+
 		ret = ina3221_read_value(ina, reg, &regval);
 		if (ret)
 			return ret;
@@ -366,10 +431,18 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
 			      int channel, long val)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
-	struct ina3221_input *input = &ina->inputs[channel];
-	int resistance_uo = input->shunt_resistor;
+	struct ina3221_input *input = ina->inputs;
 	u8 reg = ina3221_curr_reg[attr][channel];
-	int regval, current_ma, voltage_uv;
+	int resistance_uo, current_ma, voltage_uv;
+	int regval;
+
+	if (channel > INA3221_CHANNEL3)
+		resistance_uo = ina->summation_shunt_resistor;
+	else
+		resistance_uo = input[channel].shunt_resistor;
+
+	if (!resistance_uo)
+		return -EOPNOTSUPP;
 
 	/* clamp current */
 	current_ma = clamp_val(val,
@@ -381,8 +454,21 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
 	/* clamp voltage */
 	voltage_uv = clamp_val(voltage_uv, -163800, 163800);
 
-	/* 1 / 40uV(scale) << 3(register shift) = 5 */
-	regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
+	/*
+	 * Formula to convert voltage_uv to register value:
+	 *     regval = (voltage_uv / scale) << shift
+	 * Note:
+	 *     The scale is 40uV for all shunt voltage registers
+	 *     Shunt Voltage Sum register left-shifts 1 bit
+	 *     All other Shunt Voltage registers shift 3 bits
+	 * Results:
+	 *     SHUNT_SUM: (1 / 40uV) << 1 = 1 / 20uV
+	 *     SHUNT[1-3]: (1 / 40uV) << 3 = 1 / 5uV
+	 */
+	if (reg == INA3221_SHUNT_SUM)
+		regval = DIV_ROUND_CLOSEST(voltage_uv, 20) & 0xfffe;
+	else
+		regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
 
 	return regmap_write(ina->regmap, reg, regval);
 }
@@ -499,7 +585,10 @@ static int ina3221_read_string(struct device *dev, enum hwmon_sensor_types type,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	int index = channel - 1;
 
-	*str = ina->inputs[index].label;
+	if (channel == 7)
+		*str = "summation of shunt voltages";
+	else
+		*str = ina->inputs[index].label;
 
 	return 0;
 }
@@ -529,6 +618,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
 		case hwmon_in_label:
 			if (channel - 1 <= INA3221_CHANNEL3)
 				input = &ina->inputs[channel - 1];
+			else if (channel == 7)
+				return 0444;
 			/* Hide label node if label is not provided */
 			return (input && input->label) ? 0444 : 0;
 		case hwmon_in_input:
@@ -573,11 +664,16 @@ static const struct hwmon_channel_info *ina3221_info[] = {
 			   /* 4-6: shunt voltage Channels */
 			   HWMON_I_INPUT,
 			   HWMON_I_INPUT,
-			   HWMON_I_INPUT),
+			   HWMON_I_INPUT,
+			   /* 7: summation of shunt voltage channels */
+			   HWMON_I_INPUT | HWMON_I_LABEL),
 	HWMON_CHANNEL_INFO(curr,
+			   /* 1-3: current channels*/
+			   INA3221_HWMON_CURR_CONFIG,
 			   INA3221_HWMON_CURR_CONFIG,
 			   INA3221_HWMON_CURR_CONFIG,
-			   INA3221_HWMON_CURR_CONFIG),
+			   /* 4: summation of current channels */
+			   HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM),
 	NULL
 };
 
@@ -624,6 +720,9 @@ static ssize_t ina3221_shunt_store(struct device *dev,
 
 	input->shunt_resistor = val;
 
+	/* Update summation_shunt_resistor for summation channel */
+	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
+
 	return count;
 }
 
@@ -642,6 +741,7 @@ ATTRIBUTE_GROUPS(ina3221);
 
 static const struct regmap_range ina3221_yes_ranges[] = {
 	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
+	regmap_reg_range(INA3221_SHUNT_SUM, INA3221_SHUNT_SUM),
 	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
 };
 
@@ -772,6 +872,9 @@ static int ina3221_probe(struct i2c_client *client,
 			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
 	}
 
+	/* Initialize summation_shunt_resistor for summation channel control */
+	ina->summation_shunt_resistor = ina3221_summation_shunt_resistor(ina);
+
 	ina->pm_dev = dev;
 	mutex_init(&ina->lock);
 	dev_set_drvdata(dev, ina);
@@ -875,6 +978,22 @@ static int __maybe_unused ina3221_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* Initialize summation channel control */
+	if (ina->summation_shunt_resistor) {
+		/*
+		 * Take all three channels into summation by default
+		 * Shunt measurements of disconnected channels should
+		 * be 0, so it does not matter for summation.
+		 */
+		ret = regmap_update_bits(ina->regmap, INA3221_MASK_ENABLE,
+					 INA3221_MASK_ENABLE_SCC_MASK,
+					 INA3221_MASK_ENABLE_SCC_MASK);
+		if (ret) {
+			dev_err(dev, "Unable to control summation channel\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1

