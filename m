Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08310C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCEE26743
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEaK0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:26:42 -0400
Received: from aclms3.advantech.com.tw ([125.252.70.86]:15026 "EHLO
        ACLMS3.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaK0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:26:41 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS3.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td81b8d9510ac1401c8e60@ACLMS3.advantech.com.tw>;
 Fri, 31 May 2019 18:26:39 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (nct7904) Add extra sysfs support for fan, voltage and temperature.
Date:   Fri, 31 May 2019 10:26:28 +0000
Message-ID: <20190531102628.28785-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.82]
X-ClientProxiedBy: taipei09.ADVANTECH.CORP (172.20.0.236) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

This patch do 2 jobs as described in below:

1. NCT-7904D also supports reading of channel limitation registers
and SMI status registers for fan, voltage and temperature monitoring,
add below sysfs nodes:

-fan[1-*]_min
-fan[1-*]_alarm
-in[0-*]_min
-in[0-*]_max
-in[0-*]_alarm
-temp[1-*]_max
-temp[1-*]_max_hyst
-temp[1-*]_emergency
-temp[1-*]_emergency_hyst
-temp[1-*]_alarm

2. Add the temp[1-*]_type sysfs to show type of temperature sensor is
thermal diode, thermistor, AMD SB-TSI or Intel PECI.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 492 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 440 insertions(+), 52 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 6a74df6841f0..91d1eb822707 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -55,10 +55,33 @@
 #define DTS_T_CTRL1_REG		0x27
 #define VT_ADC_MD_REG		0x2E
 
+#define VSEN1_HV_LL_REG		0x02	/* Bank 1; 2 regs (HV/LV) per sensor */
+#define VSEN1_LV_LL_REG		0x03	/* Bank 1; 2 regs (HV/LV) per sensor */
+#define VSEN1_HV_HL_REG		0x00	/* Bank 1; 2 regs (HV/LV) per sensor */
+#define VSEN1_LV_HL_REG		0x01	/* Bank 1; 2 regs (HV/LV) per sensor */
+#define SMI_STS1_REG		0xC1	/* Bank 0; SMI Status Register */
+#define SMI_STS5_REG		0xC5	/* Bank 0; SMI Status Register */
+#define SMI_STS7_REG		0xC7	/* Bank 0; SMI Status Register */
+#define SMI_STS8_REG		0xC8	/* Bank 0; SMI Status Register */
+
 #define VSEN1_HV_REG		0x40	/* Bank 0; 2 regs (HV/LV) per sensor */
 #define TEMP_CH1_HV_REG		0x42	/* Bank 0; same as VSEN2_HV */
 #define LTD_HV_REG		0x62	/* Bank 0; 2 regs in VSEN range */
+#define LTD_HV_HL_REG		0x44	/* Bank 1; 1 reg for LTD */
+#define LTD_LV_HL_REG		0x45	/* Bank 1; 1 reg for LTD */
+#define LTD_HV_LL_REG		0x46	/* Bank 1; 1 reg for LTD */
+#define LTD_LV_LL_REG		0x47	/* Bank 1; 1 reg for LTD */
+#define TEMP_CH1_CH_REG		0x05	/* Bank 1; 1 reg for LTD */
+#define TEMP_CH1_W_REG		0x06	/* Bank 1; 1 reg for LTD */
+#define TEMP_CH1_WH_REG		0x07	/* Bank 1; 1 reg for LTD */
+#define TEMP_CH1_C_REG		0x04	/* Bank 1; 1 reg per sensor */
+#define DTS_T_CPU1_C_REG	0x90	/* Bank 1; 1 reg per sensor */
+#define DTS_T_CPU1_CH_REG	0x91	/* Bank 1; 1 reg per sensor */
+#define DTS_T_CPU1_W_REG	0x92	/* Bank 1; 1 reg per sensor */
+#define DTS_T_CPU1_WH_REG	0x93	/* Bank 1; 1 reg per sensor */
 #define FANIN1_HV_REG		0x80	/* Bank 0; 2 regs (HV/LV) per sensor */
+#define FANIN1_HV_HL_REG	0x60	/* Bank 1; 2 regs (HV/LV) per sensor */
+#define FANIN1_LV_HL_REG	0x61	/* Bank 1; 2 regs (HV/LV) per sensor */
 #define T_CPU1_HV_REG		0xA0	/* Bank 0; 2 regs (HV/LV) per sensor */
 
 #define PRTS_REG		0x03	/* Bank 2 */
@@ -67,6 +90,8 @@
 #define FANCTL1_FMR_REG		0x00	/* Bank 3; 1 reg per channel */
 #define FANCTL1_OUT_REG		0x10	/* Bank 3; 1 reg per channel */
 
+#define ENABLE_TSI	BIT(1)
+
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
 };
@@ -81,6 +106,7 @@ struct nct7904_data {
 	u8 fan_mode[FANCTL_MAX];
 	u8 enable_dts;
 	u8 has_dts;
+	u8 temp_mode; /* 0: TR mode, 1: TD mode */
 };
 
 /* Access functions */
@@ -179,6 +205,25 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 			rpm = 1350000 / cnt;
 		*val = rpm;
 		return 0;
+	case hwmon_fan_min:
+		ret = nct7904_read_reg16(data, BANK_1,
+					 FANIN1_HV_HL_REG + channel * 2);
+		if (ret < 0)
+			return ret;
+		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
+		if (cnt == 0x1fff)
+			rpm = 0;
+		else
+			rpm = 1350000 / cnt;
+		*val = rpm;
+		return 0;
+	case hwmon_fan_alarm:
+		ret = nct7904_read_reg(data, BANK_0,
+				       SMI_STS7_REG + (channel >> 3));
+		if (ret < 0)
+			return ret;
+		*val = (ret >> (channel & 0x07)) & 1;
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -188,8 +233,18 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
 {
 	const struct nct7904_data *data = _data;
 
-	if (attr == hwmon_fan_input && data->fanin_mask & (1 << channel))
-		return 0444;
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_alarm:
+		if (data->fanin_mask & (1 << channel))
+			return 0444;
+	case hwmon_fan_min:
+		if (data->fanin_mask & (1 << channel))
+			return 0644;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
@@ -220,6 +275,37 @@ static int nct7904_read_in(struct device *dev, u32 attr, int channel,
 			volt *= 6; /* 0.006V scale */
 		*val = volt;
 		return 0;
+	case hwmon_in_min:
+		ret = nct7904_read_reg16(data, BANK_1,
+					 VSEN1_HV_LL_REG + index * 4);
+		if (ret < 0)
+			return ret;
+		volt = ((ret & 0xff00) >> 5) | (ret & 0x7);
+		if (index < 14)
+			volt *= 2; /* 0.002V scale */
+		else
+			volt *= 6; /* 0.006V scale */
+		*val = volt;
+		return 0;
+	case hwmon_in_max:
+		ret = nct7904_read_reg16(data, BANK_1,
+					 VSEN1_HV_HL_REG + index * 4);
+		if (ret < 0)
+			return ret;
+		volt = ((ret & 0xff00) >> 5) | (ret & 0x7);
+		if (index < 14)
+			volt *= 2; /* 0.002V scale */
+		else
+			volt *= 6; /* 0.006V scale */
+		*val = volt;
+		return 0;
+	case hwmon_in_alarm:
+		ret = nct7904_read_reg(data, BANK_0,
+				       SMI_STS1_REG + (index >> 3));
+		if (ret < 0)
+			return ret;
+		*val = (ret >> (index & 0x07)) & 1;
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -230,9 +316,18 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
 	const struct nct7904_data *data = _data;
 	int index = nct7904_chan_to_index[channel];
 
-	if (channel > 0 && attr == hwmon_in_input &&
-	    (data->vsen_mask & BIT(index)))
-		return 0444;
+	switch (attr) {
+	case hwmon_in_input:
+	case hwmon_in_alarm:
+		if (channel > 0 && (data->vsen_mask & BIT(index)))
+			return 0444;
+	case hwmon_in_min:
+	case hwmon_in_max:
+		if (channel > 0 && (data->vsen_mask & BIT(index)))
+			return 0644;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -242,6 +337,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 {
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret, temp;
+	unsigned int reg1, reg2, reg3;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -259,16 +355,100 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 		temp = ((ret & 0xff00) >> 5) | (ret & 0x7);
 		*val = sign_extend32(temp, 10) * 125;
 		return 0;
+	case hwmon_temp_alarm:
+		if (channel < 5) {
+			ret = nct7904_read_reg(data, BANK_0,
+					       SMI_STS1_REG);
+			if (ret < 0)
+				return ret;
+			*val = (ret >> (channel & 0x07)) & 1;
+		} else {
+			if ((channel - 5) < 4) {
+				ret = nct7904_read_reg(data, BANK_0,
+						       SMI_STS7_REG +
+						       ((channel - 5) >> 3));
+				if (ret < 0)
+					return ret;
+				*val = (ret >> ((channel - 5) & 0x07)) & 1;
+			} else {
+				ret = nct7904_read_reg(data, BANK_0,
+						       SMI_STS8_REG +
+						       ((channel - 5) >> 3));
+				if (ret < 0)
+					return ret;
+				*val = (ret >> (((channel - 5) & 0x07) - 4))
+							& 1;
+			}
+		}
+		return 0;
+	case hwmon_temp_type:
+		if (channel < 5) {
+			if ((data->tcpu_mask >> channel) & 0x01) {
+				if ((data->temp_mode >> channel) & 0x01)
+					*val = 3; /* TD */
+				else
+					*val = 4; /* TR */
+			} else {
+				*val = 0;
+			}
+		} else {
+			if ((data->has_dts >> (channel - 5)) & 0x01) {
+				if (data->enable_dts & ENABLE_TSI)
+					*val = 5; /* TSI */
+				else
+					*val = 6; /* PECI */
+			} else {
+				*val = 0;
+			}
+		}
+		return 0;
+	case hwmon_temp_max:
+		reg1 = LTD_HV_HL_REG;
+		reg2 = TEMP_CH1_C_REG;
+		reg3 = DTS_T_CPU1_C_REG;
+		break;
+	case hwmon_temp_max_hyst:
+		reg1 = LTD_LV_HL_REG;
+		reg2 = TEMP_CH1_CH_REG;
+		reg3 = DTS_T_CPU1_CH_REG;
+		break;
+	case hwmon_temp_emergency:
+		reg1 = LTD_HV_LL_REG;
+		reg2 = TEMP_CH1_W_REG;
+		reg3 = DTS_T_CPU1_W_REG;
+		break;
+	case hwmon_temp_emergency_hyst:
+		reg1 = LTD_LV_LL_REG;
+		reg2 = TEMP_CH1_WH_REG;
+		reg3 = DTS_T_CPU1_WH_REG;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	if (channel == 4)
+		ret = nct7904_read_reg(data, BANK_1, reg1);
+	else if (channel < 5)
+		ret = nct7904_read_reg(data, BANK_1,
+				       reg2 + channel * 8);
+	else
+		ret = nct7904_read_reg(data, BANK_1,
+				       reg3 + (channel - 5) * 4);
+
+	if (ret < 0)
+		return ret;
+	*val = ret * 1000;
+	return 0;
 }
 
 static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
 {
 	const struct nct7904_data *data = _data;
 
-	if (attr == hwmon_temp_input) {
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_alarm:
+	case hwmon_temp_type:
 		if (channel < 5) {
 			if (data->tcpu_mask & BIT(channel))
 				return 0444;
@@ -276,6 +456,19 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
 			if (data->has_dts & BIT(channel - 5))
 				return 0444;
 		}
+	case hwmon_temp_max:
+	case hwmon_temp_max_hyst:
+	case hwmon_temp_emergency:
+	case hwmon_temp_emergency_hyst:
+		if (channel < 5) {
+			if (data->tcpu_mask & BIT(channel))
+				return 0644;
+		} else {
+			if (data->has_dts & BIT(channel - 5))
+				return 0644;
+		}
+	default:
+		break;
 	}
 
 	return 0;
@@ -306,6 +499,139 @@ static int nct7904_read_pwm(struct device *dev, u32 attr, int channel,
 	}
 }
 
+static int nct7904_write_temp(struct device *dev, u32 attr, int channel,
+			      long val)
+{
+	struct nct7904_data *data = dev_get_drvdata(dev);
+	int ret, index;
+	unsigned int reg1, reg2, reg3;
+
+	index = nct7904_chan_to_index[channel];
+	val = clamp_val(val / 1000, -128, 127);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		reg1 = LTD_HV_HL_REG;
+		reg2 = TEMP_CH1_C_REG;
+		reg3 = DTS_T_CPU1_C_REG;
+		break;
+	case hwmon_temp_max_hyst:
+		reg1 = LTD_LV_HL_REG;
+		reg2 = TEMP_CH1_CH_REG;
+		reg3 = DTS_T_CPU1_CH_REG;
+		break;
+	case hwmon_temp_emergency:
+		reg1 = LTD_HV_LL_REG;
+		reg2 = TEMP_CH1_W_REG;
+		reg3 = DTS_T_CPU1_W_REG;
+		break;
+	case hwmon_temp_emergency_hyst:
+		reg1 = LTD_LV_LL_REG;
+		reg2 = TEMP_CH1_WH_REG;
+		reg3 = DTS_T_CPU1_WH_REG;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (channel == 4)
+		ret = nct7904_write_reg(data, BANK_1, reg1, val);
+	else if (channel < 5)
+		ret = nct7904_write_reg(data, BANK_1,
+					reg2 + channel * 8, val);
+	else
+		ret = nct7904_write_reg(data, BANK_1,
+					reg3 + (channel - 5) * 4, val);
+
+	return ret;
+}
+
+static int nct7904_write_fan(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct nct7904_data *data = dev_get_drvdata(dev);
+	int ret;
+	u8 tmp;
+
+	switch (attr) {
+	case hwmon_fan_min:
+		if (val <= 0)
+			return 0x1fff;
+
+		val = clamp_val((1350000 + (val >> 1)) / val, 1, 0x1fff);
+		tmp = (val >> 5) & 0xff;
+		ret = nct7904_write_reg(data, BANK_1,
+					FANIN1_HV_HL_REG + channel * 2, tmp);
+		if (ret < 0)
+			return ret;
+		tmp = val & 0x1f;
+		ret = nct7904_write_reg(data, BANK_1,
+					FANIN1_LV_HL_REG + channel * 2, tmp);
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7904_write_in(struct device *dev, u32 attr, int channel,
+			    long val)
+{
+	struct nct7904_data *data = dev_get_drvdata(dev);
+	int ret, index;
+	u8 tmp;
+
+	index = nct7904_chan_to_index[channel];
+
+	if (index < 14)
+		val = val / 2; /* 0.002V scale */
+	else
+		val = val / 6; /* 0.006V scale */
+
+	val = clamp_val(val, 0, 0x7ff); /* Bit 15 is sign bit */
+
+	switch (attr) {
+	case hwmon_in_min:
+		tmp = nct7904_read_reg(data, BANK_1,
+				       VSEN1_LV_LL_REG + index * 4);
+		if (tmp < 0)
+			return tmp;
+		tmp &= ~0x7;
+		tmp |= val & 0x7;
+		ret = nct7904_write_reg(data, BANK_1,
+					VSEN1_LV_LL_REG + index * 4, tmp);
+		if (ret < 0)
+			return ret;
+		tmp = nct7904_read_reg(data, BANK_1,
+				       VSEN1_HV_LL_REG + index * 4);
+		if (tmp < 0)
+			return tmp;
+		tmp = (val >> 3) & 0xff;
+		ret = nct7904_write_reg(data, BANK_1,
+					VSEN1_HV_LL_REG + index * 4, tmp);
+		return ret;
+	case hwmon_in_max:
+		tmp = nct7904_read_reg(data, BANK_1,
+				       VSEN1_LV_HL_REG + index * 4);
+		if (tmp < 0)
+			return tmp;
+		tmp &= ~0x7;
+		tmp |= val & 0x7;
+		ret = nct7904_write_reg(data, BANK_1,
+					VSEN1_LV_HL_REG + index * 4, tmp);
+		if (ret < 0)
+			return ret;
+		tmp = nct7904_read_reg(data, BANK_1,
+				       VSEN1_HV_LL_REG + index * 4);
+		if (tmp < 0)
+			return tmp;
+		tmp = (val >> 3) & 0xff;
+		ret = nct7904_write_reg(data, BANK_1,
+					VSEN1_HV_LL_REG + index * 4, tmp);
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int nct7904_write_pwm(struct device *dev, u32 attr, int channel,
 			     long val)
 {
@@ -363,8 +689,14 @@ static int nct7904_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
 	switch (type) {
+	case hwmon_in:
+		return nct7904_write_in(dev, attr, channel, val);
+	case hwmon_fan:
+		return nct7904_write_fan(dev, attr, channel, val);
 	case hwmon_pwm:
 		return nct7904_write_pwm(dev, attr, channel, val);
+	case hwmon_temp:
+		return nct7904_write_temp(dev, attr, channel, val);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -413,51 +745,91 @@ static int nct7904_detect(struct i2c_client *client,
 
 static const struct hwmon_channel_info *nct7904_info[] = {
 	HWMON_CHANNEL_INFO(in,
-			   HWMON_I_INPUT, /* dummy, skipped in is_visible */
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT,
-			   HWMON_I_INPUT),
+			   /* dummy, skipped in is_visible */
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM,
+			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
+			   HWMON_I_ALARM),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT,
-			   HWMON_F_INPUT),
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT,
-			   HWMON_T_INPUT),
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_MAX |
+			   HWMON_T_MAX_HYST | HWMON_T_TYPE | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_HYST),
 	NULL
 };
 
@@ -515,6 +887,8 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* CPU_TEMP attributes */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL0_REG);
+	if (ret < 0)
+		return ret;
 
 	if ((ret & 0x6) == 0x6)
 		data->tcpu_mask |= 1; /* TR1 */
@@ -527,37 +901,51 @@ static int nct7904_probe(struct i2c_client *client,
 
 	/* LTD */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_CTRL2_REG);
+	if (ret < 0)
+		return ret;
 	if ((ret & 0x02) == 0x02)
 		data->tcpu_mask |= 0x10;
 
 	/* Multi-Function detecting for Volt and TR/TD */
 	ret = nct7904_read_reg(data, BANK_0, VT_ADC_MD_REG);
+	if (ret < 0)
+		return ret;
 
+	data->temp_mode = 0;
 	for (i = 0; i < 4; i++) {
 		val = (ret & (0x03 << i)) >> (i * 2);
 		bit = (1 << i);
 		if (val == 0)
 			data->tcpu_mask &= ~bit;
+		else if (val == 0x1 || val == 0x2)
+			data->temp_mode |= bit;
 	}
 
 	/* PECI */
 	ret = nct7904_read_reg(data, BANK_2, PFE_REG);
+	if (ret < 0)
+		return ret;
 	if (ret & 0x80) {
-		data->enable_dts = 1; //Enable DTS & PECI
+		data->enable_dts = 1; /* Enable DTS & PECI */
 	} else {
 		ret = nct7904_read_reg(data, BANK_2, TSI_CTRL_REG);
+		if (ret < 0)
+			return ret;
 		if (ret & 0x80)
-			data->enable_dts = 0x3; //Enable DTS & TSI
+			data->enable_dts = 0x3; /* Enable DTS & TSI */
 	}
 
 	/* Check DTS enable status */
 	if (data->enable_dts) {
-		data->has_dts =
-			nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
-		if (data->enable_dts & 0x2) {
-			data->has_dts |=
-			(nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG) & 0xF)
-								<< 4;
+		ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL0_REG) & 0xF;
+		if (ret < 0)
+			return ret;
+		data->has_dts = ret;
+		if (data->enable_dts & ENABLE_TSI) {
+			ret = nct7904_read_reg(data, BANK_0, DTS_T_CTRL1_REG);
+			if (ret < 0)
+				return ret;
+			data->has_dts |= (ret & 0xF) << 4;
 		}
 	}
 
-- 
2.17.1

