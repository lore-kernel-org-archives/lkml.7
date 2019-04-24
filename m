Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E58C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA5A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfDXJGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:06:38 -0400
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:35660 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbfDXJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:06:37 -0400
Received: from jax4mhob24.registeredsite.com (jax4mhob24.registeredsite.com [64.69.218.112])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3O90mJh018360
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:00:49 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob24.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3O90joA135313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:00:45 -0400
Received: (qmail 20703 invoked by uid 0); 24 Apr 2019 09:00:45 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 24 Apr 2019 09:00:45 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk: Add Si5341/Si5340 driver
Date:   Wed, 24 Apr 2019 11:00:38 +0200
Message-Id: <20190424090038.18353-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a driver for the Si5341 and Si5340 chips. The driver does not fully
support all features of these chips, but allows the chip to be used
without any support from the "clockbuilder pro" software.

If the chip is preprogrammed, that is, you bought one with some defaults
burned in, or you programmed the NVM in some way, the driver will just
take over the current settings and only change them on demand. Otherwise
the input must a fixed XTAL in its most basic configuration (no
predividers, no feedback, etc.).

The driver supports dynamic changes of multisynth, output dividers and
enabling or powering down outputs and multisynths.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/Kconfig      |   11 +
 drivers/clk/Makefile     |    1 +
 drivers/clk/clk-si5341.c | 1452 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1464 insertions(+)
 create mode 100644 drivers/clk/clk-si5341.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e705aab9e38b..4824bb372b36 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -90,6 +90,17 @@ config COMMON_CLK_SCPI
 	  This driver uses SCPI Message Protocol to interact with the
 	  firmware providing all the clock controls.
 
+
+config COMMON_CLK_SI5341
+	tristate "Clock driver for SiLabs 5341 and 5340 A/B/C/D devices"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver supports Silicon Labs 5341 and 5340 programmable clock
+	  generators. For proper operation, the device needs to be
+	  pre-programmed either using NVM or a firmware "blob" with register
+	  settings created by the silabs clock creator software.
+
 config COMMON_CLK_SI5351
 	tristate "Clock driver for SiLabs 5351A/B/C"
 	depends on I2C
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1db133652f0c..4a7aa4a01fef 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
 obj-$(CONFIG_COMMON_CLK_SCPI)           += clk-scpi.o
+obj-$(CONFIG_COMMON_CLK_SI5341)		+= clk-si5341.o
 obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
 obj-$(CONFIG_COMMON_CLK_SI544)		+= clk-si544.o
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
new file mode 100644
index 000000000000..0d636658853b
--- /dev/null
+++ b/drivers/clk/clk-si5341.c
@@ -0,0 +1,1452 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Silicon Labs Si5341/Si5340 Clock generator
+ * Copyright (C) 2019 Topic Embedded Products
+ * Author: Mike Looijmans <mike.looijmans@topic.nl>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/gcd.h>
+#include <linux/math64.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define SI5341_MAX_NUM_OUTPUTS 10
+#define SI5340_MAX_NUM_OUTPUTS 4
+
+#define SI5341_NUM_SYNTH 5
+#define SI5340_NUM_SYNTH 4
+
+/* Range of the synthesizer fractional divider */
+#define SI5341_SYNTH_N_MIN	10
+#define SI5341_SYNTH_N_MAX	4095
+
+/* The chip can get its input clock from 3 input pins or an XTAL */
+
+/* There is one PLL running at 13500–14256 MHz */
+#define SI5341_PLL_VCO_MIN 13500000000ull
+#define SI5341_PLL_VCO_MAX 14256000000ull
+
+/* The 5 frequency synthesizers obtain their input from the PLL */
+struct clk_si5341_synth {
+	struct clk_hw hw;
+	struct clk_si5341 *data;
+	u8 index;
+};
+#define to_clk_si5341_synth(_hw) \
+	container_of(_hw, struct clk_si5341_synth, hw)
+
+/* The output stages can be connected to any synth (full mux) */
+struct clk_si5341_output {
+	struct clk_hw hw;
+	struct clk_si5341 *data;
+	u8 index;
+};
+#define to_clk_si5341_output(_hw) \
+	container_of(_hw, struct clk_si5341_output, hw)
+
+struct clk_si5341 {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	struct i2c_client *i2c_client;
+	struct clk_si5341_synth synth[SI5341_NUM_SYNTH];
+	struct clk_si5341_output clk[SI5341_MAX_NUM_OUTPUTS];
+	struct clk *pxtal;
+	const char *pxtal_name;
+	const u16 *reg_output_offset;
+	const u16 *reg_rdiv_offset;
+	u64 freq_vco; /* 13500–14256 MHz */
+	u8 num_outputs;
+	u8 num_synth;
+};
+#define to_clk_si5341(_hw)	container_of(_hw, struct clk_si5341, hw)
+
+struct clk_si5341_output_config {
+	u8 source_index;
+	u8 out_format_drv_bits;
+	u8 out_cm_ampl_bits;
+	bool synth_master;
+	bool always_on;
+	u32 synth_frequency;
+	u32 clock_frequency;
+};
+
+#define SI5341_PAGE		0x0001
+#define SI5341_PN_BASE		0x0002
+#define SI5341_DEVICE_REV	0x0005
+#define SI5341_STATUS		0x000C
+#define SI5341_SOFT_RST		0x001C
+
+/* Input dividers (48-bit) */
+#define SI5341_IN_PDIV(x)	(0x0208 + ((x) * 10))
+#define SI5341_IN_PSET(x)	(0x020E + ((x) * 10))
+
+/* PLL configuration */
+#define SI5341_PLL_M_NUM	0x0235
+#define SI5341_PLL_M_DEN	0x023B
+
+/* Output configuration */
+#define SI5341_OUT_CONFIG(output)	\
+			((output)->data->reg_output_offset[(output)->index])
+#define SI5341_OUT_FORMAT(output)	(SI5341_OUT_CONFIG(output) + 1)
+#define SI5341_OUT_CM(output)		(SI5341_OUT_CONFIG(output) + 2)
+#define SI5341_OUT_MUX_SEL(output)	(SI5341_OUT_CONFIG(output) + 3)
+#define SI5341_OUT_R_REG(output)	\
+			((output)->data->reg_rdiv_offset[(output)->index])
+
+/* Synthesize N divider */
+#define SI5341_SYNTH_N_NUM(x)	(0x0302 + ((x) * 11))
+#define SI5341_SYNTH_N_DEN(x)	(0x0308 + ((x) * 11))
+#define SI5341_SYNTH_N_UPD(x)	(0x030C + ((x) * 11))
+
+/* Synthesizer output enable, phase bypass, power mode */
+#define SI5341_SYNTH_N_CLK_TO_OUTX_EN	0x0A03
+#define SI5341_SYNTH_N_PIBYP		0x0A04
+#define SI5341_SYNTH_N_PDNB		0x0A05
+#define SI5341_SYNTH_N_CLK_DIS		0x0B4A
+
+/* SI5341_OUT_CONFIG bits */
+#define SI5341_OUT_CFG_PDN		BIT(0)
+#define SI5341_OUT_CFG_OE		BIT(1)
+#define SI5341_OUT_CFG_RDIV_FORCE2	BIT(2)
+
+/* Static configuration (to be moved to firmware) */
+struct si5341_reg_default {
+	u16 address;
+	u8 value;
+};
+
+/* Output configuration registers 0..9 are not quite logically organized */
+static const u16 si5341_reg_output_offset[] = {
+	0x0108,
+	0x010D,
+	0x0112,
+	0x0117,
+	0x011C,
+	0x0121,
+	0x0126,
+	0x012B,
+	0x0130,
+	0x013A,
+};
+static const u16 si5340_reg_output_offset[] = {
+	0x0112,
+	0x0117,
+	0x0126,
+	0x012B,
+};
+
+/* The location of the R divider registers */
+static const u16 si5341_reg_rdiv_offset[] = {
+	0x024A,
+	0x024D,
+	0x0250,
+	0x0253,
+	0x0256,
+	0x0259,
+	0x025C,
+	0x025F,
+	0x0262,
+	0x0268,
+};
+static const u16 si5340_reg_rdiv_offset[] = {
+	0x0250,
+	0x0253,
+	0x025C,
+	0x025F,
+};
+
+/*
+ * Programming sequence from ClockBuilder, settings to initialize the system
+ * using only the XTAL input, without pre-divider.
+ * This also contains settings that aren't mentioned anywhere in the datasheet.
+ * The "known" settings like synth and output configuration are done later.
+ */
+static const struct si5341_reg_default si5341_reg_defaults[] = {
+	{ 0x0017, 0x3A }, /* INT mask (disable interrupts) */
+	{ 0x0018, 0xFF }, /* INT mask */
+	{ 0x0021, 0x0F }, /* Select XTAL as input */
+	{ 0x0022, 0x00 }, /* Not in datasheet */
+	{ 0x002B, 0x02 }, /* SPI config */
+	{ 0x002C, 0x20 }, /* LOS enable for XTAL */
+	{ 0x002D, 0x00 }, /* LOS timing */
+	{ 0x002E, 0x00 },
+	{ 0x002F, 0x00 },
+	{ 0x0030, 0x00 },
+	{ 0x0031, 0x00 },
+	{ 0x0032, 0x00 },
+	{ 0x0033, 0x00 },
+	{ 0x0034, 0x00 },
+	{ 0x0035, 0x00 },
+	{ 0x0036, 0x00 },
+	{ 0x0037, 0x00 },
+	{ 0x0038, 0x00 }, /* LOS setting (thresholds) */
+	{ 0x0039, 0x00 },
+	{ 0x003A, 0x00 },
+	{ 0x003B, 0x00 },
+	{ 0x003C, 0x00 },
+	{ 0x003D, 0x00 }, /* LOS setting (thresholds) end */
+	{ 0x0041, 0x00 }, /* LOS0_DIV_SEL */
+	{ 0x0042, 0x00 }, /* LOS1_DIV_SEL */
+	{ 0x0043, 0x00 }, /* LOS2_DIV_SEL */
+	{ 0x0044, 0x00 }, /* LOS3_DIV_SEL */
+	{ 0x009E, 0x00 }, /* Not in datasheet */
+	{ 0x0102, 0x01 }, /* Enable outputs */
+	{ 0x013F, 0x00 }, /* Not in datasheet */
+	{ 0x0140, 0x00 }, /* Not in datasheet */
+	{ 0x0141, 0x40 }, /* OUT LOS */
+	{ 0x0202, 0x00 }, /* XAXB_FREQ_OFFSET (=0)*/
+	{ 0x0203, 0x00 },
+	{ 0x0204, 0x00 },
+	{ 0x0205, 0x00 },
+	{ 0x0206, 0x00 }, /* PXAXB (2^x) */
+	{ 0x0208, 0x00 }, /* Px divider setting (usually 0) */
+	{ 0x0209, 0x00 },
+	{ 0x020A, 0x00 },
+	{ 0x020B, 0x00 },
+	{ 0x020C, 0x00 },
+	{ 0x020D, 0x00 },
+	{ 0x020E, 0x00 },
+	{ 0x020F, 0x00 },
+	{ 0x0210, 0x00 },
+	{ 0x0211, 0x00 },
+	{ 0x0212, 0x00 },
+	{ 0x0213, 0x00 },
+	{ 0x0214, 0x00 },
+	{ 0x0215, 0x00 },
+	{ 0x0216, 0x00 },
+	{ 0x0217, 0x00 },
+	{ 0x0218, 0x00 },
+	{ 0x0219, 0x00 },
+	{ 0x021A, 0x00 },
+	{ 0x021B, 0x00 },
+	{ 0x021C, 0x00 },
+	{ 0x021D, 0x00 },
+	{ 0x021E, 0x00 },
+	{ 0x021F, 0x00 },
+	{ 0x0220, 0x00 },
+	{ 0x0221, 0x00 },
+	{ 0x0222, 0x00 },
+	{ 0x0223, 0x00 },
+	{ 0x0224, 0x00 },
+	{ 0x0225, 0x00 },
+	{ 0x0226, 0x00 },
+	{ 0x0227, 0x00 },
+	{ 0x0228, 0x00 },
+	{ 0x0229, 0x00 },
+	{ 0x022A, 0x00 },
+	{ 0x022B, 0x00 },
+	{ 0x022C, 0x00 },
+	{ 0x022D, 0x00 },
+	{ 0x022E, 0x00 },
+	{ 0x022F, 0x00 }, /* Px divider setting (usually 0) end */
+	{ 0x026B, 0x00 }, /* DESIGN_ID (ASCII string) */
+	{ 0x026C, 0x00 },
+	{ 0x026D, 0x00 },
+	{ 0x026E, 0x00 },
+	{ 0x026F, 0x00 },
+	{ 0x0270, 0x00 },
+	{ 0x0271, 0x00 },
+	{ 0x0272, 0x00 }, /* DESIGN_ID (ASCII string) end */
+	{ 0x0339, 0x1F }, /* N_FSTEP_MSK */
+	{ 0x033B, 0x00 }, /* Nx_FSTEPW (Frequency step) */
+	{ 0x033C, 0x00 },
+	{ 0x033D, 0x00 },
+	{ 0x033E, 0x00 },
+	{ 0x033F, 0x00 },
+	{ 0x0340, 0x00 },
+	{ 0x0341, 0x00 },
+	{ 0x0342, 0x00 },
+	{ 0x0343, 0x00 },
+	{ 0x0344, 0x00 },
+	{ 0x0345, 0x00 },
+	{ 0x0346, 0x00 },
+	{ 0x0347, 0x00 },
+	{ 0x0348, 0x00 },
+	{ 0x0349, 0x00 },
+	{ 0x034A, 0x00 },
+	{ 0x034B, 0x00 },
+	{ 0x034C, 0x00 },
+	{ 0x034D, 0x00 },
+	{ 0x034E, 0x00 },
+	{ 0x034F, 0x00 },
+	{ 0x0350, 0x00 },
+	{ 0x0351, 0x00 },
+	{ 0x0352, 0x00 },
+	{ 0x0353, 0x00 },
+	{ 0x0354, 0x00 },
+	{ 0x0355, 0x00 },
+	{ 0x0356, 0x00 },
+	{ 0x0357, 0x00 },
+	{ 0x0358, 0x00 }, /* Nx_FSTEPW (Frequency step) end */
+	{ 0x0359, 0x00 }, /* Nx_DELAY */
+	{ 0x035A, 0x00 },
+	{ 0x035B, 0x00 },
+	{ 0x035C, 0x00 },
+	{ 0x035D, 0x00 },
+	{ 0x035E, 0x00 },
+	{ 0x035F, 0x00 },
+	{ 0x0360, 0x00 },
+	{ 0x0361, 0x00 },
+	{ 0x0362, 0x00 }, /* Nx_DELAY end */
+	{ 0x0802, 0x00 }, /* Not in datasheet */
+	{ 0x0803, 0x00 }, /* Not in datasheet */
+	{ 0x0804, 0x00 }, /* Not in datasheet */
+	{ 0x090E, 0x02 }, /* XAXB_EXTCLK_EN=0 XAXB_PDNB=1 (use XTAL) */
+	{ 0x091C, 0x04 }, /* ZDM_EN=4 (Normal mode) */
+	{ 0x0943, 0x00 }, /* IO_VDD_SEL=0 (0=1v8, use 1=3v3) */
+	{ 0x0949, 0x00 }, /* IN_EN (disable input clocks) */
+	{ 0x094A, 0x00 }, /* INx_TO_PFD_EN (disabled) */
+	{ 0x0A02, 0x00 }, /* Not in datasheet */
+	{ 0x0B44, 0x0F }, /* PDIV_ENB (datasheet does not mention what it is) */
+};
+
+/* Read and interpret a 44-bit followed by a 32-bit value in the regmap */
+static int si5341_decode_44_32(struct regmap *regmap, unsigned int reg,
+	u64 *val1, u32 *val2)
+{
+	int err;
+	u8 r[10];
+
+	err = regmap_bulk_read(regmap, reg, r, 10);
+	if (err < 0)
+		return err;
+
+	*val1 = ((u64)((r[5] & 0x0f) << 8 | r[4]) << 32) |
+			(u32)(r[3] << 24 | r[2] << 16 | r[1] << 8 | r[0]);
+	*val2 = r[9] << 24 | r[8] << 16 | r[7] << 8 | r[6];
+
+	return 0;
+}
+
+static int si5341_encode_44_32(struct regmap *regmap, unsigned int reg,
+	u64 n_num, u32 n_den)
+{
+	u8 r[10];
+
+	/* Shift left as far as possible without overflowing */
+	while (!(n_num & BIT(43)) && !(n_den & BIT(31))) {
+		n_num <<= 1;
+		n_den <<= 1;
+	}
+
+	/* 44 bits (6 bytes) numerator */
+	r[0] = n_num & 0xff;
+	r[1] = (n_num >> 8) & 0xff;
+	r[2] = (n_num >> 16) & 0xff;
+	r[3] = (n_num >> 24) & 0xff;
+	r[4] = (n_num >> 32) & 0xff;
+	r[5] = (n_num >> 40) & 0x0f;
+	/* 32 bits denominator */
+	r[6] = n_den & 0xff;
+	r[7] = (n_den >> 8) & 0xff;
+	r[8] = (n_den >> 16) & 0xff;
+	r[9] = (n_den >> 24) & 0xff;
+
+	/* Program the fraction */
+	return regmap_bulk_write(regmap, reg, r, sizeof(r));
+}
+
+/* VCO, we assume it runs at a constant frequency */
+static unsigned long si5341_clk_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_si5341 *data = to_clk_si5341(hw);
+	int err;
+	u64 res;
+	u64 m_num;
+	u32 m_den;
+	unsigned int shift;
+
+	/* Assume that PDIV is not being used, just read the PLL setting */
+	err = si5341_decode_44_32(data->regmap, SI5341_PLL_M_NUM,
+				&m_num, &m_den);
+	if (err < 0)
+		return 0;
+
+	if (!m_num || !m_den)
+		return 0;
+
+	/*
+	 * Though m_num is 64-bit, only the upper bits are actually used. While
+	 * calculating m_num and m_den, they are shifted as far as possible to
+	 * the left. To avoid 96-bit division here, we just shift them back so
+	 * we can do with just 64 bits.
+	 */
+	shift = 0;
+	res = m_num;
+	while (res & 0xffff00000000) {
+		++shift;
+		res >>= 1;
+	}
+	res *= parent_rate;
+	do_div(res, (m_den >> shift));
+
+	dev_dbg(&data->i2c_client->dev,
+		"%s(p=%lu) m=0x%llx/0x%x shift=%u res=%llu\n",
+		__func__, parent_rate, m_num, m_den, shift, res);
+
+	/* We cannot return the actual frequency in 32 bit, store it locally */
+	data->freq_vco = res;
+
+	/* Report kHz since the value is out of range */
+	do_div(res, 1000);
+
+	return (unsigned long)res;
+}
+
+static const struct clk_ops si5341_clk_ops = {
+	.recalc_rate = si5341_clk_recalc_rate,
+};
+
+/* Synthesizers, there are 5 synthesizers that connect to any of the outputs */
+
+/* The synthesizer is on if all power and enable bits are set */
+static int si5341_synth_clk_is_on(struct clk_hw *hw)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	int err;
+	u32 val;
+	u8 index = synth->index;
+
+	err = regmap_read(synth->data->regmap,
+			SI5341_SYNTH_N_CLK_TO_OUTX_EN, &val);
+	if (err < 0)
+		return err;
+
+	dev_dbg(&synth->data->i2c_client->dev, "%s(%u): %#x\n",
+			__func__, index, val);
+
+	if (!(val & BIT(index)))
+		return false;
+
+	err = regmap_read(synth->data->regmap, SI5341_SYNTH_N_PDNB, &val);
+	if (err < 0)
+		return err;
+
+	if (!(val & BIT(index)))
+		return false;
+
+	/* This bit must be 0 for the synthesizer to receive clock input */
+	err = regmap_read(synth->data->regmap, SI5341_SYNTH_N_CLK_DIS, &val);
+	if (err < 0)
+		return err;
+
+	return !(val & BIT(index));
+}
+
+static void si5341_synth_clk_unprepare(struct clk_hw *hw)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	u8 index = synth->index;
+	u8 mask = BIT(index);
+
+	dev_dbg(&synth->data->i2c_client->dev, "%s(%u)\n", __func__, index);
+
+	/* Disable output */
+	regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_CLK_TO_OUTX_EN, mask, 0);
+	/* Power down */
+	regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_PDNB, mask, 0);
+	/* Disable clock input to synth (set to 1 to disable) */
+	regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_CLK_DIS, mask, mask);
+}
+
+static int si5341_synth_clk_prepare(struct clk_hw *hw)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	int err;
+	u8 index = synth->index;
+	u8 mask = BIT(index);
+
+	dev_dbg(&synth->data->i2c_client->dev, "%s(%u)\n", __func__, index);
+
+	/* Power up */
+	err = regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_PDNB, mask, mask);
+	if (err < 0)
+		return err;
+
+	/* Enable clock input to synth (set bit to 0 to enable) */
+	err = regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_CLK_DIS, mask, 0);
+	if (err < 0)
+		return err;
+
+	/* Enable output */
+	return regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_CLK_TO_OUTX_EN, mask, mask);
+}
+
+/* Synth clock frequency: Fvco * n_den / n_den, with Fvco in 13500-14256 MHz */
+static unsigned long si5341_synth_clk_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	u64 f;
+	u64 n_num;
+	u32 n_den;
+	int err;
+
+	err = si5341_decode_44_32(synth->data->regmap,
+			SI5341_SYNTH_N_NUM(synth->index), &n_num, &n_den);
+	if (err < 0)
+		return err;
+
+	/*
+	 * n_num and n_den are shifted left as much as possible, so to prevent
+	 * overflow in 64-bit math, we shift n_den 4 bits to the right
+	 */
+	f = synth->data->freq_vco;
+	f *= (n_den >> 4);
+
+	/* Now we need to to 64-bit division: f/n_num */
+	/* And compensate for the 4 bits we dropped */
+	f = div64_u64(f, (n_num >> 4));
+
+	dev_dbg(&synth->data->i2c_client->dev,
+			"%s(%u) p=%lu n=0x%llx d=0x%x f=%llu\n",
+			__func__, synth->index, parent_rate, n_num, n_den, f);
+
+	return (unsigned long)f;
+}
+
+static long si5341_synth_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	u64 f;
+
+	dev_dbg(&synth->data->i2c_client->dev, "%s(%u) r=%lu p=%lu\n",
+			__func__, synth->index, rate, *parent_rate);
+
+	/* The synthesizer accuracy is such that anything in range will work */
+	f = synth->data->freq_vco;
+	do_div(f, SI5341_SYNTH_N_MAX);
+	if (rate < (unsigned long)f)
+		return (long)f;
+
+	f = synth->data->freq_vco;
+	do_div(f, SI5341_SYNTH_N_MIN);
+	if (rate > (unsigned long)f)
+		return (long)f;
+
+	return (long)rate;
+}
+
+static int si5341_synth_program(struct clk_si5341_synth *synth,
+	u64 n_num, u32 n_den, bool is_integer)
+{
+	int err;
+	u8 index = synth->index;
+
+	err = si5341_encode_44_32(synth->data->regmap,
+			SI5341_SYNTH_N_NUM(index), n_num, n_den);
+
+	/* Set the bit that indicates if the fraction is integer */
+	err = regmap_update_bits(synth->data->regmap,
+		SI5341_SYNTH_N_PIBYP, BIT(index), is_integer ? BIT(index) : 0);
+	if (err < 0)
+		return err;
+
+	/* Write to the update bit to make the change take effect */
+	return regmap_write(synth->data->regmap,
+		SI5341_SYNTH_N_UPD(index), 0x01);
+}
+
+
+static int si5341_synth_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_si5341_synth *synth = to_clk_si5341_synth(hw);
+	u64 n_num;
+	u32 n_den;
+	u32 r;
+	u32 g;
+	bool is_integer;
+
+	dev_dbg(&synth->data->i2c_client->dev, "%s(%u) r=%lu p=%lu\n",
+			__func__, synth->index, rate, parent_rate);
+
+	/* obvious solution */
+	n_num = synth->data->freq_vco;
+	n_den = rate;
+
+	/* see if there's an integer solution */
+	r = do_div(n_num, rate);
+	is_integer = (r == 0);
+	if (is_integer) {
+		/* Integer divider equal to n_num */
+		n_den = 1;
+	} else {
+		/* Calculate a fractional solution */
+		g = gcd(r, rate);
+		n_den = rate / g;
+		n_num *= n_den;
+		n_num += r / g;
+	}
+
+	dev_dbg(&synth->data->i2c_client->dev,
+			"%s(%u): n=0x%llx d=0x%x %s\n", __func__,
+				synth->index, n_num, n_den,
+				is_integer ? "int" : "frac");
+
+	return si5341_synth_program(synth, n_num, n_den, is_integer);
+}
+
+static const struct clk_ops si5341_synth_clk_ops = {
+	.is_prepared = si5341_synth_clk_is_on,
+	.prepare = si5341_synth_clk_prepare,
+	.unprepare = si5341_synth_clk_unprepare,
+	.recalc_rate = si5341_synth_clk_recalc_rate,
+	.round_rate = si5341_synth_clk_round_rate,
+	.set_rate = si5341_synth_clk_set_rate,
+};
+
+static int si5341_output_clk_is_on(struct clk_hw *hw)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	int err;
+	u32 val;
+
+	err = regmap_read(output->data->regmap,
+			SI5341_OUT_CONFIG(output), &val);
+	if (err < 0)
+		return err;
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u): %#x\n",
+			__func__, output->index, val);
+
+	/* Bit 0=PDN, 1=OE so only a value of 0x2 enables the output */
+	return (val & 0x03) == SI5341_OUT_CFG_OE;
+}
+
+static void si5341_output_clk_unprepare(struct clk_hw *hw)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u)\n",
+			__func__, output->index);
+
+	/* Disable and then power down the output */
+	regmap_update_bits(output->data->regmap,
+			SI5341_OUT_CONFIG(output),
+			SI5341_OUT_CFG_OE, 0);
+	regmap_update_bits(output->data->regmap,
+			SI5341_OUT_CONFIG(output),
+			SI5341_OUT_CFG_PDN, SI5341_OUT_CFG_PDN);
+}
+
+static int si5341_output_clk_prepare(struct clk_hw *hw)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	int err;
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u)\n",
+			__func__, output->index);
+
+	/* Power up first, then enable the output */
+	err = regmap_update_bits(output->data->regmap,
+			SI5341_OUT_CONFIG(output),
+			SI5341_OUT_CFG_PDN, 0);
+	if (err < 0)
+		return err;
+
+	return regmap_update_bits(output->data->regmap,
+			SI5341_OUT_CONFIG(output),
+			SI5341_OUT_CFG_OE, SI5341_OUT_CFG_OE);
+}
+
+static unsigned long si5341_output_clk_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	int err;
+	u32 val;
+	u32 r_divider;
+	u8 r[3];
+
+	err = regmap_read(output->data->regmap,
+			SI5341_OUT_CONFIG(output), &val);
+	if (err < 0)
+		return err;
+
+	/* If bit(2) is set, the divider is forcibly set to "2" */
+	if (val & SI5341_OUT_CFG_RDIV_FORCE2) {
+		r_divider = 2;
+	} else {
+		err = regmap_bulk_read(output->data->regmap,
+				SI5341_OUT_R_REG(output), r, 3);
+		if (err < 0)
+			return err;
+
+		/* Calculate value as 24-bit integer, (Rx_REG+1)x2 */
+		r_divider = ((r[2] << 16 | r[1] << 8 | r[0]) + 1) << 1;
+	}
+
+	dev_dbg(&output->data->i2c_client->dev,
+			"%s(%u): p=%lu rd=%u %lu\n",
+			__func__, output->index, parent_rate,
+			r_divider, parent_rate / r_divider);
+
+	return parent_rate / r_divider;
+}
+
+static long si5341_output_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	unsigned long r;
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u): %lu\n",
+			__func__, output->index, rate);
+
+	r = *parent_rate >> 1;
+
+	/* If rate is an even divisor, no changes to parent required */
+	if (r && !(r % rate))
+		return (long)rate;
+
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		if (rate > 200000000)
+			/* minimum r-divider is 2 */
+			r = 2;
+		else
+			/* Take a parent frequency near 400 MHz */
+			r = (400000000u / rate) & ~1;
+		*parent_rate = r * rate;
+	} else {
+		/* We cannot change our parent's rate, report what we can do */
+		r /= rate;
+		rate = *parent_rate / (r << 1);
+	}
+
+	return (long)rate;
+}
+
+static int si5341_output_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	/* Frequency divider is (r_div + 1) * 2 */
+	u32 r_div = (parent_rate / rate) >> 1;
+	int err;
+	u8 r[3];
+
+	if (r_div <= 1)
+		r_div = 0;
+	else if (r_div >= BIT(24))
+		r_div = BIT(24) - 1;
+	else
+		--r_div;
+
+	/* For a value of "2", we set the "OUT0_RDIV_FORCE2" bit */
+	err = regmap_update_bits(output->data->regmap,
+			SI5341_OUT_CONFIG(output),
+			SI5341_OUT_CFG_RDIV_FORCE2,
+			(r_div == 0) ? SI5341_OUT_CFG_RDIV_FORCE2 : 0);
+	if (err < 0)
+		return err;
+
+	/* Just always write the R_REG */
+	r[0] = r_div & 0xff;
+	r[1] = (r_div >> 8) & 0xff;
+	r[2] = (r_div >> 16) & 0xff;
+	err = regmap_bulk_write(output->data->regmap,
+			SI5341_OUT_R_REG(output), r, 3);
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u): r=%lu p=%lu rd=%u\n",
+			__func__, output->index, rate, parent_rate, r_div);
+
+	return 0;
+}
+
+static int si5341_output_reparent(struct clk_si5341_output *output, u8 index)
+{
+	return regmap_update_bits(output->data->regmap,
+		SI5341_OUT_MUX_SEL(output), 0x07, index);
+}
+
+static int si5341_output_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u): N%u\n",
+			__func__, output->index, index);
+
+	if (index >= output->data->num_synth)
+		return -EINVAL;
+
+	return si5341_output_reparent(output, index);
+}
+
+static u8 si5341_output_get_parent(struct clk_hw *hw)
+{
+	struct clk_si5341_output *output = to_clk_si5341_output(hw);
+	int err;
+	u32 val;
+
+	err = regmap_read(output->data->regmap,
+			SI5341_OUT_MUX_SEL(output), &val);
+
+	dev_dbg(&output->data->i2c_client->dev, "%s(%u): N%u\n",
+			__func__, output->index, val & 0x7);
+
+	return val & 0x7;
+}
+
+static const struct clk_ops si5341_output_clk_ops = {
+	.is_prepared = si5341_output_clk_is_on,
+	.prepare = si5341_output_clk_prepare,
+	.unprepare = si5341_output_clk_unprepare,
+	.recalc_rate = si5341_output_clk_recalc_rate,
+	.round_rate = si5341_output_clk_round_rate,
+	.set_rate = si5341_output_clk_set_rate,
+	.set_parent = si5341_output_set_parent,
+	.get_parent = si5341_output_get_parent,
+};
+
+/* Called by probe, before output is actually registered */
+static int si5341_output_set_parent_and_freq(
+	struct clk_si5341_output *output, u8 index, u32 parent_rate)
+{
+	int err;
+
+	if (index < output->data->num_synth) {
+		err = si5341_output_reparent(output, index);
+		if (err < 0)
+			return err;
+	}
+
+	if (parent_rate) {
+		index = si5341_output_get_parent(&output->hw);
+		err = clk_set_rate(output->data->synth[index].hw.clk,
+				parent_rate);
+	}
+
+	return err;
+}
+
+/*
+ * The chip can be bought in a pre-programmed version, or one can program the
+ * NVM in the chip to boot up in a preset mode. This routine tries to determine
+ * if that's the case, or if we need to reset and program everything from
+ * scratch. Returns negative error, or true/false.
+ */
+static int si5341_is_programmed_already(struct clk_si5341 *data)
+{
+	int err;
+	u32 v;
+	u8 r[4];
+	u8 i;
+
+	err = regmap_read(data->regmap, 0x00E2, &v);
+	if (err < 0)
+		return err;
+
+	/* Read the PLL divider value, it must have a non-zero value */
+	err = regmap_bulk_read(data->regmap, SI5341_PLL_M_DEN, r, 4);
+	if (err < 0)
+		return err;
+
+	dev_dbg(&data->i2c_client->dev, "%s: %#x md=%#x\n",
+			__func__, v,
+			r[3] << 24 | r[2] << 16 | r[1] << 8 | r[0]);
+
+	for (i = 0; i < 4; ++i)
+		if (r[i])
+			return true;
+
+	return false;
+}
+
+static struct clk_hw *of_clk_si5341_get(
+	struct of_phandle_args *clkspec, void *_data)
+{
+	struct clk_si5341 *data = _data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= data->num_outputs) {
+		dev_err(&data->i2c_client->dev, "invalid index %u\n", idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &data->clk[idx].hw;
+}
+
+static int si5341_probe_chip_id(struct clk_si5341 *data)
+{
+	int err;
+	u8 reg[4];
+
+	err = regmap_bulk_read(data->regmap, SI5341_PN_BASE, reg, 4);
+	if (err < 0) {
+		dev_err(&data->i2c_client->dev, "Failed to read chip ID\n");
+		return err;
+	}
+
+	dev_info(&data->i2c_client->dev, "Chip: %x Grade: %u Rev: %u\n",
+		 (reg[1] << 8) | reg[0], reg[2], reg[3]);
+
+	/* The 5341 has 10 outputs, the 5340 has only 4 */
+	switch (reg[0]) {
+	case 0x40:
+		data->num_outputs = SI5340_MAX_NUM_OUTPUTS;
+		data->num_synth = SI5340_NUM_SYNTH;
+		data->reg_output_offset = si5340_reg_output_offset;
+		data->reg_rdiv_offset = si5340_reg_rdiv_offset;
+		break;
+	case 0x41:
+		data->num_outputs = SI5341_MAX_NUM_OUTPUTS;
+		data->num_synth = SI5341_NUM_SYNTH;
+		data->reg_output_offset = si5341_reg_output_offset;
+		data->reg_rdiv_offset = si5341_reg_rdiv_offset;
+		break;
+	default:
+		dev_err(&data->i2c_client->dev, "Model '%x' not supported\n",
+			(reg[1] << 8) | reg[0]);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Read active settings into the regmap cache for later reference */
+static int si5341_read_settings(struct clk_si5341 *data)
+{
+	int err;
+	u8 i;
+	u8 r[10];
+
+	err = regmap_bulk_read(data->regmap, SI5341_PLL_M_NUM, r, 10);
+	if (err < 0)
+		return err;
+
+	err = regmap_bulk_read(data->regmap,
+				SI5341_SYNTH_N_CLK_TO_OUTX_EN, r, 3);
+	if (err < 0)
+		return err;
+
+	err = regmap_bulk_read(data->regmap,
+				SI5341_SYNTH_N_CLK_DIS, r, 1);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < data->num_synth; ++i) {
+		err = regmap_bulk_read(data->regmap,
+					SI5341_SYNTH_N_NUM(i), r, 10);
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < data->num_outputs; ++i) {
+		err = regmap_bulk_read(data->regmap,
+					data->reg_output_offset[i], r, 4);
+		if (err < 0)
+			return err;
+
+		err = regmap_bulk_read(data->regmap,
+					data->reg_rdiv_offset[i], r, 3);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int si5341_write_multiple(struct clk_si5341 *data,
+	const struct si5341_reg_default *values, unsigned int num_values)
+{
+	unsigned int i;
+	int res;
+
+	for (i = 0; i < num_values; ++i) {
+		res = regmap_write(data->regmap,
+			values[i].address, values[i].value);
+		if (res < 0) {
+			dev_err(&data->i2c_client->dev,
+				"Failed to write %#x:%#x\n",
+				values[i].address, values[i].value);
+			return res;
+		}
+	}
+
+	return 0;
+}
+
+const struct si5341_reg_default si5341_preamble[] = {
+	{0x0B25, 0x00},
+	{0x0502, 0x01},
+	{0x0505, 0x03},
+	{0x0957, 0x1F},
+	{0x0B4E, 0x1A},
+};
+
+static int si5341_send_preamble(struct clk_si5341 *data)
+{
+	int res;
+	u32 revision;
+
+	/* For revision 2 and up, the values are slightly different */
+	res = regmap_read(data->regmap, SI5341_DEVICE_REV, &revision);
+	if (res < 0)
+		return res;
+
+	/* Write "preamble" as specified by datasheet */
+	res = regmap_write(data->regmap, 0xB24, revision < 2 ? 0xD8 : 0xC0);
+	if (res < 0)
+		return res;
+	res = si5341_write_multiple(data,
+		si5341_preamble, ARRAY_SIZE(si5341_preamble));
+	if (res < 0)
+		return res;
+
+	/* Wait for 300 ms */
+	msleep(300);
+
+	return 0;
+}
+
+/* Perform a soft reset and write post-amble */
+static int si5341_finalize_defaults(struct clk_si5341 *data)
+{
+	int res;
+	u32 revision;
+
+	res = regmap_read(data->regmap, SI5341_DEVICE_REV, &revision);
+	if (res < 0)
+		return res;
+
+	dev_dbg(&data->i2c_client->dev, "%s rev=%u\n", __func__, revision);
+
+	/* Perform a soft reset */
+	res = regmap_write(data->regmap, SI5341_SOFT_RST, 0x01);
+	if (res < 0)
+		return res;
+
+	/* Write post-amble */
+	res = regmap_write(data->regmap, 0xB24, revision < 2 ? 0xDB : 0xC3);
+	if (res < 0)
+		return res;
+	res = regmap_write(data->regmap, 0x0B25, 0x02);
+	if (res < 0)
+		return res;
+
+	return 0;
+}
+
+
+static const struct regmap_range si5341_regmap_volatile_range[] = {
+	regmap_reg_range(0x000C, 0x0012), /* Status */
+	regmap_reg_range(0x001C, 0x001E), /* reset, finc/fdec */
+	regmap_reg_range(0x00E2, 0x00FE), /* NVM, interrupts, device ready */
+	/* Update bits for synth config */
+	regmap_reg_range(SI5341_SYNTH_N_UPD(0), SI5341_SYNTH_N_UPD(0)),
+	regmap_reg_range(SI5341_SYNTH_N_UPD(1), SI5341_SYNTH_N_UPD(1)),
+	regmap_reg_range(SI5341_SYNTH_N_UPD(2), SI5341_SYNTH_N_UPD(2)),
+	regmap_reg_range(SI5341_SYNTH_N_UPD(3), SI5341_SYNTH_N_UPD(3)),
+	regmap_reg_range(SI5341_SYNTH_N_UPD(4), SI5341_SYNTH_N_UPD(4)),
+};
+
+const struct regmap_access_table si5341_regmap_volatile = {
+	.yes_ranges = si5341_regmap_volatile_range,
+	.n_yes_ranges = ARRAY_SIZE(si5341_regmap_volatile_range),
+};
+
+/* Pages 0, 1, 2, 3, 9, A, B are valid, so there are 12 pages */
+static const struct regmap_range_cfg si5341_regmap_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = 12 * 256,
+		.selector_reg = SI5341_PAGE,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 256,
+	},
+};
+
+static const struct regmap_config si5341_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = 0,
+	.ranges = si5341_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(si5341_regmap_ranges),
+	.max_register = 12 * 256,
+	.volatile_table = &si5341_regmap_volatile,
+};
+
+static int si5341_dt_parse_dt(struct i2c_client *client,
+	struct clk_si5341_output_config *config)
+{
+	struct device_node *child;
+	struct device_node *np = client->dev.of_node;
+	u32 num;
+	u32 val;
+
+	memset(config, 0, sizeof(struct clk_si5341_output_config) *
+				SI5341_MAX_NUM_OUTPUTS);
+	/* Set defaults to no forced source, not a master */
+	for (num = 0; num < SI5341_MAX_NUM_OUTPUTS; ++num)
+		config[num].source_index = 0xff;
+
+	for_each_child_of_node(np, child) {
+		if (of_property_read_u32(child, "reg", &num)) {
+			dev_err(&client->dev, "missing reg property of %s\n",
+				child->name);
+			goto put_child;
+		}
+
+		if (num >= SI5341_MAX_NUM_OUTPUTS) {
+			dev_err(&client->dev, "invalid clkout %d\n", num);
+			goto put_child;
+		}
+
+		if (!of_property_read_u32(child, "silabs,format", &val)) {
+			/* Set cm and ampl conservatively to 3v3 settings */
+			switch (val) {
+			case 1: /* normal differential */
+				config[num].out_cm_ampl_bits = 0x33;
+				break;
+			case 2: /* low-power differential */
+				config[num].out_cm_ampl_bits = 0x13;
+				break;
+			case 4: /* LVCMOS */
+				config[num].out_cm_ampl_bits = 0x33;
+				/* Set SI recommended impedance for LVCMOS */
+				config[num].out_format_drv_bits |= 0xc0;
+				break;
+			default:
+				dev_err(&client->dev,
+					"invalid silabs,format %u for %u\n",
+					val, num);
+				goto put_child;
+			}
+			config[num].out_format_drv_bits &= ~0x07;
+			config[num].out_format_drv_bits |= val & 0x07;
+			/* Always enable the SYNC feature */
+			config[num].out_format_drv_bits |= 0x08;
+		}
+
+		if (!of_property_read_u32(child, "silabs,common-mode", &val)) {
+			if (val > 0xf) {
+				dev_err(&client->dev,
+					"invalid silabs,common-mode %u\n",
+					val);
+				goto put_child;
+			}
+			config[num].out_cm_ampl_bits &= 0xf0;
+			config[num].out_cm_ampl_bits |= val & 0x0f;
+		}
+
+		if (!of_property_read_u32(child, "silabs,amplitude", &val)) {
+			if (val > 0xf) {
+				dev_err(&client->dev,
+					"invalid silabs,amplitude %u\n",
+					val);
+				goto put_child;
+			}
+			config[num].out_cm_ampl_bits &= 0x0f;
+			config[num].out_cm_ampl_bits |= (val << 4) & 0xf0;
+		}
+
+		if (!of_property_read_u32(child, "silabs,synth-source",
+					  &val)) {
+			/* Chip type not known at this point, assume largest */
+			if (val >= SI5341_NUM_SYNTH) {
+				dev_err(&client->dev,
+					"invalid synth-source %u for %u\n",
+					val, num);
+				goto put_child;
+			}
+
+			config[num].source_index = val;
+		}
+
+		if (!of_property_read_u32(child, "silabs,synth-frequency",
+					  &val)) {
+			if (config[num].source_index >= SI5341_NUM_SYNTH) {
+				dev_err(&client->dev,
+					"synth-frequency requires synth-source "
+					"for %u\n", num);
+				goto put_child;
+			}
+
+			config[num].synth_frequency = val;
+		}
+
+		if (!of_property_read_u32(child, "clock-frequency", &val))
+			config[num].clock_frequency = val;
+
+		if (of_property_read_bool(child, "silabs,disable-high"))
+			config[num].out_format_drv_bits |= 0x10;
+
+		config[num].synth_master =
+			of_property_read_bool(child, "silabs,synth-master");
+
+		config[num].always_on =
+			of_property_read_bool(child, "always-on");
+	}
+
+	return 0;
+
+put_child:
+	of_node_put(child);
+	return -EINVAL;
+}
+
+/*
+ * If not pre-configured, calculate and set the PLL configuration manually.
+ * For low-jitter performance, the PLL should be set such that the synthesizers
+ * only need integer division.
+ * Without any user guidance, we'll set the PLL to 14GHz, which still allows
+ * the chip to generate any frequency on its outputs, but jitter performance
+ * may be sub-optimal.
+ */
+static int si5341_initialize_pll(struct clk_si5341 *data)
+{
+	struct device_node *np = data->i2c_client->dev.of_node;
+	u32 m_num = 0;
+	u32 m_den = 0;
+
+	if (of_property_read_u32(np, "silabs,pll-m-num", &m_num)) {
+		dev_err(&data->i2c_client->dev,
+			"PLL configuration requires silabs,pll-m-num\n");
+	}
+	if (of_property_read_u32(np, "silabs,pll-m-den", &m_den)) {
+		dev_err(&data->i2c_client->dev,
+			"PLL configuration requires silabs,pll-m-den\n");
+	}
+
+	if (!m_num || !m_den) {
+		dev_err(&data->i2c_client->dev,
+			"PLL configuration invalid, assume 14GHz\n");
+		m_den = clk_get_rate(data->pxtal) / 10;
+		m_num = 1400000000;
+	}
+
+	return si5341_encode_44_32(data->regmap,
+			SI5341_PLL_M_NUM, m_num, m_den);
+}
+
+static int si5341_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct clk_si5341 *data;
+	struct clk_init_data init;
+	const char *root_clock_name;
+	const char *synth_clock_names[SI5341_NUM_SYNTH];
+	int err;
+	struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
+	u8 i;
+	bool initialization_required;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->i2c_client = client;
+
+	data->pxtal = devm_clk_get(&client->dev, "xtal");
+	if (IS_ERR(data->pxtal)) {
+		if (PTR_ERR(data->pxtal) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "Missing xtal clock input\n");
+	}
+
+	err = si5341_dt_parse_dt(client, config);
+	if (err)
+		return err;
+
+	if (of_property_read_string(client->dev.of_node, "clock-output-names",
+			&init.name))
+		init.name = client->dev.of_node->name;
+	root_clock_name = init.name;
+
+	data->regmap = devm_regmap_init_i2c(client, &si5341_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	i2c_set_clientdata(client, data);
+
+	err = si5341_probe_chip_id(data);
+	if (err < 0)
+		return err;
+
+	/* "Activate" the xtal (usually a fixed clock) */
+	clk_prepare_enable(data->pxtal);
+
+	if (of_property_read_bool(client->dev.of_node, "silabs,reprogram")) {
+		initialization_required = true;
+	} else {
+		err = si5341_is_programmed_already(data);
+		if (err < 0)
+			return err;
+
+		initialization_required = !err;
+	}
+
+	if (initialization_required) {
+		/* Populate the regmap cache in preparation for "cache only" */
+		err = si5341_read_settings(data);
+		if (err < 0)
+			return err;
+
+		err = si5341_send_preamble(data);
+		if (err < 0)
+			return err;
+
+		/*
+		 * We intend to send all 'final' register values in a single
+		 * transaction. So cache all register writes until we're done
+		 * configuring.
+		 */
+		regcache_cache_only(data->regmap, true);
+
+		/* Write the configuration pairs from the firmware blob */
+		err = si5341_write_multiple(data, si5341_reg_defaults,
+					ARRAY_SIZE(si5341_reg_defaults));
+		if (err < 0)
+			return err;
+
+		/* PLL configuration is required */
+		err = si5341_initialize_pll(data);
+		if (err < 0)
+			return err;
+	}
+
+	/* Register the PLL */
+	data->pxtal_name = __clk_get_name(data->pxtal);
+	init.parent_names = &data->pxtal_name;
+	init.num_parents = 1; /* For now, only XTAL input supported */
+	init.ops = &si5341_clk_ops;
+	init.flags = 0;
+	data->hw.init = &init;
+
+	err = devm_clk_hw_register(&client->dev, &data->hw);
+	if (err) {
+		dev_err(&client->dev, "clock registration failed\n");
+		return err;
+	}
+
+	init.num_parents = 1;
+	init.parent_names = &root_clock_name;
+	init.ops = &si5341_synth_clk_ops;
+	for (i = 0; i < data->num_synth; ++i) {
+		synth_clock_names[i] = kasprintf(GFP_KERNEL, "%s.N%u",
+			client->dev.of_node->name, i);
+		init.name = synth_clock_names[i];
+		data->synth[i].index = i;
+		data->synth[i].data = data;
+		data->synth[i].hw.init = &init;
+		dev_dbg(&client->dev, "Register %s\n", init.name);
+		err = devm_clk_hw_register(&client->dev, &data->synth[i].hw);
+		if (err) {
+			dev_err(&client->dev,
+				"synth N%u registration failed\n", i);
+		}
+	}
+
+	init.num_parents = data->num_synth;
+	init.parent_names = synth_clock_names;
+	init.ops = &si5341_output_clk_ops;
+	init.flags = 0;
+	for (i = 0; i < data->num_outputs; ++i) {
+		init.name = kasprintf(GFP_KERNEL, "%s.%d",
+			client->dev.of_node->name, i);
+		init.flags = config[i].synth_master ? CLK_SET_RATE_PARENT : 0;
+		data->clk[i].index = i;
+		data->clk[i].data = data;
+		data->clk[i].hw.init = &init;
+		if (config[i].out_format_drv_bits & 0x07) {
+			dev_dbg(&client->dev,
+				"out %u: fmt=%#x cm=%#x\n", i,
+				config[i].out_format_drv_bits,
+				config[i].out_cm_ampl_bits);
+			regmap_write(data->regmap,
+				SI5341_OUT_FORMAT(&data->clk[i]),
+				config[i].out_format_drv_bits);
+			regmap_write(data->regmap,
+				SI5341_OUT_CM(&data->clk[i]),
+				config[i].out_cm_ampl_bits);
+		}
+		si5341_output_set_parent_and_freq(&data->clk[i],
+			config[i].source_index,
+			config[i].synth_frequency);
+		dev_dbg(&client->dev, "Register %s\n", init.name);
+		err = devm_clk_hw_register(&client->dev, &data->clk[i].hw);
+		kfree(init.name); /* clock framework made a copy of the name */
+		if (err) {
+			dev_err(&client->dev,
+				"output %u registration failed\n", i);
+			goto error;
+		}
+		if (config[i].clock_frequency)
+			clk_set_rate(data->clk[i].hw.clk,
+				config[i].clock_frequency);
+		if (config[i].always_on)
+			clk_prepare(data->clk[i].hw.clk);
+	}
+
+	err = of_clk_add_hw_provider(client->dev.of_node, of_clk_si5341_get,
+			data);
+	if (err) {
+		dev_err(&client->dev, "unable to add clk provider\n");
+		goto error;
+	}
+
+	if (initialization_required) {
+		/* Synchronize */
+		regcache_cache_only(data->regmap, false);
+		err = regcache_sync(data->regmap);
+		if (err < 0)
+			goto error;
+
+		err = si5341_finalize_defaults(data);
+		if (err < 0)
+			goto error;
+	}
+
+error:
+	/* Free the names, clk framework makes copies */
+	for (i = 0; i < data->num_synth; ++i)
+		kfree(synth_clock_names[i]);
+
+	return err;
+}
+
+static const struct i2c_device_id si5341_id[] = {
+	{ "si5340", 0 },
+	{ "si5341", 1 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si5341_id);
+
+static const struct of_device_id clk_si5341_of_match[] = {
+	{ .compatible = "silabs,si5340" },
+	{ .compatible = "silabs,si5341" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, clk_si5341_of_match);
+
+static struct i2c_driver si5341_driver = {
+	.driver = {
+		.name = "si5341",
+		.of_match_table = clk_si5341_of_match,
+	},
+	.probe		= si5341_probe,
+	.id_table	= si5341_id,
+};
+module_i2c_driver(si5341_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Si5341 driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

