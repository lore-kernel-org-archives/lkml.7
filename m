Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D61206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556235390;
	bh=U9S2Lja8Twue45OoC3vWZB4u/HIbeVV/hxbsdPCkINc=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=sMHRFPMl3CKQ+tAmK3M5NIVqwoGdI5w1Erjk12sjCed6Zx/xzu1zCS5nmcacI86gg
	 ZzmDRbWaSW4qmJ2SFHLIUcHM6GegCb4P1FhTE/E1aScOUWqVb0YK1CAfIyiLVhMQD0
	 xFrvxhR7vElFlxOif9zBjXn6pLvYt4BtDxLpaviA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfDYXg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDYXg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:36:27 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D6D206A3;
        Thu, 25 Apr 2019 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556235384;
        bh=U9S2Lja8Twue45OoC3vWZB4u/HIbeVV/hxbsdPCkINc=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=nI7y0i+TDjzm78YuXsPpNIWNVGrBl/rqLk8v7WcKMSyHj14M57xo26n/ozIzOqtkV
         L8qC1axMu3qWolZSQdolTpGYhQmfdJ1oSW7pDaOtdlVWT2yBVIVyQyHHk/Tzr1STdb
         KdG4a7joed9IWqPI5zTUZJVG44vRkBOXDdG2Bj9A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190424090038.18353-1-mike.looijmans@topic.nl>
References: <20190424090038.18353-1-mike.looijmans@topic.nl>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Add Si5341/Si5340 driver
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org
Message-ID: <155623538292.15276.10999401088770081919@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 16:36:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-04-24 02:00:38)
> Adds a driver for the Si5341 and Si5340 chips. The driver does not fully
> support all features of these chips, but allows the chip to be used
> without any support from the "clockbuilder pro" software.
>=20
> If the chip is preprogrammed, that is, you bought one with some defaults
> burned in, or you programmed the NVM in some way, the driver will just
> take over the current settings and only change them on demand. Otherwise
> the input must a fixed XTAL in its most basic configuration (no

must be

> predividers, no feedback, etc.).
>=20
> The driver supports dynamic changes of multisynth, output dividers and
> enabling or powering down outputs and multisynths.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> new file mode 100644
> index 000000000000..0d636658853b
> --- /dev/null
> +++ b/drivers/clk/clk-si5341.c
> @@ -0,0 +1,1452 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Silicon Labs Si5341/Si5340 Clock generator
> + * Copyright (C) 2019 Topic Embedded Products
> + * Author: Mike Looijmans <mike.looijmans@topic.nl>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/gcd.h>
> +#include <linux/math64.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define SI5341_MAX_NUM_OUTPUTS 10
> +#define SI5340_MAX_NUM_OUTPUTS 4
> +
> +#define SI5341_NUM_SYNTH 5
> +#define SI5340_NUM_SYNTH 4
> +
> +/* Range of the synthesizer fractional divider */
> +#define SI5341_SYNTH_N_MIN     10
> +#define SI5341_SYNTH_N_MAX     4095
> +
> +/* The chip can get its input clock from 3 input pins or an XTAL */
> +
> +/* There is one PLL running at 13500=E2=80=9314256 MHz */
> +#define SI5341_PLL_VCO_MIN 13500000000ull
> +#define SI5341_PLL_VCO_MAX 14256000000ull
> +
> +/* The 5 frequency synthesizers obtain their input from the PLL */
> +struct clk_si5341_synth {
> +       struct clk_hw hw;
> +       struct clk_si5341 *data;
> +       u8 index;
> +};
> +#define to_clk_si5341_synth(_hw) \
> +       container_of(_hw, struct clk_si5341_synth, hw)
> +
> +/* The output stages can be connected to any synth (full mux) */
> +struct clk_si5341_output {
> +       struct clk_hw hw;
> +       struct clk_si5341 *data;
> +       u8 index;
> +};
> +#define to_clk_si5341_output(_hw) \
> +       container_of(_hw, struct clk_si5341_output, hw)
> +
> +struct clk_si5341 {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +       struct i2c_client *i2c_client;
> +       struct clk_si5341_synth synth[SI5341_NUM_SYNTH];
> +       struct clk_si5341_output clk[SI5341_MAX_NUM_OUTPUTS];
> +       struct clk *pxtal;
> +       const char *pxtal_name;
> +       const u16 *reg_output_offset;
> +       const u16 *reg_rdiv_offset;
> +       u64 freq_vco; /* 13500=E2=80=9314256 MHz */
> +       u8 num_outputs;
> +       u8 num_synth;
> +};
> +#define to_clk_si5341(_hw)     container_of(_hw, struct clk_si5341, hw)
> +
> +struct clk_si5341_output_config {
> +       u8 source_index;
> +       u8 out_format_drv_bits;
> +       u8 out_cm_ampl_bits;
> +       bool synth_master;
> +       bool always_on;
> +       u32 synth_frequency;
> +       u32 clock_frequency;
> +};
> +
> +#define SI5341_PAGE            0x0001
> +#define SI5341_PN_BASE         0x0002
> +#define SI5341_DEVICE_REV      0x0005
> +#define SI5341_STATUS          0x000C
> +#define SI5341_SOFT_RST                0x001C
> +
> +/* Input dividers (48-bit) */
> +#define SI5341_IN_PDIV(x)      (0x0208 + ((x) * 10))
> +#define SI5341_IN_PSET(x)      (0x020E + ((x) * 10))
> +
> +/* PLL configuration */
> +#define SI5341_PLL_M_NUM       0x0235
> +#define SI5341_PLL_M_DEN       0x023B
> +
> +/* Output configuration */
> +#define SI5341_OUT_CONFIG(output)      \
> +                       ((output)->data->reg_output_offset[(output)->inde=
x])
> +#define SI5341_OUT_FORMAT(output)      (SI5341_OUT_CONFIG(output) + 1)
> +#define SI5341_OUT_CM(output)          (SI5341_OUT_CONFIG(output) + 2)
> +#define SI5341_OUT_MUX_SEL(output)     (SI5341_OUT_CONFIG(output) + 3)
> +#define SI5341_OUT_R_REG(output)       \
> +                       ((output)->data->reg_rdiv_offset[(output)->index])
> +
> +/* Synthesize N divider */
> +#define SI5341_SYNTH_N_NUM(x)  (0x0302 + ((x) * 11))
> +#define SI5341_SYNTH_N_DEN(x)  (0x0308 + ((x) * 11))
> +#define SI5341_SYNTH_N_UPD(x)  (0x030C + ((x) * 11))
> +
> +/* Synthesizer output enable, phase bypass, power mode */
> +#define SI5341_SYNTH_N_CLK_TO_OUTX_EN  0x0A03
> +#define SI5341_SYNTH_N_PIBYP           0x0A04
> +#define SI5341_SYNTH_N_PDNB            0x0A05
> +#define SI5341_SYNTH_N_CLK_DIS         0x0B4A
> +
> +/* SI5341_OUT_CONFIG bits */
> +#define SI5341_OUT_CFG_PDN             BIT(0)
> +#define SI5341_OUT_CFG_OE              BIT(1)
> +#define SI5341_OUT_CFG_RDIV_FORCE2     BIT(2)
> +
> +/* Static configuration (to be moved to firmware) */
> +struct si5341_reg_default {
> +       u16 address;
> +       u8 value;
> +};
> +
> +/* Output configuration registers 0..9 are not quite logically organized=
 */

SUPER SIGH!!!!!!

> +static const u16 si5341_reg_output_offset[] =3D {
> +       0x0108,
> +       0x010D,
> +       0x0112,
> +       0x0117,
> +       0x011C,
> +       0x0121,
> +       0x0126,
> +       0x012B,
> +       0x0130,
> +       0x013A,
> +};
> +static const u16 si5340_reg_output_offset[] =3D {
> +       0x0112,
> +       0x0117,
> +       0x0126,
> +       0x012B,
> +};
> +
> +/* The location of the R divider registers */
> +static const u16 si5341_reg_rdiv_offset[] =3D {
> +       0x024A,
> +       0x024D,
> +       0x0250,
> +       0x0253,
> +       0x0256,
> +       0x0259,
> +       0x025C,
> +       0x025F,
> +       0x0262,
> +       0x0268,
> +};

Put a newline here please.

> +static const u16 si5340_reg_rdiv_offset[] =3D {
> +       0x0250,
> +       0x0253,
> +       0x025C,
> +       0x025F,
> +};
> +
> +/*
> + * Programming sequence from ClockBuilder, settings to initialize the sy=
stem
> + * using only the XTAL input, without pre-divider.
> + * This also contains settings that aren't mentioned anywhere in the dat=
asheet.

That's awful! What a non-surprise!

> + * The "known" settings like synth and output configuration are done lat=
er.
> + */
> +static const struct si5341_reg_default si5341_reg_defaults[] =3D {
> +       { 0x0017, 0x3A }, /* INT mask (disable interrupts) */
> +       { 0x0018, 0xFF }, /* INT mask */
> +       { 0x0021, 0x0F }, /* Select XTAL as input */
> +       { 0x0022, 0x00 }, /* Not in datasheet */
> +       { 0x002B, 0x02 }, /* SPI config */
> +       { 0x002C, 0x20 }, /* LOS enable for XTAL */
> +       { 0x002D, 0x00 }, /* LOS timing */
> +       { 0x002E, 0x00 },
> +       { 0x002F, 0x00 },
> +       { 0x0030, 0x00 },
> +       { 0x0031, 0x00 },
> +       { 0x0032, 0x00 },
> +       { 0x0033, 0x00 },
> +       { 0x0034, 0x00 },
> +       { 0x0035, 0x00 },
> +       { 0x0036, 0x00 },
> +       { 0x0037, 0x00 },
> +       { 0x0038, 0x00 }, /* LOS setting (thresholds) */
> +       { 0x0039, 0x00 },
> +       { 0x003A, 0x00 },
> +       { 0x003B, 0x00 },
> +       { 0x003C, 0x00 },
> +       { 0x003D, 0x00 }, /* LOS setting (thresholds) end */
> +       { 0x0041, 0x00 }, /* LOS0_DIV_SEL */
> +       { 0x0042, 0x00 }, /* LOS1_DIV_SEL */
> +       { 0x0043, 0x00 }, /* LOS2_DIV_SEL */
> +       { 0x0044, 0x00 }, /* LOS3_DIV_SEL */
> +       { 0x009E, 0x00 }, /* Not in datasheet */
> +       { 0x0102, 0x01 }, /* Enable outputs */
> +       { 0x013F, 0x00 }, /* Not in datasheet */
> +       { 0x0140, 0x00 }, /* Not in datasheet */
> +       { 0x0141, 0x40 }, /* OUT LOS */
> +       { 0x0202, 0x00 }, /* XAXB_FREQ_OFFSET (=3D0)*/
> +       { 0x0203, 0x00 },
> +       { 0x0204, 0x00 },
> +       { 0x0205, 0x00 },
> +       { 0x0206, 0x00 }, /* PXAXB (2^x) */
> +       { 0x0208, 0x00 }, /* Px divider setting (usually 0) */
> +       { 0x0209, 0x00 },
> +       { 0x020A, 0x00 },
> +       { 0x020B, 0x00 },
> +       { 0x020C, 0x00 },
> +       { 0x020D, 0x00 },
> +       { 0x020E, 0x00 },
> +       { 0x020F, 0x00 },
> +       { 0x0210, 0x00 },
> +       { 0x0211, 0x00 },
> +       { 0x0212, 0x00 },
> +       { 0x0213, 0x00 },
> +       { 0x0214, 0x00 },
> +       { 0x0215, 0x00 },
> +       { 0x0216, 0x00 },
> +       { 0x0217, 0x00 },
> +       { 0x0218, 0x00 },
> +       { 0x0219, 0x00 },
> +       { 0x021A, 0x00 },
> +       { 0x021B, 0x00 },
> +       { 0x021C, 0x00 },
> +       { 0x021D, 0x00 },
> +       { 0x021E, 0x00 },
> +       { 0x021F, 0x00 },
> +       { 0x0220, 0x00 },
> +       { 0x0221, 0x00 },
> +       { 0x0222, 0x00 },
> +       { 0x0223, 0x00 },
> +       { 0x0224, 0x00 },
> +       { 0x0225, 0x00 },
> +       { 0x0226, 0x00 },
> +       { 0x0227, 0x00 },
> +       { 0x0228, 0x00 },
> +       { 0x0229, 0x00 },
> +       { 0x022A, 0x00 },
> +       { 0x022B, 0x00 },
> +       { 0x022C, 0x00 },
> +       { 0x022D, 0x00 },
> +       { 0x022E, 0x00 },
> +       { 0x022F, 0x00 }, /* Px divider setting (usually 0) end */
> +       { 0x026B, 0x00 }, /* DESIGN_ID (ASCII string) */
> +       { 0x026C, 0x00 },
> +       { 0x026D, 0x00 },
> +       { 0x026E, 0x00 },
> +       { 0x026F, 0x00 },
> +       { 0x0270, 0x00 },
> +       { 0x0271, 0x00 },
> +       { 0x0272, 0x00 }, /* DESIGN_ID (ASCII string) end */
> +       { 0x0339, 0x1F }, /* N_FSTEP_MSK */
> +       { 0x033B, 0x00 }, /* Nx_FSTEPW (Frequency step) */
> +       { 0x033C, 0x00 },
> +       { 0x033D, 0x00 },
> +       { 0x033E, 0x00 },
> +       { 0x033F, 0x00 },
> +       { 0x0340, 0x00 },
> +       { 0x0341, 0x00 },
> +       { 0x0342, 0x00 },
> +       { 0x0343, 0x00 },
> +       { 0x0344, 0x00 },
> +       { 0x0345, 0x00 },
> +       { 0x0346, 0x00 },
> +       { 0x0347, 0x00 },
> +       { 0x0348, 0x00 },
> +       { 0x0349, 0x00 },
> +       { 0x034A, 0x00 },
> +       { 0x034B, 0x00 },
> +       { 0x034C, 0x00 },
> +       { 0x034D, 0x00 },
> +       { 0x034E, 0x00 },
> +       { 0x034F, 0x00 },
> +       { 0x0350, 0x00 },
> +       { 0x0351, 0x00 },
> +       { 0x0352, 0x00 },
> +       { 0x0353, 0x00 },
> +       { 0x0354, 0x00 },
> +       { 0x0355, 0x00 },
> +       { 0x0356, 0x00 },
> +       { 0x0357, 0x00 },
> +       { 0x0358, 0x00 }, /* Nx_FSTEPW (Frequency step) end */
> +       { 0x0359, 0x00 }, /* Nx_DELAY */
> +       { 0x035A, 0x00 },
> +       { 0x035B, 0x00 },
> +       { 0x035C, 0x00 },
> +       { 0x035D, 0x00 },
> +       { 0x035E, 0x00 },
> +       { 0x035F, 0x00 },
> +       { 0x0360, 0x00 },
> +       { 0x0361, 0x00 },
> +       { 0x0362, 0x00 }, /* Nx_DELAY end */
> +       { 0x0802, 0x00 }, /* Not in datasheet */
> +       { 0x0803, 0x00 }, /* Not in datasheet */
> +       { 0x0804, 0x00 }, /* Not in datasheet */
> +       { 0x090E, 0x02 }, /* XAXB_EXTCLK_EN=3D0 XAXB_PDNB=3D1 (use XTAL) =
*/
> +       { 0x091C, 0x04 }, /* ZDM_EN=3D4 (Normal mode) */
> +       { 0x0943, 0x00 }, /* IO_VDD_SEL=3D0 (0=3D1v8, use 1=3D3v3) */
> +       { 0x0949, 0x00 }, /* IN_EN (disable input clocks) */
> +       { 0x094A, 0x00 }, /* INx_TO_PFD_EN (disabled) */
> +       { 0x0A02, 0x00 }, /* Not in datasheet */
> +       { 0x0B44, 0x0F }, /* PDIV_ENB (datasheet does not mention what it=
 is) */
> +};
> +
> +/* Read and interpret a 44-bit followed by a 32-bit value in the regmap =
*/
> +static int si5341_decode_44_32(struct regmap *regmap, unsigned int reg,
> +       u64 *val1, u32 *val2)
> +{
> +       int err;
> +       u8 r[10];
> +
> +       err =3D regmap_bulk_read(regmap, reg, r, 10);
> +       if (err < 0)
> +               return err;
> +
> +       *val1 =3D ((u64)((r[5] & 0x0f) << 8 | r[4]) << 32) |
> +                       (u32)(r[3] << 24 | r[2] << 16 | r[1] << 8 | r[0]);
> +       *val2 =3D r[9] << 24 | r[8] << 16 | r[7] << 8 | r[6];

Is this almost get_unaligned_le64()? Maybe with some masking thrown in
to ignore bytes at r6 and r7. And then a get_unaligned_le32() after that
starting at r6.

> +
> +       return 0;
> +}
> +
> +static int si5341_encode_44_32(struct regmap *regmap, unsigned int reg,
> +       u64 n_num, u32 n_den)
> +{
> +       u8 r[10];
> +
> +       /* Shift left as far as possible without overflowing */
> +       while (!(n_num & BIT(43)) && !(n_den & BIT(31))) {
> +               n_num <<=3D 1;
> +               n_den <<=3D 1;
> +       }
> +
> +       /* 44 bits (6 bytes) numerator */
> +       r[0] =3D n_num & 0xff;
> +       r[1] =3D (n_num >> 8) & 0xff;
> +       r[2] =3D (n_num >> 16) & 0xff;
> +       r[3] =3D (n_num >> 24) & 0xff;
> +       r[4] =3D (n_num >> 32) & 0xff;
> +       r[5] =3D (n_num >> 40) & 0x0f;
> +       /* 32 bits denominator */
> +       r[6] =3D n_den & 0xff;
> +       r[7] =3D (n_den >> 8) & 0xff;
> +       r[8] =3D (n_den >> 16) & 0xff;
> +       r[9] =3D (n_den >> 24) & 0xff;

Maybe some put_unaligned_le64() and put_unaligned_le32()?

> +
> +       /* Program the fraction */
> +       return regmap_bulk_write(regmap, reg, r, sizeof(r));
> +}
> +
> +/* VCO, we assume it runs at a constant frequency */
> +static unsigned long si5341_clk_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si5341 *data =3D to_clk_si5341(hw);
> +       int err;
> +       u64 res;
> +       u64 m_num;
> +       u32 m_den;
> +       unsigned int shift;
> +
> +       /* Assume that PDIV is not being used, just read the PLL setting =
*/
> +       err =3D si5341_decode_44_32(data->regmap, SI5341_PLL_M_NUM,
> +                               &m_num, &m_den);
> +       if (err < 0)
> +               return 0;
> +
> +       if (!m_num || !m_den)
> +               return 0;
> +
> +       /*
> +        * Though m_num is 64-bit, only the upper bits are actually used.=
 While
> +        * calculating m_num and m_den, they are shifted as far as possib=
le to
> +        * the left. To avoid 96-bit division here, we just shift them ba=
ck so
> +        * we can do with just 64 bits.
> +        */
> +       shift =3D 0;
> +       res =3D m_num;
> +       while (res & 0xffff00000000) {
> +               ++shift;
> +               res >>=3D 1;
> +       }
> +       res *=3D parent_rate;
> +       do_div(res, (m_den >> shift));
> +
> +       dev_dbg(&data->i2c_client->dev,
> +               "%s(p=3D%lu) m=3D0x%llx/0x%x shift=3D%u res=3D%llu\n",
> +               __func__, parent_rate, m_num, m_den, shift, res);
> +
> +       /* We cannot return the actual frequency in 32 bit, store it loca=
lly */
> +       data->freq_vco =3D res;
> +
> +       /* Report kHz since the value is out of range */
> +       do_div(res, 1000);
> +
> +       return (unsigned long)res;

Uh oh. Do you need really high frequencies that don't fit in 32-bits?

> +}
> +
> +static const struct clk_ops si5341_clk_ops =3D {
> +       .recalc_rate =3D si5341_clk_recalc_rate,
> +};
> +
> +/* Synthesizers, there are 5 synthesizers that connect to any of the out=
puts */
> +
> +/* The synthesizer is on if all power and enable bits are set */
> +static int si5341_synth_clk_is_on(struct clk_hw *hw)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       int err;
> +       u32 val;
> +       u8 index =3D synth->index;
> +
> +       err =3D regmap_read(synth->data->regmap,
> +                       SI5341_SYNTH_N_CLK_TO_OUTX_EN, &val);
> +       if (err < 0)
> +               return err;

Should return 0 for off I suppose. Our "fail to read on/off" logic isn't
really there.

> +
> +       dev_dbg(&synth->data->i2c_client->dev, "%s(%u): %#x\n",
> +                       __func__, index, val);
> +
> +       if (!(val & BIT(index)))
> +               return false;
> +
> +       err =3D regmap_read(synth->data->regmap, SI5341_SYNTH_N_PDNB, &va=
l);
> +       if (err < 0)
> +               return err;

Sam comment.

> +
> +       if (!(val & BIT(index)))
> +               return false;

false is not int, but ok.

> +
> +       /* This bit must be 0 for the synthesizer to receive clock input =
*/
> +       err =3D regmap_read(synth->data->regmap, SI5341_SYNTH_N_CLK_DIS, =
&val);
> +       if (err < 0)
> +               return err;
> +
> +       return !(val & BIT(index));
> +}
> +
> +static void si5341_synth_clk_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       u8 index =3D synth->index;
> +       u8 mask =3D BIT(index);

I hope that index isn't large causing overflow here.

> +
> +       dev_dbg(&synth->data->i2c_client->dev, "%s(%u)\n", __func__, inde=
x);
> +
> +       /* Disable output */
> +       regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_CLK_TO_OUTX_EN, mask, 0);
> +       /* Power down */
> +       regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_PDNB, mask, 0);
> +       /* Disable clock input to synth (set to 1 to disable) */
> +       regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_CLK_DIS, mask, mask);
> +}
> +
> +static int si5341_synth_clk_prepare(struct clk_hw *hw)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       int err;
> +       u8 index =3D synth->index;
> +       u8 mask =3D BIT(index);
> +
> +       dev_dbg(&synth->data->i2c_client->dev, "%s(%u)\n", __func__, inde=
x);
> +
> +       /* Power up */
> +       err =3D regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_PDNB, mask, mask);
> +       if (err < 0)
> +               return err;
> +
> +       /* Enable clock input to synth (set bit to 0 to enable) */
> +       err =3D regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_CLK_DIS, mask, 0);
> +       if (err < 0)
> +               return err;
> +
> +       /* Enable output */
> +       return regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_CLK_TO_OUTX_EN, mask, mask);
> +}
> +
> +/* Synth clock frequency: Fvco * n_den / n_den, with Fvco in 13500-14256=
 MHz */
> +static unsigned long si5341_synth_clk_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       u64 f;
> +       u64 n_num;
> +       u32 n_den;
> +       int err;
> +
> +       err =3D si5341_decode_44_32(synth->data->regmap,
> +                       SI5341_SYNTH_N_NUM(synth->index), &n_num, &n_den);
> +       if (err < 0)
> +               return err;
> +
> +       /*
> +        * n_num and n_den are shifted left as much as possible, so to pr=
event
> +        * overflow in 64-bit math, we shift n_den 4 bits to the right
> +        */
> +       f =3D synth->data->freq_vco;
> +       f *=3D (n_den >> 4);

Do we need these parenthesis? Maybe n_den >>=3D 4 should preceded this
line.

> +
> +       /* Now we need to to 64-bit division: f/n_num */
> +       /* And compensate for the 4 bits we dropped */
> +       f =3D div64_u64(f, (n_num >> 4));
> +
> +       dev_dbg(&synth->data->i2c_client->dev,
> +                       "%s(%u) p=3D%lu n=3D0x%llx d=3D0x%x f=3D%llu\n",
> +                       __func__, synth->index, parent_rate, n_num, n_den=
, f);
> +
> +       return (unsigned long)f;

Drop useless cast please.

> +}
> +
> +static long si5341_synth_clk_round_rate(struct clk_hw *hw, unsigned long=
 rate,
> +               unsigned long *parent_rate)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       u64 f;
> +
> +       dev_dbg(&synth->data->i2c_client->dev, "%s(%u) r=3D%lu p=3D%lu\n",
> +                       __func__, synth->index, rate, *parent_rate);
> +
> +       /* The synthesizer accuracy is such that anything in range will w=
ork */
> +       f =3D synth->data->freq_vco;
> +       do_div(f, SI5341_SYNTH_N_MAX);
> +       if (rate < (unsigned long)f)

Why are we casting f to unsigned long?

> +               return (long)f;

Drop cast?

> +
> +       f =3D synth->data->freq_vco;
> +       do_div(f, SI5341_SYNTH_N_MIN);
> +       if (rate > (unsigned long)f)
> +               return (long)f;

Drop cast? Or make rate =3D f?

> +
> +       return (long)rate;

Drop cast?

> +}
> +
> +static int si5341_synth_program(struct clk_si5341_synth *synth,
> +       u64 n_num, u32 n_den, bool is_integer)
> +{
> +       int err;
> +       u8 index =3D synth->index;
> +
> +       err =3D si5341_encode_44_32(synth->data->regmap,
> +                       SI5341_SYNTH_N_NUM(index), n_num, n_den);
> +
> +       /* Set the bit that indicates if the fraction is integer */

Useless comment.

> +       err =3D regmap_update_bits(synth->data->regmap,
> +               SI5341_SYNTH_N_PIBYP, BIT(index), is_integer ? BIT(index)=
 : 0);
> +       if (err < 0)
> +               return err;
> +
> +       /* Write to the update bit to make the change take effect */

Useless comment?

> +       return regmap_write(synth->data->regmap,
> +               SI5341_SYNTH_N_UPD(index), 0x01);
> +}
> +
> +
> +static int si5341_synth_clk_set_rate(struct clk_hw *hw, unsigned long ra=
te,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si5341_synth *synth =3D to_clk_si5341_synth(hw);
> +       u64 n_num;
> +       u32 n_den;
> +       u32 r;
> +       u32 g;
> +       bool is_integer;
> +
> +       dev_dbg(&synth->data->i2c_client->dev, "%s(%u) r=3D%lu p=3D%lu\n",
> +                       __func__, synth->index, rate, parent_rate);
> +
> +       /* obvious solution */

What?

> +       n_num =3D synth->data->freq_vco;
> +       n_den =3D rate;
> +
> +       /* see if there's an integer solution */
> +       r =3D do_div(n_num, rate);
> +       is_integer =3D (r =3D=3D 0);
> +       if (is_integer) {
> +               /* Integer divider equal to n_num */
> +               n_den =3D 1;
> +       } else {
> +               /* Calculate a fractional solution */
> +               g =3D gcd(r, rate);
> +               n_den =3D rate / g;
> +               n_num *=3D n_den;
> +               n_num +=3D r / g;
> +       }
> +
> +       dev_dbg(&synth->data->i2c_client->dev,
> +                       "%s(%u): n=3D0x%llx d=3D0x%x %s\n", __func__,
> +                               synth->index, n_num, n_den,
> +                               is_integer ? "int" : "frac");
> +
> +       return si5341_synth_program(synth, n_num, n_den, is_integer);
> +}
> +
> +static const struct clk_ops si5341_synth_clk_ops =3D {
> +       .is_prepared =3D si5341_synth_clk_is_on,
> +       .prepare =3D si5341_synth_clk_prepare,
> +       .unprepare =3D si5341_synth_clk_unprepare,
> +       .recalc_rate =3D si5341_synth_clk_recalc_rate,
> +       .round_rate =3D si5341_synth_clk_round_rate,
> +       .set_rate =3D si5341_synth_clk_set_rate,
> +};
> +
> +static int si5341_output_clk_is_on(struct clk_hw *hw)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       int err;
> +       u32 val;
> +
> +       err =3D regmap_read(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output), &val);
> +       if (err < 0)
> +               return err;
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u): %#x\n",
> +                       __func__, output->index, val);
> +
> +       /* Bit 0=3DPDN, 1=3DOE so only a value of 0x2 enables the output =
*/
> +       return (val & 0x03) =3D=3D SI5341_OUT_CFG_OE;
> +}
> +
> +static void si5341_output_clk_unprepare(struct clk_hw *hw)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u)\n",
> +                       __func__, output->index);
> +
> +       /* Disable and then power down the output */
> +       regmap_update_bits(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output),
> +                       SI5341_OUT_CFG_OE, 0);
> +       regmap_update_bits(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output),
> +                       SI5341_OUT_CFG_PDN, SI5341_OUT_CFG_PDN);
> +}
> +
> +static int si5341_output_clk_prepare(struct clk_hw *hw)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       int err;
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u)\n",
> +                       __func__, output->index);

Can you just use the tracepoints in clk framework? These prints are
really cluttering the code up making it hard to see what's going on.

> +
> +       /* Power up first, then enable the output */

This comment could come above the function instead of inline.

> +       err =3D regmap_update_bits(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output),
> +                       SI5341_OUT_CFG_PDN, 0);
> +       if (err < 0)
> +               return err;
> +
> +       return regmap_update_bits(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output),
> +                       SI5341_OUT_CFG_OE, SI5341_OUT_CFG_OE);
> +}
> +
> +static unsigned long si5341_output_clk_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       int err;
> +       u32 val;
> +       u32 r_divider;
> +       u8 r[3];
> +
> +       err =3D regmap_read(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output), &val);
> +       if (err < 0)
> +               return err;
> +
> +       /* If bit(2) is set, the divider is forcibly set to "2" */

That's obvious from the code.

> +       if (val & SI5341_OUT_CFG_RDIV_FORCE2) {
> +               r_divider =3D 2;
> +       } else {
> +               err =3D regmap_bulk_read(output->data->regmap,
> +                               SI5341_OUT_R_REG(output), r, 3);
> +               if (err < 0)
> +                       return err;
> +
> +               /* Calculate value as 24-bit integer, (Rx_REG+1)x2 */
> +               r_divider =3D ((r[2] << 16 | r[1] << 8 | r[0]) + 1) << 1;
> +       }
> +
> +       dev_dbg(&output->data->i2c_client->dev,
> +                       "%s(%u): p=3D%lu rd=3D%u %lu\n",
> +                       __func__, output->index, parent_rate,
> +                       r_divider, parent_rate / r_divider);
> +
> +       return parent_rate / r_divider;
> +}
> +
> +static long si5341_output_clk_round_rate(struct clk_hw *hw, unsigned lon=
g rate,
> +               unsigned long *parent_rate)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       unsigned long r;
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u): %lu\n",
> +                       __func__, output->index, rate);
> +
> +       r =3D *parent_rate >> 1;
> +
> +       /* If rate is an even divisor, no changes to parent required */
> +       if (r && !(r % rate))
> +               return (long)rate;
> +
> +       if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
> +               if (rate > 200000000)
> +                       /* minimum r-divider is 2 */
> +                       r =3D 2;
> +               else
> +                       /* Take a parent frequency near 400 MHz */
> +                       r =3D (400000000u / rate) & ~1;

Style: Please enclose in braces if there's more than one line,
regardless of comment being one of those lines or not.

> +               *parent_rate =3D r * rate;
> +       } else {
> +               /* We cannot change our parent's rate, report what we can=
 do */
> +               r /=3D rate;
> +               rate =3D *parent_rate / (r << 1);
> +       }
> +
> +       return (long)rate;

Please drop useless cast.

> +}
> +
> +static int si5341_output_clk_set_rate(struct clk_hw *hw, unsigned long r=
ate,
> +               unsigned long parent_rate)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       /* Frequency divider is (r_div + 1) * 2 */
> +       u32 r_div =3D (parent_rate / rate) >> 1;
> +       int err;
> +       u8 r[3];
> +
> +       if (r_div <=3D 1)
> +               r_div =3D 0;
> +       else if (r_div >=3D BIT(24))
> +               r_div =3D BIT(24) - 1;
> +       else
> +               --r_div;
> +
> +       /* For a value of "2", we set the "OUT0_RDIV_FORCE2" bit */
> +       err =3D regmap_update_bits(output->data->regmap,
> +                       SI5341_OUT_CONFIG(output),
> +                       SI5341_OUT_CFG_RDIV_FORCE2,
> +                       (r_div =3D=3D 0) ? SI5341_OUT_CFG_RDIV_FORCE2 : 0=
);
> +       if (err < 0)
> +               return err;
> +
> +       /* Just always write the R_REG */
> +       r[0] =3D r_div & 0xff;
> +       r[1] =3D (r_div >> 8) & 0xff;
> +       r[2] =3D (r_div >> 16) & 0xff;
> +       err =3D regmap_bulk_write(output->data->regmap,
> +                       SI5341_OUT_R_REG(output), r, 3);
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u): r=3D%lu p=3D%lu =
rd=3D%u\n",
> +                       __func__, output->index, rate, parent_rate, r_div=
);
> +
> +       return 0;
> +}
> +
> +static int si5341_output_reparent(struct clk_si5341_output *output, u8 i=
ndex)
> +{
> +       return regmap_update_bits(output->data->regmap,
> +               SI5341_OUT_MUX_SEL(output), 0x07, index);
> +}
> +
> +static int si5341_output_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u): N%u\n",
> +                       __func__, output->index, index);
> +
> +       if (index >=3D output->data->num_synth)
> +               return -EINVAL;
> +
> +       return si5341_output_reparent(output, index);
> +}
> +
> +static u8 si5341_output_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_si5341_output *output =3D to_clk_si5341_output(hw);
> +       int err;
> +       u32 val;
> +
> +       err =3D regmap_read(output->data->regmap,
> +                       SI5341_OUT_MUX_SEL(output), &val);
> +
> +       dev_dbg(&output->data->i2c_client->dev, "%s(%u): N%u\n",
> +                       __func__, output->index, val & 0x7);
> +
> +       return val & 0x7;
> +}
> +
> +static const struct clk_ops si5341_output_clk_ops =3D {
> +       .is_prepared =3D si5341_output_clk_is_on,
> +       .prepare =3D si5341_output_clk_prepare,
> +       .unprepare =3D si5341_output_clk_unprepare,
> +       .recalc_rate =3D si5341_output_clk_recalc_rate,
> +       .round_rate =3D si5341_output_clk_round_rate,
> +       .set_rate =3D si5341_output_clk_set_rate,
> +       .set_parent =3D si5341_output_set_parent,
> +       .get_parent =3D si5341_output_get_parent,
> +};
> +
> +/* Called by probe, before output is actually registered */
> +static int si5341_output_set_parent_and_freq(
> +       struct clk_si5341_output *output, u8 index, u32 parent_rate)
> +{
> +       int err;
> +
> +       if (index < output->data->num_synth) {
> +               err =3D si5341_output_reparent(output, index);

Maybe this can be done via assigned-clock-parents?

> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       if (parent_rate) {
> +               index =3D si5341_output_get_parent(&output->hw);
> +               err =3D clk_set_rate(output->data->synth[index].hw.clk,

And assigned-clock-rates.

> +                               parent_rate);
> +       }
> +
> +       return err;
> +}
> +
> +/*
> + * The chip can be bought in a pre-programmed version, or one can progra=
m the
> + * NVM in the chip to boot up in a preset mode. This routine tries to de=
termine
> + * if that's the case, or if we need to reset and program everything from
> + * scratch. Returns negative error, or true/false.
> + */
> +static int si5341_is_programmed_already(struct clk_si5341 *data)
> +{
> +       int err;
> +       u32 v;
> +       u8 r[4];
> +       u8 i;
> +
> +       err =3D regmap_read(data->regmap, 0x00E2, &v);
> +       if (err < 0)
> +               return err;
> +
> +       /* Read the PLL divider value, it must have a non-zero value */
> +       err =3D regmap_bulk_read(data->regmap, SI5341_PLL_M_DEN, r, 4);
> +       if (err < 0)
> +               return err;
> +
> +       dev_dbg(&data->i2c_client->dev, "%s: %#x md=3D%#x\n",
> +                       __func__, v,
> +                       r[3] << 24 | r[2] << 16 | r[1] << 8 | r[0]);

There isn't a macro for this byte to word? get_unaligned_le32()?

> +
> +       for (i =3D 0; i < 4; ++i)
> +               if (r[i])
> +                       return true;

This for loop could just be 'convert r into u32; print it; test it for 0'.

> +
> +       return false;
> +}
> +
> +static struct clk_hw *of_clk_si5341_get(
> +       struct of_phandle_args *clkspec, void *_data)

Please fix this style:

static struct clk_hw *
of_clk_si5341_get(struct of_phandle_args *clkspec, void *_data)

> +{
> +       struct clk_si5341 *data =3D _data;
> +       unsigned int idx =3D clkspec->args[0];
> +
> +       if (idx >=3D data->num_outputs) {
> +               dev_err(&data->i2c_client->dev, "invalid index %u\n", idx=
);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return &data->clk[idx].hw;
> +}
> +
> +static int si5341_probe_chip_id(struct clk_si5341 *data)
> +{
> +       int err;
> +       u8 reg[4];
> +
> +       err =3D regmap_bulk_read(data->regmap, SI5341_PN_BASE, reg, 4);

ARRAY_SIZE(reg) instead of 4?

> +       if (err < 0) {
> +               dev_err(&data->i2c_client->dev, "Failed to read chip ID\n=
");
> +               return err;
> +       }
> +
> +       dev_info(&data->i2c_client->dev, "Chip: %x Grade: %u Rev: %u\n",
> +                (reg[1] << 8) | reg[0], reg[2], reg[3]);
> +
> +       /* The 5341 has 10 outputs, the 5340 has only 4 */

Alright! Thanks for the info!

> +       switch (reg[0]) {
> +       case 0x40:
> +               data->num_outputs =3D SI5340_MAX_NUM_OUTPUTS;
> +               data->num_synth =3D SI5340_NUM_SYNTH;
> +               data->reg_output_offset =3D si5340_reg_output_offset;
> +               data->reg_rdiv_offset =3D si5340_reg_rdiv_offset;
> +               break;
> +       case 0x41:
> +               data->num_outputs =3D SI5341_MAX_NUM_OUTPUTS;
> +               data->num_synth =3D SI5341_NUM_SYNTH;
> +               data->reg_output_offset =3D si5341_reg_output_offset;
> +               data->reg_rdiv_offset =3D si5341_reg_rdiv_offset;
> +               break;
> +       default:
> +               dev_err(&data->i2c_client->dev, "Model '%x' not supported=
\n",
> +                       (reg[1] << 8) | reg[0]);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +/* Read active settings into the regmap cache for later reference */
> +static int si5341_read_settings(struct clk_si5341 *data)
> +{
> +       int err;
> +       u8 i;
> +       u8 r[10];
> +
> +       err =3D regmap_bulk_read(data->regmap, SI5341_PLL_M_NUM, r, 10);
> +       if (err < 0)
> +               return err;
> +
> +       err =3D regmap_bulk_read(data->regmap,
> +                               SI5341_SYNTH_N_CLK_TO_OUTX_EN, r, 3);
> +       if (err < 0)
> +               return err;
> +
> +       err =3D regmap_bulk_read(data->regmap,
> +                               SI5341_SYNTH_N_CLK_DIS, r, 1);
> +       if (err < 0)
> +               return err;
> +
> +       for (i =3D 0; i < data->num_synth; ++i) {
> +               err =3D regmap_bulk_read(data->regmap,
> +                                       SI5341_SYNTH_N_NUM(i), r, 10);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       for (i =3D 0; i < data->num_outputs; ++i) {
> +               err =3D regmap_bulk_read(data->regmap,
> +                                       data->reg_output_offset[i], r, 4);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D regmap_bulk_read(data->regmap,
> +                                       data->reg_rdiv_offset[i], r, 3);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int si5341_write_multiple(struct clk_si5341 *data,
> +       const struct si5341_reg_default *values, unsigned int num_values)
> +{
> +       unsigned int i;
> +       int res;
> +
> +       for (i =3D 0; i < num_values; ++i) {
> +               res =3D regmap_write(data->regmap,
> +                       values[i].address, values[i].value);
> +               if (res < 0) {
> +                       dev_err(&data->i2c_client->dev,
> +                               "Failed to write %#x:%#x\n",
> +                               values[i].address, values[i].value);
> +                       return res;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +const struct si5341_reg_default si5341_preamble[] =3D {
> +       {0x0B25, 0x00},

Please put space around { and }

	  { 0x0b25, 0x00 },

> +       {0x0502, 0x01},
> +       {0x0505, 0x03},
> +       {0x0957, 0x1F},
> +       {0x0B4E, 0x1A},
> +};
> +
> +static int si5341_send_preamble(struct clk_si5341 *data)
> +{
> +       int res;
> +       u32 revision;
> +
> +       /* For revision 2 and up, the values are slightly different */
> +       res =3D regmap_read(data->regmap, SI5341_DEVICE_REV, &revision);
> +       if (res < 0)
> +               return res;
> +
> +       /* Write "preamble" as specified by datasheet */
> +       res =3D regmap_write(data->regmap, 0xB24, revision < 2 ? 0xD8 : 0=
xC0);
> +       if (res < 0)
> +               return res;
> +       res =3D si5341_write_multiple(data,
> +               si5341_preamble, ARRAY_SIZE(si5341_preamble));
> +       if (res < 0)
> +               return res;
> +
> +       /* Wait for 300 ms */

Yeah that's obvious. Does the datasheet say to do that? That would be
more useful to indicate here instead of repeating what the code does.

> +       msleep(300);
> +
> +       return 0;
> +}
> +
> +/* Perform a soft reset and write post-amble */
> +static int si5341_finalize_defaults(struct clk_si5341 *data)
> +{
> +       int res;
> +       u32 revision;
> +
> +       res =3D regmap_read(data->regmap, SI5341_DEVICE_REV, &revision);
> +       if (res < 0)
> +               return res;
> +
> +       dev_dbg(&data->i2c_client->dev, "%s rev=3D%u\n", __func__, revisi=
on);
> +
> +       /* Perform a soft reset */

Obvious.

> +       res =3D regmap_write(data->regmap, SI5341_SOFT_RST, 0x01);
> +       if (res < 0)
> +               return res;
> +
> +       /* Write post-amble */
> +       res =3D regmap_write(data->regmap, 0xB24, revision < 2 ? 0xDB : 0=
xC3);

Why no define for SI5341_POST_AMBLE?

> +       if (res < 0)
> +               return res;
> +       res =3D regmap_write(data->regmap, 0x0B25, 0x02);

And what register is this?

> +       if (res < 0)
> +               return res;
> +
> +       return 0;
> +}
> +
> +
> +static const struct regmap_range si5341_regmap_volatile_range[] =3D {
> +       regmap_reg_range(0x000C, 0x0012), /* Status */
> +       regmap_reg_range(0x001C, 0x001E), /* reset, finc/fdec */
> +       regmap_reg_range(0x00E2, 0x00FE), /* NVM, interrupts, device read=
y */
> +       /* Update bits for synth config */
> +       regmap_reg_range(SI5341_SYNTH_N_UPD(0), SI5341_SYNTH_N_UPD(0)),
> +       regmap_reg_range(SI5341_SYNTH_N_UPD(1), SI5341_SYNTH_N_UPD(1)),
> +       regmap_reg_range(SI5341_SYNTH_N_UPD(2), SI5341_SYNTH_N_UPD(2)),
> +       regmap_reg_range(SI5341_SYNTH_N_UPD(3), SI5341_SYNTH_N_UPD(3)),
> +       regmap_reg_range(SI5341_SYNTH_N_UPD(4), SI5341_SYNTH_N_UPD(4)),
> +};
> +
> +const struct regmap_access_table si5341_regmap_volatile =3D {
> +       .yes_ranges =3D si5341_regmap_volatile_range,
> +       .n_yes_ranges =3D ARRAY_SIZE(si5341_regmap_volatile_range),
> +};
> +
> +/* Pages 0, 1, 2, 3, 9, A, B are valid, so there are 12 pages */
> +static const struct regmap_range_cfg si5341_regmap_ranges[] =3D {
> +       {
> +               .range_min =3D 0,
> +               .range_max =3D 12 * 256,
> +               .selector_reg =3D SI5341_PAGE,
> +               .selector_mask =3D 0xff,
> +               .selector_shift =3D 0,
> +               .window_start =3D 0,
> +               .window_len =3D 256,
> +       },
> +};
> +
> +static const struct regmap_config si5341_regmap_config =3D {
> +       .reg_bits =3D 8,
> +       .val_bits =3D 8,
> +       .cache_type =3D REGCACHE_RBTREE,
> +       .max_register =3D 0,
> +       .ranges =3D si5341_regmap_ranges,
> +       .num_ranges =3D ARRAY_SIZE(si5341_regmap_ranges),
> +       .max_register =3D 12 * 256,

Maybe 12 * 256 should be a define.

> +       .volatile_table =3D &si5341_regmap_volatile,
> +};
> +
> +static int si5341_dt_parse_dt(struct i2c_client *client,
> +       struct clk_si5341_output_config *config)
> +{
> +       struct device_node *child;
> +       struct device_node *np =3D client->dev.of_node;
> +       u32 num;
> +       u32 val;
> +
> +       memset(config, 0, sizeof(struct clk_si5341_output_config) *
> +                               SI5341_MAX_NUM_OUTPUTS);
> +       /* Set defaults to no forced source, not a master */
> +       for (num =3D 0; num < SI5341_MAX_NUM_OUTPUTS; ++num)
> +               config[num].source_index =3D 0xff;
> +
> +       for_each_child_of_node(np, child) {
> +               if (of_property_read_u32(child, "reg", &num)) {
> +                       dev_err(&client->dev, "missing reg property of %s=
\n",
> +                               child->name);
> +                       goto put_child;
> +               }
> +
> +               if (num >=3D SI5341_MAX_NUM_OUTPUTS) {
> +                       dev_err(&client->dev, "invalid clkout %d\n", num);
> +                       goto put_child;
> +               }
> +
> +               if (!of_property_read_u32(child, "silabs,format", &val)) {
> +                       /* Set cm and ampl conservatively to 3v3 settings=
 */
> +                       switch (val) {
> +                       case 1: /* normal differential */
> +                               config[num].out_cm_ampl_bits =3D 0x33;
> +                               break;
> +                       case 2: /* low-power differential */
> +                               config[num].out_cm_ampl_bits =3D 0x13;
> +                               break;
> +                       case 4: /* LVCMOS */
> +                               config[num].out_cm_ampl_bits =3D 0x33;
> +                               /* Set SI recommended impedance for LVCMO=
S */
> +                               config[num].out_format_drv_bits |=3D 0xc0;
> +                               break;
> +                       default:
> +                               dev_err(&client->dev,
> +                                       "invalid silabs,format %u for %u\=
n",
> +                                       val, num);
> +                               goto put_child;
> +                       }
> +                       config[num].out_format_drv_bits &=3D ~0x07;
> +                       config[num].out_format_drv_bits |=3D val & 0x07;
> +                       /* Always enable the SYNC feature */
> +                       config[num].out_format_drv_bits |=3D 0x08;
> +               }
> +
> +               if (!of_property_read_u32(child, "silabs,common-mode", &v=
al)) {
> +                       if (val > 0xf) {
> +                               dev_err(&client->dev,
> +                                       "invalid silabs,common-mode %u\n",
> +                                       val);
> +                               goto put_child;
> +                       }
> +                       config[num].out_cm_ampl_bits &=3D 0xf0;
> +                       config[num].out_cm_ampl_bits |=3D val & 0x0f;
> +               }
> +
> +               if (!of_property_read_u32(child, "silabs,amplitude", &val=
)) {
> +                       if (val > 0xf) {
> +                               dev_err(&client->dev,
> +                                       "invalid silabs,amplitude %u\n",
> +                                       val);
> +                               goto put_child;
> +                       }
> +                       config[num].out_cm_ampl_bits &=3D 0x0f;
> +                       config[num].out_cm_ampl_bits |=3D (val << 4) & 0x=
f0;
> +               }
> +
> +               if (!of_property_read_u32(child, "silabs,synth-source",
> +                                         &val)) {
> +                       /* Chip type not known at this point, assume larg=
est */
> +                       if (val >=3D SI5341_NUM_SYNTH) {
> +                               dev_err(&client->dev,
> +                                       "invalid synth-source %u for %u\n=
",
> +                                       val, num);
> +                               goto put_child;
> +                       }
> +
> +                       config[num].source_index =3D val;
> +               }
> +
> +               if (!of_property_read_u32(child, "silabs,synth-frequency",
> +                                         &val)) {
> +                       if (config[num].source_index >=3D SI5341_NUM_SYNT=
H) {
> +                               dev_err(&client->dev,
> +                                       "synth-frequency requires synth-s=
ource "
> +                                       "for %u\n", num);
> +                               goto put_child;
> +                       }
> +
> +                       config[num].synth_frequency =3D val;
> +               }
> +
> +               if (!of_property_read_u32(child, "clock-frequency", &val))
> +                       config[num].clock_frequency =3D val;
> +
> +               if (of_property_read_bool(child, "silabs,disable-high"))
> +                       config[num].out_format_drv_bits |=3D 0x10;
> +
> +               config[num].synth_master =3D
> +                       of_property_read_bool(child, "silabs,synth-master=
");
> +
> +               config[num].always_on =3D
> +                       of_property_read_bool(child, "always-on");
> +       }
> +
> +       return 0;
> +
> +put_child:
> +       of_node_put(child);
> +       return -EINVAL;
> +}
> +
> +/*
> + * If not pre-configured, calculate and set the PLL configuration manual=
ly.
> + * For low-jitter performance, the PLL should be set such that the synth=
esizers
> + * only need integer division.
> + * Without any user guidance, we'll set the PLL to 14GHz, which still al=
lows
> + * the chip to generate any frequency on its outputs, but jitter perform=
ance
> + * may be sub-optimal.
> + */
> +static int si5341_initialize_pll(struct clk_si5341 *data)
> +{
> +       struct device_node *np =3D data->i2c_client->dev.of_node;
> +       u32 m_num =3D 0;
> +       u32 m_den =3D 0;
> +
> +       if (of_property_read_u32(np, "silabs,pll-m-num", &m_num)) {
> +               dev_err(&data->i2c_client->dev,
> +                       "PLL configuration requires silabs,pll-m-num\n");
> +       }
> +       if (of_property_read_u32(np, "silabs,pll-m-den", &m_den)) {
> +               dev_err(&data->i2c_client->dev,
> +                       "PLL configuration requires silabs,pll-m-den\n");
> +       }
> +
> +       if (!m_num || !m_den) {
> +               dev_err(&data->i2c_client->dev,
> +                       "PLL configuration invalid, assume 14GHz\n");
> +               m_den =3D clk_get_rate(data->pxtal) / 10;
> +               m_num =3D 1400000000;
> +       }
> +
> +       return si5341_encode_44_32(data->regmap,
> +                       SI5341_PLL_M_NUM, m_num, m_den);
> +}
> +
> +static int si5341_probe(struct i2c_client *client,
> +               const struct i2c_device_id *id)
> +{
> +       struct clk_si5341 *data;
> +       struct clk_init_data init;
> +       const char *root_clock_name;
> +       const char *synth_clock_names[SI5341_NUM_SYNTH];
> +       int err;
> +       struct clk_si5341_output_config config[SI5341_MAX_NUM_OUTPUTS];
> +       u8 i;

Why not just an int or unsigned int? Why a u8?

> +       bool initialization_required;
> +
> +       data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->i2c_client =3D client;
> +
> +       data->pxtal =3D devm_clk_get(&client->dev, "xtal");
> +       if (IS_ERR(data->pxtal)) {
> +               if (PTR_ERR(data->pxtal) =3D=3D -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
> +               dev_err(&client->dev, "Missing xtal clock input\n");
> +       }
> +
> +       err =3D si5341_dt_parse_dt(client, config);
> +       if (err)
> +               return err;
> +
> +       if (of_property_read_string(client->dev.of_node, "clock-output-na=
mes",
> +                       &init.name))
> +               init.name =3D client->dev.of_node->name;
> +       root_clock_name =3D init.name;
> +
> +       data->regmap =3D devm_regmap_init_i2c(client, &si5341_regmap_conf=
ig);
> +       if (IS_ERR(data->regmap))
> +               return PTR_ERR(data->regmap);
> +
> +       i2c_set_clientdata(client, data);
> +
> +       err =3D si5341_probe_chip_id(data);
> +       if (err < 0)
> +               return err;
> +
> +       /* "Activate" the xtal (usually a fixed clock) */
> +       clk_prepare_enable(data->pxtal);
> +
> +       if (of_property_read_bool(client->dev.of_node, "silabs,reprogram"=
)) {
> +               initialization_required =3D true;
> +       } else {
> +               err =3D si5341_is_programmed_already(data);
> +               if (err < 0)
> +                       return err;
> +
> +               initialization_required =3D !err;
> +       }
> +
> +       if (initialization_required) {
> +               /* Populate the regmap cache in preparation for "cache on=
ly" */
> +               err =3D si5341_read_settings(data);
> +               if (err < 0)
> +                       return err;
> +
> +               err =3D si5341_send_preamble(data);
> +               if (err < 0)
> +                       return err;
> +
> +               /*
> +                * We intend to send all 'final' register values in a sin=
gle
> +                * transaction. So cache all register writes until we're =
done
> +                * configuring.
> +                */
> +               regcache_cache_only(data->regmap, true);
> +
> +               /* Write the configuration pairs from the firmware blob */
> +               err =3D si5341_write_multiple(data, si5341_reg_defaults,
> +                                       ARRAY_SIZE(si5341_reg_defaults));
> +               if (err < 0)
> +                       return err;
> +
> +               /* PLL configuration is required */
> +               err =3D si5341_initialize_pll(data);
> +               if (err < 0)
> +                       return err;
> +       }
> +
> +       /* Register the PLL */
> +       data->pxtal_name =3D __clk_get_name(data->pxtal);
> +       init.parent_names =3D &data->pxtal_name;
> +       init.num_parents =3D 1; /* For now, only XTAL input supported */
> +       init.ops =3D &si5341_clk_ops;
> +       init.flags =3D 0;
> +       data->hw.init =3D &init;
> +
> +       err =3D devm_clk_hw_register(&client->dev, &data->hw);
> +       if (err) {
> +               dev_err(&client->dev, "clock registration failed\n");
> +               return err;
> +       }
> +
> +       init.num_parents =3D 1;
> +       init.parent_names =3D &root_clock_name;
> +       init.ops =3D &si5341_synth_clk_ops;
> +       for (i =3D 0; i < data->num_synth; ++i) {
> +               synth_clock_names[i] =3D kasprintf(GFP_KERNEL, "%s.N%u",

Use devm_kasprintf() and let error paths cleanup?

> +                       client->dev.of_node->name, i);
> +               init.name =3D synth_clock_names[i];
> +               data->synth[i].index =3D i;
> +               data->synth[i].data =3D data;
> +               data->synth[i].hw.init =3D &init;
> +               dev_dbg(&client->dev, "Register %s\n", init.name);

Is this necessary? Maybe we should add a pr_debug() deep in
clk_register() if you really want to know. I don't think I'd be too
opposed to that.

> +               err =3D devm_clk_hw_register(&client->dev, &data->synth[i=
].hw);
> +               if (err) {
> +                       dev_err(&client->dev,
> +                               "synth N%u registration failed\n", i);
> +               }
> +       }
> +
> +       init.num_parents =3D data->num_synth;
> +       init.parent_names =3D synth_clock_names;
> +       init.ops =3D &si5341_output_clk_ops;
> +       init.flags =3D 0;
> +       for (i =3D 0; i < data->num_outputs; ++i) {
> +               init.name =3D kasprintf(GFP_KERNEL, "%s.%d",
> +                       client->dev.of_node->name, i);
> +               init.flags =3D config[i].synth_master ? CLK_SET_RATE_PARE=
NT : 0;

Ok, so synth_master means that it can change the rate of the parent?

> +               data->clk[i].index =3D i;
> +               data->clk[i].data =3D data;
> +               data->clk[i].hw.init =3D &init;
> +               if (config[i].out_format_drv_bits & 0x07) {

What is magic 0x07? Please make a define for it.

> +                       dev_dbg(&client->dev,
> +                               "out %u: fmt=3D%#x cm=3D%#x\n", i,
> +                               config[i].out_format_drv_bits,
> +                               config[i].out_cm_ampl_bits);

Can't we get this with regmap tracepoints?

> +                       regmap_write(data->regmap,
> +                               SI5341_OUT_FORMAT(&data->clk[i]),
> +                               config[i].out_format_drv_bits);
> +                       regmap_write(data->regmap,
> +                               SI5341_OUT_CM(&data->clk[i]),
> +                               config[i].out_cm_ampl_bits);
> +               }
> +               si5341_output_set_parent_and_freq(&data->clk[i],
> +                       config[i].source_index,
> +                       config[i].synth_frequency);
> +               dev_dbg(&client->dev, "Register %s\n", init.name);

Ah this again!

> +               err =3D devm_clk_hw_register(&client->dev, &data->clk[i].=
hw);
> +               kfree(init.name); /* clock framework made a copy of the n=
ame */
> +               if (err) {
> +                       dev_err(&client->dev,
> +                               "output %u registration failed\n", i);
> +                       goto error;
> +               }
> +               if (config[i].clock_frequency)
> +                       clk_set_rate(data->clk[i].hw.clk,
> +                               config[i].clock_frequency);
> +               if (config[i].always_on)
> +                       clk_prepare(data->clk[i].hw.clk);
> +       }
> +
> +       err =3D of_clk_add_hw_provider(client->dev.of_node, of_clk_si5341=
_get,

Can you use devm_of_clk_add_hw_provider()?

> +                       data);
> +       if (err) {
> +               dev_err(&client->dev, "unable to add clk provider\n");
> +               goto error;
> +       }
> +
> +       if (initialization_required) {
> +               /* Synchronize */

Useless comment. Please remove.

> +               regcache_cache_only(data->regmap, false);
> +               err =3D regcache_sync(data->regmap);
> +               if (err < 0)
> +                       goto error;
> +
> +               err =3D si5341_finalize_defaults(data);
> +               if (err < 0)
> +                       goto error;
> +       }
> +
> +error:
> +       /* Free the names, clk framework makes copies */
> +       for (i =3D 0; i < data->num_synth; ++i)
> +               kfree(synth_clock_names[i]);
> +
> +       return err;
> +}
> +
