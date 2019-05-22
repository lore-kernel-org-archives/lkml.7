Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B13C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD7F20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO6ABETQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfEVNCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:02:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54551 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:02:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so2142796wml.4;
        Wed, 22 May 2019 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H7LYxxMt89xiZ1cz7piW3pFDtBm3us8ApduF1nWTJGY=;
        b=KO6ABETQ5u9WE/eUn+znoyrVEYdkSZYEd6ZVmXaEKXVZAQkqeCSGbAUAplFrkk5BI+
         vO9y0ty4X6Qo8OwZT5mPyMsnHkcTUbKzJsNfhLRnUiN/jBM1Qh8tWwkj7aCLxxG4w4eq
         CZhEra22i96IciYfxHPv2KKCn4VtzcbVAutXNjUZlCqh5nY7mu2tOev6O75S6vJlC6ri
         bofZ/FbLjOvArwQ27UqKRshKqkVPowgEQ+WFcQbwe+ItX6fEVVgrDUC/uJtvINVWmyiC
         7HaGaXYYFvj23fzVvCAzYSfb/DQX2CrGh4GNB1JZIFGbJj6yQBCTlc5vie+L307JMKo/
         H+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H7LYxxMt89xiZ1cz7piW3pFDtBm3us8ApduF1nWTJGY=;
        b=l/xMjUuxL49lDfcf1TeuNK5H9JsNXWyCZv8u8OZvRfb/QD+IvBnf1JCB4xMir4pYYs
         VfQJ5kQyDHZums+4feq4PNs2XnZH2z0/rRMHZci1mXlPgvjg368U824y/zgf6WjnL0VC
         wM2hEuUx8Zwt/Q+hNEXmO4QjJsk7iveED+qJH49HqhCw9omUqJaxRtahFNRiTgFWPw0b
         KB53pV5NecGBP87mElWDfFs/cRXIMO+oxcNidsnIbFA4KbZeVf3jIkHDP5rdtSQdDUKz
         L7gxATAVxfuQIF8RdtCxS9sw0gO6t2ppd8DzWmwwj2ve+JF7LYGBq5vRX/e81crsrNPZ
         2UiQ==
X-Gm-Message-State: APjAAAUVFeqqaYuhbbFkl51U/tyWXOyL4dZQFxcFBoht8tQhlIWgCiGx
        ni80wvR6+9ZfpU95uqYEJlg=
X-Google-Smtp-Source: APXvYqz53R1LRWIT0/YM2XfiM85Z0S/Ux+oSIqbvy5Mt+yw4EohsNm/ONe+vIjqjqkmWDImc3mxRPw==
X-Received: by 2002:a1c:680a:: with SMTP id d10mr7624530wmc.145.1558530117737;
        Wed, 22 May 2019 06:01:57 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t6sm12000541wmt.34.2019.05.22.06.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:01:56 -0700 (PDT)
Date:   Wed, 22 May 2019 15:01:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 09/12] soc/tegra: pmc: add pmc wake support for
 tegra210
Message-ID: <20190522130155.GJ30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-10-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-10-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:20PM -0700, Sowjanya Komatineni wrote:
> This patch implements PMC wakeup sequence for Tegra210 and defines
> common used wake events of RTC alarm and power key.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 120 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 120 insertions(+)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index f77ce4b827e3..5e68e1de1780 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -57,6 +57,7 @@
>  #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>  #include <dt-bindings/gpio/tegra186-gpio.h>
>  #include <dt-bindings/gpio/tegra194-gpio.h>
> +#include <dt-bindings/gpio/tegra-gpio.h>
> =20
>  #define PMC_CNTRL			0x0
>  #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
> @@ -66,6 +67,12 @@
>  #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
>  #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
>  #define  PMC_CNTRL_MAIN_RST		BIT(4)
> +#define  PMC_CNTRL_LATCH_WAKEUPS	BIT(5)
> +
> +#define PMC_WAKE_MASK			0x0c
> +#define PMC_WAKE_LEVEL			0x10
> +#define PMC_WAKE_STATUS			0x14
> +#define PMC_SW_WAKE_STATUS		0x18
> =20
>  #define DPD_SAMPLE			0x020
>  #define  DPD_SAMPLE_ENABLE		BIT(0)
> @@ -96,6 +103,11 @@
> =20
>  #define PMC_SCRATCH41			0x140
> =20
> +#define PMC_WAKE2_MASK			0x160
> +#define PMC_WAKE2_LEVEL			0x164
> +#define PMC_WAKE2_STATUS		0x168
> +#define PMC_SW_WAKE2_STATUS		0x16c
> +
>  #define PMC_SENSOR_CTRL			0x1b0
>  #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
>  #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
> @@ -1917,6 +1929,65 @@ static const struct irq_domain_ops tegra_pmc_irq_d=
omain_ops =3D {
>  	.alloc =3D tegra_pmc_irq_alloc,
>  };
> =20
> +static inline void clear_pmc_sw_wake_status(void)
> +{
> +	tegra_pmc_writel(pmc, 0, PMC_SW_WAKE_STATUS);
> +	if (tegra_get_chip_id() !=3D TEGRA20)

Please don't use tegra_get_chip_id(). We already have pmc->soc, so it
should be easy enough to add a flag to identify Tegra generations that
have this register. Another alternative would be to fill in all the wake
events that the generation supports and then iterate over that to find
out what the maximum wake event ID is and use that to determine which
registers are valid. I'm assuming Tegra20 supports less than 32 wake
events, hence why it doesn't need PMC_SW_WAKE_STATUS.

> +		tegra_pmc_writel(pmc, 0, PMC_SW_WAKE2_STATUS);
> +}
> +
> +static inline void clear_pmc_wake_status(void)
> +{
> +	u32 reg;

u32 value for consistency with the rest of the driver.

> +
> +	reg =3D tegra_pmc_readl(pmc, PMC_WAKE_STATUS);
> +	if (reg)
> +		tegra_pmc_writel(pmc, reg, PMC_WAKE_STATUS);

Is there any harm in writing 0 to these registers? Not that it matters
much, but the code here looks a little odd.

> +	if (tegra_get_chip_id() !=3D TEGRA20) {
> +		reg =3D tegra_pmc_readl(pmc, PMC_WAKE2_STATUS);
> +		if (reg)
> +			tegra_pmc_writel(pmc, reg, PMC_WAKE2_STATUS);
> +	}
> +}
> +
> +static int tegra210_pmc_irq_set_wake(struct irq_data *data, unsigned int=
 on)
> +{
> +	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
> +	unsigned int offset, bit;
> +	u32 pmc_wake_mask_reg;
> +	u32 value;
> +
> +	if (data->hwirq < 0)
> +		return 0;

Again, is this really necessary?

> +
> +	offset =3D data->hwirq / 32;
> +	bit =3D data->hwirq % 32;
> +
> +	clear_pmc_sw_wake_status();
> +
> +	/* enable PMC wake */
> +	value =3D tegra_pmc_readl(pmc, PMC_CNTRL);
> +	value |=3D PMC_CNTRL_LATCH_WAKEUPS;
> +	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> +	usleep_range(110, 120);
> +
> +	value &=3D ~PMC_CNTRL_LATCH_WAKEUPS;
> +	tegra_pmc_writel(pmc, value, PMC_CNTRL);
> +	usleep_range(110, 120);
> +
> +	clear_pmc_wake_status();

Could you add a couple more comments describing what this does. Maybe
also inline the clear_pmc_{sw_,}wake_status() functions into this since
they are only used here.

> +
> +	pmc_wake_mask_reg =3D (offset) ? PMC_WAKE2_MASK : PMC_WAKE_MASK;

I think it'd be clearer to write this as:

	if (data->hwirq > 32)
		offset =3D PMC_WAKE2_MASK;
	else
		offset =3D PMC_WAKE_MASK;

> +	value =3D tegra_pmc_readl(pmc, pmc_wake_mask_reg);
> +	if (on)
> +		value |=3D 1 << bit;
> +	else
> +		value &=3D ~(1 << bit);
> +	tegra_pmc_writel(pmc, value, pmc_wake_mask_reg);
> +
> +	return 0;
> +}
> +
>  static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int=
 on)
>  {
>  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
> @@ -1948,6 +2019,46 @@ static int tegra186_pmc_irq_set_wake(struct irq_da=
ta *data, unsigned int on)
>  	return 0;
>  }
> =20
> +static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int=
 type)
> +{
> +	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
> +	unsigned int offset, bit;
> +	u32 pmc_wake_lvl_reg;
> +	u32 value;
> +
> +	if (data->hwirq < 0)
> +		return 0;
> +
> +	offset =3D data->hwirq / 32;
> +	bit =3D data->hwirq % 32;
> +
> +	pmc_wake_lvl_reg =3D (offset) ? PMC_WAKE2_LEVEL : PMC_WAKE_LEVEL;

Same comment as for the PMC_WAKE*_MASK registers.

Thierry

> +	value =3D tegra_pmc_readl(pmc, pmc_wake_lvl_reg);
> +
> +	switch (type) {
> +	case IRQ_TYPE_EDGE_RISING:
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		value |=3D 1 << bit;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +	case IRQ_TYPE_LEVEL_LOW:
> +		value &=3D ~(1 << bit);
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
> +		value ^=3D 1 << bit;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tegra_pmc_writel(pmc, value, pmc_wake_lvl_reg);
> +
> +	return 0;
> +}
> +
>  static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int=
 type)
>  {
>  	struct tegra_pmc *pmc =3D irq_data_get_irq_chip_data(data);
> @@ -2535,6 +2646,11 @@ static const struct pinctrl_pin_desc tegra210_pin_=
descs[] =3D {
>  	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
>  };
> =20
> +static const struct tegra_wake_event tegra210_wake_events[] =3D {
> +	TEGRA_WAKE_GPIO("power", 24, 0, 189), /*TEGRA_GPIO(X, 5)*/
> +	TEGRA_WAKE_IRQ("rtc", 16, 2),
> +};
> +
>  static const struct tegra_pmc_soc tegra210_pmc_soc =3D {
>  	.num_powergates =3D ARRAY_SIZE(tegra210_powergates),
>  	.powergates =3D tegra210_powergates,
> @@ -2552,10 +2668,14 @@ static const struct tegra_pmc_soc tegra210_pmc_so=
c =3D {
>  	.regs =3D &tegra20_pmc_regs,
>  	.init =3D tegra20_pmc_init,
>  	.setup_irq_polarity =3D tegra20_pmc_setup_irq_polarity,
> +	.pmc_irq_set_wake =3D tegra210_pmc_irq_set_wake,
> +	.pmc_irq_set_type =3D tegra210_pmc_irq_set_type,
>  	.reset_sources =3D tegra210_reset_sources,
>  	.num_reset_sources =3D ARRAY_SIZE(tegra210_reset_sources),
>  	.reset_levels =3D NULL,
>  	.num_reset_levels =3D 0,
> +	.num_wake_events =3D ARRAY_SIZE(tegra210_wake_events),
> +	.wake_events =3D tegra210_wake_events,
>  };
> =20
>  #define TEGRA186_IO_PAD_TABLE(_pad)					     \
> --=20
> 2.7.4
>=20

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlSEEACgkQ3SOs138+
s6Hm4w/+NvbhQ40c0le7ni46eF1U5JHPFcmtR+4iq9mbVXEfqqzuBUJDUyUj11n0
973o8ur4c2WOi77FG2qZk/32iqST9qVaTseJvspqKPf9k1Z+C2+C/ffaTwFNdqQp
ofx5xWOOpcm6sH9SmmhcJDLnWVTRozD7t1oJzgOD7tkNAOKdOhnCqmkqI3Rnzz1D
0gKLDiE7XFbYLoDNEXmo10aprwpZMFQ5mH/Gp7eLJWg6LMWnF+ouZ/GjeApkRYDY
58pDBqpbBgqcihR3X7LjgA/dxvCXeDtDsD4qUvEENGY0401MqHgIRBkFzcyNoopO
4Glfb8M2hXyECXGazRAC3N/EqPBTiCWxWFK7sh/1I9ma+FsmUafNxA7SFz5TGUtM
At1PKQ+F852gO+X9eqldrXaGzfMJLP3Lj2Qtim77UuftUeU6yIThBsQFNI0N6T3I
MstXyEAweBE1PGvMr+pCoWPFRzFkkDQjjVmE4cPe9dbL/LcBXsXYS6ed5Z848I9E
Bh4bS95N59Se2BtsO9GRctPwBjDqlrui/bO01dsBGLKeFDdhxD2A1YC6T1YnEr02
0Lm6F3QH10inw6NVxQBKEhzzkdOXdD6hzyRCA0jQ7Ac7svo0CjkdzVI5HzIFgjwL
dvxA3kM+H5IhTSjEr9I1o0nvDcgwJgd+wt3qxh+PQ/Th976zaos=
=pLh5
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--
